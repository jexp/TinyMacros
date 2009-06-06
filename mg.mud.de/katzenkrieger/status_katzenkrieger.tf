; $Log: status_katzenkrieger.tf,v $
; Revision 1.2  2002/05/21 13:43:03  thufhnik
; Schnell, Pflanzenkrieger und Nachtsicht
;
; Revision 1.1  2002/05/17 15:09:43  thufhnik
; Scratch (zum Testen des neuen cfg_echo erstmal nur das Katzenauge...)
;

/set status_katzenkrieger_tf_version $Id$
/set status_katzenkrieger_tf_author=Thufhir@mg.mud.de
/set status_katzenkrieger_tf_requires=config.tf(1.15) status.tf
/set status_katzenkrieger_tf_desc=Statuszeile die Katzenkriegergilde

;;; Konfiguration

/set_var CFG_MG_KATZENKRIEGER_AUGE_ECHO_TEXT Katzenauge
/set_var CFG_MG_KATZENKRIEGER_AUGE_ECHO_ATTR Cgreen
/set_var CFG_MG_KATZENKRIEGER_AUGE_ALR_ECHO_TEXT Katzenauge schon an!
/set_var CFG_MG_KATZENKRIEGER_AUGE_ALR_ECHO_ATTR Cyellow
/set_var CFG_MG_KATZENKRIEGER_AUGE_AUS_ECHO_TEXT Katzenauge aus
/set_var CFG_MG_KATZENKRIEGER_AUGE_AUS_ECHO_ATTR Cred

/set_var CFG_MG_KATZENKRIEGER_NSICHT_ECHO_TEXT Nachtsicht
/set_var CFG_MG_KATZENKRIEGER_NSICHT_ECHO_ATTR Cgreen
/set_var CFG_MG_KATZENKRIEGER_NSICHT_ALR_ECHO_TEXT Nachtsicht schon an!
/set_var CFG_MG_KATZENKRIEGER_NSICHT_ALR_ECHO_ATTR Cyellow
/set_var CFG_MG_KATZENKRIEGER_NSICHT_AUS_ECHO_TEXT Nachtsicht aus
/set_var CFG_MG_KATZENKRIEGER_NSICHT_AUS_ECHO_ATTR Cred

/set_var CFG_MG_KATZENKRIEGER_SCHNELL_ECHO_TEXT Schnell
/set_var CFG_MG_KATZENKRIEGER_SCHNELL_ECHO_ATTR Cgreen
/set_var CFG_MG_KATZENKRIEGER_SCHNELL_ALR_ECHO_TEXT Schnell schon an!
/set_var CFG_MG_KATZENKRIEGER_SCHNELL_ALR_ECHO_ATTR Cyellow
/set_var CFG_MG_KATZENKRIEGER_SCHNELL_AUS_ECHO_TEXT Schnell aus
/set_var CFG_MG_KATZENKRIEGER_SCHNELL_AUS_ECHO_ATTR Cred

/set_var CFG_MG_KATZENKRIEGER_KRIEGER_ECHO_TEXT Pflanzenkrieger
/set_var CFG_MG_KATZENKRIEGER_KRIEGER_ECHO_ATTR Cgreen
/set_var CFG_MG_KATZENKRIEGER_KRIEGER_ALR_ECHO_TEXT Pflanzenkrieger schon da!
/set_var CFG_MG_KATZENKRIEGER_KRIEGER_ALR_ECHO_ATTR Cyellow
/set_var CFG_MG_KATZENKRIEGER_KRIEGER_DEC_ECHO_TEXT Pflanzenkrieger zerfaellt etwas
/set_var CFG_MG_KATZENKRIEGER_KRIEGER_DEC_ECHO_ATTR Cyellow
/set_var CFG_MG_KATZENKRIEGER_KRIEGER_INC_ECHO_TEXT Pflanzenkriger verbessert
/set_var CFG_MG_KATZENKRIEGER_KRIEGER_INC_ECHO_ATTR Cgreen
/set_var CFG_MG_KATZENKRIEGER_KRIEGER_AUS_ECHO_TEXT Pflanzenkrieger tot
/set_var CFG_MG_KATZENKRIEGER_KRIEGER_AUS_ECHO_ATTR Cbgmagenta

/set_var CFG_MG_KATZENKRIEGER_NO_KP_ECHO_TEXT Zu wenig KP!
/set_var CFG_MG_KATZENKRIEGER_NO_KP_ECHO_ATTR Cred

;;; Variablen initialisieren

/set katzenkrieger_auge 0
/set katzenkrieger_krieger 0
/set katzenkrieger_nsicht 0
/set katzenkrieger_schnell 0

;;; Statusmodule

/set_var CFG_STATUS_COLOR_KATZENKRIEGER_AUGE_1 Cred
/set_var CFG_STATUS_TEXT_KATZENKRIEGER_AUGE_1 A
/set sl_katzenkrieger_auge_doc=Katzenauge $[status_doc_attr("KATZENKRIEGER_AUGE_1")]
/set_status_var_flag katzenkrieger_auge katzenkrieger_auge 1

