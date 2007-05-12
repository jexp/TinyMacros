; $Log: util.echo.tf,v $
; Revision 1.21  2002/10/09 22:38:12  mh14
; simplelists kann jetzt einen Delimeter -d, Alternativ erlaubte Tasten -a und einen Titeltext -t verarbeiten
;
; Revision 1.20  2002/06/13 08:22:08  mh14
; simple_menu unterstuetzt jetz eine hervorhebende Anzeige von Parent-Menues, Farben fuer Parent/Blattknoten, col_echo kann jetzt auch mit Farben umgehen, Farben fuer simple_menu konfigurierbar
;
; Revision 1.19  2002/06/06 10:42:56  mh14
; info farbe neu
;
; Revision 1.18  2002/04/26 14:07:38  nieten
; args, daemlicher Fehler in /col_echo
;
; Revision 1.17  2002/04/24 13:03:09  nieten
; - Korrekturen in der Doku
; - Aenderungen in /col_echo und /simple_menu, so dass Menuenummern jetzt
;   formatiert werden
; - /col_echo etwas umgestrickt
;
; Revision 1.16  2002/04/18 19:34:04  mh14
; simple_menu verarbeitet jetzt q zum abbruch
;
; Revision 1.15  2002/04/16 12:20:01  mh14
; config-system, ein paar aenderungen an simple_menu
;
; Revision 1.14  2002/04/04 13:09:44  mh14
; /info, Config Vars geaendert
;
; Revision 1.13  2002/03/07 15:49:55  nieten
; /remove_attributes eingebaut
; /ext_read piepst nicht mehr so viel
;
; Revision 1.12  2001/12/08 22:38:48  mh14
; fileinfo req
;
; Revision 1.11  2001/12/03 22:01:51  mh14
; config reingeschoben
;
; Revision 1.10  2001/11/05 15:24:24  nieten
; Hilfe zu /echo2 korrigiert
;
; Revision 1.9  2001/09/30 00:58:42  mh14
; Hilfetext geaendert
;
; Revision 1.8  2001/09/25 21:25:47  mh14
;  format_sucess_text fuer erfolgsabhaengige textfaerbung/formatierung, gesteuert durch Benutzervariablen
;
; Revision 1.7  2001/09/12 22:25:57  mh14
; /line aus keys.tf verschoben
;
; Revision 1.6  2001/09/11 20:52:21  mh14
; Erweiteres Read (ext_read) mit Eingabeprompt und Defaultwert in Eingabezeile
; simple_menu ein Menue mit Kommandodarstellung und Auswahl per Zahl
;
; Revision 1.5  2001/09/09 19:09:42  mh14
; help_de.list
;
; Revision 1.4  2001/09/06 21:11:44  mh14
;  Log eingefuegt
;

/set util_echo_tf_version $Id: util.echo.tf,v 1.21 2002/10/09 22:38:12 mh14 Exp $
/set util_echo_tf_author=Mesirii@mg.mud.de
/set util_echo_tf_requires=util.vfunc.tf
/set util_echo_tf_desc Echo-Erweiterungen (Spalten, bedingt, Zeilenumbruch)

; ********************* BEGIN CONFIG ********************
/cfg_set GUI FORMAT_ATTR_SUCCESS Cgreen
/cfg_set GUI FORMAT_ATTR_WARNING Cyellow
/cfg_set GUI FORMAT_ATTR_INFO Cyellow
/cfg_set GUI FORMAT_ATTR_ERROR Cred
/cfg_set GUI FORMAT_ATTR_FATAL Cbgred
/cfg_info gui FORMAT_ATTR Fehlerfarben

/cfg_info gui menu Menues

/cfg_set GUI MENU PARENT_COLOR Cblue
/cfg_info gui MENU PARENT_COLOR Farbe_SubMenue

/cfg_set GUI MENU CHILD_COLOR x
/cfg_info gui MENU CHILD_COLOR Farbe_Menuepunkt

/cfg_set GUI MENU SHOW_SUB_SIGN 1
/cfg_info gui MENU SHOW_SUB_SIGN Anzeige_+Submenue

/set_var col_echo_len 54
/set_var col_echo_size 18
; ********************* END CONFIG **********************

/deprecated format_attr_success v
/deprecated format_attr_warning v
/deprecated format_attr_error v
/deprecated format_attr_fatal v

/addh info \
Erweitert die Funktionalitaet des '-p'-Parameters von /echo um das Attribut \
'@@@{}{N}', welches einen Zeilenumbruch hervorruft.
/addh see echo, attributes
/addh echo2 comm

