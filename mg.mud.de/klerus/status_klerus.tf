; $Log: status_klerus.tf,v $
; Revision 1.10  2003/10/08 09:58:33  thufhnik
; Talismantrigger sauberer
;
; Revision 1.9  2003/06/28 09:34:28  thufhnik
; Lernen einfaerben
;
; Revision 1.8  2002/09/10 13:14:34  thufhnik
; Nutzung von repeat_once fuer GM.
;
; Revision 1.7  2002/04/20 15:55:07  thufhnik
; 1. Anpassung an /configure
;
; Revision 1.6  2002/04/16 14:21:55  thufhnik
; Bug in Weihe Waffe gefixt
; Erschoepfung
;
; Revision 1.5  2002/03/05 10:12:51  thufhnik
; Reportmeldung nach dem Einloggen einstellen
;
; Revision 1.4  2002/03/04 07:53:14  thufhnik
; Autokampf (beta)
;
; Revision 1.3  2002/02/24 12:23:57  thufhnik
; Gebete, Spaltung, Lebenskraft, Goetterzorn
;
; Revision 1.2  2002/02/22 16:41:02  thufhnik
; Elementarsphaere und Weihe
;
; Revision 1.1  2002/02/22 14:28:44  thufhnik
; Scratch
;

/set status_klerus_tf_version $Id$
/set status_klerus_tf_author=Thufhir@mg.mud.de
/set status_klerus_tf_requires=util.repeat.tf config.tf(1.16)
/set status_klerus_tf_desc=Statuszeile fuer die Klerikergilde

;;; Konfigurierbares

/set_var CFG_ECHO_GAG_LEVEL 2

; Lernen
/set_var CFG_MG_KLERUS_LEARN_ECHO_ATTR Cbggreen,Cwhite

;;; Variablen initialisieren

/set klerus_busy 0
/set klerus_quiet 0
/set klerus_gs 0
/set klerus_scheisse 0
/set klerus_hs 0
/set klerus_mk 0
/set klerus_w 0
/set klerus_gm= 
/set klerus_es=
/set klerus_ep=
/set klerus_es_type=erde

;;; Statuszeilenmodule

/set sl_klerus_gs_doc=Glaubensstaerke (0-12, gelb unterlegt wenn mit Scheisse beschmierter Talisman, rot hinterlegt beim Beten)
/def sl_klerus_gs = \
	/init_var klerus_gs%;\
	/set status_attr_klerus_gs=klerus_busy?"Cbgred":klerus_scheisse?\
		"Cbgyellow,Cblack":"Cgreen"%;\
	/return status_var("klerus_gs",2)

/set sl_klerus_hs_doc=Heiligenschein (H)
/def sl_klerus_hs = \
	/init_var klerus_hs%;\
	/set status_func_klerus_hs=klerus_hs?"H":""%;\
	/return status_var("klerus_hs",1,%KLERUS_HS_F)

/set sl_klerus_w_doc=Weihe (W)
/def sl_klerus_w = \
	/init_var klerus_w%;\
	/set status_func_klerus_w=klerus_w?"W":""%;\
	/return status_var("klerus_w",1,%KLERUS_WEIHE_F)

/set sl_klerus_mk_doc=Messerkreis (M)
/def sl_klerus_mk = \
	/init_var klerus_mk%;\
	/set status_func_klerus_mk=klerus_mk?"M":""%;\
	/return status_var("klerus_mk",1,%KLERUS_MK_F)

/set sl_klerus_gm_doc=Goettermacht (G, ~ nicht moeglich)
/def sl_klerus_gm = \
	/init_var klerus_gm%;\
	/return status_var("klerus_gm",1)

/set sl_klerus_es_doc=Elementarschild (E: Erde, F: Feuer, W: Wasser, L: Luft \
	K: Kaelte)
/def sl_klerus_es = \
	/init_var klerus_es%;\
	/return status_var("klerus_es",1)

/set sl_klerus_ep_doc=Elementarsphaere (E: Erde, F: Feuer, W: Wasser, L: Luft \
	K: Kaelte)
/def sl_klerus_ep = \
	/init_var klerus_ep%;\
	/return status_var("klerus_ep",1)

;;; Makros & Trigger

; Heiligenschein

/def -Fp20 -agCblue -msimple -t'Lembold erhoert Dich. Ueber Deinem Haupt \
	erscheint ein Heiligenschein.' klerus_hs = \
	/set status_attr_klerus_hs %KLERUS_HS_F%;\
	/set klerus_hs 1%;\
	/echo -aCgreen Heiligenschein

