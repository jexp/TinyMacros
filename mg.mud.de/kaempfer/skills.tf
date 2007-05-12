; $Log: skills.tf,v $
; Revision 1.6  2004/03/14 07:55:22  thufhnik
; man sollte das auch komplett machen... :(
;
; Revision 1.5  2004/03/14 07:46:40  thufhnik
; "praktisch ueberhaupt nicht" in die %-umrechnung eingebaut
;
; Revision 1.4  2003/03/22 15:53:56  thufhnik
; %-Zeichen in Umgebrochenen Kampfbrotmeldungen
;
; Revision 1.3  2003/03/22 15:47:38  thufhnik
; Bugfix im Kampfbrot
;
; Revision 1.2  2002/11/06 14:58:52  thufhnik
; Bereinigungen
; Kampfbrot? (Bitte testen!)
;
; Revision 1.1  2002/06/13 09:41:01  thufhnik
; Scratch
;

/set skills_tf_version $Id: skills.tf,v 1.6 2004/03/14 07:55:22 thufhnik Exp $
/set skills_tf_author=Thufhir@mg.mud.de
/set skills_tf_requires=
/set skills_tf_desc Skills der Trves in %


; Konfigurierbares

/set_var CFG_MG_KAEMPFER_SKILLS_ECHO_ATTR Ccyan


; die eigentlichen Macros

/def skills = \
	/if (regmatch('(weit entfernt von |noch laengst nicht |bald schon |\
	    fast |)(absolut superuebel|superuebel|sehr sehr uebel|sehr uebel|\
	    uebel|sehr sehr schlecht|sehr schlecht|schlecht|maessig|\
	    durchschnittlich|befriedigend|sehr befriedigend|recht gut|\
	    ganz gut|gut|sehr gut|ausgezeichnet|hervorragend|perfekt|\
	    absolut perfekt|praktisch ueberhaupt nicht)', {*})) \
		/if ({P1} =~ 'weit entfernt von ') /let ks_abzug=4%; \
		/elseif ({P1} =~ 'noch laengst nicht ') /let ks_abzug=3%; \
		/elseif ({P1} =~ 'bald schon ') /let ks_abzug=2%; \
		/elseif ({P1} =~ 'fast ') /let ks_abzug=1%; \
		/else /let ks_abzug=0%;\
		/endif%;\
		/if ({P2} =~ 'praktisch ueberhaupt nicht') /let ks_base=0%;\
		/elseif ({P2} =~ 'absolut superuebel') /let ks_base=5%;\
		/elseif ({P2} =~ 'superuebel') /let ks_base=10%;\
		/elseif ({P2} =~ 'sehr sehr uebel') /let ks_base=15%;\
		/elseif ({P2} =~ 'sehr uebel') /let ks_base=20%;\
		/elseif ({P2} =~ 'uebel') /let ks_base=25%;\
		/elseif ({P2} =~ 'sehr sehr schlecht') /let ks_base=30%;\
		/elseif ({P2} =~ 'sehr schlecht') /let ks_base=35%;\
		/elseif ({P2} =~ 'schlecht') /let ks_base=40%;\
		/elseif ({P2} =~ 'maessig') /let ks_base=45%;\
		/elseif ({P2} =~ 'durchschnittlich') /let ks_base=50%;\
		/elseif ({P2} =~ 'befriedigend') /let ks_base=55%;\
		/elseif ({P2} =~ 'sehr befriedigend') /let ks_base=60%;\
		/elseif ({P2} =~ 'recht gut') /let ks_base=65%;\
		/elseif ({P2} =~ 'ganz gut') /let ks_base=70%;\
		/elseif ({P2} =~ 'gut') /let ks_base=75%;\
		/elseif ({P2} =~ 'sehr gut') /let ks_base=80%;\
		/elseif ({P2} =~ 'ausgezeichnet') /let ks_base=85%;\
		/elseif ({P2} =~ 'hervorragend') /let ks_base=90%;\
		/elseif ({P2} =~ 'perfekt') /let ks_base=95%;\
		/elseif ({P2} =~ 'absolut perfekt') /let ks_base=100%;\
		/else /let ks_base=0%;\
		/endif%; \
		/return $[ks_base-ks_abzug]%;\
	/else \
		/return "???"%;\
	/endif

/def -p0 -msimple -q -t'Du schaetzt Deine Faehigkeiten als Kaempfer ein:' \
	skills_schaetzen = \
	/def -1 -p0 -mglob -q -t'{Der|Du|Deine} *.' skills_kill = \
		/purge skills_list%;\
	/def -p0 -mregexp -agCblue -q -t'^   ([A-Z].+) : ([a-z ]+)$$' \
		skills_list = \
		/echo -a%%CFG_MG_KAEMPFER_SKILLS_ECHO_ATTR $$[pad({P0},-70, \
			"(",1, skills({P2}),3,"\%)",2)]

/def -p0 -mglob -q -t'{Er|Sie} ist so ein komischer Kleriker. Du erkennst nur, \
	dass {er|sie} den Umgang mit' skills_kleri = \
	/def -1 -p0 -mregexp -agCblue -t'^stumpfen Hiebwaffen ([a-z ]+) \
		beherrscht\\\\.' skills_kleri_out = \
		/echo -p %%P0 @{%%CFG_MG_KAEMPFER_SKILLS_ECHO_ATTR}\
			$$[strcat("(",skills({P1}),"\%)")]@{n}

/def -p0 -msimple -t'Krieger dieses Brot richtig fuehren und es gehoerte \
	eine Menge Uebung dazu.' skills_kampfbrot = \
	/def -1 -p0 -mregexp -agCblue -q -t'^Du beherrschs?t den Umgang mit \
		dem Kampfbrot ([a-z ]+)(!)?$$' skills_kampfbrot_1 = \
		/if ({P2}=~'!') \
			/echo -p -- %%P0 @{%%CFG_MG_KAEMPFER_SKILLS_ECHO_ATTR}\
				$$[strcat("(",skills({P1}),"\%)")]@{n}%%;\
		/else \
			/echo -- %%P0%%;\
			/def -1 -p0 -agCblue -mregexp -q -t'^(.+)!$$$' \
				skills_kampfbrot_2 = \
				/let skills_tmp=%%P1 %%%P1%%%;\
				/echo -p -- %%%P0 \
					@{%%%CFG_MG_KAEMPFER_SKILLS_ECHO_ATTR}\
					$$$[strcat("(",skills(skills_tmp),\
					"\\\%)")]@{n}%%;\
		/endif