/defh echo2 = \
	/let param=%*%;\
	/let reg=$[strcat("(^ *(-((p|e)|((a|w)[^ -]+)) )+)")] %;\
	/if ((regmatch(reg,param)==1) & (strstr({P0},"-p")!=-1)) \
	  /let part1=%P0%;\
	  /let part2=$[substr(param,strlen(part1))]%;\
	  /let off=$[strstr(part2,"@{N}")] %;\
	  /while (off!=-1) \
	     /let temp=$[strcat(substr(part2,0,off))]%;\
	     /echo $[strcat(part1," -- ",temp)]%;\
	     /let part2=$[substr(part2,off+4)]%;\
	     /let off=$[strstr(part2,"@{N}")]%;\
	  /done %;\
	/endif %;\
	/if (part2!~"") /echo $[strcat(part1," -- ",part2)]%; /endif

;	  /let reg=$[strcat("(@{(N|n|g|G|u|r|f|d|B|b|h)?(C[A-Za-z1-9]+)?})")] %;\


/addh info \
Sammelt eine Anzahl von Ausgaben und gibt sie beim Aufruf ohne Parameter durch Kommata getrennt wieder aus.
/addh var %echolist
/addh echolist mak

/set echolist=
/def echolist =\
	/if ({*}=~"") \
	    /_echo $[substr(echolist,2)]%;\
	    /set echolist=%;\
	/else \
	    /set echolist=$[strcat(echolist,", ",{*})]%;\
	/endif

/addh info \
Initialisiert die Ausgabebreite und die Spaltenbreite fuer die naechsten /col_echo.
/addh ex  /init_col_echo 80 15
/addh syn /init_col_echo width col_width
/addh init_col_echo mak

/set col_echo=
/set col_line_len=0

/def init_col_echo = \
    /set col_echo_size=%2%;\
    /set col_echo_len=$[trunc({1} / col_echo_size) * col_echo_size]%;\
    /set col_echo=%;\
    /set col_line_len=0

/addh info \
Gibt solange Text in laut /init_col_echo gestalteten Zeilen aus, bis es ohne Parameter aufgerufen wird. Der Text wird spaltenweise formatiert. Wenn Text zu lang ist, ragt er bis auf die naechsten Spalten ueber.
/addh syn /col_echo Text oder kein Parameter zum Beenden
/addh col_echo mak

