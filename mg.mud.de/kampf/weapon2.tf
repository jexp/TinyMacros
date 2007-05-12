; $Log: weapon2.tf,v $
; Revision 1.17  2002/08/27 08:08:38  mh14
; /set_var Falschanwendungen debuggt
;
; Revision 1.16  2002/06/17 08:17:48  mh14
; statuszeilenanzeige von anfang an
;
; Revision 1.15  2002/06/14 15:00:02  mh14
; feste breite, und ohne farben wenn weggesteckt
;
; Revision 1.14  2002/06/13 14:28:47  mh14
; statuszeilenanzeige, editierbar bei weapon_add_new(auto), ei paar trigger geaendert
;
; Revision 1.13  2002/06/08 08:02:03  thufhnik
; Bugfix in shield_guess
; Kleinigkeiten in weapon_guess
;
; Revision 1.12  2002/06/06 15:59:49  thufhnik
; shield_add_new verschoenert
;
; Revision 1.11  2002/06/06 15:49:41  thufhnik
; Trigger bereinigt
; Berechnung von p_free_hands debugt
;
; Revision 1.10  2002/06/06 09:36:06  thufhnik
; Waffe und Schild werden im save-file gespeichert und nach dem Laden
; restauriert
;
; Revision 1.9  2002/06/04 16:38:03  thufhnik
; bugfix im sms
;
; Revision 1.8  2002/06/03 11:57:47  thufhnik
; weapon_container beim zuecken und wegstecken beruecksichtigen
;
; Revision 1.7  2002/06/03 10:12:10  thufhnik
; Schoeneres weapon_add_new
;
; Revision 1.6  2002/06/03 09:11:40  thufhnik
; Bei den Waffen den Schaden anders behandeln
;
; Revision 1.5  2002/06/01 14:49:52  thufhnik
; bugfix im unset
;
; Revision 1.4  2002/06/01 14:38:56  thufhnik
; Diverses
;
; Revision 1.3  2002/05/31 08:24:03  thufhnik
; an- und ausziehen ohne Meldung moeglich gemacht
;
; Revision 1.2  2002/05/30 21:11:17  thufhnik
; wenn die gesetzte waffe geloescht werden soll, dann soll sie auch weggesteckt
; werden
;
; Revision 1.1  2002/05/30 20:35:31  thufhnik
; Scratch
;

/set weapon2_tf_version $Id: weapon2.tf,v 1.17 2002/08/27 08:08:38 mh14 Exp $
/set weapon2_tf_author=Thufhir@mg.mud.de
/set weapon2_tf_requires=lists.tf worldconnect.tf(1.18)
/set weapon2_tf_desc Waffen- und Schildverwaltung (Ersatz fuer die weapon.tf)


; Konfigurierbares

/set_var weapon_list_name waffen2
/set_var weapon_list_location=-c
/set_var shield_list_name schilde2
/set_var shield_list_location=-c
/set_var weapon_echo_color Cmagenta
/set_var weapon_draw_color Cmagenta
/set_var weapon_status_size 4
/set_var shield_status_size 4
/set_var weapon_magic_types ([Ee]is|[Ff]euer|[Bb]litz|[Mm]agie|[Ss]aeure|[Ww]asser)
/init_var weapon_container


;;; Variablen initialisieren

/set weapon_gag 0

;;; Statusmodule
/def sl_weapon = \
  /init_var status_var_weapon weapon_short weapon_hitfunc weapon_damage%;\
  /set status_func_weapon_drawn=(weapon_drawn & weapon_hitfunc) ? "+" : ""%;\
  /set status_attr_weapon_drawn=weapon_drawn ? "Cred" : "n"%;\
  /test status_var("weapon_drawn",weapon_status_size)%;\
  /return strcat('\%weapon_sl weapon_drawn:1')

/def sl_shield = \
  /init_var shield_worn shield_sl%;\
  /set status_func_shield_worn=(shield_worn & shield_defendfunc) ? "+" : ""%;\
  /set status_attr_shield_worn=shield_worn ? "Cred" : "n"%;\
  /test status_var("shield_worn",shield_status_size)%;\
  /return strcat('\%shield_sl shield_worn:1')

/def weapon_no_sl = /set weapon_sl="%weapon":%weapon_status_size
/def shield_no_sl = /set shield_sl="%shield":%shield_status_size
;;; die Macros

