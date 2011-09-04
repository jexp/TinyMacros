; $Log: status_dunkelelfen.tf,v $
; Revision 1.32  2004/12/22 14:36:31  thufhnik
; bessere Behandlung der Busy-Erkennung
; vor der Blitzhand Handschuhe ausziehen
;
; Revision 1.31  2004/12/13 13:42:08  thufhnik
; Beschwoere kommt jetzt auch mit 2 Zombies zurecht
;
; Revision 1.30  2004/07/20 12:58:41  thufhnik
; "," in Finsternismeldung eingefuegt (verdammte typokorrektur)
;
; Revision 1.29  2004/07/14 11:36:40  thufhnik
; Flags aus im Todeshook
;
; Revision 1.28  2004/07/14 10:35:55  thufhnik
; Kommata in Schutz und Schutzhuelle eingefuegt
;
; Revision 1.27  2004/03/24 07:41:23  thufhnik
; Weitere Meldung zu Schutzschild
;
; Revision 1.26  2004/03/23 12:27:45  thufhnik
; Ergaenzung zu Bannkreis und dem busy
;
; Revision 1.25  2003/12/06 14:34:09  chbr
; Typofix in vereinige
;
; Revision 1.24  2003/11/09 16:23:14  thufhnik
; Weihe
;
; Revision 1.23  2003/11/09 15:44:06  thufhnik
; Verschmelze Fehlschlag ohne Auswirkung ergaenzt
;
; Revision 1.22  2003/10/29 23:17:57  thufhnik
; Finsternis Blitze duerfen jetzt auch umbrechen
;
; Revision 1.21  2003/10/15 10:31:36  thufhnik
; neue Meldung fuer Finsternis
;
; Revision 1.20  2003/10/08 14:33:54  thufhnik
; Beim Ideln dem Sonnentod vorbeugen
;
; Revision 1.19  2003/09/29 10:04:02  thufhnik
; Kleinigkeiten
; Verschmelze
;
; Revision 1.18  2003/09/22 07:27:45  thufhnik
; Beschwoere
; Kleinigkeiten hier und da
;
; Revision 1.17  2003/09/21 12:27:02  chbr
; Weitere Ende-Meldung fuer Schutzschild
;
; Revision 1.16  2003/09/12 13:46:42  chbr
; Weitere Abbruchmeldung fuer Vereinige
;
; Revision 1.15  2003/09/12 13:37:30  chbr
; Vereinige fuer Dunkelelfenkaempfer
;
; Revision 1.14  2003/09/05 15:26:46  thufhnik
; Statusmodul fuer Blitzhand
; Meldung fuer Blitzhand durch zu wenig KP aus
; neue Meldung bei Finsternis
;
; Revision 1.13  2003/09/02 06:01:53  thufhnik
; Abbruchmeldungen fuer Finsternis
;
; Revision 1.12  2003/09/01 16:08:09  thufhnik
; Blitzhand etc.
;
; Revision 1.11  2003/09/01 10:01:05  thufhnik
; Mehr Meldungen zur Aura
;
; Revision 1.10  2003/08/16 20:36:51  thufhnik
; Ergaenzung zum Blitz der Finsternis
;
; Revision 1.9  2003/08/15 08:39:04  thufhnik
; neue Meldung zu aura
;
; Revision 1.8  2003/08/14 08:25:43  thufhnik
; Meldung von Finsternis ebenfalls geaendert
;
; Revision 1.7  2003/08/14 07:41:41  thufhnik
; bei Schutz hat Padreic die Meldung wohl geaendert
;
; Revision 1.6  2003/08/11 22:00:23  thufhnik
; neu: /dunkelelfen_do_finsternis
;
; Revision 1.5  2003/08/10 18:40:38  thufhnik
; Bannkreis
; weitere Meldung der Aura
;
; Revision 1.4  2003/08/07 10:04:31  thufhnik
; diverse Erweiterungen
;
; Revision 1.3  2003/07/31 13:38:29  thufhnik
; Typo in Nachtsicht
;
; Revision 1.2  2003/07/30 09:37:00  thufhnik
; Schutz im Autokampf
;
; Revision 1.1  2003/07/29 16:57:40  thufhnik
; Scratch
;

/set status_dunkelelfen_tf_version $Id: status_dunkelelfen.tf,v 1.32 2004/12/22 14:36:31 thufhnik Exp $
/set status_dunkelelfen_tf_author=Thufhir@mg.mud.de
/set status_dunkelelfen_tf_requires=util.hooks.tf config.tf(1.16)
/set status_dunkelelfen_tf_desc=Statuszeile und Report fuer die Dunkelelfengilde

;;; Vorschlag fuer eine status_dunkelelfen.cfg
;
; /set config_status_line={dunkelelfen_schutz}{dunkelelfen_aura}\
;	{dunkelelfen_schutzschild}{dunkelelfen_blitzhand}\
;	{dunkelelfen_beschwoere}{dunkelelfen_verschmelze}\
;	{dunkelelfen_weihe}_L:{lp}_{dunkelelFEN_Busy}{mp}{p_block}\
;	{arzt}{hydra_present}_FL:{vorsicht}:{flucht}_W:{weapon}_{modes}_\
;	{dim_node}_{clock}

;;; Konfiguration

/set_var CFG_ECHO_GAG_LEVEL 2

;;; Texte und Farben fuer die Spells

; Fehler
/set_var CFG_MG_DUNKELELFEN_ERROR_ECHO_TEXT Zauberspruch missglueckt
/set_var CFG_MG_DUNKELELFEN_ERROR_ECHO_ATTR Cred

; Lernen
/set_var CFG_MG_DUNKELELFEN_LEARN_ECHO_TEXT Gelernt!
/set_var CFG_MG_DUNKELELFEN_LEARN_ECHO_ATTR Cbggreen

; Lernsperre
/set_var CFG_MG_DUNKELELFEN_NOLEARN_ECHO_TEXT Lernsperre!
/set_var CFG_MG_DUNKELELFEN_NOLEARN_ECHO_ATTR Cbgred 

; Erschoepfung
/set_var CFG_MG_DUNKELELFEN_ERSCHOEPFUNG_ECHO_TEXT Erschoepfung
/set_var CFG_MG_DUNKELELFEN_ERSCHOEPFUNG_ECHO_ATTR Cyellow

