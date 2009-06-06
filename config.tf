; $Log: config.tf,v $
; Revision 1.24  2002/12/06 16:20:34  mh14
; gildenspezifische aenderungen in gilde/user_config.cfg
;
; Revision 1.23  2002/12/06 15:18:09  mh14
; user/mudspezifische Variablen müssen jetzt nur noch ein MUD bzw. PLAYER enthalten, matching von varname auf mregexp aufgehofen
;
; Revision 1.22  2002/09/28 00:42:12  mh14
; Update jetzt moeglich mittels /cfg_update wenn in der hilfe ein update Eintrag enthalten ist, oder fuer alles was status im namen hat per /config_status
;
; Revision 1.21  2002/09/11 12:24:09  mh14
; hilfeeintraege sind manchmal auch kleingeschrieben
;
; Revision 1.20  2002/09/08 17:10:55  mh14
; bei cfg_info koennen jetzt auch fuer den Variablennamen hinterm : regular expressions fuer variablenmengen angegeben werden
;
; Revision 1.19  2002/06/13 08:25:54  mh14
; Mudspezifische Dinge nach mg.mud.de/user_config.def verschoben, Hervorhebung von Parent-Knoten (mit Hilfe von util.echo.tf)
;
; Revision 1.18  2002/06/06 10:20:45  mh14
; listen werden jetzt selbst gespeichert und nicht mehr in die user_config.cfg als Variable hinzugefuegt
;
; Revision 1.17  2002/06/05 10:51:34  mh14
; auch farben mit leerzeichen getrennt sind jetzt gueltige werte
;
; Revision 1.16  2002/05/29 11:51:45  thufhnik
; /cfg_echocolor zugefuegt
;
; Revision 1.15  2002/05/21 11:30:47  thufhnik
; /cfg_echogag hinzugefuegt
;
; Revision 1.14  2002/05/15 16:25:20  thufhnik
; inventory.tf zugefuegt
;
; Revision 1.13  2002/05/04 17:06:03  mh14
; grummel pedantic
;
; Revision 1.12  2002/04/24 09:23:23  thufhnik
; Paketauswahl fuer erwarte.tf
;
; Revision 1.11  2002/04/23 15:09:56  nieten
; Bug in /cfg_get_type raus
;
; Revision 1.10  2002/04/23 13:30:41  nieten
; - Bug in /cfg_get_type entfernt (help ist *Hash*liste)
; - Neuer dtype 'flag'. Kann 0 oder 1 sein.
; - /cfg_check ist jetzt sicherer
; - Doku ueberarbeitet
;
; Revision 1.9  2002/04/23 00:06:46  mh14
; Variablen fuer cfg_echo sinniger benannt, CFG_ECHO_GAG_LEVEL wird beim Fehlen jetzt auf 2 angenommen, im echo_text kann zu evaluierendes Zeugs stehen z.b. %p_lp
;
; Revision 1.8  2002/04/22 23:44:35  mh14
; debugausgaben raus
;
; Revision 1.7  2002/04/20 16:23:24  thufhnik
; info.tf aufgenommen
;
; Revision 1.6  2002/04/18 22:56:38  mh14
; gui debuggt,check erlaubt jetzt auch leere farbvariablen, qsort von ken
;
; Revision 1.5  2002/04/17 01:16:25  mh14
; wie kommt man raus aus /configure
;
; Revision 1.4  2002/04/16 13:43:42  mh14
; Wertecheck
;
; Revision 1.3  2002/04/16 12:13:22  mh14
; speichern von config in user_config.cfg, editieren von listen, debuggt, refactoriert, etwas doku, sachen in die richten files rausgezogen (/cfg_info)
;
; Revision 1.2  2002/04/12 16:41:02  mh14
; /cfg_echo fuer bedingte Alternativausgaben von Triggern, CFG_ECHO_GAG_LEVEL auch dafuer
;

/set config_tf_version $Id$
/set config_tf_author=Mesirii@mg.mud.de
/set config_tf_requires=!lists.tf util.echo.tf(1.20) util.sfunc.tf(1.7)
/set config_tf_desc=Konfigurationssystem


/addh info \
Liefert die /custom-Optionen, wo ein Savefile fuer die angegebene Config-Variable zu finden ist.
/addh syn /cfg_get_dest cfg-hierarchie-name
/addh ret /custom-Optionen
/addh ex /cfg_get_dest USE -> nix@{N}\
/cfg_get_dest STATUS MUD HITPOINTS -> -c@{N}\
/cfg_get_dest COMM MUD PLAYER TELL_FROM -> -c -p
/addh cfg_get_dest mak

