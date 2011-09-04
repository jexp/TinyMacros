; $Log: dunkelelfen.tf,v $
; Revision 1.18  2005/02/15 11:51:57  thufhnik
; Nyelas Einschaetzung an die Gilde angepasst (part 1)
;
; Revision 1.17  2005/01/07 14:40:54  thufhnik
; Ergaenzung zu Nenaisus Skills
;
; Revision 1.16  2005/01/07 14:22:50  thufhnik
; Teo kann jetzt auch die Faehigkeiten mitteilen
;
; Revision 1.15  2003/10/14 12:57:34  thufhnik
; Nur noch eigene Skills in %, damit der hook nicht mit fremden
; Skills durcheinander kommt.
;
; Revision 1.14  2003/09/30 13:31:31  thufhnik
; Teo spricht fuer alle skillz zu lang, da kommen leider Prompts zwischen. ;(
;
; Revision 1.13  2003/08/20 10:20:04  thufhnik
; Nenaisus tms koennen ebenfalls brechen. ;(
;
; Revision 1.12  2003/08/20 08:09:20  thufhnik
; Einheitliche Skillausgabe, jetzt konfigurierbar
; teile mit von Nenaisu ebenfalls bearbeiten
;
; Revision 1.11  2003/08/14 07:05:10  thufhnik
; Schwertkampfskill
; Nyela darf jetzt auch brechen
;
; Revision 1.10  2003/08/14 06:43:55  thufhnik
; Bugfix in den hoeheren %-Ausgaben
;
; Revision 1.9  2003/08/13 09:15:13  thufhnik
; Wenn Teo (um)bricht, dann tun wir das auch. ;)
;
; Revision 1.8  2003/08/07 17:26:11  thufhnik
; Skills der Kaempfer, erstmal ohne Schwertkampf (vielleicht schraubt
; Padreic da noch)
;
; Revision 1.7  2003/08/06 15:55:15  thufhnik
; Die Einschaetzung in Worten bei den Skills mit ausgeben
;
; Revision 1.6  2003/08/06 08:41:52  thufhnik
; Skills Kleruszweig
;
; Revision 1.5  2003/08/05 11:13:00  thufhnik
; Skills Magiezweig
;
; Revision 1.4  2003/07/30 08:34:35  thufhnik
; Skills sind nun fertig. ;)
;
; Revision 1.3  2003/07/29 21:13:37  thufhnik
; Ergaenzungen in den Skilleinschaetzungen
;
; Revision 1.2  2003/07/29 16:58:19  thufhnik
; Scratch
;
; Revision 1.1  2003/07/29 09:26:05  thufhnik
; Scratch
;
 
/set dunkelelfen_tf_version $Id: dunkelelfen.tf,v 1.18 2005/02/15 11:51:57 thufhnik Exp $
/set dunkelelfen_tf_author=Thufhir@mg.mud.de
/set dunkelelfen_tf_requires=util.tf util.sfunc.tf
/set dunkelelfen_tf_desc=Loader der Dunkelelfengilde

/mload -U -c -ddunkelelfen status_dunkelelfen.tf
/mload -U -c -ddunkelelfen status_ext.tf
; Konfigurierbares

/set_var CFG_DUNKELELFEN_SKILL_COLOR Cgreen
/set_var CFG_DUNKELELFEN_SKILL_TEXT - #1 (#2%) #3

/set_var CFG_MG_STUFENKOSTEN 1
/set_var CFG_MG_STUFENKOSTEN_ECHO_ATTR Cyellow
/set_var CFG_MG_STUFENKOSTEN_ECHO_TEXT Du hast #1% der naechsten Stufe erreicht.

; Einschaetzung der Stufe

