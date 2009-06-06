; $Log: loading.tf,v $
; Revision 1.43  2002/12/06 15:33:54  mh14
; /custom und damit auch alles was laedt und speichert kennt jetzt \-g für gilde
;
; Revision 1.42  2002/12/03 03:46:34  mh14
; Sprachkonzept geändert, kein LANG mehr sondern user_lang (-L) und mud_lang (-l) neue mak_loc zu direkten Ersetzen von Strings in Makrobodies, /addh kennt jetz locales für verschiedene Hilfeversionen
;
; Revision 1.41  2002/09/28 00:51:12  mh14
; bug mit -a behoben
;
; Revision 1.40  2002/09/18 13:19:07  thufhnik
; is_file_loaded entbuggt
;
; Revision 1.39  2002/06/13 08:24:26  mh14
; bei -U kann jetzt der Text angegeben werden, der beim /configure der Paketauswahl angezeigt werden soll, damit entfallen die extra /cfg_info fuer die Paketauswahl
;
; Revision 1.38  2002/04/21 13:09:30  mh14
; doku -U -E
;
; Revision 1.37  2002/04/16 13:02:17  mh14
;  /custom erzeugt jetzt keine globalen Variablen mehr (grosse Fehlerursache), es nutzt /ret_vars aus util.tf, die Files wurden darauf angepasst
;
; Revision 1.36  2002/04/16 12:16:44  mh14
; ladereihenfolge *.cfg *.def vor *.tf -U und -E als Optionen von /mload, config system
;
; Revision 1.35  2002/03/27 01:36:41  mh14
; Aenderung Testsystem
;
; Revision 1.34  2002/02/13 14:38:03  mh14
; /custom -a bei bedarf / dranhaengen
;
; Revision 1.33  2002/02/13 14:11:34  mh14
; /custom nochmal umgestellt, mit der option -a[string] haengt es makdir oder string vor den pfad dran, ansonsten ist es wieder relativ
;
; Revision 1.32  2002/02/11 01:34:28  mh14
; bug bei /mload -m entfernt
;
; Revision 1.31  2002/02/09 15:21:00  mh14
; /custom haengt jetzt %makdir an %load_dir an, WICHTIG inkompatible aenderung! lists.tf updaten
;
; Revision 1.30  2002/01/11 14:15:46  mh14
; mload hat jetzt den Parameter -m fuer multiples laden von files z.B. /mload -m -c -dways *.tf
;
; Revision 1.29  2001/12/18 00:02:26  mh14
; requirre gesaeubert
;
; Revision 1.28  2001/10/29 18:32:27  nieten
; Hilfe zu /custom korrigiert
; "/addh hooks" in "/addh hook" korrigiert
;
; Revision 1.27  2001/10/25 13:20:24  mh14
;  doku mload wg. load_init_config
;
; Revision 1.26  2001/10/25 13:07:40  mh14
;  load_init_config fuer init Makros fuer TF-Files nach Laden in mload eingebaut
;
; Revision 1.25  2001/10/10 22:10:21  mh14
; Default-Konfiguration in .tf Files verschoben
;
; Revision 1.24  2001/10/03 09:40:16  mh14
; connection sachen in worldconnect.tf verschoben
;
; Revision 1.23  2001/10/02 00:09:06  mh14
;  bug in load_config entfernt (bei inner loads in den geladenen config-files
;
; Revision 1.22  2001/10/01 18:54:38  mh14
; bug in load_config entfernt
;
; Revision 1.21  2001/09/30 01:12:59  mh14
; load_config debuggt
; is_file_loaded hinzugefuegt, wird z.b. in user_connect genutzt
; connect hook um user_connect erweitert
; escapen des dateinamens in get_filename_file_info ausgelagert
;
; Revision 1.20  2001/09/27 21:20:06  nieten
; /file_info kommt nun auch mit Pfaden zurecht
;
; Revision 1.19  2001/09/25 21:21:39  mh14
; warning bei xx_connect_count raus, generelle Methode fuer Einfaerben von Text erfolgsabhaengig (siehe util.echo.tf) , diese in list_required eingebaut, /load_config zum Laden von Konfigurationsdateien
;
; Revision 1.18  2001/09/19 19:31:05  mh14
; dateinamen mit - jetzt mit mload moeglich
;
; Revision 1.17  2001/09/17 14:55:57  nieten
; /echo_file_info geaendert, damit /mload auch mit Pfadangaben funzt
;
; Revision 1.16  2001/09/17 10:46:24  mh14
;  *.i18n wird bei /mload mit geladen
;
; Revision 1.15  2001/09/15 19:48:36  mh14
;  custom um -d erweitert, histsize jetzt im çonnect hook
;
; Revision 1.14  2001/09/14 22:18:49  mh14
;  neue parameter (-vvarname, -l, -p) fuer custom und damit /mload,/loadlist,/savelist
;
; Revision 1.13  2001/09/12 22:25:40  mh14
; customize.cfg wird zusaetzlich geladen
;
; Revision 1.12  2001/09/09 19:06:22  mh14
; remove_cvs verschoben, bug in list_required
;
; Revision 1.11  2001/09/07 00:55:23  mh14
;  Versionscheck beim Laden
;
; Revision 1.10  2001/09/07 00:06:51  mh14
;  /load_config generell als /load_depend fuer zugeordnete Dateien
;
; Revision 1.9  2001/09/06 22:32:34  mh14
; etwas andere Fehlermeldung beim Laden
;
; Revision 1.8  2001/09/06 22:13:19  mh14
;  wieder ganz
;
; Revision 1.7  2001/09/06 22:02:31  mh14
; kuenstlicher Fehler
;
; Revision 1.6  2001/09/06 21:11:44  mh14
;  Log eingefuegt
;

/set loading_tf_version $Id$
/set loading_tf_author=Mesirii@mg.mud.de
/set loading_tf_requires lists.tf util.hooks.tf util.prompts.tf
/set loading_tf_desc /mload, /setos, Speichern und Laden von Variablen

; ********************* BEGIN CONFIG ********************
; in user_config.cfg setzen
;/set load_all_quiet=0

/cfg_info all loading Laden_von_Files
/cfg_info all loading SUFFIX Dateiendungen:file_suffixes

/set_var file_suffixes .tf .mak

/cfg_info all loading INFO Fileinfo_beim_Laden
/cfg_set all loading INFO 1

/ifdo CFG_ALL_LOADING_INFO \
/add_to_hook loaded /echo_file_info \%1

/if (TF_TEST_RUN) \
/add_to_hook loaded /add_to_hook run_test /load_depend %2 .test%;\
/endif

/ifdef CFG_ALL_LOADING_INFO user_echo_file_info = \
; Ausgabe CVS Informatione (Filename, Version, Autor)
	/ifecho file_info(fi_filename,"version")!~"" \
	-aCgreen $[remove_cvs(file_info(fi_filename,"version"))] ($[file_info(fi_filename,"author")])%;\
    /if (!load_quiet) \
; Ausgabe Inhalt
	/ifecho file_info(fi_filename,"version")!~"" \
	$[file_info(fi_filename,"desc")]%;\
; Ausgabe benoetigte Dateien
	/ifecho file_info(fi_filename,"requires")!~"" \
	-p Requires: $[list_required(fi_filename)]%;\
    /endif%;

; ********************* END CONFIG **********************

/addh info \
Dieser Hook wird vor dem Laden eines Files mit dem puren Dateinamen als Parameter ausgefuehrt.
/addh see /mload
/addh pre_load hook
/add_to_hook pre_load /set file_name=%1

/addh info \
Dieser Hook wird zum Neuladen aller geladenen Dateien ausgefuehrt, er wird von /mload mit den bisher geladenen Dateien gefuellt. Er enthaelt z. Zt. nur Aufrufe von /mload, kann aber durch andere Kommandos ergaenzt werden, die beim Neuladen der Files notwendig werden.
/addh see /mload
/addh reload hook

/addh info \
Wertet den '-c'-Parameter der Speicher- und Ladekommandos aus und gibt das entsprechende offset directory zurueck. Ggf. muss noch das Basis-Makro Directory davorgehaengt werden (bei Speicherkommandos).
/addh syn \
-m bedeutet multiple Files der Filename ist dann ein Pattern z.B. *.tf, es wird dann die Variable load_multi auf 1 gesetzt@{N}\
-a erzeugt absolute Pfade, dh. vor den offset wird noch %makdir gehaengt@{N}\
-c nimmt ${world_host} als Offset oder, wenn ${world_host} nicht gesetzt ist, dann %default_world_host.@{N}\
-cp nimmt ${world_host} als Offset oder, wenn ${world_host} nicht gesetzt ist, dann %default_world_host und als zweiten Offset ${world_character} bzw. %default_world_character.@{N}\
-coffset nimmt offset als Offset ,)
/addh opt \
-U wenn CFG_USE_FILE (z.b. CFG_USE_LOADING) existiert und 0 ist wird das File nicht geladen, sonst ja@{N}\
-Etf-expr wenn die TF-Expression true ist, wird das File geladen sonst nicht@{N}\
-p[char] Character@{N}\
-g[gilde] Gilde@{N}\
-c[host] Host (Mud)@{N}\
-l[lang] Mudsprache (Language)@{N}\
-L[lang] Nutzersprache (Language)@{N}\
-q quiet (ohne Meldungen)@{N}\
-vvarname Inhalt der Variablen (z.b. -vp_guild -> gildenbez.)@{N}\
-ddirname dirname uebernommen (z.b. -dnpcs -> npcs.)
/addh ex \
'-cmg.mud.de' liefert 'mg.mud.de/' als Offset fuer mudspezifische Dateien und@{N}\
'-c -p' liefert bei mir 'mg.mud.de/mesirii/'@{N}\
'-Ep_sub_guild=~"Abwehr" laedt das File nur wenn der Zaubererzweig "Abwehr" ist
/addh version 1.02
/addh custom mak
	
