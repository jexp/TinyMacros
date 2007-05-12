
; $Log: plinfo.tf,v $
; Revision 1.10  2003/02/27 14:46:21  lje
;
; Kraft und Ausdauer wurden offenbar im Info-Befehl getauscht
;
; Revision 1.9  2003/01/01 12:55:32  olm
; info_format_str heisst jetzt plinfo_format_str. Mit der alten Bezeichnung
; ist es von der info.tf rausgeworfen worden (purge info_*).
;
; Revision 1.8  2002/12/12 11:36:35  lje
;
; Zeilen 0 vor das "ausruestung" gesetzt, da dieses More verwendet und es auf kleinen Terminals sonst zu fehlern kommt
;
; Revision 1.7  2002/12/10 20:20:41  lje
;
; Hmja, Kraft und Ausdauer waren im Homemud noch andersrum...
;
; Revision 1.6  2002/12/10 20:05:49  lje
;
; "sscore" komplett nachgebaut -> /plscore
;
; Revision 1.5  2002/12/09 19:59:52  lje
;
; Kleiner Bugfix, danke Eldaron
;
; Revision 1.4  2002/12/09 16:51:46  lje
;
; Test auf vorhandenes Scoreamulett
;
; Revision 1.3  2002/12/09 12:03:57  lje
;
; Daten aus "info" werden nun ausgewertet und das komplette "sinfo" ist nachgebildet
;
; Revision 1.2  2002/12/09 10:15:22  lje
;
; Bei Waffen wird jetzt die Anzahl der benutzten Haende angezeigt
;
; Revision 1.1  2002/12/09 01:20:28  lje
;
; Erste Version, momentan nur benutzte Waffen/Ruestung
;
;
;

/set plinfo_tf_version $Id: plinfo.tf,v 1.10 2003/02/27 14:46:21 lje Exp $
/set plinfo_tf_author=Vardion@mg.mud.de
/set plinfo_tf_requires=
/set plinfo_tf_desc=TF-Teilersatz fuer Patryns Scoreamulett

/set plinfo_auto_zeilen=3

/def plinfo = \
	/def -p10000 -mregexp -q -ag -n1 -t'^Du ziehst das Scoreamulett an.$$|\
		^Du traegst das Scoreamulett bereits.$$|^Du musst das \
		Scoreamulett erst nehmen !$$|^Wie bitte.$$' \
		plinfo_test = \
		/if ({2} =~ 'ziehst' | {2} =~ 'traegst') \
			!\\sinfo%%; \
		/else \
			/plinfo_info%%; \
		/endif%; \
	!\\trage scoreamulett

/def plinfo_info = \
	/def -p10000 -mregexp -q -ag -n1 -t'^                    ' info_s = \
		/plinfo_start%; \
	/def -p10000 -msimple -q -ag -n1 -t'Okay, Deine Zeilenzahl steht nun \
		auf 0.' info_g%; \
	!\\zeilen 0%; \
	!\\ausruestung%; \
	!\\zeilen auto -%plinfo_auto_zeilen%; \
	!\\info

/def plinfo_start = \
	/set wcount=0%; \
	/plinfo_collect %PR%; \
	/def -p10000 -mglob -q -ag -n21 -t'*' info_c = /plinfo_collect %%*