/ifdef CFG_MG_STUFENKOSTEN dunkelelfen_kosten = \
	/echo -a%CFG_MG_STUFENKOSTEN_ECHO_ATTR -- \
		$[sprintf(CFG_MG_STUFENKOSTEN_ECHO_TEXT,{1})]

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -Fp99 -t'Bis Du Dich das \
	naechste Mal hier blicken laesst, solltest Du eine Menge' \
	dunkelelfen_kosten1 = \
	/def -agCblue -msimple -Fp99 -1 -t'Stufenpunkte sammeln. Sonst wird \
		das nix!' dunkelelfen_kosten1a = /dunkelelfen_kosten 0-19

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -Fp99 -t'Da liegt aber noch ein \
	weiter Weg vor Dir. Aber Du schaffst es ganz sicher!' \
	dunkelelfen_kosten2 = /dunkelelfen_kosten 20-39 

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -Fp99 -t'Also die Haelfte hast \
	Du schon ungefaehr geschafft. Aber ruh Dich jetzt ja' \
	dunkelelfen_kosten3 = \
	/def -agCblue -msimple -Fp99 -1 -t'nicht darauf aus. Sieh mal zu, \
		dass Du die zweite Haelfte zur naechsten Stufe' \
		dunkelelfen_kosten3a%;\
	/def -agCblue -msimple -Fp99 -1 -t'auch noch schaffst. Auf einem Bein \
		kann man schliesslich nicht lange stehn!' \
		dunkelelfen_kosten3b = /dunkelelfen_kosten 40-59

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -Fp99 -t'Also ein bisschen was \
	musst Du noch tun, aber es sieht schon ziemlich gut aus!' \
	dunkelelfen_kosten4 = /dunkelelfen_kosten 60-79

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -Fp99 -t'Huch na sowas, Du hast \
	die naechste Stufe ja schon fast erreicht. Na also! Der' \
	dunkelelfen_kosten5 = \
	/def -agCblue -msimple -Fp99 -1 -t'Rest ist ja wirklich nur noch \
		Kleinkram!' dunkelelfen_kosten3a = \
		/dunkelelfen_kosten 80-99

; Gildenfaehigkeiten

/def dunkelelfen_skill = \
	/if (regmatch('(wirklich |einfach |einigermassen |gerade mal |\
	    noch nicht einmal |)(absolut nicht|so gut wie gar nicht|\
	    katastrophal|bemitleidenswert|beaengstigend|jaemmerlich|\
	    laecherlich|furchtbar|schlecht|kaum|schwach|maessig|\
	    ausreichend|brauchbar|gut|erstaunlich gut|spielend|\
	    bemerkenswert|hervorragend|beeindruckend|fast perfekt|\
	    perfekt|hast Du bisher noch nicht gelernt)', {*})) \
		/if ({P1} =~ 'einfach ') /let ds_abzug=1%;\
		/elseif ({P1} =~ 'einigermassen ') /let ds_abzug=2%;\
		/elseif ({P1} =~ 'gerade mal ') /let ds_abzug=3%;\
		/elseif ({P1} =~ 'noch nicht einmal ') /let ds_abzug=4%;\
		/else /let ds_abzug=0%;\
		/endif%;\
		/if ({P2} =~ 'absolut nicht') /let ds_base=0%;\
		/elseif ({P2} =~ 'so gut wie gar nicht') /let ds_base=5%;\
		/elseif ({P2} =~ 'katastrophal') /let ds_base=10%;\
		/elseif ({P2} =~ 'bemitleidenswert') /let ds_base=15%;\
		/elseif ({P2} =~ 'beaengstigend') /let ds_base=20%;\
		/elseif ({P2} =~ 'jaemmerlich') /let ds_base=25%;\
		/elseif ({P2} =~ 'laecherlich') /let ds_base=30%;\
		/elseif ({P2} =~ 'furchtbar') /let ds_base=35%;\
		/elseif ({P2} =~ 'schlecht') /let ds_base=40%;\
		/elseif ({P2} =~ 'kaum') /let ds_base=45%;\
		/elseif ({P2} =~ 'schwach') /let ds_base=50%;\
		/elseif ({P2} =~ 'maessig') /let ds_base=55%;\
		/elseif ({P2} =~ 'ausreichend') /let ds_base=60%;\
		/elseif ({P2} =~ 'brauchbar') /let ds_base=65%;\
		/elseif ({P2} =~ 'gut') /let ds_base=70%;\
		/elseif ({P2} =~ 'erstaunlich gut') /let ds_base=75%;\
		/elseif ({P2} =~ 'spielend') /let ds_base=80%;\
		/elseif ({P2} =~ 'bemerkenswert') /let ds_base=85%;\
		/elseif ({P2} =~ 'hervorragend') /let ds_base=90%;\
		/elseif ({P2} =~ 'beeindruckend') /let ds_base=95%;\
		/elseif ({P2} =~ 'fast perfekt') /let ds_base=100%;\
		/elseif ({P2} =~ 'perfekt') /let ds_base=100%;\
		/else /let ds_base=0%;\
		/endif%;\
		/return $[ds_base-ds_abzug]%;\
	/else \
		/return "???"%;\
	/endif

