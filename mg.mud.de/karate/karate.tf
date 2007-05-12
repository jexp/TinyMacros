; $Log: karate.tf,v $
; Revision 1.7  2003/06/22 08:36:22  rumburuk
; Stufenabschaetzungen
;
; Revision 1.6  2003/05/07 21:02:55  olm
; Hook set_skillability ausgefuehrt pro Wert von Funa. Ich brauchte das :)
;
; Revision 1.5  2002/10/17 15:45:35  thufhnik
; Einschaetzungen von Funa korrigiert
;
; Revision 1.4  2002/04/16 00:43:18  mh14
; speichern letzte abfrage
;
; Revision 1.3  2002/04/15 17:06:29  mh14
; Karate-Skills eingebaut, bitte testen
;
; Revision 1.2  2002/03/05 10:53:46  thufhnik
; requires ergaenzt
;
; Revision 1.1  2002/03/05 10:50:36  thufhnik
; Scratch
;
 
/set karate_tf_version $Id: karate.tf,v 1.7 2003/06/22 08:36:22 rumburuk Exp $
/set karate_tf_author=Thufhir@mg.mud.de
/set karate_tf_requires=status_ext.tf hydra.tf
/set karate_tf_desc=Loader der Karategilde

/remove_from_hook points /echo_hit_points

/config_status {ext_segen}{ext_schutzhand}{ext_kiri}_L:{lp}_K:{mp}_{arzt}{hydra_present}_FL:{vorsicht}:{flucht}_W:{weapon}_{modes}_{dim_node}_{clock}

;;; Konfiguration
/set_var CFG_MG_STUFENKOSTEN 1
/set_var CFG_MG_STUFENKOSTEN_ECHO_ATTR Cyellow
/set_var CFG_MG_STUFENKOSTEN_ECHO_TEXT Du hast #1% der naechsten Stufe erreicht.


/set t_karate=0

;;; stufenkosten

/ifdef CFG_MG_STUFENKOSTEN karate_kosten = \
	/echo -a%CFG_MG_STUFENKOSTEN_ECHO_ATTR -- \
		$[sprintf(CFG_MG_STUFENKOSTEN_ECHO_TEXT,{1})]

/ifdef CFG_MG_STUFENKOSTEN -w -q -agCblue -msimple -p0 -t'Ruh Deine Knochen erstmal \
		ein bisschen aus. Bis zur naechsten Stufe werden sie' \
	karate_kosten1 = \
	/def -agCblue -msimple -p0 -1 -t'noch genug leiden muessen!' \
		karate_kosten1a = /karate_kosten 0-19

/ifdef CFG_MG_STUFENKOSTEN -w -q -agCblue -msimple -p0 -t'Ganz schoen anstrengend \
		immer nur mit Hand und Fuss zu metzeln, oder? Aber es' \
	karate_kosten2 = \
	/def -agCblue -msimple -p0 -1 -t'hat Dich schon etwas naeher an die \
		naechste Stufe rangebracht!' \
		karate_kosten2a = /karate_kosten 20-39

/ifdef CFG_MG_STUFENKOSTEN -w -q -agCblue -msimple -p0 -t'Du scheinst eingesehen \
		zu haben, dass hirnloses Draufhauen nix nutzt. Die' \
	karate_kosten3 = \
	/def -agCblue -msimple -p0 -1 -t'Haelfte haste ungefaehr schon geschafft!' \
		karate_kosten3a = \ /karate_kosten 40-59

/ifdef CFG_MG_STUFENKOSTEN -w -q -agCblue -msimple -p0 -t'Die Handkanten geschaerft, \
		den Gi fest zugebunden. Bald hast Du es geschafft!' \
	karate_kosten4 = /karate_kosten 60-79

/ifdef CFG_MG_STUFENKOSTEN  -w -q -agCblue -msimple -p0 -t'So viele blaue Flecken \
		wie Du an Armen und Beinen hast, kann die naechste' karate_kosten5 = \
	/def -agCblue -msimple -p0 -1 -t'Stufe nicht mehr weit sein!' \
		karate_kosten5a = /karate_kosten 80-99




