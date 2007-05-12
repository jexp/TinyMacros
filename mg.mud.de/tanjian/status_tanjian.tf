; $Log: status_tanjian.tf,v $
; Revision 1.20  2002/09/11 18:14:58  thufhnik
; Tanjinreport forcieren beim laden
;
; Revision 1.19  2002/05/31 08:24:52  thufhnik
; Anpassung an neue weapon2.tf
;
; Revision 1.18  2002/04/20 16:00:03  thufhnik
; 1. Anpassunf an /configure
;
; Revision 1.17  2002/04/04 12:58:02  thufhnik
; Umgestellt auf neues Config-System, .cfg wird ab jetzt nicht mehr angefasst
;
; Revision 1.16  2002/04/01 19:17:41  thufhnik
; Funktion aus util.vfunc.tf benutzen
;
; Revision 1.15  2002/03/31 12:51:23  thufhnik
; alle Flags in der Statuszeile sind jetzt voll konfigurierbar
;
; Revision 1.14  2002/03/30 20:26:36  thufhnik
; erste Anpassungen an das neue status.tf und Konfigurationsvorschlaege
;
; Revision 1.13  2002/03/03 19:33:26  thufhnik
; kami
;
; Revision 1.12  2002/02/15 12:57:11  thufhnik
; Doku zu den Status-Modulen
;
; Revision 1.11  2002/02/01 13:25:47  thufhnik
; p_frog aus Tanjianreport setzen
;
; Revision 1.10  2002/01/29 14:12:40  thufhnik
; Bugfix in der Auswertung der Fluchtrichtung
;
; Revision 1.9  2002/01/29 13:59:31  thufhnik
; vs und fr aus dem report auswerten
;
; Revision 1.8  2002/01/29 13:38:45  thufhnik
; Tanjianreport auf lange Align-Ausgabe umgestellt
; tanjian_mustmedi mit 1 initialisieren
;
; Revision 1.7  2002/01/29 13:30:59  thufhnik
; Alignment aus tanjianreport in p_align
;
; Revision 1.6  2002/01/26 11:19:55  thufhnik
; Diverse Erweiterungen
;
; Revision 1.5  2002/01/21 18:52:34  thufhnik
; Meditation, Tegatana, Omamori, etc.
;
; Revision 1.4  2001/12/14 14:03:24  thufhnik
; akshara
;
; Revision 1.3  2001/12/13 16:23:36  thufhnik
; gift
;
; Revision 1.2  2001/12/13 16:10:57  thufhnik
; blind & taub dazu
;
; Revision 1.1  2001/12/12 16:14:38  thufhnik
; Scratch
;

/set status_tanjian_tf_version $Id: status_tanjian.tf,v 1.20 2002/09/11 18:14:58 thufhnik Exp $
/set status_tanjian_tf_author=Thufhir@mg.mud.de
/set status_tanjian_tf_requires=status.tf(1.24) util.vfunc(1.18)
/set status_tanjian_tf_desc=Statuszeile und Report fuer die Tanjiangilde

; Variablen initialisieren

/set tanjian_mustmedi 1

; Statusmodule

/set_var CFG_STATUS_COLOR_TANJIAN_MUSTMEDI_1=Cbgred,Cwhite
/set_var CFG_STATUS_TEXT_TANJIAN_MUSTMEDI_1 M

/set sl_tanjian_mustmedi_doc=wenn meditiert werden muss: $[status_doc_attr("TANJIAN_MUSTMEDI_1")]
/set_status_var_flag tanjian_mustmedi tanjian_mustmedi 1

/set_var CFG_STATUS_COLOR_TANJIAN_KOKORO_1 Cyellow
/set_var CFG_STATUS_TEXT_TANJIAN_KOKORO_1 k
/set_var CFG_STATUS_COLOR_TANJIAN_KOKORO_2 Cred
/set_var CFG_STATUS_TEXT_TANJIAN_KOKORO_2 K
/set_var CFG_STATUS_COLOR_TANJIAN_KOKORO_3 Cred,h
/set_var CFG_STATUS_TEXT_TANJIAN_KOKORO_3 K

