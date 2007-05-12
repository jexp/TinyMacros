; $Log: inventory.tf,v $
; Revision 1.30  2004/04/14 07:41:55  thufhnik
; Vesrays Ring in %inv_vesring
; Bei der Ermittlung von %inv_ring stoeren dieverse AT_MISC nicht mehr
;
; Revision 1.29  2004/01/25 13:49:09  thufhnik
; Nach dem Login einmal den Elfenbeinblock mit "dare" testen
;
; Revision 1.28  2003/12/01 05:36:45  thufhnik
; Nebelamulett
;
; Revision 1.27  2003/11/30 12:04:57  thufhnik
; /inv_check laeuft beim Start jetzt sicher durch.
;
; Revision 1.26  2003/09/13 09:33:34  thufhnik
; Magierpfade werden jetzt auch beim inv_check beruecksichtigt
; MGtool
;
; Revision 1.25  2003/08/25 09:35:18  thufhnik
; Terminatorschaedel
;
; Revision 1.24  2003/07/27 22:20:04  olm
; Leere Geldkarte wurde nicht erkannt und nicht rausgegaggt.
;
; Revision 1.23  2003/07/17 18:44:28  thufhnik
; dann das ganze nochmal sauberer
;
; Revision 1.22  2003/07/17 18:40:03  thufhnik
; wenn CFG_INV_MORE_LINES == 0 dann zeilen 0 ans mud.
;
; Revision 1.21  2003/04/15 12:30:46  thufhnik
; befleckte Ruestungen
;
; Revision 1.20  2003/03/10 13:47:27  thufhnik
; Haarstraehne der Nixe eingebaut
;
; Revision 1.19  2003/02/10 15:18:25  thufhnik
; kleine Ergaenzungen hier und da...
;
; Revision 1.18  2003/02/10 14:06:50  thufhnik
; Gewaender zu inv_rue
; Geldboerse
; Config-var CFG_INV_WEAR_AUTO
;
; Revision 1.17  2002/11/08 14:52:35  thufhnik
; Wurfsterne
;
; Revision 1.16  2002/10/17 08:33:24  thufhnik
; Sabberamulett, Spruehdose, Elekompass
;
; Revision 1.15  2002/10/10 07:42:24  thufhnik
; Talisman der Kleriker meldet bei /inv_check nicht mehr
;
; Revision 1.14  2002/10/06 09:08:28  thufhnik
; Beim An-/Ausziehen wird, wenn es konfiguriert ist, /inv_check aufgerufen
;
; Revision 1.13  2002/10/06 08:53:25  thufhnik
; Einige Ergaenzungen
;
; Revision 1.12  2002/09/16 08:50:09  thufhnik
; Plakette & Kerbholz
;
; Revision 1.11  2002/09/12 09:32:24  thufhnik
; Dem Gescrolle mit /tf_prompt ein Ende bereitet
; Fussring
;
; Revision 1.10  2002/09/11 08:22:41  thufhnik
; Flapa als Lichtquelle erkennen
;
; Revision 1.9  2002/09/03 11:03:46  thufhnik
; Nach dem Laden der Properties /inv_check
;
; Revision 1.8  2002/09/02 14:11:32  thufhnik
; Robe der Magie
;
; Revision 1.7  2002/08/01 08:07:36  thufhnik
; verbesserung in der prompt-behandlung
; totenschaedel von ti
;
; Revision 1.6  2002/07/31 14:10:39  thufhnik
; zeilen 0 und am ende wiederherstellen
;
; Revision 1.5  2002/07/14 14:57:53  thufhnik
; Score- und Totenkopfamulett
;
; Revision 1.4  2002/07/13 13:03:09  thufhnik
; Silberkreuz und Ausnahmen
;
; Revision 1.3  2002/07/11 13:21:57  thufhnik
; Hosen, Schuhe, Amulette
; Triggerbereinigung
;
; Revision 1.2  2002/07/10 19:52:42  thufhnik
; Ruestungen, Schuhe, Handschuhe und Ringe hinzugefuegt
;
; Revision 1.1  2002/05/15 13:29:31  thufhnik
; Scratch
;

