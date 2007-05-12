; $Log: worldconnect.tf,v $
; Revision 1.23  2002/12/03 03:46:34  mh14
; Sprachkonzept geändert, kein LANG mehr sondern user_lang (-L) und mud_lang (-l) neue mak_loc zu direkten Ersetzen von Strings in Makrobodies, /addh kennt jetz locales für verschiedene Hilfeversionen
;
; Revision 1.22  2002/10/10 00:11:00  mh14
; zu speichernde Variablen tosave konfigurierbar
;
; Revision 1.21  2002/10/02 18:40:56  nieten
; Fenstertitel korrigiert
;
; Revision 1.20  2002/09/28 00:43:30  mh14
; Update bei Configure
;
; Revision 1.19  2002/09/27 23:25:59  mh14
; Konfigurierbarer Fenstertitel
;
; Revision 1.18  2002/06/06 09:34:22  thufhnik
; nach dem laden des save-files den hook loadsaved ausfuehren
;
; Revision 1.17  2002/04/17 01:13:35  nieten
; /loadsaved und /saveall verwenden nach Moeglichkeit das Playerverzeichnis
;
; Revision 1.16  2002/04/16 12:22:57  mh14
; config-system anpassungen
;
; Revision 1.15  2002/04/11 16:09:05  mh14
; grummel typo
;
; Revision 1.14  2002/04/11 15:58:42  mh14
; bugs in addplayer beseitigt
;
; Revision 1.13  2002/03/29 22:06:32  mh14
; IDLE_TIME -> CFG_CONNECT_IDLE_TIME , addplayer kann jetzt auch Verzeichnisse erzeugen, im Debugmode Ausgabe der Zeit fuer das Laden aller Files
;
; Revision 1.12  2002/03/28 01:10:28  mh14
; hook fuer idlecheck auch hier definiert
;
; Revision 1.11  2002/03/27 23:47:55  mh14
; Idlecheck eingebaut
;
; Revision 1.10  2002/03/27 01:31:35  mh14
; /loadsaved jetzt garantiert als letzttes beim connect
;
; Revision 1.9  2001/12/18 00:02:04  mh14
; FirstConnect Ausgabe raus und requirre gesaeubert
;
; Revision 1.8  2001/11/29 15:45:56  mh14
; addplayer
;
; Revision 1.7  2001/11/28 14:57:53  mh14
; noch 2 sachen an first_connect gehaengt
;
; Revision 1.6  2001/11/28 11:38:28  mh14
; besseres abfangen nicht definierter welten
;
; Revision 1.5  2001/11/27 21:20:27  mh14
; playerfile wieder in -c, solange verzeichnis noch nich da, connect hook auf erstes > Prompt geaendert, damit die connection auch wirklich da ist
;
; Revision 1.4  2001/11/06 19:15:11  nieten
; /feset kommt nun auch mit mehr als 2 Argumenten zurecht
; /loadsaved und /saveall spden/eichern ${world_character}saved nun im Spielerverzeichnis
;
; Revision 1.3  2001/10/10 22:10:21  mh14
; Default-Konfiguration in .tf Files verschoben
;
; Revision 1.2  2001/10/07 17:05:16  mh14
; Funktionaliatet aus tf-connect hook in eigenen connect hook, der auf Begruessungsstring vom Mud triggert, verschoben
;
; Revision 1.1  2001/10/03 09:39:01  mh14
; connection sachen aus loading.tf ausgelagert
;
;

/set worldconnect_tf_version $Id: worldconnect.tf,v 1.23 2002/12/03 03:46:34 mh14 Exp $
/set worldconnect_tf_author=Mesirii@mg.mud.de
/set worldconnect_tf_requires lists.tf util.hooks.tf util.prompts.tf util.tf(1.21)
/set worldconnect_tf_desc Speichern und Laden von Variablen, Connection mit automatischen Laden von Files

; ********************* BEGIN CONFIG ********************
/add_to_hook first_connect /load_config -L user_config
/add_to_hook first_connect /load_config -c user_config
/add_to_hook first_connect /load_config -c -p user_config

/addh info Konfiguration Fenstertitel
/addh update /eval /xtitle %CFG_CONNECT_TITLE
/addh CFG_CONNECT_TITLE cfg

/set_var CFG_CONNECT_TITLE=TF: ${world_character}@${world_host} (${world_name})
/cfg_info connect TITLE Fenstertitel
/eval /add_to_hook first_connect /xtitle %CFG_CONNECT_TITLE