/set sl_tanjian_kokoro_doc=Kokoro aktiv: $[status_doc_attr("TANJIAN_KOKORO_1")], $[status_doc_attr("TANJIAN_KOKORO_2")] oder $[status_doc_attr("TANJIAN_KOKORO_3")]
/set_status_var_count tanjian_kokoro tanjian_kokoro 1 3

/set_var CFG_STATUS_COLOR_TANJIAN_HAYAI_1 Cwhite
/set_var CFG_STATUS_TEXT_TANJIAN_HAYAI_1 h
/set_var CFG_STATUS_COLOR_TANJIAN_HAYAI_2 Ccyan
/set_var CFG_STATUS_TEXT_TANJIAN_HAYAI_2 H
/set_var CFG_STATUS_COLOR_TANJIAN_HAYAI_3 Ccyan,h
/set_var CFG_STATUS_TEXT_TANJIAN_HAYAI_3 H

/set sl_tanjian_hayai_doc=Hayai aktiv: $[status_doc_attr("TANJIAN_HAYAI_1")], $[status_doc_attr("TANJIAN_HAYAI_2")] oder $[status_doc_attr("TANJIAN_HAYAI_3")]
/set_status_var_count tanjian_hayai tanjian_hayai 1 3

/set_var CFG_STATUS_COLOR_TANJIAN_AKSHARA_1 Cred
/set_var CFG_STATUS_TEXT_TANJIAN_AKSHARA_1 a
/set_var CFG_STATUS_COLOR_TANJIAN_AKSHARA_2 Ccyan
/set_var CFG_STATUS_TEXT_TANJIAN_AKSHARA_2 A
/set_var CFG_STATUS_COLOR_TANJIAN_AKSHARA_3 Cyellow,h
/set_var CFG_STATUS_TEXT_TANJIAN_AKSHARA_3 A
/set_var CFG_STATUS_COLOR_TANJIAN_AKSHARA_4 Cred
/set_var CFG_STATUS_TEXT_TANJIAN_AKSHARA_4 ~

/set sl_tanjian_akshara_doc=Akshara (aktiv: $[status_doc_attr("TANJIAN_AKSHARA_1")], $[status_doc_attr("TANJIAN_AKSHARA_2")], $[status_doc_attr("TANJIAN_AKSHARA_3")]; nicht moeglich:$[status_doc_attr("TANJIAN_AKSHARA_4")])
/set_status_var_count tanjian_akshara tanjian_akshara 1 4

/set_var CFG_STATUS_COLOR_TANJIAN_TEOM_1 Cmagenta
/set_var CFG_STATUS_TEXT_TANJIAN_TEOM_1 T
/set_var CFG_STATUS_COLOR_TANJIAN_TEOM_2 Cgreen
/set_var CFG_STATUS_TEXT_TANJIAN_TEOM_2 O

/set sl_tanjian_teom_doc=Tegatana oder Omamori aktiv ($[status_doc_attr("TANJIAN_TEOM_1")] oder $[status_doc_attr("TANJIAN_TEOM_2")])
/set_status_var_count tanjian_teom tanjian_teom 1 2

/set_var CFG_STATUS_COLOR_TANJIAN_CLAN_1 Cred
/set_var CFG_STATUS_TEXT_TANJIAN_CLAN_1 ?
/set_var CFG_STATUS_COLOR_TANJIAN_CLAN_2 Cred
/set_var CFG_STATUS_TEXT_TANJIAN_CLAN_2 ?
/set_var CFG_STATUS_COLOR_TANJIAN_CLAN_3 Cred
/set_var CFG_STATUS_TEXT_TANJIAN_CLAN_3 ?

/set sl_tanjian_clan_doc=Clanspell
/set_status_var_count tanjian_clan tanjian_clan 1 3

; Tanjianreport auf die Trigger einstellen