/def custom = \
     /test getopts("g:d:v:l:L:c:p:qma:E:U:",0)%;\
     /let load_dir=%;\
     /test load_dir:=strcat(load_dir,custom_opt(opt_l,map_locale(mud_lang)))%;\
     /test load_dir:=strcat(load_dir,custom_opt(opt_L,map_locale(user_lang)))%;\
     /test load_dir:=strcat(load_dir,custom_opt(opt_c,custom_opt_world("host")))%;\
     /test load_dir:=strcat(load_dir,custom_opt(opt_p,custom_opt_world("character")))%;\
     /test load_dir:=strcat(load_dir,custom_opt(opt_g,p_guild))%;\
     /test load_dir:=strcat(load_dir,custom_opt((opt_v=~"0")?0 :"",inner_var(2,"opt_v")))%;\
     /test load_dir:=strcat(load_dir,custom_opt(opt_d))%;\
     /let load_multi=%opt_m%;\
     /let load_do=1%;\
     /if (opt_E!~"0" & opt_E!~"") \
          /test load_do:=%opt_E%;\
     /endif%;\
     /test load_do:=load_do & custom_use(load_dir,{*})%;\
     /if (opt_a!~"0") \
        /let a_load_dir=%{opt_a-%makdir}%;\
	/if (a_load_dir!/"*/") /let a_load_dir=%a_load_dir/%; /endif%;\
	/let load_dir=%{a_load_dir}%load_dir%;\
     /endif%;\
     /let load_quiet=$[opt_q | load_all_quiet]%;\
     /let load_file=%*%;\