; Schaden durch Sonne
/set_var CFG_MG_DUNKELELFEN_SONNE_ECHO_TEXT Achtung: Sonne!!!
/set_var CFG_MG_DUNKELELFEN_SONNE_ECHO_ATTR Cbgred

; Nachtsicht
/set_var CFG_MG_DUNKELELFEN_NACHTSICHT_ECHO_TEXT Nachtsicht
/set_var CFG_MG_DUNKELELFEN_NACHTSICHT_ECHO_ATTR Cgreen
/set_var CFG_MG_DUNKELELFEN_NACHTSICHT_ALR_ECHO_TEXT Nachtsicht bereits aktiv
/set_var CFG_MG_DUNKELELFEN_NACHTSICHT_ALR_ECHO_ATTR Cyellow
/set_var CFG_MG_DUNKELELFEN_NACHTSICHT_ERROR_ECHO_TEXT Fehlschlag: Nachtsicht
/set_var CFG_MG_DUNKELELFEN_NACHTSICHT_ERROR_ECHO_ATTR Cred

; Schutz
/set_var CFG_MG_DUNKELELFEN_SCHUTZ_ECHO_TEXT Schutz
/set_var CFG_MG_DUNKELELFEN_SCHUTZ_ECHO_ATTR Cgreen
/set_var CFG_MG_DUNKELELFEN_SCHUTZ_OUT_ECHO_TEXT Schutz aus
/set_var CFG_MG_DUNKELELFEN_SCHUTZ_OUT_ECHO_ATTR Cyellow
/set_var CFG_MG_DUNKELELFEN_SCHUTZ_ALR_ECHO_TEXT Schutz bereits aktiv
/set_var CFG_MG_DUNKELELFEN_SCHUTZ_ALR_ECHO_ATTR Cyellow
/set_var CFG_STATUS_TEXT_DUNKELELFEN_SCHUTZ_1 S
/set_var CFG_STATUS_COLOR_DUNKELELFEN_SCHUTZ_1 Cgreen

; Finsternis
/set_var CFG_MG_DUNKELELFEN_FINSTERNIS_ECHO_TEXT Vorbereitung: Finsternis
/set_var CFG_MG_DUNKELELFEN_FINSTERNIS_ECHO_ATTR Cyellow
/set_var CFG_MG_DUNKELELFEN_FINSTERNIS_ABBR_ECHO_TEXT Finsternis Abbruch
/set_var CFG_MG_DUNKELELFEN_FINSTERNIS_ABBR_ECHO_ATTR Cred
/set_var CFG_MG_DUNKELELFEN_FINSTERNIS_1_ECHO_ATTR Cbgred
/set_var CFG_MG_DUNKELELFEN_FINSTERNIS_2_ECHO_ATTR Cgreen

; Aura
/set_var CFG_MG_DUNKELELFEN_AURA_ECHO_TEXT Aura
/set_var CFG_MG_DUNKELELFEN_AURA_ECHO_ATTR Cgreen
/set_var CFG_MG_DUNKELELFEN_AURA_UPDATE_ECHO_TEXT Aura Verbesserung
/set_var CFG_MG_DUNKELELFEN_AURA_UPDATE_ECHO_ATTR Cgreen
/set_var CFG_MG_DUNKELELFEN_AURA_ALR_ECHO_TEXT Aura bereits aktiv
/set_var CFG_MG_DUNKELELFEN_AURA_ALR_ECHO_ATTR Cyellow
/set_var CFG_MG_DUNKELELFEN_AURA_OUT_ECHO_TEXT Aura aus
/set_var CFG_MG_DUNKELELFEN_AURA_OUT_ECHO_ATTR Cyellow
/set_var CFG_STATUS_TEXT_DUNKELELFEN_AURA_1 A
/set_var CFG_STATUS_COLOR_DUNKELELFEN_AURA_1 Cmagenta
/set_var CFG_STATUS_TEXT_DUNKELELFEN_AURA_2 A
/set_var CFG_STATUS_COLOR_DUNKELELFEN_AURA_2 Cmagenta,h

; Schutzschild
/set_var CFG_MG_DUNKELELFEN_SCHUTZSCHILD_PREP_ECHO_TEXT Vorbereitung: Schutzschild
/set_var CFG_MG_DUNKELELFEN_SCHUTZSCHILD_PREP_ECHO_ATTR Cyellow
/set_var CFG_MG_DUNKELELFEN_SCHUTZSCHILD_ECHO_TEXT Schutzschild
/set_var CFG_MG_DUNKELELFEN_SCHUTZSCHILD_ECHO_ATTR Cgreen
/set_var CFG_MG_DUNKELELFEN_SCHUTZSCHILD_OUT_ECHO_TEXT Schutzschild aus
/set_var CFG_MG_DUNKELELFEN_SCHUTZSCHILD_OUT_ECHO_ATTR Cyellow
/set_var CFG_MG_DUNKELELFEN_SCHUTZSCHILD_ALR_ECHO_TEXT Schutzschild bereits aktiv
/set_var CFG_MG_DUNKELELFEN_SCHUTZSCHILD_ALR_ECHO_ATTR Cyellow
/set_var CFG_MG_DUNKELELFEN_SCHUTZSCHILD_NOFIGHT_ECHO_TEXT Schutzschild Abbruch
/set_var CFG_MG_DUNKELELFEN_SCHUTZSCHILD_NOFIGHT_ECHO_ATTR Cred
/set_var CFG_STATUS_TEXT_DUNKELELFEN_SCHUTZSCHILD_1 M
/set_var CFG_STATUS_COLOR_DUNKELELFEN_SCHUTZSCHILD_1 Cyellow

; Bannkreis
/set_var CFG_MG_DUNKELELFEN_BANNKREIS_NOTARGET_ECHO_TEXT Kein Ziel: Bannkreis
/set_var CFG_MG_DUNKELELFEN_BANNKREIS_NOTARGET_ECHO_ATTR Cyellow
/set_var CFG_MG_DUNKELELFEN_BANNKREIS_PREP_ECHO_TEXT Vorbereitung: Bannkreis
/set_var CFG_MG_DUNKELELFEN_BANNKREIS_PREP_ECHO_ATTR Cyellow
/set_var CFG_MG_DUNKELELFEN_BANNKREIS_ECHO_TEXT Bannkreis
/set_var CFG_MG_DUNKELELFEN_BANNKREIS_ECHO_ATTR Cgreen