/def tanjian_set_report = \
	/def -1 -agCblue -q -Fp10000 -w -msimple -t'Alte Meldung war:' \
		tanjian_setgag1 = \
		/def -agCblue -q -Fp10000 -w -mregexp -t'$$$' \
			tanjian_setgag2 = \
			/if ({PL} =~ 'Neue Reportmeldung:') \
				/purge -msimple tanjian_setgag2%%%;\
				/def -1 -agCblue -F -q -p10000 -w -mglob \
					-t'LP: *' tanjian_setgag3%%%;\
				/def -1 -agCblue -F -q -p10000 -w -mglob \
					-t'AK: *' tanjian_setgag4%%%;\
			/endif%;\
	/def -1 -agCblue -q -Fp10000 -w -mregexp -t'^Tanjianreport (war \
		schon )?angeschaltet\\\\.$$' tanjian_setgag5%;\
	/send !\\tanjianreport LP: \%la (\%lm) MP: \%ka (\%km) GI: \%GI \
		VS: \%vo FR: \%fl\%lf\
		KO: \%ko HA: \%ha TO: \%Te AK: \%ak CA: \%CA BL: \%bl \
		TA: \%ta FRO: \%fr ME: \%me.\%lf%;\
	/send !\\tanjianreport ein%;\
	/send !\\tanjianreport

; Tanjianreport triggern

/def -p1 -w -q -agCgreen -mregexp -t'^LP\\: ([0-9]+) \\(([0-9]+)\\) \
	MP\\: ([0-9]+) \\(([0-9]+)\\) GI\\: (G| ) VS\\: ([0-9]+) \
	FR\\: (.*)$' tanjian_reptrigger1 = \
	/eval_hook points %P1 %P3%;\
	/set p_maxlp %P2%;\
	/set p_maxmp %P4%;\
	/if ({P5} =~ 'G') \
		/set p_poison=schwer%;\
		/set p_poison_time=$[time()]%;\
	/else \
		/set p_poison=%;\
	/endif%;\
	/if ({P7} =~ '0') \
		/check_vorsicht %P6 keine%;\
	/else \
		/check_vorsicht %P6 %P7%;\
	/endif

/def -p1 -w -q -agCgreen -mregexp -t'^KO\\: (ja|nein) HA\\: (ja|nein) \
	TO\\: (TE|OM|  ) AK\\: (ja|nein|busy) CA\\: (.+) \
	BL\\: (J|N) TA\\: (J|N) FRO\\: (J|N) ME\\: (J|N)\\.$' \
	tanjian_reptrigger2 = \
	/if ({P1} =~ 'ja') \
		/set_flag tanjian_kokoro%;\
	/else \
		/set tanjian_kokoro=0%;\
	/endif%;\
	/if ({P2} =~ 'ja') \
		/set_flag tanjian_hayai%;\
	/else \
		/set tanjian_hayai=0%;\
	/endif%;\
	/if ({P3} =~ 'TE') \
		/set tanjian_teom=1%;\
	/elseif ({P3} =~ 'OM') \
		/set tanjian_teom=2%;\
	/else \
		/set tanjian_teom=0%;\
	/endif%;\
	/if ({P4} =~ 'ja') \
		/set_flag tanjian_akshara%;\
	/elseif ({P4} =~ 'nein') \
		/set tanjian_akshara=0%;\
	/elseif ({P4} =~ 'busy') \
		/set tanjian_akshara=4%;\
	/endif%;\
	/set p_align=%P5%;\
	/if ({P6} =~ 'J') \
		/set p_blind 1%;\
	/else \
		/set p_blind 0%;\
	/endif%;\
	/if ({P7} =~ 'J') \
		/set p_deaf 1%;\
	/else \
		/set p_deaf 0%;\
	/endif%;\
	/if ({P8} =~ 'J') \
		/set p_frog 1%;\
	/else \
		/set p_frog 0%;\
	/endif%;\
	/if ({P9} =~ 'N') \
		/set tanjian_mustmedi 1%;\
	/else \
		/set tanjian_mustmedi 0%;\
	/endif

; Fehler

/def -aCbggreen -F -q -msimple -t'Vielleicht lernst Du ja aus Deinem \
	Fehler.' tanjian_error = /set TANJIAN_BUSY=

