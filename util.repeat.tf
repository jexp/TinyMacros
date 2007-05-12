; $Log: util.repeat.tf,v $
; Revision 1.9  2002/09/10 14:45:23  thufhnik
; vereinfachtes repeat_once
;
; Revision 1.8  2002/09/10 13:04:13  thufhnik
; repeat_once hinzugefuegt
;
; Revision 1.7  2001/09/09 22:21:39  mh14
; Bug in Doku
;
; Revision 1.6  2001/09/09 19:16:59  mh14
; requires bereinigt
;
; Revision 1.5  2001/09/09 19:09:42  mh14
; help_de.list
;
; Revision 1.4  2001/09/06 21:11:44  mh14
;  Log eingefuegt
;

/set util_repeat_tf_version $Id: util.repeat.tf,v 1.9 2002/09/10 14:45:23 thufhnik Exp $
/set util_repeat_tf_author=Mesirii@mg.mud.de
/set util_repeat_tf_requires util.hooks.tf
/set util_repeat_tf_desc Countdown,Heartbeats,Kommando-Counter

/addh info \
Zaehlt die uebergebene Variable im Sekundentakt bis auf 0 herunter. Alternativ kann statt des Sekundentakts auch ein anderer Zeitschritt angegeben werden. Nuetzlich z.B. fuer Zeitsperren, die in der Statuszeile angezeigt werden sollen. Wenn nach dem Herunterzaehlen ein Makro ausgefuehrt werden soll, muss es nach dem dann notwendigen Takt angegeben werden.
/addh syn /countdown varname [takt]@{N}\
/countdown varname takt makro
/addh countdown mak

/def countdown = \
	/if /test \{%1\}>0%; /then \
	  /test --%1%;\
;	  /test echo(\{%1\})%;\
	  /repeat -%{2-1} 1 /countdown %*%; \
	/else \
	  /if ({#}>2) /eval %-2%; /endif%;\
	/endif%;

/addh info \
Wiederholt den als Restparameter uebergebenen String Parameter1-mal. Dabei ist es egal, ob es sich um Mud- oder tf-Kommandos handelt. Der Zaehler von /n (Variable n) kann auch im Code genutzt werden.
/addh ex /n 5 nimm alles aus leiche %n (oder besser /n 5 nl %n)
/addh n comm
/defh n = \
	/let n=$[{1}+1]%;\
	/while (--n>0) \
          /eval %-1%; \
	/done%;


/addh info \
Wiederholt den als Restparameter uebergebenen String sooft, wie er den Parameter 1 halbieren kann. \
Dabei ist es egal, ob es sich um Mud- oder tf-Kommandos handelt. Der Zaehler von /n2  (Variable n2) kann auch im Code genutz werden.
/addh ex z.B. soviele Muenzen wie moeglich tragen ;) @{N}\
/n2 100000 nimm %n2 muenzen (oder besser /n 100000 nm %n2)
/addh n2 comm

/defh n2 = \
	/let n2=%1%;\
	/while (n2>0) \
	   /eval %-1%;\
	   /let n2=$[n2/2]%;\
	/done%;\

/addh info \
Fuer wiederkehrende Aufgaben aehnlich eines cron-Jobs wird festgelegt, alle wieviel (n) Sekunden sie ausgefuehrt werden (Parameter), dann kann der Hook 'beat_n' mit den entsprechenden Makros gefuellt werden, die zu diesem Zeitpunkt ausgefuehrt werden sollen.@{N}\
Gesteuert wird das ganze durch die Variablen 'do_beat', die alle Beats anhalten kann (0) oder wieder laufen lassen (1), und durch 'do_beat_n', die das ebenso fuer die einzelnen Beats steuert.@{N}\
In der Variablen 'beat_pid_n' steht die pid des letzten repeats des beat.
/addh var do_beat, do_beat_n, beat_pid_n
/addh see hooks,repeat
/addh ex Aller 10 Sekunden ein Beep /beat 10 1%;/add_to_hook beat_10 /echo Beep
/addh syn /beat repeat_sek run_now(1|0)
/addh beat mak

/def beat = \
	/def beat_%{1} = \
	/if (do_beat>=0 & do_beat_%{1}>=0) \
	/if (do_beat_%{1}==1 & do_beat==1) \
	  /eval_hook beat_%{1}\%;\
	/endif\%;\
	/repeat -%{1} 1 /beat_%{1}\%;\
	/set beat_pid_%{1}=\%?\%;\
	/endif\%;%;\
	\
	/set do_beat_%{1}=%{2-1}%;\
	/set do_beat=%{2-1}%;\
	/let beat_output=$(/ps -r)%;\
	/if (strstr(strcat(beat_output," "),strcat("/beat_",{1}," "))==-1) \
	   /beat_%{1}%;\
	/endif%;\

/addh info \
Schaut nach, ob es den als 2. Paramter uebergebenen Prozess bereits gibt. Ist dies nicht der Fall wird er nach Paramter 1 Sekunden ausgefuehrt. Rueckgabewert ist die pid des repeats oder 0 falls es den Prozess schon gibt.
/addh see repeat
/addh syn /repeat_once time makro
/addh ex /repeat_once 5 /purge -mglob mytrigger_*
/addh repeat_once mak
/def repeat_once = \
	/if (!regmatch({-1},$(/ps))) \
		/repeat -%1 1 %-1%;\
		/return %?%;\
	/else \
		/return 0%;\
	/endif


/addh_fileinfo
