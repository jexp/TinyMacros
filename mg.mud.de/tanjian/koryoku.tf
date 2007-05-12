; $Log: koryoku.tf,v $
; Revision 1.1  2002/09/09 14:07:11  thufhnik
; Uebernahme von Eldaron ins CVS
;

/set koryoku_tf_version=$Id: koryoku.tf,v 1.1 2002/09/09 14:07:11 thufhnik Exp $
/set koryoku_tf_author=Eldaron@MorgenGrauen
/set koryoku_tf_requires=break_string.tf
/set koryoku_tf_desc=Ausgabe von Koryoku schoener

;;---------------------------------------------------------------------------

;; ignore_inline wird benoetigt, um die Resistenzen mit @{} richtig umzubrechen
/set bs_ignore_inline=1


;;---------------------------------------------------------------------------
;; Hier gehts dann los:

/def koryoku = \
	/purge -mglob koryoku_*%;\
	/def -ag -q -mregexp -t" ist eine? (Lebewesen|untotes Wesen)\." \
		koryoku_target1 = \
			/set korytarget=%%PL%%;\
			/echo %%PL (NPC)%%;/koryokuother%;\
	/def -ag -q -mregexp -t" ist eine? (Spieler|Spielerin|Seher|Seherin|\
		Magier)\." koryoku_target2 = \
			/set korytarget=%%PL%%;\
			/echo %%PL (Interactive)%%;/koryokuother%;\
	/def -ag -mregexp -q -t'Du bist eine? (Spieler|Spielerin|Seher|\
		Seherin)\.' koryoku_self_state=/koryokuself%;\
;;----------------------------------------------------------------------------
;; Material
	/def -ag -mregexp -q -t'besteht aus *' koryoku_p_material = \
		/echo Material: %%PR%;\
;;----------------------------------------------------------------------------
;; Wenn keine ID meldung da ist, dann braucht man das auch nicht sehen
	/def -ag -mglob -t'Sonst kannst Du nichts besonderes an * erkennen.' \
		koryoku_lp_ok = /repeat -3 1 /purge -mglob koryoku_*%;\
;;----------------------------------------------------------------------------
;; P_INFO da
	/def -ag -mglob -t'Du erkennst besondere Eigenschaften an *' \
		koryoku_lp_ok2 = \
		/repeat -3 1 /purge -mglob koryoku_*%%;\
		/echo -p @{B}P_INFO:@{n}%;\
;;----------------------------------------------------------------------------
	/unset korytarget%;\
	/send koryoku %*


/def koryokuself = \
;;	/purge -mglob koryoku_*%;\
	/def -ag -msimple -q -t'Du gehoerst der Tanjian-Gilde an.' \
		koryoku_self_guild = /nop%;\
;;----------------------------------------------------------------------------
;; Wie Fit sind unsere Lps/Kps?
	/def -msimple -ag -q -t'Du fuehlst Dich absolut fit.' \
		koryoku_hitpoints_1 = /echo Lps: 100\%%;\
	/def -msimple -ag -q -t'Du fuehlst Dich gut.' \
		koryoku_hitpoints_2 = /echo Lps:  90\%%;\
	/def -msimple -ag -q -t'Du hast Dich schon mal besser gefuehlt.' \
		koryoku_hitpoints_3 = /echo Lps:  80\%%;\
	/def -msimple -ag -q -t'Du bist leicht angeschlagen.' \
		koryoku_hitpoints_4 = /echo Lps:  70\%%;\
	/def -msimple -ag -q -t'Du bist angeschlagen.' \
		koryoku_hitpoints_5 = /echo Lps:  60\%%;\
	/def -msimple -ag -q -t'Du fuehlst Dich ziemlich mitgenommen.' \
		koryoku_hitpoints_6 = /echo Lps:  50\%%;\
	/def -msimple -ag -q -t'Du fuehlst Dich gar nicht gut.' \
		koryoku_hitpoints_7 = /echo Lps:  40\%%;\
	/def -msimple -ag -q -t'Du bist in einer schlechten Verfassung.' \
		koryoku_hitpoints_8 = /echo Lps:  30\%%;\
	/def -msimple -ag -q -t'Du solltest dringend einen Arzt aufsuchen.' \
		koryoku_hitpoints_9 = /echo Lps:  20\%%;\
	/def -msimple -ag -q -t'Du bist fast tot.' \
		koryoku_hitpoints_10 = /echo Lps:  10\%%;\