;/echo %load_dir %load_file%;\
     /return ret_vars('load_file','load_dir','load_quiet','load_do','load_multi')

/def custom_use = \
     /if (opt_U!~"0" & !opt_m) \
;     /if (!opt_m) \
         /let cfg_use_var=CFG_%;\
	 /let cfg_use_file=$[toupper(replace(".","_",{2}))]%;\
	 /if (cfg_use_file=/"*_TF") /let cfg_use_file=$[substr(cfg_use_file,0,-3)]%; /endif%;\
	 /let cfg_use_dir=$[toupper(replace(".","_",replace("/"," ",{1})))]%;\
	 /let cfg_use_var=CFG_USE_$[ (cfg_use_dir!~"") ? strcat(replace(" ","_",cfg_use_dir),"_") : ""]%{cfg_use_file}%;\
;         /let cfg_use_var=$[toupper(replace(".","_",replace("/","_",strcat("CFG_USE_",{1},{2}))))]%;\
; 	/if (opt_l!~"0") /let cfg_use_var=%{cfg_use_var}_LANG%; /endif%;\
; 	/if (opt_c!~"0") /let cfg_use_var=%{cfg_use_var}_MUD%; /endif%;\
; 	/if (opt_p!~"0") /let cfg_use_var=%{cfg_use_var}_PLAYER%; /endif%;\
;	/if (cfg_use_var=/"*_TF") /let cfg_use_var=$[substr(cfg_use_var,0,-3)]%; /endif%;\
;      /echo -aCmagenta dir: %cfg_use_dir file: %cfg_use_file all: %cfg_use_var%;\
      /if (opt_U!~"") \
          /cfg_info USE %cfg_use_dir %cfg_use_file %opt_U%;\
      /endif%;\
       /if (!isVar(cfg_use_var)) \
          /set %cfg_use_var=1%;\
	  /return 1%;\
       /else \
          /return %cfg_use_var%;\
       /endif%;\
     /endif%;\
     /return 1%;