/def cfg_get_dest = \
     /let cfg_dest=%;\
     /if ({*}=/"*MUD*" | {*} =/ strcat("*{",replace(".","_",world_info("host")),"}*")) \
        /let cfg_dest=%cfg_dest -c%;\
     /endif%;\
     /if ({*}=/"*GUILD*" | {*} =/ strcat("*",p_guild,"*")) \
        /if (cfg_dest!/"*-c*") /let cfg_dest=%cfg_dest -c%; /endif%;\
        /let cfg_dest=%cfg_dest -g%;\
     /endif%;\
     /if ({*}=/"*PLAYER*" | {*} =/ strcat("*{",replace(".","_",world_info("character")),"}*")) \
        /if (cfg_dest!/"*-c*") /let cfg_dest=%cfg_dest -c%; /endif%;\
        /let cfg_dest=%cfg_dest -p%;\
     /endif%;\
     /return cfg_dest

/addh info \
Speichert die als letzten Parameter uebergebene Variable in dem user_config.cfg-File, das durch die vorhergehenden Config-Hierarchie Namen bestimmt wurde. Dabei werden in dem File die Zeilen ersetzt, in denen die Variable bisher gesetzt wurde, oder halt ans Ende des Files angehaengt.
/addh syn /cfg_save config hierarchie names varnae
/addh ex /cfg_save ALL LOADING SUFFIX file_suffixes wird in user_config.cfg gespeichert@{N}\
/cfg_save MG_MUD_DE COMMAND LOOK wird in mg.mud.de/user_config.cfg gespeichert

/addh cfg_save mak

/def cfg_save = \
     /let cfg_var=%L%;\
     /let cfg_line=$(/listvar -msimple %cfg_var)%;\
     /cfg_get_dest %-L%;\
     /let cfg_dest=-a %?%;\
;/let cfg_line%;\
;/let cfg_dest%;\
     /custom %cfg_dest%;\
     /test %?%;\
     /let cfg_file=%{load_dir}user_config.cfg%;\
     /let cfg_cmp_line=/set %cfg_var*%;\
     /cfg_mod_file%;

; TODO ggf verzeichnisse anlegen !!

/def cfg_mod_file = \
;/let cfg_file=%{cfg_file}.test%;\
/echo Modify File: %cfg_file%;\
     /if (file_exists(cfg_file)) \
     /let cfg_in=$[tfopen(cfg_file,"r")]%;\
       /let cfg_queue=$[tfopen("cfg","q")]%;\
       /let tmp=%;\
       /let replaced=0%;\
       /while (tfread(cfg_in,tmp)>-1) \
          /if (tmp=/cfg_cmp_line) \
	     /let replaced=1%;\
	     /echo Replacing '%tmp' with '%cfg_line'%;\
	     /let tmp=%cfg_line%;\
	  /endif%;\
	  /test tfwrite(cfg_queue,tmp)%;\
       /done%;\
       /if (!replaced) \
          /echo Added %cfg_line at the end of %cfg_file%;\
	  /test tfwrite(cfg_queue,cfg_line)%;\
	  /test tfwrite(cfg_queue,"")%;\
       /endif%;\
       /test tfclose(cfg_in)%;\
       /let cfg_out=$[tfopen(cfg_file,"w")]%;\
       /while (tfread(cfg_queue,tmp)>-1) \
	  /test tfwrite(cfg_out,tmp)%;\
       /done%;\
       /test tfclose(cfg_queue),tfclose(cfg_out)%;\
     /else \
       /echo -aCyellow %cfg_file does NOT exist! It will be created with the line %cfg_line%;\
       /test fwrite(cfg_file,cfg_line)%;\
     /endif%;\


