; $Log: klerus.tf,v $
; Revision 1.17  2003/10/31 10:32:21  rumburuk
; Kostenmeldung berichtigt (! statt .)
;
; Revision 1.16  2003/10/29 15:42:57  thufhnik
; Mit den Kampfstaeben hatte sich ein bug in die Faehigkeiten eingeschlichen.
;
; Revision 1.15  2003/10/08 15:25:28  thufhnik
; Kampfstockskill
;
; Revision 1.14  2003/08/25 11:37:04  thufhnik
; In einer Stufeneinschaetzung wurde aus einem . ein !
;
; Revision 1.13  2003/07/09 13:25:14  thufhnik
; Anrufungsskill und Keulenskill auch in % umsetzen
;
; Revision 1.12  2003/06/12 12:02:11  thufhnik
; Noch nen bischen Kosmetik
;
; Revision 1.11  2003/06/12 11:45:30  thufhnik
; , in %-Angaben durch . ersetzt (ermoeglicht Fliesskommaoperationen im Hook)
; kleinere Triggerbereinigungen
;
; Revision 1.10  2003/05/08 16:20:05  olm
; Und auch hier der Hook set_skillability.
;
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
 
/set klerus_tf_version $Id: klerus.tf,v 1.17 2003/10/31 10:32:21 rumburuk Exp $
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

/ifdef CFG_MG_STUFENKOSTEN -w -q -agCblue -msimple -p0 -t'Wer hat Dir denn das \
	Gehirn gelaeutert? Zeig erstmal was von Deinem Koennen,' \
	klerus_kosten1 = \
	/def -agCblue -msimple -p0 -1 -t'bevor Du schon wieder erhoehen \
		willst!' klerus_kosten1a = /klerus_kosten 0-19

/ifdef CFG_MG_STUFENKOSTEN -w -q -agCblue -msimple -p0 -t'Du wirst bestimmt \
	noch einige Heiltraenke brauchen bis zur naechsten Stufe!' \
	klerus_kosten2 = /klerus_kosten 20-39

/ifdef CFG_MG_STUFENKOSTEN -w -q -agCblue -msimple -p0 -t'Beile Dich! Das \
	Boese sitzt Dir im Nacken und Du hast noch ungefaehr die' \
	klerus_kosten3 = \
	/def -agCblue -msimple -p0 -1 -t'Haelfte vor Dir!' klerus_kosten3a = \
		/klerus_kosten 40-59

/ifdef CFG_MG_STUFENKOSTEN -w -q -agCblue -msimple -p0 -t'So nah am Ziel wirst \
	Du doch nicht aufgeben wollen. Hol Dir noch ein bisschen' \
	klerus_kosten4 = \
	/def -agCblue -msimple -p0 -1 -t'goettliche Unterstuetzung und \
		weiter gehts!' klerus_kosten4a = /klerus_kosten 60-79

/ifdef CFG_MG_STUFENKOSTEN  -w -q -agCblue -msimple -p0 -t'Bei Saphina, Kandri \
	und Lembold, Du bist fast bei der naechsten Stufe' klerus_kosten5 = \
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
/addtolist klerus_guete 52.5 etwas besser als der Durchschnitt
/addtolist klerus_guete 47.5 durchschnittlich gut
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

/def -agCblue -mglob -p1 -w -q -t'{Arkshat|Mindra} mustert Dich \
	eindringlich. Dann sagt {er:|sie:}' klerus_arkshat_ein = \
	/set klerus_arkshat 1%;\
	/if (CFG_KLERUS_GAGLEVEL==1) \
		/echo -a%CFG_KLERUS_COLOR_ARKSHAT %*%;\
	/elseif (CFG_KLERUS_GAGLEVEL==0) \
		/echo %*%;\
	/endif