/def -msimple -p1 -w -q -t'Folgende Faehigkeiten/Zaubersprueche kannst Du \
	Dir hier vermitteln lassen:' dunkelelfen_skills_start = \
	/set dunkelelfen_skills 1%;\
	/def -1 -w -q -Fp9999999 -hPROMPT dunkelelfen_skill_stop = \
		/unset dunkelelfen_skills

/def -E(dunkelelfen_skills) -mglob -agCblue -p1 -w -q -t'- * \
	kannst Du bereits *' dunkelelfen_skills = \
	/set dunkelelfen_tmp_skill=$[substr({-5},0,-1)]%;\
	/set dunkelelfen_tmp_name=%2%;\
	/dunkelelfen_skill_out 13

/def -Fp100000 -w -q -mglob -t'* fragt Nenais\'u nach {Faehigkeiten.|\
	Sprueche.}' dunkel_elfen_nyela_negativ = \
	/set dunkelelfen_no_skillhook 1

/def -mregexp -Fp100000 -w -q -t'^Nenais\'u (teilt Dir mit|sagt): So steht es \
	um Deine Sprueche:' dunkelelfen_magieskills_start = \
	/if (dunkelelfen_no_skillhook) \
		/unset dunkelelfen_no_skillhook%;\
	/else \
		/set dunkelelfen_magieskills 1%;\
		/def -1 -w -q -Fp9999999 -hPROMPT \
			dunkelelfen_magieskills_stop = \
			/unset dunkelelfen_magieskills%;\
	/endif

/def -E(dunkelelfen_magieskills) -mglob -agCblue -p1000 -w -q -t'Nenais\'u \
	{teilt Dir mit:|sagt:} * kannst Du *' dunkelelfen_magieskills = \
	/if ({2}=~"sagt:") \
		/set dunkelelfen_tmp_skill=$[substr({-5},0,-1)]%;\
		/set dunkelelfen_tmp_name=%3%;\
		/dunkelelfen_skill_out 13%;\
	/else \
		/set dunkelelfen_tmp_name=%5%;\
		/if ({L1}=/"*.") \
			/set dunkelelfen_tmp_skill=$[substr({-7},0,-1)]%;\
			/dunkelelfen_skill_out 13%;\
		/else \
			/set dunkelelfen_tmp_skill=%-7%;\
			/def -1 -mregexp -agCblue -p1000 -w -q -t'^Nenais\\'u \
				teilt Dir mit: ([a-z ]+)\\\\.' \
				dunkelelfen_zauberskills_broken = \
				/set dunkelelfen_tmp_skill=\
					%%dunkelelfen_tmp_skill %%P1%%;\
				/dunkelelfen_skill_out 13%;\
		/endif%;\
	/endif

/def -E(dunkelelfen_magieskills) -msimple -agCblue -p1000 -w -q -t'Nenais\'u \
	teilt Dir mit: ' dunkelelfen_magieskills_gag

/def -E(dunkelelfen_magieskills) -mglob -agCblue -p1000 -w -q -t'Nenais\'u \
	teilt Dir mit: * hast Du noch nicht gelernt*' \
	dunkelelfen_magieskills_no = \
	/echo -pa%CFG_DUNKELELFEN_SKILL_COLOR -- %*

/def -Fp100000 -w -q -mglob -t'* fragt Teo\'na\'katl nach {Faehigkeiten.|\
	Anrufungen.}' dunkel_elfen_teo_negativ = \
	/set dunkelelfen_no_skillhook 1

/def -mregexp -Fp10000 -w -q -t'^Teo\'na\'katl (teilt Dir mit|sagt): So steht \
	es um Dich und Deine Faehigkeiten:$' dunkelelfen_klerusskills_start = \
	/if (dunkelelfen_no_skillhook) \
		/unset dunkelelfen_no_skillhook%;\
	/else \
		/set dunkelelfen_klerusskills 1%;\
	/endif