;;----------------------------------------------------------------------------
	/def -msimple -ag -q -t'Deine geistigen Kraefte sind fast voll da.' \
		koryoku_magicpoints_1 = /echo Kps: 90\%%;\
	/def -msimple -ag -q -t'Deine geistigen Kraefte sind voll da.' \
		koryoku_magicpoints_2 = /echo Kps: 100\%%;\
	/def -msimple -ag -q -t'Du warst mental auch schon mal besser drauf.' \
		koryoku_magicpoints_3 = /echo Kps:  80\%%;\
	/def -msimple -ag -q -t'Du bist mental ein wenig erschoepft.' \
		koryoku_magicpoints_4 = /echo Kps:  70\%%;\
	/def -msimple -ag -q -t'Du bist mental erschoepft.' \
		koryoku_magicpoints_5 = /echo Kps:  60\%%;\
	/def -msimple -ag -q -t'Du leidest unter geistiger Mattheit.' \
		koryoku_magicpoints_6 = /echo Kps:  50\%%;\
	/def -msimple -ag -q -t'Du bist mental ziemlich ausgelaugt.' \
		koryoku_magicpoints_7 = /echo Kps:  40\%%;\
	/def -msimple -ag -q -t'Deine geistigen Kraefte gehen dem Ende zu.' \
		koryoku_magicpoints_8 = /echo Kps:  30\%%;\
	/def -msimple -ag -q -t'Deine geistigen Kraefte sind fast am Ende.' \
		koryoku_magicpoints_9 = /echo Kps:  20\%%;\
	/def -msimple -ag -q -t'Deine geistigen Kraefte sind am Ende.' \
		koryoku_magicpoints_10 = /echo Kps:  10\%%;\
;;----------------------------------------------------------------------------
;;Koryoku auf sich selbst: Saettigung
	/def -msimple -ag -q -t'Dein Magen knurrt vernehmlich.' \
		koryoku_food_1 = /test echo(" 0% < Food  <  5% ")%;\
	/def -msimple -ag -q -t'Gelegentlich knurrt Dein Magen.' \
		koryoku_food_2 = /test echo(" 5% < Food  < 25% ")%;\
	/def -msimple -ag -q -t'Du koenntest mal wieder etwas essen.' \
		koryoku_food_3 = /echo 25% < Food  < 45\%%;\
	/def -msimple -ag -q -t'Du bist einigermassen gesaettigt.' \
		koryoku_food_4 = /echo 45% < Food  < 65\%%;\
	/def -msimple -ag -q -t'Dein Magen ist gut gefuellt.' \
		koryoku_food_5 = /echo 65% < Food  < 75\%%;\
	/def -msimple -ag -q -t'Du bist kaum noch dazu in der Lage, etwas \
		zu essen.' koryoku_food_6 = /echo 75% < Food  < 95\%%;\
	/def -msimple -ag -q -t'Du bist voll wie ein Mastschwein.' \
		koryoku_food_7 = /echo 95% < Food  < 100\%%;\