/def weapon_action = \
	/if ({1}=/"[012]") \
		/let weapon_command=%-1%;\
		/let weapon_required_hands=%1%;\
	/else \
		/let weapon_command=%*%;\
		/let weapon_required_hands=2%;\
	/endif%;\
	/if (weapon_drawn & (p_free_hands < weapon_required_hands)) \
		/def -1 -p99999 -mglob -agCblue -t'Du steckst \
			* zurueck.' weapon_action_g1%;\
		/send !\\stecke %weapon_id weg%;\
	/endif%;\
	/if (shield_worn & (weapon_required_hands > 1)) \
		/def -1 -p99999 -mglob -agCblue -t'Du ziehst \
			* aus.' weapon_action_g2%;\
		/send !\\ziehe %shield_id aus%;\
	/endif%;\
	/eval %weapon_command%;\
	/if (weapon_drawn & (p_free_hands < weapon_required_hands)) \
		/def -1 -p99999 -mglob -agCblue -t'Du zueckst \
			*.' weapon_action_g3%;\
		/send !\\zuecke %weapon_id%;\
	/endif%;\
	/if (shield_worn & (weapon_required_hands > 1)) \
		/def -1 -p99999 -mglob -agCblue -t'Du ziehst \
			* an.' weapon_action_g4%;\
		/send !\\trage %shield_id%;\
	/endif

/def weapon_toggle = \
     /if (weapon_drawn) /weapon_unwear%; \
     /else /weapon_draw%; /endif


/def weapon_unwear = \
	/if (weapon !~ "" & weapon_id !~ "" & weapon_drawn) \
		/if (weapon_container !~ "") \
			/set weapon_gag 1%;\
			/send !\\stecke %weapon_id in %weapon_container in \
				mir%;\
		/else \
			/send !\\stecke %weapon_id weg%;\
		/endif%;\
	/else \
		/set weapon_quiet 0%;\
	/endif

/def weapon_draw = \
	/if (weapon !~ "" & weapon_id !~ "") \
		/if (weapon_hands > (2-shield_hands+zauberer_extrahand) \
		    & shield_worn) \
			/send !\\ziehe %shield_id aus%;\
		/endif%;\
		/if (weapon_container !~ "") \
			/set weapon_gag 1%;\
			/send !\\nimm %weapon_id aus %weapon_container in mir%;\
		/endif%;\
		/send !\\zuecke %weapon_id%;\
	/endif

/def shield_unwear = \
	/if (shield !~ "" & shield_id !~ "" & shield_worn) \
		/send !\\ziehe %shield_id aus%;\
	/else \
		/set shield_quiet 0%;\
	/endif

/def shield_wear = \
	/if (shield !~ "" & shield_id !~ "") \
		/send !\\trage %shield_id%;\
	/endif

/def weapon_unset = \
	/set weapon=%;\
	/set weapon_hands 0%;\
	/set weapon_id=%;\
	/set weapon_damage=%;\
	/set weapon_long=%;\
;	/set weapon_sl=:%weapon_status_size%;\
	/weapon_no_sl%;\
	/set weapon_hitfunc 0%;\
	/set weapon_drawn 0

/def shield_unset = \
	/set shield=%;\
	/set shield_hands 0%;\
	/set shield_id=%;\
	/set shield_damage=%;\
	/set shield_long=%;\
	/shield_no_sl%;\
;	/set shield_sl=:%shield_status_size%;\
	/set shield_defendfunc 0%;\
	/set shield_worn 0
	

/def weapon_show = \
	/echo -pa%weapon_echo_color *** Waffe: @{h}%{weapon_long}@{n} \
		(%{weapon}): %weapon_damage, %{weapon_hands}hand

/def shield_show = \
	/echo -pa%weapon_echo_color *** Schild: @{h}%{shield_long}@{n} \
		(%{shield}): %shield_damage, %{shield_hands}hand