/def -Fp20 -aCyellow -msimple -t'Dein Heiligenschein flackert.' \
	klerus_hs_warn = \
	/set status_attr_klerus_hs=%KLERUS_HS_F2%;\
	/set klerus_hs 1

/def -Fp20 -agCblue -msimple -t'Dein Heiligenschein verglimmt.' \
	klerus_hs_out = \
	/set klerus_hs 0%;\
	/echo -aCred Heiligenschein AUS%;\
	/if /ismacro autokampf_update%; /then \
		/autokampf_update heiligenschein%;\
	/endif

/def -Fp20 -aCgreen -msimple -t'Aber ueber Deinem Haupt schwebt doch \
	schon ein Heiligenschein!' klerus_hs_already = \
	/set klerus_hs 1

; Messerkreis

/def -Fp20 -agCblue -msimple -t'Kandri erfasst Dich mit ihrer Macht! \
	Du beginnst zu gluehen! Das Gluehen' klerus_mk = \
	/purge -mglob klerus_mk_g*%;\
	/def -F -1 -p20 -agCblue -msimple -t'weitet sich langsam aus und \
		verdichtet sich zu einem leuchtenden Kreis um' klerus_mk_g1%;\
	/def -F -1 -p20 -agCblue -msimple -t'Deinen Koerper. Aus dem \
		Leuchten heraus kondensieren auf einmal wirbelnde' \
		klerus_mk_g2%;\
	/def -F -1 -p20 -agCblue -msimple -t'Messer, die jeder Bewegung \
		Deines Koerpers folgen.' klerus_mk_g3%;\
	/set status_attr_klerus_mk=%KLERUS_MK_F%;\
	/set klerus_mk 1%;\
	/echo -aCgreen Messerkreis

/def -Fp20 -aCyellow -msimple -t'Die wirbelnden Messer werden langsamer.' \
	klerus_mk_warn = \
	/set status_attr_klerus_mk=%KLERUS_MK_F2%;\
	/set klerus_mk 1

/def -Fp20 -agCblue -msimple -t'Der Kreis wirbelnder Messer verschwindet \
	wieder.' klerus_mk_out = \
	/set klerus_mk 0%;\
	/echo -aCred Messerkreis AUS%;\
	/if /ismacro autokampf_update%; /then \
		/autokampf_update messerkreis%;\
	/endif

/def -Fp20 -aCgreen -msimple -t'Aber Du stehst schon inmitten eines \
	Messerkreises!' klerus_mk_already = \
	/set klerus_mk 1

; Goettermacht

/def klerus_can_gm = \
	/set status_attr_klerus_gm=%KLERUS_GM_F%;\
	/set klerus_gm=%;\

/def -Fp20 -agCblue -msimple -t'Du erflehst die Macht der Goetter.' \
	klerus_gm = \
	/purge -mglob klerus_gm_g*%;\
	/def -1 -Fp20 -agCblue -msimple -t'Eine goettliche Aura huellt Dich \
		ein.' klerus_gm_g1%;\
	/def -1 -Fp20 -agCblue -mregexp -t'Als Dich die Aura umhuellt, \
		spuerst Du einen( kleinen| grossen|) Teil der Macht der' \
		klerus_gm_g2 = \
		/if ({P1} =~ " kleinen") \
			/let KLERUS_GM_STAT=(-)%%;\
			/set status_attr_klerus_gm=%KLERUS_GM_F%%;\
		/elseif ({P1} =~ " grossen") \
			/let KLERUS_GM_STAT=(+)%%;\
			/set status_attr_klerus_gm=%KLERUS_GM_F3%%;\
		/else \
			/let KLERUS_GM_STAT=%%;\
			/set status_attr_klerus_gm=%KLERUS_GM_F2%%;\
		/endif%%;\
		/set klerus_gm G%%;\
		/echo -aCgreen Goettermacht %%KLERUS_GM_STAT%%;\
		/repeat_once 300 /klerus_can_gm%;\
	/def -1 -Fp20 -agCblue -msimple -t'Goetter.' klerus_gm_g3

/def -Fp20 -agCblue -q -msimple -t'Die goettliche Aura verlaesst Dich \
	wieder.' klerus_gm_out = \
	/set status_attr_klerus_gm=%KLERUS_GM_FF%;\
	/set klerus_gm=~%;\
	/echo -aCred Goettermacht AUS

/def -Fp20 -aCred -q -msimple -t'Die Goetter haben sich vor kurzem erst um \
	Dich gekuemmert!' klerus_gm_no

; Elementarschilde

/def klerus_do_es = \
	/send !\\elementarschild %klerus_es_type

; Elementarschild Erde