;;----------------------------------------------------------------------------
;;Koryoku auf sich selbst: Durst
	/def -msimple -ag -q -t'Du verdurstest bald.' koryoku_drink_1 = \
		/test echo(" 0% < Drink <  5% ")%;\
	/def -msimple -ag -q -t'Du hast einen ordentlichen Durst.' \
		koryoku_drink_2 = /test echo(" 5% < Drink < 25% ")%;\
	/def -msimple -ag -q -t'Du koenntest mal wieder etwas trinken.' \
		koryoku_drink_3 = /echo 25% < Drink < 45\%%;\
	/def -msimple -ag -q -t'Du hast derzeit keinen Durst.' \
		koryoku_drink_4 = /echo 45% < Drink < 65\%%;\
	/def -msimple -ag -q -t'Das Wasser schwappt in Deinem Magen.' \
		koryoku_drink_5 = /echo 65% < Drink < 75\%%;\
	/def -msimple -ag -q -t'Du hast den reinsten Wasserbauch.' \
		koryoku_drink_6 = /echo 75% < Drink < 95\%%;\
	/def -msimple -ag -q -t'Wenn Du noch mehr trinkst, platzt Du.' \
		koryoku_drink_7 = /echo 95% < Drink < 100\%%;\
;;----------------------------------------------------------------------------
;;Koryoku auf sich selbst: Alkohol
	/def -msimple -ag -q -t'Du bist absolut nuechtern.' \
		koryoku_alc_1 = /test echo(" 0% <  Alc  <  5% ")%;\
	/def -msimple -ag -q -t'Du bist fast nuechtern.' koryoku_alc_2 = \
		 /test echo(" 5% <  Alc  < 25% ")%;\
	/def -msimple -ag -q -t'Du bist angeheitert.' koryoku_alc_3 = \
		/echo 25% <  Alc  < 45\%%;\
	/def -msimple -ag -q -t'Du hast einen ordentlichen Schwips.' \
		koryoku_alc_4 = /echo 45% <  Alc  < 65\%%;\
	/koryokuresistenzen%;\
	/koryokualign


;;############################################################################
;;############################################################################

