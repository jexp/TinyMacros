; $Log: util.trigger.tf,v $
; Revision 1.24  2002/10/19 17:24:40  thufhnik
; tf_prompt geaendert, nach mesis aenderung ging gar nix mehr...
;
; Revision 1.23  2002/10/18 14:06:58  mh14
; tf_prompt debuggt
;
; Revision 1.22  2002/04/11 13:14:34  mh14
; Aenderungen an Prompt alias bei /trig_grab -B -E ohne text werden automatisch nummern verteilt die den text eindeutig grabben lassen, der prompttext verarbeitet jetzt %*
;
; Revision 1.21  2001/12/05 21:25:45  nieten
; Fehler in der Hilfe korrigiert
;
; Revision 1.20  2001/12/05 19:21:20  nieten
; /trig_get_macro debuggt, Parameteruebergabe an callback Makro geht wieder
;
; Revision 1.19  2001/12/03 12:51:14  mh14
; bug in trig_grab rausgemacht
;
; Revision 1.18  2001/11/30 13:20:48  mh14
; grab_trig fuer /test makros angepasst, sowie einen Beginn Prompt -B
;
; Revision 1.17  2001/11/27 13:52:10  mh14
; anpassung first_connect, aenderung reihenfolge in trig_grab_body, bug bei -n raus, bug bei kommandos mit vorhandenen parametern raus -M'/echo abc'
;
; Revision 1.16  2001/11/06 14:12:49  nieten
; Hilfetexte mit @{N} korrigiert
;
; Revision 1.15  2001/10/30 19:36:35  nieten
; /trig_is_active debuggt (siehe dort)
;
; Revision 1.14  2001/10/25 21:32:30  mh14
;  -F0 schaltet fallthru trigger aus default eingeschaltet oder mit -F[1]
;
; Revision 1.13  2001/10/25 20:46:39  mh14
;  trig_grab: check auf aktive trigger trig_is_active, loeschen trig_purge, nummer wird von trig_grab zurueckgegeben, sicherheitskill nach %trig_purge_timeout sekunden
;
; Revision 1.12  2001/10/24 13:37:34  mh14
; -M weggelassen, nur variable wird gesetzt
;
; Revision 1.11  2001/10/24 13:06:38  mh14
; bug -y war nicht in get_opts aufgefauehrt
;
; Revision 1.10  2001/10/24 13:00:32  mh14
; trig_grab kosmetisch meldung ueber nciht definierte variable trig_grab_counter
;
; Revision 1.9  2001/10/22 14:00:04  nieten
; Hilfetexte korrigiert
;
; Revision 1.8  2001/10/22 11:45:18  mh14
; trig_grab ersetzt jetzt alle anderen grab_trigger
;
; Revision 1.7  2001/10/19 14:33:34  mh14
; trig_grab als universeller grab-trigger der alle bisherigen abloesen kann
;
; Revision 1.6  2001/10/01 21:12:50  mh14
; tf_prompt debuggt, def_catch_tf_prompt_trig benutzt tf_prompt um das ende des textes festzustellen
;
; Revision 1.5  2001/09/09 19:09:42  mh14
; help_de.list
;
; Revision 1.4  2001/09/06 21:11:44  mh14
;  Log eingefuegt
;

/set util_trigger_tf_version $Id$
/set util_trigger_tf_author=Mesirii@mg.mud.de
/set util_trigger_tf_requires=
/set util_trigger_tf_desc verschiedene Trigger, die mehrere Zeilen grabben

; ********************* BEGIN CONFIG ********************
; fuer mud_custom_prompt/-response
/add_to_hook first_connect /load_config -c util.trigger

/addh info Time to purge alle Triggers defined by a call of trig_grab
/addh trig_purge_timeout var
/set trig_purge_timeout=10
; ********************* END CONFIG **********************