/def col_echo = \
    /if (!{#}) \
        /col_do_echo%;\
	/return%;\
    /endif%;\
    /let param=%; /test param:={*}%;\
    /if (param=/"@[{]*[}]*") \
        /let off=$[strchr(param,"}")+1]%;\
        /let col_echo_color=$[substr(param,0,off)]%;\
	/let param=$[substr(param,off)]%;\
    /endif%;\
    /let paramlen=$[strlen(param) + 1]%;\
;/echo %col_echo_color, %param, %paramlen%;\
    /let repcount=$[col_echo_size - paramlen]%;\
    /if (repcount < 0) \
	/let repcount=$[col_echo_size + mod(repcount,col_echo_size)]%;\
    /endif%;\
;    /if (strlen(col_echo)+paramlen+repcount > col_echo_len) \
    /if (col_line_len+paramlen+repcount > col_echo_len) \
        /col_do_echo%;\
    /endif%;\
    /test col_echo:=strcat(col_echo, col_echo_color,param,"@{x}", strrep(" ",repcount+1))%;\
    /test col_line_len:=col_line_len+paramlen+repcount+1%;\
;    /if (strlen(col_echo) >= col_echo_len) \
     /if (strlen(col_line_len) >= col_echo_len) \
        /col_do_echo%;\
    /endif

/def col_do_echo = \
	/echo -p @{x} %col_echo%;\
	/set col_echo=%;\
	/set col_line_len=0%;\

/addh info \
Macht nur die Ausgabe, wenn der als erste Parameter uebergebene Ausdruck wahr ist.
/addh ex /ifecho debuglevel==10 Internal Warning
/addh syn /ifecho expression Text
/addh ifecho mak

/def ifecho = \
	/if /test (%1)%; /then /echo %-1%; /endif%;


/addh info \
Ein erweitertes Read, das einen Praefix als Prompt setzt und einen Standardwert in die Eingabezeile schreibt.
/addh syn /ext_read praefix [defaultwert]
/addh ex /ext_read Auswahl 10
/addh see prompt
/addh ext_read func

/def ext_read = \
    /echo -p Eingabe %1%;\
    /if ({#}) \
        /test prompt({1})%;\
    /endif%;\
    /if (kblen()) \
        /dokey DLINE%;\
    /endif%;\
    /test input({2})%;\
    /let input_text=%;\
    /test tfread(input_text)%;\
    /if ({#}) \
        /test prompt("> ")%;\
    /endif%;\
    /return input_text


/addh info \
Ein einfaches Menue, das seine Parameter nummeriert darstellt und als Ergebnis eine darauf normierte Zahl zurueckgibt (oder 0 im Fehlerfall). Die Eingabe von 'q' fuehrt zum Rueckgabewert -1.
/addh ex /simple_menu Laden Speichern Schliessen
/addh return Auswahl oder 0 bei Fehler
/addh simple_menu mak

/def simple_menu = \
    /if (!{#}) \
        /return 0%;\
    /endif%;\
    /let opt_d=_%;\
    /test getopts("a:d:t:")%;\
    /echo %opt_t%;\
    /let sm_width=$[strlen({*})/{#} + 6]%;\
    /test init_col_echo(columns(), sm_width)%;\
    /let count=1%;\
    /let count_size=$[trunc(log10({#})) + 1]%;\
    /let menu_parent=0%; /let menu_text=%;\
    /while ({#}) \
        /test menu_parent:=({1}=/"+*")%;\
	/test menu_text:={1}%;\
        /if (menu_parent & !CFG_GUI_MENU_SHOW_SUB_SIGN) \
	   /test menu_text:=substr(menu_text,1)%;\
	/endif%;\
	/test col_echo(strcat("@{", menu_parent ? CFG_GUI_MENU_PARENT_COLOR : CFG_GUI_MENU_CHILD_COLOR, "}", \
	      pad(count,count_size), ") ", \
	      replace(opt_d," ",menu_text)))%;\
	/shift%;\
	/test ++count%;\
    /done%;\
    /col_echo%;\
    /let menu_input=$[ext_read("Menu: ")]%;\
    /if (menu_input =/ "q") \
        /return -1%;\
    /elseif (menu_input =/ strcat("[",opt_a,"]*")) \
        /return menu_input%;\
    /elseif (menu_input !/ "{[0-9]*}") \
        /return 0%;\
    /elseif (menu_input>=count | menu_input<1) \
	/return 0%;\
    /else \
	/return menu_input%;\
    /endif


/addh info \
Zeichnet eine Linie ueber den gesamten Bildschirm. Wenn ein Parameter angegeben wurde, wird dieser in der Zeile zentriert.
/addh line mak

/def line = \
	/if (!{#}) \
	  /echo - $[strrep("-",columns()-1)]%;\
	/else \
	  /let plen=$[strlen({*})]%;\
	  /let columns=$[(columns()-1-plen)/2]%;\
	  /echo - $[strcat(strrep("-",columns),{*},strrep("-",columns))]%;\
	/endif


/addh info \
Formats the given Text according to the Variables CFG_GUI_FORMAT_ATTR_*.
/addh cfg CFG_GUI_FORMAT_ATTR_*
/addh ex /format_success_text success Done -> formatted text done (for /echo -p) according to the CFG_GUI_FORMAT_ATTR_SUCCESS
/addh format_success_text mak

/def format_success_text = \
     /let param=%1%;\
     /if (param=~"1")         /let param=success%;\
     /elseif (param=~"0")     /let param=success%;\
     /elseif (param=/"ok")    /let param=success%;\
     /elseif (param=/"error") /let param=failure%;\
     /elseif (param=~error)   /let param=failure%;\
     /endif%;\
     /test param:=toupper(param)%;\
     /if (!isVar(strcat("CFG_GUI_FORMAT_ATTR_",param))) \
       /echo -e Wrong format parameter: %param Text: %-1%; \
     /endif%;\
     /return strcat("@{",CFG_GUI_FORMAT_ATTR_%param,"}",{-1},"@{n}")


/addh info \
Gibt den uebergebenen Text entsprechend des angegebenen Errorlevels formatiert aus.
/addh syn /info (error|success|warning|failure|fatal) Text
/addh ex /info error Das ist ein Fehler
/addh info mak

/def info = \
     /let param=%;\
     /test param:=CFG_GUI_FORMAT_ATTR_$[toupper({1-ERROR})]%;\
     /echo -a%param -p %-1


/addh info \
Loescht im uebergebenen String alle Attributsdefinitionen. Nuetzlich fuer Ausgabe in Logfiles oder in den Prompt.
/addh ex Die Zeile@{N}\
/echo -p @@{Ccyan}$[remove_attributes("nicht @@{Cred}rot")]@{N}\
erzeugt als Ausgabe@{N}\
@{Ccyan}nicht rot@{n}
/addh return String ohne Attributsanweisungen
/addh remove_attributes func

/def remove_attributes = \
    /let res=$(/echo -p - %*)%;\
    /result res

/addh info Faerbt die als Parameter angegebenen Worte mit den als ersten Parameter vorgegebenen Attributen ein.\
Gross-/Kleinschreibung beachten! Es werden Trigger mit -mregexp dafuer erzeugt, der Name ist t_highlight_%2
/addh ex /highlight BCred Mekare Maharet
/addh highlight mak

/def highlight  = \
  /def -t"($[replace(' ','|',{-1})])" -P0%1 -p1000000 -F t_highlight_%2 = /test 0     

/addh info Faerbt die ganze Zeile entsprechend des glob Triggers und der als ersten Parameter uebergebenen Attribute ein
/addh ex /color_line BCwhite \* MPA
/addh color_line mak

/def color_line = /def -p100000 -F -a%1 -mglob -t"*%-1*" t_color_line_$[hash({*})] = /test 0

/addh_fileinfo