; Meditation

/def -msimple -aCred -t'Du setzt Dich hin und faengst an zu meditieren.' \
	tanjian_meditation = /set TANJIAN_BUSY=meditation%;\
	/def -1 -msimple -aCgreen -t'Du beendest Deine Meditation.' \
		tanjian_meditation_fertig = \
		/set TANJIAN_BUSY=%%;\
		/set tanjian_mustmedi 0

; Kokoro

/def -agCblue -F -q -msimple -t'Du versinkst in tiefe Konzentration. Du \
	konzentrierst Dich auf Kokoro, die' tanjian_kokoro_prep = \
	/def -1 -agCblue -F -q -msimple -t'Membran im Zentrum der Dinge. \
		Alles um Dich herum versinkt in einer absoluten' \
		tanjian_kokoro_gag1a%;\
	/def -1 -agCblue -F -q -msimple -t'Dunkelheit.' tanjian_kokoro_gag1b%;\
	/set TANJIAN_BUSY=kokoro%;\
	/echo -aCgreen Tanjian Konzentration: Kokoro

/def -agCblue -F -q -mregexp -t'Du versetzt Kokoro in Schwingung und \
	spuerst, wie (die|etwas|viel) Energie Deinen' tanjian_kokoro = \
	/purge -mregexp tanjian_kokoro_2[a-c]%;\
	/repeat -1 1 /purge tanjian_kokoro_2c%;\
	/def -1 -agCblue -F -q -msimple -t'Geist durchstroemt.' \
		tanjian_kokoro_2a%;\
	/def -1 -agCblue -F -q -msimple -t'Die Dunkelheit loest sich von \
		Deinem Geist.' tanjian_kokoro_2b = /set TANJIAN_BUSY=%;\
	/def -1 -agCblue -F -q -msimple -t'Die Energie scheint Dein \
		Bewusstsein zu erweitern.' tanjian_kokoro_2c%;\
	/if ({P1}=~"viel") \
		/set tanjian_kokoro=3%;\
		/let TANJIAN_KOK=(+)%;\
	/elseif ({P1}=~"die") \
	      /set tanjian_kokoro=2%;\
		/let TANJIAN_KOK=%;\
	/elseif ({P1}=~"etwas") \
	      /set tanjian_kokoro=1%;\
		/let TANJIAN_KOK=(-)%;\
	/else \
		/set tanjian_kokoro=-1%;\
		/let TANJIAN_KOK=?%;\
	/endif%;\
	/echo -aCgreen Tanjian: Kokoro %TANJIAN_KOK

/def -agCblue -F -q -msimple -t'Du versetzt Kokoro in Schwingung. Doch \
	Deine Konzentration war offenbar nicht' tanjian_kokoro_error = \
	/purge -mregexp tanjian_kokoro_3[a-c]%;\
	/set tanjian_kokoro=-1%;\
	/def -1 -agCblue -F -q -msimple -t'ausreichend. Negative Energie \
		martert Deinen Geist.' tanjian_kokoro_3a%;\
	/def -1 -agCblue -F -q -msimple -t'Die Dunkelheit loest sich \
		widerstrebend von Deinem Geist.' \
		tanjian_kokoro_3b = /set TANJIAN_BUSY=%;\
	/def -1 -agCblue -F -q -msimple -t'Deine Konzentration hat wohl nicht \
		ausgereicht.' tanjian_kokoro_3c%;\
	/echo -aCred Tanjian Fehlschlag: Kokoro

/def -msimple -aCred -t'Die Energien des Kokoro versiegen.' \
	tanjian_kokoro_aus = \
	/set tanjian_kokoro=0

/def -msimple -aCred -t'Die Membran schwingt doch noch!' tanjian_kokoro_ison

; Kampfkonzentration

/def -agCblue -F -q -msimple -t'Du versinkst in tiefer Konzentration.' \
	tanjian_konzentration = \
	/echo -aCgreen Tanjian Konzentration: Kampf (Abwehr/Angriff/Zeit)%;\
	/set TANJIAN_BUSY=kampfkonzentration

