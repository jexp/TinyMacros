; $Log: mg_properties.tf,v $
; Revision 1.50  2003/09/13 08:48:45  thufhnik
; p_wizlevel fuer Magier
;
; Revision 1.49  2003/09/13 08:41:02  thufhnik
; p_state wird jetzt auf magier gesetzt fuer ebensolche
;
; Revision 1.48  2002/12/03 03:54:36  mh14
; jetzt hoffentlich richtiges alias-escape
;
; Revision 1.47  2002/11/27 10:58:39  mh14
; trennung von mg_properties.tf von den statuszeilensettings
;
; Revision 1.45  2002/10/06 22:41:04  olm
; Das gleiche auch nochmal fuers fwer, sprich: /fwer, erzeugt
; die Liste fwer.
;
; Revision 1.44  2002/10/06 20:45:12  olm
; Neue Variable 'after_kkwer', analog zu after_go.
;
; Revision 1.43  2002/10/06 20:14:29  olm
; Neue Funktion 'kkwer'
;
; Revision 1.42  2002/09/15 13:57:44  mh14
; Text mit Attributen fuer Neuen Level einstellbar
;
; Revision 1.41  2002/09/14 12:14:03  thufhnik
; Ergaenzungen zum Elfenbeinblock
;
; Revision 1.40  2002/09/11 12:23:52  mh14
; dtype beim flag vergessen
;
; Revision 1.39  2002/09/11 12:12:35  mh14
; block flag hat jetzt nen eindeutigen namen fuer farbhinterlegung der mp, ausserdem wird nicht gesetzte p_block variable beruecksichtigt
;
; Revision 1.38  2002/08/27 08:09:18  mh14
; Block konfigurierbar
;
; Revision 1.37  2002/08/23 09:47:10  mh14
; Seherin,Magierin wird zu seher,magier in updateplayer2
;
; Revision 1.36  2002/06/29 15:26:27  thufhnik
; alle konfigurierbaren Vars von /set auf /set_var umgestellt
;
; Revision 1.35  2002/06/13 08:28:02  mh14
; diverse configure vorgaben aus der config.tf hierherverschoben
;
; Revision 1.34  2002/04/23 22:47:22  mh14
; beruecksichtigt jetz -n bei setprop
;
; Revision 1.33  2002/04/23 00:07:16  mh14
; Ausgabe der Hitpoints konfigurierbar
;
; Revision 1.32  2002/04/21 12:59:59  mh14
; EP-Differenz in p_diff_ep
;
; Revision 1.31  2002/04/21 12:36:19  mh14
; auf trig_grab umgestellt
;
; Revision 1.30  2002/04/11 12:37:08  mh14
; CFG_STATUS_COLOR_EP_K grossgeschrieben
;
; Revision 1.29  2002/03/29 22:36:44  mh14
; Statuszeileconfig umgestellt
;
; Revision 1.28  2002/03/28 06:46:04  thufhnik
; Da p_block noch nicht im savefile ist weitere Trigger fuer den Block
;
; Revision 1.27  2002/03/27 01:21:13  mh14
; statuszeilenkonfiguration fuer farben/texte eingebaut, ausserdem generische makros fuer flags und gestaffelte numerische anzeigen (lp), statuszeilendoku etwas verbessert (status_line,status_help), abhaengige Variablen fuer Statuszeile integriert
;
; Revision 1.26  2002/02/23 13:13:35  thufhnik
; gefaehrliche Vergiftung eingebaut
;
; Revision 1.25  2002/02/18 12:07:59  mh14
; - am ende des info begin strings entfernt
;
; Revision 1.24  2002/02/18 11:57:47  mh14
; - am ende des info begin strings entfernt
;
; Revision 1.23  2002/02/10 22:33:58  mh14
; Statuszeilendoku
;
; Revision 1.22  2002/02/09 13:19:53  mh14
; new_level check eingebaut
;
; Revision 1.21  2002/02/01 13:11:35  thufhnik
; p_frog ergaenzt
; sl_frog,_sl_poison,sl_blind,sl_deaf zu sl_arzt zusammengefasst
;
; Revision 1.20  2001/12/13 15:53:17  thufhnik
; Blind- und Taubheit zugefuegt (p_blind, p_deaf, sl_blind, sl_deaf)
;
; Revision 1.19  2001/12/04 09:15:14  lje
; Das Scoreamu ueberschreibt info nicht mehr, sondern definiert jetzt sinfo. Daher erreicht man mit \info immer den im Spieler eingebauten Befehl und der Test auf Scoreamu ist nicht mehr noetig
;
; Revision 1.18  2001/11/27 21:17:49  mh14
; sl_* anpassungen an status.tf, finger -n fuer check_info
;
; Revision 1.17  2001/10/29 18:59:23  nieten
; mg_properties.cfg
;
; Revision 1.16  2001/10/19 14:37:46  mh14
; Aenderungen an der Statuszeile, diese ist jetzt Schneller, hoffentlich Problematik der parallelen threads (globale Variable (value) behoben
;
; Revision 1.15  2001/10/10 22:10:22  mh14
; Default-Konfiguration in .tf Files verschoben
;
; Revision 1.14  2001/10/08 17:54:17  mh14
; set_points debuggt (lp/mp)
;
; Revision 1.13  2001/10/07 17:13:58  mh14
; Module fuer alignment, lp,mp, ep,vergiftung
;
; Revision 1.12  2001/10/05 00:18:05  olm
; Ist wohl komplizierter und ich finde den Fehler jetzt nicht, daher wieder
; rueckgaengig (1.11 -> 1.10)
;
; Revision 1.11  2001/10/04 23:12:14  olm
; Bug in /updatePlayer2 behoben, dass die mod_xxx auf 0 gesetzt werden,
; wenn sie nicht durch die Trigger gesetzt worden sind.
;
; Revision 1.10  2001/10/04 14:17:19  olm
; Subguild enthaelt jetzt die Zusaetze wie "Zweig" oder "Clan" nicht mehr,
; kleiner Bugfix im Trigger fuer p_logout_diff
;
; Revision 1.9  2001/10/03 11:58:18  mh14
; lp/mp Auswertung auch fuer Spieler ohne Reporttool
;
; Revision 1.8  2001/10/01 21:14:39  mh14
; debuggt, komplette finger-informationen werden mit ausgewertet
;
; Revision 1.7  2001/09/14 18:41:47  olm
; /tf_prompt statt manueller Definition des Alias-Triggers
;
; Revision 1.6  2001/09/14 18:23:22  olm
; Subguild eingefuehrt (Clans, Zweige...) (p_subguild).
; Muss aus den Gildenfiles per /get_subguild aktualisiert werden.
;
; Revision 1.5  2001/09/09 19:09:42  mh14
; help_de.list
;
; Revision 1.4  2001/09/06 21:11:44  mh14
;  Log eingefuegt
;

/set mg_properties_tf_version $Id: mg_properties.tf,v 1.50 2003/09/13 08:48:45 thufhnik Exp $
/set mg_properties_tf_author=Mesirii@mg.mud.de
/set mg_properties_tf_requires=properties.tf(1.12) lists.tf util.tf util.hooks.tf util.trigger.tf util.sfunc.tf
/set mg_properties_tf_desc Auslesen der Spielerproperties mittels catch-trigger und Liste

; ********************* BEGIN CONFIG ********************

/add_to_hook connect report ein%;report vorsicht ein

/cfg_info mud properties Spielerattribute
/addh info Ausgabetext fuer Hitpointausgabe
/addh CFG_MUD_HIT_POINTS_ECHO_TEXT cfg

/addh info Farbe fuer Hitpointausgabe
/addh CFG_MUD_HIT_POINTS_ECHO_ATTR cfg

/cfg_info MUD PROPERTIES HIT_POINTS_ECHO_TEXT Hitpointausgabetext:2
/cfg_info MUD PROPERTIES HIT_POINTS_ECHO_ATTR Hitpointausgabefarbe:2

/set_var CFG_MUD_HIT_POINTS_ECHO_TEXT LP: %p_lp (%p_m_lp) MP: %p_mp (%p_m_mp)
/set_var CFG_MUD_HIT_POINTS_ECHO_ATTR B

/addh info Steuert die Ausgabe der Hitpoints
/addh CFG_MUD_DO_ECHO_HIT_POINTS cfg

/cfg_info MUD PROPERTIES DO_ECHO_HIT_POINTS Hitpointausgabeflag:2
/cfg_set MUD DO_ECHO_HIT_POINTS 1

/ifdo CFG_MUD_DO_ECHO_HIT_POINTS /add_to_hook points /echo_hit_points

/add_to_hook property_update /mg_properties_check_level

/cfg_info MUD PROPERTIES NEW_LEVEL_TEXT Text_neuer_Level:2
/set_var CFG_MUD_NEW_LEVEL_TEXT -aBCred Level!!

/def mg_properties_check_level = \
  /if (p_new_level>p_level) \
     /eval /echo -p %CFG_MUD_NEW_LEVEL_TEXT%;\
  /endif%;

/addsave p_lp
/addsave p_mp

/addh info \
Eine Liste der Properties vom MG.
/addh var p_lp, p_mp, p_maxlp, p_maxmp, p_m_lp, p_m_mp, p_escape, p_whimpie, p_name, p_race, p_align, p_tall, p_level, p_weight, p_guild, p_guild_level, p_ep, p_ap, p_maxap, base_dex, mod_dex, dex, base_int, mod_int, int, base_str, mod_str, str, base_const, mod_const, const, p_deaf, p_blind, p_frog
/addh mud_properties var

/addh info \
Letze Aenderung der Lebenspunkte.
/addh p_m_lp var

/addh info \
Letze Aenderung der Magiepunkte.
/addh p_m_mp var

/addh info \
Zeit der letzten Ueberpruefung der Punkte.
/addh p_update_time var

/addh info \
Blind oder nicht blind?
/addh p_blind var

/addh info \
Taub oder nicht taub?
/addh p_deaf var

;  Trigger ;

/addh info ZusatzMP sind was feines :)
/addh p_block var