/def -Fp20 -agCblue -msimple -t'Die Erde zu Deinen Fuessen woelbt sich und \
	bricht auf. Ein irdener Schild' klerus_ese = \
	/purge -mglob klerus_ese_g*%;\
	/def -1 -Fp20 -agCblue -mregexp -t'schiesst empor und umgibt \
		(.+)\\\\.' klerus_ese_g1 = \
		/if ({P1} =~ 'Dich') \
			/set status_attr_klerus_es=%%KLERUS_ESE_F%%;\
			/set klerus_es=E%%;\
			/set klerus_es_type=erde%%;\
			/echo -aCgreen Elementarschild Erde%%;\
		/else \
			/echo -aCgreen Elementarschild Erde %%P1%%;\
		/endif

; Elementarschild Feuer

/def -Fp20 -agCblue -mregexp -t'^Eine Stichflamme schiesst (vor Dir )?aus \
	dem Boden und umgibt (.+) mit einem' klerus_esf = \
	/purge -mglob klerus_esf_g*%;\
	/def -1 -Fp20 -agCblue -mglob -t'*Schild.' klerus_esf_g1%;\
	/if ({P2} =~ "Dich") \
		/set status_attr_klerus_es=%KLERUS_ESF_F%;\
		/set klerus_es=F%;\
		/set klerus_es_type=feuer%;\
		/echo -aCgreen Elementarschild Feuer%;\
	/else \
		/echo -aCgreen Elementarschild Feuer %P2%;\
	/endif

; Elementarschild Wasser

/def -Fp20 -agCblue -msimple -t'Ein ploetzlicher Regenschauer prasselt \
	hernieder, ohne Dich jedoch zu' klerus_esw = \
	/purge -mglob klerus_esw_g*%;\
	/def -1 -Fp20 -agCblue -msimple -t'durchnaessen. Statt dessen \
		umgibt Dich nun ein Schild aus Wasser.' klerus_esw_g1 = \
		/set status_attr_klerus_es=%KLERUS_ESW_F%%;\
		/set klerus_es=W%%;\
		/set klerus_es_type=wasser%%;\
		/echo -aCgreen Elementarschild Wasser

; Elementarschild Luft

/def -Fp20 -agCblue -msimple -t'Ein starker Wind umtost Dich auf einmal \
	und bildet so einen luftigen Schild.' klerus_esl = \
	/set status_attr_klerus_es=%KLERUS_ESL_F%;\
	/set klerus_es=L%;\
	/set klerus_es_type=luft%;\
	/echo -aCgreen Elementarschild Luft

; Elementarschild Kaelte

/def -Fp20 -agCblue -msimple -t'Klirrende Kaelte umgibt Dich auf einmal \
	schuetzend.' klerus_esk = \
	/set status_attr_klerus_es=%KLERUS_ESK_F%;\
	/set klerus_es=K%;\
	/set klerus_es_type=kaelte%;\
	/echo -aCgreen Elementarschild Kaelte

; Elementarschilde klingen ab

/def -Fp20 -aCyellow -msimple -t'Dein Elementarschild wird duenner.' \
	klerus_es_warn = \
	/if (!regmatch("[EFWLK]", klerus_es)) \
		/set klerus_es=E%;\
	/endif%;\
	/eval /set status_attr_klerus_es %%KLERUS_ES%{klerus_es}_F2%;\
	/set klerus_es %klerus_es

/def -Fp20 -agCblue -msimple -t'Der Elementarschild zerfaellt.' \
	klerus_es_out = \
	/set klerus_es=%;\
	/echo -aCred Elementarschild AUS%;\
	/if /ismacro autokampf_update%; /then \
		/autokampf_update /klerus_do_es%;\
	/endif

; Elementarsphaere

/def -Fp20 -agCblue -msimple -t'Ein Reissen geht durch Deinen Koerper, und \
	die Welt um Dich herum scheint zu' klerus_ep = \
	/purge -mglob klerus_ep_g*%;\
	/def -1 -Fp20 -agCblue -msimple -t'verschwimmen. Kandri bedient \
		sich der Grundlagen von Lembolds Schoepfung, und' \
		klerus_ep_g1%;\
	/def -1 -Fp20 -agCblue -mregexp -t'um Dich herum erscheint ein \
		Blase aus kristalline[mr] (Feuer|Wasser|Erde|Kaelte|Luft)\
		\\\\. Dann wird Deine' klerus_ep_g2 = \
		/let klerus_tmp=$$[substr({P1},0,1)]%%;\
		/eval /set status_attr_klerus_ep \
			%%%KLERUS_ES%%{klerus_tmp}_F%%;\
		/set klerus_ep %%klerus_tmp%%;\
		/echo -aCgreen Elementarsphaere %%P1%;\
	/def -1 -Fp20 -agCblue -msimple -t'Wahrnehmung wieder scharf.' \
		klerus_ep_g3

