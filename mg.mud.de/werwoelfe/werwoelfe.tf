; $Log: werwoelfe.tf,v $
; Revision 1.4  2002/09/19 10:11:19  thufhnik
; Stufeneinschaetzungen
;
; Revision 1.3  2002/09/18 19:47:29  thufhnik
; Abfrage auf reduce.tf
; Versuch Statusmeldungen
;
; Revision 1.2  2002/09/18 08:33:05  thufhnik
; Messerfunktion
;
; Revision 1.1  2002/07/16 15:39:39  thufhnik
; Scratch
;
 
/set werwoelfe_tf_version $Id$
/set werwoelfe_tf_author=Thufhir@mg.mud.de
/set werwoelfe_tf_requires=util.tf loading.tf
/set werwoelfe_tf_desc=Loader der Werwolfgilde

/mload -U -c -dwerwoelfe status_werwoelfe.tf

; Konfigurierbares

/set_var CFG_MG_STUFENKOSTEN 1
/set_var CFG_MG_STUFENKOSTEN_ECHO_ATTR Cyellow
/set_var CFG_MG_STUFENKOSTEN_ECHO_TEXT Du hast #1% der naechsten Stufe erreicht.

; Einschaetzung der Stufe

/ifdef CFG_MG_STUFENKOSTEN werwoelfe_kosten = \
	/echo -a%CFG_MG_STUFENKOSTEN_ECHO_ATTR -- \
		$[sprintf(CFG_MG_STUFENKOSTEN_ECHO_TEXT,{1})]

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -Fp99 -t'Und wenn Du noch so \
	grimmig guckst und den Mond anheulst. Du hast gerade erst' \
	werwoelfe_kosten1 = \
	/def -agCblue -msimple -Fp99 -1 -t'erhoeht. Nun musst Du erstmal \
		wieder etwas tun!' werwoelfe_kosten1a = \
		/werwoelfe_kosten 0-19

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -Fp99 -t'Staerke Deine \
	Willenskraft. Du hast noch einiges vor Dir!' werwoelfe_kosten2 = \
	/werwoelfe_kosten 20-39

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -Fp99 -t'Noch einige Gegner \
	werden sich vor Dir fuerchten muessen, obwohl Du schon viel' \
	werwoelfe_kosten3 = \
	/def -agCblue -msimple -Fp99 -1 -t'geschafft hast!' \
		werwoelfe_kosten3a = /werwoelfe_kosten 40-59

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -Fp99 -t'Verlass Dein Rudel und \
	zieh hinaus ins Abenteuer. Dann wirst Du bald siegreich' \
	werwoelfe_kosten4 = \
	/def -agCblue -msimple -Fp99 -1 -t'heimkehren!' werwoelfe_kosten4a = \
		/werwoelfe_kosten 60-79

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -Fp99 -t'Noch ein letztes Mal \
	die fuerchterlichen Krallen schaerfen, dann hast Du' \
	werwoelfe_kosten5 = \
	/def -agCblue -msimple -Fp99 -1 -t'Deinen neuen Level erreicht!' \
		werwoelfe_kosten5a = /werwoelfe_kosten 80-99

; Kampfspezifisches

/ifdef is_file_loaded("reduce.tf") -p0 -agCblue -msimple -q -w -t'Du stichst \
	besonders gemein zu, aber so, dass es niemand merkt.' \
	werwoelfe_messerbonus = \
	/set RE_WFUNC .@{%RE_FARBE_37}Wwolf-Fkt@{%RE_FARBE_37}

/if (is_file_loaded("reduce.tf")) \
	/re_def_status sieht noch ganz frisch aus. 100%;\
	/re_def_status hat schon den ein oder anderen Schlag abgekriegt. 90%;\
	/re_def_status hat schon was abgekriegt. 80%;\
	/re_def_status blutet schon ganz gut, lecker. 60%;\
	/re_def_status hat ordentlich was ueber den Schaedel gekriegt. 50%;\
	/re_def_status ist... wie wuerde Mondheuler sagen? Bald faellig... 30%;\
	/re_def_status sieht nach baldigem Umkippen aus. 10%;\
/endif
