; $Log: klerus.tf,v $
; Revision 1.9  2003/03/14 18:34:25  chbr
; Mindra kann jetzt auch die Einstufungen umrechnen
;
; Revision 1.8  2003/03/11 19:28:11  chbr
; Typo in der Stufenabschaetzung gefixed
;
; Revision 1.7  2002/11/05 14:28:26  thufhnik
; Stufeneinschaetzungen
;
; Revision 1.6  2002/11/05 09:12:48  thufhnik
; Laden der Subgildenfiles umgestellt
;
; Revision 1.5  2002/10/24 12:07:32  thufhnik
; Wunder
;
; Revision 1.4  2002/04/16 11:38:44  thufhnik
; Einschaetzung der Anrufungen in %
; Hierzu bitte CFG_KLERUS_GAGLEVEL beachten
;
; Revision 1.3  2002/02/24 11:34:13  thufhnik
; Reihenfolge des Ladens fuer gufreie Statuszeile geaendert
;
; Revision 1.2  2002/02/24 10:47:47  thufhnik
; ggf. Kandri-File nachladen
;
; Revision 1.1  2002/02/18 11:47:02  thufhnik
; Scratch
;
 
/set klerus_tf_version $Id: klerus.tf,v 1.9 2003/03/14 18:34:25 chbr Exp $
/set klerus_tf_author=Thufhir@mg.mud.de
/set klerus_tf_requires=util.tf
/set klerus_tf_desc=Loader der Klerusgilde


; Konfiguration

/set_var CFG_KLERUS_GAGLEVEL 2
/set_var CFG_KLERUS_COLOR_ARKSHAT Cgreen

/set_var CFG_MG_STUFENKOSTEN 1
/set_var CFG_MG_STUFENKOSTEN_ECHO_ATTR Cyellow
/set_var CFG_MG_STUFENKOSTEN_ECHO_TEXT Du hast #1% der naechsten Stufe erreicht.

; Files Laden

/eval /mload -c -dklerus klerus_%{p_sub_guild}.tf
/mload -c -dklerus status_klerus.tf

;;; Stufenkosten

/ifdef CFG_MG_STUFENKOSTEN klerus_kosten = \
	/echo -a%CFG_MG_STUFENKOSTEN_ECHO_ATTR -- \
		$[sprintf(CFG_MG_STUFENKOSTEN_ECHO_TEXT,{1})]

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -p0 -t'Wer hat Dir denn das \
	Gehirn gelaeutert? Zeig erstmal was von Deinem Koennen,' \
	klerus_kosten1 = \
	/def -agCblue -msimple -p0 -1 -t'bevor Du schon wieder erhoehen \
		willst!' klerus_kosten1a = /klerus_kosten 0-19

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -p0 -t'Du wirst bestimmt \
	noch einige Heiltraenke brauchen bis zur naechsten Stufe.' \
	klerus_kosten2 = /klerus_kosten 20-39

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -p0 -t'Beile Dich! Das Boese \
	sitzt Dir im Nacken und Du hast noch ungefaehr die' \
	klerus_kosten3 = \
	/def -agCblue -msimple -p0 -1 -t'Haelfte vor Dir.' klerus_kosten3a = \
		/klerus_kosten 40-59

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -p0 -t'So nah am Ziel wirst \
	Du doch nicht aufgeben wollen. Hol Dir noch ein bisschen' \
	klerus_kosten4 = \
	/def -agCblue -msimple -p0 -1 -t'goettliche Unterstuetzung und \
		weiter gehts!' klerus_kosten4a = /klerus_kosten 60-79

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -p0 -t'Bei Saphina, Kandri und \
	Lembold, Du bist fast bei der naechsten Stufe' klerus_kosten5 = \
	/def -agCblue -msimple -p0 -1 -t'angekommen!' klerus_kosten5a = \
		/klerus_kosten 80-99

;;; Wunder