/addh info \
Zum Erkennen, ob das Mud eine Reihe von Kommandos ausgefuehrt hat, wird das Kommando in %mud_custom_prompt an das Mud geschickt. Dabei kann der Parameter %1 zur Identifizierung benutzt werden. In der Variablen %mud_custom_prompt_response ist die Antwort des Muds enthalten. Dabei wird derselbe Parameter %1 zur Identifizierung genutzt. Nachdem das Kommando ans Mud geschickt wurde, wird der entsprechende Trigger definiert, der als Aktion den als Parameter %2 uebergebenen Text ausfuehrt.
/addh syn /test tf_prompt(Identifikationstext,Aktion)
/addh ex /test tf_prompt("Das ist ein Test","/echo Test erfolgreich")
/addh tf_prompt mak

/set_var mud_custom_prompt=!alias tf_prompt %1
/set_var mud_custom_prompt_response=Neues Alias: tf_prompt  = %1
/set tf_prompt_counter=0

/def tf_prompt = \
     /test ++tf_prompt_counter%;\
     /trig_send_custom_prompt %1%;\
     /eval \
     /def -agCblue -1 -msimple -F -p10000 \
     -t"%mud_custom_prompt_response" \
     t_tf_prompt_%{tf_prompt_counter} = \
     %{-1}%;


/addh info \
Definiert den Trigger, der das Abfangen der Ausgaben des Muds vornimmt. Das Ergebnis wird in der Variablen %fulldetail gespeichert, wobei die Zeilenumbrueche durch @@@{}{N} gebildet werden. Damit ist eine Nutzung mit /echo2 moeglich. Die Ausgabe des Muds wird unterdrueckt.
/addh see /catch_output, (alte Namen: /def_psave_trig, /def_psave3_trig)
/addh ex /set nextmakro=/do_next%;@{N}\
	/set fulldetail=%;@{N}\
	/def_catch_output_trig%;@{N}\
	/catch_output 2%;@{N}\
	unt decke%;unt boden%;
/addh var fulldetail
/addh def_catch_output_trig mak