/def koryokuother = \
;;----------------------------------------------------------------------------
;; Wir wollen doch wissen, wieviele Lps der Gegner hat.
	/def -mglob -ag -t"Du bist * unendlich ueberlegen." koryoku_hp_1 = \
		/echo %%korytarget hat zwischen 1 und $$[p_lp / 11] Lps.%;\
	/def -mglob -ag -t"Du kannst * problemlos zermalmen."i koryoku_hp_2 = \
		/echo %%korytarget hat zwischen $$[p_lp / 11] und \
			$$[p_lp / 8] Lps.%;\
	/def -mglob -ag -t"* ist kein wuerdiger Gegner fuer Dich." \
		koryoku_hp_3 = /echo %%korytarget hat zwischen $$[p_lp / 8] \
			und $$[p_lp / 5] Lps.%;\
	/def -mglob -ag -t"Du bist * hoffnungslos ueberlegen." koryoku_hp_4 = \
		/echo %%korytarget hat zwischen $$[p_lp / 5] und \
			$$[p_lp / 4] Lps.%;\
	/def -mglob -ag -t"Du bist * haushoch ueberlegen." koryoku_hp_5 = \
		/echo %%korytarget hat zwischen $$[p_lp / 4] und \
			$$[p_lp / 3] Lps.%;\
	/def -mglob -ag -t"Du bist sehr viel staerker als *." koryoku_hp_6 = \
		/echo %%korytarget hat zwischen $$[p_lp / 3] und \
			$$[p_lp / 5 * 2] Lps.%;\
	/def -mglob -ag -t"Du bist viel staerker als *." koryoku_hp_7 = \
		/echo %%korytarget hat zwischen $$[p_lp / 5 * 2] und \
			$$[p_lp / 2] Lps.%;\
	/def -mglob -ag -t"Du bist staerker als *." koryoku_hp_8 = \
		/echo %%korytarget hat zwischen $$[p_lp / 2] und \
			$$[p_lp / 4 * 3] Lps.%;\
	/def -mglob -ag -t"Du bist etwas staerker als *" koryoku_hp_9 = \
		/echo %%korytarget hat zwischen $$[p_lp / 4 * 3] und \
			$$[p_lp / 6 * 5] Lps.%;\
	/def -mglob -ag -t"* ist genauso stark wie Du."	koryoku_hp_10 = \
		/echo %%korytarget hat genau $$[p_lp] Lps.%;\
	/def -mglob -ag -t"* ist etwa gleich stark wie Du." koryoku_hp_11 = \
		/echo %%korytarget hat zwischen $$[p_lp / 6 * 5] und \
			$$[p_lp / 6 * 7 ] Lps.%;\
	/def -mglob -ag -t"* ist etwas staerker als Du." koryoku_hp_12 = \
		/echo %%korytarget hat zwischen $$[p_lp / 8 * 9] und \
			$$[p_lp / 3 * 4 ] Lps.%;\
	/def -mglob -ag -t"* ist staerker als Du." koryoku_hp_13 = \
		/echo %%korytarget hat zwischen $$[p_lp / 3 * 4] und \
			$$[p_lp *2 ] Lps.%;\
	/def -mglob -ag -t"* ist viel staerker als Du."	koryoku_hp_14 = \
		/echo %%korytarget hat zwischen $$[p_lp * 2] und \
			$$[p_lp /2 * 5] Lps.%;\
	/def -mglob -ag -t"* ist sehr viel staerker als Du." koryoku_hp_15 = \
		/echo %%korytarget hat zwischen $$[p_lp /2 *5] und \
			$$[p_lp * 3] Lps.%;\
	/def -mglob -ag -t"* ist Dir haushoch ueberlegen." koryoku_hp_16 = \
		/echo %%korytarget hat zwischen $$[p_lp * 3] und \
			$$[p_lp * 4] Lps.%;\
	/def -mglob -ag -t"* ist Dir hoffnungslos ueberlegen." koryoku_hp_17 = \
		/echo %%korytarget hat zwischen $$[p_lp * 4] und \
			$$[p_lp * 5] Lps.%;\
	/def -mglob -ag -t"*? Renn um Dein Leben!" koryoku_hp_18 = \
		/echo %%korytarget hat zwischen $$[p_lp * 5] und \
			$$[p_lp * 8] Lps.%;\
	/def -mglob -ag -t"* kann Dich problemlos zermalmen." koryoku_hp_19 = \
		/echo %%korytarget hat zwischen $$[p_lp * 8] und \
			$$[p_lp * 11] Lps.%;\
	/def -mglob -ag -t"* ist Dir unendlich ueberlegen." koryoku_hp_20 = \
		/echo %%korytarget hat mehr als $$[p_lp * 11] Lps.%;\