; Blitzhand
/set_var CFG_MG_DUNKELELFEN_BLITZHAND_ECHO_TEXT Blitzhand
/set_var CFG_MG_DUNKELELFEN_BLITZHAND_ECHO_ATTR Cgreen
/set_var CFG_MG_DUNKELELFEN_BLITZHAND_OUT_ECHO_TEXT Blitzhand aus
/set_var CFG_MG_DUNKELELFEN_BLITZHAND_OUT_ECHO_ATTR Cyellow
/set_var CFG_MG_DUNKELELFEN_BLITZHAND_ALR_ECHO_TEXT Blitzhand bereits aktiv
/set_var CFG_MG_DUNKELELFEN_BLITZHAND_ALR_ECHO_ATTR Cyellow
/set_var CFG_STATUS_TEXT_DUNKELELFEN_BLITZHAND_1 B
/set_var CFG_STATUS_COLOR_DUNKELELFEN_BLITZHAND_1 Cyellow,h

; Beschwoere
/set_var CFG_MG_DUNKELELFEN_BESCHWOERE_ECHO_TEXT Beschwoere
/set_var CFG_MG_DUNKELELFEN_BESCHWOERE_ECHO_ATTR Cgreen
/set_var CFG_MG_DUNKELELFEN_BESCHWOERE_OUT_ECHO_TEXT Zombie verloren!
/set_var CFG_MG_DUNKELELFEN_BESCHWOERE_OUT_ECHO_ATTR Cbgmagenta
/set_var CFG_MG_DUNKELELFEN_BESCHWOERE_IN_ECHO_TEXT Ein Zombie kommt an.
/set_var CFG_MG_DUNKELELFEN_BESCHWOERE_IN_ECHO_ATTR g
/set_var CFG_MG_DUNKELELFEN_BESCHWOERE_2LIFE_ECHO_TEXT Der Zombie verliert ein Leben!
/set_var CFG_MG_DUNKELELFEN_BESCHWOERE_2LIFE_ECHO_ATTR Cmagenta
/set_var CFG_STATUS_TEXT_DUNKELELFEN_BESCHWOERE_1 Z
/set_var CFG_STATUS_COLOR_DUNKELELFEN_BESCHWOERE_1 Cbgred,Cwhite
/set_var CFG_STATUS_TEXT_DUNKELELFEN_BESCHWOERE_2 Z
/set_var CFG_STATUS_COLOR_DUNKELELFEN_BESCHWOERE_2 Cbgmagenta,Cwhite
/set_var CFG_STATUS_TEXT_DUNKELELFEN_BESCHWOERE_3 Z
/set_var CFG_STATUS_COLOR_DUNKELELFEN_BESCHWOERE_3 Cmagenta

; Vereinige
/set_var CFG_MG_DUNKELELFEN_VEREINIGE_PREP_ECHO_TEXT Vorbereitung: Vereinige
/set_var CFG_MG_DUNKELELFEN_VEREINIGE_PREP_ECHO_ATTR Cyellow
/set_var CFG_MG_DUNKELELFEN_VEREINIGE_ECHO_TEXT Vereinige
/set_var CFG_MG_DUNKELELFEN_VEREINIGE_ECHO_ATTR Cgreen
/set_var CFG_MG_DUNKELELFEN_VEREINIGE_OUT_ECHO_TEXT Vereinige aus
/set_var CFG_MG_DUNKELELFEN_VEREINIGE_OUT_ECHO_ATTR Cred
/set_var CFG_MG_DUNKELELFEN_VEREINIGE_ALR_ECHO_TEXT Vereinigung schon vorhanden
/set_var CFG_MG_DUNKELELFEN_VEREINIGE_ALR_ECHO_ATTR Cyellow
/set_var CFG_STATUS_TEXT_DUNKELELFEN_VEREINIGE_1 V
/set_var CFG_STATUS_COLOR_DUNKELELFEN_VEREINIGE_1 Cyellow,h

; Verschmelze
/set_var CFG_MG_DUNKELELFEN_VERSCHMELZE_ECHO_TEXT Verschmelze
/set_var CFG_MG_DUNKELELFEN_VERSCHMELZE_ECHO_ATTR Cgreen
/set_var CFG_MG_DUNKELELFEN_VERSCHMELZE_OUT_ECHO_TEXT Verschmelze aus
/set_var CFG_MG_DUNKELELFEN_VERSCHMELZE_OUT_ECHO_ATTR Cred
/set_var CFG_STATUS_TEXT_DUNKELELFEN_VERSCHMELZE_1 V
/set_var CFG_STATUS_COLOR_DUNKELELFEN_VERSCHMELZE_1 Cblue
/set_var CFG_STATUS_TEXT_DUNKELELFEN_VERSCHMELZE_2 V
/set_var CFG_STATUS_COLOR_DUNKELELFEN_VERSCHMELZE_2 Cbgblue,Cwhite

; Weihe
/set_var CFG_MG_DUNKELELFEN_WEIHE_ECHO_TEXT Weihe
/set_var CFG_MG_DUNKELELFEN_WEIHE_ECHO_ATTR Cgreen
/set_var CFG_MG_DUNKELELFEN_WEIHE_OUT_ECHO_TEXT Weihe aus
/set_var CFG_MG_DUNKELELFEN_WEIHE_OUT_ECHO_ATTR Cred
/set_var CFG_STATUS_COLOR_DUNKELELFEN_WEIHE_1 Cbgblack,Cwhite
/set_var CFG_STATUS_TEXT_DUNKELELFEN_WEIHE_1 W

;;; Variablen initialisieren

/init_var dunkelelfen_busy
/init_var dunkelelfen_schutz
/init_var dunkelelfen_aura
/init_var dunkelelfen_schutzschild
/init_var dunkelelfen_vereinige
/init_var dunkelelfen_verschmelze
/init_var dunkelelfen_weihe

;;; Statusmodule

/set sl_dunkelelfen_schutz_doc=Schutz $[status_doc_attr("DUNKELELFEN_SCHUTZ_1")]
/def sl_dunkelelfen_schutz = \
        /set_status_var_flag dunkelelfen_schutz dunkelelfen_schutz 1

