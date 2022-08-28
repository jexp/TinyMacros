/set status_wipfellaeufer_tf_version $Id$
/set status_wipfellaeufer_tf_author=Bugfix@mg.mud.de
/set status_wipfellaeufer_tf_requires=util.hooks.tf config.tf(1.16)
/set status_wipfellaeufer_tf_desc=Statuszeile und Report fuer die Wipfellaeufergilde

; Konfiguration

/set_var CFG_ECHO_GAG_LEVEL 2

; Texte und Farben fuer die Spells

; Schnell
/set_var CFG_STATUS_TEXT_WIPFELLAEUFER_PFEILSCHNELL_1 P
/set_var CFG_STATUS_COLOR_WIPFELLAEUFER_PFEILSCHNELL_1 Cmagenta
/set_var CFG_MG_WIPFELLAEUFER_PFEILSCHNELL_ECHO_TEXT Pfeilschnell
/set_var CFG_MG_WIPFELLAEUFER_PFEILSCHNELL_ECHO_ATTR Cgreen
/set_var CFG_MG_WIPFELLAEUFER_PFEILSCHNELL_ALR_ECHO_ATTR Cgreen
/set_var CFG_MG_WIPFELLAEUFER_PFEILSCHNELL_ALR_ECHO_TEXT Pfeilschnell schon aktiv
/set_var CFG_MG_WIPFELLAEUFER_PFEILSCHNELL_AUS_ECHO_ATTR Cred
/set_var CFG_MG_WIPFELLAEUFER_PFEILSCHNELL_AUS_ECHO_TEXT Pfeilschnell AUS

; Licht
/set_var CFG_MG_WIPFELLAEUFER_LICHT_ECHO_ATTR Cgreen
/set_var CFG_MG_WIPFELLAEUFER_LICHT_ECHO_TEXT Gluehwuermchen

; Wurzelsaft
/set_var CFG_STATUS_TEXT_WIPFELLAEUFER_WURZELSAFT_1 W
/set_var CFG_STATUS_COLOR_WIPFELLAEUFER_WURZELSAFT_1 Cgreen
/set_var CFG_MG_WIPFELLAEUFER_WURZELSAFT_ECHO_ATTR Cgreen
/set_var CFG_MG_WIPFELLAEUFER_WURZELSAFT_ECHO_TEXT Wurzelsaft
/set_var CFG_MG_WIPFELLAEUFER_WURZELSAFT_ALR_ECHO_ATTR Cgreen
/set_var CFG_MG_WIPFELLAEUFER_WURZELSAFT_ALR_ECHO_TEXT Wurzelsaft schon aktiv
/set_var CFG_MG_WIPFELLAEUFER_WURZELSAFT_AUS_ECHO_ATTR Cred
/set_var CFG_MG_WIPFELLAEUFER_WURZELSAFT_AUS_ECHO_TEXT Wurzelsaft AUS

; Baumrinde
/set_var CFG_STATUS_TEXT_WIPFELLAEUFER_BAUMRINDE_1 B
/set_var CFG_STATUS_COLOR_WIPFELLAEUFER_BAUMRINDE_1 Cyellow
/set_var CFG_MG_WIPFELLAEUFER_BAUMRINDE_ECHO_ATTR Cgreen
/set_var CFG_MG_WIPFELLAEUFER_BAUMRINDE_ECHO_TEXT Baumrinde
/set_var CFG_MG_WIPFELLAEUFER_BAUMRINDE_ALR_ECHO_ATTR Cgreen
/set_var CFG_MG_WIPFELLAEUFER_BAUMRINDE_ALR_ECHO_TEXT Baumrinde bereits aktiv
/set_var CFG_MG_WIPFELLAEUFER_BAUMRINDE_AUS_ECHO_ATTR Cred
/set_var CFG_MG_WIPFELLAEUFER_BAUMRINDE_AUS_ECHO_TEXT Baumrinde AUS

; Lernen
/set_var CFG_MG_WIPFELLAEUFER_LEARN_ECHO_ATTR Cbggreen

;;; Variablen initialisieren

/set wipfellaeufer_pfeilschnell 0
/set wipfellaeufer_wurzelsaft 0
/set wipfellaeufer_baumrinde 0


; Statuszeilenmodule

/set sl_wipfellaeufer_baumrinde_doc=Baumrinde ($[status_doc_attr("WIPFELLAEUFER_BAUMRINDE_1")])
/def sl_wipfellaeufer_baumrinde = \
  /set_status_var_flag wipfellaeufer_baumrinde wipfellaeufer_baumrinde 1

/set sl_wipfellaeufer_wurzelsaft_doc=Wurzelsaft ($[status_doc_attr("WIPFELLAEUFER_WURZELSAFT_1")])
/def sl_wipfellaeufer_wurzelsaft = \
  /set_status_var_flag wipfellaeufer_wurzelsaft wipfellaeufer_wurzelsaft 1

/set sl_wipfellaeufer_pfeilschnell_doc=pfeilschnell ($[status_doc_attr("WIPFELLAEUFER_PFEILSCHNELL_1")])
/def sl_wipfellaeufer_pfeilschnell = \
  /set_status_var_flag wipfellaeufer_pfeilschnell wipfellaeufer_pfeilschnell 1


; Pfeilschnell

/def wipfellaeufer_start_pfeilschnell = \
  /set wipfellaeufer_pfeilschnell 1%;\
  /def -1 -Fp8 -q -w -agCblue -msimple -t'Deine Pfeile werden wieder langsamer.' \
    wipfellaeufer_pfeilschnell_2 = \
    /set wipfellaeufer_pfeilschnell 0%%; \
    /cfg_echo MG_WIPFELLAEUFER_PFEILSCHNELL_AUS %%*