; Kampfkonzentration ausserhalb von Kaempfen

/def -aCred -F -q -msimple -t'Wenn Du nicht kaempfst, nuetzt das doch \
	ueberhaupt nichts.' tanjian_kampfkonzentration_fehler = \
	/if (TANJIAN_BUSY=~"kampfkonzentration") \
		/set TANJIAN_BUSY=%;\
	/endif

; Tegatana

/def -agCblue -F -q -msimple -t'Du konzentrierst Dich auf den Kampf.' \
	tanjian_tegatana = \
	/purge tanjian_tegatana_succ%;\
	/def -aCbggreen -1 -F -q -msimple -t'Du fuehlst Dich regelrecht \
		aufgeputscht.' tanjian_tegatana_succ%;\
	/echo -aCgreen Tanjian: Tegatana%;\
	/set TANJIAN_BUSY=

/def -aCred -F -q -msimple -t'Deine Kampf-Konzentration laesst nach.' \
	tanjian_tegatana_aus = \
	/set tanjian_teom=0

/def -aCred -F -q -msimple -t'Du konzentrierst Dich doch bereits auf den \
	Kampf.' tanjian_tegatana_ison

/def -aCred -F -q -msimple -t'Du konzentrierst Dich derzeit auf Deine \
	Abwehr.' tanjian_tegatana_omaison

; Omamori

/def -agCblue -F -q -msimple -t'Du konzentrierst Dich auf die Abwehr.' \
	tanjian_omamori = \
	/purge tanjian_omamori_succ%;\
	/repeat -1 1 /purge tanjian_omamori_succ%;\
	/def -aCbggreen -1 -F -q -msimple -t'Du fuehlst Dich richtig sicher.' \
		tanjian_omamori_1a%;\
        /echo -aCgreen Tanjian: Omamori%;\
        /set TANJIAN_BUSY=

/def -aCred -F -q -msimple -t'Deine Abwehr-Konzentration laesst nach.' \
	tanjian_omamori_aus = \
	/set tanjian_teom=0

/def -aCred -F -q -msimple -t'Du konzentrierst Dich derzeit auf den Kampf.' \
	tanjian_omamori_tegaison

; Hayai

/def -agCblue -F -q -msimple -t'Du konzentrierst Dich auf den Fluss der \
	Zeit.' tanjian_hayai = \
	/purge -mregexp tanjian_hayai_1[a-c]%;\
	/repeat -1 1 /purge -mregexp tanjian_hayai_1[ac]%;\
	/def -aCbggreen -F -q -1 -msimple -t'Allerdings nicht so, wie \
		Du Dir das erhofft hattest.' tanjian_hayai_1a = \
		/set tanjian_hayai=-1%;\
	/def -agCblue -1 -F -q -mregexp -t'Der Zeitfluss veraendert \
		sich( sehr| etwas|)\\\\.' tanjian_hayai_1b = \
		/if ({P1}=~" sehr") \
			/let TANJIAN_HAYAI=(+)%%;\
			/set tanjian_hayai=3%%;\
		/elseif ({P1}=~" etwas") \
			/let TANJIAN_HAYAI=(-)%%;\
			/set tanjian_hayai=1%%;\
		/else \
			/let TANJIAN_HAYAI=%%;\
			/set tanjian_hayai=2%%;\
		/endif%%;\
		/echo -aCgreen Tanjian: Hayai %%TANJIAN_HAYAI%;\
	/def -aCbggreen -1 -F -q -msimple -t'Alles um Dich herum scheint zu \
		erstarren.' tanjian_hayai_1c%;\
	/set TANJIAN_BUSY=

/def -aCred -F -q -msimple -t'Die Kontrolle ueber den Zeitfluss entgleitet \
	Dir.' tanjian_hayai_aus = /set tanjian_hayai=0

/def -aCred -F -q -msimple -t'Du konzentrierst Dich bereits auf den \
	Zeitfluss.' tanjian_hayai_ison = /set tanjian_hayai=\
	$[tanjian_hayai?tanjian_hayai:1]