/set sl_dunkelelfen_aura_doc=Aura $[status_doc_attr("DUNKELELFEN_AURA_1")]
/def sl_dunkelelfen_aura = \
        /set_status_var_count dunkelelfen_aura dunkelelfen_aura 1 2

/set sl_dunkelelfen_schutzschild_doc=Schutzschild $[status_doc_attr("DUNKELELFEN_SCHUTZSCHILD_1")]
/def sl_dunkelelfen_schutzschild = \
	/set_status_var_flag dunkelelfen_schutzschild dunkelelfen_schutzschild 1

/set sl_dunkelelfen_blitzhand_doc=Blitzhand $[status_doc_attr("DUNKELELFEN_BLITZHAND_1")]
/def sl_dunkelelfen_blitzhand = \
	/set_status_var_flag dunkelelfen_blitzhand dunkelelfen_blitzhand 1

/set sl_dunkelelfen_vereinige_doc=Vereinige $[status_doc_attr("DUNKELELFEN_VEREINIGE_1")]
/def sl_dunkelelfen_vereinige = \
	/set_status_var_flag dunkelelfen_vereinige dunkelelfen_vereinige 1

/set sl_dunkelelfen_weihe_doc=Weihe $[status_doc_attr("DUNKELELFEN_WEIHE_1")]
/def sl_dunkelelfen_weihe = \
	/set_status_var_flag dunkelelfen_weihe dunkelelfen_weihe 1

/set sl_dunkelelfen_verschmelze_doc=Verschmelze $[status_doc_attr("DUNKELELFEN_VERSCHMELZE_1")]
/def sl_dunkelelfen_verschmelze = \
	/set_status_var_count dunkelelfen_verschmelze dunkelelfen_verschmelze 1 2

/set sl_dunkelelfen_beschwoere_doc=Beschwoere $[status_doc_attr("DUNKELELFEN_BESCHWOERE_1")]
/def sl_dunkelelfen_beschwoere = \
	/set_status_var_count dunkelelfen_beschwoere dunkelelfen_beschwoere 1 3

/def sl_dunkelelfen_busy = \
	/set status_func_dunkelelfen_busy="K:"%;\
	/set status_attr_dunkelelfen_busy=dunkelelfen_busy?"Cbgred,Cwhite":\
		"n"%;\
	/return status_var("dunkelelfen_busy",2)

;;; Trigger

/def -p0 -q -w -agCblue -msimple -t'Die Sonne scheint gnadenlos auf Dein \
	Haupt und schwaecht Dich.' dunkelelfen_sonne = \
	/cfg_echo MG_DUNKELELFEN_SONNE %*%;\
	/if (!dunkelelfen_schutz & !autokampf & idle()>60 & p_mp>=10) \
		/send !\\schutz%;\
	/endif

; Fehler

/def -p0 -q -w -agCblue -msimple -t'Der Zauberspruch ist leider missglueckt.' \
	dunkelelfen_error = /cfg_echo MG_DUNKELELFEN_ERROR %*

; Lernen

/def -p0 -q -w -agCblue -msimple -t'Du lernst aus Deinem Fehler.' \
	dunkelelfen_learn = /cfg_echo MG_DUNKELELFEN_LEARN %*

; Lernsperre

/def -p0 -q -w -agCblue -msimple -t'Leider lernst Du nichts aus Deinem \
	Fehler.' dunkelelfen_nolearn = /cfg_echo MG_DUNKELELFEN_NOLEARN %*

; Erschoepfung

/def -p0 -q -w -agCblue -msimple -t'Du solltest erst einmal etwas zur Ruhe \
	kommen.' dunkelelfen_erschoepfung = \
	/cfg_echo MG_DUNKELELFEN_ERSCHOEPFUNG %*

; Nachtsicht

/def -p0 -q -w -agCblue -mglob -t'Du blinzelst einmal kurz mit den Augen und \
	gewoehnst Dich an die {Helligkeit.|Dunkelheit.}' \
	dunkelelfen_nachtsicht = \
	/dunkelelfen_unbusy%;\
	/cfg_echo MG_DUNKELELFEN_NACHTSICHT %*

/def -p0 -q -w -agCblue -mregexp -t'^Deine Augen haben sich bereits voellig \
	an d(ie Dunkelheit|as Licht) gewoehnt!$' dunkelelfen_nachtsicht_alr = \
	/dunkelelfen_unbusy%;\
	/cfg_echo MG_DUNKELELFEN_NACHTSICHT_ALR %*

/def -p0 -q -w -agCblue -mregexp -t'^Du blinzelst mit Deinen Augen, doch Du \
	(kannst immer noch nichts sehen|bist immer noch vom Licht geblendet)\
	\\.$' dunkelelfen_nachtsicht_error = \
	/dunkelelfen_unbusy%;\
	/cfg_echo MG_DUNKELELFEN_NACHTSICHT_ERROR %*

; Schutz

/def -p0 -q -w -agCblue -msimple -t'Du murmelst einige Worte vor Dich hin, und \
	auf einmal haeltst Du einen' dunkelelfen_schutz = \
	/cfg_echogag MG_DUNKELELFEN_SCHUTZ %*%;\
	/def -1 -p0 -q -w -agCblue -msimple -t'magischen Balsam in Haenden, \
		mit dem Du Dich auch sofort einreibst.' dunkelelfen_schutz_2 = \
		/dunkelelfen_unbusy%%;\
		/set dunkelelfen_schutz 1%%;\
		/cfg_echo MG_DUNKELELFEN_SCHUTZ %*

/def -p0 -q -w -agCblue -msimple -t'Dein Schutzfilm gegen die Sonne verblasst \
	langsam wieder.' dunkelelfen_schutz_aus = \
	/set dunkelelfen_schutz 0%;\
	/cfg_echo MG_DUNKELELFEN_SCHUTZ_OUT %*%;\
	/if /ismacro autokampf_update%; /then \
		/autokampf_update /dunkelelfen_do_schutz%;\
	/endif

/def -p0 -q -w -agCblue -msimple -t'Ein leichter Schutzfilm schuetzt Dich \
	doch bereits vor der Sonne.' dunkelelfen_schutz_alr = \
	/set dunkelelfen_schutz 1%;\
	/cfg_echo MG_DUNKELELFEN_SCHUTZ_ALR %*

