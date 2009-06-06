; $Log: help.tf,v $
; Revision 1.30  2002/12/05 10:34:33  mh14
; bug wenn help_tips.ary nicht da ist rausgemacht
;
; Revision 1.29  2002/12/03 04:16:03  mh14
; keywordfilewarnung
;
; Revision 1.28  2002/12/03 03:45:36  mh14
; Sprachkonzept geändert, kein LANG mehr sondern user_lang (-L) und mud_lang (-l) neue mak_loc zu direkten Ersetzen von Strings in Makrobodies, /addh kennt jetz locales für verschiedene Hilfeversionen
;
; Revision 1.27  2002/09/06 12:10:12  nieten
; /create_help und zugehoerige Hilfsmakros hinzugefuegt. Die (komplette) Hilfe
; kann nun auch offline ohne eigentliches Laden der Files erzeugt werden.
;
; Revision 1.26  2002/09/06 12:00:18  nieten
; keine doppelten Eintraege mehr mehr, stattdessen Aktualisierung
;
; Revision 1.25  2002/08/26 11:41:39  mh14
; make_help debuggt
;
; Revision 1.24  2002/06/13 08:20:24  mh14
; Hilfe wird jetzt nach dem generieren (auch beim Laden) gespeichert, wenn keine Hilfegenerierung eingeschaltet ist, wird die Liste geladen
;
; Revision 1.23  2002/04/23 13:18:23  nieten
; - kleine Aenderung in /help_show_tips
; - kleine Aenderungen in der Doku
;
; Revision 1.22  2002/04/21 13:09:57  mh14
; hilfegenerierung einstellbar
;
; Revision 1.21  2002/04/18 22:35:59  mh14
; bug raus in /addh
;
; Revision 1.20  2002/04/18 21:59:04  mh14
; dynamische hilfegenerierung beim laden, hashliste fuer hilfe
;
; Revision 1.19  2002/04/16 12:14:09  mh14
; config update, einige Feinheiten kosmetischer Natur
;
; Revision 1.18  2002/04/01 19:08:00  mh14
; addh,make_help optimiert (halbe zeit), help_show_tips debuggt
;
; Revision 1.17  2002/03/27 23:37:08  mh14
; help_show_tips, zeigt Tips aus LANG/help_tips.ary an
;
; Revision 1.16  2001/12/14 00:57:32  nieten
; "/hilfe %<variablenname>" geht jetzt auch
;
; Revision 1.15  2001/12/05 14:07:52  nieten
; Hilfe zu help.tf korrigiert
;
; Revision 1.14  2001/10/31 20:49:00  nieten
; requires korrigiert
;
; Revision 1.13  2001/10/31 17:30:11  nieten
; Hilfe zu /addh korrigiert
;
; Revision 1.12  2001/10/22 15:39:53  nieten
; Hilfe zu /addh etwas ergaenzt, Source formatiert
;
; Revision 1.11  2001/10/10 22:10:21  mh14
; Default-Konfiguration in .tf Files verschoben
;
; Revision 1.10  2001/09/26 12:12:06  nieten
; /make_help gibt "Fertig"-Meldung aus
;
; Revision 1.9  2001/09/14 22:30:07  mh14
; Indexseite aller Makros bei HTML-Hilfe Generierung
;
; Revision 1.8  2001/09/11 23:49:30  mh14
; 2 neue Hilfeparameter
; opt: Optionen
; param: Parameter
;
; Revision 1.7  2001/09/10 18:29:51  mh14
; slash bug entfernt
;
; Revision 1.6  2001/09/09 22:29:40  mh14
;  Hilfegenerierung/HTML
;
; Revision 1.5  2001/09/09 19:05:44  mh14
; fuer File Eintrag reicht ein /addh_fileinfo
;
; Revision 1.4  2001/09/06 22:22:45  nieten
; Hilfetexte ueberarbeitet.
;
; Revision 1.3  2001/09/06 21:11:44  mh14
;  Log eingefuegt
;

/set help_tf_version $Id$
/set help_tf_author=Mesirii@mg.mud.de
/set help_tf_requires=!lists.tf(1.28) util.sfunc.tf util.echo.tf util.hooks.tf
/set help_tf_desc=Hilfesystem mit Hilfegenerierung (Listen+Html)

; ********************* BEGIN CONFIG ********************
/set html_expert_dir=help/expert
/set html_global_dir=help/global


/addh info Flag fuer Help Tips
/addh CFG_HELP_SHOW_TIPS cfg
/addh dtype flag
/set_var CFG_HELP_SHOW_TIPS 1

/cfg_info help SHOW_TIPS Laufzeilentips

/ifdo CFG_HELP_SHOW_TIPS /add_to_hook user_got_idle /help_show_tips

/addh info \
Flag, das das dynamische Aufbauen der Hilfe beim Laden von Files ein- und ausschaltet.
/addh en info Flag which switches the dynamic generation when loading files.
/addh dtype flag
/addh CFG_HELP_BUILD cfg

/set_var CFG_HELP_BUILD 1

/cfg_info help BUILD Hilfe_beim_Laden_erzeugen

/ifdo CFG_HELP_BUILD /add_to_hook pre_load /help_pre_load \%1
/ifdo !CFG_HELP_BUILD /hloadlist -L help

; ********************* END CONFIG **********************

/loadlist -q -L help_keywords