/def -t"Du konzentrierst Dich kurz und uebertraegst einen Teil Deiner magischen Energie" -aCyellow -msimple t_ladeblock = /set p_block=1%;/self_update p_mp%;/purge t_ladeblock_g%;/def -1 -msimple -aCyellow -t"in den Block." t_ladeblock_g

/def -t"Frische Kraft stroemt aus dem Elfenbeinblock in Deinen Koerper." -aCgreen -msimple t_entladeblock = /set p_block=0%;/self_update p_mp

/def -t"Der Elfenbeinblock ist doch geladen!" -aCgreen -msimple t_block_voll = /set p_block=1%;/self_update p_mp

/def -t"Deine Magiepunkte muessen maximal sein, um den Elfenbeinblock \
  aufladen zu" -aCyellow -msimple t_block_keine_kp = \
  /set p_block=0%;\
  /self_update p_mp%;\
  /purge t_block_keine_kp_g%;\
  /def -1 -aCyellow -msimple -aCyellow -t"koennen." t_block_keine_kp_g

/def -t"Der Elfenbeinblock ist gar nicht geladen!" -aCred -msimple t_block_leer = /set p_block 0%;/self_update p_mp

/addh info \
Faengt die LP/MP-Meldung ab, setzt die Properties p_lp und p_mp und die Differenz p_m_lp und p_m_mp und ruft dann den Hook points auf.
/addh var p_mp, p_lp, p_m_lp, p_m_mp
/addh t_lpmp trig
/addh t_lpmp_2 trig
/def -t"^(>* )?Du hast jetzt ([0-9]*) Lebenspunkte und ([0-9]*) Konzentrationspunkte\\.$" -mregexp -ag -Fp9999 t_lpmp = \
  /eval_hook points %P2 %P3
