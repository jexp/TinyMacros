; $Log: team.tf,v $
; Revision 1.13  2002/11/19 17:20:11  nieten
; an 256-Farben-Patch angepasst (Attribut n -> x)
;
; Revision 1.12  2002/10/18 11:58:28  olm
; Die Liste team_mitglieder wird nun beim Laden erzeugt
;
; Revision 1.11  2002/10/15 13:06:38  olm
; Neue Funktion team_complete, ueberprueft, ob alle Teammitglieder bei
; einem im Raum stehen.
;
; Revision 1.10  2002/10/01 12:36:06  nieten
; Bugfix in t_team_auf
;
; Revision 1.9  2002/09/17 17:26:50  nieten
; - Farben fuer Teamtexte und Teaminfo
; - Farben und Team Autoaufnahme ueber /configure
; - kompaktes Teaminfo per /team_info (/ti)
; - Setzen von FL und TAB durch Teamleiter moeglich
; - formatierte Ausgabe der Attribute
; - team_member==2 fuer Teamleiter
; - diverser Kleinkram
;
; Revision 1.8  2002/09/04 19:03:29  nieten
; bug in /tab_fl raus
;
; Revision 1.7  2002/09/04 12:48:04  mh14
; Team-Info Auswertung
;
; Revision 1.6  2002/09/03 14:23:26  mh14
; Trigger als Glob
;
; Revision 1.5  2002/09/03 14:08:34  nieten
; - Trigger etwas aufgeraeumt
; - /tab_fl eingebaut
;
; Revision 1.4  2002/09/03 12:54:11  mh14
; Hilfe fuers File
;
; Revision 1.3  2002/09/02 23:13:49  mh14
; Ein/Ausschalter fuer automatische Teamaufnahme, wer ist Teamleiter wenn man um Aufnahme gebeten wird und keiner ist
;
; Revision 1.2  2002/09/02 23:01:39  mh14
; Team.tf eingebaut
;
; Revision 1.1  2002/09/02 22:19:04  mh14
; Team-Makros und Trigger
;

/set team_tf_version $Id$
/set team_tf_author Mesirii@mg.mud.de
/set team_tf_requires=way.tf util(1.38)
/set team_tf_desc=Team-Makros 


; Team-Ebene fuer /configure
/cfg_info mud team Team

/addh info \
Attribut, das alle teambezogenen Meldungen bis auf die Ausgabe von "team info (lang)" erhalten.@{N}\
(Ist ?comm.tf geladen, so werden alle Zeilen Form@{N}\
[Team ...] ...@{N}\
wie in ?comm_ebenen_list angegeben gefaerbt.)
/addh dtype color
/addh CFG_MUD_TEAM_COLOR1 var

/cfg_info mud team COLOR1 Farbe
/set_var CFG_MUD_TEAM_COLOR1 Cblue


/addh info \
Attribut, welches fuer die Ausgabe von "team info (lang)" verwendet wird.
/addh dtype color
/addh CFG_MUD_TEAM_INFOCOLOR var

/cfg_info mud team INFOCOLOR Farbe_fuer_team_info
/set_var CFG_MUD_TEAM_INFOCOLOR x

/createnewlist team_mitglieder

/addh info \
Startet den Team Angriff in n Sekunden, ohne Parameter sofort. Nur ausfuehrbar fuer den Teamleiter. Mit /team_angriff, waehrend es laeuft, wird es wieder abgebrochen.@{N}\
Per Default ist @{B}/ta@{x} als Kuerzel dafuer definiert, falls nicht schon ein Makro mit diesem Namen existiert.
/addh syn /team_angriff [n]
/addh ex /team_angriff 10
/addh team_angriff comm