/def make_help_keywords = \
/createlist help_keywords%;\
/addtolist help_keywords info 0 Info:%;\
/addtolist help_keywords syn 1 Syntax:%;\
/addtolist help_keywords opt 1 Optionen:%;\
/addtolist help_keywords param 1 Parameter:%;\
/addtolist help_keywords misc 0 Sonstiges:%;\
/addtolist help_keywords adapt 1 Anpassen an Mud:%;\
/addtolist help_keywords ex 0 Beispiel:%;\
/addtolist help_keywords tut 0 Einfuehrung:%;\
/addtolist help_keywords return 1 Rueckgabewert:%;\
/addtolist help_keywords see 0 Siehe auch:%;\
/addtolist help_keywords comm 0 Kommandos:%;\
/addtolist help_keywords mak 1 Makros:%;\
/addtolist help_keywords hook 1 Hooks:%;\
/addtolist help_keywords trig 1 Trigger:%;\
/addtolist help_keywords over 1 TF-Befehle:%;\
/addtolist help_keywords func 1 TF-Funktionen:%;\
/addtolist help_keywords req 0 Benoetigt:%;\
/addtolist help_keywords var 1 Variablen:%;\
/addtolist help_keywords list 1 Listen:%;\
/addtolist help_keywords fileinfo 0 Datei:%;\
/addtolist help_keywords version 1 Version:%;\
/addtolist help_keywords changes 0 Aenderungen:%;\
/addtolist help_keywords type 2 Typ:%;\
/addtolist help_keywords dtype 2 Datentyp:%;\
/addtolist help_keywords update 2 Updatemakro:


/test add_loc("Keywords nicht gefunden, sie werden temporär erzeugt!","de","help-keyword file not found, they are temporarily created","en")

/ifdo (isKey("help_keywords","info")=~error) /echo -aCred $(/loc de Keywords nicht gefunden, sie werden temporär erzeugt!)%;/make_help_keywords

/set help_tips_loaded=0

/def dont_make_help = /set build_help=0


/addh info \
Wenn Idle werden Tips aus der Datei lang/help_tips.ary auf der Statuszeile angezeigt. Wird vom Hook user_got_idle aufgerufen!
/addh see /lauf, arrays, CFG_CONNECT_IDLE_TIME, user_got_idle
/addh help_show_tips mak

/def help_show_tips = \
    /if (!CFG_HELP_SHOW_TIPS | idle()<CFG_CONNECT_IDLE_TIME | help_tips_loaded==-1) \
        /return%;\
    /endif%;\
    /if (help_tips_loaded==0) \
        /loadarray -L help_tips%;\
	/if (!{?}) \
	    /set help_tips_loaded=-1%;\
	    /return%;\
	/endif%;\
        /set help_tips_loaded=1%;\
    /endif%;\
    /if (alen("help_tips")>0) \
        /lauf $[aget("help_tips", rand(alen("help_tips")+1))]%;\
        /repeat -%? 1 /help_show_tips%;\
    /endif


/def create_help_list =\
     /set help_list_%1=
;    /createlist help_list_%1

/addh info \
Wird von /mload beim Laden eines Files aufgerufen. Es werden die Variable 'file_name' gesetzt und
/addh make_help comm

/defh make_help = \
    /set build_help=1%;\
    /set help_time=$[time()]%;\
    /unset help_files%;\
    /hcreatelist help%;\
    /add_to_hook pre_load /purge_vars help_list_*%;\
    /echo Before Reload! $[time()-help_time] sek%;\
    /reload%;\
    /echo Done Creating Help! $[time()-help_time] sek%;\
    /save_help%;\
    /dont_make_help%;\
    /set build_help=0%;\
    /echo Hilfe-Files erzeugt.

/def save_help = \
    /hsavelist -L help

/def help_pre_load = \
    /purge_vars help_list_*%;\
    /if (help_files!/strcat("*{",{1},"}*")) \
;       /echo Generating Help for %1%;\
	/set help_files=%help_files %1%;\
	/set build_help=1%;\
	/createlist addh_sublist%;\
    /else \
        /set build_help=0%;\
    /endif%;


/def addh_html = \
    /let param=%L1%;\
    /if (isKey("help_keywords",param) !~ error) \
        /echo -e Entry %{-L1}%;\
	/test haddtolist("html_all_makros",{-L1},make_html_file_name)%;\
	/hilfe_html %{html_full}%{-L1}%;\
    /endif%;

/def addh_fileinfo_html = \
    /hilfe_html %file_name%;


/defh make_html_file2 = \
    /if ({1}=~"+") \
	/set html_full=+%; \
	/set html_dir=%html_expert_dir%;\
    /else \
	/set html_full=%; \
	/set html_dir=%html_global_dir%;\
    /endif%;\
    /let param2=%-1%;\
    /let make_html_file_name=%L1%;\
    /echo -e Working On File: %make_html_file_name%;\
    /let file_handle=$[tfopen(strcat(html_dir,"/",make_html_file_name,".html"),"w")]%;\
    /test tfflush(file_handle,1)%;\
    /test tfwrite(file_handle,"<html><head><title>")%;\
    /test tfwrite(file_handle,make_html_file_name)%;\
    /test tfwrite(file_handle,"</title></head><body>")%;\
    /let res=<a name=\"top\"></a>%;\
    /test tfwrite(file_handle,res)%;\
    /let res=$(/hilfe_html %{html_full}%make_html_file_name)%;\
    /test tfwrite(file_handle,res)%;\
    /let res=%;\
    /test tfwrite(file_handle,"-------------------------<br>")%;\
    /set build_help=1%;\
    /def addh_fileinfo=${addh_fileinfo_html}%;\
    /if (user_lang=~"de") \
        /def addh = /addh_html \%*%;\
    /elseif (user_lang=~"en") \
        /def addh_en = /addh_html \%*%;\
    /endif%;\
    /let res=$(/mload %param2)%;\
    /if (mload_body!~"") \
        /def mload=%mload_body%;\
    /endif%;\
    /test tfwrite(file_handle,res) %;\
    /test tfwrite(file_handle,strcat('<br>This file was created using TinyFugue (c) 1998 by <a href="http:////tf.tcp.com/~hawkeye/">Ken Keys</a> at ',ftime("%c",time()),' by Michael Hunger <a href="mailto:mh14@inf.tu-dresden.de">(mh14@inf.tu-dresden.de)</a>.<br>')) %;\
    /test tfwrite(file_handle,"</body></html>") %;\
    /test tfclose(file_handle)%;