/def plinfo_collect = \
	/if (regmatch('[<A-Za-z][A-Za-z0-9 \\.-]*[A-Za-z>]', {*})) \
		/test ++wcount%; \
		/let val=%P0%; \
		/if (val =/ '<*>') /let val=%; /endif%; \
		/if     (wcount ==  1) /set info_ausr_helm=%val%; \
		/elseif (wcount ==  2) /set info_ausr_waffe=%val%; \
		/elseif (wcount ==  3) /set info_ausr_koecher=%val%; \
		/elseif (wcount ==  4) /set info_ausr_amulett=%val%; \
		/elseif (wcount ==  5) /set info_ausr_panzer=%val%; \
		/elseif (wcount ==  6) /set info_ausr_ring=%val%; \
		/elseif (wcount ==  7) /set info_ausr_schild=%val%; \
		/elseif (wcount ==  8) /set info_ausr_hands=%val%; \
		/elseif (wcount ==  9) /set info_ausr_guertel=%val%; \
		/elseif (wcount == 10) /set info_ausr_umhang=%val%; \
		/elseif (wcount == 11) /set info_ausr_hose=%val%; \
		/elseif (wcount == 12) \
			/unset wcount%; \
			/set info_ausr_schuhe=%val%; \
			/def -p10000 -mregexp -q -ag -n1 \
				-t'^- (\\\\[Team .+\\\\] )?(.+) -*$$' \
				info_s = /plinfo_start2%; \
			/def -p9999 -mglob -q -ag -n1 -t'Ok, Deine Zeilenzahl \
				wird nun *' info_g1%; \
			/def -p9999 -mglob -q -ag -n1 -t'Bitte beachte, dass \
				dies *' info_g2%; \
			/def -p9999 -mglob -q -ag -n1 -t'Telnetnegotiations \
				unterstuetzt *' info_g3%; \
		/endif%; \
	/endif

/def plinfo_start2 = \
	/set info_info_titel=%P2%; \
	/def -p10000 -mglob -q -ag -t'*' info_c = /plinfo_collect2 %%*
	

/def plinfo_collect2 = \
	/if ({*} =/ '------------------------------*') \
		/undef info_c%; \
		/plinfo_ausgabe%; \
		/break%; \
	/endif%; \
	/if     ({*} =/ 'Rasse ........*') /set info_info_rasse=%3%; \
	/elseif ({*} =/ 'Geschlecht ...*') \
		/set info_info_geschl=%3%; \
		/set info_info_groesse=%6 cm%; \
	/elseif ({*} =/ 'Stufe ........*') \
		/test regmatch('Gewicht[^0-9]+', {*})%; \
		/set info_info_gewicht=%PR%; \
	/elseif ({*} =/ 'Alter: *') /set info_info_alter=%-1%; \
	/endif

/def plinfo_format_str = \
	/return substr(pad({1}, -{2}), 0, {2})

/def plinfo_ausgabe = \
	/let whands=1%; \
	/if (info_ausr_schild =~ info_ausr_waffe) \
		/set info_ausr_schild=%; \
		/let whands=2%; \
	/endif%; \
	/if (info_ausr_waffe !~ '') \
		/test info_ausr_waffe:=strcat(plinfo_format_str(info_ausr_waffe,\
			51), '(', whands, '-haendig)')%; \
	/endif%; \
	/_echo +-------------------------------------------------------------\
		--------------+%; \
	/_echo | $[plinfo_format_str(info_info_titel, 74)]|%; \
	/_echo +-------------------------------------+-----------------------\
		--------------+%; \
	/_echo | Rasse.....: $[plinfo_format_str(info_info_rasse, 24)]\
		| Groesse...: $[plinfo_format_str(info_info_groesse, 24)]|%; \
	/_echo | Geschlecht: $[plinfo_format_str(info_info_geschl, 24)]\
		| Gewicht...: $[plinfo_format_str(info_info_gewicht, 24)]|%; \
	/_echo +-------------------------------------+-----------------------\
		--------------+%; \
	/_echo | Waffe.....: $[plinfo_format_str(info_ausr_waffe,   62)]|%; \
	/_echo | Schild....: $[plinfo_format_str(info_ausr_schild,  62)]|%; \
	/_echo | Helm......: $[plinfo_format_str(info_ausr_helm,    62)]|%; \
	/_echo | Amulett...: $[plinfo_format_str(info_ausr_amulett, 62)]|%; \
	/_echo | Ring......: $[plinfo_format_str(info_ausr_ring,    62)]|%; \
	/_echo | Handschuhe: $[plinfo_format_str(info_ausr_hands,   62)]|%; \
	/_echo | Umhang....: $[plinfo_format_str(info_ausr_umhang,  62)]|%; \
	/_echo | Ruestung..: $[plinfo_format_str(info_ausr_panzer,  62)]|%; \
	/_echo | Hosen.....: $[plinfo_format_str(info_ausr_hose,    62)]|%; \
	/_echo | Schuhe....: $[plinfo_format_str(info_ausr_schuhe,  62)]|%; \
	/_echo | Guertel...: $[plinfo_format_str(info_ausr_guertel, 62)]|%; \
	/_echo | Koecher...: $[plinfo_format_str(info_ausr_koecher, 62)]|%; \
	/_echo +-------------------------------------------------------------\
		--------------+%; \
	/_echo | Alter: $[plinfo_format_str(info_info_alter, 67)]|%; \
	/_echo +-------------------------------------------------------------\
		--------------+%; \
	/purge -mglob info_ausr_*%; \
	/purge -mglob info_info_*