/def def_psave_trig = /def -ag -t"*" -mglob -F -p100 psave_trig = \
;	/set fulldetail\%;\
	/set fulldetail=\$[strcat(fulldetail,\"\@\{N\}\",\{*})] \%; %;

/eval /def def_catch_output_trig = ${def_psave_trig}

/addh info \
Definiert den Abbruchtrigger (bzw. -hook), der fuer /def_catch_output_trig gilt. Als Paramter kann angegeben werden, wieviele Prompts (Default-Prompt '>') gewartet werden soll (Standard 1). Das Ergebnis des Grabbens wird in der Variablen %fulldetail gespeichert. Es wird anschliessend das in %nextmakro stehende Makro ausgefuehrt, das eine Weiterverarbeitung vornehmen kann.
/addh ex /set nextmakro=/do_next%;@{N}\
	/set fulldetail=%;@{N}\
	/def_catch_output_trig%;@{N}\
	/catch_output 2%;@{N}\
	unt decke%;unt boden%;
/addh syn /catch_output [Anzahl der zu wartenden Prompts == Anzahl der Kommandos]
/addh see /echo2 fuer Ausgabe von Fulldetail mit Zeilenumbruechen, /def_catch_2regexp_trig, /catch_output, /def_catch_prefix_trig, /def_catch_regexp_trig, /def_catch_output_trig, (alte Namen: /def_psave_trig, /def_psave3_trig)
/addh hook psave2
/addh var fulldetail, nextmakro
/addh catch_ouput mak

/def def_psave3_trig = \
	/if (({1}=/"[0-9]*") & ({1}>1)) \
	  /def -n$[{1}-1] -mglob -q -h"PROMPT >*" -p102 psave2 = /nop%;\
	/endif %;\
	/def -1 -mglob -q -h"PROMPT >*"  -F -p101 psave3 = \
	/undef psave_trig\%; /eval -s0 \%nextmakro \%; %;

/eval /def catch_output = ${def_psave3_trig}

/addh info \
Ein Makro, das einen Regexp-Trigger definiert, dessen aufeinanderfolgende Zeilen in der Variablen %fulldetail gespeichert werden. Dabei wird der Text vom Mud unterdrueckt. Nach einer gegebenen Zeit wird das Grabben beendet und das Makro, welches in der Variablen %nextmakro steht, aufgerufen.
/addh ex /def_catch_regexp_trig 5 ^Du siehst:@{N}\
	 Faengt waehrend der folgenden 5 Sekunden alle Textzeilen ab, die mit 'Du siehst:' beginnen, und speichert sie in der Variablen %fulldetail.
/addh syn /def_catch_regexp_trig Sekunden Regexp
/addh see /echo2 fuer Ausgabe von Fulldetail mit Zeilenumbruechen, d/ef_catch_2regexp_trig, /catch_output, /def_catch_prefix_trig
/addh var %nextmakro, %fulldetail
/addh def_catch_regexp_trig mak

/def def_catch_regexp_trig = /def -ag -t%-1 -mregexp -p100 t_catch_regexp = /set fulldetail=\$[strcat(fulldetail,\"\@\{N\}\",\{*\})] \%; %;\
	/repeat -%1 1 /undef t_catch_regexp\%;\
	/eval -s0 \%nextmakro \%; %;


/addh info \
Der Text, der zwischen den zwei angegebenen Regexp-Triggern (einer fuer Start und einer fuer Stop) erscheint, wird inklusive dieser beiden Zeilen in der Variablen %fulldetail gespeichert. Nach dem Ausfuehren des Stop-Triggers wird das Makro, das in der Variablen %nextmakro steht, ausgefuehrt.
/addh ex '/test def_catch_2regexp_trig("^Es begann","^Es endete")' speichert alles zwischen und inklusive der Zeilen der beiden Regexps.
/addh syn /test def_catch_2regexp_trig(regex_start,regex_stop)
/addh see /echo2 fuer Ausgabe von Fulldetail mit Zeilenumbruechen, /catch_output, /def_catch_prefix_trig, /def_catch_regexp_trig
/addh var %nextmakro, %fulldetail
/addh def_catch_2regexp_trig mak

/def body_t_catch_2regexp = \
      /set fulldetail=$[strcat(fulldetail,"@{N}",{*})] %; \
;      /set fulldetail%;\
     /def -ag -t"*" -mglob -F -p100 t_catch_2regexp2 = \
	/set fulldetail=\$[strcat(fulldetail,\"\@\{N\}\",\{*\})] \%; \
;	/set fulldetail\%; %;\


/def def_catch_2regexp_trig = /def -1 -F -ag -t"%{1}" -mregexp -p100 t_catch_2regexp = ${body_t_catch_2regexp}%;\
     /def -1 -ag -t"%{2}" -mregexp -F -p101 t_catch_2regexp3 = \
	   /set fulldetail=\$[strcat(fulldetail,\"\@\{N\}\",\{*\})] \%;\
;	   /set fulldetail\%;\
	   /undef t_catch_2regexp2\%;\
	   /eval -s0 \%nextmakro \%; %;\
;	/list t_catch_2regexp*%;

/def body_t_catch_2regexp_nf = \
      /set fulldetail=$[strcat(fulldetail,"@{N}",{*})] %; \
;      /set fulldetail%;\
     /def -ag -t"*" -mglob -p100 t_catch_2regexp2 = \
	/set fulldetail=\$[strcat(fulldetail,\"\@\{N\}\",\{*\})] \%; \
;	/set fulldetail\%; %;\


/def def_catch_2regexp_trig_nf = /def -1 -ag -t"%{1}" -mregexp -p100 t_catch_2regexp = ${body_t_catch_2regexp_nf}%;\
     /def -1 -ag -t"%{2}" -mregexp -p101 t_catch_2regexp3 = \
	   /set fulldetail=\$[strcat(fulldetail,\"\@\{N\}\",\{*\})] \%;\
;	   /set fulldetail\%;\
	   /undef t_catch_2regexp2\%;\
	   /eval -s0 \%nextmakro \%; %;\
;	/list t_catch_2regexp*%;

/addh info \
Ein Makro, das den Text, in dem die angegebene Regexp auftaucht, fuer eine bestimmte Zeit (Parameter) in der Variablen %fulldetail speichert und nach Ablauf der Zeit das Makro in der Variablen %nextmakro ausfuehrt. Dabei wird nur der Text in der Variablen gespeichert, der nicht von der Regexp abgedeckt wird (PL und PR). Der Text wird gegaggt.
/addh ex '/def_catch_prefix_trig 4 Jemand sagt:' speichert dessen Text fuer 4 Sekunden in der Variablen %fulldetail.
/addh syn /def_catch_prefix_trig Sekunden Regexp
/addh see /echo2 fuer Ausgabe von Fulldetail mit Zeilenumbruechen, /def_catch_2regexp_trig, /catch_output,  /def_catch_regexp_trig
/addh var %nextmakro, %fulldetail
/addh def_catch_prefix_trig mak

/def def_catch_prefix_trig = /def -ag -t"%-1" -mregexp -p100 t_catch_prefix = /set fulldetail=\$[strcat(fulldetail,\"\@\{N\}\",\{PL},\{PR\})] \%; %;\
	/repeat -%1 1 /catch_prefix_body%;

/def catch_prefix_body = \
	/if (isMacro("t_catch_prefix")) \
           /undef t_catch_prefix%;\
	   /eval -s0 %nextmakro %;\
	/endif%;

/addh info \
Faengt einen Text des Muds ab, von dem man nur Anfang und Ende kennen muss und der ueber mehrere Zeilen verteilt sein kann, und laesst den Gesamttext per /trigger nochmal ablaufen, so dass man diesen wie eine Zeile vom Mud betrachten kann.
/addh ex /test def_catch_broken_trig("Der Haendler meint","Muenzen zahlen")
/addh syn /test def_catch_broken_trig("Starttext","Endtext")
/addh def_catch_broken_trig trig

/def def_catch_broken_trig = \
     /def -F -t"%1*" -mglob -p200002 -1 t_catch_broken1 = \
       /test broken_text:={*}\%;\
       /def -F -t"*" -mglob -p200000 t_catch_broken2 = \
              /test broken_text:=strcat(broken_text,' ',{*})\%;\
     /def -F -t"*%2" -mglob -p200001 -1 t_catch_broken3 = \
        /echo -aCred \\\$[strcat(broken_text,' ',{*})]\\\%;\
        /undef t_catch_broken2\\\%; \
	/test trigger(strcat(broken_text,' ',{*}))\\\%;\
	/unset broken_text

/addh info \
Nach dem Triggern der Startzeile werden die naechsten n Zeilen in der Variablen %fulldetail gesammelt und dann das Makro in der Variablen %nextmakro ausgefuehrt, das diesen Text dann verarbeiten kann.
/addh ex '/def_catch_num_trig 5 Inventory:' sammelt die 5 Zeilen des Inventories auf.
/addh syn /def_catch_num_trig num_catch_lines Starttext
/addh def_catch_num_trig trig

/def def_catch_num_trig = \
	/if (({1}=/"[0-9]*") & ({#}>1)) \
	  /def -1 -q -t"%{-1}" -p10000 -ag -F t_catch_num1 = \
	   /test fulldetail:={*}\%; /set num_trig=%1\%;\
	   /def -n%1 -q -t"*" -p10000 -F -ag -mglob t_catch_num2 = \
	    /test fulldetail:=strcat(fulldetail,"@{N}",{*}) %%%;\
	    /if (--num_trig==0) /eval -s0 %nextmakro %%%; /endif \%;%; \
	/endif %;

/addh info \
Faengt den Text von der aktuellen Zeile bis zum Auftreten des TF-Prompts ab, das mit dem uebergebenen Text oder default mit def_catch_tf_prompt_trig ausgefuehrt wird. Der gegrabbte Text steht in der Variablen fulldetail
/addh syn /def_catch_tf_prompt_trig [endtext [tf-code]]
/addh ex  /set nextmakro=/echo \%fulldetail%; /def_catch_tf_prompt_trig%;@{N}\
oder@{N}\
/set nextmakro=/echo \%fulldetail%;/def_catch_tf_prompt_trig EndText%;@{N}\
oder@{N}\
/def_catch_tf_prompt_trig EndText /echo \%fulldetail%;@{N}\
oder@{N}\
/test def_catch_tf_prompt_trig("EndText","/echo \%fulldetail")
/addh def_catch_tf_prompt_trig trig

/def def_catch_tf_prompt_trig = \
	  /set fulldetail=%;\
	  /def -q -t"*" -p9999 -ag -F t_catch_tf_prompt = \
	    /test fulldetail:=strcat(fulldetail,"@{N}",{*})%;\
	  /tf_prompt %{1-def_catch_tf_prompt_trig} \
	     /undef t_catch_tf_prompt\\\%;$[escape("%$",{-1-%nextmakro})]

/addh info \
Grabbt Zeilen aus dem Output des Muds, beginnend mit einer Startzeile (-b) ueber n Zeilen Body (ggf. -y) und eine Endzeile. Das ganze wird durch drei Trigger gesteuert.@{N}\
Wie kann der eingefangene Text genutzt werden: Entweder es wird per -M ein Makro angegeben, dem der Text nach Abschluss uebergeben wird. Ausserdem wird er in der mit -v angegebenen Variablen (default %fulldetail) gespeichert. Die einzelnen Zeilen werden mit @@@{}{N} (siehe /echo2) oder den bei -d angegebenen Zeichen verkettet. Oder das angegebene Makro wird pro Zeile mit der Zeile aufgerufen (wie bei /quote, daher auch -q).@{N}\
Abgebrochen wird das Triggering nach einer Anzahl Body-Zeilen (-n), nach einer gewissen Zeit (-t) oder nachdem ein zweites Kommando (-P, mud_custom_prompt) eine weitere Ausgabe im Mud erzeugt hat (%mud_custom_prompt_response). Mit -N kann die Anzahl der Kommandos bestimmt werden, deren Ausgaben eingefangen werden sollen.@{N}\
Was eingefangen werden soll gibt -c an: b Beginnzeile, y Bodyzeilen, e Endzeile (z.B. -cbye fuer alles inkl. Beginn- und Endzeile).@{N}\
Wenn die Triggertexte mit einen Praefix beginnen, kann damit der Matching Modus festgelegt werden (r# regexp, g# glob, s# simple).@{N}\
Mit -C kann ein Kommando angegeben werden, dessen Ausgabe eingefangen werden soll. Alternativ kann dieses auch vor /trig_grab losgeschickt werden.
/addh ex @{N}\
/trig_grab -b"g#*--------" -e"r#^-+$" -M/echo  -q -ag -cbye -Cinfo@{N}\
faengt die Ausgabe des info Befehls in mg.mud.de ein und gibt sie gleich wieder zeilenweise per /echo aus@{N}\
/trig_grab -b"g#*--------" -e"r#^-+$" -M/echo -d# -ag -cy -Cinfo@{N}\
faengt nur den Kern der Info-Ausgabe ein (keine Start und Endtext, siehe -c) und gibt diese per /echo nach erfolgten grabbing als einen Text (Zeilen getrennt durch #, siehe -d) aus)@{N}\
/trig_grab -e"r#Ausgae?nge?:" -Cschau -M/scan_raum -aCred@{N}\
faengt die Raumbeschreibung (P_LONG) des aktuellen Raumes ein, faerbt diese rot (-aCred) und uebergibt sie an das eigene Makro /scan_raum als Parameter.
/addh opt a Attributes@{N}\
b Beginning Text syn: [[rgs]#]Text@{N}\
e Ending Text syn: [[rgs]#]Text@{N}\
q Quote Mode (def. off)@{N}\
n Number of Body Lines@{N}\
N Number of Commands (whose output shall be catched) sent to the Mud (Prompt-Hooks)@{N}\
E,P Prompt Text Ende@{N}\
B Prompt Text Beginn@{N}\
t Time (sec)@{N}\
v globale Variable name (def. fulldetail)@{N}\
M callback Macro name (def. none, only the variable is set)@{N}\
d Line delimeter (def. @@@{}{N})@{N}\
c Catch Mode ([b][y][e] b beginning y Body e end) (def. y)@{N}\
y Body Trigger Text (z.B. fuer Praefix) syn: [[rgs]#]Text (def. *)@{N}\
p Priority@{N}\
F fallthru triggers or not (def 1)@{N}\
C Kommando fuers Mud
/addh trig_grab trig

/def trig_grab = \
	/init_var trig_grab_counter%;\
	/test ++trig_grab_counter%;\
	/let opt_v=fulldetail%;\
	/let opt_a=n%;\
	/let opt_d=@{N}%;\
	/let opt_p=1%;\
	/let opt_c=y%;\
	/let opt_q=0%;\
	/let opt_y=*%;\
	/let opt_F=1%;\
	/let opt_P=0%; /let opt_B=0%; /let opt_E=0%;\
	/test getopts("w:C:a:b:e:qn#p#t#v:d:c:P:M:y:N#F#B:E:")%;\
	/if (opt_w!~"") /let opt_w=-w%opt_w%; /endif%;\
	/if (opt_E!~"0") \
	   /let opt_P=%opt_E%;\
	   /let opt_E=%;\
	/endif%;\
	/if (opt_P!~"0") \
	   /if (opt_P=~"") /let opt_P=end_%{trig_grab_counter}%; /endif%;\
	   /let opt_e=$[trig_def_custom_prompt(opt_P)]%;\
	/endif%;\
	/if (opt_B!~"0") \
	   /if (opt_B=~"") /let opt_B=start_%{trig_grab_counter}%; /endif%;\
	   /let opt_b=$[trig_def_custom_prompt(opt_B)]%;\
	/endif%;\
	/eval -s0 $[trig_grab_start()]%;\
;	/list trig_grab_start_%{trig_grab_counter}%;\
	/if (opt_b=~"") /trig_grab_start_%{trig_grab_counter}%; /endif%;\
	/if (opt_B!~"0") \
	   /trig_send_custom_prompt %opt_B%;\
	/endif%;\
	/if (opt_C!~"") \
           /eval -s0 -- %opt_C %;\
	/endif%;\
	/if (opt_P!~"0") \
	   /trig_send_custom_prompt %opt_P%;\
	/endif%;\
	/return trig_grab_counter

/def trig_send_custom_prompt = \
	/eval %mud_custom_prompt

/def trig_def_custom_prompt = \
	/eval /return "s#%mud_custom_prompt_response"

/def trig_grab_body = \
	/let result=/def %opt_w $[trig_grab_text(opt_y)] -p$[opt_p+1] $[opt_F?"-F":""] -q -a%opt_a $[opt_n ? strcat("-n",opt_n) : ""] trig_grab_body_%{trig_grab_counter} = \
	    $[trig_grab_command("y")] \
	    $[opt_n ? strcat("/if (--trig_grab_number_",trig_grab_counter,"<=0) /trig_grab_end_",trig_grab_counter,"%;/break%; /endif%;") : ""]%; \
	/return result

/def trig_grab_text = \
	/if ({*}=/"[rgs]#*") \
	    /let param=$[substr({*},0,1)]%;\
	    /test param:=param=~"s" ? "-msimple" : param=~"r" ? "-mregexp" : "-mglob"%;\
	    /let param=%param -t"$[substr({*},2)]"%;\
	/else \
	    /let param=-mglob -t"%{*}"%;\
	/endif%;\
	/return param%;

/def trig_grab_end = \
	/if (opt_e!~"") \
	    /let result=/def %opt_w  $[trig_grab_text(opt_e)] -a%opt_a -p$[opt_p+2] -1 $[opt_F?"-F":""] -q trig_grab_end_%{trig_grab_counter} = %;\
	/elseif (opt_N) \
	    /let result=/def %opt_w -hPROMPT -p$[opt_p+2] -n%opt_N -F -q trig_grab_end_%{trig_grab_counter} = %;\
	/else \
	    /let result=/def trig_grab_end_%{trig_grab_counter} = %;\
	/endif%;\
	/let result=%result \
	    $[opt_N ? strcat("/if (--trig_grab_number_",trig_grab_counter,">0) /break%; /endif%;") : ""] \
	    $[!opt_N ? trig_grab_command("e") : ""] \
	    /set trig_grab_active=0\%;\
	    $[strcat("/purge trig_grab_*_",trig_grab_counter,"%;")] \
	    $[!opt_q ? trig_get_macro() : ""]%;\
	/return result%;

/def trig_get_macro = \
        /if (opt_M!~"") \
	   /if (opt_M=/"/test *") \
	      /return strcat(opt_M,"\%;") %;\
	   /endif%;\
	   /if (opt_M=/"* *") \
	      /return strcat(opt_M," \%",opt_v , "\%;") %;\
	   /else \
              /return strcat(opt_M," -- \%",opt_v , "\%;") %;\
	   /endif%;\
	/endif%;

/def trig_grab_start = \
	/if (opt_b!~"") \
	    /let result=/def %opt_w $[trig_grab_text(opt_b)] -a%opt_a -p%opt_p -1 $[opt_F?"-F":""] -q trig_grab_start_%{trig_grab_counter} = %;\
	/else \
	    /let result=/def trig_grab_start_%{trig_grab_counter} = %;\
	/endif%;\
	/let result=%result \
	    $[!opt_q ? strcat("/set ",opt_v,"=%;") : "" ] \
	    $[trig_grab_command("b")] \
	    $[opt_t ? strcat("/repeat -",opt_t," 1 /trig_grab_end_",trig_grab_counter,"%;") :""] \
	    $[opt_n ? strcat("/set trig_grab_number_",trig_grab_counter,"=",opt_n,"%;") : "" ] \
	    $[opt_N ? strcat("/set trig_grab_number_",trig_grab_counter,"=",opt_N,"%;") : "" ] \
	    $[strcat("/repeat -",max(trig_purge_timeout,(opt_t ? opt_t+1 : 0))," 1 /purge trig_grab_*_",trig_grab_counter,"%;")] \
	    /set trig_grab_active=1\%;\
	    $[escape("%$",trig_grab_end())] \%;\
	    $[escape("%$",trig_grab_body())]%;\
	/return result%;

/def trig_grab_command = \
	/if (opt_c=/strcat("*",{1},"*")) \
	    /if (opt_q & opt_M!~"") \
	        /return strcat(opt_M,((opt_M!/"* *")?" --":"")," \%{*}\%;")%;\
	    /else \
	        /return strcat("/test ",opt_v,":=strcat(",opt_v,",{*},'",opt_d,"')\%;")%;\
	    /endif%;\
	/endif%;\
	/return ""

/addh info checks of the triggers defined with trig_grab, whose number was returned by trig_grab are still active or not
/addh syn /trig_is_active number returned by trig_grab
/addh return number of still active triggers/macros (0 to 3)
/addh trig_is_active mak

/def trig_is_active = \
	/set trig_still_active=0%;\
; Die Zeile
;	/quote -S /test ++trig_still_active `/list -mglob trig_grab_*_%1%;\
; verursacht Fehler, da das Ergebnis von /list als zweites Argument
; von /test gewertet wird. Deshalb
; Temporaeres Makro, um in der /quote-Zeile das Ergebnis von /list wegzuwerfen.
	/def trig_inc_counter = /test ++trig_still_active%;\
	/quote -S /trig_inc_counter `/list -s -mglob trig_grab_*_%1%;\
	/undef trig_inc_counter%;\
	/return trig_still_active%;


/def file_trigger = \
     /custom -a %-L%;\
     /test %?%;\
     /let ut_filepath=%load_dir%load_file%;\
     /let ut_filename=%L%;\
     /if (file_exists(ut_filepath)) \
         /purge t_ut_%{ut_filename}*%;\
         /let handle=%;\
	 /test handle:=tfopen(ut_filepath,"r")%;\
	 /let line=%;\
	 /let ut_counter=0%;\
	 /let ut_counter2=0%;\
	 /let ut_trigger_gag=%;\
	 /let ut_trigger=%;\
	 /let action_nr=0%;\
	 /let echo_cmd=%;\
	 /let exec_cmd=%;\
	 /while (tfread(handle,line)>-1) \
	       /if (line=/";*") \
	       /elseif (line=/"+*") \
	           /let echo_cmd=/echo -p $[substr(line,1)]%;\
	       /elseif (line=/"#*") \
	           /if (line=~"#") \
		      /let action_nr=0%;\
		   /else \
		      /let action_nr=$[substr(line,1)]%;\
		   /endif%;\
	       /elseif (line=/"\\**") \
	           /if (line=~"*") \
		      /let exec_cmd=%;\
		   /else \
	              /let exec_cmd=$[substr(line,1)]\%;%;\
		   /endif%;\
	       /elseif (line=~"") \
	          /if (ut_trigger!~"") \
		     /let ut_counter2=0%;\
/let action_nr%;\
		     /if (action_nr==0) \
		        /let trigger_def=$[def_trigger("-p100",ut_filename, ut_counter, ut_trigger, ut_trigger_gag, exec_cmd, echo_cmd)]%;\
		     /else \
		        /let trigger_def=$[def_trigger("-p100",ut_filename, ut_counter, ut_trigger, ut_trigger_gag)]%;\
		     /endif%;\
		     /echo -aCyellow %trigger_def%;\
		     /eval -s0 %trigger_def%;\
		     /test ++ut_counter%;\
		     /let ut_trigger=%;\
		     /let ut_trigger_gag=%;\
		  /endif%;\
	       /else \
	           /if (ut_counter2==0) \
		       /let ut_trigger=%line%;\
		   /else \
		      /if (action_nr==ut_counter2) \
		        /let ut_trigger_gag=%ut_trigger_gag $[escape('%$',def_trigger("-p101 -1",ut_filename, strcat(ut_counter,"_",ut_counter2), line, exec_cmd, echo_cmd ))]%;\
		      /else \
		        /let ut_trigger_gag=%ut_trigger_gag $[def_trigger("-p101 -1",ut_filename, strcat(ut_counter,"_",ut_counter2), line)]%;\
		      /endif%;\
		   /endif%;\
		   /test ++ut_counter2%;\
	       /endif%;\
	 /done%;\
	 /test tfclose(handle)%;\
     /else \
        /info error Datei %ut_filepath existiert nicht%;\
     /endif

/def def_trigger = \
     /let def_trigger=/def %1 -m$[get_trigger_mode({4})] -t'%4' -aCgreen -F t_ut_%2_%3 = $[{#}<5 ? "/test 0" : {-4} ]\%;%;\
;     /echo %def_trigger%;\
     /return def_trigger%;\

/def get_trigger_mode = \
     /if (regmatch("(\\^|\\$|\\.\\+|\\.\\*)",{*})) /return "regexp"%;\
     /elseif (regmatch("(\\*|[{}])",{*})) /return "glob"%;\
     /else /return "simple"%;\
     /endif

/def del_trig = \
    /list -s -t"*%{*}*"%;\
    /if ({?} >0) \
    /let tmp=$[ext_read("Makronummer/name (Nichts fuer Abbruch):")]%;\
    /if (tmp=~"") /return%; /endif%;\
    /if (tmp=/"[0-9]*") \
	/undefn %tmp%; \
    /else \
	/undef %tmp%; \
    /endif%;\
    /else /info ERROR keine Trigger, die "%*" enthalten gefunden!%;\
    /endif

/addh info removes the triggers defined with trig_grab, whose number was returned by trig_grab
/addh syn /trig_purge number returned by trig_grab
/addh trig_purge mak

/def trig_purge = \
	/purge trig_grab_*_%1

/addh_fileinfo