/def addh_fileinfo_html = \
    /set mload_body=${mload}%;\
    /def mload%;


/addh info \
Enthaelt die moeglichen Schluesselworte fuer die Hilfebefehle.
/addh ex mak(key) 1 Makros:(value, 0|1|2 Detailstufe, Ueberschrift)
/addh help_keywords list


/addh info \
Ermoeglicht es, neue Eintraege in das Hilfesystem einzufuegen. Dazu werden zuerst die gewuenschten Rubriken gefuellt und danach alle in die Hilfe eingetragen. Bei den Texten koennen alle von /echo -p bekannten Formatierungen benutzt werden und ausserdem noch @@@{}{N} fuer Zeilenumbrueche.@{N}\
Die erlaubten Schluesselworte stehen in %help_keywords.@{N}\
Ein aelterer Eintrag zum gleichen Stichwort wird ggf. ueberschrieben.@{N}\
(Mit @@{} am Zeilenanfang koennen uebrigens fuehrende Leerzeichen erzeugt werden.)
/addh en info Adds new entries to the help system, for this first each category is set and the the helplist is filled. Within the help text all attributes known to tf can be used as well as @@@{}{N} for linefeeds.@{N}\
The allowed keywords can by found in /showlist help_keywords.@{N}\
Previous entries of the same category are overwritten. Using @@{} at the beginning of the line allows leading whitespaces.
/addh syn /addh [locale->en|de]info|syn|var|list|return|mak|comm|ex|see|dtype Text mit Formatierungen@{N}\
und zum Schluss: /addh eintrag
/addh list help, helpindex, addh_sublist, help_keywords
/addh see /help, /echo, /echo2
/addh addh mak


/def addh = \
    /if (!build_help) /return%; /endif%;\
    /let help_locale=de%;\
    /if (is_locale({1})) \
       /if (user_lang!~{1}) /return%; /endif%;\
       /shift%;\
    /endif%;\
    /let key=$[tolower({1})]%;\
    /if (is_help_keyword(key)) \
	 /set addh_key_%key=%key %-1%;\
    /else \
	/let key2=$[tolower({L1})]%;\
	/if (!is_help_keyword(key2)) \
	    /let key2=misc%;\
	    /let key=$[tolower({*})]%;\
	/else \
	    /let key=$[tolower({-L1})] %;\
	/endif%;\
	/createlist addh_sublist%;\
	/addtolist addh_sublist type %key2%;\
	/quote -S /addtolist addh_sublist `/listvar -v addh_key_*%;\
	/init_var help_list_%key2%;\
	/test help_list_%key2:=strcat(help_list_%key2,", ",key)%;\
;	/test help_list_%key2:=strcat(help_list_%key2,", ",key)%;\
	/addtolist addh_sublist fileinfo %file_name%;\
        /test hdeletekeyandvalue('help', key)%;\
	/test haddlisttolist('help',key,addh_sublist)%;\
	/purge_vars addh_key_*%;\
    /endif%;


/set help_keywords_list=

/def is_help_keyword = \
    /if (help_keywords_list=~"") \
        /set help_keywords_list=.%;\
        /foreach help_keywords k /is_help_keyword_add%;\
    /endif%;\
      /return strstr(help_keywords_list, ".%1." )>-1%;\

/def is_help_keyword_add = \
    /set help_keywords_list=%help_keywords_list%1.


/addh info \
Fuegt die in dieser Makrodatei erstellten Kommandos und Makros in den Hilfeeintrag fuer die Datei ein und schliesst diesen Hilfeeintrag ab.
/addh var %fi_list, %file_name
/addh mak /forEach, /addh, /fi_add
/addh list file_comm, file_mak
/addh addh_fileinfo mak

/def addh_fileinfo = \
     /if (!build_help) /return%; /endif%;\
;    /forEach help_keywords k /fi_add0%;\
    /quote -S /fi_add0 `/listvar -s help_list_*%;\
    /let fi_filename=$[replace(".","_",file_name)]%;\
    /addh version $[remove_cvs(file_info(fi_filename,"version"))] \
        ($[file_info(fi_filename,"author")])%;\
    /addh req $[file_info(fi_filename,"requires")]%;\
;    /if (isKey("addh_sublist","info")=~error) \
    /if (addh_key_info=~"") \
	/addh info $[file_info(fi_filename,"desc")]%;\
    /endif%;\
    /addh %file_name fileinfo%;\
    /unset fi_list%;\
    /addh_filelist %file_name%;\
    /save_help

/def addh_filelist = \
     /hgetlistvalueof help tf-macros%;\
     /set addh_allfiles=%?%;\
     /if (addh_allfiles!~error) \
        /getdvalueof addh_allfiles fileinfo%;\
	/let addh_file=%?%;\
	/if (addh_file=~error) /let addh_file=%1%;\
	/elseif (addh_file!/ strcat("*{",{1},"}*")) \
	   /let addh_file=%addh_file, %1%;\
	/endif%;\
	/addtolist addh_allfiles fileinfo %addh_file%;\
	/hdeletekeyandvalue help tf-macros%;\
	/haddlisttolist help tf-macros %addh_allfiles%;\
     /endif%;\
     /unset addh_allfiles

/addh info \
Hilfsmakro, das die einzelnen Teillisten oder Subtopics eines Eintrags in die Hilfeliste schreibt.
/addh var %temp_list, %fi_list, %help_list, %help_keywords
/addh mak /forEach, /addh, f/i_add
/addh fi_add0 mak

