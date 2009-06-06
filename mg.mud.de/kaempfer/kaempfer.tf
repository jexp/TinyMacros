; $Log: kaempfer.tf,v $
; Revision 1.1  2002/11/20 12:29:23  thufhnik
; Scratch
;

/set kaempfer_tf_version $Id$
/set kaempfer_tf_author=Thufhir@mg.mud.de
/set kaempfer_tf_requires=
/set kaempfer_tf_desc=Loader der Kaempfergilde

/mload -U -c -dkaempfer fehlschlaege.tf
/mload -U -c -dkaempfer schaetz.tf
/mload -U -c -dkaempfer skills.tf
/mload -U -c -dkaempfer status_kaempfer.tf

; Konfigurierbares

/set_var CFG_MG_STUFENKOSTEN 1
/set_var CFG_MG_STUFENKOSTEN_ECHO_ATTR Cyellow
/set_var CFG_MG_STUFENKOSTEN_ECHO_TEXT Du hast #1% der naechsten Stufe erreicht.

; Stufenkosten

/ifdef CFG_MG_STUFENKOSTEN kaempfer_kosten = \
	/echo -a%CFG_MG_STUFENKOSTEN_ECHO_ATTR -- \
		$[sprintf(CFG_MG_STUFENKOSTEN_ECHO_TEXT,{1})]

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -p0 -t'Hat grade erst erhoeht \
	und faengt schon an zu jammern wie ein altersschwacher' \
	kaempfer_kosten1 = \
	/def -1 -agCblue -msimple -p0 -t'Zauberer. Nimm gefaelligst Haltung \
		an!' kaempfer_kosten1a = /kaempfer_kosten 0-19

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -p0 -t'Oh weh, da hast Du aber \
	noch ne Menge vor Dir. Beiss die Zaehne zusammen und' \
	kaempfer_kosten2 = \
	/def -1 -agCblue -msimple -p0 -t'los gehts!' kaempfer_kosten2a = \
		/kaempfer_kosten 20-39

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -p0 -t'Kaempfer schnell an die \
	Waffen! Die Haelfte hast Du ungefaehr geschafft, aber' \
	kaempfer_kosten3 = \
	/def -1 -agCblue -msimple -p0 -t'es gibt noch viel zu tun!' \
		kaempfer_kosten3a = /kaempfer_kosten 40-59

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -p0 -t'Staerke Deinen \
	Kampfwillen. Die groessten Anstrengungen hast Du schon hinter' \
	 kaempfer_kosten4 = \
	/def -1 -agCblue -msimple -p0 -t'Dir!' kaempfer_kosten4a = \
		/kaempfer_kosten 60-79

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -p0 -t'Das fehlende bisschen \
	machst Du als gnadenlos guter Kaempfer doch mit Links.' \
	kaempfer_kosten5 = \
	/def -1 -agCblue -msimple -p0 -t'Jetzt halt Dich aber mal ran. Oder \
		willst Du Dich auf dem letzten Stueck noch' kaempfer_kosten5a%;\
	/def -1 -agCblue -msimple -p0 -t'von so einem luschigen Zauberer \
		ueberrunden lassen?' kaempfer_kosten5b = /kaempfer_kosten 80-99
