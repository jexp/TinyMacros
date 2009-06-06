; $Log: zauberer.tf,v $
; Revision 1.4  2002/09/03 12:30:31  thufhnik
; Stufenkostenausgabe mit CFG_MG_STUFENKOSTEN konfigurierbar
;
; Revision 1.3  2002/09/03 11:31:57  thufhnik
; Einschaetzung der Stufenkosten
;
; Revision 1.2  2002/04/20 15:38:51  thufhnik
; Anpassung an /configure
;
; Revision 1.1  2002/02/10 14:35:47  thufhnik
; Scratch
;
 
/set zauberer_tf_version $Id$
/set zauberer_tf_author=Thufhir@mg.mud.de
/set zauberer_tf_requires=util.tf util.sfunc.tf
/set zauberer_tf_desc=Loader der Zauberergilde

/mload -U -c -dzauberer status_zauberer.tf
/mload -U -c -dzauberer koma.tf
/mload -c -dzauberer stab.tf

; Konfigurierbares

/set_var CFG_MG_STUFENKOSTEN 1
/set_var CFG_MG_STUFENKOSTEN_ECHO_ATTR Cyellow
/set_var CFG_MG_STUFENKOSTEN_ECHO_TEXT Du hast #1% der naechsten Stufe erreicht.

; Einschaetzung der Stufe

/ifdef CFG_MG_STUFENKOSTEN zauberer_kosten = \
	/echo -a%CFG_MG_STUFENKOSTEN_ECHO_ATTR -- \
		$[sprintf(CFG_MG_STUFENKOSTEN_ECHO_TEXT,{1})]

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -Fp99 -t'Jetzt fang hier ja \
	nicht an zu jammern. Du hast doch grade erst erhoeht. Fuer' \
	zauberer_kosten1 = \
	/def -agCblue -msimple -Fp99 -1 -t'die naechste Stufe musst Du erstmal \
		Leistung zeigen!' zauberer_kosten1a = /zauberer_kosten 0-19

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -Fp99 -t'Du kannst zwar zaubern, \
	aber nicht hexen. Fuer die naechste Stufe musst Du' zauberer_kosten2 = \
	/def -agCblue -msimple -Fp99 -1 -t'schon noch einiges tun!' \
		zauberer_kosten2a = /zauberer_kosten 20-39 

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -Fp99 -t'Teile Llystrathe mit \
	Hilfe. Och schade scheint nicht zu funktionieren, dann' \
	zauberer_kosten3 = \
	/def -agCblue -msimple -Fp99 -1 -t'musst Du eben selber noch ne Menge \
		Stufenpunkte sammeln!' zauberer_kosten3a = \
		/zauberer_kosten 40-59

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -Fp99 -t'Ein bisschen Wille und \
	Magie und Du schaffst es wieder ein Stueck naeher an' \
	zauberer_kosten4 = \
	/def -agCblue -msimple -Fp99 -1 -t'die neue Stufe heranzukommen!' \
		zauberer_kosten4a = /zauberer_kosten 60-79

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -Fp99 -t'Die paar fehlenden \
	Puenktchen haste Dir doch rasch zusammengezaubert!' \
	zauberer_kosten5 = /zauberer_kosten 80-99