;;----------------------------------------------------------------------------
;; Body verglichen mit Caster
	/def -mglob -ag -q -t'Du sollst doch nicht ohne Ruestung kaempfen!*' \
		koryoku_ruestung_1 = /test koryokuhook('Body ','(+8)','%%*')%;\
	/def -mglob -ag -q -t'Hast Du vergessen, Deine Ruestung anzuziehen?*' \
		koryoku_ruestung_2 = \
		/test koryokuhook('Body ','(+7)','$$[esc_special({*})]')%;\
	/def -mglob -ag -q -t'Die Ruestung * ist unerhoert viel besser als \
		Deine.*' koryoku_ruestung_3 = \
		/test koryokuhook('Body ','(+6)','$$[esc_special({*})]')%;\
	/def -mglob -ag -q -t'Die Ruestung * ist unglaublich viel besser als \
		Deine.*' koryoku_ruestung_4 = \
		/test koryokuhook('Body ','(+5)','$$[esc_special({*})]')%;\
	/def -mglob -ag -q -t'Die Ruestung * ist sehr viel besser als \
		Deine.*' koryoku_ruestung_5 = \
		/test koryokuhook('Body ','(+4)','$$[esc_special({*})]')%;\
	/def -mglob -ag -q -t'Die Ruestung * ist viel besser als Deine.*' \
		koryoku_ruestung_6 = \
		/test koryokuhook('Body ','(+3)','$$[esc_special({*})]')%;\
	/def -mglob -ag -q -t'Die Ruestung * ist besser als Deine.*' \
		koryoku_ruestung_7 = \
		/test koryokuhook('Body ','(+2)','$$[esc_special({*})]')%;\
	/def -mglob -ag -q -t'Die Ruestung * ist etwas besser als Deine.*' \
		koryoku_ruestung_8 = \
		/test koryokuhook('Body ','(+1)','$$[esc_special({*})]')%;\
	/def -mglob -ag -q -t'Eure Ruestungen sind etwa gleich gut.*' \
		koryoku_ruestung_9 = \
		/test koryokuhook('Body ','(~0)','%%*')%;\
	/def -mglob -ag -q -t'* Rustung ist genauso gut wie Deine.*' \
		koryoku_ruestung_10 = \
		/test koryokuhook('Body ','( 0)','%%*')%;\
	/def -mglob -ag -q -t'Deine Ruestung ist etwas besser als die *.*' \
		koryoku_ruestung_11 = \
		/test koryokuhook('Body ','(-1)','$$[esc_special({*})]')%;\
	/def -mglob -ag -q -t'Deine Ruestung ist besser als die *.*' \
		koryoku_ruestung_12 = \
		/test koryokuhook('Body ','(-2)','$$[esc_special({*})]')%;\
	/def -mglob -ag -q -t'Deine Ruestung ist viel besser als die *.*' \
		koryoku_ruestung_13 = \
		/test koryokuhook('Body ','(-3)','$$[esc_special({*})]')%;\
	/def -mglob -ag -q -t'Deine Ruestung ist sehr viel besser als die *.*' \
		koryoku_ruestung_14 = \
		/test koryokuhook('Body ','(-4)','$$[esc_special({*})]')%;\
	/def -mglob -ag -q -t'Deine Ruestung ist unglaublich viel besser \
		als die *.*' koryoku_ruestung_15 = \
		/test koryokuhook('Body ','(-5)','$$[esc_special({*})]')%;\
	/def -mglob -ag -q -t'Deine Ruestung ist unerhoert viel besser als \
		die *.*' koryoku_ruestung_16 = \
		/test koryokuhook('Body ','(-6)','$$[esc_special({*})]')%;\
	/def -mglob -ag -q -t'Was * da hat, kann man gar nicht Ruestung \
		nennen.*' koryoku_ruestung_17 = \
		/test koryokuhook('Body ','(-7)','%%*')%;\
	/def -mglob -ag -q -t'Erklaere * doch mal, dass Luft keine gute \
		Ruestung ist.*' koryoku_ruestung_18 = \
		/test koryokuhook('Body ','(-8)','%%*')%;\