/def fi_add0 = \
    /set fi_list=%;\
    /eval /set temp_list=\%help_list_%1%;\
    /if (temp_list!~"<I>") \
        /forEach temp_list k /fi_add%;\
	/addh %1 $[substr(fi_list,2)]%;\
    /endif%;

/def fi_add0 = \
    /if /test help_list_%1!~""%; /then \
        /test addh({1},substr(help_list_%1,2))%;\
    /endif%;

/def fi_add0 = \
    /test addh(substr({1},10),substr(%1,2))

/set href0=<a href="
/set href1=">
/set href2=</a>


/addh info \
Haengt Parameter an Variable %fi_list an.
/addh var %fi_list
/addh fi_add mak

/def fi_add =\
    /set fi_list=$[strcat(fi_list,", ",{*})]%;


/addh info \
Erzeugt Makros, die mit den Parametern '-h' und '-?' ihren entsprechenden Hilfetext darstellen. Das sollten @{B}alle interaktiven Makros@{n} sein.
/addh see /def, /help
/addh defh mak

/def defh = \
    /let param=%*%;\
    /let off=$[strstr(param,"=")]%;\
    /let part1=$[substr(param,0,off)]%;\
    /let part2=$[substr(param,off+1)]%;\
    /if (substr(part2,strlen(part2)-2)!~"%;")\
	/let part2=$[strcat(part2,"%;")]%;\
    /endif%;\
    /let off=$[strrchr(part1," ")]%;\
    /if (off==-1) /let off=0%; /endif%;\
    /let part11=$[substr(part1,0,off)]%;\
    /let part12=$[substr(part1,off)]%;\
    /let key=$[tolower(part1)]%;\
    /@def %part1 = \
        /if ((\{1}=~\"-h\")|(\{1}=~\"-?\")) \
            /hilfe %part12\%;\
	/else \
	    %part2\
	/endif%;


/addh info \
Falls vorhanden, zeigt es den Hilfetext fuer den angegebenen Parameter an. \
Mit einem vorangestellten '+' wird eine ausfuehrliche Hilfe angezeigt. \
Ansonsten gibt es den Parameter an das tf-Hilfesystem weiter.
/addh syn /hilfe [+][/]eintrag
/addh ex /hilfe /addh, /hilfe +mload, /hilfe +%tf_html, /hilfe + /iskey
/addh list helpindex, help, addh_sublist
/addh see /addh, /defh
/addh var %addh_sublist
/addh hilfe comm

/defh rem_hilfe =\
    /let key=$[tolower({*})]%;\
    /if (substr(key,0,1)=~"+") \
        /let key=$[substr(key,1)]%;\
; ggf. Leerzeichen loeschen
	/while (substr(key,0,1)=~" ") \
	    /let key=$[substr(key,1)]%;\
	/done%;\
	/let full=1%;\
    /else \
        /let full=0%;\
    /endif%;\
    /if (key=/"[/%]*") \
        /let key=$[substr(key,1)]%;\
    /endif%;\
    /if (isKey("helpindex",key)!~error) \
	/getlistvalueof help %key%;\
	/set addh_sublist=%?%;\
	/getdvalueof addh_sublist type%;\
	/getvalueof help_keywords %value%;\
	/echo -p @{B}$[substr(value,2)] %key@{n}%;\
	/forEach help_keywords kv /show_help %full%;\
	/return 2%;\
    /else \
        /@help %key%;\
    /endif%;

/defh hilfe =\
    /let key=$[tolower({*})]%;\
    /if (substr(key,0,1)=~"+") \
        /let key=$[substr(key,1)]%;\
; ggf. Leerzeichen loeschen
	/while (substr(key,0,1)=~" ") \
	    /let key=$[substr(key,1)]%;\
	/done%;\
	/let full=1%;\
    /else \
	/let full=0%;\
    /endif%;\
    /if (key=/"[/%]*") \
        /let key=$[substr(key,1)]%;\
    /endif%;\
    /hgetlistvalueof help %key%;\
    /set addh_sublist=%?%;\
    /if (addh_sublist!~error) \
	/getdvalueof addh_sublist type%;\
	/getvalueof help_keywords %value%;\
	/echo -p @{B}$[substr(value,2)] %key@{n}%;\
	/forEach help_keywords kv /show_help %full%;\
	/return 2%;\
    /else \
        /@help %key%;\
    /endif%;


/addh info \
Erzeugt alle Hilfe-Datein als HTML in den Verzeichnissen '%makdir/help/global' fuer den Normaluser und '%makdir/help/expert' fuer den Programmierer
/addh mak /tokenize, /make_html_file
/addh var %makdir
/addh make_help_html comm

/defh make_help_html =\
    /if ({1}=~"+") \
        /let html_prefix=+%;\
        /set html_dir=%makdir/%{2-%html_expert_dir}%;\
    /else \
	/let html_prefix=.%;\
        /set html_dir=%makdir/%{2-%html_global_dir}%;\
    /endif%;\
;/set html_dir%;\
    /hgetlistvalueof help tf-macros%;\
    /set addh_sublist=%?%;\
    /if (addh_sublist!~error) \
       /getvalueof addh_sublist fileinfo%;\
       /let html_all_files=%?%;\
       /if (html_all_files!~error) \
	 /test tokenize(", ",html_all_files,"make_help_html")%;\
	 /let count=$[make_help_html0]%;\
	 /sys mkdir -p %html_dir%;\
	 /sys rm $[strcat(html_dir,"/*")]%;\
	 /createlist html_created_files%;\
	 /hcreatelist html_all_makros%;\
	 /while (count>1) \
	     /test make_help_html_file:=make_help_html%count%;\
;	     /test make_help_html_file:=substr(make_help_html_file,0,strlen(make_help_html_file)-2)%;\
     /echo -aCred Working on: %make_help_html_file%;\
	     /make_html_list %make_help_html_file%;\
	     /make_html_file2 %html_prefix %make_help_html_file%;\
	     /let count=$[count-1]%;\
	 /done%;\
	 /make_html_index%;\
	 /make_html_all_index%;\
        /endif%;\
        /endif%;\

/def make_html_all_index = \
     /set html_body=<ul>%;\
     /quote -S /add_body_lines `/hsortForEach html_all_makros kv /make_html_all_index2%;\
     /test write_html_file("index_all","Index aller Makros",strcat(html_body,"</ul>"))%;


/def make_html_all_index2 = \
    /getlistvalueof help %forEach_key%;\
    /let entry_text=%;\
    /if (value!~error) \
        /set addh_sublist=%value%;\
        /getvalueof addh_sublist info%;\
        /if (value!~error) \
            /let off=$[strstr(value,"@{N}")]%;\
	    /if (off>-1) \
	        /let entry_text=$[substr(value,0,off)]%;\
	    /else \
	        /let entry_text=%value%;\
	    /endif%;\
	    /if (strlen(entry_text)>160) \
	        /let entry_text=$[substr(entry_text,0,160)]%;\
	    /endif%;\
        /endif%;\
    /endif%;\
    /echo <li><a href="%{forEach_value}.html#%{forEach_key}">%{forEach_key}</a> (%{forEach_value}) %entry_text%;

/def make_html_list = \
    /addtolist html_created_files %L1

/def make_html_index = \
    /set html_body=%;\
    /quote -S /add_body_lines `/forEach html_created_files k /make_html_index2%;\
    /test write_html_file("index","Index File",html_body)%;


/def make_html_index2 = \
    /echo <a href="%1.html"><H3>%1</H3></a>%;\
;    /set load_quiet=0%;\
    /echo_file_info %1%;


/def add_body_lines = \
    /set html_body=%html_body<br>%*

/def write_html_file = \
    /let file_handle=$[tfopen(strcat(html_dir,"/",{1},".html"),"w")]%;\
    /test tfflush(file_handle,1)%;\
    /test tfwrite(file_handle,"<html><head><title>")%;\
    /test tfwrite(file_handle,{2}) %;\
    /test tfwrite(file_handle,"</title></head><body>")%;\
    /test tfwrite(file_handle,'<a name="top"></a>')%;\
    /test tfwrite(file_handle,{3})%;\
    /test tfwrite(file_handle,strcat('<br>This file was created using TinyFugue (c) 1998 by <a href="http:////tf.tcp.com/~hawkeye/">Ken Keys</a> at ',ftime("%c",time()),' by Michael Hunger <a href="mailto:mh14@inf.tu-dresden.de">(mh14@inf.tu-dresden.de)</a>.<br>'))%;\
    /test tfwrite(file_handle,"</body></html>")%;\
    /test tfclose(file_handle)%;


/addh info \
Erzeugt ein HTML-Hilfefile aus dem uebergebenen Hilfeeintrag, moeglichst eine Makrodatei, aber auch ein einzelnes Kommando ist moeglich. An den uebergebenen Namen wird ein .html angehaengt. Es werden auch die in der Hilfebeschreibung referenzierten im selben File definierten Makros mit auf die Seite gepackt. Ein '+' vor dem Namen erzeugt eine Entwicklerversion (ausfuehrlicher).
/addh syn /make_html_file [+]macro(datei)
/addh var %html_eval_list, %html_full, 
/addh comm hilfe_html
/addh func tfio
/addh make_html_file comm

/defh make_html_file = \
    /set html_eval_list=%;\
    /let param=%*%;\
    /if (substr(param,0,1)=~"+") \
        /let param=$[substr(param,1)]%;\
    /endif%;\
    /let file=$[tfopen(strcat(html_dir,param,".html"),"w")]%;\
    /test tfflush(file,1)%;\
    /test tfwrite(file,"<html><head><title>")%;\
    /test tfwrite(file,param) %;\
    /test tfwrite(file,"</title></head><body>")%;\
    /let res=<a name=\"top\"></a>%;\
    /test tfwrite(file,res)%;\
;    /let res%;\
    /let res=$(/hilfe_html %*)%;\
    /test tfwrite(file,res)%;\
    /let res=%;\
    /test tfwrite(file,"-------------------------<br>")%;\
;/echo -e - %html_eval_list%;\
    /test tokenize("/",html_eval_list)%;\
    /let count=2%;\
    /while (count<=T0) \
        /unset html_eval_list%;\
	/let topic=T%count%;\
	/test topic:=%topic%;%;\
	/let topic=$[substr(topic,0,strlen(topic)-2)]%;\
	/echo -e Working on: %topic %file%;\
	/let res=$(/%topic)%;\
;/echo -e %res%;\
;	 /test shread()%;\
         /test tfwrite(file,res)%;\
	 /test tfflush(file)%;\
	 /let count=$[count+1]%;\
    /done%;\
;    /let res=$(/eval %html_eval_list)%;\
;    /let res%;\
;    /test tfwrite(file,res)%;\
    /let t=/test tfwrite(file,strcat("<br>This file was created using TinyFugue (c) 1998 by <a href=\"http:////tf.tcp.com/~hawkeye/\">Ken Keys</a> at ",ftime("%c",time())," by Michael Hunger <a href=\"mailto:mh14@inf.tu-dresden.de\">(mh14@inf.tu-dresden.de)</a>.<br>"))%;\
    /test tfwrite(file,"</body></html>")%;\
    /test tfclose(file)%;