/set inventory_tf_version=$Id: inventory.tf,v 1.30 2004/04/14 07:41:55 thufhnik Exp $
/set inventory_tf_author=Thufhir@mg.mud.de
/set inventory_tf_requires=util.hooks.tf util.trigger.tf
/set inventory_tf_desc=Pruefen ob gewisse Gegenstaende im Inv vorhanden sind


; Konfigurierbares

; Soll beim An-/Ausziehen von Ruestungen automatisch /inv_check aufgerufen
; werden?
/set_var CFG_INV_NOTIFY_CHANGE 1

; Wieviele Zeilen sollen beim Scrollen mit More uebrig bleiben? (zeilen auto -5)
; 0 fuer zeilen 0
/set_var CFG_INV_MORE_LINES 5

; Sollen Misc-Ruestungen automatisch angezogen werden?
/set_var CFG_INV_WEAR_AUTO 1


; Variablen initialisieren

/set inv_amu=
/set inv_arnischaedel=0
/set inv_bmuenzen=0
/set inv_boerse=0
/set inv_chaosball=0
/set inv_elekompass=0
/set inv_elfenbeinblock=0
/set inv_engelsfluegel=0
/set inv_fussring=0
/set inv_geldkarte=0
/set inv_handschuhe=
/set inv_helm=
/set inv_hyrue=0
/set inv_hose=
/set inv_kerbholz=0
/set inv_licht=0
/set inv_muenzen=0
/set inv_nebelamu=0
/set inv_ohrenschuetzer=0
/set inv_paket=0
/set inv_plakette=0
/set inv_rdm=0
/set inv_ring=
/set inv_robe=
/set inv_rucksack=0
/set inv_rue=
/set inv_sabberamu=0
/set inv_schaufel=0
/set inv_schild=
/set inv_schuhe=
/set inv_scoreamu=0
/set inv_seil=0
/set inv_silberkreuz=0
/set inv_spruehdose=0
/set inv_tarnhelm=0
/set inv_teddy=0
/set inv_tischaedel=0
/set inv_tkamu=0
/set inv_vesring=0
/set inv_wsterne=0

; Makros und Trigger

/def inv_cont = \
	/purge -mglob inv_check_*%;\
	/inv_check%1

/addh info \
Setzt einige Variablen (inv_*) je nachdem, ob gewisse Dinge im Inventory \
vorhanden sind. Nach Beendigung der Pruefung wird der Hook inventory_update \
ausgefuehrt.
/addh syn /inv_check
/addh ex /inv_check
/addh inv_check mak
/defh inv_check = \
	/if (!inv_check_running) \
		/set inv_check_running=1%;\
		/def -1 -agCblue -Fp1 -w -q -msimple -t'Okay, Deine \
			Zeilenzahl steht nun auf 0.' inv_check_cont%;\
		/send !\\zeilen 0%;\
		/tf_prompt inv_check /inv_check1%;\
	/endif