;;----------------------------------------------------------------------------
;; Waffe relativ zum Caster
	/def -mglob -ag -q -t'Vielleicht solltest Du doch besser eine Waffe \
		zuecken?*' koryoku_waffe_1 = /koryokuhook Waffe (+8) %%*%;\
	/def -mglob -ag -q -t'* Waffe laesst Deine ganz mickrig aussehen.*' \
		koryoku_waffe_2 = \
		/koryokuhook Waffe (+7) $$[esc_special({*})]%;\
	/def -mglob -ag -q -t'* Waffe ist Deiner haushoch ueberlegen.*' \
		koryoku_waffe_3 = \
		/koryokuhook Waffe (+6) $$[esc_special({*})]%;\
	/def -mglob -ag -q -t'* Waffe ist Deiner weit ueberlegen.*' \
		koryoku_waffe_4 = \
		/koryokuhook Waffe (+5) $$[esc_special({*})]%;\
	/def -mglob -ag -q -t'* Waffe ist sehr viel besser als Deine.*' \
		koryoku_waffe_5 = \
		/koryokuhook Waffe (+4) $$[esc_special({*})]%;\
	/def -mglob -ag -q -t'* Waffe ist viel besser als Deine.*' \
		koryoku_waffe_6 = \
		/koryokuhook Waffe (+3) $$[esc_special({*})]%;\
	/def -mglob -ag -q -t'* Waffe ist besser als Deine.*' \
		koryoku_waffe_7 = \
		/koryokuhook Waffe (+3) $$[esc_special({*})]%;\
	/def -mglob -ag -q -t'* Waffe ist etwas besser als Deine.*' \
		koryoku_waffe_8 = \
		/koryokuhook Waffe (+1) $$[esc_special({*})]%;\
	/def -mglob -ag -q -t'Eure Waffen sind etwa gleich gut.*' \
		koryoku_waffe_9 = \
		/koryokuhook Waffe (-0) %%*%;\
	/def -mglob -ag -q -t'* Waffe ist genauso gut wie Deine.*' \
		koryoku_waffe_10 = \
		/koryokuhook Waffe (~0) $$[esc_special({*})]%;\
	/def -mglob -ag -q -t'Deine Waffe ist etwas besser als die *.*' \
		koryoku_waffe_11 = \
		/koryokuhook Waffe (-1) $$[esc_special({*})]%;\
	/def -mglob -ag -q -t'Deine Waffe ist besser als die *.*' \
		koryoku_waffe_12 = \
		/koryokuhook Waffe (-2) $$[esc_special({*})]%;\
	/def -mglob -ag -q -t'Deine Waffe ist viel besser als die *.*' \
		koryoku_waffe_13 = \
		/koryokuhook Waffe (-3) $$[esc_special({*})]%;\
	/def -mglob -ag -q -t'Deine Waffe ist sehr viel besser als die *.*' \
		koryoku_waffe_14 = \
		/koryokuhook Waffe (-4) $$[esc_special({*})]%;\
	/def -mglob -ag -q -t'Deine Waffe ist der von * weit ueberlegen.*' \
		koryoku_waffe_15 = /koryokuhook Waffe (-5) %%*%;\
	/def -mglob -ag -q -t'Deine Waffe ist der von * haushoch ueberlegen.*' \
		koryoku_waffe_16 = /koryokuhook Waffe (-6) %%*%;\
	/def -mglob -ag -q -t'Deine Waffe ist eigentlich zu gut fuer diesen \
		Gegner.*' koryoku_waffe_17 = /koryokuhook Waffe (-7) %%*%;\
	/def -mglob -ag -q -t'Frag * mal, ob * nicht lieber mit einer Waffe \
		kaempfen wuerde.*' koryoku_waffe_18 = \
		/koryokuhook Waffe (-8) %%*%;\
;;----------------------------------------------------------------------------
;; Gilde? (fehlen noch einige)
	/def -ag -mglob -t"* gehoert den Elementar-Beschwoerern an." \
		koryoku_guild_1 = /echo Gilde=Elementare%;\
	/def -ag -mglob -t"* gehoert der Abenteurer-Gilde an." \
		koryoku_guild_2 = /echo Gilde=Abenteurer%;\
	/def -ag -mglob -t"* gehoert der Akademie der geistigen Kraft an." \
		koryoku_guild_3 = /echo Gilde=Zauberer%;\
	/def -ag -mglob -t"* gehoert den Bierschuettlern an." \
		koryoku_guild_4 = /echo Gilde=Bierschuettler%;\
	/def -ag -mglob -t"* gehoert den Klerikern an." koryoku_guild_5 = \
		/echo Gilde=Klerus%;\
	/def -ag -mglob -t"* gehoert der Kaempfer-Gilde an." koryoku_guild_6 = \
		/echo Gilde=Kaempfer%;\
	/def -ag -mglob -t"* gehoert der Karate-Gilde an." koryoku_guild_7 = \
		/echo Gilde=Karate%;\