/addh info \
Ein Echo-Makro, das schaut, ob fuer den uebergebenen Makronamen eine Config von Farbe und/oder Text existiert. Wenn ja gibt es die Config aus, ansonsten den Originaltext.@{N}\
Die Variablen heissen: CFG_*_ECHO_TEXT und CFG_*_ECHO_ATTR, das * steht fuer den als ersten uebergebenen Parameter.@{N}\
Dabei wird noch CFG_ECHO_GAG_LEVEL beachtet: bei 0 oder nicht gesetzt wird die Originalmeldung ausgegeben, bei 1 wird nur die Farbe beruecksichtigt, bei 2 wird Farbe und Alternativtext beruecksichtigt.
/addh syn /cfg_echo configname %*
/addh ex /set CFG_MG_ZAUBERER_ZSCHILD_ECHO_TEXT=ZSchild @{B}aus.@{n}@{N}\
/set CFG_MG_ZAUBERER_ZSCHILD_ECHO_ATTR=Cblue@{N}\
/cfg_echo MG_ZAUBERER_ZSCHILD %*
/addh cfg_echo mak

/def cfg_echo = \
     /let cfg_name=$[toupper({1})]%;\
     /let cfg_name=CFG_%{cfg_name}_ECHO%;\
     /let cfg_echo_text=%-1%;\
     /let cfg_echo_attr=x%;\
     /let gag_level=%{CFG_ECHO_GAG_LEVEL-2}%;\
     /if (gag_level>1 & isVar(strcat(cfg_name,"_TEXT"))) \
        /test cfg_echo_text:=$[strcat(cfg_name,"_TEXT")]%;\
     /endif%;\
     /if (gag_level>0 & isVar(strcat(cfg_name,"_ATTR"))) \
        /test cfg_echo_attr:=$[strcat(cfg_name,"_ATTR")]%;\
     /endif%;\
     /eval /echo -a%cfg_echo_attr -p -- %cfg_echo_text

/addh info \
Gibt je nach CFG_ECHO_GAG_LEVEL den uebergebenen String farbig, normal oder gar nicht aus.
/addh syn /cfg_echogag configname %*
/addh ex /set CFG_MG_ZAUBERER_ZSCHILD_ECHO_ATTR=Cblue@{N}\
/cfg_echogag MG_ZAUBERER_ZSCHILD Zauberschild
/addh cfg_echogag mak

/def cfg_echogag = \
	/if (CFG_ECHO_GAG_LEVEL > 1) \
		/return%;\
	/elseif (CFG_ECHO_GAG_LEVEL == 1) \
		/let cfg_name=$[toupper({1})]%;\
		/let cfg_attrib=%;\
		/test cfg_attrib:=$[strcat("CFG_",cfg_name,"_ECHO_ATTR")]%;\
		/echo -pa%cfg_attrib -- %-1%;\
	/else \
		/echo -- %-1%;\
	/endif

/addh info \
Gibt den uebergebenen String je nach CFG_ECHO_GAG_LEVEL farbig oder ohne Attribute aus.
/addh syn /cfg_echocolor configname %*
/addh ex /set CFG_MG_ZAUBERER_ZSCHILD_ECHO_ATTR=Cblue@{N}\
/cfg_echocolor MG_ZAUBERER_ZSCHILD Zauberschild
/addh cfg_echocolor mak

/def cfg_echocolor = \
	/if (CFG_ECHO_GAG_LEVEL) \
		/let cfg_name=$[toupper({1})]%;\
		/let cfg_attrib=%;\
		/test cfg_attrib:=$[strcat("CFG_",cfg_name,"_ECHO_ATTR")]%;\
		/echo -pa%cfg_attrib -- %-1%;\
	/else \
		/echo -- %-1%;\
	/endif

/addh info \
Wenn die ueber die Config-Hierarchie-Namen bestimmte Variable noch nicht gesetzt ist, wird sie auf den Wert des letzten Parameters gesetzt
/addh return Variablenname
/addh syn /cfg_set Config-Hierarchie-Namen Wert
/addh ex /cfg_set USE LOADING 1
/addh cfg_set mak

/def cfg_set = \
     /cfg_var_name %-L%;\
     /let cfg_var=%?%;\
     /set_var %cfg_var %L%;\
     /return cfg_var

/addh info \
Die ueber die Config-Hierarchie-Namen bestimmte Variable wird auf den Wert des letzten Parameters gesetzt.
/addh return Variablenname
/addh syn /cfg_init Config-Hierarchie-Namen Wert
/addh ex /cfg_init USE LOADING 1
/addh cfg_init mak

/def cfg_init = \
     /cfg_var_name %-L%;\
     /let cfg_var=%?%;\
     /set %cfg_var=%L%;\
     /return cfg_var
     