;/def -t"^LP:[ ]+([0-9]*), KP:[ ]+([0-9]*)|###, Gift: ([\(\)a-z]*)\\.$" -mregexp -ag -Fp9999 t_lpmp_2 = \
;  /eval_hook points %P1 %P2

/def -t"^LP:([ ]*)([0-9]+), KP:([ ]*)([0-9#]+), Gift: (.*).$" -mregexp -ag -Fp9999 t_lpmp_new = \
  /if ({P5}=~"keins" | {P5}=~"(nicht verfuegbar)") \
    /set p_poison=%;\
  /else \
    /set p_poison=%{P5}%;\
  /endif%;\
  /if ({P4}=~"###") \
    /eval_hook points %P2 0%;\
  /else \
    /eval_hook points %P2 %P4%;\
  /endif%;

; fuer nicht statusreporttoolbesitzer:
; /check_punkte auf eine Taste binden, z.B. /setkey 1 5 /check_punkte LP/MP Info

/addh info \
Berechnet Aenderung der Lebens- und Magiepunkte. Wenn die Aenderung groesser als 1 ist oder man sich im Kampf befindet: Anzeige.@{N}\
Wenn _pf gesetzt ist und keine Kontrolle-Zaubern laeuft und keine Sperrzeit bis zum naechsten Zauberspruch vorhanden ist, dann wird /pfunc mit ?p_lp und ?p_mp aufgerufen.
/addh var p_mp, p_lp, p_m_lp, p_m_mp,
/addh echo_hit_points mak
/def echo_hit_points= \
  /if ((kampf>0)|(max(abs(p_m_lp),abs(p_m_mp))>1)) \
    /cfg_echo MUD_HIT_POINTS%;\
  /endif %;