/addh info \
Gibt per /echo eine HTML-Version der Onlinehilfe fuer einen Hilfeeintrag aus.
/addh see /hilfe, /make_html_file
/addh mak /forEach, /show_help_html
/addh list addh_sublist, help_keywords
/addh var %html_full, %html_file_name,
/addh comm /help
/addh hilfe_html comm

/defh hilfe_html =\
    /let key=$[tolower({*})]%;\
    /let full=0%;/set html_full=%;/set value=%;\
    /if (substr(key,0,1)=~"+") \
        /let key=$[substr(key,1)]%;\
	/let full=1%;\
	/set html_full=+%;\
    /endif%;\
    /if (substr(key,0,1)=~"/") \
        /let key=$[substr(key,1)]%;\
    /endif%;\
    /if (hgetvalueof("help",key) !~ error) \
	/hgetlistvalueof help %key%;\
	/set addh_sublist=%?%;\
	/getvalueof addh_sublist fileinfo%;\
	/let html_file_name=%value%;\
	/getdvalueof addh_sublist type%;\
	/getvalueof help_keywords %value%;\
	/_echo <a name="%key"></a>%;\
	/_echo <a href="#top">(top)</a>%;\
	/if (html_full=~"+") \
	    /_echo Source of: \
	        <a href="source//%html_file_name">%html_file_name</a><br>%;\
	/endif %;\
	/_echo <H3>$[substr(value,2)] %key</H3><p>%;\
	/forEach help_keywords kv /show_help_html %full%;\
    /else \
        /@help %key%;\
    /endif%;