/beat 30
/add_to_hook beat_30 /check_idle
; 1 Min Idle
/addh info Zeit ab der man als idle angesehen wird
/addh CFG_CONNECT_IDLE_TIME cfg
/set_var CFG_CONNECT_IDLE_TIME 120
/cfg_info connect IDLE_TIME Idlezeit

/def cfg_varlist = \
/addh info Liste der fuer ${world_character} gespeicherten Variablen%;\
/addh ${world_character} cfg%;\
/cfg_info connect VARLIST gespeicherte_Variablen:${world_character}tosave

/add_to_hook connect /cfg_varlist
; ********************* END CONFIG **********************

/addh info Variable, die anzeigt, ob der Nutzer gerade als Idle angesehen wird
/addh user_is_idle var

/set user_is_idle=0

/addh info \
Testet ob der Nutzer seit %CFG_CONNECT_IDLE_TIME keine Taste mehr gedrueckt hat, setzt das Flag %user_is_idle und ruft den Hook ?user_got_idle auf.@{N}\
Wenn der Nutzer wieder aktiv wird, und vorher idle war wird das Flag zurueckgesetzt und der Hook ?user_got_active aufgerufen@{N}\
Haengt zur Zeit am Hook beat_30 (aller 30Sek)
/addh check_idle mak

/def check_idle = \
     /if (!user_is_idle & idle()>CFG_CONNECT_IDLE_TIME) \
        /toggle user_is_idle%;\
	/eval_hook user_got_idle%;\
     /endif%;\
     /if (user_is_idle & idle()<CFG_CONNECT_IDLE_TIME) \
        /toggle user_is_idle%;\
	/eval_hook user_got_active%;\
     /endif%;

/addh info Hook der beim Idle-Werden des Nutzers aufgerufen wird
/addh user_got_idle hook

/addh info Hook der beim Aktiv-Werden des Nutzers aufgerufen wird
/addh user_got_active hook


/addh info \
Beim Connect wird einmalig die Datei ${world_host}/${world_character} geladen.\
Ausserdem werden die mittels /saveall abgespeicherten Variablen mit /loadsaved wieder geladen.
/addh mak saveall, loadsaved
/addh hook CONNECT
/addh myconn hook
/def -hCONNECT -p2 -F h_connect_hook = \
; erster Prompt ohne : oder ? am Ende
          /if (${world_name}=~"" | ${world_character}=~""| ${world_host}=~"") \
	    /listworlds ${world_name}%;\
	    /echo -aCyellow Keine mud- und spielerspezifischen Dateien geladen fuer diese Welt!%;\
	/else \
	  /def -q -mglob -F -n1 -h'PROMPT *[^:?]?' h_connect_success = \
 	  /connect_init%;\
	/endif%;

/def connect_init = \
	  /set ${world_character}tosave=%tosave%;\
	  /if (!isVar(strcat(world_info("name"),"_connect_count"))) \
	     /set ${world_name}_connect_count=0%;\
	  /endif%;\
	  /test ++${world_name}_connect_count%;\
	  /eval_hook connect ${world_name}%;\
	  /if /test ${world_name}_connect_count==1%; /then \
;	     /echo -aCyellow First Connect%;\
	     /eval_hook first_connect ${world_name}%;\
	     /loadsaved%;\
	     /ifecho debug Time to load all Files $[time()-load_time] sek%;\
	  /endif %;\

/add_to_hook first_connect /mload -c ${world_character}.tf
/add_to_hook first_connect /load_config user_connect
;/add_to_hook first_connect /loadsaved

/addh info \
Beendet die Verbindung zur aktuellen Welt und baut sofort eine neue auf.
/addh syn /reconnect [world]
/addh reconnect comm

/def reconnect = \
	/let world=%{1-${world_name}}%;\
	/dc %world%;\
	/connect %world%;

/addh info \
Speichert bei einem Disconnect die angegebenen Variablen.
/addh see addsave, loadsaved, saveall
/addh hook SIGHUP, DISCONNECT
/addh mydc hook
/def -hSIGHUP|DISCONNECT mydc = /eval_hook disconnect

/addh info \
Ueberschreibt das standardmaessige /quit so, dass die angegebenen Variablen abgespeichert werden. Der Hook quit wird ausserdem ausgefuehrt.
/addh see loadsaved, saveall, addsave, lists.mak
/addh quit over