/def dunkelelfen_do_schutz = \
	/if (!dunkelelfen_busy) \
		/if /ismacro weapon_action%; /then \
			/weapon_action 1 schutz%;\
		/else \
			/send !\\schutz%;\
		/endif%;\
	/endif

; Finsternis

/def -p0 -q -w -agCblue -msimple -t'Du reisst die Haende hoch und rufst die \
	Maechte der Finsternis um Hilfe an.' dunkelelfen_finsternis = \
	/dunkelelfen_spell_wait 3%;\
	/cfg_echo MG_DUNKELELFEN_FINSTERNIS %*%;\
	/def -1 -p1 -q -w -agCblue -mregexp -t'^Ploetzlich schiesst ein \
		(kleiner |grosser |riesiger |gewaltiger |gigantischer |)Blitz \
		auf Dich nieder\\\\.$$' dunkelelfen_finsternis_t1 = \
		/dunkelelfen_finsternis_done MG_DUNKELELFEN_FINSTERNIS_1 %%*%;\
	/def -1 -p0 -q -w -agCblue -mregexp -t'^Ploetzlich schiesst ein \
		(kleiner |grosser |riesiger |gewaltiger |gigantischer |)Blitz \
		auf [^.]+( nieder\\\\.)?$$' dunkelelfen_finsternis_t2 = \
		/if ({P2}!~' nieder.') \
			/def -1 -p0 -q -w -agCblue -mglob -t'*nieder.' \
				dunkelelfen_finsternis_t21 = \
				/dunkelelfen_finsternis_done \
					MG_DUNKELELFEN_FINSTERNIS_2 %%%*%%;\
			/cfg_echocolor MG_DUNKELELFEN_FINSTERNIS_2 %%*%%;\
		/else \
			/dunkelelfen_finsternis_done \
				MG_DUNKELELFEN_FINSTERNIS_2 %%*%%;\
		/endif%;\
	/def -1 -p0 -q -w -agCblue -msimple -t'Doch die Maechte der Finsternis \
		scheinen nicht zu reagieren.' dunkelelfen_finsternis_t3 = \
		/dunkelelfen_finsternis_done MG_DUNKELELFEN_ERROR %%*%;\
	/def -1 -p0 -q -w -agCblue -mglob -t'* kruemmt sich ploetzlich vor \
		Schmerzen.' dunkelelfen_finsternis_t4 = \
		/dunkelelfen_finsternis_done MG_DUNKELELFEN_FINSTERNIS_2 %%*%;\
	/def -1 -p0 -q -w -agCblue -mregexp -t'^Auf einmal geht es Dir wieder \
		(ein wenig|wesentlich) besser\\\\.$$' \
		dunkelelfen_finsternis_t5 = \
		/dunkelelfen_finsternis_done MG_DUNKELELFEN_FINSTERNIS_2 %%*%;\
	/def -1 -p0 -q -w -agCblue -msimple -t'Auf einmal kannst Du wie durch \
		ein Wunder wieder sehen.' dunkelelfen_finsternis_t6 = \
		/dunkelelfen_finsternis_done MG_DUNKELELFEN_FINSTERNIS_2 %%*%;\
	/def -1 -p0 -q -w -agCblue -msimple -t'Wie durch ein Wunder bist Du \
		auf einmal nicht mehr gelaehmt.' dunkelelfen_finsternis_t7 = \
		/dunkelelfen_finsternis_done MG_DUNKELELFEN_FINSTERNIS_2 %%*%;\
	/def -1 -p0 -q -w -agCblue -msimple -t'Du bist den Maechten der \
		Finsternis nicht mehr nahe genug, um auf ihre' \
		dunkelelfen_finsternis_t8 = \
		/cfg_echogag MG_DUNKELELFEN_FINSTERNIS_ABBR %%*%%;\
		/def -1 -p0 -q -w -agCblue -msimple -t'Unterstuetzung hoffen \
			zu koennen.' dunkelelfen_finsternis_t81 = \
			/cfg_echo MG_DUNKELELFEN_FINSTERNIS_ABBR %%%*%%%;\
			/dunkelelfen_finsternis_done2%;\
	/def -1 -p0 -q -w -agCblue -msimple -t'Deine Probleme scheinen nicht \
		gross genug, um die Maechte der Finsternis fuer' \
		dunkelelfen_finsternis_t9 = \
		/cfg_echogag MG_DUNKELELFEN_FINSTERNIS_ABBR %%*%%;\
		/def -1 -p0 -q -w -agCblue -msimple -t'Dich gewinnen zu \
			koennen.' dunkelelfen_finsternis_t91 = \
			/cfg_echo MG_DUNKELELFEN_FINSTERNIS_ABBR %%%*%%%;\
			/dunkelelfen_finsternis_done2

/def dunkelelfen_finsternis_done = \
	/cfg_echocolor %*%;\
	/dunkelelfen_finsternis_done2

/def dunkelelfen_finsternis_done2 = \
	/dunkelelfen_unbusy%;\
	/purge -mglob dunkelelfen_finsternis_t*%;\
	/if (!dunkelelfen_blitzhand) \
		/if /ismacro weapon_draw%; /then \
			/set weapon_quiet 1%;\
			/weapon_draw%;\
		/endif%;\
		/if /ismacro shield_wear%; /then \
			/set shield_quiet 1%;\
			/shield_wear%;\
		/endif%;\
	/endif

/def dunkelelfen_do_finsternis = \
	/if /ismacro weapon_unwear%; /then \
		/set weapon_quiet 1%;\
		/weapon_unwear%;\
	/endif%;\
	/if /ismacro shield_unwear%; /then \
		/set shield_quiet 1%;\
		/shield_unwear%;\
	/endif%;\
	/send !\\finsternis

; Aura

