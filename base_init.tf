; $Log: base_init.tf,v $
; Revision 1.20  2002/12/06 16:17:11  mh14
; maplocale debuggt
;
; Revision 1.19  2002/12/05 11:01:43  mh14
; map_locale
;
; Revision 1.18  2002/12/03 03:45:36  mh14
; Sprachkonzept geändert, kein LANG mehr sondern user_lang (-L) und mud_lang (-l) neue mak_loc zu direkten Ersetzen von Strings in Makrobodies, /addh kennt jetz locales für verschiedene Hilfeversionen
;
; Revision 1.17  2002/12/03 00:57:15  mh14
; LANG ist jetzt user_lang im Configfile, wird in i18n.tf beachtet, TODO generelles Sprachkonzept
;
; Revision 1.16  2002/09/17 12:59:44  nieten
; redef-Gescrolle reduziert
;
; Revision 1.15  2002/08/26 20:01:49  mh14
; /set_var debuggt
;
; Revision 1.14  2002/04/16 12:12:24  mh14
; configreihenfolge umgestellt, ein paar hilfsmakros vorgezogen
;
; Revision 1.13  2002/04/08 12:15:42  nieten
; /deprecated wird (ohne Funktionalitaet) definiert
;
; Revision 1.12  2002/03/27 01:32:27  mh14
; Aenderung Testsystem
;
; Revision 1.11  2001/12/08 17:31:59  mh14
; max_recur max_iter runtergesetzt, have_ext etwas umgestellt
;
; Revision 1.10  2001/11/28 14:43:47  mh14
; makdir endet mit /
;
; Revision 1.9  2001/11/28 10:58:39  mh14
; have_ext zum checken von Patches
;
; Revision 1.8  2001/11/27 13:46:46  mh14
; makdir endet jetzt immer auf /
;
; Revision 1.7  2001/11/05 15:25:02  nieten
; %tmp war globale Variable
;
; Revision 1.6  2001/10/29 18:33:15  nieten
; /set_makdir nimmt bei fehlendem Argument das aktuelle Verzeichnis
; /set_makdir loescht den alten Wert von TFPATH nicht, sondern erweitert ihn
;
; Revision 1.5  2001/10/10 22:10:21  mh14
; Default-Konfiguration in .tf Files verschoben
;
; Revision 1.4  2001/09/24 20:48:52  mh14
; automatisches feststellen des startverzeichnisses, kein makdir mehr zu setzen
;
; Revision 1.3  2001/09/22 13:36:53  mh14
; einfache einbindung der Pakete
;
; Revision 1.2  2001/09/06 21:11:44  mh14
;  Log eingefuegt
;

/set load_time=
/test load_time:=time()

/def set_makdir = \
    /if ({#} == 0 | {1} =~ "") \
        /let tmp=$(/pwd)%;\
    /else \
        /if ({*}=/"*base_init.tf") \
            /let tmp=$[substr({*},0,strlen({*})-strlen("base_init_tf"))]%;\
	/endif%;\
    /endif%;\
    /set makdir=%{USE_MAKDIR-%tmp}%;\
    /if (makdir !/ "*/") /set makdir=%makdir/%; /endif%;\
    /test TFPATH:=strcat(TFLIBDIR," ",TFPATH," ",makdir)%;

/test set_makdir({*})


/def init_base_system=\
    /if (!base_system_inited) \
        /set base_system_inited=1%;\
	/set tosave=<I>%;\
	/set loaded_files=<I>%;\
	/set lists=<I>%;\
	/set hlists=<I>%;\
	/set max_recur=10000%;\
	/set max_iter=10000%;\
	/set value=%;\
	/set error=2147483646%;\
	/if (user_lang=~"") /set user_lang=$[map_locale(LANG)]%;/endif%;\
	/echo -aCyellow Sprache: %user_lang%;\
	/def addsave%;\
	/def deprecated%;\
    /endif%;

/def -hREDEF -ag -F h_redef = /test 0
/def -hLOADFAIL -F -ag h_loadfail = /test 0
/def -hCONFLICT -ag -F h_conflict = /test 0

; wenn keine Hilfegenerierung noetig ist ;)
/if (!build_help) \
    /def addh = /test 0%;\
    /def addh_fileinfo = /test 0%;\
    /def addh_en = /test 0%;\
    /def addh_en_fileinfo = /test 0%;\
    /def defh=/@def \%*%;\
/endif%;

/set init_locale_de=de de_DE german deutsch de_AU
/set init_locale_en=en en_US en_EN english englisch C

/def map_locale = \
     /let param=$[tolower({1})]%;\
     /if (param=/"*_*") /let param=$[substr(param,0,strchr(param,"_"))]%; /endif%;\
     /let map_locale=%;\
     /listvar -s init_locale_* *%{param}*%| /test tfread(map_locale)%;\
     /result (map_locale!~"") ? substr(map_locale,12) : param

/def have_ext = \
        /if (!tf_ext) \
	/let have_ext=$(/version)%;\
	/let off=$[strstr(have_ext,"% Extensions: ")]%;\
	/if (off==-1) \
	   /set tf_ext=-1%;\
	   /result 0%; \
	/endif%;\
	/set tf_ext=1%;\
	/test have_ext:=substr(have_ext,off+strlen("% Extensions: "))%;\
	/let off=$[strchr(have_ext,"% ")]%;\
	/while (have_ext!/"%*" & off>-1) \
	   /let tf_akt_ext=$[substr(have_ext,0,off)]%;\
	   /set tf_ext_%{tf_akt_ext}=1%;\
	   /test have_ext:=substr(have_ext,off+1)%;\
	   /let off=$[strchr(have_ext,"% ")]%;\
	/done%;\
	/result (tf_ext_%1==1)%;\
	/else \
	  /result (tf_ext_%1==1)%;\
	/endif%;\

/def set_var = \
     /if ({*}=/"*=*") \
        /let set_var=$[substr({*},0,strchr({*},'='))]%;\
	/set %set_var%|\
	/let do_set=%?%;\
     /else \
	/set %1%|\
	/let do_set=%?%;\
     /endif%;\
     /if (!{do_set}) \
        /set %*%;\
     /endif%;

/def ifdo = \
     /if /test %{1}%; /then /eval %-1%; /endif

/def add_to_hook =\
     /if (!(ismacro(strcat("hook_",{1})))) /def hook_%1%; /endif%;\
     /if (strstr(${hook_%1},{-1})==-1) /def hook_%1=$[strcat(${hook_%1},{-1},(substr({-1},strlen({-1})-2))!~"%;"?"%;":"")] %; /endif%;

/load -q user_config.cfg
/load -q user_config.def

/init_base_system

/load -q base_files.def
/load -q base_files.cfg

/if (TF_TEST_RUN) \
/run_tests%;\
/endif%;\