/def -Fp8 -q -w -agCblue -msimple -t'Du denkst an die Geschwindigkeit eines Pfeils.' \
  wipfellaeufer_pfeilschnell = \
  /cfg_echogag MG_WIPFELLAEUFER_PFEILSCHNELL %*%; \
  /purge wipfellaeufer_pfeilschnell_* %; \
  /def -1 -Fp8 -q -w -agCblue -msimple -t'Du fuehlst Dich ploetzlich deutlich schneller.' \
    wipfellaeufer_pfeilschnell_1 = \
    /cfg_echo MG_WIPFELLAEUFER_PFEILSCHNELL %%*%%;\
    /wipfellaeufer_start_pfeilschnell%%; \
    /eval_hook spell

/def -Fp8 -q -w -agCblue -msimple -t'Du bist doch schon schneller!' \
  wipfellaeufer_alr_pfeilschnell = \
  /wipfellaeufer_start_pfeilschnell%; \
  /cfg_echo MG_WIPFELLAEUFER_PFEILSCHNELL_ALR %*

; Licht

/def -Fp8 -q -w -agCgreen -msimple -t'Du machst eine magische Bewegung.' \
  wipfellaeufer_licht = \
  /cfg_echogag MG_WIPFELLAEUFER_LICHT %*%;\
  /purge wipfellaeufer_licht_g1%;\
  /def -Fp8 -1 -q -w -agCgreen -msimple -t'Du stimmst Dich ein wenig auf die Natur ein und rufst ein paar Gluehwuermchen herbei.' \
    wipfellaeufer_licht_g1 = \
    /cfg_echo MG_WIPFELLAEUFER_LICHT %%*%%;\
    /eval_hook spell

; Wurzelsaft

/test wipfellaeufer_wurzelsaft_trig:=strcat(p_name, "s Wurzelsaft verschwindet.")
/def wipfellaeufer_start_wurzelsaft = \
  /set wipfellaeufer_wurzelsaft 1%%; \
  /purge wipfellaeufer_wurzelsaft_*%; \
  /def -Fp8 -1 -q -w -agCgreen -msimple -t'%wipfellaeufer_wurzelsaft_trig' \
    wipfellaeufer_wurzelsaft_3 = \
  /set wipfellaeufer_wurzelsaft 0%%; \
  /cfg_echo MG_WIPFELLAEUFER_WURZELSAFT_AUS %%*

/def -Fp8 -q -w -agCgreen -msimple -t'Du ballst Deine Haende zu Faeusten und streckst sie aus. Du konzentrierst Dich' \
  wipfellaeufer_wurzelsaft = \
  /cfg_echogag MG_WIPFELLAEUFER_WURZELSAFT %*%; \
  /def -Fp8 -1 -q -w -agCgreen -msimple -t'auf die Kraft der Wurzeln und versuchst, sie aus dem Boden zu zerren.' \
    wipfellaeufer_wurzelsaft_1 = \
    /cfg_echogag MG_WIPFELLAEUFER_WURZELSAFT %*%; \
  /def -Fp8 -1 -q -w -agCgreen -msimple -t'Aus dem Boden schmiegen sich Wurzeln an Deine Beine.' \
    wipfellaeufer_wurzelsaft_2 = \
    /cfg_echo MG_WIPFELLAEUFER_WURZELSAFT %%*%%; \
    /wipfellaeufer_start_wurzelsaft%%; \
    /eval_hook spell

/def -Fp8 -q -w -agCgreen -msimple -t'Hier hat die Kraft der Wurzeln schon einen Anschub von Dir erhalten.' \
  wipfellaeufer_alr_wurzelsaft = \
  /cfg_echo MG_WIPFELLAEUFER_WURZELSAFT_ALR %*%; \
  /wipfellaeufer_start_wurzelsaft

; Baumrinde

/def wipfellaeufer_start_baumrinde = \
  /purge wipfellaeufer_baumrinde_ende%; \
  /set wipfellaeufer_baumrinde 1%; \
  /def -Fp8 -q -w -agCgreen -msimple -t'Deine Baumrinde loest sich auf.' \
    wipfellaeufer_baumrinde_1 = \
    /set wipfellaeufer_baumrinde 0%%; \
    /cfg_echo MG_WIPFELLAEUFER_BAUMRINDE_AUS %%*

/def -Fp8 -q -w -agCgreen -msimple -t'Dir waechst gerade ein wenig Borke.' \
  wipfellaeufer_baumrinde = \
  /cfg_echo MG_WIPFELLAEUFER_BAUMRINDE %*%; \
  /wipfellaeufer_start_baumrinde

/def -Fp8 -q -w -agCgreen -msimple -t'Du hast doch schon eine Baumrinde!' \
  wipfellaeufer_alr_baumrinde = \
  /cfg_echo MG_WIPFELLAEUFER_BAUMRINDE_ALR %*%; \
  /wipfellaeufer_start_baumrinde
  
  

; Erschoepfung

/def -Fp8 -q -w -aCyellow -msimple -t'Du bist noch zu erschoepft von Deinem \
  letzten Spruch.' wipfellaeufer_erschoepf

  
; Zuwenig KP.

/def -Fp8 -q -w -aCyellow -msimple -t'Du hast zu wenig Zauberpunkte fuer \
  diesen Spruch.' wipfellaeufer_no_mp


; Lernen

/def -Fp8 -q -w -agCblue -msimple -t'Du lernst aus Deinem Fehler.' \
  wipfellaeufer_lernen_erfolg = /cfg_echocolor MG_WIPFELLAEUFER_LEARN %*


; Sachen beim Laden starten

/config_status