/def -p0 -q -w -agCblue -msimple -t'Du faltest Deine Haende zusammen und \
	murmelst die magischen Worte...' dunkelelfen_aura = \
	/dunkelelfen_unbusy%;\
	/cfg_echogag MG_DUNKELELFEN_AURA %*%;\
	/def -1 -p0 -q -w -agCblue -mregexp -t'Um Dich herum entsteht eine \
		(schwache |(sehr )?starke |)magische Aura\\\\.$$' \
		dunkelelfen_aura_t1 = \
		/cfg_echo MG_DUNKELELFEN_AURA %%*%%;\
		/if ({P1}=/"*starke*") \
			/set dunkelelfen_aura 2%%;\
		/else \
			/set dunkelelfen_aura 1%%;\
		/endif%%;\
		/purge -mglob dunkelelfen_aura_t*%;\
	/def -1 -p0 -q -w -agCblue -msimple -t'Die Dich umgebene magische \
		Aura stabilisiert sich wieder.' dunkelelfen_aura_t2 = \
		/cfg_echo MG_DUNKELELFEN_AURA %%*%%;\
		/set dunkelelfen_aura 1%%;\
		/purge -mglob dunkelelfen_aura_t*%;\
	/def -1 -p0 -q -w -agCblue -msimple -t'Die Aura um Dich waechst und \
		wird groesser.' dunkelelfen_aura_t3 = \
		/cfg_echo MG_DUNKELELFEN_AURA_UPDATE %%*%%;\
		/set dunkelelfen_aura 2%%;\
		/purge -mglob dunkelelfen_aura_t*%;\
	/def -1 -p0 -q -w -agCblue -msimple -t'Die Aura um Dich waechst \
		gewaltig.' dunkelelfen_aura_t4 = \
		/cfg_echo MG_DUNKELELFEN_AURA_UPDATE %%*%%;\
		/set dunkelelfen_aura 2%%;\
		/purge -mglob dunkelelfen_aura_t*%;\
	/def -1 -p0 -q -w -agCblue -mglob -t'Irgendetwas scheinst * falsch \
		gemacht *' dunkelelfen_aura_t5 = \
		/if ({L1}!/'*.') \
			/def -1 -p0 -q -w -agCblue -mglob -t'*.' \
				dunkelelfen_aura_t51 = \
				/cfg_echocolor MG_DUNKELELFEN_ERROR %%%*%%;\
		/endif%%;\
		/cfg_echocolor MG_DUNKELELFEN_ERROR %%*%%;\
		/purge -mglob dunkelelfen_aura_t*

/def -p0 -q -w -agCblue -msimple -t'Du kannst die Magieaura um Dich nicht \
	weiter verbessern.' dunkelelfen_aura_alr = \
	/cfg_echo MG_DUNKELELFEN_AURA_ALR %*%;\
	/if (!dunkelelfen_aura) \
		/set dunkelelfen_aura 1%;\
	/endif

/def -p0 -q -w -agCblue -msimple -t'Die Magieaura die Dich umgibt loest sich \
	allmaehlich auf.' dunkelelfen_aura_aus = \
	/cfg_echo MG_DUNKELELFEN_AURA_OUT %*%;\
	/set dunkelelfen_aura 0%;\
	/if /ismacro autokampf_update%; /then \
		/autokampf_update /dunkelelfen_do_aura%;\
	/endif

/def dunkelelfen_do_aura = \
	/if (!dunkelelfen_busy) \
		/if /ismacro weapon_action%; /then \
			/weapon_action 2 aura%;\
		/else \
			/send !\\aura%;\
		/endif%;\
	/endif

; Schutzschild

/def -p0 -q -w -agCblue -msimple -t'Du konzentrierst Dich auf den Aufbau \
	eines Schutzschilds.' dunkelelfen_schutzschild_prep = \
	/dunkelelfen_spell_wait 7%;\
	/cfg_echo MG_DUNKELELFEN_SCHUTZSCHILD_PREP %*

/def -p0 -q -w -agCblue -msimple -t'Du machst eine Pirouette, schnippst \
	danach mit dem Finger, und auf einmal' dunkelelfen_schutzschild = \
	/cfg_echogag MG_DUNKELELFEN_SCHUTZSCHILD %*%;\
	/def -1 -p0 -q -w -agCblue -msimple -t'entsteht ein magisches \
		Schutzschild um Dich herum.' dunkelelfen_schutzschild_2 = \
		/dunkelelfen_unbusy%%;\
		/set dunkelelfen_schutzschild 1%%;\
                /cfg_echo MG_DUNKELELFEN_SCHUTZSCHILD %*

/def -p0 -q -w -agCblue -msimple -t'Das Schutzschild um Dich herum loest \
	sich langsam auf.' dunkelelfen_schutzschild_out = \
	/set dunkelelfen_schutzschild 0%;\
	/cfg_echo MG_DUNKELELFEN_SCHUTZSCHILD_OUT %*

/def -p0 -q -w -agCblue -msimple -t'Dein Schutzschild ist nun aufgebraucht.' \
	dunkelelfen_schutzschild_out_2 = \
	/set dunkelelfen_schutzschild 0%;\
	/cfg_echo MG_DUNKELELFEN_SCHUTZSCHILD_OUT %*

/def -p0 -q -w -agCblue -msimple -t'Bei Deiner ganzen Hektik zerplatzt Dir \
	auf einmal Dein Schutzschild.' dunkelelfen_schutzschild_out_3 = \
	/set dunkelelfen_schutzschild 0%;\
	/cfg_echo MG_DUNKELELFEN_SCHUTZSCHILD_OUT %*

/def -p0 -q -w -agCblue -msimple -t'Du befindest Dich doch gerade gar nicht \
	im Kampf, so macht das nicht viel Sinn.' dunkelelfen_schutzschild_nof=\
	/dunkelelfen_unbusy%;\
	/cfg_echo MG_DUNKELELFEN_SCHUTZSCHILD_NOFIGHT %*

/def -p0 -q -w -agCblue -msimple -t'Leider zerplatzt Dir daraufhin Dein \
	Schutzschild.' dunkelelfen_schutzschild_out_4 = \
	/set dunkelelfen_schutzschild 0%;\
	/cfg_echo MG_DUNKELELFEN_SCHUTZSCHILD_OUT %*

/def -p0 -q -w -agCblue -msimple -t'Als Du Dich anderen Dingen zuwendest, \
	bricht der magische Schild um Dich zusammen.' \
	dunkelelfen_schutzschild_out_5 = \
	/dunkelelfen_unbusy%;\
	/cfg_echo MG_DUNKELELFEN_SCHUTZSCHILD_NOFIGHT %*