/def plscore = \
	/def -p10000 -mregexp -q -ag -n1 -t'^Du ziehst das Scoreamulett an.$$|\
		^Du traegst das Scoreamulett bereits.$$|^Du musst das \
		Scoreamulett erst nehmen !$$|^Wie bitte.$$' \
		plscore_test = \
		/if ({2} =~ 'ziehst' | {2} =~ 'traegst') \
			!\\sscore%%; \
		/else \
			/plscore_info%%; \
		/endif%; \
	!\\trage scoreamulett

/def plscore_info = \
	/def -p10000 -mregexp -q -ag -n1 -t'^- (\\\\[Team .+\\\\] )?(.+) -*$$' \
		 info_s = /plscore_start%; \
	!\\info

/def plscore_start = \
	/set score_titel=%P2%; \
	/def -p10000 -mglob -q -ag -t'*' info_c = /plscore_collect %%*
	

/def plscore_collect = \
	/if ({*} =/ '------------------------------*') \
		/undef info_c%; \
		/plscore_ausgabe%; \
		/break%; \
	/endif%; \
	/if     ({*} =/ 'Gilde ........*') \
			/set score_gilde=%3%; \
			/set score_gilde_level=%6%; \
	/elseif ({*} =/ 'Erfahrung ...*') \
		/set score_exp=%3%; \
		/set score_align=%7%; \
	/elseif ({*} =/ 'Stufe ........*') \
		/if ({5} =~ 'Gewicht') \
			/set score_level=%3%; \
			/set score_plevel=%4%; \
		/else \
			/set score_level=%3%; \
			/set score_plevel=(%3)%; \
		/endif%; \
	/elseif ({*} =/ 'Rasse ...*') /set score_ap=%6%; \
	/elseif ({*} =/ 'Todesfolgen*') \
		/test regmatch('^Tode[^ ]+ (kein Malus|[0-9]+)( +Fluch[^"]+\
			"(.+)")?$$', {*})%; \
		/set score_tode=%P1%; \
		/set score_fl=%P3%; \
	/elseif ({*} =/ 'Gesundheit ..*') \
		/set score_lp=%3%; \
		/if ({5} =~ 'Gift') \
			/set score_maxlp=$[substr({4}, 1, -1)]%; \
			/set score_gift=%-6%; \
		/else \
			/set score_maxlp=%3%; \
			/set score_gift=%-5%; \
		/endif%; \
	/elseif ({*} =/ 'Konzentration ..*') \
		/set score_mp=%3%; \
		/if ({5} =~ 'Vorsicht') \
			/set score_maxmp=$[substr({4}, 1, -1)]%; \
		/else \
			/set score_maxmp=%3%; \
		/endif%; \
		/set score_vs=%L1%; \
		/if (score_vs =~ 'mutig') /set score_vs=0%; /endif%; \
	/elseif ({*} =/ 'Geschick*') \
		/test regmatch('^[^0-9]+(........)[^0-9]+(.+)$$', {*})%; \
		/set score_ges=%P1%; \
		/set score_kra=%P2%; \
	/elseif ({*} =/ 'Ausdauer ...*') \
		/test regmatch('^[^0-9]+(........)[^0-9]+(.+)$$', {*})%; \
		/set score_aus=%P1%; \
		/set score_int=%P2%; \
	/endif