; ********************* END CONFIG **********************

/def -t"Du hast eine leichte Vergiftung." -ag -msimple t_light_poison = \
  /set p_poison=leicht%; /set p_poison_time=$[time()]%;

/def -t"Du hast eine schwere Vergiftung." -aCred -msimple t_heavy_poison = \
  /set p_poison=schwer%; /set p_poison_time=$[time()]%;

/def -t"Du hast eine gefaehrliche Vergiftung." -aCred -msimple t_bad_poison = \
  /set p_poison=gefaehrlich%; /set p_poison_time=$[time()]%;

/def check_poison = \
    /if (time()-p_poison_time>20) \
  /set p_poison=%;\
    /endif%;

/beat 30
/add_to_hook beat_30 /check_poison
/set do_beat_30=1

/addh info Aktualisiert die Spielereigenschaften (info)
/addh check_props comm

/def check_props = \
  /check_info%;

/addh info Aktualisiert die Spielereigenschaften (punkte)
/addh check_punkte comm

/def check_punkte = \
     /setprop -n old_ep %p_ep%;\
     /trig_grab -p30 -F0 -agCblue -C"!\\punkte" -M/check_props2 -b"- *" -e"r#^-+\$"

/addh info Aktualisiert die Spielereigenschaften (info)
/addh check_info comm

/def check_info = \
     /setprop -n new_level %p_level%;\
     /setprop -n old_ep %p_ep%;\
     /trig_grab -p30 -F0 -agCblue -C"!\\\\info" -M/check_props2 -b"- *" -e"r#^-+\$"

/addh info Aktualisiert die Spielereigenschaften (finger)
/addh check_finger comm

/def check_finger = \
     /trig_grab -agCblue -p30 -F0 -C"!\\\\finger -n ${world_character}" -M/check_finger2 -E -cby

;Gesundheit ....... 226                Gift ............. gesund
;Konzentration .... 117 (218)          Vorsicht ......... 100
;Todesfolgen....... kein Malus         Fluchtrichtung ... "w"
;Spiel verlassen .. nicht moeglich

/addh info Liste der Regexp-Pattern die zum Auslesen der "info" Ausgabe genutzt werden
/addh props list