;;----------------------------------------------------------------------------
; modifiziertes SA_X?
	/def -ag -p1 -mregexp -q -t'scheint von Natur aus *' koryoku_sa_x = \
         	/set speicher=%%PR%%; \
         	/if (substr(speicher, -1 , 1) =~ '.') /sa_x_ausgabe%%; \
         	/else \
         	        /def -ag -p1 -mglob -q -t'*' sa_x_collect = \
         	                /set speicher=%%%speicher %%%*%%%; \
         	                /if (substr(speicher, -1 , 1) =~ '.') \
         	                        /undef sa_x_collect%%%; \
         	                        /sa_x_ausgabe%%%; \
         	                /endif%%;\
		/endif%;\
	/koryokuresistenzen%;\
	/koryokualign



;;############################################################################
;;############################################################################

/def koryokuhook = \
	/if ({*}=/'*. *') /set kory_hook=(Tmp_Hook)%;\
		/def -mglob -ag -q -t'*beeinflusst zu sein.' \
			koryoku_gag_hook = /purge koryoku_gag_hook%;\
	/endif%;\
	/echo %1 %2 %kory_hook%;\
	/unset kory_hook


;;----------------------------------------------------------------------------
;; Spellsuccess reicht fuer Resistenzen
/def koryokuresistenzen = \
	/purge -mglob koryoku_resis_*%;\
	/def -mregexp -ag -t"(Er|Sie|Es|Du) has?t weder besonders \
		verwundbaren? Stellen noch besondere Resistenzen\." \
		koryoku_resis_no = \
		/echo -p @{u}Keine Resistenzen/Anfaelligkeiten@{n}%;\
	/def -ag -p1 -mregexp -q -t'(Er|Sie|Es|Du) b?ist (etwas|besonders) \
		(resistent|anfaellig) gegen: *' koryoku_resis_yes = \
         	/set speicher=%%-5%%;\
	 	/set strength=%%P2%%;\
	 	/set resisvalue=%%P3%%;\
         	/if (substr(speicher, -1 , 1) =~ '.') /resi_ausgabe%%;\
         	/else \
         	        /def -ag -p1 -mglob -q -t'*' resi_collect = \
         	                /set speicher=%%%speicher %%%*%%%;\
         	                /if (substr(speicher, -1 , 1) =~ '.') \
         	                        /undef resi_collect%%%;\
         	                        /resi_ausgabe%%%;\
         	                /endif%%;\
		/endif%;\


;;############################################################################
;;############################################################################

;; Align
/def koryokualign = \
	/def -mglob -ag -q -t'* {bist|ist} absolut satanisch.' \
		koryoku_align_1 = /echo Align (-8)%;\
	/def -mglob -ag -q -t'* {bist|ist} satanisch.' \
		koryoku_align_2 = /echo Align (-7)%;\
	/def -mglob -ag -q -t'* {bist|ist} fast schon satanisch.' \
		koryoku_align_3 = /echo Align (-6)%;\
	/def -mglob -ag -q -t'* {bist|ist} sehr boese.' \
		koryoku_align_4 = /echo Align (-5)%;\
	/def -mglob -ag -q -t'* {bist|ist} boese.' \
		koryoku_align_5 = /echo Align (-4)%;\
	/def -mglob -ag -q -t'* {bist|ist} sehr frech.' \
		koryoku_align_6 = /echo Align (-3)%;\
	/def -mglob -ag -q -t'* {bist|ist} frech.' \
		koryoku_align_7 = /echo Align (-2)%;\
	/def -mglob -ag -q -t'* {bist|ist} ein wenig frech.' \
		koryoku_align_8 = /echo Align (-1)%;\
	/def -mglob -ag -q -t'* {bist|ist} neutral.' \
		koryoku_align_9 = /echo Align ( 0)%;\
	/def -mglob -ag -q -t'* {bist|ist} ab und zu nett.' \
		koryoku_align_10 = /echo Align (+1)%;\
	/def -mglob -ag -q -t'* {bist|ist} nett.' \
		koryoku_align_11 = /echo Align (+2)%;\
	/def -mglob -ag -q -t'* {bist|ist} sehr nett.' \
		koryoku_align_12 = /echo Align (+3)%;\
	/def -mglob -ag -q -t'* {bist|ist} gut.' \
		koryoku_align_13 = /echo Align (+4)%;\
	/def -mglob -ag -q -t'* {bist|ist} sehr gut.' \
		koryoku_align_14 = /echo Align (+5)%;\
	/def -mglob -ag -q -t'* {bist|ist} fast schon heilig.' \
		koryoku_align_15 = /echo Align (+6)%;\
	/def -mglob -ag -q -t'* {bist|ist} heilig.' \
		koryoku_align_16 = /echo Align (+7)%;\
	/def -mglob -ag -q -t'* {bist|ist} absolut heilig.' \
		koryoku_align_17 = /echo Align (+8)


