; $Log: util.windows.tf,v $
; Revision 1.17  2002/10/18 19:11:40  nieten
; kleiner Bugfix
;
; Revision 1.16  2002/10/18 19:01:44  nieten
; %window_options fuer weitere Parameter fuer xterm/cmd eingebaut
;
; Revision 1.15  2002/10/03 20:02:51  mh14
; make_home bei show_window_unix
;
; Revision 1.14  2002/09/28 01:30:31  mh14
; ps x statt -x
;
; Revision 1.13  2002/09/17 13:11:14  mh14
; Anzeigen von Xterms jetzt ein/ausschaltbar per configure
;
; Revision 1.12  2002/04/16 12:21:52  mh14
; config-system anpassungen
;
; Revision 1.11  2002/02/09 15:19:56  mh14
; timestampintervall einstellbar, und auch ganz stopbar
;
; Revision 1.10  2002/01/15 14:01:51  nieten
; Beim Starten des Logs wird jetzt auch Datum geschrieben
;
; Revision 1.9  2001/12/03 22:06:18  mh14
; ms windows kompatibel, keine timestamps wenn ausgeloggt
;
; Revision 1.8  2001/11/27 13:53:18  mh14
;  debuggt, handle bei tfwrite
;
; Revision 1.7  2001/10/29 18:28:27  nieten
; /remove_window schliesst den zugehoerigen stream
;
; Revision 1.6  2001/10/10 22:10:21  mh14
; Default-Konfiguration in .tf Files verschoben
;
; Revision 1.5  2001/09/09 19:09:42  mh14
; help_de.list
;
; Revision 1.4  2001/09/06 21:11:44  mh14
;  Log eingefuegt
;

/set util_windows_tf_version $Id$
/set util_windows_tf_author=Mesirii@mg.mud.de
/set util_windows_tf_requires lists.tf 
/set util_windows_tf_desc gezieltes Umleiten von Mudausgaben in Dateien und andere Fenster

; ********************* BEGIN CONFIG ********************
/cfg_info windows Textumleitung
/cfg_info windows TIMESTAMP_INTERVAL Zeitstempelabstand
/cfg_set windows timestamp_interval 15

/add_to_hook first_connect /windows_run_timestamps

/addh info Flag das angibt ob ein xterm/dos box aufgemacht werden soll, die den Inhalt des Logfiles anzeigt
/addh dtype flag
/addh CFG_WINDOWS_SHOW_XTERM cfg

/cfg_info windows SHOW_XTERM Logfile_anzeigen
/cfg_set windows SHOW_XTERM 1

/createlist windows
; ********************* END CONFIG **********************