/addh info \
Zeigt die einzelnen Rubriken eines Hilfethemas an. Dabei ist der komplette Eintrag in der Liste 'addh_sublist' enthalten.
/addh syn /show_help 0|1 Hilfeschluesselwort 0|1 Titel
/addh list addh_sublist
/addh mak /echo2, /getvalueof
/addh show_help mak

/def show_help =\
    /if ({1}>={3}) \
        /getvalueof addh_sublist %2%;\
        /if (value!~error) \
            /echo2 -p @{B}%-3@{n} %value%;\
        /endif%;\
    /endif%;


/addh info \
Zeigt die einzelnen Rubriken eines Hilfethemas als HTML-Quelltext an. Dabei ist der komplette Eintrag in der Liste 'addh_sublist' enthalten.
/addh syn \
/show_help_html 0|1 Hilfeschluesselwort 0|1 Titel
/addh list addh_sublist, 
/addh mak /echo2, /getvalueof
/addh show_help_html mak

/def show_help_html =\
    /if ({1}>={3}) \
        /getvalueof addh_sublist %2%;\
;/echo -e %2 value: %value%;\
        /if (value!~error) \
	    /set value=$(/replace @{N} <br> %value)%;\
	    /set value=$(/replace @{B} <b> %value)%;\
	    /set value=$(/replace @{n} <!--> %value)%;\
	    /if ({2}=/"{see|comm|mak|hook|over|var|list|func|fileinfo|req}") \
	        /make_hrefs%;\
	    /endif%;\
	    /if ({2}=/"{info|misc|changes|tut}") \
;/echo -e %2%;\
		/make_hrefs [?/]%;\
	    /endif %;\
	    /if ({2}=/"{syn|ex}") \
		/set value=$[strcat("<pre>",value,"</pre>")]%;\
	    /endif %;\
	    /set value=$(/replace <!--> </b></i> %value)%;\
            /_echo <strong>%-3</strong> %value</b></i><p>%;\
	    /set value=%;\
        /endif%;\
    /endif%;


/addh info \
Pfad zu tf-Hilfe HTML-Seiten.
/addh ex tf_html=file://localhost/data/docs/tf/commands/index.html
/addh tf_html var

/set tf_html=../tf/commands/index.html


/addh info \
Scannt uebergebene Strings nach potentiellen Links und erzeugt diese, Parameteruebergabe in %value.
/addh return in %value der modifizierte String
/addh var %html_file_name, %html_eval_list, %value
/addh list /help_keywords, /help
/addh comm help
/addh make_hrefs mak

/def make_hrefs = \
    /let param=%value%;\
;/let param%;\
;/let html_file_name%;\
;/echo %param%;\
    /let res=%;\
    /let expression=$[strcat("(([A-Za-z0-9_]+)#)?(",{1},"[A-Za-z0-9_\\.]+)")]%;\
    /while (regmatch(expression,param)) \
        /let Pfull=%P0%;\
	/let Pfile=%P2%;\
	/let Pname=$[tolower({P3})]%;\
	/let f_help=0%; /let f_hilfe=0%;\
	/if (substr(Pname,0,1)=/"[\\?/]") \
	    /let Pname=$[substr(Pname,1)]%;\
	/endif%;\
	/let Pfull2=%Pfull%;\
	/if (substr(Pfull,0,1)=/"\\?") \
	    /let Pfull2=$[substr(Pfull,1)]%;\
	/endif%;\
;/let Pfull%;\
;/let Pfile%;\
;/let Pname%;\
;/echo make_hrefs: %P3 : %P0%;\
	/let t=$(/help %Pname%;/let f_help=%?%;)%;\
	/getlistvalueof help %Pname%;\
	/if (value!~error) \
	    /let f_hilfe=1%; \
	    /if (Pfile=~"") \
	        /set html_temp_list=%value%;\
	        /getvalueof html_temp_list type%;\
		/getvalueof help_keywords %value%;\
		/if (substr(value,0,1)>0 & html_full=~"") \
		    /let f_hilfe=0%;\
		/else \
	            /getvalueof html_temp_list fileinfo%;\
		    /if (value!~html_file_name) \
		        /let Pfile=%value%; \
		    /else \
		        /let to_add=$[strcat("/hilfe_html ",html_full,{Pname},"%;")]%;\
			/if (Pname!~value) \
			    /if (strstr(html_eval_list,to_add)==-1) \
			        /set html_eval_list=$[strcat(html_eval_list,to_add)]%;\
		            /endif%;\
			/endif%;\
		    /endif%;\
		/endif%;\
	    /endif%;\
	/endif%;\
