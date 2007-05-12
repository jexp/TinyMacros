; $Log: schaetz.tf,v $
; Revision 1.6  2004/09/05 09:48:11  thufhnik
; erste Version der Kampfstockskills, ist aber gildenseitig noch
; verbesserungswuerdig, so dass bald eine neue Version zu erwarten ist
;
; Revision 1.5  2004/03/14 10:16:50  thufhnik
; Ausgabe der Waffenskills formatiert
;
; Revision 1.4  2004/03/14 10:00:29  thufhnik
; hoffentlich alle Meldungen zu den Waffenskills
;
; Revision 1.3  2004/03/14 08:29:33  thufhnik
; Angefangen die nowmalen Waffenskills einzubauen
;
; Revision 1.2  2002/09/09 12:05:40  thufhnik
; Log
;

/set schaetz_tf_version=$Id: schaetz.tf,v 1.6 2004/09/05 09:48:11 thufhnik Exp $
/set schaetz_tf_author=Eldaron@MorgenGrauen
/set schaetz_tf_requires=break_string.tf
/set schaetz_tf_desc=Schaetzen der Kaempfer schoener

;;; Skillangaben dem geschaetzen direkt mitteilen?

/set_var schaetz_tm_skills 0

;;; Das leidige Problem mit Inline Formatierungen beim Break_string

/set bs_ignore_inline=1


;;; Paket vollstaendig entfernbar

/def remove_schaetz = \
	/unset target%;\
	/unset speicher%;\
	/purge trves_schaetz%;\
	/purge schaetz_ausgabe


;; Erstmal das ganze Schaetz in einen String sammeln.

/def -ag -p1 -mregexp -q -t' (ist absolut fit|ist leicht geschwaecht|fuehlte \
	sich auch schon besser|ist leicht angekratzt|ist nicht mehr \
	taufrisch|sieht recht mitgenommen aus|wankt bereits bedenklich|ist \
	in keiner guten Verfassung|braucht dringend einen Arzt|steht auf \
	der Schwelle des Todes) und ist damit *' trves_schaetz = \
         	/set speicher=%-1%; \
		/set target=%PL%;\
       	        /def -ag -p1 -mglob -q -t'*' schaetz_collect = \
         	                /set speicher=%%speicher %%*%%; \
         	                /if (substr(speicher, -6 , 6) =~ 'gross.') \
         	                        /undef schaetz_collect%%; \
         	                        /schaetz_ausgabe%%; \
         			/endif
	         
;; Und dann natuerlich schoener ausgeben.
/def schaetz_ausgabe = \
;;----------------------------------------------------------------------------
;;  Lps in %
	/if ({speicher}=/'*ist absolut fit und ist damit*') \
		/set schaetz_abs=10%;\
	/elseif ({speicher}=/'*ist leicht geschwaecht und ist damit *') \
		/set schaetz_abs= 9%;\
	/elseif ({speicher}=/'*fuehlte sich auch schon besser und ist damit*') \
		/set schaetz_abs= 8%;\
	/elseif ({speicher}=/'*ist leicht angekratzt und ist damit*') \
		/set schaetz_abs= 7%;\
	/elseif ({speicher}=/'*ist nicht mehr taufrisch und ist damit*') \
		/set schaetz_abs= 6%;\
	/elseif ({speicher}=/'*sieht recht mitgenommen aus und ist damit*') \
		/set schaetz_abs= 5%;\
	/elseif ({speicher}=/'*wankt bereits bedenklich und ist damit*') \
		/set schaetz_abs= 4%;\
	/elseif ({speicher}=/'*ist in keiner guten Verfassung und ist damit*') \
		/set schaetz_abs= 3%;\
	/elseif ({speicher}=/'*braucht dringend einen Arzt und ist damit*') \
		/set schaetz_abs= 2%;\
	/elseif ({speicher}=/'*steht auf der Schwelle des Todes und ist damit*') \
		/set schaetz_abs= 1%;\
	/endif%;\