/addh info \
Liefert den Wert der ueber die Config-Hierarchie-Namen bestimmten Variable.
/addh syn /cfg_get Config-Hierarchie-Namen
/addh ex /cfg_get USE LOADING
/addh cfg_get mak

/def cfg_get = \
     /cfg_var_name %*%;\
     /return %?

/def cfg_navi_all = \
     /return strcat(cfg_navi_gui()," ",cfg_navi_intern())

/def cfg_navi_intern = \
     /if ({*}=~"") /return ""%; /endif%;\
     /return strcat("(",toupper(replace(" ","->",{*})),")")

/def cfg_navi_gui = \
     /if ({*}=~"") /return ""%; /endif%;\
     /cfg_get_path_info %*%;\
     /return {?}

/def cfg_get_var = \
     /let cfg_key=%L%;\
     /cfg_get_info %*%;\
     /let cfg_value=%?%;\
     /if (cfg_value=/"*:*") \
	/let cfg_value=$[substr(cfg_value,strchr(cfg_value,":")+1)]%;\
	/if (cfg_value=/"[0-9]*") \
	   /let cfg_params=%-L %cfg_key%;\
;/let cfg_params%;\
	   /get_param # %cfg_params%;\
	   /let cfg_count=%?%;\
	   /let count=0%;\
	   /let params=%;\
	   /while (++count<=cfg_count) \
	      /if (cfg_value!/strcat("*",count,"*")) \
		 /get_param %count %cfg_params%;\
		 /let params=%params %?%;\
	      /endif%;\
	   /done%;\
;	   /echo New Params: %params%;\
	   /return params%;\
; todo parameter 1 4 3 weglassen
	/else \
; direkter varname
	   /return cfg_value%;\
	/endif%;\
     /else \
	/return {*}%;\
     /endif%;