/def -p3 -F -t"``Du kannst*" -ag -mglob t_karete_ein = \
     /set t_karate=1%;\
     /def -1 -p1 -t"*.''" -ag -mglob t_karete_aus = \
        /set t_karate=0\%;\
	/savelist -c -p karate

/def -F -p2 -E(t_karate) -ag -t"(^``Du kannst |)([A-Z][a-z-]+) (.+)(,| und|\\.'')$" -mregexp t_karate_bew1 = \
        /getkeyofvalue karate_guete %P3%;\
	/let guete=%?%;\
	/getvalueof karate %P2%;\
	/let last_guete=%?%;\
	/if (last_guete!~error & last_guete!~guete) \
	    /let verbessert=@{x}>@{$[state_color(last_guete)]}%last_guete\%%;\
	/endif%;\
	/uaddtolist karate %P2 %guete%;\
	/eval_hook set_skillability $[tolower({P2})] %guete%;\
	/let karate_prozent=(%guete\%%verbessert)%;\
	/let guete_color=@{$[state_color(guete)]}%;\
	/echo -p $[pad({P2},-32,':',1,guete_color,0,{P3},-33,karate_prozent,-10)]
	
/loadlist -c -p karate

/createlist karate_guete
/addtolist karate_guete 100 so perfekt wie ein wahrer Meister
/addtolist karate_guete 98 phantastisch meisterlich
/addtolist karate_guete 96 aussergewoehnlich meisterlich
/addtolist karate_guete 94 ueberaus meisterlich
/addtolist karate_guete 92 meisterlich
/addtolist karate_guete 90 fast meisterlich
/addtolist karate_guete 88 aussergewoehnlich phantastisch
/addtolist karate_guete 86 phantastisch
/addtolist karate_guete 84 beinahe phantastisch
/addtolist karate_guete 82 so langsam phantastisch
/addtolist karate_guete 80 wirklich hervorragend
/addtolist karate_guete 78 hervorragend
/addtolist karate_guete 76 ueberaus ausgezeichnet
/addtolist karate_guete 74 sehr ausgezeichnet
/addtolist karate_guete 72 ausgezeichnet
/addtolist karate_guete 70 fast ausgezeichnet
/addtolist karate_guete 68 wirklich sehr gut
/addtolist karate_guete 66 etwa sehr gut
/addtolist karate_guete 64 fast sehr gut
/addtolist karate_guete 62 bald sehr gut
/addtolist karate_guete 60 wirklich gut
/addtolist karate_guete 58 gut
/addtolist karate_guete 56 fast schon gut
/addtolist karate_guete 54 besser als nur recht gut
/addtolist karate_guete 52 recht gut
/addtolist karate_guete 50 schon bald recht gut
/addtolist karate_guete 48 gut mittelmaessig
/addtolist karate_guete 46 mittelmaessig
/addtolist karate_guete 44 fast, FAST mittelmaessig
/addtolist karate_guete 42 bald mittelmaessig
/addtolist karate_guete 40 gut passabel
/addtolist karate_guete 38 passabel
/addtolist karate_guete 36 knapp passabel
/addtolist karate_guete 34 halbwegs passabel
/addtolist karate_guete 32 deutlich besser als nur maessig
/addtolist karate_guete 30 etwas besser als nur maessig
/addtolist karate_guete 28 maessig
/addtolist karate_guete 26 fast maessig
/addtolist karate_guete 24 eher maessig als schlecht
/addtolist karate_guete 22 nicht mehr schlecht
/addtolist karate_guete 20 nicht mehr allzu schlecht
/addtolist karate_guete 18 mehr schlecht als recht
/addtolist karate_guete 16 schlecht
/addtolist karate_guete 14 sehr schlecht
/addtolist karate_guete 12 uebel
/addtolist karate_guete 10 sehr uebel
/addtolist karate_guete 8 miserabel
/addtolist karate_guete 6 sehr miserabel
/addtolist karate_guete 4 aeusserst miserabel
/addtolist karate_guete 2 hundsmiserabel
/addtolist karate_guete 0 total hundsmiserabel