;/let f_help%;/let f_hilfe%;\
	/let off=$[strstr(param,Pfull)]%;\
	/if (substr(param,off-1,1)=~" ") \
	    /let offs=1%;\
	/else \
	    /let offs=0%;\
	/endif %;\
	/let res=$[strcat(res,substr(param,0,off))]%;\
	/if (f_hilfe | f_help) \
	    /if (f_help & f_hilfe) \
;		/echo writing tf reference %;\
		/let res=$[strcat(res,(offs)?" ":"",href0,((Pfile!~"")?strcat(Pfile,".html"):""),"#",Pname,href1,{Pfull2},href2)]%;\
	    /endif%;\
	    /let res=$[strcat(res,(offs)?" ":"",href0,((Pfile!~"")?strcat(Pfile,".html"):((f_help)?tf_html:"")),"#",Pname,href1,Pfull2,(f_help)?"(tf)":"",href2)]%;\
	/else \
	    /let res=$[strcat(res,(offs)?" ":"",Pfull2)]%;\
	/endif%;\
	/let param=$[substr(param,off+strlen({Pfull}))]%;\
;	 /read%;\
    /done%;\
    /unset html_temp_list%;\
    /set value=$[strcat(res,param)]%;




/addh info \
Erzeugt zu allen Files unterhalb der uebergebenen Verzeichnisse, die mit \
"*.tf" aufhoeren, die zugehoerige Hilfe. Evtl. vorhandene "i18n"-, "*.def"- \
oder "*.cfg"-Files werden ebenfalls beruecksichtigt. Alternativ kann auch \
eine Liste der Files direkt angegeben werden. Ohne Parameter werden \
alle Verzeichnisse aus %TFPATH durchsucht. Nach Erstellung der Hilfe wird \
sie gespeichert und noch etwas Statistikkram ausgegeben.@{N}\
Es wird lediglich die Hilfe erzeugt, Makros aus den entsprechenden Files \
werden nicht ausgefuehrt! Daher sollte es keine Probleme mit \
Abhaengigkeiten zwischen Files, sich widersprechenden Makrodefinitionen \
oder aehnlichen Seiteneffekten geben.@{N}\
Defaultmaessig wird die Hilfe komplett neu erzeugt. Eine bestehende Hilfe \
wird also geloescht und nicht erweitert. Will man eine bestehende Hilfe \
erweitern, so muss /create_help mit der Option '-a' aufgerufen werden.@{N}\
/create_help kann offline aufgerufen werden.@{N}\
Das Erzeugen der kompletten Hilfe kann eine ganze Weile dauern. Falls die \
ganze Geschichte laenger als 10 Sekunden dauert, wird deshalb nach \
Fertigstellung freundlich gepiepst.
/addh syn /create_help [-a] [Pfad1/File1 Pfad2/File2 ...]
/addh ex /create_help mg.mud.de meinkram.tf /usr/local/tf/
/addh mak /create_help_filelist, /create_help_file
/addh create_help comm

/def create_help = \
    /let create_help_time=$[time()]%;\
    /if ({1} =~ "-a") \
	/shift%;\
    /else \
	/hcreatelist help%;\
    /endif%;\