/set_var CFG_STATUS_COLOR_KATZENKRIEGER_NSICHT_1 Cyellow
/set_var CFG_STATUS_TEXT_KATZENKRIEGER_NSICHT_1 N
/set sl_katzenkrieger_nsicht_doc=Nachtsicht $[status_doc_attr("KATZENKRIEGER_NSICHT_1")]
/set_status_var_flag katzenkrieger_nsicht katzenkrieger_nsicht 1

/set_var CFG_STATUS_COLOR_KATZENKRIEGER_KRIEGER_1 Cyellow
/set_var CFG_STATUS_TEXT_KATZENKRIEGER_KRIEGER_1 k
/set_var CFG_STATUS_COLOR_KATZENKRIEGER_KRIEGER_2 Cgreen
/set_var CFG_STATUS_TEXT_KATZENKRIEGER_KRIEGER_2 K
/set sl_katzenkrieger_krieger_doc=Pflanzenkrieger $[status_doc_attr("KATZENKRIEGER_KRIEGER_1")], stark: $[status_doc_attr("KATZENKRIEGER_KRIEGER_2")]
/set_status_var_count katzenkrieger_krieger katzenkrieger_krieger 1 2

/set_var CFG_STATUS_COLOR_KATZENKRIEGER_SCHNELL_1 Cmagenta
/set_var CFG_STATUS_TEXT_KATZENKRIEGER_SCHNELL_1 S
/set sl_katzenkrieger_schnell_doc=Schnell $[status_doc_attr("KATZENKRIEGER_SCHNELL_1")]
/set_status_var_flag katzenkrieger_schnell katzenkrieger_schnell 1

;;; die Spells

; Katzenauge

/def -agCblue -Fp1 -msimple -q -w -t'Du konzentrierst Dich auf die Kraefte \
	des Katzenauges.' katzenkrieger_auge = \
	/cfg_echogag MG_KATZENKRIEGER_AUGE %*%;\
	/purge katzenkrieger_auge_gag%;\
	/def -1 -agCblue -Fp1 -msimple -q -w -t'Du empfaengst nun die \
		Visionen des Katzenauges.' katzenkrieger_auge_gag = \
		/set katzenkrieger_auge 1%%;\
		/cfg_echo MG_KATZENKRIEGER_AUGE %%*

/def -agCblue -Fp1 -msimple -q -w -t'Die Kraft des Katzenauges laesst nach.' \
	katzenkrieger_auge_aus = \
	/set katzenkrieger_auge 0%;\
	/if /ismacro autokampf_update%; /then \
		/autokampf_update katzenauge%;\
	/endif%;\
	/cfg_echo MG_KATZENKRIEGER_AUGE_AUS %*

/def -agCblue -Fp1 -msimple -q -w -t'Du verfuegst doch noch ueber das \
	Katzenauge.' katzenkrieger_auge_already = \
	/cfg_echo MG_KATZENKRIEGER_AUGE_ALR %*%;\
	/set katzenkrieger_auge 1

; Nachtsicht

/def -agCblue -Fp1 -msimple -q -w -t'Du versuchst, Deine Augen an die \
	Dunkelheit anzupassen.' katzenkrieger_nsicht = \
	/cfg_echogag MG_KATZENKRIEGER_NSICHT %*%;\
	/purge katzenkrieger_nsicht_gag%;\
	/def -1 -agCblue -Fp1 -msimple -q -w -t'Es gelingt Dir.' \
		katzenkrieger_nsicht_gag = \
		/set katzenkrieger_nsicht 1%%;\
		/cfg_echo MG_KATZENKRIEGER_NSICHT %%*

/def -agCblue -Fp1 -msimple -q -w -t'Deine Nachtsicht laesst nach.' \
	katzenkrieger_nsicht_aus = \
	/set katzenkrieger_nsicht 0%;\
	/if /ismacro autokampf_update%; /then \
		/autokampf_update nachtsicht%;\
	/endif%;\
	/cfg_echo MG_KATZENKRIEGER_NSICHT_AUS %*

/def -agCblue -Fp1 -msimple -q -w -t'Deine Augen sind noch angepasst.' \
	katzenkrieger_nsicht_already = \
	/cfg_echo MG_KATZENKRIEGER_NSICHT_ALR %*%;\
	/set katzenkrieger_nsicht 1

; Schnell

/def -agCblue -Fp1 -msimple -q -w -t'Du konzentrierst Dich auf Deine \
	Geschwindigkeit.' katzenkrieger_schnell = \
	/cfg_echogag MG_KATZENKRIEGER_SCHNELL %*%;\
	/purge katzenkrieger_schnell_gag%;\
	/def -1 -agCblue -Fp1 -msimple -q -w -t'Du fuehlst Dich ploetzlich \
		deutlich schneller.' katzenkrieger_schnell_gag = \
		/set katzenkrieger_schnell 1%%;\
		/cfg_echo MG_KATZENKRIEGER_SCHNELL %%*