/def -Fp20 -aCyellow -msimple -t'Deine Elementarsphaere bekommt duenne \
	Stellen.' klerus_ep_warn = \
	/if (!regmatch("[EFWLK]", klerus_ep)) \
		/set klerus_ep=E%;\
	/endif%;\
	/eval /set status_attr_klerus_ep %%KLERUS_ES%{klerus_ep}_F2%;\
	/set klerus_ep %klerus_ep

/def -Fp20 -agCblue -msimple -t'Die Elementarsphaere loest sich auf.' \
	klerus_ep_out = \
	/set klerus_ep=%;\
	/echo -aCred Elementarsphaere AUS

; Weihe Waffe

/def -Fp20 -agCblue -q -mregexp -t'^Du sprichst ein kurzes, inbruenstiges \
	Gebet\\.' klerus_weihe_w = \
	/purge -mglob klerus_weihe_w_g*%;\
	/def -Fp1 -w -q -mregexp -agCblue -t'$$' klerus_weihe_w_g1%;\
	/def -1 -Fp2 -q -agCblue -mregexp -t'versieht\\\\.$$' \
		klerus_weihe_w_g2 = \
		/purge klerus_weihe_w_g1%%;\
		/set status_attr_klerus_w=%%KLERUS_WEIHE_F%%;\
		/set klerus_w 1%%;\
		/echo -aCgreen Weihe (Waffe)

; Weihe Handschuhe

/def -Fp20 -agCblue -mregexp -t'Lembolds Heiliger Zorn faehrt knisternd in \
	(.+)\\.' klerus_weihe_s = \
	/set status_attr_klerus_w=%KLERUS_WEIHE_S_F%;\
	/set klerus_w 1%;\
	/echo -aCgreen Weihe (%P1)

; Weihe Haende

/def -Fp20 -agCblue -msimple -t'Du fuehlst ein Kribbeln in Deinen Haenden, \
	als Lembold Dich mit seinem' klerus_weihe_h = \
	/purge -mglob klerus_weihe_h_g*%;\
	/def -1 -Fp20 -agCblue -msimple -t'Heiligen Zorn erfuellt.' \
		klerus_weihe_h_g1 = \
		/set status_attr_klerus_w=%%KLERUS_WEIHE_H_F%%;\
		/set klerus_w 1%;\
		/echo -aCgreen Weihe (Haende)

; Weihe aus

/def -Fp20 -agCblue -msimple -t'Der Heilige Zorn Lembolds ist verraucht.' \
	klerus_weihe_out = \
	/set klerus_w 0%;\
	/echo -aCred Weihe AUS

; Weihe schon an

/def -Fp20 -aCgreen -msimple -t'Du musst warten, bis die letzte Weihe \
	abgelaufen ist!' klerus_weihe_already = \
	/set klerus_w 1

; Spaltung

/def -Fp20 -agCblue -msimple -t'Die Welt verschwimmt vor Deinen Augen, als \
	Dich Kandris Macht erfasst und sie' klerus_sp = \
	/purge -mglob klerus_sp_g*%;\
	/def -1 -Fp20 -agCblue -msimple -t'Deine Staerken und Schwaechen \
		auslotet. Dann kannst Du wieder klarer sehen.' klerus_sp_g1%;\
	/def -1 -Fp20 -agCblue -msimple -t'Ein Zerren geht durch Deinen \
		Koerper, als sich neben Dir ein Abbild Deiner' klerus_sp_g2%;\
	/def -1 -Fp20 -agCblue -msimple -t'selbst aus dem Nichts schaelt.' \
		klerus_sp_g3 = /echo -aCgreen Spaltung

/def -F -p20 -aCred -mglob -t'Ein Abbild * loest sich in Wohlgefallen auf.' \
	klerus_sp_out

; Lebenskraft

/def -F -p20 -agCblue -msimple -t'Dein Talisman erwaermt sich, und Du \
	spuerst ein angenehmes Kribbeln.' klerus_lk = \
	/purge -mglob klerus_lk_g*%;\
	/def -1 -Fp20 -agCblue -msimple -t'Als das Kribbeln nachlaesst, \
		fuehlst Du Dich besser als vorher, doch Dein' klerus_lk_g1%;\
	/def -1 -Fp20 -agCblue -msimple -t'Talisman schimmert nur noch \
		matt.' klerus_lk_g2 = \
		/echo -aCgreen Lebenskraft%%;\
		/repeat -0 1 /klerus_tali_check