/def configure = \
;     /echo configure: %#: %*%;\
     /let cfg_param=%*%;\
     /if (!{#} |{L}!~toupper({L})) \
         /echo -auCmagenta  Konfiguration: $[cfg_navi_gui({*})] (<RETURN> wechselt hoch, "q" beendet)%;\
	 /cfg_get_config %*%;\
	 /let menu_text=%?%;\
;/echo %menu_text%;\
;	 /sort_params_quick %menu_text%;\
;	 /let menu_text=%{?}%;\
	 /simple_menu %menu_text%;\
	 /let cfg_choice=%?%;\
	 /if (cfg_choice>0) \
	    /cfg_list_name %*%;\
	    /let list_name=%?%;\
	    /getikey %list_name $[cfg_choice-1]%;\
	    /let cfg_key=%?%;\
 	    /if (cfg_key=~toupper(cfg_key)) \
	       /cfg_get_var %* %cfg_key%;\
	       /let cfg_var=%?%;\
	       /get_param # %cfg_var%;\
	       /if ({?}>1) \
	          /config_var %cfg_var%;\
	       /else \
; Nur Variablenname
	          /config_var %* %cfg_key %cfg_var%;\
	       /endif%;\
 	    /else \
	      /configure %* %cfg_key%;\
	      /let cfg_choice=%?%;\
	    /endif%;\
	 /endif%;\
     /else \
        /config_var %*%;\
	/let cfg_param=%-L%;\
     /endif%;\
     /if (cfg_choice>0) \
        /configure %cfg_param%;\
	/let cfg_choice=%?%;\
     /elseif (cfg_choice==0) \
        /get_param # %cfg_param%;\
	/if ({?}) \
	  /get_param -L %cfg_param%;\
          /configure %?%;\
	  /let cfg_choice=%?%;\
	/endif%;\
     /endif%;\
     /return cfg_choice

/def config_var_input = \
    /let varname=%L%;\
;/echo config_var_input varname: %varname%;\
    /hilfe %varname%|\
    /if ({?}) \
	/line%;\
	/hilfe %varname%;\
	/line%;\
    /endif%;\
    /echo $[strcat("Wert fuer ",cfg_navi_gui({-L}),": ")]%;\
    /test ext_read("Wert: ",%varname)%;\
    /let cfg_value=%?%;\
    /if /test cfg_value!~%varname%; /then \
	/cfg_check %varname %cfg_value%;\
	/if ({?}) \
	    /set %varname=%cfg_value%;\
	    /cfg_save %-L %varname%;\
	    /cfg_update %varname%;\
	/else \
	    /info error Fehler fuer Datentyp $[cfg_get_type(varname)]: Wert: %cfg_value%;\
	/endif%;\
    /endif%;

/set cfg_color_list=(black|red|green|yellow|blue|magenta|cyan|white)
/eval /set cfg_attr_check=^(([nxgGurfdBbh]|C(%cfg_color_list|bg%cfg_color_list))[ ,]?)*\$

/def cfg_check = \
    /let cfg_type=$[cfg_get_type({1})]%;\
/echo %1: %cfg_type%;\
    /if (cfg_type=~"color") \
        /return regmatch(cfg_attr_check, {-1})%;\
    /elseif (cfg_type=~"number") \
        /return regmatch("^ *[+-]?[0-9]+ *\$", {-1})%;\
    /elseif (cfg_type=~"flag") \
        /return regmatch("^ *(0|1) *\$", {-1})%;\
    /else \
        /return 1%;\
    /endif


/def cfg_get_type = \
    /hgetlistvalueof help %1%;\
    /let cfg_help=%?%;\
    /if (cfg_help=~error) \
        /hgetlistvalueof help $[tolower({1})]%;\
	/let cfg_help=%?%;\
    /endif%;\
    /if (cfg_help!~error) \
        /getvalueof cfg_help dtype%;\
	/let cfg_value=%?%;\
	/if (cfg_value!~error) /return cfg_value%; /endif%;\
     /endif%;\
     /if ({1}=/"*color*" | {1}=/"*attr*") /return "color"%; /endif%;\
     /return "text"%;

/def cfg_update = \
    /hgetlistvalueof help %1%;\
    /let cfg_help=%?%;\
    /if (cfg_help=~error) \
        /hgetlistvalueof help $[tolower({1})]%;\
	/let cfg_help=%?%;\
    /endif%;\
    /if (cfg_help!~error) \
        /getvalueof cfg_help update%;\
	/let cfg_value=%?%;\
	/if (cfg_value!~error & cfg_value=/"/*") \
/info info Updating via: %cfg_value%;\
	    /eval %cfg_value%;\
	    /return%;\
	/endif%;\
     /endif%;\
     /if ({1}=/"*status*") \
/info info Updating via: /config_status%;\
        /config_status%; \
     /endif%;
     
/addh info \
Speichert die angegebene Liste ab, wenn sie schon geladen wurde, wird der Zielort aus der Liste lists genommen, sonst wird er aus der Config-Hierarchier per /cfg_get_dest ermittelt, die Liste dahin gespeichert und an die jeweilige user_config.cfg das Ladekommando angehaengt.
/addh see cfg_save
/addh cfg_save_list mak

/def cfg_save_list = \
     /let cfg_name=%L%;\
     /getvalueof lists %cfg_name%;\
     /let cfg_dest=%?%;\
     /if (cfg_dest!~error) \
        /get_param -1 %cfg_dest%;\
	/let cfg_dest=%?%;\
	/info info Saving modified List: %cfg_name%;\
	/savelist -q %cfg_dest%;\
     /else \
        /echo -aCred List %cfg_name not loaded!%;\
	/cfg_get_dest %-L%;\
        /let cfg_dest=-a %?%;\
	/savelist %cfg_dest %cfg_name%;\
        /custom %cfg_dest%;\
	/test %?%;\
        /let cfg_file=%{load_dir}user_config.cfg%;\
	/info info Saving modified List: %cfg_name to destination: %{load_dir}%cfg_name%;\
        /let cfg_cmp_line=/loadlist*%cfg_name%;\
        /let cfg_line=/loadlist %cfg_dest %cfg_name%;\
        /cfg_mod_file%;\
     /endif%;\
     /cfg_update %cfg_name%;\

     
/def config_var = \
	/let line=%;\
	/if (isVar({L})) \
	  /if (isList({L})!~error) \
	     /let tmp=%;\
	     /test tmp:=%L%;\
	     /editlistvalues %L%;\
	     /if /test tmp!~%L%; /then \
	        /cfg_save_list %-L %L%;\
	     /endif%;\
; todo /editlist!	  
;	  /elseif (ishList({L})) \
;	  /elseif (is_hook({L})) \
;	     /edit_hook %L%;\
	  /else \
	     /config_var_input %*%;\
	  /endif%;\
; 	   /let varname=%L%;\
; 	   /hilfe %varname%;\
; 	   /echo $[strcat("Wert fuer ",cfg_navi_gui({-L}),": ")]%;\
; 	   /test ext_read("Wert: ",%varname)%;\
; 	   /let cfg_value=%?%;\
; 	   /set %varname=%cfg_value%;\
; 	   /cfg_save %-L %varname%;\
	/else \
	  /let varname=%L%;\
	  /listvar -s -msimple %varname%|\
	  /let var_count=%?%;\
;	  /listvar -s -msimple %varname%;/echo -aCcyan 0. %varname %var_count%;\
;	  /listvar -s -mregexp ^%varname%|\
;	  /let var_count=%?%;\
;/listvar -s -mregexp ^%varname%;/echo -aCcyan 1. %varname %var_count%;\
	  /let cfg_varlist=1%;\
	  /if (var_count==0) \
	    /let cfg_varlist=0%;\
	    /cfg_var_name %*%;\
	    /let varname=%?%;\
	    /listvar -s -mregexp %varname%|\
;/echo -aCcyan 2. %varname %var_count%;\
	    /let var_count=%?%;\
	  /endif%;\
	  /if (var_count==0) \
; sollte nicht vorkommen!
	     /info error Keine Konfigurationsvariable gefunden für %{*}%;\
	     /cfg_var_name %*%;\
	     /config_var_input %* %?%;\
; 	     /echo $[strcat("Wert fuer ",cfg_navi_gui({*}),": ")]%;\
; 	     /test ext_read("Wert: ")%;\
; 	     /cfg_init %* %?%;\
; 	     /cfg_save %* %?%;\
	  /elseif (var_count==1) \
	     /listvar -s -mregexp %varname%|\
	     /test tfread(line)%;\
;/let line%;\
	     /test regmatch({L},line)%;\
	     /let params=%-L %{P0}%{PR}%;\
	     /cfg_var_name %params%;\
	     /config_var_input %params %?%;\
; 	     /hilfe %?%;\
; 	     /cfg_get %params%;\
; 	     /let cfg_value=%?%;\
; 	     /echo $[strcat("Wert fuer ",cfg_navi_gui(params),": ")]%;\
; 	     /test ext_read(strcat("Wert: "),cfg_value)%;\
; 	     /let cfg_value=%?%;\
; 	     /cfg_init %params %cfg_value%;\
; 	     /cfg_save %params %?%;\
	  /else \
	    /let line=%;\
	    /let menu_text=%;\
	    /listvar -s -mregexp %varname%|\
	    /while (tfread(line)>-1) \
	       /test (regmatch({L},line))%;\
	       /let menu_text=%menu_text $[strcat({P0},{PR})]%;\
	    /done%;\
	    /let old_pedantic=%pedantic%;\
	    /set pedantic=0%;\
	    /qsort strcmp %menu_text%;\
;	    /sort_params_quick %menu_text%;\
	    /let menu_text=%?%;\
	    /set pedantic=%old_pedantic%;\
	    /echo -aBu Konfiguration: $[cfg_navi_gui({*})]%;\
	    /simple_menu %menu_text%;\
	    /let cfg_choice=%?%;\
	    /if (cfg_choice==0) \
	       /info warning Abbruch Konfiguration%;\
	    /else \
	        /get_param %cfg_choice %menu_text%;\
	        /let tmp=%?%;\
/let tmp%;\
		/if (cfg_varlist) \
                   /config_var %-L %tmp%;\
		/else \
		   /cfg_var_name %-L %tmp%;\
		   /let tmp=%?%;\
/let tmp%;\
		   /config_var %* %tmp%;\
	      /endif%;\
	    /endif%;\
	  /endif%;\
	/endif%;\

/def sort_params = \
     /if ({#}<2) /return {1}%; /endif%;\
     /if ({#}==2) \
        /if (strcmp({1},{2})>0) \
	   /return strcat({2}," ",{1})%;\
	/else /return strcat({1}," ",{2})%;\
     /endif%;\
;     /echo Params: %*%;\
     /let params=%;\
     /let i=0%;\
     /while (++i < {#}) \
        /if /test (strcmp({%i},{$[i+1]})>0)%; /then \
	    /test params:=strcat({-L$[({#}-i+1)]}," ",{$[i+1]}," ",{%i}," ",{-$[i+1]})%;\
;	    /echo %params%;\
            /sort_params %params%;\
	    /return {?}%;\
;	    /break%;\
	/endif%;\
     /done%;\
     /return {*}

/def sort_func = \
     /return strcmp({1},{2})<=0

/def sort_params_quick = \
;     /echo Params: %# %*%;\
     /if ({#}==0) /return%; /endif%;\
     /if ({#}==1) \
       /return {1}%;\
     /endif%;\
     /if ({#}==2) \
        /if (!sort_func({1},{2})) \
	   /return strcat({2}," ",{1})%;\
	/else \
	   /return strcat({1}," ",{2})%;\
	/endif%;\
     /endif%;\
     /let il=1%;\
     /let center=$[{#}/2]%;\
     /let center_value=%;\
     /test center_value:={%center}%;\
     /let left=%;\
     /let right=%;\
     /let ir=%{#}%;\
    /while (il<center | ir>center) \
       /while /test (il < center & sort_func({%il},center_value))%; /do \
	  /test left:=strcat(left," ",{%il})%;\
	  /test ++il%;\
       /done%;\
       /while /test (ir > center & !sort_func({%ir},center_value))%; /do \
	  /test right:=strcat({%ir}," ",right)%;\
	  /test --ir%;\
       /done%;\
       /if (ir>center) \
	  /test left:=strcat(left," ",{%ir})%;\
	  /test --ir%;\
       /endif%;\
       /if (il<center) \
	  /test right:=strcat({%il}," ",right)%;\
	  /test ++il%;\
       /endif%;\
    /done%;\
     /sort_params_quick %left%;\
     /let left=%?%;\
     /sort_params_quick %right%;\
     /let right=%?%;\
;       /echo Done %left %center_value %right%;\
     /return strcat(left," ",center_value," ",right)
     
/def clear_input = \
     /let line=%;\
     /let count=0%;\
     /while (tfread(line)) \
;        /echo clear_input $[++count] %line%;\
     /done%;\
     /test tfclose("i")

/def cfg_list_var = \
     /listvar CFG_%1_*

/def cfg_get_config = \
     /cfg_list_name %*%;\
     /let list_name=%?%;\
     /set cfg_get_config=%;\
     /foreach %list_name kv /cfg_get_config2%;\
     /return cfg_get_config

/def cfg_get_info = \
     /cfg_list_name %-L%;\
     /let list_name=%?%;\
     /getvalueof %list_name $[tolower({L})]%;\
     /let tmp=%?%;\
     /if (tmp!~error) /return tmp%; /endif%;\
     /getvalueof %list_name %{L}%;\
     /let tmp=%?%;\
     /if (tmp!~error) /return tmp%; /endif%;\
     /return ""

/def cfg_get_path_info = \
     /let count=%#%;\
     /let result=%;\
     /while (--count>0) \
        /get_param -L%count %*%;\
	/let tmp=%?%;\
	/cfg_get_info %tmp%;\
	/let tmp=%?%;\
	/if (tmp=/"*:*") /test tmp:=substr(tmp,0,strchr(tmp,":"))%; /endif%;\
	/let result=%result %tmp%;\
     /done%;\
     /cfg_get_info %*%;\
     /let tmp=%?%;\
     /if (tmp=/"*:*") /test tmp:=substr(tmp,0,strchr(tmp,":"))%; /endif%;\
     /let result=%result %tmp%;\
     /return replace(" ","->",substr(result,1))

/def cfg_get_config2 = \
     /let cfg_is_menu=$[(forEach_key!~toupper(forEach_key)) ? "+" : ""]%;\
     /if (forEach_value=/"*:*") \
        /set cfg_get_config=%{cfg_get_config} %{cfg_is_menu}$[substr(forEach_value,0,strchr(forEach_value,':'))]%;\
     /else \
        /set cfg_get_config=%{cfg_get_config} %{cfg_is_menu}%{forEach_value}%;\
     /endif%;\
	 
/addh info \
Liefert eine Verkettung der Parameter mit cfg_ davor. Wird fuer konfigurierte Variablennamen und cfg-Listen verwendet.
/addh see cfg_var_name, cfg_list_name
/addh syn /cfg_name Config-Hierarchie-Namen
/addh cfg_name mak

/def cfg_name = \
     /let list_name=cfg%;\
     /while ({#}) \
        /let list_name=%{list_name}_$[tolower({1})]%;\
	/shift%;\
     /done%;\
     /return list_name     

/addh info \
Liefert einen Variablennamen fuer die angegebenen Config-Hierarchie-Namen.
/addh see cfg_var_name, cfg_list_name
/addh syn /cfg_var_name Config-Hierarchie-Namen
/addh return Variablenname CFG_* (alles grossgeschrieben)
/addh cfg_var_name mak

/def cfg_var_name = \
     /cfg_name %*%;\
     /return toupper({?})

/def cfg_list_name = \
     /cfg_name %*%;\
     /return strcat(tolower({?}),"_list")

/addh info \
Fuegt in die Configurations-Hierarchie eine neue Variable ein. Dabei wird ueber die Config-Hierarchie-Namen der Platz im Baum angegeben.@{N}\
Der letzte Parameter ist eine Kurzbeschreibung fuer das Menue (Leerzeichen durch _ ersetzen).@{N}\
Wenn der vorletzte Parameter grossgeschrieben ist, weist er direkt auf eine zu konfigurierende Variable, sonst auf eine weitere Menuebene.@{N}\
Wenn hinter der Beschreibung ein ':' (Doppelpunkt) folgt, kann dahinter ein abweichender Variablenname angegeben werden (sonst wird er aus den Config-Hierarchie-Namen gebildet), auch koennen durch Doppelpunkt getrennte Zahlen folgen, die anzeigen, welche Config-Hierarchie-Namen bei der Variablennamensbildung ignoriert werden sollen.
/addh syn /cfg_info Config-Hierarchie-Namen [name|NAME] Menue_Text:[varname|ignoriere_hierarchieX[:ignoriere_hierarchieY]
/addh ex /cfg_info use Paketverwaltung@{N}\
/cfg_info use LOADING Laden_von_Files@{N}\
/cfg_info all loading SUFFIX Dateiendungen:file_suffixes -> anderer Varname@{N}\
/cfg_info status mg tanjian Tanjian:2 -> anderer Varname (CFG_STATUS_TANJIAN, 2==MG faellt weg)
/addh cfg_info mak

/def cfg_info = \
     /cfg_list_name %-L2%;\
     /let list_name=%?%;\
     /createnewlist %list_name%;\
     /uaddtolist %list_name %L2 %L

;/quote -S /unset `/listvar -s -mregexp cfg

/cfg_info all Generelles
/cfg_info use Paketauswahl
/cfg_info gui Oberflaeche
/cfg_info mud Mudspezifizisches

/cfg_info mud commands Kommandos

/cfg_info mud comm Kommunikation

/cfg_info all PEDANTIC  Korrektheitspruefung:pedantic
/cfg_info all DEBUG     Debuglevel
/cfg_info all LOADWORLD Weltdefinitionen_laden

/cfg_info gui MORE    More:more
/cfg_info gui HISTSIZE History:histsize
/cfg_info gui IHISTSIZE Eingabehistory
/cfg_info gui COLORS Farbliste
/cfg_info gui VISUAL Visual-Mode:visual

/cfg_info help	   Hilfe
/cfg_info connect  Connection	   


;/cfg_info USE BREAK_STRING
/cfg_info USE CRYPT Crypt_Kommunikation
/cfg_info USE HELP Hilfesystem
/cfg_info USE I18N Internationalisierung
/cfg_info USE KEYS Funktionstastenebenen
/cfg_info USE LOADING Laden_von_Files
/cfg_info USE PROPERTIES Spielerproperties
/cfg_info USE SSHLOAD TF_Files_ueber_SSH
/cfg_info USE STATUS Statuszeile
/cfg_info USE UNTROOM Untersuchehilfe
;/cfg_info USE UTIL
/cfg_info USE UTIL_ABBREV Abkuerzungsdefinition
/cfg_info USE UTIL_COMPLETION Eingabevervollstaendigung
; /cfg_info USE UTIL_ECHO
; /cfg_info USE UTIL_PROMPTS
; /cfg_info USE UTIL_QUOTE
; /cfg_info USE UTIL_REPEAT
; /cfg_info USE UTIL_SFUNC
; /cfg_info USE UTIL_STACK
/cfg_info USE UTIL_TIMER Timerfunktionen
;/cfg_info USE UTIL_TRIGGER
;/cfg_info USE UTIL_VFUNC
/cfg_info USE UTIL_WINDOWS Umleitung in Fenster
/cfg_info USE WAY Wegesystem
/cfg_info USE WORLDCONNECT Connection
/cfg_info USE XALIAS lokale_Aliase
;/cfg_info status (COLOR|TEXT)_TANJIAN Tanjian(Test)

