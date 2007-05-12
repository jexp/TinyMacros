/set focus_tf_version=$Id: focus.tf,v 1.3 2002/11/10 11:32:32 thufhnik Exp $
/set focus_tf_author=Thufhir@mg.mud.de
/set focus_tf_requires=reduce.tf util.vfunc.tf
/set focus_tf_desc=Automatisches Setzen eines Opfers in der Variable %opfer

;;; Variablen initialisieren
/set opfer=
/set opfer_time 0
/set opfer_regexp_opfer=[A-Z][^ ]+
/set focus_gilde 0
/set focus_exclude_shorten=(besen|kapitaen|rochen|schatten|schemen|\
	tropfen|wesen)$
/set focus_must_shorten2=(baeren|daemonen|giganten)$

;;; Konfigurierbares
/set_var OPFER_CHANGE_TIME 20

;;; Trigger und Macros ab hier

/def focus = \
	/set opfer_pref=$[tolower({1})]%;\
	/set opfer=%opfer_pref%;\
	/set opfer_time=$[time()]%;\
	/if (p_guild=~'karate' & !focus_gilde & p_guild_level>=3) \
		/send !\\konzentration auf %opfer%;\
	/elseif (p_guild=~'kaempfer' & !focus_gilde & p_guild_level>=7) \
		/send !\\fokus %opfer%;\
	/else \
		/echo -aCgreen -- Focus: %opfer%;\
	/endif

/def focus_get_name = \
	/test regmatch(opfer_regexp_opfer, {*})%;\
	/let focus_name=$[tolower({P0})]%;\
	/if (regmatch(focus_must_shorten2,focus_name)) \
		/let focus_name=$[substr(focus_name,0,-2)]%;\
	/elseif (RE_ARTICLE & focus_name=/'*en' & \
	    !regmatch(focus_exclude_shorten,focus_name)) \
		/let focus_name=$[substr(focus_name,0,-1)]%;\
	/endif%;\
	/return focus_name

/def -msimple -Fp20 -q -w -E(!focus_gilde) -t'Ok.' focus_new_fight = \
	/set opfer=%;\
	/set opfer_time 0

/ifdef (p_guild=~'zauberer') -mregexp -Fp1000 -w -q -t'^(Nach )?W[Ee][MNnm] \
	moechtest Du .*\\?$' focus_spell_miss = \
	/set opfer=%;\
	/set opfer_time 0

/ifdef (p_guild=~'tanjian') -mglob -Fp1000 -w -q -t'{Wen|Auf wen} \
	moechtest Du *?' focus_spell_miss = \
	/set opfer=%;\
	/set opfer_time 0

/ifdef (p_guild=~'klerus') -mglob -Fp1000 -w -q -t'{Wen|Wem} willst Du *?' \
	focus_spell_miss = \
	/set opfer=%;\
	/set opfer_time 0

/ifdef (p_guild=~'kaempfer') -mregexp -p0 -w -q -t'^Du richtest Deine ganze \
	Aufmerksamkeit auf (.+)\\.$' focus_kaempfer_set = \
	/set focus_gilde 1%;\
	/focus $[focus_get_name({P1})]

/ifdef (p_guild=~'kaempfer') -mregexp -p0 -w -q -t'^Du konzentrierst Dich \
	doch schon auf (.+)!$' focus_kaempfer_set2 = \
	/set focus_gilde 1%;\
	/focus $[focus_get_name({P1})]

/ifdef (p_guild=~'karate') -mregexp -p0 -w -q -t'^Du konzentrierst Dich \
	jetzt auf (.+)\\.$' focus_karate_set = \
	/set focus_gilde 1%;\
	/focus $[focus_get_name({P1})]

/def focus_detect = \
	/if (RE_ANGREIFER =~'Du') \
		/set focus_gilde 0%;\
		/let focus_tmp=%;\
		/test focus_tmp:=focus_get_name(RE_OPFER)%;\
		/if (opfer=~'' | focus_tmp=~opfer_pref | \
		    (time()-opfer_time)>OPFER_CHANGE_TIME) \
			/set opfer=%focus_tmp%;\
			/set opfer_time=$[time()]%;\
			/if (focus_tmp!~opfer_pref) \
				/echo -aCgreen -- Focus: %opfer%;\
			/endif%;\
		/elseif (opfer=~focus_tmp) \
			/set opfer_time=$[time()]%;\
		/endif%;\
	/endif

;;; Beim Start

/if /ismacro compile_regexp%; /then \
	/compile_regexp opfer_regexp_opfer%;\
	/compile_regexp focus_must_shorten2%;\
	/compile_regexp focus_exclude_shorten%;\
/endif
/add_to_hook re_ausgabe /focus_detect