; Bannkreis

/def -p0 -q -w -agCblue -msimple -t'Du beginnst Dich mental auf den Aufbau \
	eines Bannkreises vorzubereiten.' dunkelelfen_bannkreis_prep = \
	/set dunkelelfen_busy=1%;\
	/cfg_echo MG_DUNKELELFEN_BANNKREIS_PREP %*

/def -p0 -q -w -agCblue -mglob -t'Du erschaffst einen magischen Bannkreis um \
	Dich und *' dunkelelfen_bannkreis = \
	/cfg_echo MG_DUNKELELFEN_BANNKREIS %*%;\
	/dunkelelfen_unbusy

/def -p0 -q -w -agCblue -mglob -t'Wen willst Du denn {versuchen|versuchen,} \
	in den Bannkreis zu ziehen?' dunkelelfen_bannkreis_notarget = \
	/set dunkelelfen_busy=0%;\
	/cfg_echo MG_DUNKELELFEN_BANNKREIS_NOTARGET

; Blitzhand

/def -p0 -q -w -agCblue -msimple -t'Du konzentrierst Dich einen Moment und \
	laesst Deine magische Energie in' dunkelelfen_blitzhand = \
	/cfg_echogag MG_DUNKELELFEN_BLITZHAND %*%;\
	/def -1 -p0 -q -w -agCblue -msimple -t'Deine Fingerkuppen fliessen. \
		Du spuerst bereits ein leichtes Knistern.' \
		dunkelelfen_blitzhand2 = \
		/dunkelelfen_unbusy%%;\
		/cfg_echo MG_DUNKELELFEN_BLITZHAND %%*%;\
		/set dunkelelfen_blitzhand 1

/def -p0 -q -w -agCblue -msimple -t'Das Kribbeln in Deinen Fingern laesst \
	allmaehlich nach.' dunkelelfen_blitzhand_out = \
	/dunkelelfen_blitzhand_recover

/def -p0 -q -w -agCblue -msimple -t'Deine magischen Kraefte verlassen Dich, \
	Deine Haende entspannen sich wieder.' dunkelelfen_blitzhand_outkp = \
	/dunkelelfen_blitzhand_recover

/def dunkelelfen_blitzhand_recover = \
	/if (dunkelelfen_blitzhand_handschuhe!~'') \
		/send !\\trage %dunkelelfen_blitzhand_handschuhe%;\
		/unset dunkelelfen_blitzhand_handschuhe%;\
	/endif%;\
	/cfg_echo MG_DUNKELELFEN_BLITZHAND_OUT %*%;\
	/set dunkelelfen_blitzhand 0

/def -p0 -q -w -agCblue -msimple -t'In Deinen Haenden befindet sich immer \
	noch eine Menge Energie, Du solltest' dunkelelfen_blitzhand_alr = \
	/cfg_echogag MG_DUNKELELFEN_BLITZHAND_ALR %*%;\
	/def -1 -p0 -q -w -agCblue -msimple -t'es nicht uebertreiben.' \
		dunkelelfen_blitzhand_alr_g1 = \
		/cfg_echo MG_DUNKELELFEN_BLITZHAND_ALR %%*%%;\
		/set dunkelelfen_blitzhand 1

/def dunkelelfen_do_blitzhand = \
	/if (!dunkelelfen_busy) \
		/if /ismacro weapon_unwear%; /then \
			/set weapon_quiet 1%;\
			/weapon_unwear%;\
		/endif%;\
		/if /ismacro shield_unwear%; /then \
			/set shield_quiet 1%;\
			/shield_unwear%;\
		/endif%;\
		/if (inv_handschuhe!~'') \
			/set dunkelelfen_blitzhand_handschuhe %inv_handschuhe%;\
			/send !\\ziehe %inv_handschuhe aus%;\
		/endif%;\
		/send !\\blitzhand %*%;\
	/endif

; Beschwoere

/def -p0 -q -w -agCblue -msimple -t'Du machst zahlreiche Gesten ueber der \
	Leiche und erweckst sie zu neuem Leben.' dunkelelfen_beschwoere = \
	/dunkelelfen_spell_wait 60%;\
	/if (dunkelelfen_beschwoere) \
		/set dunkelelfen_beschwoere_2nd %dunkelelfen_beschwoere%;\
		/set dunkelelfen_beschwoere 3%;\
	/else \
		/set dunkelelfen_beschwoere 3%;\
	/endif%;\
	/cfg_echo MG_DUNKELELFEN_BESCHWOERE %*

/def -p0 -q -w -agCblue -msimple -t'Du machst zahlreiche Gesten ueber der \
	Leiche, aber alle Versuche sie zum' dunkelelfen_beschwoere_err = \
	/cfg_echogag MG_DUNKELELFEN_ERROR %*%;\
	/def -1 -p0 -q -w -agCblue -msimple -t'Leben zu erwecken scheitern \
		klaeglich.' dunkelelfen_beschwoere_err1 = \
		/dunkelelfen_spell_wait 60%%;\
		/cfg_echo MG_DUNKELELFEN_ERROR %%*

/def -E(dunkelelfen_beschwoere) -p0 -q -w -agCblue -msimple -t'Der Zombie \
	faellt zu Boden, steht aber wieder auf.' \
	dunkelelfen_beschwoere_second_life = \
	/if (dunkelelfen_beschwoere_2nd > 1) \
		/test --dunkelelfen_beschwoere_2nd%;\
	/else \
		/test --dunkelelfen_beschwoere%;\
	/endif%;\
	/cfg_echo MG_DUNKELELFEN_BESCHWOERE_2LIFE %*

/def -E(dunkelelfen_beschwoere) -p0 -q -w -agCblue -msimple -t'Der Zombie \
	zerfaellt zu Staub.' dunkelelfen_beschwoere_out = \
	/if (dunkelelfen_beschwoere_2nd) \
		/set dunkelelfen_beschwoere_2nd 0%;\
	/else \
		/set dunkelelfen_beschwoere 0%;\
	/endif%;\
	/cfg_echo MG_DUNKELELFEN_BESCHWOERE_OUT %*

/def -E(dunkelelfen_beschwoere) -p0 -q -w -agCblue -msimple -t'Ein Zombie \
	kommt an.' dunkelelfen_beschwoere_in = \
	/cfg_echo MG_DUNKELELFEN_BESCHWOERE_IN %*