;;----------------------------------------------------------------------------
;; Lps relativ zum Caster
	/if ({speicher}=/'*und ist damit absolut, unglaublich schwaecher als Du.*') \
		/set schaetz_rel_min=0%;\
		/set schaetz_rel_max=$[p_lp-199]%;\
	/elseif ({speicher}=/'*und ist damit unglaublich schwaecher als Du.*') \
		/set schaetz_rel_min=$[p_lp-199]%;\
		/set schaetz_rel_max=$[p_lp-150]%;\
	/elseif ({speicher}=/'*und ist damit sehr viel schwaecher als Du.*') \
		/set schaetz_rel_min=$[p_lp-149]%;\
		/set schaetz_rel_max=$[p_lp-110]%;\
	/elseif ({speicher}=/'*und ist damit viel schwaecher als Du.*') \
		/set schaetz_rel_min=$[p_lp-109]%;\
		/set schaetz_rel_max=$[p_lp-80]%;\
	/elseif ({speicher}=/'*und ist damit deutlich schwaecher als Du.*') \
		/set schaetz_rel_min=$[p_lp-79]%;\
		/set schaetz_rel_max=$[p_lp-50]%;\
	/elseif ({speicher}=/'*und ist damit schwaecher als Du.*') \
		/set schaetz_rel_min=$[p_lp-49]%;\
		/set schaetz_rel_max=$[p_lp-30]%;\
	/elseif ({speicher}=/'*und ist damit etwas schwaecher als Du.*') \
		/set schaetz_rel_min=$[p_lp-29]%;\
		/set schaetz_rel_max=$[p_lp-20]%;\
	/elseif ({speicher}=/'*und ist damit fast so stark wie Du.*') \
		/set schaetz_rel_min=$[p_lp-19]%;\
		/set schaetz_rel_max=$[p_lp-10]%;\
	/elseif ({speicher}=/'*und ist damit etwa genauso stark wie Du.*') \
		/set schaetz_rel_min=$[p_lp-9]%;\
		/set schaetz_rel_max=$[p_lp+10]%;\
	/elseif ({speicher}=/'*und ist damit ein klein wenig staerker als Du.*') \
		/set schaetz_rel_min=$[p_lp+11]%;\
		/set schaetz_rel_max=$[p_lp+20]%;\
	/elseif ({speicher}=/'*und ist damit etwas staerker als Du.*') \
		/set schaetz_rel_min=$[p_lp+21]%;\
		/set schaetz_rel_max=$[p_lp+30]%;\
	/elseif ({speicher}=/'*und ist damit staerker als Du.*') \
		/set schaetz_rel_min=$[p_lp+31]%;\
		/set schaetz_rel_max=$[p_lp+50]%;\
	/elseif ({speicher}=/'*und ist damit deutlich staerker als Du.*') \
		/set schaetz_rel_min=$[p_lp+51]%;\
		/set schaetz_rel_max=$[p_lp+80]%;\
	/elseif ({speicher}=/'*und ist damit viel staerker als Du.*') \
		/set schaetz_rel_min=$[p_lp+81]%;\
		/set schaetz_rel_max=$[p_lp+120]%;\
	/elseif ({speicher}=/'*und ist damit sehr viel staerker als Du.*') \
		/set schaetz_rel_min=$[p_lp+121]%;\
		/set schaetz_rel_max=$[p_lp+180]%;\
	/elseif ({speicher}=/'*und ist damit sehr sehr viel staerker als Du.*') \
		/set schaetz_rel_min=$[p_lp+181]%;\
		/set schaetz_rel_max=$[p_lp+250]%;\
	/elseif ({speicher}=/'*und ist damit ueberaus sehr viel staerker als Du.*') \
		/set schaetz_rel_min=$[p_lp+251]%;\
		/set schaetz_rel_max=$[p_lp+350]%;\
	/elseif ({speicher}=/'*und ist damit gewaltig staerker als Du.*') \
		/set schaetz_rel_min=$[p_lp+351]%;\
		/set schaetz_rel_max=$[p_lp+500]%;\
	/elseif ({speicher}=/'*und ist damit unglaublich staerker als Du.*') \
		/set schaetz_rel_min=$[p_lp+501]%;\
		/set schaetz_rel_max=$[p_lp+1000]%;\
	/elseif ({speicher}=/'*und ist damit wahnsinnig viel staerker als Du.*') \
		/set schaetz_rel_min=$[p_lp+1001]%;\
		/set schaetz_rel_max=$[p_lp+2000]%;\
	/elseif ({speicher}=/'*und ist damit weghiermaessig viel staerker als Du.*') \
		/set schaetz_rel_min=$[p_lp+2001]%;\
		/set schaetz_rel_max=$[p_lp+3000]%;\
	/elseif ({speicher}=/'*und ist damit jenseits aller Grenzen viel staerker als Du.*') \
		/set schaetz_rel_min=$[p_lp+3000]%;\
		/set schaetz_rel_max=oo%;\
	/endif%;\