/addh info \
In das als erster Parameter angegebene Fenster werden die vom als Rest angegebenen Regexp-Trigger geschrieben, aber trotzdem noch im normalen Fenster angezeigt.
/addh ex /add_to_window_r Tod \\[Tod:.*
/addh add_to_window_r comm

/def add_to_window_r = /test _add_to_window({1},{-1},"-mregexp")%;

/addh info \
In das als erster Parameter angegebene Fenster werden die vom als Rest angegebenen Regexp-Trigger geschrieben, aber trotzdem noch im normalen Fenster angezeigt und zwar wird der gematchte Text mit den als 2. Parameter angegebenen Attributen eingefaerbt.

/addh ex /add_to_window_rc Tod Cblack \\[Tod:.*
/addh add_to_window_rc comm

/def add_to_window_rc = /test _add_to_window({1},{-2},strcat("-mregexp -P0",{2}))%;

/createlist windows
/addh info \
In das als erster Parameter angegebene Fenster werden die vom als Rest angegebenen Regexp-Trigger geschrieben, aber wird nicht mehr im normalen Fenster angezeigt.
/addh ex /move_to_window_r Tod \\[Tod:.*
/addh move_to_window_r comm

/def move_to_window_r = /test _add_to_window({1},{-1},"-mregexp -ag")%;

/addh info \
In das als erster Parameter angegebene Fenster werden die vom als Rest angegebenen Global-Trigger geschrieben, aber trotzdem noch im normalen Fenster angezeigt.
/addh ex /add_to_window_g Tod *[Tod:*
/addh add_to_window_g comm

/def add_to_window_g = /test _add_to_window({1},{-1},"-mglob")%;

/addh info \
In das als erster Parameter angegebene Fenster werden die vom als Rest angegebenen Global-Trigger geschrieben, aber wird nicht mehr im normalen Fenster angezeigt.
/addh ex /move_to_window_g Tod *[Tod:*
/addh move_to_window_g comm

/def move_to_window_g = /test _add_to_window({1},{-1},"-mglob -ag")%;

/addh info \
In das als erster Parameter angegebene Fenster wird der als Restparameter uebergebene Text geschrieben.
/addh ex /write_to_window Tod wieder mal gestorben
/addh write_to_window comm
/def write_to_window = /test _add_to_window({1},{-1},"no_trig")%;

/addh info \
Zeigt das als Parameter angebegene Fenster an (falls es geschlossen wurde). \
In der Variable ?%window_options koennen zusaetzliche Parameter fuer xterm bzw. cmd uebergeben werden.
/addh ex /show_window Tod
/addh show_window comm

/addh info \
Mit dieser Variable koennen zusaetzliche Parameter an xterm bzw. cmd uebergebene werden. Dazu muss sie vor dem Aufruf von ?/show_window gesetzt werden.
/addh ex -bg black -fg white
/addh window_options var

/set_var window_options=

/def show_window = \
	/if (OS=/"*win*") \
	   /show_window_win %*%;\
	/else \
	   /show_window_unix %*%;\
	/endif%;

/def show_window_unix = \
	/def -1 -hRESUME -ag h_resume = /test 0%;\
	/set output=$(/sys "ps x | grep tail")%;\
	/let tail=tail -%2f $[get_window_file({1})]%;\
	/if (strstr(output,tail)==-1) \
	/if (TERM=/"screen*") \
	    /sys screen -X screen -t "%1" %tail%;\
	/else \
	    /sh -q xterm -title "%1" %window_options \
		-e %tail &%;\
	/endif%;\
	/endif

/def show_window_win = \
	/def -1 -hRESUME -ag h_resume = /test 0%;\
	/sh -q cmd %window_options \
'	    /c "start tail -%2f $[make_dos_path(get_window_file({1}))]"

/addh info \
liefert den Dateinamen fuer das Logging dieses windows zurueck
/addh get_window_file mak

/def get_window_file = \
	/return strcat(make_home(makdir),world_info("host"),"/",{1},".log")

/def _add_to_window = \
	/let window=%1%;\
	/getvalueof windows %window%;\
	/if (value=~error) \
	   /let handle=$[tfopen(get_window_file(window),"a")]%;\
	   /addtolist windows %window %handle 0%;\
	   /let window_trigger_counter=0%;\
	   /test tfwrite(handle,strcat("Starting Log ",window,ftime("[%%x %%X]",time()))) %;\
	   /if (CFG_WINDOWS_SHOW_XTERM) \
	      /show_window %window%;\
	   /endif%;\
	/else \
	  /if (regmatch("(.+) (.+)",value)) \
	    /let handle=%P1%;\
	    /let window_trigger_counter=$[1+{P2}]%;\
	    /uaddtolist windows %window %handle %window_trigger_counter%;\
	  /endif%;\
	/endif%;\
	/if (handle>-1) \
	  /if ({3}=~"no_trig") \
	    /test tfwrite(handle,{2}) %;\
	  /else \
	    /def -p100000 -F %3 -t"%2" $[strcat("trig_",window,window_trigger_counter)] = /test tfwrite(%handle,{*}) %;\
	  /endif%;\
	/endif%;

/addh info \
Loescht alle Trigger fuer das angegeben Fenster und schliesst das zugehoerige File
/addh remove_window comm

/def remove_window = \
    /purge -mglob trig_%{1}*%;\
    /getvalueof windows %1%;\
    /if (value!~error) \
        /if (regmatch("(.+) (.+)",value)==1) \
;/echo >> %0: closing stream %P1%;\
	    /test tfclose({P1})%;\
	/endif%;\
	/deletekeyandvalue windows %1%;\
    /endif

/addh info \
Erzeugt den Hook um aller windows_timestamp_interval einen Zeitstempel in jedes Log zu schreiben
/addh see windows_stop_timestamps
/addh windows_run_timestamps mak

/def windows_run_timestamps = \
     /let timestamp_sec=$[CFG_WINDOWS_TIMESTAMP_INTERVAL*60]%;\
     /beat %timestamp_sec%;\
     /set do_beat_%timestamp_sec=1%;\
     /set windows_run_timestamps=1%;\
     /add_to_hook beat_%timestamp_sec /window_timestamps%;\

/addh info \
Setzt die Variable windows_run_timestamps auf 0
/addh windows_stop_timestamps mak

/def windows_stop_timestamps = \
     /set windows_run_timestamps=0%;\
     /let timestamp_sec=$[CFG_WINDOWS_TIMESTAMP_INTERVAL*60]%;\
     /remove_from_hook beat_%timestamp_sec /window_timestamps%;\

/addh info \
Funktion die an eine Beat-Hook gehaengt wird um Timestamps in alle Logs zu schreiben, das geschieht nur wenn man eine aktive world hat und die Variable windows_run_timestamps auf 1 steht.
/addh see windows_run_timestamps
/addh window_timestamps mak

/def window_timestamps = \
    /if (windows_run_timestamps & world_info("name")!~"") \
       /forEach windows kv /window_timestamps2%;\
    /endif%;

/def window_timestamps2 = \
	/test tfwrite({2},ftime("[%%X]",time())) %;


/def add_to_window_all = /test _add_to_window("all","*","-mglob")%;
/def move_to_window_all = /test _add_to_window("all","*","-mglob -ag")%;
/def redirect_all = \
	/move_to_window_all%;\
	/if (!ismacro("echo_save")) /def echo_save=${echo}%; /endif%;\
	/def echo=/test getopts("a:poerw:"),write_to_window("all",{*})%;\

/def stop_redirect = \
	/remove_window all%;\
	/def echo=${echo_save}%;


/addh_fileinfo