/def weapon_set = \
	/if ({#} == 0) \
		/weapon_unwear%;\
		/weapon_unset%;\
	/else \
		/getvalueof %weapon_list_name %1%;\
		/if (value =~ error) \
			/echo -aCred *** Waffe nicht gefunden!%;\
		/else \
			/set weapon %1%;\
			/weapon_set2 %value%;\
			/weapon_draw%;\
		/endif%;\
	/endif

/def weapon_set1 = \
	/set weapon %1%;\
	/getvalueof %weapon_list_name %weapon%;\
	/weapon_set2 %value

/def weapon_set2 = \
	/set weapon_hands %1%;\
	/set weapon_id %2%;\
	/set weapon_damage %3%;\
	/set weapon_long %-3%;\
	/set weapon_hitfunc=$[weapon_damage=/"*+*"]%;\
;	/set weapon_sl=$[strcat(substr(weapon, 0, \
;		weapon_status_size-weapon_hitfunc), weapon_hitfunc?"+":"")]%;\
	/weapon_show

/def weapon_find2 = \
	/if (weapon_search =~ {-4}) \
		/weapon_set1 %1%;\
	/endif

/def weapon_find = \
	/if ({*} !~ weapon_long) \
		/weapon_unset%;\
		/set weapon_search %*%;\
		/forEach %weapon_list_name kv /weapon_find2%;\
	/endif%;\
	/return weapon

/def shield_set = \
	/if ({#} == 0) \
		/shield_unwear%;\
		/shield_unset%;\
	/else \
		/getvalueof %shield_list_name %1%;\
		/if (value =~ error) \
			/echo -aCred *** Schild nicht gefunden!%;\
		/else \
			/shield_unwear%;\
			/set shield %1%;\
			/shield_set2 %value%;\
			/shield_wear%;\
		/endif%;\
	/endif

/def shield_set1 = \
	/set shield %1%;\
	/getvalueof %shield_list_name %shield%;\
	/shield_set2 %value

/def shield_set2 = \
	/set shield_hands %1%;\
	/set shield_id %2%;\
	/set shield_damage %3%;\
	/set shield_long %-3%;\
	/set shield_defendfunc=$[shield_damage=/"*+*"]%;\
;        /set shield_sl=$[strcat(substr(shield, 0, \
;                shield_status_size-shield_defendfunc), \
;		shield_defendfunc?"+":"")]%;\
	/shield_show

/def shield_find2 = \
	/if (shield_search =~ {-4}) \
		/shield_set1 %1%;\
	/endif

/def shield_find = \
	/if ({*} !~ shield_long) \
		/shield_unset%;\
		/set shield_search %*%;\
		/forEach %shield_list_name kv /shield_find2%;\
	/endif%;\
	/return shield

/def weapon_guess = \
	/set weapon_id=$[tolower({*})]%;\
	/if (weapon=~"" | weapon=~"auto" | weapon=~"0") \
		/let weapon_guess_weapon 1%;\
		/set weapon=$[substr(weapon_id,0,weapon_status_size-1)]%;\
	/else \
		/let weapon_guess_weapon 0%;\
	/endif%;\
	/set weapon_long %*%;\
	/set weapon_hands 2%;\
	/set weapon_damage=???%;\
	/let weapon_type=%;\
	/if (regmatch("[Aa]xt", {*})) \
		/let weapon_type=Axt%;\
		/set weapon_damage=Schnitt%;\
	/elseif (regmatch("[Ss]chwert", {*})) \
		/let weapon_type=Schwert%;\
		/set weapon_damage=Schnitt%;\
	/elseif (regmatch("([Kk]eule|[Ss](tock|tab)|[Hh]ammer|[Kk]olben)", {*})) \
		/let weapon_type=Keule%;\
		/set weapon_damage=Schlag%;\
	/elseif (regmatch("([Mm]esser|[Dd]olch)", {*})) \
		/let weapon_type=Messer%;\
		/set weapon_damage=Schnitt%;\
		/set weapon_hands 1%;\
	/elseif (regmatch("[Ss](peer|tachel)", {*})) \
		/let weapon_type=Speer%;\
		/set weapon_damage=Stich%;\
	/else \
		/test regmatch("[A-Z][a-z]+",{*})%;\
	/endif%;\
	/if ({PL} !~ "") \
		/let weapon_tmp=%PL%;\
		/if (weapon_guess_weapon) \
			/if (weapon_type=~"Speer") \
				/set weapon=$[tolower(strcat(substr({PL},0,1),\
					substr({P0},0,2)))]%;\
			/else \
				/set weapon=$[tolower(strcat(substr({PL},0,1),\
					substr({P0},0,1)))]%;\
			/endif%;\
		/endif%;\
		/if (regmatch(weapon_magic_types,{weapon_tmp})) \
			/set weapon_damage=$[strcat(weapon_damage,\
				",",\
				(toupper(substr({P1},0,1))),\
				(tolower(substr({P1},1))))]%;\
		/endif%;\
	/endif

/def shield_guess = \
	/set shield_id=$[tolower({*})]%;\
	/set shield_id=$[replace(" ","",shield_id)]%;\
	/if (shield=~"" | shield=~"auto" | shield=~"0") \
		/let shield_guess_shield 1%;\
		/set shield=$[substr(shield_id,0,shield_status_size-1)]%;\
	/endif%;\
	/set shield_long %*%;\
	/set shield_hands 1%;\
	/set shield_damage=Schild%;\
	/if (regmatch("[Ss](child|chuppe)",{*})) \
		/set shield_id=$[tolower({P0})]%;\
	/endif%;\
	/if ({PL} !~ "") \
		/let shield_tmp=%PL%;\
		/if (shield_guess_shield) \
			/set shield=$[tolower(strcat(substr({PL},0,1),\
				substr({P0},0,1)))]%;\
		/endif%;\
		/if (regmatch(weapon_magic_types,{shield_tmp})) \
			/set shield_damage=$[strcat(shield_damage,\
				",",\
				(toupper(substr({P1},0,1))),\
				(tolower(substr({P1},1))))]%;\
		/endif%;\
	/endif

/def weapon_add_new = \
	/echo -aCyellow *** neue Waffe: %*%;\
	/set weapon=$[ext_read("Waffenkuerzel ('0' fuer Abbruch, 'auto' fuer \
		automatische Erkennung): ", "auto")]%;\
	/if (weapon =~ "0") \
		/weapon_guess %*%;\
		/echo *** Waffe: nicht in Liste aufgenommen%;\
	/elseif (weapon =~ "auto") \
		/weapon_guess %*%;\
		/weapon_show%;\
		/let weapon_save=$[ext_read("Waffe in Liste aufnehmen? \
			[J/n/(e)dit] ", "J")]%;\
		/if (weapon_save =/ "j*") \
			/uaddtolist %weapon_list_name %weapon %weapon_hands \
			%weapon_id %weapon_damage %weapon_long%;\
			/return%;\
		/elseif (weapon_save !/"e*")  \
			/echo *** Waffe: nicht in Liste aufgenommen%;\
			/return%;\
		/endif%;\
	/endif%;\
;	/else \
		/weapon_guess %*%;\
		/set weapon_id=$[ext_read("Id (mit der man die Waffe im Mud \
			ansprechen kann): ", weapon_id)]%;\
		/set weapon_hands=$[ext_read("Benoetigte Haende: ", \
			weapon_hands)]%;\
		/set weapon_long=$[ext_read("Langbeschreibung: ", \
			weapon_long)]%;\
		/echo Schaden (Schlag, Stich, Schnitt, Quetschen, + fuer \
			HitFunc, Eis, Feuer, Blitz, etc.)%;\
		/set weapon_damage=$[ext_read("Schaden: ", weapon_damage)]%;\
		/uaddtolist %weapon_list_name %weapon %weapon_hands %weapon_id \
			%weapon_damage %weapon_long%;\
		/weapon_show%;\
;	/endif%;\
;	/set weapon_sl=$[strcat(substr(weapon, 0, \
;		weapon_status_size-weapon_hitfunc), weapon_hitfunc?"+":"")]

/def shield_add_new = \
	/echo -aCyellow *** neuer Schild: %*%;\
	/set shield=$[ext_read("Kuerzel ('0' fuer Abbruch, 'auto' fuer \
		automatische Erkennung): ", "auto")]%;\
	/if (shield =~ "0") \
		/shield_guess %*%;\
		/echo *** Schild: nicht in Liste aufgenommen%;\
	/elseif (shield =~ "auto") \
		/shield_guess %*%;\
		/shield_show%;\
		/let weapon_save=$[ext_read("Schild in Liste aufnehmen? \
			[J/n] ", "J")]%;\
		/if (substr(tolower(weapon_save),0,1) =~ "j") \
			/uaddtolist %shield_list_name %shield %shield_hands \
				%shield_id %shield_damage %shield_long%;\
		/else \
			/echo *** Waffe: nicht in Liste aufgenommen%;\
		/endif%;\
	/else \
		/shield_guess %*%;\
		/set shield_id=$[ext_read("Id: ", shield_id)]%;\
		/set shield_hands=$[ext_read("Benoetigte Haende: ", \
			shield_hands)]%;\
		/set shield_long=$[ext_read("Langbeschreibung: ", \
			shield_long)]%;\
		/set shield_damage=$[ext_read("Schaden: ", shield_damage)]%;\
		/uaddtolist %shield_list_name %shield %shield_hands %shield_id \
			%shield_damage %shield_long%;\
		/shield_show%;\
	/endif%;\
;        /set shield_sl=$[strcat(substr(shield, 0, \
;                shield_status_size-shield_defendfunc), \
;		shield_defendfunc?"+":"")]

/def weapon_eval_hands = \
	/set p_free_hands=$[2+zauberer_extrahand]%;\
	/if (shield_worn) \
		/set p_free_hands=$[p_free_hands-shield_hands]%;\
	/endif%;\
	/if (weapon_drawn) \
		/set p_free_hands=$[p_free_hands-weapon_hands]%;\
	/endif%;\
	/if (p_free_hands < 0) \
		/set p_free_hands 0%;\
	/endif

/def -Fp100 -q -w -mregexp -agCblue -t'^Du zueckst (den|die|das|ein(en?)? )?(.+)\\.$' weapon_zuecken = \
	/if (!weapon_quiet) \
		/echo -a%weapon_draw_color %*%;\
	/else \
		/set weapon_quiet 0%;\
	/endif%;\
	/let weapon_tmp %P3%;\
	/if (weapon_find(weapon_tmp) =~ "") \
		/input /weapon_add_new %weapon_tmp%;\
	/endif%;\
	/set weapon_drawn 1%;\
;	/set weapon_sl=%weapon_sl%;\
	/test status_get_schaden_attr(weapon,weapon_damage,"weapon_sl",weapon_status_size)%;\
	/weapon_eval_hands%;\
	/set weapon_gag 0

/def -Fp100 -q -w -mregexp -agCblue -t'^Du steckst (.+) zurueck\\.$' \
	weapon_wegstecken = \
	/if (!weapon_quiet) \
		/echo -a%weapon_draw_color %*%;\
	/else \
		/set weapon_quiet 0%;\
	/endif%;\
	/set weapon_drawn 0%;\
;	/set weapon_sl=:%weapon_status_size%;\
	/weapon_no_sl%;\
	/weapon_eval_hands

/def -Fp100 -q -w -mregexp -agCblue -t'^Du ziehst (den |die |das |ein(en?)? )?\
	(.*([Ss](child|chuppe).*)|Kieferknochen) a(n|us)\\.$' weapon_schild = \
	/if (!shield_quiet) \
		/echo -a%weapon_draw_color %*%;\
	/else \
		/set shield_quiet 0%;\
	/endif%;\
	/if ({P6} =~ "n") \
		/let shield_tmp %P3%;\
		/if (shield_find(shield_tmp) =~ "") \
			/input /shield_add_new %shield_tmp%;\
		/endif%;\
		/set shield_worn 1%;\
		/set shield=%shield%;\
                /test status_get_schaden_attr(shield,shield_damage,"shield_sl",shield_status_size)%;\
	/else \
		/set shield_worn 0%;\
		/set shield=%shield%;\
;		/set shield_sl=:%shield_status_size%;\
		/shield_no_sl%;\
	/endif%;\
	/weapon_eval_hands

/def -agCblue -Fp1 -mregexp -E(weapon_gag) -w -q -t'^Du steckst .+ in .+\\.$' \
	weapon_gag_stecken = /set weapon_gag 0

/def -agCblue -Fp1 -mglob -E(weapon_gag) -w -q -t'Du nimmst *.' \
	weapon_gag_nehmen  = /set weapon_gag 0

/def -agCblue -Fp1 -msimple -E(weapon_gag) -w -q -t'WAS willst Du nehmen?' \
	weapon_gag_was = /set weapon_gag 0

/def weapon_init_lists = \
     /loadnamedlist weapon%;\
     /loadnamedlist shield%;\
	/init_var weapon weapon_drawn shield shield_worn%;\
	/addsave weapon%;\
	/addsave weapon_drawn%;\
	/addsave shield%;\
	/addsave shield_worn%;\
;	/set shield_sl=:%shield_status_size%;\
;	/set weapon_sl=:%weapon_status_size%;

/def weapon_eval = \
	/if (weapon !~ "") \
		/weapon_set1 %weapon%;\
	/endif%;\
	/if (shield !~ "") \
		/shield_set1 %shield%;\
	/endif%;\
	/weapon_eval_hands%;\
	/weapon_no_sl%;\
	/shield_no_sl%;\

;;; nach dem Laden:

/rename_mac sw weapon_set weapon2
/rename_mac ss shield_set weapon2

/add_to_hook loadsaved /weapon_eval
/weapon_init_lists