/def -E(klerus_arkshat) -agCblue -mglob -p1 -w -q -t'{Arkshat|Mindra} \
	nickt leicht mit dem Kopf.' klerus_arkshat_aus = \
	/set klerus_arkshat 0%;\
	/if (CFG_KLERUS_GAGLEVEL==1) \
		/echo -a%CFG_KLERUS_COLOR_ARKSHAT %*%;\
	/elseif (CFG_KLERUS_GAGLEVEL==0) \
		/echo %*%;\
	/endif

/def klerus_skill_out = \
	/getkeyofvalue klerus_guete %{-1}%;\
	/let klerus_tmp_percent=%value%;\
	/let klerus_tmp_color=$[state_color(value)]%;\
	/eval_hook set_skillability $[tolower({1})] %klerus_tmp_percent%;\
	/if (CFG_KLERUS_GAGLEVEL > 1) \
		/if (klerus_tmp_percent < 100 | klerus_force) \
			/echo -pa%CFG_KLERUS_COLOR_ARKSHAT \
				$[pad({1},-17,':',1,\
				strcat("@{",klerus_tmp_color,"}"),0,\
				 klerus_tmp_percent,4,'%@{n}',0)]%;\
		/endif%;\
	/elseif (CFG_KLERUS_GAGLEVEL > 0) \
		/echo -pa%CFG_KLERUS_COLOR_ARKSHAT \
			$[pad({klerus_out},-60, strcat("@{",klerus_tmp_color,\
			"}"),0,strcat(" (",klerus_tmp_percent,"%)"),-6,"@{n}",\
			0)]%;\
	/else \
		/echo %klerus_out%;\
	/endif%;\
	/unset klerus_out%;\
	/unset klerus_force

/def -E(klerus_arkshat) -p1 -w -q -agCblue -mregexp -t'^Du beherrschst \'\
	([a-z]+)\' +([a-zA-Z ]+)\\.$' klerus_prayers = \
	/set klerus_out=%P0%;\
	/klerus_skill_out %P1 %P2

/def -E(klerus_arkshat) -p1 -w -q -agCblue -mregexp -t'^Deine Faehigkeit, mit \
	(Schlagwaffen|Kampfstaeben) zu kaempfen, ist ([a-zA-Z ]+)\
	( ausgebildet\\.)?$' klerus_clubs = \
	/set klerus_force 1%;\
	/if ({P1}=~'Kampfstaeben') \
		/set klerus_skillname=Kampfstaebe%;\
	/else \
		/set klerus_skillname=%P1%;\
	/endif%;\
	/if ({P3}=~' ausgebildet.') \
		/klerus_skill_out %klerus_skillname %P2%;\
		/unset klerus_skillname%;\
	/else \
		/set klerus_tmp_str %P2%;\
		/def -1  -p1 -w -q -agCblue -mregexp -t'^([a-zA-Z ]+)?\
			ausgebildet\\\\.$$' klerus_clubs2 = \
			/set klerus_out=%%klerus_out %%P0%%;\
			/klerus_skill_out %%klerus_skillname \
				%%{klerus_tmp_str} %%P1%%;\
			/unset klerus_tmp_str%%;\
			/unset klerus_skillname%;\
	/endif

/def -E(klerus_arkshat) -p1 -w -q -agCblue -mregexp -t'^Die allgemeine \
	Faehigkeit der Anrufung beherrschst Du ([a-zA-Z ]+)(\\.)?$' \
	klerus_call = \
	/set klerus_force 1%;\
	/set klerus_out=%P0%;\
	/if ({P2}=~'.') \
		/klerus_skill_out Anrufungen %P1%;\
	/else \
		/set klerus_tmp_str %P1%;\
		/def -1  -p1 -w -q -agCblue -mregexp -t'^([a-zA-Z ]+)?\
			\\\\.$$' klerus_call2 = \
			/set klerus_out=%%klerus_out %%P0%%;\
			/klerus_skill_out Anrufungen %%{klerus_tmp_str} \
				%%P1%%;\
			/unset klerus_tmp_str%;\
	/endif
