; $Log: status.tf,v $
; Revision 1.36  2002/12/06 16:17:59  mh14
; Gildenstatuszeile per /configure
;
; Revision 1.35  2002/12/05 13:13:54  mh14
; jetzt auch mudglobale, globale, spielerspez. Statuszeilendefinition
;
; Revision 1.34  2002/09/02 23:34:59  mh14
; breiten von statuszeileneintraegen koennen jetzt frei vergeben werden, mit {bla:10} diese ueberschreiben die Breiten aus den vordefinierten Eintraegen
;
; Revision 1.33  2002/06/14 14:59:39  mh14
; breitenangabe bei status_get_schaden_str
;
; Revision 1.32  2002/05/03 14:09:54  mh14
; status_breite dazu zum berechnen der statuszeilenbreite
;
; Revision 1.31  2002/04/17 01:17:39  mh14
; config debuggt
;
; Revision 1.30  2002/04/16 12:17:41  mh14
; config-system
;
; Revision 1.29  2002/04/11 17:57:15  mh14
; format_number3 fuer 3stellige Anzeige grosser Zahlen
;
; Revision 1.28  2002/04/11 12:58:12  mh14
; umbenennung von CFG_ALL_COLORS in  CFG_GUI_COLORS
;
; Revision 1.27  2002/04/03 12:27:08  mh14
; grummel
;
; Revision 1.26  2002/04/03 12:11:26  mh14
; bug bei Mail Flag, status_config_[set_]attr_named fuer benannte ConfigVariablen bei /set_status_var_*, _NEG als Suffix bei /set_status_var_count varname default breite max min (bei min<0)
;
; Revision 1.25  2002/03/31 18:48:31  mh14
; lauf gibt jetzt laufzeit+1 zurueck um rundungsproblem zu vermeiden
;
; Revision 1.24  2002/03/29 22:35:27  mh14
; CFG_* Variablen fuer /lauf, Farbe auch einstellbar, Uhrformat fuer Statuszeile einstellbar, Default 24h Anzeige, dep_var etc. nach util.vfunc.tf verschoben, set_status_var_count zur einfachen Definition von Statuszeilenmodulen, die auf Variablen mit einer festen Anzahl von Zustaenden basieren, Variablen fuer Statuszeilenmodule heissen jetzt CFG_STATUS_*
;
; Revision 1.23  2002/03/28 20:39:44  mh14
; grummel nochmal debuggt
;
; Revision 1.22  2002/03/28 20:28:10  mh14
; die lauftexte hoeren jetzt garantiert bei tastendruck auf
;
; Revision 1.21  2002/03/27 23:49:30  mh14
; lauf killt sich selbst bei Tastendruck, es gibt die voraussichtliche Laufzeit zurueck,debuggt
;
; Revision 1.20  2002/03/27 03:04:08  mh14
; hilfeeintrag debuggt, /lauf
;
; Revision 1.19  2002/03/27 01:21:13  mh14
; statuszeilenkonfiguration fuer farben/texte eingebaut, ausserdem generische makros fuer flags und gestaffelte numerische anzeigen (lp), statuszeilendoku etwas verbessert (status_line,status_help), abhaengige Variablen fuer Statuszeile integriert
;
; Revision 1.18  2002/02/10 22:31:52  mh14
; status_line und status_help als Userdokumentation der aktuellen bzw. moeglichen Statuszeileneintraege
;
; Revision 1.17  2002/01/28 10:57:55  mh14
; Mail erscheint jetzt als M in der statuszeile
;
; Revision 1.16  2001/12/08 22:39:25  mh14
; bug bei config_status ohne parameter raus
;
; Revision 1.15  2001/12/06 08:11:23  mh14
;  weitere farben fuer waffen
;
; Revision 1.14  2001/12/05 15:07:36  mh14
; neue schadensarten von thufhir
;
; Revision 1.13  2001/11/27 13:44:21  mh14
; * Anpassung von status_colors, fuer das nicht gepatchte tf
; Besseres Timing beim Neusetzen der Statuszeile (nur noch wenn Attribute
; geaendert) andere Herangehensweise fuer sl_*, status_func_name nutzen !
;
; * keep_value zum ausfuehren von expression ohne dass danach die variabe value
; veraendert ist
; * status_colors in set_status_cache und update_status_line aufgegliedert
;
; * status_var("name") erzeugt notwendige variablen (name,status_var_name) und
; gibt den richtig formatierten Statuszeileneintrag zurueck (fuer sl_*)
;
; * sl_example geaendert
;
; * format_number eingefuehrt fuer Tausender, *k(kilo), *M(ega)
; * sl_world, sl_modes angepasst
;
; Revision 1.12  2001/10/22 11:43:24  mh14
;  staendiges setzen der Statuszeile erzeugt zuviel last, daher jetzt 1 sek pause in status_colors
;
; Revision 1.11  2001/10/19 14:37:46  mh14
; Aenderungen an der Statuszeile, diese ist jetzt Schneller, hoffentlich Problematik der parallelen threads (globale Variable (value) behoben
;
; Revision 1.10  2001/10/10 22:10:21  mh14
; Default-Konfiguration in .tf Files verschoben
;
; Revision 1.9  2001/10/08 17:46:48  mh14
; generelle statusfunktionen aus allg_status.tf
;
; Revision 1.8  2001/10/07 16:59:32  mh14
; Beispiel fuer Modul, Module fuer world, modes, clock, bug aus config_status entfernt
;
; Revision 1.7  2001/09/26 12:07:22  nieten
; Hilfe korrigiert
;
; Revision 1.6  2001/09/25 13:17:44  nieten
; kein warning bzgl. last_status_colors mehr
;
; Revision 1.5  2001/09/17 02:38:17  mh14
;  Einfache Statuszeilendefinition nach Ollis Konzept, Beispiele in status.test
;
; Revision 1.4  2001/09/09 19:09:41  mh14
; help_de.list
;
; Revision 1.3  2001/09/06 21:11:44  mh14
;  Log eingefuegt
;

/set status_tf_version $Id$
/set status_tf_author=Mesirii@mg.mud.de
/set status_tf_requires=
/set status_tf_desc Statuszeile, die ihre Attribute selbst aendern kann

; ********************* BEGIN CONFIG ********************
/cfg_info status   Statuszeile
/cfg_info status line Definition 
/cfg_info status line GLOBAL Globale_Statuszeile:config_status_line
/cfg_info status line MUD mudglobale_Statuszeile:config_status_line
/cfg_info status line GUILD Gildenstatuszeile:config_status_line
/cfg_info status line PLAYER spielerspezifische_Statuszeile:config_status_line

/set_var config_status_line {world}____________________________________________________{modes}_{clock}

; kann in status.cfg stehen
;/rename_mac sc status_colors status

/cfg_info status std Standardsachen
/cfg_info status std CLOCK_FORMAT Uhrformat:2
/cfg_set STATUS CLOCK_FORMAT %H:%M

/cfg_info status LAUF Laufschrift
/cfg_info status lauf COLOR Farbe
/cfg_info status lauf STEP Schrittweite

/cfg_info status all Generelles
/cfg_info status all BACKGROUND Hintergrund:status_attr
/cfg_info status all PAD	Trenner:status_pad


/cfg_info status STATE_COLORS Zustandsfarben:state_colors

/createlist state_colors
/addtolist state_colors 100 BCblue
/addtolist state_colors 90 Cblue
/addtolist state_colors 80 BCgreen
/addtolist state_colors 70 Cgreen
/addtolist state_colors 60 BCyellow
/addtolist state_colors 50 Cyellow
/addtolist state_colors 40 BCred
/addtolist state_colors 30 Cred
/addtolist state_colors 20 Br
/addtolist state_colors 10 r

/set schadensarten=Feuer, Eis, Sturm, Magie, Krach, Wasser, Blitz, Pfeil, Messer,Felsen, Boese, Saeure, Terror, Peitsche, Quetschen, Explosion, Widerhaken und Gift, Heilig, Schwert, Keule, Messer, Speer

/cfg_info status MAGIE_COLORS Magiefarben:magie_colors
/createlist magie_colors
/addtolist magie_colors {satanisch*|boes*} D xBCblack,Cbgred
/addtolist magie_colors {lodernd*|flammen*|brennen*|feuer*|feurig*} F xBCred,Cbgyellow
/addtolist magie_colors {frostig*|eis*} E xBCwhite,Cbgblue
/addtolist magie_colors {blitz*} B xBCyellow
/addtolist magie_colors {gift*} G xBCgreen,Cbgyellow
/addtolist magie_colors {saeure*|aetzen*} S xBCgreen
/addtolist magie_colors {schreien*|kampfschreie|krach*} K xBCcyan
/addtolist magie_colors {waessrig*|fluessig*|wasser*} W xBCblue
/addtolist magie_colors {terror*|grauen*} T xBr
/addtolist magie_colors {heilig*|gut*} H xBCwhite,Cwhite
/addtolist magie_colors {luft*|stuerm*|sturm*} L xrBCbgblue
/addtolist magie_colors {magische*|magie*} M xBCyellow,Cbgred

/cfg_info status PHYS_COLORS Schadensfarben:phys_colors
/createlist phys_colors
/addtolist phys_colors {daumenschrauben|quetschen} q xCred,Cbgblue
/addtolist phys_colors {peitschenhiebe|peitsche} p xCyellow,Cbgblue
/addtolist phys_colors {felsbrocken|keule|stab|hammer|stock|kolben} k xCred,Cbgcyan
/addtolist phys_colors {messerschnitte|messer|schwert|dolch|axt} m xCred,Cbgwhite 
/addtolist phys_colors {pfeil|pfeile|speer|stachel|lanze} s xCgreen,Cbgblue
/addtolist phys_colors {widerhaken|reissen} r xCred,Cbgred
/addtolist phys_colors {magierschaedel|explosion|explosiv*} x xCwhite,Cbgblue
/addtolist phys_colors unbekannt u xr


; ********************* END CONFIG **********************
/init_var status_fields_cache status_count
/set last_status_colors=1

/addh info \
Funktion, die in status_var_xxx vor der eigentlichen Variablen aufgefuehrt werden muss, und die die Statuszeile bei jedem Aufruf (aber max. 1x pro Sekunde) neu setzt und damit die Farben bzw. Attribute an die Werte aller Variablen anpassen kann.
/addh ex \
/def status_color_a=/return (a<10)?"Cgreen":"Cred"@{N}\
/set status_field=a:10:$[status_color_a()]@{N}\
oder@{N}\
/set status_var_a=status_colors(a)@{N}\
Statuszeile@{N}\
/set status_field=a:10:$[(a<10)?"Cgreen":"Cred"]@{N}\
Basisstatuszeile, oder einmal /status_colors aufrufen@{N}\
/set status_fields=a:10

/addh status_colors func

/def rem_status_colors=\
	/if ((time()-last_status_colors)>1 | {#}) \
	  /repeat -0 1 /eval /eval /set status_fields=%%status_field%;\
	  /test last_status_colors:=time()%;\
	/endif%;

/def status_colors=\
	/if (!{#}) \
	  /update_status_line%;\
	  /return%;\
	/endif%;\
	/set_status_cache %1%;\
	/if /test (last_status_colors & status_cache_attr_%1!~status_attr_value_%1)%; /then \
	  /update_status_line%;\
	/endif%;\
	/return status_value_%1%;

/def set_status_cache = \
	/if (!{#}) /return%; /endif%;\
	  /let save_value=%;\
	  /test save_value:=value%;\
	  /init_var status_value_%1%;\
	  /init_var status_attr_value_%1%;\
	  /if (isVar(strcat("status_func_",{1}))) \
	     /eval /test status_value_%1:=(\%status_func_%1)%;\
	  /else \
	     /test status_value_%1:=%1%;\
	  /endif%;\
	  /set status_cache_%1=%;\
	  /test status_cache_%1:=%1%;\
	  /set status_cache_attr_%1=%;\
	  /test status_cache_attr_%1:=status_attr_value_%1%;\
	  /if (isVar(strcat("status_attr_",{1}))) \
	     /eval /test status_attr_value_%1:=(\%status_attr_%1)%;\
	  /endif%;\
	  /test value:=save_value%;\
	  /return status_value_%1%;

/def update_status_line = \
	    /set last_status_colors=0%;\
	    /repeat -0 1 \
	    /eval /set status_fields=%status_field\%;\
	    /repeat -1 1 /set last_status_colors=1%;\
	
/def keep_value = /let save_value=%;/let result=%;\
	/return save_value:=value,\
	        result:=%{*-1},\
	        value:=save_value,\
	        result

/def status_var = \
	/set status_var_%1=status_colors("%1")%;\
	/set status_cache %1%;\
	/result "%1:%2:%{3-\%status_attr_value_%1}"

/def status_help = \
     /echo Moegliche Eintraege in der Statuszeile:%;\
     /quote -S /status_help2 3 `/list -s sl_*%;\
     /quote -S /status_help2 12 `/listvar -s status_line_*%;\
     
/def status_help2 = \
     /let sl_name=$[substr({L},{1})]%;\
     /if (isVar(strcat("sl_",sl_name,"_doc"))) \
	 /eval /eval /echo -p @{Cblue}{%sl_name}:@{x} \%sl_%{sl_name}_doc%;\
     /else \
         /echo -p @{Cblue}{%sl_name}:@{x}%;\
     /endif%;

/def status_line = \
     /echo Aktuelle Statuszeilenkonfiguration:%;\
     /echo %config_status_line%;\
     /echo%;\
     /status_line2 %config_status_doc%;\

/def status_line2 = \
     /while ({#}) \
      /let sl_name=%1%;\
      /shift%;\
      /let tmp=@{Cblue}{%sl_name}:@{x}%;\
      /if (isVar(strcat("sl_",sl_name,"_doc"))) \
         /test tmp:=strcat(tmp," ",sl_%{sl_name}_doc)%;\
      /endif%;\
      /eval /echo -p %tmp%;\
     /done%;

/def status_doc_attr = \
     /let status_doc_color=%;\
     /let status_doc_attr=%;\
     /let status_doc_text=%;\
     /let result=%;\
     /while ({#}) \
       /test status_doc_attr:=CFG_STATUS_COLOR_%1%;\
       /test status_doc_color:=status_doc_attr%;\
       /if (status_doc_attr=~"") \
         /let status_doc_attr=n%;\
       /endif%;\
       /if  /test ({CFG_STATUS_TEXT_%1}!~"")%; /then \
          /test status_doc_text:=CFG_STATUS_TEXT_%1%;\
       /else \
          /test status_doc_text:={2}%;\
	  /shift%;\
       /endif%;\
       /test result:=strcat(result," @{",status_doc_attr,"}'",status_doc_text,"'@{x} (",status_doc_color,")")%;\
       /shift%;\
     /done%;\
     /return result%;

/addh info \
Einfache Statuszeilendefinition, die fast direkt so angegeben wird, wie sie spaeter aussehen soll. Dabei wird fast alles direkt uebernommen, nur die angegebenen Variablen werden entweder aus vorgefertigten, mitgelieferten Modulen entnommen oder (vorher) on the fly erzeugt; wenn beides nicht moeglich ist, wird die Variable direkt uebernommen. Die Aenderungen sind sofort sichtbar.
/addh syn /config_status Statuszeilendefinition
/addh ex /config_status __LP:{lp}_MP:{p_mp:6}__abc__!!!__ABC__{a}_{@world}_{insert:1}@{N}\
* Alle __ werden direkt umgesetzt, auch die Strings, nur die Variablen in {} erhalten eine besondere Behandlung.@{N}\
* Wenn ein Makro (Modul) namens sl_%{varname} vorhanden ist, wird dieses ausgefuehrt, um z.B. Attribute, Breiten, Trigger, Standardwerte zu definieren, und sein Ergebnis in die Statuszeile integriert.@{N}\
* Wenn eine Variable status_line_%{varname} vorhanden ist, wird angenommen, dass die Variablen bereits per /set_status_var_(num|string) definiert wurde und die status_line_%{varname} wird in die Statuszeile integriert.@{N}\
* Ansonsten wird die Variable direkt unter ihrem Namen in die Statuszeile eingetragen, ohne besondere Formatierung und Laengenangaben.@{N}\
* wenn eine Laengenangabe mit : angegeben wird, ueberschreibt diese die Laengenangabe in dem Makro oder dem schon definierten Statuszeileneintrag
/addh see set_status_var_num, set_status_var_string, status_colors
/addh config_status comm

/def config_status = \
;     /echo  [config_status] %*%;\
     /if (!{#}) \
	/let param_sl=%config_status_line%;\
     /else \
        /set config_status_line=%*%;\
        /let param_sl=%*%;\
     /endif%;\
     /set config_status_doc=%;\
     /let parsed_sl=%;\
     /let slc_pl=%; /let slc_pr=%; /let slc_p1=%;/let slc_len=%;\
     /while (regmatch("{([^:}]+)(:([0-9]+))?}",param_sl)) \
       /test slc_pl:={PL}%; /test slc_p1:={P1}%; /test slc_len:={P3}%;/test slc_pr:={PR}%;\
       /test slc_pl:=config_status_static(slc_pl)%;\
       /test parsed_sl:=strcat(parsed_sl,slc_pl)%;\
       /set config_status_doc=%config_status_doc %slc_p1%;\
       /let slc_entry=%;\
       /if (isMacro(strcat("sl_",slc_p1))) \
	   /test slc_entry:=sl_%{slc_p1}()%;\
       /elseif (isVar(strcat("status_line_",slc_p1))) \
          /test slc_entry:=status_line_%{slc_p1}%;\
       /else \
          /test slc_entry:=slc_p1%;\
       /endif%;\
       /if (slc_len!~"" & slc_len=/"[0-9]*") \
          /if (regmatch(":[0-9]+(:[^: ]+)?$",slc_entry)) \
	      /test slc_entry:=strcat({PL},":",slc_len,{P1})%;\
	  /else \
	      /test slc_entry:=strcat(slc_entry,slc_entry=/"*:" ? "" :  ":",slc_len)%;\
	  /endif%;\
       /endif%;\
       /test parsed_sl:=strcat(parsed_sl,slc_entry," ")%;\
       /test param_sl:={slc_pr}%;\
     /done%;\
     /test parsed_sl:=strcat(parsed_sl,config_status_static(param_sl))%;\
;     /test echo(parsed_sl)%;\
     /init_var status_field%;\
     /test status_field:=parsed_sl%;\
     /set last_status_colors=1%;\
;     /test last_status_colors:=time()-2%;\
     /status_colors

/add_to_hook first_connect /config_status


/addh info Liefert den Platz der in der aktuell eingestellten Statuszeile verbraucht wird.
/addh status_breite mak

/def status_breite = \
	/let param=%status_fields%;\
	/let result=0%;\
	/let reg=("([^" ]+)"[^:]|'([^ ']+)'[^:]|:([-0-9]+))%;\
	/while (regmatch(reg,param)) \
	   /test result:=result+abs({P4})+strlen({P2})+strlen({P3})%;\
	   /let param=%PR%;\
        /done%;\
	/result result

/addh info \
Parst und verarbeitet die statischen Elemente der Statuszeile wie _ und feste Strings.
/addh syn /config_status_static String mit nur statischen Elementen
/addh ex /config_status_static __MP:___LP:__!!!____abc__@{N}\
return: :2 "MP:" :3 "LP:" :2 "!!!" :4 "abc" :2
/addh see config_status
/addh return verabeiteter String
/addh config_status_static mak
/def config_status_static = \
     /let param=%; /test param:={*}%;\
     /let res=%;\
     /while (strlen(param)>0 & regmatch("(_*)([^_]*)",param)) \
        /test res:=strcat(res,{PL})%;\
        /if ({P1}!~"") \
          /test res:=strcat(res,":",strlen({P1})," ")%;\
	/endif%;\
        /if ({P2}!~"") \
          /test res:=strcat(res,'"',{P2},'" ')%;\
	/endif%;\
	/test param:={PR}%;\
     /done%;\
     /return strcat(res,param)%;

/addh info \
Definiert eine numerische Variable fuer die Statuszeile sofort (on the fly). Die Attribute werden fuer eine Vergleichsliste angegeben (siehe /attr_ordered). Wenn statt des Defaultwertes der Variablenname noch einmal angegeben wird, wird diese Variable nur per Selbstzuweisung initialisiert (d.h. bleibt unveraendert, wenn schon existent).
/addh syn /set_status_var_num varname defaultwert breite vglwert1 attr1 vglwert2 attr2 default_attr
/addh ex /set_status_var_num lp 220 3 80 Cred 160 Cyellow Cgreen
/addh see attr_ordered
/addh set_status_var_num mak

/def set_status_var_num = \
  /if ({1}=~{2}) \
     /init_var %1%;\
  /else \
     /set %1=%2%;\
  /endif%;\
  /let param=$[({1}=/"p_*") ? substr({1},2) : {1} ]%;\
  /status_config_set_attr c %1 < . %-3%;\
  /set status_attr_%1=%?%;\
  /set status_func_%1=%1%;\
  /set status_line_%param=$[status_var({1},{3})]%;\
  /return status_line_%param

/addh info\
Definiert eine Variable fuer die Statuszeile sofort (on the fly). Die Informationen zur Darstellung werden aus den Konfigurationsvariablen fuer Farbe und Text geholt (CFG_STATUS_COLOR_VARNAME*, CFG_STATUS_TEXT_VARNAME*)@{N}\
Wenn statt des Defaultwerts der Variablenname noch einmal angegeben wird, wird die Variable per Selbstzuweisung aktualisiert

/addh syn /set_status_var_string varname defaultwert|varname breite text1 text2 text3 ...
/addh ex /set_status_var_string p_align p_align 3 heilig gut nett neutral frech boese satanisch

/addh set_status_var_string mak

/def set_status_var_string = \
  /if ({1}=~{2}) \
     /init_var %1%;\
  /else \
     /set %1=%2%;\
  /endif%;\
  /let param=$[({1}=/"p_*") ? substr({1},2) : {1} ]%;\
  /status_config_attr c %1 =~ " %-3%;\
  /set status_attr_%1=%?%;\
  /status_config_attr t %1 =~ " %-3%;\
  /set status_func_%1=%?%;\
  /set status_line_%param=$[status_var({1},{3})]%;\
  /return status_line_%param

/addh info \
Methoden um Statuszeilenvariablen die auf Flags basieren, on the Fly zu definieren, dabei werden wenn vorhanden und gewuenscht Konfigurationsvariablen fuer Attribute (CFG_STATUS_COLOR_*) und Texte (CFG_STATUS_TEXT_*) genutzt werden (ggf. auch fuer ausgeschalteten Status (CFG_STATUS_COLOR_*_OFF,CFG_STATUS_TEXT_*_OFF))@{N}\
Wenn Farb- und Textinformationen angegeben werden, werden mit diesen Werten die entsprechenden Konfigurationsvariablen gesetzt (s.o.)

/addh syn /set_status_var_flag varname default breite [Text_an Attr_an [Text_aus Attr_aus]]

/addh ex /set_status_var_flag p_frog 0 1@{N}\
/set_status_var_flag p_blind 0 1 B Cbgmangenta@{N}\
/set_status_var_flag p_block 0 1 + Cyellow - n

/addh set_status_var_flag mak

/def set_status_var_flag = \
    /set_status_var_count %1 %2 %3 1%;\

/addh info \
Setzen von Statuszeilendefinitionsmodulen on the fly fuer Variablen die aufsteigende numerische Werte enthalten (0..max oder min..0..max)
/addh syn /set_status_var_count varname (default|varname) breite max [min]
/addh ex /set_status_var count p_align p_align 1 3 -3
/addh set_status_var_count mak

/def set_status_var_count = \
  /if ({1}=~{2}) \
     /init_var %1%;\
  /else \
     /set %1=%2%;\
  /endif%;\
  /let param=$[({1}=/"p_*") ? substr({1},2) : {1} ]%;\
  /let tmp=0%;\
  /while (++tmp<={4}) \
    /let status_var_count=%status_var_count %tmp %tmp%;\
  /done%;\
  /if ({#}>4) \
  /let tmp=0%;\
  /while (--tmp>={5}) \
    /let status_var_count=%status_var_count %tmp NEG_$[-tmp]%;\
  /done%;\
  /endif%;\
  /status_config_attr_named c %1 == . %status_var_count%;\
  /set status_attr_%1=%?%;\
  /status_config_attr_named t %1 == . %status_var_count%;\
  /set status_func_%1=%?%;\
  /set status_line_%param=$[status_var({1},{3})]%;\
  /return status_line_%param

/def rem_set_status_var_flag = \
  /if ({1}=~{2}) \
     /init_var %1%;\
  /else \
     /set %1=%2%;\
  /endif%;\
  /let param=$[({1}=/"p_*") ? substr({1},2) : {1} ]%;\
  /let tmp=$[status_get_config_name({1})]%;\
  /if ({#}>3) \
     /set CFG_STATUS_COLOR_%{tmp}=%5%;\
     /set CFG_STATUS_TEXT_%{tmp}=%4%;\
  /endif%;\
  /if ({#}>5) \
     /set CFG_STATUS_COLOR_%{tmp}_OFF=%7%;\
     /set CFG_STATUS_TEXT_%{tmp}_OFF=%6%;\
  /endif%;\
  /set status_line_%param=$[status_var({1},{3})]%;\
  /if (isVar(strcat("CFG_STATUS_TEXT_",{tmp},"_OFF"))) \
     /set status_func_%1=%1 ? CFG_STATUS_TEXT_%{tmp} : CFG_STATUS_TEXT_%{tmp}_OFF%;\
  /else \
     /set status_func_%1=%1 ? CFG_STATUS_TEXT_%{tmp} : ""%;\
  /endif%;\
  /if (isVar(strcat("CFG_STATUS_COLOR_",{tmp},"_OFF"))) \
     /set status_attr_%1=%1 ? CFG_STATUS_COLOR_%{tmp} : CFG_STATUS_COLOR_%{tmp}_OFF%;\
  /else \
    /if (isVar(strcat("CFG_STATUS_TEXT_",{tmp},"_OFF"))) \
       /set status_attr_%1=%1 ? CFG_STATUS_COLOR_%{tmp} : "n"%;\
    /else \
       /test status_line_%param:=status_var({1},{3},CFG_STATUS_COLOR_%{tmp})%;\
    /endif%;\
  /endif%;\
  /return status_line_%param


/addh info liefert den Konfigurationsvariablennamen fuer die angegebene Variable zurueck, es gibt Konfigurationen fuer Farbe und Text. Ein uebergebener Suffix wird mit angehaengt
/addh syn /status_get_config_name varname [c|t|beliebig] beliebiger suffix
/addh ex /status_get_config_name p_frog c@{N}\
      /status_get_config_name p_lp c 1@{N}\
      /status_get_config_name p_block t OFF@{N}\
/addh status_get_config_name mak

/def status_get_config_name = \
    /let result=$[toupper( ({1}=/"p_*") ? substr({1},2) : {1} )]%;\
    /if ({#}>1) \
       /if ({2} =/ "c") /let result=CFG_STATUS_COLOR_%result%;\
       /elseif ({2} =/ "t") /let result=CFG_STATUS_TEXT_%result%;\
       /else /let result=%{2}_%result%;\
       /endif%;\
       /if ({#}>2) \
         /let result=%result_%{-2}%;\
       /endif%;\
    /endif%;\
    /return result%;


; /def rem_set_status_var_string = \
;   /set %1=%2%;\
;   /if ({#}>3) \
;     /set status_var_%1=status_colors(),(%1!~"")?%1:%4%;\
;   /else \
;     /set status_var_%1=status_colors(),%1%;\
;   /endif%;\
;   /if ({#}>4) \
;     /set status_attr_%1=(%1!~"")?%5:%{6-n}%;\
;   /else /set status_attr_%1=n%;\
;   /endif%;\
;   /set status_size_%1=%3%;\
;   /set status_line_%1=$[strcat({1},":\\$[test(status_size_",{1},")]:\\$[test(status_attr_",{1},")]")]%;\
;   /return strcat({1},":\$[test(status_size_",{1},")]:\$[test(status_attr_",{1},")]")

/addh info formatiert eine grosse Zahl mittels angehaegter k bzw. M und den restlichen vorangehenden Stellen
/addh ex /format_number 1000 -> 1k; /format_number 1000000 -> 1M
/addh format_number mak

/def format_number = \
     /return ({1}<1000) ? {1} : \
	     ({1}<1000000) ? strcat(substr({1},0,-3),"k") : \
	                     strcat(substr({1},0,-6),"M")

/addh info Formatiert eine Zahl so, dass sie auch auf 3 Stellen erkennbar ist, z.b. 999=999 9999=9k9 99999=99k 999999=M99
/addh format_number3 mak

/def format_number3 = \
     /result substr(({1}<1000) ? {1} : \
	     ({1}<100000) ? strcat(substr({1},0,-3),"k",substr({1},-3)) : \
	                     strcat(substr({1},0,-6),"M",substr({1},-6)),0,{2-3})
          
/addh info \
Erzeugt einen Ausdruck, der den ersten Parameter (Varname) mit den jeweils folgenden vergleicht und die angegebenen Attribute zurueckgibt.
/addh syn /attr_ordered varname vglwert1 attr1 vglwert2 attr2 .. default_attr
/addh ex /attr_ordered lp 80 Cred 160 Cyellow Cgreen
/addh attr_ordered mak


/def attr_ordered = \
     /let param=%1%; /shift%;\
     /let result=%;\
     /while ({#}>1) \
       /test result:=strcat(result,param,'<',{1},'?"',{2},'" :')%;\
       /shift 2%;\
     /done%;\
     /return strcat(result,'"',{1-n},'"')%;

/addh info Liefert einen Vergleichsausdruck für die Variable (%1), mit dem Operator (%2). Dabei kann angegeben werden, ob die Vergleichswerte Strings sind (%3 ist " oder ') und ob die Ergebnisswerte Strings oder Variablennamen sind (%4 ist ' oder " bei String), in %5+2*i stehen die Vergleichswerte, und in %6+2*i die Ergebniswerte
/addh syn /attr_ordered_cmp varname operator ['".] ['".] compare1 result1 compare2 result2 ... [result_default]
/addh ex /attr_ordered_cmp hp < . . maxhp/3 COLOR_HP_33 maxhp*2/3 COLOR_HP_66 COLOR_HP
/addh attr_ordered_cmp mak

/def attr_ordered_cmp = \
     /let param=%1%; /shift%;\
     /let operator=%1%; /shift%;\
     /let cmp_var=$[status_get_quote({1})]%; /shift%;\
     /let attr_var=$[status_get_quote({1})]%; /shift%;\
     /let result=%;\
     /while ({#}>1 & {2}!~"") \
       /test result:=strcat(result,param,operator,cmp_var,{1},cmp_var,'?',attr_var,{2},attr_var,' :')%;\
       /shift 2%;\
     /done%;\
     /if ({#} & {1}!~"") \
       /return strcat(result,attr_var,{1},attr_var)%;\
     /else \
       /return strcat(result,'"n"')%;\
     /endif%;

/addh info liefert wenn ein TF-Quote Zeichen uebergeben wurde dieses zurueck, sonst einen Leerstring
/addh status_get_quote mak

/def status_get_quote = \
     /return ({1}=~"'" | {1}=~'"') ? {1} : ""%;

/def attr_ordered_str = \
     /let param=%1%; /shift%;\
     /let result=%;\
     /while ({#}>1) \
       /test result:=strcat(result,param,'=~"',{1},'"?"',{2},'" :')%;\
       /shift 2%;\
     /done%;\
     /return strcat(result,'"',{1-n},'"')%;


/addh info \
Gibt einen TF-Ausdruck zurueck, der die uebergebene Variable mit dem Operator mit den Vergleichswerten vergleicht und die korrekten Statuskonfigurationsvariablen als Ergebniswerte einsetzt (abhaengig vom ersten Parameter), ausserdem werden die Konfigurationsvariablen gleich auf die uebergebenen Werte gesetzt.@{N}\
Die Konfigurationsvariablen werden einfach aufsteigend nummeriert.
/addh syn /status_config_set_attr [c|t] varname operator ['".] vergleichswert1 Configwert1 vergleichswert2 Configwert2 ... [DefaultConfigWert]
/addh ex /status_config_set_attr c p_lp < . 60 Cred 120 Cyellow Cgreen@{N}\
/status_config_set_attr t p_align =~ ' gut + neutral * boese -
/addh see status_config_attr
/addh status_config_set_attr mak

/def status_config_set_attr = \
     /let config_type=%1%;\
     /let param=%2%;\
     /let operator=%3%;\
     /let cmp_var=$[status_get_quote({4})]%;\
     /let config_name=$[status_get_config_name(param,{1})]%;\
     /shift 4%;\
     /let result=%;\
     /let count=0%;\
     /while (++count & {#}>1) \
       /set %{config_name}_%{count}=%2%;\
       /let result=$[strcat(result,param,operator,cmp_var,{1},cmp_var,'?',config_name,'_',count,' :')]%;\
       /shift 2%;\
     /done%;\
     /if (!{#} | {1}=~"") \
       /if (config_type=~"c") \
         /set %config_name=n%;\
       /else \
         /set %config_name=%;\
       /endif%;\
    /else \
       /set %config_name=%1%;\
    /endif%;\
    /return strcat(result,config_name)%;\

/addh info \
Gibt einen TF-Ausdruck zurueck, der die uebergebene Variable mit dem Operator mit den Vergleichswerten vergleicht und die korrekten Statuskonfigurationsvariablen als Ergebniswerte einsetzt (abhaengig vom ersten Parameter), ausserdem werden die Konfigurationsvariablen gleich auf die uebergebenen Werte gesetzt. @{N}\
Dabei erhalten die Konfigurationsvariablen jeweils den angegebenen Suffix.
/addh syn /status_config_set_attr [c|t] varname operator ['".] vergleichswert1 ConfigSuffix1 Configwert1 vergleichswert2 ConfigSuffix2 Configwert2 ... [[ConfigSuffixDefault] DefaultConfigWert]
/addh ex /status_config_set_attr c p_lp < . 60 THIRD Cred 120 TWOTHIRD Cyellow FULL Cgreen@{N}\
/status_config_set_attr t p_align =~ ' gut + neutral * boese -
/addh see status_config_attr
/addh status_config_set_attr mak
/def status_config_set_attr_named = \
     /let config_type=%1%;\
     /let param=%2%;\
     /let operator=%3%;\
     /let cmp_var=$[status_get_quote({4})]%;\
     /let config_name=$[status_get_config_name(param,{1})]%;\
     /shift 4%;\
     /let result=%;\
     /let count=0%;\
     /while (++count & {#}>2) \
       /set %{config_name}_%{2}=%3%;\
       /let result=$[strcat(result,param,operator,cmp_var,{1},cmp_var,'?',config_name,'_',{2},' :')]%;\
       /shift 3%;\
     /done%;\
     /if (!{#} | {1}=~"") \
       /if (config_type=~"c") \
         /set %config_name=n%;\
       /else \
         /set %config_name=%;\
       /endif%;\
     /else \
       /if ({#}>1) \
         /set %config_name_%1=%2%;\
       /else \
         /set %config_name=%1%;\
       /endif%;\
    /endif%;\
    /return strcat(result,config_name)%;\

/addh info \
Gibt einen TF-Ausdruck zurueck, der die uebergebene Variable mit dem Operator mit den Vergleichswerten vergleicht und die korrekten Statuskonfigurationsvariablen als Ergebniswerte einsetzt (abhaengig vom ersten Parameter). Die Konfigurationsvariablen werden einfach aufsteigend nummeriert.
/addh syn /status_config_attr [c|t] varname operator ['".] vergleichswert1 vergleichswert2 
/addh ex /status_config_attr c p_lp < . 60 120@{N}\
/status_config_attr t p_align =~ ' gut neutral boese
/addh see status_config_attr
/addh status_config_attr mak

/def status_config_attr = \
     /let config_type=%1%;\
     /let param=%2%;\
     /let operator=%3%;\
     /let cmp_var=$[status_get_quote({4})]%;\
     /let config_name=$[status_get_config_name(param,{1})]%;\
     /shift 4%;\
     /let result=%;\
     /let count=0%;\
     /while (++count & {#}) \
       /let result=$[strcat(result,param,operator,cmp_var,{1},cmp_var,'?',config_name,'_',count,' :')]%;\
       /shift%;\
     /done%;\
       /if (isVar(config_name)) \
           /return strcat(result,config_name)%;\
       /else \
	 /if (config_type=~"c") \
           /return strcat(result,'"n"')%;\
	 /else \
           /return strcat(result,'""')%;\
	 /endif%;\
       /endif%;\

/def status_config_attr_named = \
     /let config_type=%1%;\
     /let param=%2%;\
     /let operator=%3%;\
     /let cmp_var=$[status_get_quote({4})]%;\
     /let config_name=$[status_get_config_name(param,{1})]%;\
     /shift 4%;\
     /let result=%;\
     /let count=0%;\
     /while (++count & {#}>1) \
       /let result=$[strcat(result,param,operator,cmp_var,{1},cmp_var,'?',config_name,'_',{2},' :')]%;\
       /shift 2%;\
     /done%;\
       /if (isVar(config_name)) \
           /return strcat(result,config_name)%;\
       /else \
	 /if (config_type=~"c") \
           /return strcat(result,'"n"')%;\
	 /else \
           /return strcat(result,'""')%;\
	 /endif%;\
       /endif%;\

/def status_get_schaden_attr = \
	/if ({1}!~"") \
	  /set status_schaden_string=%{1}%;\
	/else \
	  /set status_schaden_string=%;\
	/endif%;\
	/status_get_schaden_string %{2} %4%;\
	/if ({#}>2) \
	/set %3=%status_schaden_attr%;\
	/endif%;\
	/return status_schaden_attr%;

/def status_get_schaden_string= \
    /if ({L}=/"[0-9]") \
       /let status_schaden_len=%L%;\
    /endif%;\
    /if (status_schaden_string!~"") \
	/set status_schaden_string2=%status_schaden_string%;\
	/let status_param_text=1%;\
	/set status_schaden_string=%;\
    /else /let status_param_text=0%;\
    /endif%;\
    /let status_schaden=$[replace(","," ",tolower({*}))]%;\
    /set status_schaden_attr=%;\
    /set status_schaden_short=%;\
    /set status_schaden_attr_only=%;\
    /forEach magie_colors kv /status_get_schaden_string2%;\
    /forEach phys_colors kv /status_get_schaden_string2%;\
    /if (status_schaden_string2!~"") \
	/set status_schaden_attr=%status_schaden_attr "%status_schaden_string2":$[strlen(status_schaden_string2)]%; \
	/set status_schaden_short=%{status_schaden_short}%{status_schaden_string2}%;\
	/set status_schaden_string2=%; \
    /endif%;\
    /if (status_schaden_len!~"" & strlen(status_schaden_short)<status_schaden_len) \
	/set status_schaden_attr=%status_schaden_attr :$[status_schaden_len-strlen(status_schaden_short)]%;\
    /endif%;

/def status_get_schaden_string2 = \
     /if (status_schaden=/strcat("*",{1},"*")) \
	/if (status_param_text==1) \
	   /let status_schaden_text=$[substr(status_schaden_string2,0,1)]%;\
	   /set status_schaden_string2=$[substr(status_schaden_string2,1)]%;\
	/else /let status_schaden_text=%{2}%;\
	/endif%;\
	/if (status_schaden_attr=~"") \
	/set status_schaden_attr="%{status_schaden_text}":$[strlen(status_schaden_text)]:%{-2}%;\
	/set status_schaden_short=%{2}%;\
	/set status_schaden_attr_only=%{-2}%;\
	/else \
	/set status_schaden_attr=%{status_schaden_attr} "%{status_schaden_text}":$[strlen(status_schaden_text)]:%{-2}%;\
	/set status_schaden_short=%{status_schaden_short}%{2}%;\
	/set status_schaden_attr_only=%status_schaden_attr_only,%{-2}%;\
	/endif%;\
     /endif%;

/def state_color = \
   /getvalueof state_colors $[trunc({*}/10)*10]%;\
   /return (value!~error)?value:"n"%;

/def sl_example = \
  /init_var example%;\
  /set status_func_example=(example>0)?toupper(example) :example%;\
  /set status_attr_example=(example>0)?"Cred":"Cgreen"%;\
  /return status_var("example",5)

/set sl_world_doc=Weltname
/def sl_world = \
;  /set status_int_world=world_info("name")%;\
  /return strcat("@world:6")
	
/set sl_modes_doc=Log (L), Insert, Einfuegemodus (I), Read, Eingabe (R), Mail (M)
/def sl_modes = \
  /set status_int_log=nlog() ? "L" : ""%;\
  /set status_var_insert=insert ? "I" : "O"%;\
  /set status_int_read=nread()? "R" : ""%;\
  /set status_int_mail=nmail()? "M" : ""%;\
  /return strcat("'[' @more:1 @read:1 @log:1 @mail:1 insert:1 ']'")



/set sl_clock_doc=Uhr
/def sl_clock = \
   /set status_int_clock=ftime(CFG_STATUS_CLOCK_FORMAT, time())%;\
   /return "@clock:5"

; Spass muss sein :)
; Usage /lauf Das ist ein Test!
/set CFG_STATUS_LAUF_STEP=4
/set CFG_STATUS_LAUF_COLOR=
/def lauf = \
  /if (status_fields!/"*lauf_text*") \
    /set lauf_status_fields=%status_fields%;\
  /endif%;\
  /set CFG_STATUS_LAUF_STEP=%{CFG_STATUS_LAUF_STEP-4}%;\
;  /set lauf_color=n%;\
  /set lauf_text=%*%;\
  /set lauf_count=$[columns()]%;\
  /let lauf_zeit=$[(lauf_count+strlen(lauf_text))/CFG_STATUS_LAUF_STEP+1]%;\
  /set status_fields=:%lauf_count%;\
  /repeat -1 %lauf_zeit /lauf2%;\
  /return lauf_zeit+4

/def lauf2 = \
     /if (idle()<2) \
;         /echo -aCred Killing Myself!%;\
         /killall -q /lauf2%;\
         /set status_fields=%lauf_status_fields%;\
	 /return%;\
     /endif%;\
     /if (CFG_STATUS_LAUF_COLOR=~"") \
       /random_param %CFG_GUI_COLORS%;\
       /let lauf_this_color=%{?}%;\
     /else \
       /let lauf_this_color=%CFG_STATUS_LAUF_COLOR%;\
     /endif%;\
     /test lauf_count:=lauf_count-CFG_STATUS_LAUF_STEP%;\
     /if (lauf_count>0) \
        /set status_fields=:%lauf_count lauf_text:0:%lauf_this_color%;\
     /elseif (strlen(lauf_text)>0) \
        /set status_fields=lauf_text:0:%lauf_this_color%;\
        /test lauf_text:=substr(lauf_text,CFG_STATUS_LAUF_STEP)%;\
     /else \
        /set status_fields=%lauf_status_fields%;\
     /endif%;\
;/set status_fields%;



/addh_fileinfo