/def custom_opt = \
     /let param=%{1}%;\
     /if (param!~"0") \
       /if (param=~"") \
	 /test param:={2}%; \
       /endif%;\
       /return strcat(param,"/")%;\
     /endif%;\
     /return ""%;

/def custom_opt_world = \
     /result (world_info({1})!~"")?world_info({1}):default_world_%1

/addh info \
Laedt ein Makrofile. Dabei kann die Endung '.tf' oder '.mak' weggelassen werden.@{N}\
Die geladenen Dateien werden im Hookmakro reload zum Neuladen gespeichert.\
Mit '/mload -c' werden die Dateien aus dem Verzeichnis ${world_host} geladen.@{N}\
Es wird der Hook loaded ausgefuehrt, der nach dem Laden eines Files mit dem Dateinamen (1), mit vollem Pfad(2) und mit den Ladeparametern(-2) ausgefuehrt wird. (z.B. /eval_hook loaded kampf.tf mg.mud.de/kampf/kampf.tf -c -dkampf)@{N}\
Wenn ein Makro dateiname_tf_init definiert ist, wird dieses nach dem Laden ausgefuehrt (load_init_config) um ggf. eine Initialisierung nach dem Fileladen zu ermoeglichen.
/addh opt \
-m bedeutet multiple Files der Filename ist dann ein Pattern z.B. *.tf, es wird pro File ein /mload aufgerufen@{N}\
/addh syn /mload [-q] [-p[directory]] [-c[directory]] -mfile[.tf|.mak]
/addh see re, purge, load, load_init_config, custom
/addh mak hook_reload, add_to_hook, eval_hook
/addh hook loaded, reload
/addh changes /custom wurde ausgegliedert.
/addh version 1.02
/addh mload comm

/def mload = \
	/let fullparam=%*%;\
 	/custom %*%;\
	/test %?%;\
	/let mload_file=%load_file%;\
	/let mload_base_file=%mload_file%;\
	/let off=$[strrchr(mload_base_file,".")]%;\
	/if (off>-1) \
	   /let mload_base_file=$[substr(mload_file,0,off)]%;\
	/endif%;\
	/if (!load_do) /return%; /endif%;\
	/if (load_multi) \
;	   /unset load_multi%;\
	   /let multi_files=$(/sys echo %load_dir%mload_file)%;\
;/echo %load_dir%mload_file%;\
	   /let multi_files=$[substr(multi_files,1)]%;\