; Fileliste erzeugen.
    /echo Suche tf-Files ...%;\
    /if ({#}) \
	/create_help_filelist %*%;\
    /else \
	/create_help_filelist %TFPATH%;\
    /endif%;\
    /if (isEmptyList("help_tffiles")) \
	/echo Nichts zu tun, keine tf-Files gefunden.%;\
	/hloadlist -l help%;\
	/unset help_tffiles%;\
	/return%;\
    /endif%;\
    /let build_help_backup=%build_help%;\
    /set build_help=1%;\
    /set create_help_entries=0%;\
    /set create_help_files=0%;\
; Hilfe erzeugen.
    /eval_hook start_build_help%;\
    /foreach help_tffiles k /create_help_file%;\
; Hilfe speichern.
    /eval_hook done_build_help%;\
    /save_help%;\
; Aufraeumen.
    /unset help_tffiles%;\
    /set build_help=%build_help_backup%;\
    /let create_help_time=$[time() - create_help_time]%;\
    /if (create_help_time > 10) \
	/beep%;\
    /endif%;\
    /echo -aBCgreen Hilfe erzeugt und gespeichert. \
	(%create_help_time sek., \
	%create_help_files $[create_help_files==1?"File":"Files"], \
	%create_help_entries \
	$[create_help_entries==1?"Hilfeeintrag":"Hilfeeintraege"])%;\
    /unset help_create_files%;\
    /unset help_create_entries


/addh info \
Erzeugt in help_tffiles eine Liste aller Files unterhalb der uebergebenen \
Verzeichnisse, mit ".tf" aufhoeren. Zugehoerige i18n-, def- und cfg-Files \
werden ebenfalls in die Liste aufgenommen.
/addh syn /create_help_filelist Pfad1 [Pfad2 ...]
/addh ex /create_help_filelist %TFPATH
/addh see /create_help
/addh create_help_filelist comm

/def create_help_filelist = \
    /createlist help_tffiles%;\
    /while ({#}) \
	/quote -S /create_help_filelist1 !"find %1 -iname \\\\*.tf"%;\
	/shift%;\
    /done%;\
;    /showlist tf_files

; Filtert Fehlermeldungen von find heraus und erweitert %help_tffiles.
; Evtl. zugehoerige i18n-, def- und cfg-Files werden ebenfalls
; beruecksichtigt.
/def create_help_filelist1 = \
    /if (substr({*},-3) =/ ".tf") \
	/xuaddtolist help_tffiles&%*&%;\
; Leerzeichen im Filenamen sind ja nie auszuschliessen, deshalb /test.
	/test create_help_filelist2({*},"i18n","def","cfg")%;\
    /endif

; Beruecksichtige Config-Files etc.
/def create_help_filelist2 = \
     /let filename=$[substr({1},0,-2)]%;\
     /shift%;\
     /while ({#}) \
	/let tmp=$[strcat(filename,{1})]%;\
	/if (file_exists(tmp)) \
	    /xuaddtolist help_tffiles&%tmp&%;\
	/endif%;\
	/shift%;\
    /done


/addh info \
Erzeugt fuer das angegebene File die Hilfeeintraege.
/addh see /create_help
/addh create_help_file mak

/def create_help_file = \
    /if (!{#}) \
	/return%;\
    /endif%;\
    /let help_in=$[tfopen({*}, "r")]%;\
    /if (help_in == -1) \
	/echo -aCred Kann '%*' nicht lesen!%;\
	/return%;\
    /endif%;\
    /test ++create_help_files%;\
    /set file_name=$[substr({*}, strrchr({*},"/")+1)]%;\
    /if (tolower(substr(file_name,-3)) =~ ".tf") \
	/echo -paCgreen Erzeuge Hilfe fuer @{n}%*@{Cgreen}.%;\
    /endif%;\
    /let continued=0%;\
    /let helpline=%;\
    /let line=%;\
    /while (tfread(help_in, line) != -1) \
	/if (strncmp(line, "/addh ", 6)==0 | continued) \
	    /let continued=$[substr(line,-1) =~ "\\"]%;\
	    /if (!continued) \
		/let helpline=$[substr(strcat(helpline, line),6)]%;\
		/addh %helpline%;\
;               /let key=$[substr(helpline, 0, strchr(helpline, " "))]%;\
;               /if (!is_help_keyword(key)) \
		/if (strncmp(helpline, "info ", 5) == 0) \
		    /test ++create_help_entries%;\
		/endif%;\
		/let helpline=%;\
	    /else \
		/test helpline:=strcat(helpline, substr(line,0,-1))%;\
	    /endif%;\
	/elseif (strncmp(line, "/addh_fileinfo", 14) == 0) \
	    /purge_vars help_list_*%;\
	    /addh_fileinfo%;\
	/endif%;\
    /done%;\
    /test tfclose(help_in)



/addh info \
Enthaelt die fuer das Hilfesystem notwendigen Befehle. Die Hilfetexte werden in den Listen 'help' und 'helpindex' abgespeichert.
/addh list help, helpindex, addh_sublist, help_keywords
/addh tut \
Die Benutzung in den eigenen Files ist ganz einfach:@{N}\
Diese Schluesselworte koennen verwendet und natuerlich auch erweitert werden:@{N}\
@{N}\
 info 0 Info:@{N}\
 syn 0 Syntax:@{N}\
 misc 0 Sonstiges:@{N}\
 adapt 1 Anpassen an Mud:@{N}\
 ex 0 Beispiel:@{N}\
 return 1 Rueckgabewert:@{N}\
 see 0 Siehe auch:@{N}\
 comm 0 Kommandos:@{N}\
 mak 1 Makros:@{N}\
 hook 1 Hooks:@{N}\
 trig 1 Trigger:@{N}\
 over 1 TF-Befehle:@{N}\
 func 1 TF-Funktionen:@{N}\
 var 1 Variablen:@{N}\
 list 1 Listen:@{N}\
 fileinfo 0 Datei:@{N}\
 type 2 Typ:@{N}\
 dtype 2 Datentyp:@{N}\
@{N}\
@{N}\
Ein Hilfeeintrag sieht z.B. so aus:@{N}\
@{N}\
/addh info \@{N}\
Holt eine/viele Variable aus dem Stack. Wenn Variablenname(n) uebergeben werden, wird der Wert in dieser Variablen gespeichert.@{N}\
/addh ex /pop@@@{}{N}\@{N} /pop test@@@{}{N}\@{N} /pop test test2@{N}\
/addh return der Inhalt der letzten Variablen@{N}\
/addh see push, getstack, putstack@{N}\
/addh pop mak@{N}\
@{N}\
@{N}\
Die Hilfe im tf sieht dann so aus:@{N}\
@{N}\
@{B}Makros: pop@{n}@{N}\
@{B}Info:@{n} Holt eine/viele Variable aus dem Stack. Wenn Variablenname(n) uebergeben @{N}\
werden, wird der Wert in dieser Variablen gespeichert.@{N}\
@{B}Beispiel:@{n} /pop@{N}\
/pop test@{N}\
/pop test test2@{N}\
@{B}Siehe auch:@{n} push, getstack, putstack@{N}\
@{B}Datei:@{n} util.tf@{N}\
@{N}\
Aus der Hilfe koennen dann auch HTML-Seiten erzeugt werden. Durch eine Angabe am Ende der Files kann eine Zusammenfassung fuer das Makrofile erzeugt werden.@{N}\
Da die Erzeugung der Hilfeinformationen nur auf Wunsch geschieht, sind die Ladezeiten ansonsten kaum beeinflusst.@{N}\
Es gibt eine Moeglichkeit, Makros mit /defh zu definieren, so dass sie interaktiv Hilfe liefert. Z.B. zeigt "/showway -?" oder "/showway -h" den Hilfeeintrag an.
/addh see /make_help, /create_help, CFG_HELP_BUILD
/addh_fileinfo

/addh info \
Eine Einfuehrung als solche gibt es nicht, bitte die Hilfeseite zum Dateisystem mit "/hilfe loading.tf" anschauen und dann von dort weiter verzweigen.
/addh see loading.tf
/addh einfuehrung see

/addh info \
Siehe LIESMICH.
/addh tf-macros see