/def team_angriff = \
     /if (team_member!=2) \
        /echo -aBCred Du bist kein Teamleiter!%;\
	/return%;\
     /endif%;\
     /if (!{#} & team_angriff_pid>0) \
	team rufe Team Angriff abgebrochen!%;\
        /kill %team_angriff_pid%;\
	/unset team_angriff_pid%;\
	/return%;\
     /endif%;\
     /if ({#} & {1}) \
         team rufe %1%;\
	 /repeat -1 1 /team_angriff $[{1}-1]%; \
	 /set team_angriff_pid=%?%;\
     /else \
	   team angriff%; \
	   /unset team_angriff_pid%; \
     /endif

/if (!ismacro("taa")) \
    /rename_mac ta team_angriff team%;\
/endif


/addh info \
Wertet die Team Autofolge Ausgaben fuer Wegesystem und Mapper aus.
/addh t_team_auto trig

/set_var p_team_follow=0

; Dieser Text wird nicht komplett eingefaerbt, deshalb der abweichende Name.
/def -E(p_team_follow&team_member==1) -mregexp \
    -t'^Du folgst Deinem Team mit "\\\\(.+)"\\.$' t__team_auto = \
    /let dir=%P1%;\
    /getkeyofvalue comm_abbr %dir%;\
    /if (value!~error) \
	/h_move %value%;\
    /else \
	/let old_weg=%weg%;\
	/set weg=1%;\
	/h_move %dir%;\
	/set weg=%old_weg%;\
    /endif

/eval /edit -P1%CFG_MUD_TEAM_COLOR1 t__team_auto


/addh info \
History von Team-Rufe. Parameter gibt die gewünschten Zeilen an; alles nach dem Zeilenparameter ist Matching Pattern (glob-pattern).
/addh syn /team_history [n] [Pattern]
/addh ex /team_history 10 {borz|sivok}@{N}\
gibt alle der letzten 10 Zeilen aus, in denen irgendwo "borz" oder "sivok" vorkommt.
/addh team_history comm

/def team_history = \
        /recall -mglob -ag /%{1-20} \\[Team *\\]*%{-1}*


/addh info \
Setzt zum angegebenen Angriffsbefehl automatisch die Fluchtrichtung in entgegengesetzer Richtung, falls moeglich. (Dazu wird die Liste extramoves verwendet.) Falls "vorsicht.tf" geladen ist, wird dazu /fl verwendet.
/addh syn /tab_fl Richtung
/addh ex /tab_fl no -> tab no, fluchtrichtung sw
/addh tab_fl comm

/def tab_fl = \
    tab %*%;\
    /let tmp=$[getvalueof("xtramoves",{*})]%;\
    /if (tmp =~ error) \
	/echo -aCred Kann "%*" nicht umkehren!%;\
    /else \
        /if (ismacro("fl")) \
	    /fl $[substr(tmp,2)]%;\
	/else \
	    fluchtrichtung $[substr(tmp,2)]%;\
	/endif%;\
    /endif


/def -E(team_member==1) -msimple -t"Du folgst jetzt dem Teamleiter." \
    t_team_af_ein1 = \
    /set p_team_follow=1

/def -E(team_member==1) -msimple -t"Du folgst jetzt nicht mehr dem \
    Teamleiter." \
    t_team_af_aus1 = \
    /set p_team_follow=0

/def -E(team_member==2) -msimple -t"Dein Team folgt Dir." t_team_af_ein = \
    /set p_team_follow=1

/def -E(team_member==2) -msimple -t"Dein Team folgt Dir nicht mehr." \
    t_team_af_aus = \
    /set p_team_follow=0


/addh info \
Schaltet Autofolge um. Default Kurz-Makroname: @{B}/af@{x}.
/addh team_autofolge comm

/def team_autofolge = \
     /let param=$[p_team_follow ? "aus" : "ein"]%;\
     /if ({#}) \
       /if ({1}=/"{1|an|ein}") /let param=ein%; \
       /else /let param=aus%;\
       /endif%;\
     /endif%;\
     team autofolge %param

/if (!ismacro("af")) \
    /rename_mac af team_autofolge team%;\
/endif


/set_var team_auto_aufnahme=0

/def team_auto_aufnahme = /toggle team_auto_aufnahme%;/team_auto_aufnahme_show
/def team_neu = /set team_auto_aufnahme=1%;/team_auto_aufnahme_show
/def team_voll = /set team_auto_aufnahme=0%;/team_auto_aufnahme_show

/def team_auto_aufnahme_show = \
    /if (team_auto_aufnahme) \
        /echo -aCyellow -p Auto-Teamaufnahme @{BCgreen}ein@{x}! \
            Umschalten mit /team_auto_aufnahme (/taa) oder /team_voll%;\
    /else \
        /echo -aCyellow -p Auto-Teamaufnahme @{BCred}aus@{x}! \
            Umschalten mit /team_auto_aufnahme (/taa) oder /team_neu%;\
    /endif


/addh info \
Variable, die das automatische Aufnehmen von Teammitgliedern steuert.@{N}\
Umschaltbar mit /team_auto_aufnahme (/taa), /team_neu - ein, /team_voll - aus. Default ist aus.
/addh dtyp flag
/addh team_auto_aufname var

/cfg_info mud team AUTOAUFNAHME automatische_Teamaufnahme:team_auto_aufnahme

/if (!ismacro("taa")) \
    /rename_mac taa team_auto_aufnahme team%;\
/endif



;;; TRIGGER

/def -F -mglob -t"* bittet Dich um {Gruendung|Aufnahme} {eines|ins} \
    {Teams.|Team.}" t_team_auf = \
    /if (team_leader!~"" & team_member!=2) \
	teile $[tolower({-L6})] mit Ich kann Dich leider nicht aufnehmen. \
	    %team_leader ist Teamleiter!%;\
	/return%;\
    /endif%;\
    /if (team_auto_aufnahme) \
	team aufnahme $[tolower({-L6})]%;\
	/set team_temp_leader=$[world_info("character")]%;\
    /else \
	/team_auto_aufnahme_show%;\
    /endif


/def -p100 -F -mglob -t"\\[Team *:\\] * wurde ins Team aufgenommen. " \
    t_team_auf_wer = \
    /let team_member_name=%L5%;\
    /if (team_member_name =/ world_info("character")) \
;        team angriffsbefehl%;\
	/set p_follow=0%;\
	/set team_leader=%team_temp_leader%;\
	/set team_member=$[team_leader=/world_info("character") ? 2 : 1]%;\
	/set team_allow=0%;\
    /endif%;\
    /createnewlist team_mitglieder%;\
    /uaddtolist team_mitglieder %P1

/def -p100 -F -E(team_member) -mglob \
    -t"\\[Team *:\\] * hat das Team verlassen." t_team_weg_wer = \
    /createnewlist team_mitglieder%;\
    /deletekeyandvalue team_mitglieder %L5


/def -p100 -F -E(team_member) -msimple \
    -t"Du verlaesst das Team." t_team_weg = \
    /createlist team_mitglieder%;\
    /unset team_leader%;\
    /unset team_temp_leader%;\
    /set team_member=0%;\
    /set p_team_follow=0%;\
    /set team_allow=0

/def -msimple -q -t"Du bist in keinem Team." t_team_no_team = \
     /t_team_weg%;\
     /purge h_team_info_stop

/def -p100 -F -E(team_member) -mglob \
    -t"\\[Team *:\\] * leitet jetzt das Team. " t_team_leader_change = \
     /set team_leader=%L5%;\
     /set team_member=$[team_leader=/world_info("character") ? 2 : 1]%;\
     /set team_allow=0

/def -p100 -F -E(team_member) -mglob \
    -t"\\[Team *:\\] * hat die Teamleitung uebernommen." \
    t_team_leader_change2 = \
     /set team_leader=%L5%;\
     /set team_member=$[team_leader=/world_info("character") ? 2 : 1]%;\
     /set team_allow=0

/def -mglob -t"* hat Dich nicht um Aufnahme gebeten." t_auf_fehl3 = \
     team folge $[tolower({1})]

/def -F -mglob -t"Du bittest * um {Gruendung|Aufnahme} {eines|ins} \
    {Teams.|Team.}" t_team_auf2 = \
     /set team_temp_leader=%3

/def -F -mglob -t"* ist schon in einem anderen Team." t_team_auf_fehl = \
     teile %1 mit Du bist schon in einem anderen Team.

/def -p100 -mglob -t"* teilt Dir mit: Du bist schon in einem anderen Team." \
    t_team_auf_fehl1 = \
    /if ({1} =~ team_temp_leader) \
        team verlasse%;\
	team folge $[tolower(team_temp_leader)]%;\
    /endif

/def -F -p10 -msimple -t"  Name        Gilde           LV GLV  LP (MLP)  \
    KP (MKP) Vors. GR AR TR FR A V" t_team_info_start = \
    /set t_team_info=1%;\
    /set team_info_single=1%;\
    /createlist team_mitglieder%;\
    /def -t"*" -p0 -F -mglob t_team_info_stop = \
        /if (--team_info_single<0) \
	    /set t_team_info=0%%;\
	    /set t_team_info_lang=0%%;\
; Ausgabe der Informationen nach Aufruf von /team_info.
	    /if (team_info_cmd) \
	        /team_show_info LP KP VS AF \
		    $$[team_info_cmd==2?"FL TAB ":""]%%;\
	        /set team_info_cmd=0%%;\
; Gagging der Trigger fuer "team info" wieder ausschalten.
	        /edit_macros -a%%CFG_MUD_TEAM_COLOR1 t_team_info_*%%;\
	    /endif%%;\
	    /purge t_team_info_stop%%;\
	    /purge h_team_info_stop%%;\
        /endif

/def -p10 -F -E(t_team_info) -msimple -t"  (Zeile 2)   \
    Angriffsbefehl                             Fluchtrichtung" \
    t_team_info_start_lang = \
    /set team_info_single=1%;\
    /set t_team_info_lang=1

/def -p1 -E(t_team_info) -F -mregexp -t"^(\\*| ) ([A-Za-z]+) +[A-Za-z]+ +[0-9]+ +[0-9]+ +[0-9]+ +\\([0-9]+\\) +[0-9]+ +\\([0-9]+\\) +[0-9]+ +[0-9-]+ +[0-9-]+ +[0-9-]+ +[0-9-]+ +[X-] +[X-]$" t_team_info_single = \
     /let param=%*%;\
     /set team_info_single=1%;\
     /if ({P1}!~"*") \
         /let param=- %param%;\
     /else \
	 /set team_leader=%P2%;\
	 /set team_member=$[team_leader=/world_info("character")? 2 : 1]%;\
     /endif%;\
     /set team_info_member=$[tolower({P2})]%;\
     /uaddtolist team_mitglieder %team_info_member %param%;\

/def -p1 -F -E(t_team_info_lang) -mregexp \
    -t"^              (..........................................) (.+)" \
    t_team_info_lang_single = \
    /let team_info_value=%;\
    /set team_info_single=1%;\
    /getdvalueof team_mitglieder %team_info_member%;\
    /test team_info_value:=strcat({?}," ", replace(" ","_",{P1}), \
                                      " ", replace(" ","_",{P2}))%;\
    /addtolist team_mitglieder %team_info_member %team_info_value


/addh info \
Listet das angebene Attribute das angegebene Teammitglied auf (aus team info). Lebens-, Magiepunkte und Vorsicht werden eingefaerbt.
/addh syn /team_get_info name attribut
/addh param leader, name, gilde, lv, level, glv, lp, mlp, kp, mp, mkp, vors, v, vs, gr, ar, tr, fr, a, tab, af, autofolge, angriffsbefehl, tabtext, fluchtrichtung, fl
/addh team_get_info comm

/def team_get_info = \
    /let team_info_value=$[getvalueof("team_mitglieder", tolower({1}))]%;\
    /if (team_info_value =~ error) \
        /echo -aCred %1 ist kein Teammitglied%;\
    /else \
	/let team_info_idx=$[getvalueof("team_info_keys", tolower({2}))]%;\
        /get_param %team_info_idx %team_info_value%;\
	/let result=%?%;\
	/if (result=/"(*)") /result substr(result,1,-1)%; /endif%;\
	/if (result=~"X") /result 1%; /endif%;\
	/if (result=/"-*") /result 0%; /endif%;\
	/if (result=/"*_*") /result replace("_"," ",result)%; /endif%;\
	/if (team_info_idx==6 | team_info_idx==10) \
	    /result team_info_color(result,7)%;\
	/endif%;\
	/if (team_info_idx==8) \
	    /result team_info_color(result,9)%;\
	/endif%;\
        /result result%;\
    /endif


/addh info \
Hilfsfunktion, die die Faerbung von Lebens-, Magiepunkten und Vorsicht vornimmt.
/addh syn /team_info_color wert idx_maxpunkte
/addh return String mit Farbe und Wert
/addh team_info_color func

/def team_info_color = \
     /let team_value=%1%;\
     /get_param %2 %team_info_value%;\
     /let team_max_value=$[substr({?},1,-1)]%;\
     /let team_value_color=$[(3*team_value<team_max_value) ? "red" : \
         (3*team_value<2*team_max_value) ? "yellow" : "green"]%;\
     /return strcat("@{C", team_value_color, "}", \
         pad(team_value,3), "@{x}")


/addh info \
Listet die angegebenen Attribute fuer alle Teammitglieder auf (aus team info). Lebens-, Magiepunkte und Vorsicht werden eingefaerbt.
/addh syn /team_show_info attribut [attribut] ...
/addh func team_info_color
/addh param leader, name, gilde, lv, level, glv, lp, mlp, kp, mp, mkp, vors, v, vs, gr, ar, tr, fr, a, tab, af, autofolge, angriffsbefehl, tabtext, fluchtrichtung, fl
/addh team_show_info comm

/def team_show_info = \
     /let result=$[pad("Name",team_pad("name"),":",1)]%;\
     /let param=%*%;\
     /while ({#}) \
        /test result:=strcat(result," ",pad({1},-abs(team_pad({1}))))%;\
	/shift%;\
     /done%;\
     /echo -a%CFG_MUD_TEAM_INFO %result%;\
     /foreach team_mitglieder k /team_show_info2 %param

/def team_show_info2 = \
     /let result=$[capitalize({L})]%;\
     /if (team_get_info({L},"leader") =~ "*") \
         /test result:=strcat("@{u}", pad(result,team_pad("name")),\
	     "@{x", CFG_MUD_TEAM_INFO, "}:")%;\
     /else \
         /test result:=strcat(pad(result, team_pad("name")), ":")%;\
     /endif%;\
     /while ({#}>1) \
        /test result:=strcat(result, " ",\
	    pad(team_get_info({L},{1}),team_pad({1})))%;\
	/shift%;\
     /done%;\
     /echo -pa%CFG_MUD_TEAM_INFO %result


; Funktion Feldname -> Feldbreite
/addh info \
Gibt fuer das angegebene Attribut die fuer pad() noetige Zahl zurueck, um eine formatierte Ausgabe zu erreichen.
/addh syn /team_pad Attribut
/addh ex \
/expr team_pad("mlp") -> 003@{N}\
/expr team_pad("fl")  -> -21
/addh team_pad func

/def team_pad = \
     /let tmp=$[getvalueof("team_info_keys", tolower({1}))]%;\
     /if (tmp =~ error) \
         /return -5%;\
     /else \
; Dieser komische Zahlenstring enthaelt die Feldbreiten.
         /return substr(\
	     "001 -11 -15 003 002 003 003 003 003 003 -02 -02 -02 -02 -02 \
	     -02 -42 -21",4*tmp-4, 3)%;\
     /endif


; Listenaufbau: Schluesselwort -> Feldnummer in 'team info (lang)'
/createlist team_info_keys
/addtolist team_info_keys leader          1
/addtolist team_info_keys name            2
/addtolist team_info_keys gilde           3
/addtolist team_info_keys lv              4
/addtolist team_info_keys level           4
/addtolist team_info_keys glv             5
/addtolist team_info_keys lp              6
/addtolist team_info_keys mlp             7
/addtolist team_info_keys mp              8
/addtolist team_info_keys kp              8
/addtolist team_info_keys mmp             9
/addtolist team_info_keys mkp             9
/addtolist team_info_keys v              10
/addtolist team_info_keys vs             10
/addtolist team_info_keys gr             11
/addtolist team_info_keys ar             12
/addtolist team_info_keys tr             13
/addtolist team_info_keys fr             14
/addtolist team_info_keys a              15
/addtolist team_info_keys af             16
/addtolist team_info_keys autofolge      16
/addtolist team_info_keys tab            17
/addtolist team_info_keys tabtext        17
/addtolist team_info_keys fl             18
/addtolist team_info_keys fluchtrichtung 18


/addh info \
Eine kompakte Version des ueblichen "team info". Es werden nur Name, aktuelle LP, aktuelle KP, Vorsicht, Autofolge und - fuer den Teamleiter - Fluchtrichtung und Angriffsbefehl angezeigt.@{N}\
Per Default ist @{B}/ti@{x} als Kuerzel dafuer definiert, falls beim Laden von "team.info" kein Makro mit diesem Namen existiert.
/addh team_info comm

/def team_info = \
; Gagging der Trigger fuer "team info" einschalten.
    /edit_macros -ag t_team_info_*%;\
; Ausgabe der Informationen bei erste Nicht-Info-Zeile durch t_team_info_stop,
; bei Prompt durch h_team_info_stop.
    /def -1 -F -p100 -q -hPROMPT h_team_info_stop = \
        /set team_info_single=0%%;\
	/lazym t_team_info_stop%;\
    /if (team_member == 2) \
	team info lang%;\
	/set team_info_cmd=2%;\
    /else \
	team info%;\
	/set team_info_cmd=1%;\
    /endif


/addh info  \
Siehe ?/team_info.
/addh ti comm

/if (!ismacro("ti")) \
    /rename_mac ti team_info team%;\
/endif



/addh info \
Schaltet das "ferngesteuerte" Setzen von Angriffsbefehl und Fluchtrichtung durch den Teamleiter ein und aus.@{N}\
Da dies gefaehrlich sein kann, wird das zugehoerige Flag bei jedem Wechsel des Teamleiters wieder auf 'aus' gestellt.@{N}\
@{Cbgred}Vorsicht:@{x} Diese "Fernsteuerung" kann sehr gefaehrlich sein (und ist sowieso nur etwas fuer Wurstmetzler). Fuer daraus resultierende Tode oder sonstige Konsequenzen kann keine Haftung uebernommen werden. :^)
/addh see /team_tab_fl
/addh team_allow comm

/def team_allow = \
    /toggle team_allow%;\
    /echo -p Setzen von TAB und FL durch Teamleiter \
        @{C$[team_allow?"green}ein":"red}aus"]@{x}.

/set_var team_allow=0


/addh info \
Der Teamleiter kann mit diesem Befehl Angriffsbefehl und Fluchtrichtung fuer die Teammitglieder setzen. Dazu muessen die einzelnen Mitglieder dies mit ?/team_allow erlauben. Eigener Angriffsbefehl und Fluchtrichtung werden in jedem Fall gesetzt.@{N}\
Angriffsbefehl oder Fluchtrichtung koennen auch weggelassen werden (das '&' allerdings nicht), um keine Aenderung vorzunehmen. Eine Loeschung von Angriffsbefehl oder Fluchtrichtung kann mit '-' erreicht werden.
/addh syn /team_tab_fl Angriffsbefehl & Fluchtrichtung
/addh ex \
/team_tab_fl betrete portal & oeffne tuer@{N}\
/team_tab_fl -&renne ganz schnell raus
/addh team_tab_fl comm

/def team_tab_fl = \
    /if (team_member != 2) \
        /echo -aBCred Du bist kein Teamleiter!%;\
    /else \
	/let pos=$[strchr({*}, "&")]%;\
	/if (pos == -1) \
	    /echo -aCred Syntax: \
	        /team_tab_fl Angriffsbefehl & Fluchtrichtung%;\
	    /return%;\
	/endif%;\
	/let tab=$[substr({*}, 0, pos)]%;\
	/let fl=$[substr({*}, pos+1)]%;\
	/if (tab !~ "") \
            team rufe &TAB& %tab%;\
	/endif%;\
	/if (fl !~ "") \
	     team rufe &FL & %fl%;\
	/endif%;\
    /endif


/def -p10 -F -E(team_member&(team_allow|team_member==2)) -mregexp \
    -t"^\\[Team (.+):([A-Za-z]+)\\] &(TAB|FL )& (.+)" t_team_tab_fl = \
    /if ({P2} !/ team_leader) \
; Bloedmann
	/return%;\
    /endif%;\
    /if ({P4} =~ "-") \
        /let richtung=%;\
    /else \
	/let richtung=%P4%;\
    /endif%;\
    /if ({P3} =~ "TAB") \
        team angriffsbefehl %richtung%;\
    /else \
        /if (ismacro("fl")) \
	    /fl %richtung%;\
	/else \
	    fluchtrichtung %richtung%;\
	/endif%;\
    /endif%;\
; Fuer Nicht-Leiter eine auffaellige Ausgabe
    /if (team_member == 1) \
        /repeat -0 1 /echo -p @{Cbgred}%P3 gesetzt:@{x} %P4%;\
    /endif


/def team_complete = \
	/set after_kkwer=/team_complete2%;\
	/kkwer bei ${world_character}%;

/def team_complete2 = \
	/set team_temp=%team_mitglieder%;\
	/foreach kkwer k /delallkeysandvalues team_temp%;\
	/if (count_entries('team_temp')!=0) \
		/echo -aBCred -- -[ Es fehlen noch: ]---------------------%;\
		/foreach team_temp k /team_complete_disp%;\
		/echo -aBCred -- -----------------------------------------%;\
	/else \
		/echo -aBCgreen -- -[ Team vollstaendig! ]------------------%;\
	/endif%;

/def team_complete_disp = \
	/test echo(strcat('   ',capitalize({1})),'BCyellow')

; Farbe fuer Trigger setzen
/eval /edit_macros -a%CFG_MUD_TEAM_COLOR1 t_team_*
/eval /edit_macros -a%CFG_MUD_TEAM_INFOCOLOR t_team_info_*


/addh info \
Enthaelt Team-Makros fuer Aufnahme von Mitgliedern (s. team_auto_aufnahme), Autofolge-Toggle, Trigger zum Mitschreiben von Team-Autofolge Meldungen fuers Wegesystem und Mapper, Team Angriff Countdown, externe Team-History, kompakten "team info"-Befehl
/addh see /team_angriff, /team_history, /tab_fl, /team_autofolge, /team_auto_aufnahme, /team_info, /team_allow
/addh_fileinfo
