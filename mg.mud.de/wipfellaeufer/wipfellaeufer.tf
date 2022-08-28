/set wipfellaeufer_tf_version $Id$
/set wipfellaeufer_tf_author=Bugfix@mg.mud.de
/set wipfellaeufer_tf_requires=util.tf util.sfunc.tf
/set wipfellaeufer_tf_desc=Loader der Wipfellaeufergilde

/mload -U -c -dwipfellaeufer status_wipfellaeufer.tf

; Konfigurierbares

/set_var CFG_MG_STUFENKOSTEN 1
/set_var CFG_MG_STUFENKOSTEN_ECHO_ATTR Cyellow
/set_var CFG_MG_STUFENKOSTEN_ECHO_TEXT Du hast #1% der naechsten Stufe erreicht.

; Einschaetzung der Stufe
; Aktuell noch die gleiche wie bei den Abenteurern

/ifdef CFG_MG_STUFENKOSTEN wipfellaeufer_kosten = \
  /echo -a%CFG_MG_STUFENKOSTEN_ECHO_ATTR -- \
    $[sprintf(CFG_MG_STUFENKOSTEN_ECHO_TEXT,{1})]

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -Fp99 -t'Bis Du Dich das \
  naechste Mal hier blicken laesst, solltest Du eine Menge' \
  wipfellaeufer_kosten1 = \
  /def -agCblue -msimple -Fp99 -1 -t'Stufenpunkte sammeln. Sonst wird \
    das nix!' wipfellaeufer_kosten1a = /wipfellaeufer_kosten 0-19

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -Fp99 -t'Da liegt aber noch ein \
  weiter Weg vor Dir. Aber Du schaffst es ganz sicher!' \
  wipfellaeufer_kosten2 = /wipfellaeufer_kosten 20-39 

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -Fp99 -t'Also die Haelfte hast \
  Du schon ungefaehr geschafft. Aber ruh Dich jetzt ja' \
  wipfellaeufer_kosten3 = \
  /def -agCblue -msimple -Fp99 -1 -t'nicht darauf aus. Sieh mal zu, \
    dass Du die zweite Haelfte zur naechsten Stufe' \
    wipfellaeufer_kosten3a%;\
  /def -agCblue -msimple -Fp99 -1 -t'auch noch schaffst. Auf einem Bein \
    kann man schliesslich nicht lange stehn!' \
    wipfellaeufer_kosten3b = /wipfellaeufer_kosten 40-59

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -Fp99 -t'Also ein bisschen was \
  musst Du noch tun, aber es sieht schon ziemlich gut aus!' \
  wipfellaeufer_kosten4 = /wipfellaeufer_kosten 60-79

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -Fp99 -t'Huch na sowas, Du hast \
  die naechste Stufe ja schon fast erreicht. Na also! Der' \
  wipfellaeufer_kosten5 = \
  /def -agCblue -msimple -Fp99 -1 -t'Rest ist ja wirklich nur noch \
    Kleinkram!' wipfellaeufer_kosten3a = \
    /wipfellaeufer_kosten 80-99