/def -E(dunkelelfen_klerusskills) -mregexp -agCblue -p1000 -w -q \
	-t'^Teo\'na\'katl (teilt Dir mit|sagt): ([a-z]+) +(kannst Du \
	([a-z ]+)(\\.)?|hast Du bisher noch nicht gelernt\\.)$' \
	dunkelelfen_klerusskills = \
	/set dunkelelfen_tmp_name=%P2%;\
	/if (dunkelelfen_tmp_name=~'wiederbelebung') \
		/unset dunkelelfen_klerusskills%;\
	/endif%;\
	/if ({P3}=~'hast Du bisher noch nicht gelernt.') \
		/echo -pa%CFG_DUNKELELFEN_SKILL_COLOR -- %P0%;\
	/else \
		/set dunkelelfen_tmp_skill=%P4%;\
		/dunkelelfen_skill_out 14%;\
	/endif

/def -Fp100000 -w -q -mglob -t'* fragt Nyela nach {Skills.|Faehigkeiten.}' \
	dunkel_elfen_nyela_negativ = /set dunkelelfen_no_skillhook 1

/def -msimple -p1000 -w -q -t'Nyela sagt: So steht es um Dich und Deine \
	Faehigkeiten:' dunkelelfen_kaempferskills_start = \
	/if (dunkelelfen_no_skillhook) \
		/unset dunkelelfen_no_skillhook%;\
	/else \
		/set dunkelelfen_kaempferskills 1%;\
		/def -1 -w -q -Fp9999999 -hPROMPT \
			dunkelelfen_kaempferskills_stop = \
			/unset dunkelelfen_kaempferskills%;\
	/endif

/def -E(dunkelelfen_kaempferskills) -mregexp -agCblue -p1000 -w -q \
	-t'^Nyela sagt: den Kampf mit dem Schwert beherrschst Du \
	([a-z ]+)(\\.)?$' dunkelelfen_kaempferschwert = \
	/set dunkelelfen_tmp_skill=%P1%;\
	/set dunkelelfen_tmp_name=schwertkampf%;\
	/if ({P2}=~'.') \
		/dunkelelfen_skill_out 16%;\
	/else \
		/dunkelelfen_kaempfer_broken%;\
	/endif

/def -E(dunkelelfen_kaempferskills) -mregexp -agCblue -p1000 -w -q \
	-t'^Nyela sagt: ([A-Z]?[a-z]+) +kannst Du ([a-z ]+)(\\.)?$' \
	dunkelelfen_kaempferskills = \
	/set dunkelelfen_tmp_skill=%P2%;\
	/set dunkelelfen_tmp_name=$[tolower({P1})]%;\
	/if ({P3}=~'.') \
		/dunkelelfen_skill_out 16%;\
	/else \
		/dunkelelfen_kaempfer_broken%;\
	/endif

/def dunkelelfen_kaempfer_broken = \
	/def -1 -mregexp -agCblue -p1000 -w -q -t'^Nyela sagt: \
		([a-z ]+)\\\\.$$' dunkelelfen_nyela_broken = \
		/set dunkelelfen_tmp_skill=%%dunkelelfen_tmp_skill %%P1%%;\
		/dunkelelfen_skill_out 16

/def dunkelelfen_skill_out = \
	/let dunkelelfen_tmp_percent=\
		$[dunkelelfen_skill(dunkelelfen_tmp_skill)]%;\
	/let dunkelelfen_tmp_color=\
		$[state_color(dunkelelfen_tmp_percent)]%;\
	/echo -pa%CFG_DUNKELELFEN_SKILL_COLOR -- \
		$[sprintf(CFG_DUNKELELFEN_SKILL_TEXT,\
		pad(dunkelelfen_tmp_name,-{1}),\
		pad(strcat("@{",dunkelelfen_tmp_color,"}"),0,\
			dunkelelfen_tmp_percent,3,"@{n}",0),\
		{dunkelelfen_tmp_skill})]%;\
	/eval_hook set_skillability $[tolower(dunkelelfen_tmp_name)] \
		%dunkelelfen_tmp_percent%;\
	/unset dunkelelfen_tmp_name%;\
	/unset dunkelelfen_tmp_skill