; Akshara

/def tanjian_do_akshara = \
	/if /ismacro weapon_unwear%; /then \
		/set weapon_quiet 1%;\
		/weapon_unwear%;\
	/endif%;\
	/if /ismacro shield_unwear%;/then \
		/set shield_quiet 1%;\
		/shield_unwear%;\
	/endif%;\
	/send !\\akshara

/def -agCblue -F -q -msimple -t'Du konzentrierst Dich voll auf Dich selbst.' \
	tanjian_akshara_vorb = \
	/echo -aCgreen Tanjian Konzentration: Akshara%;\
	/set TANJIAN_BUSY=akshara

/def -agCblue -F -q -mregexp -t'Deine Haende fangen ploetzlich an\\, (leicht|\
	hell|sehr hell) zu leuchten\\.' tanjian_akshara = \
	/purge tanjian_akshara_2a%;\
	/repeat -1 1 /purge tanjian_akshara_2a%;\
	/if ({P1} =~ "leicht") \
		/let TANJIAN_AKSHARA=(-)%;\
		/set tanjian_akshara 1%;\
	/elseif ({P1} =~ "hell") \
		/set tanjian_akshara 2%;\
		/let TANJIAN_AKSHARA=%;\
	/elseif ({P1} =~ "sehr hell") \
		/set tanjian_akshara 3%;\
		/let TANJIAN_AKSHARA=(+)%;\
	/endif%;\
	/def -1 -F -aCbggreen -q -msimple -t'Du bist fast geblendet von dem \
		Leuchten.' tanjian_akshara_2a%;\
	/set TANJIAN_BUSY=%;\
	/echo -aCgreen Tanjian: Akshara %TANJIAN_AKSHARA

/def -aCred -F -q -msimple -t'Du verlaesst den Pfad des Lichtes.' \
	tanjian_akshara_out = \
	/set tanjian_akshara=4%;\
	/if (TANJIAN_BUSY !~ 'kageodori' & !weapon_drawn) \
		/if /ismacro weapon_draw%;/then \
			/set weapon_quiet 1%;\
			/weapon_draw%;\
		/endif%;\
		/if /ismacro shield_wear%;/then \
			/set shield_quiet 1%;\
			/shield_wear%;\
		/endif%;\
	/endif

/def -agCblue -F -q -msimple -t'Du warst wohl nicht ganz auf dem Pfad des \
	Lichtes.' tanjian_akshara_error = \
	/set TANJIAN_BUSY=%;\
	/set tanjian_akshara=4%;\
	/if /ismacro weapon_draw%;/then \
		/set weapon_quiet 1%;\
		/weapon_draw%;\
	/endif%;\
	/if /ismacro shield_wear%;/then \
		/set shield_quiet 1%;\
		/shield_wear%;\
	/endif

; Kami

/def -agCblue -Fp1 -q -mregexp -t'^Du konzentrierst Dich auf (die|den|das) \
	(.+)\\.$' tanjian_kami = \
	/if (tolower({P2}) =~ weapon) \
		/purge tanjian_kami_out%;\
		/echo -aCgreen Tanjian Konzentration: Kami%;\
		/set TANJIAN_BUSY=kami%;\
		/def -1 -agCblue -F -q -mregexp -t'^Du richtest (den|die|das) \
			(.+) auf (.+)\\\\.$$' tanjian_kami_out = \
			/set TANJIAN_BUSY=%%;\
			/purge tanjian_kami_success%%;\
			/repeat -1 1 /purge tanjian_kami_success%%;\
			/def -1 -F -aCbggreen -q -msimple -t'Das also ist die \
				Macht der Geister.' tanjian_kami_success%;\
	/else \
		/test substitute({P0}, 'x')%;\
	/endif

; Angaben von Siamil in %