/createlist props
/addtolist props whimpie Vorsicht [.]+ ([0-9]+|mutig)
/addtolist props escape Fluchtrichtung [.]+ "([^"]+)"
;" damit der Emacs nicht den Rest des Files einfaerbt :^)
/addtolist props race Rasse [.]+ ([A-Z][a-z]+)
/addtolist props align Charakter [.]+ ([a-z]+)
/addtolist props gender Geschlecht [.]+ ([a-z]+)
/addtolist props size Groesse [.]+ ([0-9]+) cm
/addtolist props level Stufe [.]+ ([0-9]+)
/addtolist props new_level Stufe [.]+ [0-9]+ +\(([0-9]+)\)
/addtolist props weight Gewicht [.]+ ([0-9]+) kg
/addtolist props guild Gilde [.]+ ([A-Z][a-z]+)
/addtolist props guild_level Gildenstufe [.]+ ([0-9]+)
/addtolist props ep Erfahrung [.]+ ([0-9]+) Punkte
/addtolist props ap Abenteuer [.]+ ([0-9]+) \([0-9]+\)
/addtolist props seher_ap Abenteuer [.]+ [0-9]+ \(([0-9]+)\)
/addtolist props base_str Kraft [.]+ +([0-9]+)( \(([0-9+-]+)\))?
/addtolist props mod_str Kraft [.]+ +[0-9]+ ?\(?([0-9+-]+)\)?
/addtolist props base_dex Geschicklichkeit [.]+ +([0-9]+)( \(([0-9+-]+)\))?
/addtolist props mod_dex Geschicklichkeit [.]+ +[0-9]+ ?\(?([0-9+-]+)\)?
/addtolist props base_int Intelligenz [.]+ +([0-9]+)( \(([0-9+-]+)\))?
/addtolist props mod_int Intelligenz [.]+ +[0-9]+ ?\(?([0-9+-]+)\)?
/addtolist props base_const Ausdauer [.]+ +([0-9]+)( \(([0-9+-]+)\))?
/addtolist props mod_const Ausdauer [.]+ +[0-9]+ ?\(?([0-9+-]+)\)?
/addtolist props lp Gesundheit [.]+ ([0-9]+)( +\(([0-9+-]+)\))?
/addtolist props maxlp Gesundheit [.]+ [0-9]+ +\(([0-9+-]+)\)
/addtolist props maxlp Gesundheit [.]+ ([0-9]+) +[^ (]
/addtolist props mp Konzentration [.]+ ([0-9]+)( +\(([0-9+-]+)\))?
/addtolist props maxmp Konzentration [.]+ [0-9]+ +\(([0-9+-]+)\)
/addtolist props maxmp Konzentration [.]+ ([0-9]+) +[^ (]
/addtolist props poison Gift [.]+ ([a-z]+)
/addtolist props deaths Todesfolgen[.]+ ([0-9]+|keine)
/addtolist props fp_rel Verglichen mit Deinen Mitspielern, ([^.]+)[.]
/addtolist props fp Absolut gesehen ([^.]+)[.]
/addtolist props age Alter:  ([^.]+)[.]

/def check_props2 = \
  /list -s t_info_scoreamu%|\
  /if ({?}>0) /undef t_info_scoreamu%; /endif%;\
  /set fulldetail=$[replace("@{N}"," ",fulldetail)]%;\
  /forEach props kv /check_props3%;\
  /set fulldetail=%;\
  /eval_hook property_update

/def check_props3 = \
        /let prop=%{1}%;\
; /echo -e %{prop} : regex %{-1}%;\
  /if ({2}=/"[0-9]") /let check_props3=%{2}%; /shift%;\
        /else /let check_props3=1%; /endif%;\
  /if ({2}=/"keep_case") /let keep_case=1%; /shift%;\
  /else /let keep_case=0%;/endif%;\
  /if (regmatch({-1},fulldetail)==1) \
;    /echo %{prop} == %P1%;\
     /if (!keep_case) \
     /test check_props3:=tolower(\{P%{check_props3}\})%;\
     /else \
     /test check_props3:=\{P%{check_props3}\}%;\
     /endif%;\
     /setprop -n %{prop} %check_props3%;\
  /endif%;

;Mesirii ist anwesend,
;und zwar von: Daemonendimension (ueber T-Online).
;Eingeloggt seit: Mon,  1. Okt 2001, 21:40:48
;Voller Name: Chaosmacher Mesirii macht trotzdem weiter
;Rasse: Zwerg,  Gilde: Chaos,  Geschlecht: maennlich
;Alter: 369d 10:32:06,   Spielerlevel: 71 (Seher),   Gildenlevel: 11
;Datum des ersten Login: Mit,  9. Nov 1994, 16:22:47
;Homepage: http://tf-macros.sourceforge.net, mh14@inf.tu-dresden.de
;Bisher bereits 154 mal gestorben
;Projekt: TinyFugue was sonst :)

;Kartii ist nicht anwesend.
;Zuletzt eingeloggt von: T-Online.
;Zuletzt ausgeloggt: Sam, 29. Sep 2001, 13:57:58 (2d 08:43:42).
;Voller Name: Kartii trauert um Gandulf
;Rasse: Zwerg,  Gilde: Tanjian,  Geschlecht: maennlich
;Alter: 137d 12:17:50,   Spielerlevel: 30 (Seher),   Gildenlevel: 6
;Datum des ersten Login: vor dem 10. Nov 1995
;Kartii ist Zweitspieler.
;Bisher bereits 18 mal gestorben

/addh info Liste der Regexp Pattern zur Auswertung der "finger" Augabe
/addh finger_props list

/createlist finger_props
/addtolist finger_props login (ist( nicht)? anwesend)[,.]
/addtolist finger_props login_location keep_case und zwar von: ([^.]+)[.]
/addtolist finger_props login_location keep_case Zuletzt eingeloggt von: ([^.]+)[.]
/addtolist finger_props login_time keep_case Eingeloggt seit: ([^#]+)#
/addtolist finger_props logout_time keep_case Zuletzt ausgeloggt: ([^(]+)
/addtolist finger_props logout_diff Zuletzt ausgeloggt: [^(]+ [(]([^)]+)[)]
/addtolist finger_props full_name keep_case Voller Name: ([^#]+)#
/addtolist finger_props sub_guild 3 Rasse: .+,  Gilde: [^(]+( [(](Zweig |Clan )?([^)]+)[)])?,  Geschlecht:
/addtolist finger_props state Spielerlevel: [0-9]+ [(]([^)]+)[)]
/addtolist finger_props state (Magier)level: [1-9][0-9]+
/addtolist finger_props wizlevel Magierlevel: ([1-9][0-9]+)
/addtolist finger_props short_age Alter: ([^,]+)
/addtolist finger_props first_login keep_case Datum des ersten Login: ([^#]+)#
/addtolist finger_props zweitie ist (Zweitspieler)[.]
/addtolist finger_props deaths Bisher bereits ([0-9]+) mal gestorben
/addtolist finger_props url keep_case Homepage: ([^#]+)#
/addtolist finger_props project keep_case Projekt: ([^#]+)#

/def check_finger2 = \
  /set fulldetail=$[replace("@{N}","#",fulldetail)]%;\
  /forEach finger_props kv /check_props3%;\
  /set fulldetail=%;\
  /eval_hook property_update

/addh info \
Aktualisiert die Spielerinformationen aus dem 'info'-Befehl. Das ist notwendig, um die Einschraenkungen bei den Wegen umzusetzen und um das spielerabhaengige und gildenabhaengige Makrofile zu laden. Bitte ausfuehren, wenn sich an den Properties was aendert.@{N}\
Der letzte Trigger muss dann updatePlayer2 aufrufen.
/addh see properties, einschraenkungen, dateisystem
/addh updatePlayer comm
/def updatePlayer = \
  /createlist ${world_character}%; \
  /setprop -n name ${world_character}%; \
  /setprop -n state spieler%;\
  /check_finger%;\
  /check_info%; \
; /get_subguild%;

/def updatePlayer2 = \
;/echo -aCred updateplayer2%;\
  /getprop base_int%;\
  /let p1=%value %;\
  /getprop mod_int%;\
  /setprop -n int $[p1+value] %;\
  /getprop base_str%;\
  /let p1=%value %;\
  /getprop mod_str%;\
  /setprop -n str $[p1+value] %;\
  /getprop base_dex%;\
  /let p1=%value %;\
  /getprop mod_dex%;\
  /setprop -n dex $[p1+value] %;\
  /getprop base_const%;\
  /let p1=%value %;\
  /getprop mod_const%;\
  /setprop -n const $[p1+value] %;\
; /getprop escape%;\
; /setprop -n state $[(value!~error)?"seher":"spieler"]%; \
  /getprop state%;\
  /let temp_state=%?%;\
  /test temp_state:=tolower(temp_state)%;\
  /if (temp_state=/"*in") /test temp_state:=substr(temp_state,0,-2)%; /endif%;\
  /setprop -n state %temp_state%;\
  /getprop whimpie%;\
  /if (value=~"mutig") /setprop -n whimpie 0%; /endif%;\
  /getprop ep%;\
  /let p1=%value%;\
  /getprop old_ep%;\
  /setprop -n diff_ep $[p1-value]%;\

;/echo Done Property Update

/add_to_hook property_update /set_points %p_lp %p_mp
/add_to_hook property_update /updatePlayer2
/add_to_hook property_update /saveprops

/addh info Aktualisiert Lebenspunkte und Magiepunkte und berechnet die Differenz zum letzten Stand, ausserdem wird p_update_time gesetzt. Wird zum Hook points standardmaessig hinzugefügt.
/addh set_points mak

/def set_points = \
        /set p_update_time=$[time()]%;\
  /set p_lp=%{1}%;/set p_mp=%{2}%;\
  /set p_m_lp=$[+{1}-p_last_lp]%;\
  /set p_m_mp=$[+{2}-p_last_mp]%;\
  /set p_last_lp=%p_lp%;\
  /set p_last_mp=%p_mp%;\

/add_to_hook_begin points /set_points %1 %2

/addh info \
Liest alle Spieler ein, die ein gewisses Kriterium erfuellen (siehe Hilfe im \
MorgenGrauen zu kkwer. Das Ergebnis wird in die Liste kkwer geschrieben.
/addh syn /kkwer [kriterium]
/addh ex /kkwer erwartete
/addh ex /kkwer bei olli
/addh kkwer mak
/defh kkwer = \
  /createlist kkwer%;\
  /if (mud_short_who=~"") \
    /let cmd=kkwer %*%;\
  /else \
    /let cmd=%mud_short_who %*%;\
  /endif%;\
  /trig_grab -p30 -F0 -y"r#^([A-Z][A-Za-z]+[A-Za-z0-9], ?)+\$" -e"r#^([A-Z][A-Za-z]+[A-Za-z0-9], )*([A-Z][A-Za-z]+[A-Za-z0-9][.])\$" -d" " -cye -M/kkwer_auswerten -C"!\\\\%{cmd}" -F0 -ag%;

/def kkwer_auswerten = \
    /set fulldetail=$[tolower(substr(fulldetail,0,strlen(fulldetail)-2))]%;\
    /test tokenize(", ",fulldetail)%;\
    /let kkwer_count=$[T0+1]%;\
    /let kkwer_res=%;\
    /while (--kkwer_count>=1) \
            /test kkwer_res:=\{T%kkwer_count\}%;\
            /addtolist kkwer %kkwer_res%;\
    /done%;\
    /if (after_kkwer!~"") \
  /eval -s0 %after_kkwer%;\
  /set after_kkwer=%;\
    /endif

/def fwer = \
        /createlist fwer%;\
        /trig_grab -p30 -F0 -b"r#([a-zA-Z0-9]+) *- *[0-9]+: *[0-9]+: *[0-9]+: *[0-9]+" -y"r#([a-zA-Z0-9]+) *- *[0-9]+: *[0-9]+: *[0-9]+: *[0-9]+" -d"@" -P -cby -C"!\\\\fwer idle" -ag -M/fwer_auswerten

/def fwer_auswerten = \
    /set fulldetail=$[tolower(substr(fulldetail,0,strlen(fulldetail)-2))]%;\
    /test tokenize("@",fulldetail)%;\
    /let fwer_count=$[T0+1]%;\
    /let fwer_res=%;\
    /while (--fwer_count>=1) \
            /test fwer_res:=\{T%fwer_count\}%;\
            /if (regmatch('^([a-zA-Z0-9]+) ', fwer_res)) \
                /addtolist fwer %P1%;\
            /endif%;\
    /done%;\
    /if (after_fwer!~"") \
        /eval -s0 %after_fwer%;\
        /set after_fwer=%;\
    /endif

/addh_fileinfo
