; $Log: i18n.tf,v $
; Revision 1.11  2002/12/06 16:17:15  mh14
; maplocale debuggt
;
; Revision 1.10  2002/12/03 03:45:36  mh14
; Sprachkonzept geändert, kein LANG mehr sondern user_lang (-L) und mud_lang (-l) neue mak_loc zu direkten Ersetzen von Strings in Makrobodies, /addh kennt jetz locales für verschiedene Hilfeversionen
;
; Revision 1.9  2002/12/03 00:57:15  mh14
; LANG ist jetzt user_lang im Configfile, wird in i18n.tf beachtet, TODO generelles Sprachkonzept
;
; Revision 1.8  2002/09/28 15:11:55  mh14
; Spracheinstellung
;
; Revision 1.7  2002/08/20 15:00:28  nieten
; LANG wird nur noch bei Bedarf umgesetzt (scrollt weniger beim Einloggen)
;
; Revision 1.6  2001/11/27 13:50:41  mh14
; anpassung first_connect
;
; Revision 1.5  2001/10/10 22:10:21  mh14
; Default-Konfiguration in .tf Files verschoben
;
; Revision 1.4  2001/10/07 16:52:57  mh14
; echo bei i18n_mud_language raus
;
; Revision 1.3  2001/10/01 22:16:18  mh14
; sprachumschaltung auf world_host basis
;
; Revision 1.2  2001/09/17 10:46:01  mh14
;  debuggt
;
; Revision 1.1  2001/09/12 08:03:52  mh14
; Internationalisierung
;
/set i18n_tf_version $Id: i18n.tf,v 1.11 2002/12/06 16:17:15 mh14 Exp $
/set i18n_tf_author=Mesirii@mg.mud.de
/set i18n_tf_requires=lists.tf
/set i18n_tf_desc Internationalisierung


; Kleines Konzept: Nutzersprache und Mudsprache
; Nutzersprache bedingt Ausgaben der Makros
; wird genutzt von: addloc, loc
; Mudsprache bedingt, Trigger, Pattern matching usw. 
; TODO Vernünftige Sprachunterstützung in der Hilfe, direkte Lokalisierung von Meldungen

; ********************* BEGIN CONFIG ********************

/cfg_info i18n LOCALES Mappings_Sprachnamen:locale_.+

/set_var locale_de=de de_DE german deutsch de_AU
/set_var locale_en=en en_US en_EN english englisch C

/addh info Sprache des Nutzers
/addh update /i18n_mud_language
/addh user_lang cfg

/cfg_info i18n Spracheinstellungen
/cfg_info i18n LANG Sprache:user_lang

/cfg_info mud LANG Sprache:mud_lang

/cfg_info i18n MUD_LANGUAGE Mudliste:i18n_mud_language

/add_to_hook first_connect /i18n_mud_language

; ********************* END CONFIG **********************

/addh info \
mappt die verschiedenen Auspraegungen einer locale (z.B. deutsch, german, de_DE, de_AU usw) auf eine locale. Dazu wird entweder bei de_DE nur der erste Teil genommen, bei german usw. sollte eine Variable locale_german mit de gesetzt sein.
/addh return per result, Ziellocale oder Parameter
/addh ex /test map_locale("german"), /map_locale %%LANG
/addh syn /map_locale localebez
/addh see add_loc, loc
/addh map_locale mak

/def map_locale = \
     /let param=$[tolower({1})]%;\
     /let map_locale=%;\
     /listvar -s locale_* *%{param}*%| /test tfread(map_locale)%;\
     /result (map_locale!~"") ? substr(map_locale,7) : param

; todo mak_loc_quote

/def mak_loc = \
     /let mak_loc_lang=$[map_locale({2})]%;\
     /if (user_lang!~mak_loc_lang) /return%; /endif%;\
     /let mak_loc_macro=%1%;\
     /shift 2%;\
     /let mak_loc_macro_body=$[reval(strcat("${",mak_loc_macro,"}"))]%;\
     /while ({#}>1) \
         /test mak_loc_macro_body:=replace({1},{2},mak_loc_macro_body)%;\
;         /test mak_loc_macro_body:=replace(strcat('"',{1},'"'),strcat('"',{2},'"'),mak_loc_macro_body)%;\
;         /test mak_loc_macro_body:=replace(strcat("'",{1},"'"),strcat("'",{2},"'"),mak_loc_macro_body)%;\
	 /shift 2%;\
     /done%;\
     /edit %mak_loc_macro = %mak_loc_macro_body

/addh info \
Fügt neue Lokalisierungsstrings hinzu
/addh list i18n, add_loc (temporaer)
/addh see loc
/addh syn /test add_loc("base_string","base_locale","string","locale","string2","locale2")
/addh ex /test add_loc("Deutscher Text","de","German Text","en")
/addh add_loc mak
/def add_loc = \
     /if ({#}<2) /return%; /endif%;\
     /let base_entry=%;/test base_entry:={1}%;\
     /init_var add_loc%;\
     /test add_loc:=hgetlistvalueof("i18n",base_entry)%;\
     /if (add_loc=~error) \
       /createlist add_loc%;\
     /else \
       /test hdeletekeyandvalue("i18n",base_entry)%;\
     /endif%;\
     /while ({#}>1) \
       /test uaddtolist("add_loc",{2},{1})%;\
       /shift 2%;\
     /done%;\
     /test haddlisttolist("i18n",base_entry,add_loc)

/addh info \
Lokalisiert einen übergebenen String, dazu wird in der Liste i18n, der String gesucht und dann die Uebersetzung fuer die aktuelle Locale (in LANG) zurueckgegeben, falls die aktuelle Locale mit der Basislocale uebereinstimmt, wird nicht gesucht.
/addh syn /test loc("locale des Strings","String") oder /loc locale String
/addh ex /test loc("de","Das ist ein Text") : bei LANG=en "This is a text"@{N}\
/loc de Das ist ein Test
/addh return per /result
/addh list i18n
/addh see add_loc, LANG
/addh loc mak

/def loc = \
     /let mapped_loc=$[map_locale({1})]%;\
     /let org_string=%; /test org_string:={-1}%;\
     /if (mapped_loc=~user_lang) /result {org_string}%; /endif%;\
     /init_var add_loc%;\
     /test add_loc:=hgetlistvalueof("i18n",{org_string})%;\
     /if (add_loc!~error) \
	/let loc_string=%;\
        /test loc_string:=getvalueof("add_loc",user_lang)%;\
	/if (loc_string!~error) /result loc_string%; /endif%;\
     /endif%;\
     /echo -e No entry found for: %{org_string} (%mapped_loc) in (%user_lang)%;\
     /result {org_string}

; todo lecho
/def i18n_mud_language = \
        /if (mud_lang!~"") /return%; /endif%;\
	/getvalueof i18n_mud_language ${world_host}%;\
        /let mud_lang=%?%;\
	/if (mud_lang=~error) \
	   /if (world_info("host")=/"{*.de|*.at}") \
	      /set mud_lang=de%; \
	   /elseif (world_info("host")=/"{*.org|*.com|*.uk}") \
	      /set mud_lang=en%; \
	   /else \
	      /set mud_lang=de%; \
           /endif%;\
	/else \
	   /set mud_lang=%i18n_tmp_lang%; \
	/endif%;\

/def is_locale = /return {1}=/"{de|en}"

/addh_fileinfo