/def tanjian_str2percent = \
	/if ({*} =~ "aeusserst uebel") \
		/echo 5%;\
	/elseif ({*} =~ "sehr uebel") \
		/echo 7,5%;\
	/elseif ({*} =~ "uebel") \
		/echo 10%;\
	/elseif ({*} =~ "noch uebel") \
		/echo 12,5%;\
	/elseif ({*} =~ "aeusserst miserabel") \
		/echo 15%;\
	/elseif ({*} =~ "sehr miserabel") \
		/echo 17,5%;\
	/elseif ({*} =~ "miserabel") \
		/echo 20%;\
	/elseif ({*} =~ "noch miserabel") \
		/echo 22,5%;\
	/elseif ({*} =~ "aeusserst schlecht") \
		/echo 24%;\
	/elseif ({*} =~ "sehr schlecht") \
		/echo 26%;\
	/elseif ({*} =~ "reichlich schlecht") \
		/echo 28%;\
	/elseif ({*} =~ "ziemlich schlecht") \
		/echo 30%;\
	/elseif ({*} =~ "schlecht") \
		/echo 32%;\
	/elseif ({*} =~ "gerade noch schlecht") \
		/echo 34%;\
	/elseif ({*} =~ "aeusserst ungenuegend") \
		/echo 36%;\
	/elseif ({*} =~ "ungenuegend") \
		/echo 38%;\
	/elseif ({*} =~ "noch ungenuegend") \
		/echo 40%;\
	/elseif ({*} =~ "aeusserst mangelhaft") \
		/echo 42%;\
	/elseif ({*} =~ "sehr mangelhaft") \
		/echo 44%;\
	/elseif ({*} =~ "mangelhaft") \
		/echo 46%;\
	/elseif ({*} =~ "noch mangelhaft") \
		/echo 48%;\
	/elseif ({*} =~ "fast ausreichend") \
		/echo 50%;\
	/elseif ({*} =~ "ausreichend") \
		/echo 54%;\
	/elseif ({*} =~ "gut ausreichend") \
		/echo 58%;\
	/elseif ({*} =~ "fast befriedigend") \
		/echo 60%;\
	/elseif ({*} =~ "befriedigend") \
		/echo 66%;\
	/elseif ({*} =~ "sehr befriedigend") \
		/echo 70%;\
	/elseif ({*} =~ "fast gut") \
		/echo 75%;\
	/elseif ({*} =~ "gut") \
		/echo 80%;\
	/elseif ({*} =~ "ziemlich gut") \
		/echo 82,5%;\
	/elseif ({*} =~ "wirklich gut") \
		/echo 85%;\
	/elseif ({*} =~ "sehr gut") \
		/echo 87,5%;\
	/elseif ({*} =~ "aussergewoehnlich gut") \
		/echo 90%;\
	/elseif ({*} =~ "unglaublich gut") \
		/echo 92%;\
	/elseif ({*} =~ "besser als gut") \
		/echo 94%;\
	/elseif ({*} =~ "viel besser als gut") \
		/echo 96%;\
	/elseif ({*} =~ "beinahe perfekt") \
		/echo 99,5%;\
	/elseif ({*} =~ "so gut wie perfekt") \
		/echo 99,9%;\
	/elseif ({*} =~ "wirklich fast perfekt") \
		/echo 100%;\
	/else \
		/echo ??%;\
	/endif

/def -msimple -p200 -agCblue -t'Siamil teilt Dir mit: Dies sind Deine \
	Faehigkeiten:' tanjian_sia_pro_tr1 = \
	/echo -ahCgreen Faehigkeiten:%;\
	/def -p200 -mregexp -agCblue -t'^Siamil teilt Dir mit\\\\: ([a-z]+)\
		\\\\.+([a-z ]+)$$' tanjian_sia_pro_rep = \
		/let TANJIAN_TMP_PRO=$$(/tanjian_str2percent %%P2)%%;\
		/echo -aCgreen %%P1: %%TANJIAN_TMP_PRO\%%;\
	/def -1 -p200 -msimple -agCblue -t'Siamil teilt Dir mit: Gehe hin und \
		uebe Deine Faehigkeiten!' tanjian_sia_pro_end = \
		/purge tanjian_sia_pro_rep

; Sachen beim Laden starten

/tanjian_set_report
/config_status