/def inv_check1 = \
	/set inv_bmuenzen=0%;\
	/set inv_boerse=0%;\
	/set inv_elekompass=0%;\
	/set inv_elfenbeinblock=0%;\
	/set inv_geldkarte=0%;\
	/set inv_kerbholz=0%;\
	/set inv_licht=0%;\
	/set inv_muenzen=0%;\
	/set inv_paket=0%;\
	/set inv_plakette=0%;\
	/set inv_schaufel=0%;\
	/set inv_seil=0%;\
	/set inv_spruehdose=0%;\
	/set inv_teddy=0%;\
	/ifdef (p_state=~"magier") -w -agCblue -p1 -mregexp -q -t'^ ([^ ]+)\
		[s\\'] MGtool v([0-9.]+) \\\\[[0-9]+:[0-9]+:[0-9]+\\\\]\
		\\\\.$$' inv_check_xtool = \
		/if (tolower({P1})=~p_name) \
			/if (!is_file_loaded("xtool.tf")) \
				/mload -c xtool.tf%%;\
			/endif%%;\
			/set inv_xtool=%%P2%%;\
		/endif%;\
	/def -w -agCblue -p1 -mregexp -q -t'^ Eine (leere )?Geldboerse( mit \
		(einer|[0-9]+) Muenzen?)?\\\\.$$' \
		inv_check_boerse = \
		/test ++inv_boerse%%;\
		/if ({P2} !~ "") \
			/if ({P3}=~"einer") \
				/test ++inv_bmuenzen%%;\
				/test ++inv_muenzen%%;\
			/else \
				/set inv_bmuenzen=$$[inv_bmuenzen+{P3}]%%;\
				/set inv_muenzen=$$[inv_muenzen+{P3}]%%;\
			/endif%%;\
		/endif%;\
	/def -1 -w -agCblue -p1 -mregexp -q -t'^ (Eine|[0-9]+) Muenzen?\\\\.\
		$$' inv_check_muenzen = \
		/if ({P1}=~"Eine") \
			/test ++inv_muenzen%%;\
		/else \
			/set inv_muenzen=$$[inv_muenzen+{P1}]%%;\
		/endif%;\
	/def -w -agCblue -p1 -mregexp -q -t'^ (De|E)in gelbes Postpaket \
		\\\\((geoeffnet|geschlossen)\\\\)\\\\.$$' inv_check_paket = \
		/test ++inv_paket%%;\
		/if ({P2} =~ "geschlossen") \
			/send !\\\\oeffne paket%%;\
		/endif%;\
	/def -w -agCblue -p1 -msimple -q -t' Ein Pfirsich (leuchtend).' \
		inv_check_pfirsich = /test ++inv_licht%;\
	/def -1 -w -agCblue -p1 -mregexp -q -t'^ [A-Za-z]+[s\\'] Teddybaer \
		.+\\\\.$$' inv_check_teddy = \
		/test ++inv_teddy%;\
	/def -1 -w -agCblue -p1 -msimple -q -t' Ein Block puren Elfenbeins.' \
		inv_check_eblock = /test ++inv_elfenbeinblock%;\
	/def -1 -w -agCblue -p1 -msimple -q -t' Eine magische Plakette.' \
		inv_check_plakette = /test ++inv_plakette%;\
	/def -1 -w -agCblue -p1 -msimple -q -t' Ein Kerbholz.' \
		inv_check_kerbholz = /test ++inv_kerbholz%;\
	/def -1 -w -agCblue -p1 -msimple -q -t' Deine Seer-Card (TM).' \
		inv_check_geldkarte = /set inv_geldkarte=-1%;\
	/def -w -agCblue -p1 -msimple -q -t' Eine Schaufel.' \
		inv_check_schaufel = /test ++inv_schaufel%;\
	/def -w -agCblue -p1 -msimple -q -t' Ein Seil.' \
		inv_check_seil = /test ++inv_seil%;\
	/def -w -agCblue -p1 -msimple -q -t' Eine schwarze Scheibe.' \
		inv_check_elekompass = /test ++inv_elekompass%;\
	/def -w -agCblue -p1 -mregexp -q -t'^ Eine Spruehdose( \\\\(\
		(noch fast voll|halbvoll|fast leer)\\\\)|\\\\.)$$' \
		inv_check_spruehdose = \
		/if ({P2}=~"") \
			/set inv_spruehdose=$$[inv_spruehdose+7]%%;\
		/elseif ({P2}=~"noch fast voll") \
			/set inv_spruehdose=$$[inv_spruehdose+5]%%;\
		/elseif ({P2}=~"halbvoll") \
			/set inv_spruehdose=$$[inv_spruehdose+3]%%;\
		/else \
			/test ++inv_spruehdose%%;\
		/endif%;\
	/def -mregexp -q -w -Fp0 -agCblue -t'^ [^ ].+\\\\.$$' inv_check_gag%;\
	/send !\\inv -w -r -f -1%;\
	/tf_prompt inventory /inv_cont 2

; Ruestungen
/def inv_check2 = \
	/def -Fp1000000 -w -mregexp -q -t'(^ .+) \\\\(befleckt\\\\)(.*)' \
		inv_fleckweg = /test substitute(strcat({P1},{P2}))%;\
	/set inv_amu=%;\
	/set inv_arnischaedel=0%;\
	/set inv_chaosball=0%;\
	/set inv_engelsfluegel=0%;\
	/set inv_fussring=0%;\
	/set inv_handschuhe=%;\
	/set inv_helm=%;\
	/set inv_hose=%;\
	/set inv_hyrue=0%;\
	/set inv_nebelamu=0%;\
	/set inv_ohrenschuetzer=0%;\
	/set inv_rdm=0%;\
	/set inv_ring=%;\
	/set inv_robe=%;\
	/set inv_rucksack=0%;\
	/set inv_rue=%;\
	/set inv_sabberamu=0%;\
	/set inv_schild=%;\
	/set inv_schuhe=%;\
	/set inv_scoreamu=0%;\
	/set inv_silberkreuz=0%;\
	/set inv_tarnhelm=0%;\
	/set inv_tischaedel=0%;\
	/set inv_tkamu=0%;\
	/set inv_vesring=0%;\
	/if (is_file_loaded("status_klerus.tf")) \
		/set klerus_quiet 1%;\
	/endif%;\
	/def -w -agCblue -p1 -mregexp -q -t'^ (Ein|Der) Rucksack\
		( von ([^ ]+))?( \\\\(angezogen\\\\))?\\\\.$$' \
		inv_check_rucksack = \
		/if ({P2} =~ "" | tolower({P3}) =~ p_name) \
			/test ++inv_rucksack%%;\
			/if ({P4}=~"" & inv_rucksack==1 & CFG_INV_WEAR_AUTO) \
				/send !\\\\trage rucksack%%;\
				/send !\\\\oeffne rucksack%%;\
			/endif%%;\
		/endif%;\
	/def -w -agCblue -p2 -mregexp -q -t'^ Die Ruestung des Hydratoeters\
		( \\\\(angezogen\\\\))?\\\\.$$' inv_check_hyrue = \
		/if ({P1} !~ "") \
			/set inv_rue=hydraruestung%%;\
		/endif%%;\
		/test ++inv_hyrue%%;\
		/test ++inv_licht%;\
	/def -w -agCblue -p2 -mregexp -q -t'^ Eine Robe der Magie\
		( \\\\(angezogen\\\\))?\\\\.$$' inv_check_rdm = \
		/if ({P1} !~ "") \
			/set inv_rue=robe%%;\
		/endif%%;\
		/test ++inv_rdm%;\
	/def -w -agCblue -p2 -mregexp -q -t'^ Ein Flammenpanzer\
		( \\\\(angezogen\\\\))?\\\\.$$' inv_check_flapa = \
		/if ({P1} !~ "") \
			/set inv_rue=flammenpanzer%%;\
		/endif%%;\
		/test ++inv_licht%;\
	/def -w -agCblue -p2 -mregexp -q -t'^ Ein Sabberamulett( \
		\\\\(angezogen\\\\))?\\\\.$$' inv_check_sabberamu = \
		/if ({P1} !~ "") \
			/set inv_amu=sabberamulett%%;\
		/endif%%;\
		/test ++inv_sabberamu%;\
	/def -w -agCblue -p2 -mregexp -q -t'^ Das Nebelamulett( \
		\\\\(angezogen\\\\))?\\\\.$$' inv_check_nebelamu = \
		/if ({P1} !~ "") \
			/set inv_amu=nebelamulett%%;\
			/purge inv_check_amu%%;\
		/endif%%;\
		/test ++inv_nebelamu%;\
	/def -1 -w -agCblue -p1 -mregexp -q -t'^ Ein Chaosball \
		\\\\(pulsierend\\\\)( \\\\(angezogen\\\\))?\\\\.$$' \
		inv_check_chaosball = \
		/test ++inv_licht%%;\
		/test ++inv_chaosball%%;\
		/if ({P1} =~ "" & CFG_INV_WEAR_AUTO) \
			/send !\\\\trage chaosball%%;\
		/endif%;\
	/def -1 -w -agCblue -p1 -mregexp -q -t'^ ([^ ].+ )?([A-Z][^ ]+(panzer|\
		ruestung|hemd)|Panzer|Ruestung|Hemd|Gewand).* \
		\\\\(angezogen\\\\)\\\\.$$' inv_check_rue = \
		/set inv_rue=$$[tolower({P2})]%;\
	/def -1 -w -agCblue -p2 -mregexp -q -t'^ Ein Nasenring( \\\\(\
		angezogen\\\\))?\\\\.$$' inv_check_nasenring%;\
	/def -1 -w -agCblue -p2 -mregexp -q -t'^ Ein Fussring\
		( \\\\(angezogen\\\\))?\\\\.$$' inv_check_fussring = \
		/if ({P1} =~ "" & CFG_INV_WEAR_AUTO) \
			/send !\\\\trage fussring%%;\
		/endif%%;\
		/test ++inv_fussring%;\
	/def -1 -w -agCblue -p2 -mregexp -q -t'^ Ein rabenschwarzer Ring\
		( \\\\(angezogen\\\\))?\\\\.$$' inv_check_vesring = \
		/if ({P1} =~ "" & CFG_INV_WEAR_AUTO) \
			/send !\\\\trage vesrayring%%;\
		/endif%%;\
		/test ++inv_vesring%;\
	/def -1 -w -agCblue -p2 -mregexp -q -t'^ Der Siegelring der Chaosgilde\
		( \\\\(angezogen\\\\))?\\\\.$$' inv_check_csiegelring = \
		/if ({P1} =~ "" & CFG_INV_WEAR_AUTO) \
			/send !\\\\trage siegelring%%;\
		/endif%;\
	/def -1 -w -agCblue -p2 -mregexp -q -t'^ Der Ring des Chaos\
		( \\\\(angezogen\\\\))?\\\\.$$' inv_check_chaosring%;\
; der hat leider keine eindeutige id, um ihn anziehen zu koennen ;(
	/def -1 -w -agCblue -p2 -mregexp -q -t'^ Ein Verlobungsring von \
		[A-Z][A-Za-z]+( \\\\(angezogen\\\\))?\\\\.$$' \
		inv_check_verlobungsring = \
		/if ({P1} =~ "" & CFG_INV_WEAR_AUTO) \
			/send !\\\\trage verlobungsring%%;\
		/endif%;\
	/def -1 -w -agCblue -p1 -mregexp -q -t'^ ([^ ].+ )?([A-Z][^ ]+ring|\
		Ring).* \\\\(angezogen\\\\)\\\\.$$' inv_check_ring = \
		/set inv_ring=$$[tolower({P2})]%;\
	/def -w -agCblue -p1 -mregexp -q -t'^ Ein Paar Engelsfluegel\
		( \\\\(angezogen\\\\))?\\\\.$$' inv_check_engelsfluegel = \
		/test ++inv_engelsfluegel%%;\
		/test ++inv_licht%%;\
		/if ({P1} =~ "" & CFG_INV_WEAR_AUTO) \
			/send !\\\\trage engelsfluegel%%;\
		/endif%;\
	/def -1 -w -agCblue -p1 -mregexp -q -t'^ (Eine? |Der |Die )?\
		([a-z]+ )?(([A-Z][a-z\\\\-]+)?([Ss]chuppe|[Ss]child)|Schild|\
		Schuppe|Kieferknochen) \\\\(angezogen\\\\)\\\\.$$' \
		inv_check_schild = \
		/if (shield_id !~ "") \
			/set inv_schild=%%shield_id%%;\
		/else \
			/set inv_schild=$$[tolower({P3})]%%;\
		/endif%;\
	/def -1 -w -agCblue -p2 -mregexp -q -t'^ ([^ ].+ )?([A-Z][^ ]+\
		(handschuhe|klauen|krallen)|Handschuhe|Klauen|Armschienen|\
		Krallen).* \\\\(angezogen\\\\)\\\\.$$' inv_check_glove = \
		/set inv_handschuhe=$$[tolower({P2})]%;\
	/def -1 -w -agCblue -p1 -mregexp -q -t'^ ([^ ].+ )?([A-Z][^ ]+\
		(robe|umhang|haut|kutte)|Robe|Umhang|Toga|Stola|Kutte|Haut).* \
		\\\\(angezogen\\\\)\\\\.$$' inv_check_robe = \
		/set inv_robe=$$[tolower({P2})]%;\
	/def -1 -w -agCblue -p1 -mregexp -q -t'^ ([^ ].+ )?([A-Z][^ ]+(schuhe|\
		stiefel|mokassins)|Stiefel|Schuhe|Mokassins|Kidari).* \
		\\\\(angezogen\\\\)\\\\.$$' inv_check_schuhe = \
		/set inv_schuhe=$$[tolower({P2})]%;\
	/def -1 -w -agCblue -p2 -mregexp -q -t'^ Ein heiliges Silberkreuz\
		( \\\\(angezogen\\\\))?\\\\.$$' inv_check_silberkreuz = \
		/set inv_silberkreuz 1%%;\
		/test ++inv_licht%%;\
		/if ({P1} !~ "") \
			/set inv_amu=silberkreuz%%;\
			/purge inv_check_amu%%;\
		/endif%;\
	/def -w -agCblue -p2 -mregexp -q -t'^ Ein Scoreamulett( \\\\(\
		angezogen\\\\))?\\\\.$$' inv_check_scoreamu = \
		/test ++inv_scoreamu%%;\
		/if ({P1} =~ "" & CFG_INV_WEAR_AUTO) \
			/send !\\\\trage scoreamulett%%;\
		/endif%;\
	/def -w -agCblue -p2 -mregexp -q -t'^ Ein Totenkopfamulett( \
		\\\\(angezogen\\\\))?\\\\.$$' inv_check_tkamu = \
		/test ++inv_tkamu%%;\
		/if ({P1} =~ "" & CFG_INV_WEAR_AUTO) \
			/send !\\\\trage totenkopfamulett%%;\
		/endif%;\
	/def -1 -w -agCblue -p1 -mregexp -q -t'^ ([^ ].+ )?([A-Z][^ ]+\
		(amulett|brosche|anhaenger)|Amulett|Brosche|Anhaenger|\
		Haarstraehne).* \\\\(angezogen\\\\)\\\\.$$' inv_check_amu = \
		/set inv_amu=$$[tolower({P2})]%;\
	/def -1 -w -agCblue -p1 -mregexp -q -t'^ ([^ ].+ )?([A-Z][^ ]+hose|\
		Hose|Beinschienen).* \\\\(angezogen\\\\)\\\\.$$' \
		inv_check_hose = /set inv_hose=$$[tolower({P2})]%;\
	/def -1 -w -agCblue -p2 -mregexp -q -t'^ Der Tarnhelm( \\\\(angezogen\
		\\\\))?\\\\.$$' inv_check_tarnhelm = \
		/test ++inv_tarnhelm%%;\
		/if ({P1} !~ "") \
			/set inv_helm=tarnhelm%%;\
		/endif%;\
	/def -1 -w -agCblue -p2 -mregexp -q -t'^ Der Schaedel eines \
		Terminators( \\\\(angezogen\\\\))?\\\\.$$' \
		inv_check_terminatorschaedel = \
		/test ++inv_arnischaedel%%;\
		/if ({P1} !~ "") \
			/set inv_helm=terminatorschaedel%%;\
		/endif%;\
	/def -1 -w -agCblue -p1 -mregexp -q -t'^ (Eine? |Der |Die )?\
		([a-z]+ )?(([A-Z][a-z\\\\-]+)?([Hh](elm|ut)|[Mm]uetze|\
		[Kk]rone)) (.* )?\\\\(angezogen\\\\)\\\\.$$' inv_check_helm = \
		/set inv_helm=$$[tolower({P3})]%;\
	/def -1 -w -agCblue -p1 -msimple -q -t' Ein Totenschaedel.' \
		inv_check_tischaedel = /test ++inv_tischaedel%;\
	/def -w -agCblue -p1 -mregexp -q -t'^ Ein Paar Ohrenschuetzer( \
		\\\\(angezogen\\\\))?\\\\.$$' inv_check_ohrenschuetzer = \
		/test ++inv_ohrenschuetzer%;\
	/def -mregexp -q -w -Fp0 -agCblue -t'^ [^ ].+\\\\.$$' inv_check_gag%;\
	/send !\\inv +r -f -1%;\
	/tf_prompt inventory /inv_cont 3

/def inv_check3 = \
	/purge inv_fleckweg%;\
	/set inv_wsterne=0%;\
	/def -1 -w -agCblue -p1 -mregexp -q -t'^ (Ein|[1-9][0-9]*) \
		Wurfsterne?\\\\.$$' inv_check_wsterne = \
		/if ({P1} =~ "Ein") \
			/set inv_wsterne 1%%;\
		/else \
			/set inv_wsterne %%P1%%;\
		/endif%;\
	/def -mregexp -q -w -Fp0 -agCblue -t'^ [^ ].+\\\\.$$' inv_check_gag%;\
	/send !\\inv +w -f -1%;\
	/tf_prompt inventory /inv_cont 4

/def inv_check4 = \
	/if (inv_geldkarte == -1) \
		/def -1 -w -agCblue -p1 -mregexp -q -t'^Dein Guthaben betraegt \
			([0-9]+) Muenzen\\\\.$$' inv_check_guthaben = \
			/set inv_geldkarte=%%P1%%;\
			/undef inv_check_guthaben2%;\
		/def -1 -w -agCblue -p1 -msimple -q -t'Welches Guthaben? :-)' \
			inv_check_guthaben2 = \
			/set inv_geldkarte=0%%;\
			/undef inv_check_guthaben%;\
		/send !\\guthaben%;\
		/tf_prompt inventory /inv_cont final%;\
	/else \
		/inv_checkfinal%;\
	/endif

/def inv_checkfinal = \
	/if (CFG_INV_MORE_LINES) \
		/def -1 -w -q -p100 -mregexp -agCblue -t'^Ok, Deine Zeilenzahl \
			wird nun automatisch ermittelt \\\\(derzeit \
			[0-9]+\\\\)\\\\.$$' \
			inv_check_final_g1%;\
		/def -1 -w -q -p100 -msimple -agCblue -t'Bitte beachte, dass \
			dies nur einwandfrei funktioniert, wenn Dein Client' \
			inv_check_final_g2%;\
		/def -1 -w -q -p100 -msimple -agCblue -t'Telnetnegotiations \
			unterstuetzt (siehe auch "hilfe telnegs").' \
			inv_check_final_g3 = \
			/unset inv_check_running%%;\
			/eval_hook inventory_update%;\
		/send !\\zeilen auto -%CFG_INV_MORE_LINES%;\
	/else \
		/unset inv_check_running%;\
		/eval_hook inventory_update%;\
	/endif

/def -E(inv_wsterne) -mglob -Fp100 -w -t'Du nimmst einen Wurfstern in die \
	Hand und wirfst ihn nach *' inv_wsterne_throw = /test --inv_wsterne%;\

/def -mregexp -Fp100 -w -t'^Du nimmst (den|[0-9]+) Wurfsterne?\\.$' \
	inv_wsterne_get = \
	/if ({P1}=~'den') \
		/test ++inv_wsterne%;\
	/else \
		/set inv_wsterne=$[inv_wsterne+{P1}]%;\
	/endif

/def -E(inv_wsterne) -mregexp -Fp100 -w -t'^Du laesst (den|[0-9]+) Wurfsterne? \
	fallen\\.$' inv_wsterne_drop = \
	/if ({P1}=~'den') \
		/test --inv_wsterne%;\
	/else \
		/if (inv_wsterne>{P1}) \
			/set inv_wsterne=$[inv_wsterne-{P1}]%;\
		/else \
			/set inv_wsterne 0%;\
		/endif%;\
	/endif

/ifdef CFG_INV_NOTIFY_CHANGE -E(!inv_check_running) -Fp1 -q -w -mglob \
	-t'Du ziehst * {an.|aus.}' inv_notify_change = /inv_check

/ifdef (p_state=~"magier") -E(inv_check_running) -Fp1000000 -w -q -mregexp \
	-t'^( [^ ].+\\.) \\[.+\\]$' inv_substpath = \
	/test substitute({P1})

/def inv_elfenbeinblock_auto = \
	/remove_from_hook inventory_update /inv_elfenbeinblock_auto%;\
	/if (inv_elfenbeinblock) \
		/send !\\dare%;\
	/endif%;\
	/purge inv_elfenbeinblock_auto

/add_to_hook inventory_update /inv_elfenbeinblock_auto
/add_to_hook loadsaved /inv_check