;;############################################################################
;;############################################################################
;; Ausgabe-Makros:
;;----------------------------------------------------------------------------
/def resi_ausgabe = \
  /set bs_size=78%;\
  /set bs_attr=-p%;\
  /set bs_cmd=%;\
  /test set('bs_indent=$[replace('resistent','@{Cred}Resis', \
	                 replace('anfaellig','@{Cgreen}Empf ', \
		                  {resisvalue}))] \
	               $[replace('etwas','(-)@{n}',replace('besonders',\
			         '(+)@{n}',{strength}))] : ')%;\
  /break_string $[replace('Saeureschaden', '@{Cgreen}Saeure@{n}',\
     	    replace('magischen Schaden','@{Cwhite}Magie@{n}',\
	    replace('Schlagschaden','@{u}Schlaege@{n}',\
	    replace('Schnittschaden','@{u}Schnitte@{n}',\
	    replace('Stichschaden','@{u}Stiche@{n}',\
	    replace('Peitschenschaden','@{u}Peitschen@{n}',\
	    replace('Quetsch-Schaden','@{u}Quetschen@{n}',\
	    replace('reissenden Schaden','@{u}Reissen@{n}',\
	    replace('Explosionsschaden','@{u}Explosion@{n}',\
	    replace('Blitzschaden','@{Cyellow}Blitz@{n}',\
	    replace('Feuerschaden','@{Cred}Feuer@{n}',\
	    replace('Kaelteschaden','@{Cblue}Eis@{n}',\
	    replace('Laermschaden','@{f}Laerm@{n}',\
	    replace('Wasserschaden','@{Ccyan}Wasser@{n}',\
	    replace('Giftschaden','@{Cgreen}Gift@{n}',\
	    replace('furchteinfloessenden Schaden','@{n}Terror@{n}',\
	    replace('Luft(mangel)schaden','@{Cwhite}Wind@{n}',\
	    replace(' und',',',\
	    substr(speicher, 0, -1)))))))))))))))))))]%;\
           /unset speicher%;\
	   /unset strength%;\
	   /unset resisvalue
;;----------------------------------------------------------------------------
/def sa_x_ausgabe = \
	/if ({speicher} =/ '*relativ schnell*') \
		/echo Increased Speed!%;\
	/endif%;\
	/if ({speicher} =/ '*generell bevorzugt*') \
		/echo Increased Quality!%;\
	/endif%;\
	/if ({speicher} =/ '*gefaehrlich*') \
		/echo Increased Damage!%;\
	/endif%;\
	/unset speicher
;;----------------------------------------------------------------------------

;;Er gehoert der Tanjian-Gilde an und ist ein Mitglied des ehrwuerdigen Clans
;;der 'Okami'.