;;----------------------------------------------------------------------------
;; Hands oder Waffe, welche DTs werden damit verursacht?
	/if (regmatch("\\.( Eine?)? ([^.]*) macht folgenden Schaden: ([^.]*)\\.",speicher))\
		/set schaetz_weapon=%P2%;\
		/set schaetz_weapon_dt=%P3%;\
	/elseif (regmatch("[Er|Sie|Es] macht damit folgenden Schaden: ([^.]*)\\.",speicher))\
	/set schaetz_weapon=Hands%;\
		/set schaetz_weapon_dt=%P1%;\
	/else   /set schaetz_weapon=???%;\
		/set schaetz_weapon_dt=???%;\
	/endif%;\
;;----------------------------------------------------------------------------
;; Wie gut ist die Waffe des Targets? (-6 bis +10)
	/if (regmatch("Damit kaempft (er|sie|es) (.*) (als|wie) Du\\.",speicher))\
	    /if ({P2}=~'unglaublich viel viel schlechter') \
		/set weapon_qual=-6%;\
	    /elseif ({P2}=~'sehr viel schlechter') \
		/set weapon_qual=-5%;\
	    /elseif ({P2}=~'viel schlechter') \
		/set weapon_qual=-4%;\
	    /elseif ({P2}=~'deutlich schlechter') \
		/set weapon_qual=-3%;\
	    /elseif ({P2}=~'schlechter') \
		/set weapon_qual=-2%;\
	    /elseif ({P2}=~'etwas schlechter') \
		/set weapon_qual=-1%;\
	    /elseif ({P2}=~'etwa genauso gut') \
		/set weapon_qual= 0%;\
	    /elseif ({P2}=~'etwas besser') \
		/set weapon_qual= 1%;\
	    /elseif ({P2}=~'besser') \
		/set weapon_qual= 2%;\
	    /elseif ({P2}=~'deutlich besser') \
		/set weapon_qual= 3%;\
	    /elseif ({P2}=~'viel besser') \
		/set weapon_qual= 4%;\
	    /elseif ({P2}=~'sehr viel besser') \
		/set weapon_qual= 5%;\
	    /elseif ({P2}=~'sehr sehr viel besser') \
		/set weapon_qual= 6%;\
	    /elseif ({P2}=~'ueberaus sehr viel besser') \
		/set weapon_qual= 7%;\
	    /elseif ({P2}=~'wahnsinnig viel besser') \
		/set weapon_qual= 8%;\
	    /elseif ({P2}=~'unbeschreiblich viel besser') \
		/set weapon_qual= 9%;\
	    /elseif ({P2}=~'jenseits aller Grenzen viel besser') \
		/set weapon_qual=10%;\
	    /endif%;\
	/else /set weapon_qual= ?%;\
	/endif%;\