/ifdef (p_guild_level>8) -p0 -mregexp -aCgreen -P1Cbgyellow,Cwhite -q -w \
	-t' sieht ploetzlich um (einiges) mitgenommener aus\\.$' klerus_wunder1

/ifdef (p_guild_level>8) -p0 -mregexp -aCgreen -P1Cbgred,Cwhite -q -w \
	-t' sieht ploetzlich (erheblich) mitgenommener aus\\.$' klerus_wunder2

;;; Arkshats Einschaetzung in %

/createlist klerus_guete
/addtolist klerus_guete 100 unuebertrefflich gut
/addtolist klerus_guete 95 fast perfekt
/addtolist klerus_guete 90 phantastisch gut
/addtolist klerus_guete 85 hervorragend
/addtolist klerus_guete 80 ausserordentlich gut
/addtolist klerus_guete 75 schon sehr gut
/addtolist klerus_guete 70 gut
/addtolist klerus_guete 65 recht gut
/addtolist klerus_guete 60 besser als der Durchschnitt
/addtolist klerus_guete 55 ueberdurchschnittlich gut
/addtolist klerus_guete 52,5 etwas besser als der Durchschnitt
/addtolist klerus_guete 47,5 durchschnittlich gut
/addtolist klerus_guete 45 fast durchschnittlich gut
/addtolist klerus_guete 40 nur unterdurchschnittlich
/addtolist klerus_guete 35 schon nicht schlecht
/addtolist klerus_guete 30 noch nicht gut
/addtolist klerus_guete 25 nur wenig
/addtolist klerus_guete 20 gar nicht gut
/addtolist klerus_guete 15 nur sehr wenig
/addtolist klerus_guete 10 noch kaum
/addtolist klerus_guete 5 sehr schlecht
/addtolist klerus_guete 0 erbaermlich schlecht

/def -agCblue -mregexp -p10 -q -t'(Arkshat|Mindra) mustert Dich eindringlich. Dann \
	sagt (er|sie):' klerus_arkshat_ein = \
	/set klerus_arkshat 1%;\
	/if (CFG_KLERUS_GAGLEVEL==1) \
		/echo -a%CFG_KLERUS_COLOR_ARKSHAT %*%;\
	/elseif (CFG_KLERUS_GAGLEVEL==0) \
		/echo %*%;\
	/endif

/def -agCblue -mglob -p10 -q -t'{Arkshat|Mindra} nickt leicht mit dem Kopf.' \
	klerus_arkshat_aus = \
	/set klerus_arkshat 0%;\
	/if (CFG_KLERUS_GAGLEVEL==1) \
		/echo -a%CFG_KLERUS_COLOR_ARKSHAT %*%;\
	/elseif (CFG_KLERUS_GAGLEVEL==0) \
		/echo %*%;\
	/endif

/def -E(klerus_arkshat) -p9999 -q -agCblue -mregexp -t'^Du beherrschst \'\
	([a-z]+)\' +([a-zA-Z ]+)\\.$' klerus_prayers = \
	/getkeyofvalue klerus_guete %P2%;\
	/let klerus_tmp_percent=%value%;\
	/let klerus_tmp_color=$[state_color(value)]%;\
	/if (CFG_KLERUS_GAGLEVEL > 1) \
		/if (klerus_tmp_percent < 100) \
			/echo -pa%CFG_KLERUS_COLOR_ARKSHAT \
				$[pad({P1},-17,':',1,\
				strcat("@{",klerus_tmp_color,"}"),0,\
				klerus_tmp_percent,4,'%@{n}',0)]%;\
		/endif%;\
	/elseif (CFG_KLERUS_GAGLEVEL > 0) \
		/echo -pa%CFG_KLERUS_COLOR_ARKSHAT \
			$[pad({P0},-60, strcat("@{",klerus_tmp_color,"}"),0,\
			strcat("(",klerus_tmp_percent,"%)"),-6,"@{n}",0)]%;\
	/else \
		/echo %P0%;\
	/endif