; Verschmelze

/def -p0 -q -w -agCblue -msimple -t'Du legst der Leiche drei Finger an die \
	Schlaefe und vereinigst Deinen Geist' dunkelelfen_verschmelze = \
	/cfg_echogag MG_DUNKELELFEN_VERSCHMELZE %*%;\
	/def -1 -p0 -q -w -agCblue -msimple -t'mit ihrem.' \
		dunkelelfen_verschmelze1 = \
		/dunkelelfen_spell_wait 60%%;\
		/set dunkelelfen_verschmelze 1%%;\
		/cfg_echo MG_DUNKELELFEN_VERSCHMELZE %%*%;\
	/def -1 -w -q -Fp9999999 -hPROMPT dunkelelfen_verschmelze_prompt = \
		/purge dunkelelfen_verschmelze_error*%;\
	/def -1 -p0 -q -w -agCblue -msimple -t'Irgendwie scheint bei der \
		Vereinigung etwas schief gelaufen zu sein.' \
		dunkelelfen_verschmelze_error1 = \
		/set dunkelelfen_verschmelze 2%%;\
		/cfg_echo MG_DUNKELELFEN_ERROR %%*%;\
	/def -1 -p0 -q -w -agCblue -msimple -t'Doch irgendwie bekommst Du \
		keinen Kontakt zu ihrem Geist.' \
		dunkelelfen_verschmelze_error2 = \
		/set dunkelelfen_verschmelze 0%%;\
		/cfg_echo MG_DUNKELELFEN_ERROR %%*

/def -p0 -q -w -agCblue -msimple -t'Du reinigst Deinen Geist von der \
	Gedankenverschmelzung vollkommen und fuehlst' \
	dunkelelfen_verschmelze_out = \
	/cfg_echogag MG_DUNKELELFEN_VERSCHMELZE_OUT %*%;\
	/def -1 -p0 -q -w -agCblue -msimple -t'Dich nun auch gleich wieder \
		wesentlich wohler in Deiner Haut.' \
		dunkelelfen_verschmelze_out1 = \
		/set dunkelelfen_verschmelze 0%%;\
		/cfg_echo MG_DUNKELELFEN_VERSCHMELZE_OUT %%*

; Vereinige

/def -p0 -q -w -agCblue -msimple -t'Du faengst an, schwerer zu atmen und \
	ein starkes magisches Band mit Deinem' dunkelelfen_vereinige_prep = \
	/cfg_echogag MG_DUNKELELFEN_VEREINIGE_PREP %*%;\
	/def -1 -p0 -q -w -agCblue -msimple -t'Runenschwert aufzubauen.' \
		dunkelelfen_vereinige_prep1 = \
		/set dunkelelfen_busy=1%;\
		/cfg_echo MG_DUNKELELFEN_VEREINIGE_PREP %%*

/def -p0 -q -w -agCblue -msimple -t'Du hast nun ein magisches Band zu Deinem \
	Runenschwert aufgebaut.' dunkelelfen_vereinige = \
	/set dunkelelfen_busy=0%;\
	/set dunkelelfen_vereinige 1%;\
	/cfg_echo MG_DUNKELELFEN_VEREINIGE %*

/def -p0 -q -w -agCblue -msimple -t'Du loest das magische Band zwischen Dir \
	und Deinem Runenschwert.' dunkelelfen_vereinige_out = \
	/set dunkelelfen_vereinige 0%;\
	/cfg_echo MG_DUNKELELFEN_VEREINIGE_OUT %*

/def -p0 -q -w -agCblue -msimple -t'Das magische Band zwischen Dir und Deinem \
	Runenschwert loest sich langsam.' dunkelelfen_vereinige_out_2 = \
	/set dunkelelfen_vereinige 0%;\
	/cfg_echo MG_DUNKELELFEN_VEREINIGE_OUT %*

/def -p0 -q -w -agCblue -msimple -t'Du loest das magische Band mit Deinem \
	Runenschwert.' dunkelelfen_vereinige_out_3 = \
	/set dunkelelfen_vereinige 0%;\
	/cfg_echo MG_DUNKELELFEN_VEREINIGE_OUT %*

/def -p0 -q -w -agCblue -msimple -t'Du bist doch schon eins mit Deinem \
	Runenschwert geworden.' dunkelelfen_vereinige_alr = \
	/set dunkelelfen_vereinige 1%;\
	/cfg_echo MG_DUNKELELFEN_VEREINIGE_ALR %*

; Weihe

/def -p0 -q -w -agCblue -msimple -t'Du faellst auf die Kniee und empfaengst \
	von Seyt-Hamakha die heiligen Weihen' dunkelelfen_weihe = \
	/cfg_echogag MG_DUNKELELFEN_WEIHE %*%;\
	/def -1 -p0 -q -w -agCblue -msimple -t'die Dir im taeglichen Kampf \
		gegen das Gute helfen sollen.' dunkelelfen_weihe1 = \
		/set dunkelelfen_weihe 1%%;\
		/set dunkelelfen_busy 0%%;\
		/cfg_echo MG_DUNKELELFEN_WEIHE %%*

/def -p0 -q -w -agCblue -msimple -t'Deine Weihe klingt langsam ab...' \
	dunkelelfen_weihe_out = \
	/set dunkelelfen_weihe 0%;\
	/cfg_echo MG_DUNKELELFEN_WEIHE_OUT %*

; Zaubersperre

/def dunkelelfen_spell_wait = \
	/repeat_once %1 /dunkelelfen_unbusy%;\
	/set dunkelelfen_busy %?%;\
	/if ({dunkelelfen_busy} <= 1) \
		/set dunkelelfen_busy=1%;\
	/endif

/def dunkelelfen_unbusy = \
	/if (dunkelelfen_busy > 1) \
		/kill %dunkelelfen_busy%;\
	/endif%;\
	/set dunkelelfen_busy=0

;;; Sachen beim Laden starten

/config_status

/if /ismacro add_to_hook%; /then \
	/add_to_hook tod /set dunkelelfen_schutz 0%;\
	/add_to_hook tod /set dunkelelfen_verschmelze 0%;\
	/add_to_hook tod /set dunkelelfen_beschwoere 0%;\
/endif