;;----------------------------------------------------------------------------
;; Wie gut ist das Target geschuetzt? (-6 bis +13)
	/if (regmatch("Damit ist (er|sie|es) (.*) (als|wie) Du geschuetzt\\.",speicher))\
	    /if ({P2}=~'unglaublich viel viel schlechter') \
		/set body_qual=-6%;\
	    /elseif ({P2}=~'sehr viel schlechter') \
		/set body_qual=-5%;\
	    /elseif ({P2}=~'viel schlechter') \
		/set body_qual=-4%;\
	    /elseif ({P2}=~'deutlich schlechter') \
		/set body_qual=-3%;\
	    /elseif ({P2}=~'schlechter') \
		/set body_qual=-2%;\
	    /elseif ({P2}=~'etwas schlechter') \
		/set body_qual=-1%;\
	    /elseif ({P2}=~'genauso gut') \
		/set body_qual= 0%;\
	    /elseif ({P2}=~'ein kleines bisschen besser') \
		/set body_qual= 1%;\
	    /elseif ({P2}=~'etwas besser') \
		/set body_qual= 2%;\
	    /elseif ({P2}=~'besser') \
		/set body_qual= 3%;\
	    /elseif ({P2}=~'deutlich besser') \
		/set body_qual= 4%;\
	    /elseif ({P2}=~'viel besser') \
		/set body_qual= 5%;\
	    /elseif ({P2}=~'sehr viel besser') \
		/set body_qual= 6%;\
	    /elseif ({P2}=~'viel viel besser') \
		/set body_qual= 7%;\
	    /elseif ({P2}=~'sehr sehr viel besser') \
		/set body_qual= 8%;\
	    /elseif ({P2}=~'ueberaus sehr viel besser') \
		/set body_qual= 9%;\
	    /elseif ({P2}=~'unglaublich viel besser') \
		/set body_qual=10%;\
	    /elseif ({P2}=~'wahnsinnig viel besser') \
		/set body_qual=11%;\
	    /elseif ({P2}=~'unbeschreiblich viel besser') \
		/set body_qual=12%;\
	    /elseif ({P2}=~'jenseits aller Grenzen viel besser') \
		/set body_qual=13%;\
	    /endif%;\
	/else /set body_qual= ?%;\
	/endif%;\
	/if ({speicher}=/'*ungewoehnlich dicke Haut, bzw. Fell*') \
		/set schaetz_high_body=!(%;\
	/else /set schaetz_high_body= (%;\
	/endif%;\
;;----------------------------------------------------------------------------
;; Anfaelligkeiten/Resistenzen *aechz*
	/set schaetz_resis=%speicher%;\
	/while (regmatch("(Er|Sie|Es) ist gegen (schneidenden Schaden|zerschmetternden \
	  Schaden|stechenden Schaden|reissenden Schaden|peitschenden Schaden|zerquetschenden \
	  Schaden|explodierenden Schaden) (extrem anfaellig|sehr anfaellig|anfaellig|\
	  geschuetzt|sehr gut geschuetzt|extrem gut geschuetzt)\\.",schaetz_resis)) \
	/set schaetz_resis=%PR%;\
	/set schaetz_dt=$[replace('zerschmetternden Schaden','Schlaege',\
	    replace('schneidenden Schaden','Schnitte',\
	    replace('stechenden Schaden','Stiche',\
	    replace('peitschenden Schaden','Peitschen',\
	    replace('zerquetschenden Schaden','Quetschen',\
	    replace('explodierenden Schaden','Explosionen',\
	    replace('reissenden Schaden','Reissen',\
		     {P2})))))))]%;\
	/if ({P3}=~'extrem anfaellig') \
		/set schaetz_max_anf=%schaetz_max_anf %schaetz_dt%;\
	/elseif ({P3}=~'sehr anfaellig') \
		/set schaetz_strong_anf=%schaetz_strong_anf %schaetz_dt%;\
	/elseif ({P3}=~'anfaellig') \
		/set schaetz_weak_anf=%schaetz_weak_anf %schaetz_dt%;\
	/elseif ({P3}=~'sehr gut geschuetzt') \
		/set schaetz_strong_res=%schaetz_strong_res %schaetz_dt%;\
	/elseif ({P3}=~'geschuetzt') \
		/set schaetz_weak_res=%schaetz_weak_res %schaetz_dt%;\
	/elseif ({P3}=~'extrem gut geschuetzt') \
		/set schaetz_max_res=%schaetz_max_res %schaetz_dt%;\
	/endif%;\
	/done%;\
;;----------------------------------------------------------------------------
;; Ist das Target nicht mehr absolut fit, rechnen wir mal hoch, wieviel er 
;; ungefaehr haette...
	/if (({schaetz_abs})&({schaetz_abs}!='10')) \
		/if ({schaetz_rel_max}=~'oo') \
		/set schaetz_calc_100 -> Leben(10): $[{schaetz_rel_min}*10/{schaetz_abs}] - oo%;\
		/else \
		/set schaetz_calc_100 -> Leben(10): $[{schaetz_rel_min}*10/{schaetz_abs}] - $[{schaetz_rel_max}*10/({schaetz_abs})]%;\
		/endif%;\
	/endif%;\
;;----------------------------------------------------------------------------
;; Die Ruestungsliste scrollt auch so genug, also killen wir erstmal 
;; saemtliche artikel
	/if (regmatch("traegt ([^.]*)\\.",speicher))\
		/set schaetz_armour=$[replace('ein ','',\
		  replace('eine ','',\
		  replace('einen ','',\
		  replace('einem ','',\
		  replace('das ','',\
		  replace('die ','',\
		  replace('den ','',\
		  replace('keine zusaetzliche Ruestung','Nada',{P1}))))))))]%;\
	/else /set schaetz_armour=Nada%;\
	/endif%;\
;;----------------------------------------------------------------------------
	/if (regmatch("ist etwa ([0-9]+)cm gross\\.",speicher)) \
		/set schaetz_size=%P1%;\
	/endif%;\
;;----------------------------------------------------------------------------
;; Lps und Waffe ausgeben (unproblematisch)
	/echo -p @{u}%target (%schaetz_size cm) geschaetzt:@{n}%;\
	/echo -p @{Cmagenta}Leben(@{n}%schaetz_abs@{Cmagenta})@{n}: %schaetz_rel_min - %schaetz_rel_max @{Cgreen}%schaetz_calc_100@{n}%;\
	/echo -p @{Cred}Waffe(@{n}%weapon_qual@{Cred})@{n}: @{Cyellow}%schaetz_weapon@{n} (%schaetz_weapon_dt)%;\
;;----------------------------------------------------------------------------
;; Die Ruestungsliste muss umgebrochen werden -> break_string
	/set bs_size=78%;\
	/set bs_attr=-p%;\
	/set bs_cmd=%;\
	/test set('bs_indent=@{Ccyan}Body$[{schaetz_high_body}]@{n}%body_qual@{Ccyan})@{n}: ')%;\
;;----------------------------------------------------------------------------
;; Sachen, die nur scrollen, einen aber nicht interessieren (ToDo: Schalter 
;; einbauen)
	/set schaetz_armour=$[replace(', ,',',',\
				replace(', ,',',',\
				replace(', ,',',',\
				replace('Fussring', '',\
				replace('Hundehalsband', '',\
				replace('Drachentoeter-Orden', '',\
				replace('Rucksack', '',\
				replace('Armbanduhr', '',\
				replace('Matrixkristall', '',\
				replace('Verlobungsring', '',\
				replace('adamantenen Ehering', '',\
				replace('magische Sonnenuhr', '',\
				replace('Goldkette', '',\
				replace('Scoreamulett', '',\
				replace('MASTERBLOCK', '',\
				replace('Schleimklumpen', '',\
				replace('rotes Zipfelmuetzchen', '',\
				replace('Polar-Button', '',\
				replace('goldenen Nasenring', '',\
				replace('Paar', '',\
				replace('schwarzen Siegelring', '',\
				replace('traumhafte Wespentaille', '',\
				replace('Ruestung des Hydratoeters', 'HyRue',\
				replace('Kette mit Schaedelanhaenger', 'DD-Kette',\
				replace('drakonischen Waffenguertel', 'Waffenguertel',\
				replace('Anti-Feuer-Ring', 'AFR',\
				replace('Eisschamanenpanzer', 'ESP',\
				replace('``Born to Kill\'\'-Stirnband', '',\
				{schaetz_armour}))))))))))))))))))))))))))))]%;\
;; Fuehrende Kommata loeschen...
	/if (substr({schaetz_armour}, 0, 2)=~', ') \
		/set schaetz_armour=$[substr({schaetz_armour},2)]%;\
	/endif%;\
;; Ruestungen ausgeben
	/break_string %schaetz_armour%;\
;; Resistenzen ausgeben:
	/if ({schaetz_max_res}!~'') /echo -p @{Cred}Resis (!)@{n}:%schaetz_max_res%;/endif%;\
	/if ({schaetz_strong_res}!~'') /echo -p @{Cred}Resis (+)@{n}:%schaetz_strong_res%;/endif%;\
	/if ({schaetz_weak_res}!~'') /echo -p @{Cred}Resis (-)@{n}:%schaetz_weak_res%;/endif%;\
	/if ({schaetz_weak_anf}!~'') /echo -p @{Cgreen}Empf  (-)@{n}:%schaetz_weak_anf%;/endif%;\
	/if ({schaetz_strong_anf}!~'') /echo -p @{Cgreen}Empf  (+)@{n}:%schaetz_strong_anf%;/endif%;\
	/if ({schaetz_max_anf}!~'') /echo -p @{Cgreen}Empf  (!)@{n}:%schaetz_max_anf%;/endif%;\
;; Und den ganzen spass wieder reseten...
	/unset schaetz_abs%;\
	/unset schaetz_rel_min%;\
	/unset schaetz_rel_max%;\
	/unset schaetz_calc_100%;\
	/unset schaetz_weapon%;\
	/unset schaetz_weapon_dt%;\
	/unset weapon_qual%;\
	/unset schaetz_armour%;\
	/unset body_qual%;\
	/unset schaetz_size%;\
	/unset schaetz_high_body%;\
	/unset schaetz_resis%;\
	/unset schaetz_dt%;\
	/unset schaetz_strong_res%;\
	/unset schaetz_weak_res%;\
	/unset schaetz_strong_anf%;\
	/unset schaetz_weak_anf%;\
	/unset schaetz_max_anf%;\
	/unset schaetz_max_res

;; Waffenskills to % 

; praktisch ueberhaupt nicht
; ein bisschen
; leicht unterdurchschnittlich
; leicht ueberdurchschnittlich
; recht gut
; fuer seine Verhaeltnisse perfekt

/def trves_schaetz_skill2per = \
	/if ({*}=~"praktisch ueberhaupt nicht") \
		/let schaetz_spercent= 0-19%;\
	/elseif ({*}=~"ein bisschen") \
		/let schaetz_spercent=20-39%;\
	/elseif ({*}=~"leicht unterdurchschnittlich") \
		/let schaetz_spercent=40-59%;\
	/elseif ({*}=~"leicht ueberdurchschnittlich") \
		/let schaetz_spercent=60-79%;\
	/elseif ({*}=~"recht gut") \
		/let schaetz_spercent=80-99%;\
	/elseif ({*}=~"fuer seine Verhaeltnisse perfekt") \
		/let schaetz_spercent=  100%;\
	/else \
		/let schaetz_spercent=???%;\
	/endif%;\
	/echo -- $[pad({*},-32)] (%{schaetz_spercent}\%)%;\

;; Skills von anderen Gilden (by Madness)
/def -ag -p1 -mregexp -q -t'([A-Za-z0-9]+) beherrscht den Umgang mit stumpfen Hiebwaffen' trves_schaetz_skills = \
		/set speicher=%*%; \
		/set target=%P1%;\
	        /def -ag -p1 -mglob -q -t'*' schaetz_collect = \
         	                /set speicher=%%speicher %%*%%; \
         	                /if (substr(speicher, -1 , 1) =~ '.') \
         	                        /undef schaetz_collect%%; \
         	                        /schaetz_ausgabe_skill%%; \
         			/endif

;; Und dann natuerlich schoener ausgeben.
/def schaetz_ausgabe_skill = \
;;----------------------------------------------------------------------------
;; Keule
	/if (regmatch("den Umgang mit stumpfen Hiebwaffen ([^,]+)", speicher)) \
		/set skill_keule=$(/trves_schaetz_skill2per %P1)%;\
	/else \
		/set skill_keule=%;\
	/endif%;\
;; Aexte
	/if (regmatch("den Umgang mit Aexten ([^,]+)", speicher)) \
		/set skill_aexte=$(/trves_schaetz_skill2per %P1)%;\
	/else \
		/set skill_aexte=%;\
	/endif%;\
;; Schwerter
	/if (regmatch("den Umgang mit Schwertern ([^,]+)", speicher)) \
		/set skill_schwerter=$(/trves_schaetz_skill2per %P1)%;\
	/else \
		/set skill_schwerter=%;\
	/endif%;\
;; Speere
	/if (regmatch("den Umgang mit Speeren ([^,]+)", speicher)) \
		/set skill_speere=$(/trves_schaetz_skill2per %P1)%;\
	/else \
		/set skill_speere=%;\
	/endif%;\
;; Kampfstock
	/if (regmatch("den Umgang mit Staeben ([^,]+)", speicher)) \
		/set skill_kampfstock=$(/trves_schaetz_skill2per %P1)%;\
	/else \
		/set skill_kampfstock=%;\
	/endif%;\
;; Messer
	/if (regmatch("den Umgang mit Messern ([A-Za-z ]+) und ", speicher)) \
		/set skill_messer=$(/trves_schaetz_skill2per %P1)%;\
	/else \
		/set skill_messer=%;\
	/endif%;\
;; Peitschen
	/if (regmatch("den Umgang mit Peitschen ([^.]+)", speicher)) \
		/set skill_peitschen=$(/trves_schaetz_skill2per %P1)%;\
	/else \
		/set skill_peitschen=%;\
	/endif%;\
;;----------------------------------------------------------------------------
;; Skills ausgeben
	/echo -p @{xCyellow}Skill (@{xCwhite}Keule     @{xCyellow})@{n}: %skill_keule%;\
	/echo -p @{xCyellow}Skill (@{xCwhite}Aexte     @{xCyellow})@{n}: %skill_aexte%;\
	/echo -p @{xCyellow}Skill (@{xCwhite}Schwerter @{xCyellow})@{n}: %skill_schwerter%;\
	/echo -p @{xCyellow}Skill (@{xCwhite}Speere    @{xCyellow})@{n}: %skill_speere%;\
	/echo -p @{xCyellow}Skill (@{xCwhite}Kampfstock@{xCyellow})@{n}: %skill_kampfstock%;\
	/echo -p @{xCyellow}Skill (@{xCwhite}Messer    @{xCyellow})@{n}: %skill_messer%;\
	/echo -p @{xCyellow}Skill (@{xCwhite}Peitschen @{xCyellow})@{n}: %skill_peitschen%;\
;; Wer moechte kann dem Spieler seine Skills direkt mitteilen
	/if ({schaetz_tm_skills} == 1) \
		/eval teile %target mit Skill (Keule     ): %skill_keule%;\
		/eval teile %target mit Skill (Aexte     ): %skill_aexte%;\
		/eval teile %target mit Skill (Schwerter ): %skill_schwerter%;\
		/eval teile %target mit Skill (Speere    ): %skill_kampfstock%;\
		/eval teile %target mit Skill (Kampfstock): %skill_speere%;\
		/eval teile %target mit Skill (Messer    ): %skill_messer%;\
		/eval teile %target mit Skill (Peitschen ): %skill_peitschen%;\
	/endif%;\
;; Und den ganzen spass wieder reseten...
	/unset skill_keule%;\
	/unset skill_aexte%;\
	/unset skill_schwerter%;\
	/unset skill_speere%;\
	/unset skill_kampfstock%;\
	/unset skill_messer%;\
	/unset skill_peitschen