/def plscore_ausgabe = \
	/let leveltext=%score_level %score_plevel%; \
	/let xpdiff=0%; \
	/let apdiff=0%; \
	/if (plscore_saved_exp !~ '') \
		/test xpdiff:=score_exp - plscore_saved_exp%; \
	/endif%; \
	/set plscore_saved_exp=%score_exp%; \
	/if (plscore_saved_ap !~ '') \
		/test apdiff:=score_ap - plscore_saved_ap%; \
	/endif%; \
	/set plscore_saved_ap=%score_ap%; \
	/if (xpdiff != 0) \
		/let xptext=%score_exp ($[xpdiff > 0 ? '+' : '']%xpdiff)%; \
	/else \
		/let xptext=%score_exp Punkte%; \
	/endif%; \
	/if (apdiff != 0) \
		/let aptext=%score_ap ($[apdiff > 0 ? '+' : '']%apdiff)%; \
	/else \
		/let aptext=%score_ap Punkte%; \
	/endif%; \
	/let lprel=$[trunc(score_lp * 49.0 / score_maxlp + 0.5)]%; \
	/let mprel=$[trunc(score_mp * 49.0 / score_maxmp + 0.5)]%; \
	/let vsrel=$[trunc(score_vs * 48.0 / score_maxlp + 0.5)]%; \
	/if (score_vs < 1) \
		/let lpbar=$[strrep('#', lprel)]%; \
	/else \
		/if (lprel >= vsrel + 1) \
			/let lpbar=$[strrep('#', vsrel)]*$[strrep('#', \
				lprel - vsrel - 1)]%; \
		/else \
			/let lpbar=%; \
			/test lpbar:=strcat(strrep('#', lprel), strrep(' ', \
				vsrel - lprel), ':')%; \
		/endif%; \
	/endif%; \
	/_echo +-------------------------------------------------------------\
		--------------+%; \
	/_echo | $[plinfo_format_str(score_titel, 74)]|%; \
	/_echo +-------------------------------------+-----------------------\
		--------------+%; \
	/_echo | Gilde: $[plinfo_format_str(score_gilde, 29)]\
		| Charakter: $[plinfo_format_str(score_align, 25)]|%; \
	/_echo +-------------------------------------+-----------------------\
		--------------+%; \
	/_echo | Spielerlevel.: $[plinfo_format_str(leveltext, 59)]|%; \
	/_echo | Gildenlevel..: $[plinfo_format_str(score_gilde_level, 59)]|%; \
	/_echo +-------------------------------------+-----------------------\
		--------------+%; \
	/_echo | Erfahrung: $[plinfo_format_str(xptext, 25)]| \
		Tode: $[plinfo_format_str(score_tode, 30)]|%; \
	/_echo | Abenteuer: $[plinfo_format_str(aptext, 25)]| \
		Gift: $[plinfo_format_str(score_gift, 30)]|%; \
	/_echo +-------------------------------------+-----------------------\
		--------------+%; \
	/_echo | Kraft...........: $[plinfo_format_str(score_kra, 18)]| \
		Geschicklichkeit: $[plinfo_format_str(score_ges, 18)]|%; \
	/_echo | Ausdauer........: $[plinfo_format_str(score_aus, 18)]| \
		Intelligenz.....: $[plinfo_format_str(score_int, 18)]|%; \
	/_echo +-------------------------------------+-----------------------\
		--------------+%; \
	/_echo | Vorsicht.....: $[pad(score_vs, 3)]/$[pad(score_maxlp-1, 3)]  \
		0%%         25%%         50%%         75%%       100%% |%; \
	/_echo | Gesundheit...: $[pad(score_lp, 3)]/$[pad(score_maxlp, 3)]  \
		$[plinfo_format_str(lpbar, 49)] |%; \
	/_echo | Konzentration: $[pad(score_mp, 3)]/$[pad(score_maxmp, 3)]  \
		$[plinfo_format_str(strrep('#', mprel), 49)] |%; \
	/_echo +-------------------------------------------------------------\
		--------------+%; \
	/if (score_fl !~ '') \
		/_echo Fluchtrichtung: %score_fl%; \
	/endif%; \
	/purge -mglob score_*