;/let multi_files%;\
	   /if (multi_files=~strcat(load_dir,mload_file)) \
	     /break%;\
	   /endif%;\
	   /let off=$[strchr(multi_files," ")]%;\
	   /while (strlen(multi_files)>0) \
	      /if (off==-1) \
	        /load %multi_files%;\
		/let multi_files=%;\
	      /else \
		/load $[substr(multi_files,0,off)]%;\
		/let multi_files=$[substr(multi_files,off+1)]%;\
		/let off=$[strchr(multi_files," ")]%;\
	      /endif%;\
	   /done%;\
	   /break%;\
	/endif%;\
        /eval_hook pre_load %mload_file %fullparam%;\
	/echo /load %load_dir%mload_base_file.cfg%;\
	/load %load_dir%mload_base_file.cfg%;\
	/load %load_dir%mload_base_file.def%;\
	/try_load %{load_dir-.} %mload_file %file_suffixes%;\
	/test %?%;\
	/if (!{?}) \
	  /ifecho !load_quiet -aB Fehler: %load_dir%mload_file nicht gefunden!!%;\
	  /break%;\
        /endif%;\
	/add_to_hook reload /mload %fullparam%;\
	/load_init_config %mload_file%;\
	/load_depend %mload_fullfile .i18n%;\
;	/load_depend %mload_fullfile .def%;\
;	/load_depend %mload_fullfile .cfg%;\
	/eval_hook loaded %mload_file %mload_fullfile %fullparam%;\
	/addtolist loaded_files %mload_fullfile %fullparam%;\

/addh info \
fuehrt ein Initialisierungsmakro nach dem Laden des Files aus. Der Parameter ist der Dateiname, dieser wird wie bei den file_info Variablen als Praefix vor das _init gesetzt
/addh ex /load_init_config loading.tf -> aufruf von loading_tf_init wenn existent
/addh load_init_config mak

/def load_init_config = \
	/let init_name=$[strcat(get_filename_file_info({1}),"_init")]%;\
	/if (ismacro(init_name)) \
	   /eval -s0 /%init_name%;\
	/endif%;

/addh info laedt die beiden Konfigurationsdateien name.def und name.cfg aus dem ueber die Parameter spezifizierten Verzeichnis
/addh opt siehe /custom
/addh ex /load_config user_config
/addh load_config mak

/def load_config = \
 	/custom %*%;\
	/test %{?}%;\
	/let load_config_file=%load_file%;\
	/let off=$[strrchr(load_config_file,".")]%;\
	/if (off>-1) \
	   /let load_config_file=$[substr(load_config_file,0,off)]%;\
	/endif%;\
	/let load_config_load_dir=%{load_dir-.}%;\
	/try_load %load_config_load_dir %load_config_file.cfg%;\
	/test %?%;\
	/let load_config_echo=Load Config: $[format_success_text((!{?})?"warning":"success",strcat(load_config_load_dir,load_config_file,".cfg"))]%;\
	/try_load %load_config_load_dir %load_config_file.def%;\
	/test %?%;\
	/let load_config_echo=$[strcat(load_config_echo," ",\
	     format_success_text((!{?})?"warning":"success",\
	     strcat(load_config_load_dir,load_config_file,".def")))]%;\
	/ifecho !load_quiet -p %load_config_echo

/addh info \
Laedt abhaengige Dateien fuer die, mit vollem Pfad uebergebene, Makrodatei. Dabei enthaelt dateiname.def die Standardeinstellungen und sollte nicht vom Benutzer veraendert werden, dazu ist die Kopie namens dateiname.cfg da. Bei einer Neuinstallation wird dateiname.def ueberschrieben, damit dort auch aktuelle Aenderungen (z. B. neue Konfigurationsparameter) zum Tragen kommen. In Dateiname.test kann eine Testdatei stehen.
/addh syn /load_depend voller_dateiname
/addh ex /load_depend loading.tf
/addh load_depend mak

/def load_depend = \
	/let param=%1%;\
	/let pos=$[strrchr(param,".")]%;\
	/if (pos>-1) \
	   /test param:=substr(param,0,pos)%;\
	   /load -q %{param}%2%;\
	/endif%;

/addh info \
Wird von /mload benutzt, um eine Datei mit verschiedenen Dateiendungen zu laden. Standardmaessig stehen die Dateiendungen in der Variablen 'file_suffixes'. Wenn das Verzeichnis nicht gegeben ist (also tf suchen soll), dann statt des Verzeichnisses einen Punkt (.) uebergeben.
/addh file_suffixes var
/addh syn /try_load (dir|.) file possible_suffix_list
/addh ex /try_load ~/makros loading .tf .mak
/addh try_load mak

