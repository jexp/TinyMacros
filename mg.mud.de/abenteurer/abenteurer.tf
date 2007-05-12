; $Log: abenteurer.tf,v $
; Revision 1.3  2002/09/12 12:32:35  thufhnik
; bugfix in stufenabschaetzung
;
; Revision 1.2  2002/09/12 09:05:32  thufhnik
; -
;
; Revision 1.1  2002/09/12 08:54:36  thufhnik
; Scratch
;
 
/set abenteurer_tf_version $Id: abenteurer.tf,v 1.3 2002/09/12 12:32:35 thufhnik Exp $
/set abenteurer_tf_author=Ahab@mg.mud.de
/set abenteurer_tf_requires=util.tf util.sfunc.tf
/set abenteurer_tf_desc=Loader der Abenteurergilde

/mload -U -c -dabenteurer status_abenteurer.tf

; Konfigurierbares

/set_var CFG_MG_STUFENKOSTEN 1
/set_var CFG_MG_STUFENKOSTEN_ECHO_ATTR Cyellow
/set_var CFG_MG_STUFENKOSTEN_ECHO_TEXT Du hast #1% der naechsten Stufe erreicht.

; Einschaetzung der Stufe

/ifdef CFG_MG_STUFENKOSTEN abenteurer_kosten = \
	/echo -a%CFG_MG_STUFENKOSTEN_ECHO_ATTR -- \
		$[sprintf(CFG_MG_STUFENKOSTEN_ECHO_TEXT,{1})]

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -Fp99 -t'Bis Du Dich das \
	naechste Mal hier blicken laesst, solltest Du eine Menge' \
	abenteurer_kosten1 = \
	/def -agCblue -msimple -Fp99 -1 -t'Stufenpunkte sammeln. Sonst wird \
		das nix!' abenteurer_kosten1a = /abenteurer_kosten 0-19

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -Fp99 -t'Da liegt aber noch ein \
	weiter Weg vor Dir. Aber Du schaffst es ganz sicher!' \
	abenteurer_kosten2 = /abenteurer_kosten 20-39 

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -Fp99 -t'Also die Haelfte hast \
	Du schon ungefaehr geschafft. Aber ruh Dich jetzt ja' \
	abenteurer_kosten3 = \
	/def -agCblue -msimple -Fp99 -1 -t'nicht darauf aus. Sieh mal zu, \
		dass Du die zweite Haelfte zur naechsten Stufe' \
		abenteurer_kosten3a%;\
	/def -agCblue -msimple -Fp99 -1 -t'auch noch schaffst. Auf einem Bein \
		kann man schliesslich nicht lange stehn!' \
		abenteurer_kosten3b = /abenteurer_kosten 40-59

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -Fp99 -t'Also ein bisschen was \
	musst Du noch tun, aber es sieht schon ziemlich gut aus!' \
	abenteurer_kosten4 = /abenteurer_kosten 60-79

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -Fp99 -t'Huch na sowas, Du hast \
	die naechste Stufe ja schon fast erreicht. Na also! Der' \
	abenteurer_kosten5 = \
	/def -agCblue -msimple -Fp99 -1 -t'Rest ist ja wirklich nur noch \
		Kleinkram!' abenteurer_kosten3a = \
		/abenteurer_kosten 80-99