/def quit = \
	/eval_hook quit%; /@quit %;


/defh addplayer = \
	/echo Eingabe Daten fuer einen neuen Spieler:%;\
	/let addplayer_name=$[ext_read("Spielername: ")]%;\
	/let addplayer_pwd=$[ext_read("Passwort (optional): ")]%;\
	/let addplayer_host=$[world_info("host")!~"" ? world_info("host") : "mg.mud.de"]%;\
	/let addplayer_host=$[ext_read("Hostname des Mud: ",addplayer_host)]%;\
	/mkdir -a %makdir%addplayer_host%;\
	/mkdir -a %makdir%addplayer_host/%addplayer_name%;\
	/let addplayer_port=$[world_info("port")!~"" ? world_info("port") : "23"]%;\
	/let addplayer_port=$[ext_read("Port des Mud: ",world_info("port"))]%;\
	/let addplayer_type=$[world_info("type")!~"" ? world_info("type") : "lpp"]%;\
	/let addplayer_type=$[ext_read("ConnectTyp der Welt: ",world_info("type"))]%;\
	/let addplayer_world=$[ext_read("Weltbezeichnung: ",addplayer_name)]%;\
	/loadworld%;\
	/test addworld(addplayer_world,addplayer_type,addplayer_host,addplayer_port,addplayer_name,addplayer_pwd)%;\
	/saveworld%;\
	/echo Teste Verbindung:%;\
	/connect %addplayer_world%;\

/addh info \
Laedt die in der letzten Sitzung gespeicherten Variablen aus der Datei ${world_character}saved.list im Verzeichnis ${world_host}/${world_character}. Falls diese Datei nicht existiert, wird versucht, sie aus ${world_host} zu laden. (Dieser zweite Versuch wird nur aus Kompatibilitaetsgrunden durchgefuehrt und in zukuenftigen Versionen vermutlich rausfliegen.)
/addh list ${world_character}saved
/addh see /addsave, /saveall
/addh changes Defaultverzeichnis ist nun ${world_host}/${world_character}.
/addh loadsaved comm

/def loadsaved = \
    /echo -aB Loading saved variables for ${world_character}%;\
    /file_exists ${world_host}/${world_character}/${world_character}saved.list%;\
; Nach Moeglichkeit aus dem Playerverzeichnis laden.
    /if ({?}) \
        /loadlist -q -c -p ${world_character}saved%;\
        /loadlist -q -c -p ${world_character}tosave%;\
    /else \
        /loadlist -q -c ${world_character}saved%;\
        /loadlist -q -c ${world_character}tosave%;\
    /endif%;\
    /forEach ${world_character}saved kv /feset%;\
    /eval_hook loadsaved


/def feset = \
	/set %1=%-1

/addh info \
Fuegt die als Parameter angegebene Variable zu einer Liste hinzu, damit sie \
spaeter mit abgespeichert wird.
/addh list ${world_character}tosave
/addh see loadsaved, saveall
/addh var tosave, _temp
/addh addsave comm
/def addsave = \
	/set _temp=%${world_character}tosave %;\
	/if (_temp!~"tosave") /set _temp=${world_character}tosave %;\
	/endif %;\
	/iskey %_temp %1%;\
	/if (value=~error) \
	  /addtolist %_temp %1%;\
	/endif %;\
	/unset _temp %;


/addh info \
Speichert alle in der Liste angegebenen Variablenwerte in ${world_character}saved.list im Verzeichnis ${world_host}/${world_character} bzw. speichert die angegebenen Listen in ihre entsprechenden Dateien.
/addh list ${world_character}tosave
/addh see /addsave, /loadsaved
/addh changes Wird nun in ${world_host}/${world_character} gespeichert.
/addh saveall comm

/def saveall = \
    /if (${world_character} !~ "") \
	/createlist ${world_character}saved%;\
	/forEach ${world_character}tosave k /addsave2%;\
; Nach Moeglichkeit ins Playerverzeichnis schreiben.
	/dir_exists ${world_host}/${world_character}%;\
	/if ({?}) \
	    /savelist -c -p ${world_character}saved%;\
	/else \
	    /savelist -c ${world_character}saved%;\
	/endif%;\
	/savealllists%;\
    /endif


/def addsave2 =\
    /eval /addtolist ${world_character}saved %1 \%%1%;

/add_to_hook disconnect /saveall
/add_to_hook quit /saveall

/addh_fileinfo
