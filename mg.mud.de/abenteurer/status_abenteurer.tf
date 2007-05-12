; $Log: status_abenteurer.tf,v $
; Revision 1.1  2002/09/12 08:54:36  thufhnik
; Scratch
;

/set status_abenteurer_tf_version $Id: status_abenteurer.tf,v 1.1 2002/09/12 08:54:36 thufhnik Exp $
/set status_abenteurer_tf_author=Ahab@mg.mud.de
/set status_abenteurer_tf_requires=util.hooks.tf config.tf(1.16)
/set status_abenteurer_tf_desc=Statuszeile und Report fuer die Abenteurergilde

; Konfiguration

/set_var CFG_ECHO_GAG_LEVEL 2

; Texte und Farben fuer die Spells

; Schnell
/set_var CFG_MG_ABENTEURER_SCHNELL_ECHO_TEXT Schnell
/set_var CFG_MG_ABENTEURER_SCHNELL_ECHO_ATTR Cgreen

; Licht
/set_var CFG_MG_ABENTEURER_LICHT_ECHO_ATTR Cgreen
/set_var CFG_MG_ABENTEURER_LICHT_ECHO_TEXT Licht

; Lernen
/set_var CFG_MG_ABENTEURER_LEARN_ECHO_ATTR Cbggreen

;;; Variablen initialisieren

;/set abenteurer_erschoepfung 0
;/set abenteurer_schnell 0


; Schnell

/def -Fp8 -q -w -agCblue -msimple -t'Du fuehlst Dich ploetzlich \
	deutlich schneller.' abenteurer_schnell = \
	/cfg_echo MG_ABENTEURER_SCHNELL %*%;\
	/set abenteurer_schnell 1%;\
	/eval_hook spell


; Licht

/def -Fp8 -q -w -agCgreen -msimple -t'Du machst eine magische Bewegung.' \
	abenteurer_licht = \
	/cfg_echogag MG_ABENTEURER_LICHT %*%;\
	/purge abenteurer_licht_g1%;\
	/def -Fp8 -1 -q -w -agCgreen -msimple -t'Wie aus dem Nichts \
		erscheint eine leuchtende Kugel.' abenteurer_licht_g1 = \
		/cfg_echo MG_ABENTEURER_LICHT %%*%%;\
		/eval_hook spell


; Erschoepfung

/def -Fp8 -q -w -aCyellow -msimple -t'Du bist noch zu erschoepft von Deinem \
	letzten Spruch.' abenteurer_erschoepf

	
; Zuwenig KP.

/def -Fp8 -q -w -aCyellow -msimple -t'Du hast zu wenig Zauberpunkte fuer \
	diesen Spruch.' abenteurer_no_mp


; Lernen

/def -Fp8 -q -w -agCblue -msimple -t'Du lernst aus Deinem Fehler.' \
	zauberer_lernen_erfolg = /cfg_echocolor MG_ABENTEURER_LEARN %*


; Sachen beim Laden starten

/config_status
