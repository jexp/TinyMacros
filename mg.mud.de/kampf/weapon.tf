; $Log: weapon.tf,v $
; Revision 1.15  2002/05/31 07:31:39  thufhnik
; Wenn (CFG_USE_MG_MUD_DE_KAMPF_WEAPON > 1) abbrechen und weapon2.tf laden
;
; Revision 1.14  2002/02/10 22:36:41  mh14
; Statuszeilendoku
;
; Revision 1.13  2002/02/09 20:42:06  mh14
; feste Groesse fuer Waffe/Schild in der Statuszeile
;
; Revision 1.12  2002/02/09 13:17:56  mh14
; debuggt
;
; Revision 1.11  2002/02/04 22:13:18  mh14
; entbuggt
;
; Revision 1.10  2001/12/06 08:33:19  mh14
; bug bei weapon_use/set raus, p_free_hands
;
; Revision 1.9  2001/12/06 08:10:47  mh14
;  peitsche dazu, vorm parsen der waffe variablen zurueckgesetzt
;
; Revision 1.8  2001/12/06 07:49:31  mh14
; nicht parsebare Waffennamen repariert
;
; Revision 1.7  2001/12/06 07:36:05  mh14
; bug bei loadnamedlist weapon_short raus
;
; Revision 1.6  2001/12/05 15:07:22  mh14
; unbekannte waffen werden beim zuecken etwas ausgewertet,bekannte die nicht per makro gezueckt wurden, werden richtig gesetzt
;
; Revision 1.5  2001/12/05 13:42:53  mh14
; waffeneingabe mit eingabeaufforderung
;
; Revision 1.4  2001/11/27 21:10:52  mh14
; sl_* angepasst an status.tf
;
; Revision 1.3  2001/10/19 14:37:46  mh14
; Aenderungen an der Statuszeile, diese ist jetzt Schneller, hoffentlich Problematik der parallelen threads (globale Variable (value) behoben
;
; Revision 1.2  2001/10/08 18:01:27  mh14
; Status Module an neue Funktionen von status.tf angepasst
;
; Revision 1.1  2001/10/07 19:13:28  mh14
; Listen fuer Waffen,Schilde,Funktionen fuer Zuecken,Wegstecken,freie Haende erhalten,Status Modul fuer Waffe,Schild
;
;

/if (CFG_USE_MG_MUD_DE_KAMPF_WEAPON > 1) \
	/mload -c -dkampf weapon2.tf%;\
	/exit%;\
/endif

/set weapon_tf_version $Id: weapon.tf,v 1.15 2002/05/31 07:31:39 thufhnik Exp $
/set weapon_tf_author=Mesirii@mg.mud.de
/set weapon_tf_requires=lists.tf mg_properties.tf
/set weapon_tf_desc Waffen-,Schildverwaltung mit Zuecken,Wegstecken,Check auf freie Haende


/set weapon_sl_shield_size=3
/set weapon_sl_weapon_size=3

/def -msimple -F -t"Das hast Du schon gemacht!" weapon_trig_drawn = \
	/set weapon_drawn=1%;\
	
/def -F -msimple -t"WAS willst Du WOHIN stecken?" weapon_trig_nounwear = \
     /set weapon_drawn=0%; /set weapon_by_tf=0%;

/def -F -msimple -t"Du hast sowas nicht." weapon_trig_unknown = \
     /set weapon_drawn=0%; /set weapon_by_tf=0%;



/def -mregexp -F -t'^Du zueckst (.*)\\.$' weapon_trig_zuecke = \
        /if (--weapon_by_tf<0 & !weapon_drawn) \
	     /set weapon_drawn_name=%P1%;\
             /set weapon_by_tf=0%;\
	     /set weapon=%;\
	     /set weapon_short=%;\
	     /set weapon_damage=%;\
	     /set weapon_hitfunc=%;\
	     /ut_str2weapon %weapon_drawn_name%;\
	     /set weapon_hands=1%;\
	     /test status_get_schaden_attr(weapon_short,weapon_damage,"status_var_weapon")%;\
	     /if (strlen(weapon_short)<weapon_sl_weapon_size) \
	        /test status_var_weapon:=strcat(status_var_weapon," :",weapon_sl_weapon_size-strlen(weapon_short))%;\
	     /endif%;\
	     /set weapon_drawn=1%;\
	     /set p_free_hands=$[max(0,p_free_hands-weapon_hands)] %; \
	/endif%;\

;;; ut_str2weapon: einen String in einen gueltigen Waffennamen umwandeln:

/def artikelkuerzen=\
	/if ({1}=/'{der|des|dem|den|die|das|dein|deine|deiner|deines|deinen|deinem|eine|ein|eines|einer|einem|einen}') \
		/return {-1}%;\
	/else \
		/return {*}%;\
	/endif

/set weapon_types=(Schwert|Hammer|Speer|Keule|Messer|Axt|Lanze|Stab|Stock|Dolch|Stachel|Peitsche|Kolben)

/set shield_types=(Schild|Knochen)

/def ut_str2weapon = \
	/artikelkuerzen %{*}%;\
	/let UT_S2W=%?%;\
	/if (regmatch(strcat("([a-z]+ )?(([-A-Za-z]+)",tolower(weapon_types),"|",weapon_types,")"),UT_S2W)) \
	   /set weapon_adj=$[tolower({P1})]%;\
	   /set weapon=$[tolower({P2})]%;\
	   /set weapon_name=%{P2}%;\
	   /set weapon_type=%P4%P5%;\
	   /set weapon_damage=%P1%P3%;\
	   /set weapon_damage=%{weapon_damage-unbekannt},%weapon_type%;\
	   /set weapon_short=$[strcat(substr(weapon_adj,0,1),substr(weapon_name,0,1),substr({P4},0,1))]%;\
;/echo -aCyellow adj %weapon_adj type %weapon_type name %weapon_name short=%weapon_short dam %weapon_damage%;\
           /lw%;\
	   /return tolower(weapon_name)%;\
	/else \
	   /set weapon=$[tolower(UT_S2W)]%;\
	   /set weapon_name=$[tolower(UT_S2W)]%;\
	   /set weapon_short=$[substr(weapon_name,0,2)]%;\
	   /lw%;\
;/echo -aCyellow name %weapon_name short=%weapon_short%;\
	   /return tolower(UT_S2W)%;\
	/endif%;


; artikelkuerzen
; ([a-z]+ )?([-A-Za-z]+(schwert|hammer|speer|keule|messer|axt|lanze|stab|stock|dolch|stachel)|(Schwert|Hammer|Speer|Keule|Messer|Axt|Lanze|Stab|Stock|Dolch|Stachel))
; adj=P1, name=P2, art=P3|P4
/def rem= \
	/if (regmatch("([A-Z][a-z\\-]+[Ss]chwert|Schwert|\
			[A-Z][a-z\\-]+[Mm]esser|Messer|\
			[A-Z][a-z\\-]+[Ss]peer|Speer|\
			[A-Z][a-z\\-]+[Kk]eule|Keule|\
			[A-Z][a-z\\-]+[Aa]xt|Axt|\
			[A-Z][a-z\\-]+[Ll]anze|Lanze|\
			[A-Z][a-z\\-]+[Hh]ammer|Hammer|\
			[A-Z][a-z\\-]+[Ss]tab|Stab|\
			[A-Z][a-z\\-]+[Ss]tock|Stock|\
			[A-Z][a-z\\-]+[Dd]olch|Dolch|\
			[A-Z][a-z\\-]+[Ss]tachel|Stachel)([\\, ]|$)", \
			UT_S2W)) \
		/let UT_S2W $[tolower({P1})]%;\
	/elseif (regmatch("([Dd]e[rn]|[Dd]ie|[Dd]as|[Ee]ine?|einen) \
			([a-z]* |)([A-Z][A-Za-z\\-]+)( .*|)", \
			UT_S2W)) \
		/let UT_S2W $[tolower({P3})]%;\
	/else \
		/let UT_S2W $[tolower(UT_S2W)]%;\
	/endif%;\
	/echo -- %UT_S2W

/def -mregexp -F -t'^Du steckst (.*) zurueck\\.$' weapon_trig_weg = \
     /if (--weapon_by_tf<0 & weapon_drawn) \
       /set weapon_by_tf=0%;\
       /set weapon_drawn=0%; \
       /set p_free_hands=$[min(2,p_free_hands+weapon_hands)]%; \
     /endif%;


/def weapon_draw = \
  /if (weapon_drawn==0) \
     /if (p_free_hands<weapon_hands) \
	/weapon_unwear%;\
     /endif%;\
     /if (p_free_hands>=weapon_hands) \
	/if (weapon_container!~"") \
	  nimm %weapon aus %weapon_container in mir%;\
	/endif%;\
	  zuecke %weapon %; \
	/set weapon_by_tf=1%;\
        /set weapon_draw_flag=1%;\
	/set weapon_drawn=1 %; \
	/set p_free_hands=$[p_free_hands-weapon_hands] %; \
     /endif%; \
  /else \
     /if (weapon_container!~"") \
       stecke %weapon in %weapon_container in mir %; \
     /else \
       stecke %weapon weg %; \
     /endif%;\
     /test weapon_by_tf:=(weapon_by_tf==1) ? 2 : 1%;\
     /set weapon_drawn=0 %; \
     /set p_free_hands=$[p_free_hands+weapon_hands]%; \
  /endif %;

/def weapon_toggle_shield =  \
    /if (weapon_shield!~"") \
      /if (weapon_shield_worn==0) \
	/if (p_free_hands>=1) \
	  trage %weapon_shield%; \
	  /set weapon_shield_worn=1 %; \
	  /set p_free_hands=$[p_free_hands-1]%; \
	/endif%; \
	/else \
	   ziehe %weapon_shield aus %; \
	   /set weapon_shield_worn=0 %; \
	   /set p_free_hands=$[p_free_hands+1] %; \
	/endif %;\
    /endif %;

/def weapon_unwear = \
	/let phands=%{1-2} %;\
	/if (phands>p_free_hands) \
	     /if (weapon_shield_worn==1) \
	       /weapon_toggle_shield %; \
	     /endif %;\
	/endif %;\
	/if (phands>p_free_hands) \
	     /if (weapon_drawn==1) /weapon_draw%; /endif %;\
	/endif %;

/def weapon_wear = \
	/if (weapon_drawn==0) \
	   /weapon_draw%;\
	/endif %;\
	/if ((p_free_hands==1)&(weapon_shield_worn==0)) \
	   /weapon_toggle_shield%; \
	/endif %;

/def weapon_add = /createnewlist %weapon_list_name%;/uaddtolist %weapon_list_name %* %;/savenamedlist weapon

/def weapon_add_new = \
	/let param=%{1-%weapon_short}%;\
	/weapon_get %param%;\
	/if (value!~error) \
	  /weapon_set_attr %value%;\
;	/else \
;	  /weapon_set_attr 1 name Schwert%;\
	/endif%;\
	/set weapon_short=$[ext_read("Abkuerzung: ",param)]%;\
	/set weapon_hands=$[ext_read("Haende: ",weapon_hands)]%;\
	/set weapon=$[ext_read("Id,Name: ",weapon_name)]%;\
	/echo Schadensarten (Durch Komma getrennt, keine Leerzeichen)%;\
	/echo %schadensarten%;\
	/set weapon_damage=$[ext_read("Schadensart: ",weapon_damage)]%;\
	/set weapon_hitfunc=$[ext_read("Hitfunc (+ wenn ja): ",weapon_hitfunc)]%;\
	/lw%;\
	/if (ext_read("Waffe hinzufuegen (j/n)? ","j")=/"j") \
	/weapon_add %weapon_short %weapon_hands %weapon %{weapon_damage}%weapon_hitfunc%;\
	/endif%;

	

/def weapon_get = /getvalueof %weapon_list_name %* %;

/def weapon_get_damage = \
     /weapon_get %1%;\
     /if (value!~error) \
        /if (value=/"*+") /test value:=substr(value,0,-1)%;/endif%;\
        /get_param L %value%;\
	/return {?}%;\
     /endif%;

/def weapon_use = /let param=%* %;\
	  /weapon_get %param %;\
	  /if (value=~error) /echo -aCred keine Waffe %param gefunden!%;\
	  /else \
	     /set weapon_short=%*%;\
	     /weapon_set %value %; \
	     /test status_get_schaden_attr(weapon_short,weapon_damage,"status_var_weapon")%;\
	     /if (strlen(weapon_short)<weapon_sl_weapon_size) \
	        /test status_var_weapon:=strcat(status_var_weapon," :",weapon_sl_weapon_size-strlen(weapon_short))%;\
	     /endif%;\
	  /endif %; 

/def weapon_show = /echo -aB Waffe: %weapon ein %weapon_hands\-haender Schaden: %weapon_damage, Hitfunc: %weapon_hitfunc%;

/def weapon_set = \
;	  /if ((({1}==1)|({1}==2))&({-1}!~"")) \
	    /let temp=0 %;\
	    /if (weapon_drawn==1) /let temp=1 %; /weapon_unwear %; /endif %;\
	    /weapon_set_attr %*%;\
;	    /if (temp==1) \
	    /weapon_wear%; \
; 	    /endif %;\
	    /weapon_show%;\
;	  /endif %;

/def weapon_set_attr = \
	    /set weapon_hands=%1 %;\
	    /shift%;\
	    /if ({#}>1) \
	      /set weapon=%-L1 %;\
	      /set weapon_damage=%L1%;\
	      /set weapon_hitfunc=%;\
	      /if (weapon_damage=/"*+") \
		 /set weapon_damage=$[substr(weapon_damage,0,strlen(weapon_damage)-1)]%; /set weapon_hitfunc=+%;\
	      /endif%;\
	    /else \
	      /set weapon=%*%;\
	      /set weapon_damage=%;\
	      /set weapon_hitfunc=%;\
	    /endif%;\
	    /set weapon_name=%weapon%;


/def weapon_add_shield = /createnewlist %shield_list_name%;/uaddtolist %shield_list_name %* %;
/def weapon_get_shield = /getvalueof %shield_list_name %* %;

/def weapon_use_shield = /let param=%*%;\
	  /weapon_get_shield %param%;\
	  /if (value=~error) /echo -aCred keine Schild %param gefunden!%;\
;	     /weapon_set_shield %param%;\
;	     /set weapon_shield_short=$[substr(param,0,2)]%;\
	  /else \
	    /weapon_set_shield %value%; \
	    /set weapon_shield_short=%param%; \
	  /endif%;\
	  /test status_get_schaden_attr(weapon_shield_short,weapon_shield_damage,"status_var_shield")%;\
	  /if (strlen(weapon_shield_short)<weapon_sl_shield_size) \
	        /test status_var_shield:=strcat(status_var_shield," :",weapon_sl_shield_size-strlen(weapon_shield_short))%;\
	     /endif%;\




/def weapon_show_shield = /echo -aB Schild: %weapon_shield Schutz: %weapon_shield_damage, Defendfunc: %weapon_shield_defendfunc%;

/def weapon_set_shield = \
     /if ((weapon_shield!~"")&(weapon_shield_worn==1)) \
       /weapon_toggle_shield%;\
     /endif %;\
     /if ({#}>1) \
	    /set weapon_shield=%-L1 %;\
	    /set weapon_shield_damage=%L1%;\
	    /set weapon_shield_defendfunc=%;\
	    /if (weapon_shield_damage=/"*+") \
	       /set weapon_shield_damage=$[substr(weapon_shield_damage,0,-1)]%; \
	       /set weapon_shield_defendfunc=+%;\
	    /endif%;\
     /else \
       /set weapon_shield=%*%;\
       /set weapon_shield_damage=%;\
       /set weapon_shield_defendfunc=%;\
     /endif%;\
     /if ((weapon_shield!~"")&(weapon_shield_worn==0)) \
       /weapon_toggle_shield%;\
     /endif%;\
     /weapon_show_shield%;

/set sl_weapon_doc=wenn gezueckt: Waffe in Schadensartfarben, Hitfunc(+)

/def sl_weapon = \
  /init_var status_var_weapon weapon_short weapon_hitfunc weapon_damage%;\
  /set status_func_weapon_drawn=weapon_drawn ? weapon_hitfunc : "/"%;\
  /set status_attr_weapon_drawn=weapon_drawn ? "Cyellow" : "n"%;\
  /test status_var("weapon_drawn",weapon_sl_weapon_size)%;\
  /return strcat('\$[weapon_drawn ? status_var_weapon : ":%weapon_sl_weapon_size"] weapon_drawn:1:BCyellow')

/set sl_shield_doc=wenn getragen: Schild in Schadensartfarben, Defendfunc(+)

/def sl_shield = \
  /init_var status_var_shield weapon_shield weapon_shield_damage weapon_shield_defendfunc%;\
  /set sl_shield_doc=wenn getragen: Schild in Schadensartfarben, Defendfunc(+)%;\
  /set status_func_weapon_shield_worn=weapon_shield_worn ? weapon_shield_defendfunc : "" %;\
  /test status_var("weapon_shield_worn",weapon_sl_shield_size)%;\
  /return strcat('\$[weapon_shield_worn ? status_var_shield : ":%weapon_sl_shield_size"] weapon_shield_worn:1:BCyellow')



