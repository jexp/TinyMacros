; $Log: status_werwoelfe.tf,v $
; Revision 1.6  2002/09/10 13:26:47  thufhnik
; Benutzung von repeat_once aus util.repeat.tf
;
; Revision 1.5  2002/07/16 15:57:42  thufhnik
; *seufz* sollte man richtig machen...
;
; Revision 1.4  2002/07/16 15:54:05  thufhnik
; bugfix in rage-abklingen
;
; Revision 1.3  2002/07/16 09:10:08  thufhnik
; Horpas mit korrektemm Zeilenumbruch
;
; Revision 1.2  2002/07/15 15:31:06  thufhnik
; und gleich die ersten bugs... ;(
;
; Revision 1.1  2002/07/15 15:25:45  thufhnik
; Scratch
;

/set status_werwoelfe_tf_version=$Id$
/set status_werwoelfe_tf_author=Asuka@mg.mud.de,Thufhir@mg.mud.de
/set status_werwoelfe_tf_requires=config.tf status.tf
/set status_werwoelfe_tf_desc=Statuszeile fuer die Werwolfgilde


;;; Konfiguration

/set_var CFG_ECHO_GAG_LEVEL 2

; Wolfsformen

/set_var CFG_STATUS_COLOR_WERWOELFE_FORM_1 Cgreen
/set_var CFG_STATUS_TEXT_WERWOELFE_FORM_1 W
/set_var CFG_STATUS_COLOR_WERWOELFE_FORM_2 Cyellow
/set_var CFG_STATUS_TEXT_WERWOELFE_FORM_2 G
/set_var CFG_STATUS_COLOR_WERWOELFE_FORM_3 Cmagenta
/set_var CFG_STATUS_TEXT_WERWOELFE_FORM_3 H
/set_var CFG_STATUS_COLOR_WERWOELFE_FORM_4 Cred
/set_var CFG_STATUS_TEXT_WERWOELFE_FORM_4 g

/set_var CFG_MG_WERWOELFE_FORM_ECHO_ATTR Cgreen
/set_var CFG_MG_WERWOELFE_FORM_1_ECHO_ATTR Cgreen
/set_var CFG_MG_WERWOELFE_FORM_1_ECHO_TEXT Wolfsform: @{%CFG_STATUS_COLOR_WERWOELFE_FORM_1}Wolf@{n}
/set_var CFG_MG_WERWOELFE_FORM_2_ECHO_ATTR Cgreen
/set_var CFG_MG_WERWOELFE_FORM_2_ECHO_TEXT Wolfsform: @{%CFG_STATUS_COLOR_WERWOELFE_FORM_2}Ghourdal@{n}
/set_var CFG_MG_WERWOELFE_FORM_3_ECHO_ATTR Cgreen
/set_var CFG_MG_WERWOELFE_FORM_3_ECHO_TEXT Wolfsform: @{%CFG_STATUS_COLOR_WERWOELFE_FORM_3}Horpas@{n}
/set_var CFG_MG_WERWOELFE_FORM_4_ECHO_ATTR Cgreen
/set_var CFG_MG_WERWOELFE_FORM_4_ECHO_TEXT Wolfsform: @{%CFG_STATUS_COLOR_WERWOELFE_FORM_4}Galbrag@{n}
/set_var CFG_MG_WERWOELFE_FORM_AUS_ECHO_ATTR Cred
/set_var CFG_MG_WERWOELFE_FORM_AUS_ECHO_TEXT Verwandlung beendet
/set_var CFG_MG_WERWOELFE_FORM_SPERRE_ECHO_ATTR Cyellow
/set_var CFG_MG_WERWOELFE_FORM_SPERRE_ECHO_TEXT Noch kein Formwechsel moeglich
/set_var CFG_MG_WERWOELFE_FORM_ALR_ECHO_ATTR Cyellow
/set_var CFG_MG_WERWOELFE_FORM_ALR_ECHO_TEXT Wolfsform bereits vorhanden

; Leuchten

/set_var CFG_STATUS_TEXT_WERWOELFE_LEUCHTEN_1 L
/set_var CFG_STATUS_COLOR_WERWOELFE_LEUCHTEN_1 Cyellow
/set_var CFG_MG_WERWOELFE_LEUCHTEN_AN_ECHO_ATTR Cgreen
/set_var CFG_MG_WERWOELFE_LEUCHTEN_AN_ECHO_TEXT Leuchten
/set_var CFG_MG_WERWOELFE_LEUCHTEN_AUS_ECHO_ATTR Cred
/set_var CFG_MG_WERWOELFE_LEUCHTEN_AUS_ECHO_TEXT Leuchten aus
/set_var CFG_MG_WERWOELFE_LEUCHTEN_ALR_ECHO_ATTR Cyellow
/set_var CFG_MG_WERWOELFE_LEUCHTEN_ALR_ECHO_TEXT Leuchten schon an

; Rage

/set_var CFG_STATUS_TIME_WERWOELFE_RAGE 60
/set_var CFG_STATUS_TEXT_WERWOELFE_RAGE_1 R
/set_var CFG_STATUS_COLOR_WERWOELFE_RAGE_1 Cmagenta
/set_var CFG_MG_WERWOELFE_RAGE_AN_ECHO_ATTR Cgreen
/set_var CFG_MG_WERWOELFE_RAGE_AN_ECHO_TEXT Rage
/set_var CFG_MG_WERWOELFE_RAGE_ALR_ECHO_ATTR Cyellow
/set_var CFG_MG_WERWOELFE_RAGE_ALR_ECHO_TEXT Rage schon an
/set_var CFG_MG_WERWOELFE_RAGE_AUS_ECHO_ATTR Cred
/set_var CFG_MG_WERWOELFE_RAGE_AUS_ECHO_TEXT Rage aus

; Fellwuchs

/set_var CFG_STATUS_TEXT_WERWOELFE_FELLWUCHS_1 F
/set_var CFG_STATUS_COLOR_WERWOELFE_FELLWUCHS_1 Cyellow
/set_var CFG_MG_WERWOELFE_FELLWUCHS_AN_ECHO_ATTR Cgreen
/set_var CFG_MG_WERWOELFE_FELLWUCHS_AN_ECHO_TEXT Fellwuchs
/set_var CFG_MG_WERWOELFE_FELLWUCHS_AUS_ECHO_ATTR Cred
/set_var CFG_MG_WERWOELFE_FELLWUCHS_AUS_ECHO_TEXT Fellwuchs aus
/set_var CFG_MG_WERWOELFE_FELLWUCHS_ALR_ECHO_ATTR Cyellow
/set_var CFG_MG_WERWOELFE_FELLWUCHS_ALR_ECHO_TEXT Fellwuchs schon an

; Werwolfrufe

/set_var CFG_MG_WERWOELFE_WERRUF_ECHO_ATTR Cyellow


;;; Variablen initialisieren

/set werwoelfe_form 0
/set werwoelfe_leuchten 0
/set werwoelfe_rage 0
/set werwoelfe_fellwuchs 0


;;; Statuszeilenmodule

/set sl_werwoelfe_form_doc=Wolfsform Wolf: $[status_doc_attr("WERWOELFE_FORM_1")] Ghourdal: $[status_doc_attr("WERWOELFE_FORM_2")] Horpas: $[status_doc_attr("WERWOELFE_FORM_3")] Galbrag: $[status_doc_attr("WERWOELFE_FORM_4")]
/def sl_werwoelfe_form = \
	/set_status_var_count werwoelfe_form werwoelfe_form 1 4

/set sl_werwoelfe_leuchten_doc=Leuchten ($[status_doc_attr("WERWOELFE_LEUCHTEN_1")])
/def sl_werwoelfe_leuchten = \
	/set_status_var_flag werwoelfe_leuchten werwoelfe_leuchten 1

/set sl_werwoelfe_rage_doc=Rage ($[status_doc_attr("WERWOELFE_RAGE_1")])
/def sl_werwoelfe_rage = \
	/set_status_var_flag werwoelfe_rage werwoelfe_rage 1

/set sl_werwoelfe_fellwuchs_doc=Leuchten ($[status_doc_attr("WERWOELFE_FELLWUCHS_1")])
/def sl_werwoelfe_fellwuchs = \
	/set_status_var_flag werwoelfe_fellwuchs werwoelfe_fellwuchs 1

;;; Trigger

; Wolfsformen

/def -Fp20 -agCblue -msimple -t'Du laesst Dich auf alle 4 Beine nieder und \
	stoesst ein Heulen aus.' werwoelfe_trans_1 = \
	/cfg_echogag MG_WERWOELFE_FORM %*%;\
	/werwoelfe_transform_def

/def -Fp20 -agCblue -msimple -t'Gross und maechtig willst Du werden. Du \
	reckst Dich zum Himmel.' werwoelfe_trans_2 = \
	/cfg_echogag MG_WERWOELFE_FORM %*%;\
	/werwoelfe_transform_def

/def -Fp20 -agCblue -msimple -t'Du bueckst Dich ein wenig und heulst leise.' \
	werwoelfe_trans_3 = \
	/cfg_echogag MG_WERWOELFE_FORM %*%;\
	/werwoelfe_transform_def

/def -Fp20 -agCblue -msimple -t'Du laesst Dich auf alle 4 Beine nieder und \
	stoesst ein Heulen aus. Dabei' werwoelfe_trans_4 = \
	/cfg_echogag MG_WERWOELFE_FORM %*%;\
	/purge werwoelfe_trans_4a%;\
	/def -1 -Fp20 -agCblue -msimple -t'drueckst Du den Ruecken durch.' \
		werwoelfe_trans_4a = \
		/cfg_echogag MG_WERWOELFE_FORM %%*%;\
	/werwoelfe_transform_def

/def werwoelfe_transform_def = \
	/purge werwoelfe_transform%;\
	/def -1 -Fp20 -mregexp -agCblue -t'^Du bist jetzt ein (Wolf|Halbwolf|\
		Menschwolf|Wolfmensch)\\\\.$$' werwoelfe_transform = \
		/if ({P1} =~ "Wolf") \
			/set werwoelfe_form 1%%;\
		/elseif ({P1} =~ "Halbwolf") \
			/set werwoelfe_form 2%%;\
		/elseif ({P1} =~ "Wolfmensch") \
			/set werwoelfe_form 3%%;\
		/elseif ({P1} =~ "Menschwolf") \
			/set werwoelfe_form 4%%;\
		/endif%%;\
		/cfg_echo $$[strcat("MG_WERWOELFE_FORM_",werwoelfe_form)] %%*

/def -Fp20 -msimple -agCblue -t'Du bemerkst, wie Du Dich wieder in Deine \
	urspruengliche Form verwandelst.' werwoelfe_transform_out = \
	/set werwoelfe_form 0%;\
	/cfg_echo MG_WERWOELFE_FORM_AUS %*

/def -Fp20 -agCblue -msimple -t'Du kannst noch nicht wieder die Form wechseln, \
	der letzte Versuch ist noch nicht lang genug her.' \
	werwoelfe_transform_sperre = \
	/cfg_echo MG_WERWOELFE_FORM_SPERRE %*

/def -Fp20 -agCblue -msimple -t'Du bist schon in einer anderen Form.' \
	werwoelfe_alr = \
	/cfg_echo MG_WERWOELFE_FORM_ALR %*

; Leuchten

/def -Fp20 -agCblue -msimple -t'Du beginnst zu leuchten.' werwoelfe_leuchten = \
	/cfg_echo MG_WERWOELFE_LEUCHTEN_AN %*%;\
	/set werwoelfe_leuchten 1

/def -Fp20 -agCblue -msimple -t'Du leuchtest doch bereits.' \
	werwoelfe_leuchten_alr = \
	/cfg_echo MG_WERWOELFE_LEUCHTEN_ALR %*%;\
	/set werwoelfe_leuchten 1

/def -Fp20 -agCblue -msimple -t'Das Leuchten um Dich herum verblasst.' \
	werwoelfe_leuchten_aus = \
	/cfg_echo MG_WERWOELFE_LEUCHTEN_AUS %*%;\
	/set werwoelfe_leuchten 0

; Rage

/def -Fp20 -agCblue -msimple -t'Du projizierst Deine Innere Wut auf \
	Deinen Gegner.' werwoelfe_rage = \
	/cfg_echogag MG_WERWOELFE_RAGE_AN %*%;\
	/purge werwoelfe_rage_2%;\
	/def -1 -Fp20 -agCblue -msimple -t'Du verfaellst in Rage.' \
		werwoelfe_rage_2 = \
		/cfg_echo MG_WERWOELFE_RAGE_AN %%*%%;\
		/if (werwoelfe_rage_timer) \
			/kill %%werwoelfe_rage_timer%%;\
			/set werwoelfe_rage_timer 0%%;\
		/endif%%;\
		/werwoelfe_rage_timer%%;\
		/set werwoelfe_rage 1

/def -Fp20 -agCblue -msimple -t'Du bist noch in Rage.' werwoelfe_rage_alr = \
	/cfg_echo MG_WERWOELFE_RAGE_ALR %*%;\
	/werwoelfe_rage_timer%;\
	/set werwoelfe_rage 1

/def werwoelfe_rage_aus = \
	/set werwoelfe_rage 0%;\
	/set werwoelfe_rage_timer 0

/def werwoelfe_rage_timer = \
	/repeat_once %CFG_STATUS_TIME_WERWOELFE_RAGE /werwoelfe_rage_aus%;\
	/if ({?}) /set werwoelfe_rage_timer=%?%;/endif

; Fellwuchs

/def -Fp20 -agCblue -msimple -t'Du konzentrierst Dich auf Dein Fell.' \
 werwoelfe_fellwuchs = \
 /def -1 -ag -t'Dein Fell waechst.' werwoelfe_fellwuchs2 = \
 	/cfg_echo MG_WERWOELFE_FELLWUCHS_AN %*%%;\
	/set werwoelfe_fellwuchs 1

/def -Fp20 -agCblue -msimple -t'Du hast doch schon ein Fell!' \
	werwoelfe_fellwuchs_alr = \
	/cfg_echo MG_WERWOELFE_FELLWUCHS_ALR %*%;\
	/set werwoelfe_fellwuchs 1

/def -Fp20 -agCblue -msimple -t'Dein Fell zieht sich zurueck.' \
	werwoelfe_fellwuchs_aus = \
	/cfg_echo MG_WERWOELFE_FELLWUCHS_AUS %*%;\
	/set werwoelfe_fellwuchs 0


; Werwolfrufe

/def -Fp8 -q -agCblue -mregexp -t'Werwolf (.*) heult[:. ]' \
	werwoelfe_werrufe = /cfg_echocolor MG_WERWOELFE_WERRUF %*


;;; beim Start

/config_status