/def try_load = \
     /if ({1}!~".") /let tl_base=%1%; /else /let tl_base=%; /endif%;\
     /let tl_file=%2%;\
     /let tl_suff=%;\
     /shift 2%;\
     /load -q %{tl_base}%{tl_file}%;\
     /let load_res=%?%;\
     /while (!load_res & {#}>0) \
	/let tl_suff=%1%;\
	/shift%;\
        /load -q %{tl_base}%{tl_file}%{tl_suff}%;\
        /let load_res=%?%;\
     /done%;\
     /if (load_res) \
       /let mload_fullfile=$[strcat(tl_base,tl_file,tl_suff)]%;\
       /let mload_file=$[strcat(tl_file,tl_suff)]%;\
       /return ret_vars('mload_fullfile','mload_file')%;\
     /else \
       /return 0%;\
     /endif

/addh info \
Liefert die Informationen in den Dateivariablen dateiname_suffix_name.
/addh ex /test file_info("loading_tf","version")
/addh file_info func

/def file_info = \
	/let efi_pos=$[strrchr({1},"/\\")+1]%;\
	/if (efi_pos==0) \
	    /let fi_filename=%1%;\
	/else \
	    /let fi_filename=$[substr({1},{efi_pos})]%;\
	/endif%;\
	/result %{fi_filename}_%2


/addh info \
Entfernt die Zusatztexte vom CVS von den Id Informationen. 
/addh syn /remove_cvs Text von Id
/addh remove_cvs mak

/def remove_cvs = \
    /if (regmatch(strcat("\\$I","d: (.+) Exp \\$"),{*})) \
	/return strcat({PL},{P1},{PR})%;\
    /else \
	/return {*}%;\
    /endif%;


/addh info wandelt den uebergebenen Dateinamen in eine Form um, die fuer die Dateiinfo Variablen (z.B. filename_version) nutzbar ist, dabei werden z.b. [.-] in Unterstriche _ umgewandelt und nur der Dateiname ohne Pfad genutzt
/addh see user_echo_file_info, echo_file_info, is_file_loaded
/addh get_filename_file_info

/def get_filename_file_info =\
; evtl. vorhandene Pfadangabe abhacken und nur Filenamen nehmen
	/let efi_pos=$[strrchr({1},"/\\")+1]%;\
	/if (efi_pos==0) \
	    /let fi_filename=%1%;\
	/else \
	    /let fi_filename=$[substr({1},{efi_pos})]%;\
	/endif%;\
	/test fi_filename:=replace(".","_",fi_filename)%;\
	/test fi_filename:=replace("-","_",fi_filename)%;\
	/return fi_filename%;

/addh info \
Sofern 'load_quiet' nicht gesetzt ist, werden per /user_echo_file_info die Dateiinformationen der Dateivariablen ausgegeben.
/addh var lokal fi_filename, fi_file
/addh cfg /user_echo_file_info
/addh echo_file_info mak
/def echo_file_info=\
	/let fi_filename=$[get_filename_file_info({1})]%;\
	/user_echo_file_info%;

/addh info \
testet ob das angegebene File schon geladen ist, dabei wird auf die Existenz der filename_version Variablen geprueft
/addh is_file_loaded mak

/def is_file_loaded = \
	/let is_file_loaded_tmp=$[replace('"','',${hook_reload})]%;\
	/return (file_info(get_filename_file_info({1}),"version")!~"") | \
	(_loaded_libs=/"*%1*") | is_file_loaded_tmp=/"*%1*"%;

/addh info \
Parst die Liste der benoetigten Files und zeigt farbig an, welche davon schon geladen sind, dabei unterschieden zwischen unbedingt notwendigen Dateien und spaeter benoetigten Dateien.@{N}\
In der Dateivariablen 'filename_tf_requires' stehen die benoetigten Dateien, dabei sind die unbedingt notwenigen mit einem ! als Praefix markiert.
/addh cfg siehe \$(/listvar -s format_attr_*)
/addh var fi_filename
/addh list_required func

/def list_required = \
	/let tmp=$[file_info(fi_filename,"requires")]%;\
	/test ctokenize(" ",tmp)%;\
	/let i=0%;\
	/let tmp=%;\
	/let required_file=%;\
	/while (++i<=T0) \
	   /test required_file:=replace(".","_",\{T%{i}\})%;\
	   /let must_have=0%;\
	   /if (required_file=/"!*") \
	      /test required_file:=substr(required_file,1)%;\
	      /let must_have=1%;\
	   /endif%;\
; Versionsbestimmung
	   /if (regmatch("(.+) *[(]([0-9]+)(_([0-9]+))?[)]$",required_file)) \
	      /let required_version_number=$[+{P2}*1000+{P4}]%;\
	      /test required_file:={P1}%;\
	   /else /let required_version_number=0%;\
	   /endif%;\
;,v 1.10
	   /let required_info=$[file_info(required_file,"version")]%;\
	   /if (regmatch(",v ([0-9]+)([.]([0-9]+))?",required_info))\
	     /let required_info_version=$[+{P1}*1000+{P3}]%;\
	   /else /let required_info_version=0%;\
	   /endif%;\
	   /if (required_info!~"") \
	      /let required_succ=success%;\
	      /if (required_info_version<required_version_number) \
	        /let required_succ=fatal%;\
	      /endif%;\
	   /else \
	      /let required_succ=$[must_have?"failure":"warning"]%;\
	   /endif%;\
	   /test tmp:=strcat(tmp,format_success_text(required_succ,\{T%{i}\})," ")%;\
	/done%;\
	/result tmp
    

/addh info \
Laedt alle Makrodateien neu, ohne vorher den Speicher zu loeschen.
/addh mak eval_hook
/addh reload comm
/def reload = /eval_hook reload

/addh info \
Loescht den Speicher und laedt alle mit bisher geladenen Makrofiles neu.@{N}\
Alle Variablen werden auch abgespeichert und neu geladen.
/addh mak hook_reload, eval_hook
/addh see mload, purge, load
/addh purge_reload comm

/def purge_reload = \
	/saveall %;\
	/let reload=${hook_reload}%;\
	/let mload=${mload}%;\
	/purge%; \
	/def mload = %mload%;\
	/def hook_reload = %reload%;\
	/eval_hook %reload %;\
	/loadsaved %;

/addh info \
Das Dateisystem beruht auf den Properties eines Spielers.\
@{N}Es gibt Dateien, die vom Mud und Spieler (in gewissen Grenzen) unabhaengig sind:\
@{N}?loading.tf, ?help.tf, ?lists.tf, ?untroom.tf, ?way.tf, ?properties.tf\
@{N}Die Datei ${world_host}/${world_character}.tf (z.B.) mg.mud.de/mesirii.tf ist vom Mud abhaengig und wird beim Connect vom tf entsprechend geladen. Ausserdem wird aus diesem Directory auch die ?customize.tf geladen, die viele Einstellungen enthaelt.@{N}\
Zu den Dateien bitte die dortigen Hilfeseiten anschauen. Und jetzt viel Spass.
/addh see loading.tf, help.tf, lists.tf, untroom.tf, way.tf, properties.tf, customize.tf, mesirii.tf, chaos.tf, ueben.tf
/addh changes 1.01 In den Hook Kommandos wurden Ueberpruefungen eingebaut, ob die Hooks schon existieren.@{N}\
	/mload ruft jetzt den Hook pre_load vor dem Laden eines Files und loaded nach dem Laden eines Files auf.@{N}\
	1.02 Das Laden von -c (=custom) Dateien wurde aus /mload ausgelagert, so dass alle Funktionen es nutzen koennen (siehe /custom).@{N}\
	1.04 /custom wurde um die Moeglichkeit ergaenzt, -cp als einzigen Parameter zum Laden anzugeben; damit wird and das Mudverzeichnis noch ein Playerverzeichnis zum Laden drangehaengt.@{N}\
	     Fehler in myconn (CONNECT) behoben, der mehrfaches Laden der Files zur Folge hatte.
/addh_fileinfo