; Goetterzorn

/def -Fp20 -mglob -t'Du beschwoerst den Zorn der Goetter \
	gegen *.' klerus_gz = /repeat -0 1 /klerus_tali_check

; Gebet

/def -Fp100 -q -mglob -aCgreen -t'Du beginnst {inbruenstig|andaechtig|\
	aufopferungsvoll} zu beten.' klerus_gebet = \
	/set klerus_busy 1%;\
	/set klerus_gs=%klerus_gs

; Gebet beendet

/def -Fp100 -q -mregexp -aCgreen -t'^Du beendest Dein Gebet mit (einem \
	inbruenstigen \'Hiho\\!\'|einem erleichterten \'Endlich\'|einer \
	Lobpreisung Deiner spitzen Ohren\\.|einer Lobpreisung Deiner \
	pelzigen Fuesschen\\.)' klerus_gebet_ende = \
	/set klerus_busy 0%;\
	/repeat -0 1 /klerus_tali_check

/def -Fp100 -q -msimple -aCgreen -t'Du legst die Geissel beiseite und \
	beendest Dein Gebet.' klerus_gebet_ende2 = \
	/set klerus_busy 0%;\
	/repeat -0 1 /klerus_tali_check

; Erschoepfung

/def -Fp1 -q -msimple -aCred -t'So schnell koennen sich die Goetter nicht \
	wieder um Dich kuemmern!' klerus_erschoepfung

; Talicheck

/def klerus_str2gs = \
	/let __klerus_tmp %*%;\
	/if (regmatch('schwarz angelaufener?', __klerus_tmp)) \
		/echo 0%;\
	/elseif (regmatch('dunkel angelaufener?', __klerus_tmp)) \
		/echo 1%;\
	/elseif (regmatch('angelaufener?', __klerus_tmp)) \
		/echo 2%;\
	/elseif (regmatch('stumpf aussehender?', __klerus_tmp)) \
		/echo 3%;\
	/elseif (regmatch('matter?', __klerus_tmp)) \
		/echo 4%;\
	/elseif (regmatch('matt schimmernder?', __klerus_tmp)) \
		/echo 5%;\
	/elseif (regmatch('schimmernder?', __klerus_tmp)) \
		/echo 6%;\
	/elseif (regmatch('hell polierter?', __klerus_tmp)) \
		/echo 8%;\
	/elseif (regmatch('polierter?', __klerus_tmp)) \
		/echo 7%;\
	/elseif (regmatch('hell glaenzender?', __klerus_tmp)) \
		/echo 10%;\
	/elseif (regmatch('glaenzender?', __klerus_tmp)) \
		/echo 9%;\
	/elseif (regmatch('funkelnder?', __klerus_tmp)) \
		/echo 11%;\
	/elseif (regmatch('strahlender?', __klerus_tmp)) \
		/echo 12%;\
	/else \
		/echo -- -1%;\
	/endif

/def klerus_tali_out = \
	/set klerus_gs=$(/klerus_str2gs %*)%;\
	/if (!klerus_quiet) \
		/test echo(" Talisman: %klerus_gs", "Cgreen", 1)%;\
	/else \
		/set klerus_quiet 0%;\
	/endif

/def -p10 -mregexp -q -agCblue -t'^ Ein (kotverschmierter |)([a-z ]+) Talisman\
	( \\(angezogen\\)|)\\.$' klerus_tali_inv = \
	/if ({P1} !~ "") \
		/set klerus_scheisse 1%;\
	/else \
		/set klerus_scheisse 0%;\
	/endif%;\
	/klerus_tali_out %P2

/def klerus_tali_check = \
	/if (!klerus_busy & GOOD_WHO=~"") \
		/set klerus_quiet 1%;\
		/def -w -q -Fp1 -mregexp -agCblue -t'^ .+\\\\.$$' \
			klerus_invgag%;\
		/def -1 -q -w -Fp99999 -mglob -hPROMPT klerus_tali_prompt = \
			/purge klerus_invgag%;\
		/send !\\inv +a +r -f -1%;\
	/endif

; Lernen

/def -p0 -q -w -agCblue -msimple -t'Die Goetter schenken Dir eine \
	Erleuchtung.' klerus_learn = /cfg_echocolor MG_KLERUS_LEARN %*

; beim Start:

/def klerus_start = \
	/add_to_hook beat_900 /klerus_tali_check%;\
	/send !\\report vorsicht ein%;\
	/send !\\report ein%;\
	/klerus_tali_check%;\
	/config_status

/add_to_hook loadsaved /klerus_start