/def -agCblue -Fp1 -msimple -q -w -t'Deine Geschwindigkeit wird wieder \
	normal.' katzenkrieger_schnell_aus = \
	/set katzenkrieger_schnell 0%;\
	/if /ismacro autokampf_update%; /then \
		/autokampf_update schnell%;\
	/endif%;\
	/cfg_echo MG_KATZENKRIEGER_SCHNELL_AUS %*

/def -agCblue -Fp1 -msimple -q -w -t'Der letzte \'schnell\'-Spruch wirkt doch \
	noch.' katzenkrieger_schnell_already = \
	/cfg_echo MG_KATZENKRIEGER_SCHNELL_ALR %*%;\
	/set katzenkrieger_schnell 1

; Pflanzenkrieger

/def -agCblue -Fp1 -msimple -q -w -t'Du schmeisst die welken Blaetter in die \
	Luft und murmelst die' katzenkrieger_krieger = \
	/cfg_echogag MG_KATZENKRIEGER_KRIEGER %*%;\
	/purge -mglob katzenkrieger_krieger_gag*%;\
	/def -1 -agCblue -Fp1 -msimple -q -w -t'Beschwoerungsformel fuer \
		einen Pflanzenkrieger.' katzenkrieger_krieger_gag1 = \
		/cfg_echogag MG_KATZENKRIEGER_KRIEGER %%*%;\
	/def -1 -agCblue -Fp1 -msimple -q -w -t'Die welken Blaetter fangen \
		in der Luft an zu kreisen und bilden ploetzlich' \
		katzenkrieger_krieger_gag2 = \
		/cfg_echogag MG_KATZENKRIEGER_KRIEGER %%*%;\
	/def -1 -agCblue -Fp1 -msimple -q -w -t'eine Gestalt.' \
		katzenkrieger_krieger_gag3 = \
		/cfg_echogag MG_KATZENKRIEGER_KRIEGER %%*%;\
	/def -1 -agCblue -Fp1 -msimple -q -w -t'Ein Pflanzenkrieger entsteht.' \
		katzenkrieger_krieger_gag4 = \
		/cfg_echogag MG_KATZENKRIEGER_KRIEGER %%*%;\
	/def -1 -agCblue -Fp1 -msimple -q -w -t'Du hast einen Pflanzenkrieger \
		erzeugt.' katzenkrieger_krieger_gag5 = \
		/set katzenkrieger_krieger 1%%;\
		/cfg_echo MG_KATZENKRIEGER_KRIEGER %%*

/def -agCblue -Fp1 -msimple -q -w -t'Dein Pflanzenkrieger loest sich auf.' \
	katzenkrieger_krieger_aus = \
	/set katzenkrieger_krieger 0%;\
	/if /ismacro autokampf_update%; /then \
		/autokampf_update pflanzenkrieger%;\
	/endif%;\
	/cfg_echo MG_KATZENKRIEGER_KRIEGER_AUS %*

/def -agCblue -Fp1 -msimple -q -w -t'Du zerreibst ein welkes Blatt zwischen \
	Deinen Fingern und wirfst die Stuecke' katzenkrieger_krieger_inc = \
	/purge -mglob katzenkrieger_krieger_inc_gag*%;\
	/def -1 -agCblue -Fp1 -msimple -q -w -t'auf Deinen Pflanzenkrieger.' \
		katzenkrieger_krieger_inc_gag1 = \
		/cfg_echogag MG_KATZENKRIEGER_KRIEGER_INC %%*%;\
	/def -1 -agCblue -Fp1 -msimple -q -w -t'Du hast Deinen Pflanzenkrieger \
		erfolgreich gestaerkt.' katzenkrieger_krieger_inc_gag2 = \
		/test ++katzenkrieger_krieger%%;\
		/cfg_echo MG_KATZENKRIEGER_KRIEGER_INC %%*

/def -agCblue -Fp1 -msimple -q -w -t'Dein Pflanzenkrieger faellt leicht in \
	sich zusammen.' katzenkrieger_krieger_dec = \
	/test --katzenkrieger_krieger%;\
	/if /ismacro autokampf_update%; /then \
		/autokampf_update pflanzenkrieger%;\
	/endif%;\
	/cfg_echo MG_KATZENKRIEGER_KRIEGER_DEC %*

/def -agCblue -Fp1 -msimple -q -w -t'Der Pflanzenkrieger ist doch noch \
	gestaerkt.' katzenkrieger_krieger_already = \
	/set katzenkrieger_krieger 2%;\
	/cfg_echo MG_KATZENKRIEGER_KRIEGER_ALR %*

; zu wenig KPs

/def -agCblue -Fp1 -msimple -q -w -t'Du bist einfach zu erschoepft.' \
	katzenkrieger_no_kp = /cfg_echo MG_KATZENKRIEGER_NO_KP %*

;;; nach dem Laden:
/config_status
