; $Log: focus.tf,v $
; Revision 1.12  2004/03/15 12:41:09  thufhnik
; Noch ein paar Unklarheiten beseitigt
;
; Revision 1.11  2004/03/15 12:10:01  thufhnik
; flexiblere erkennung der opfer
;
; Revision 1.10  2004/01/21 18:41:07  thufhnik
; Stringbehandlung in util.namestr.tf ausgelagert, wird noch oefter gebraucht
;
; Revision 1.9  2003/11/09 15:41:29  thufhnik
; Dunkelelfen trigger geaendert
;
; Revision 1.8  2003/09/22 14:48:47  thufhnik
; Dunkelelfen
; kleinere Sprachliche Feinheiten
;
; Revision 1.7  2003/09/05 16:01:14  thufhnik
; Hook focus_hook mit dem Opfer als Parameter
;
; Revision 1.6  2003/08/05 12:56:49  thufhnik
; Dunkelelfen Spell-Miss
;
; Revision 1.5  2003/06/28 18:22:59  rumburuk
; Changelog fehlte
;

/set focus_tf_version=$Id$
/set focus_tf_author=Thufhir@mg.mud.de
/set focus_tf_requires=reduce.tf util.vfunc.tf util.hooks.tf util.namestr.tf
/set focus_tf_desc=Automatisches Setzen eines Opfers in der Variable %opfer

;;; Variablen initialisieren
/set opfer=
/set opfer_time 0
/set opfer_regexp_opfer=[A-Z][A-Za-z\\-]+
/set focus_gilde 0

;;; Konfigurierbares
/set_var OPFER_CHANGE_TIME 15

;;; Trigger und Macros ab hier

/def focus = \
	/set opfer_pref=$[tolower({*})]%;\
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
	/let focus_name=$(/util_namestr_shorten $[tolower({P0})])%;\
	/if (focus_name =/ "*waechter*") \
		/let focus_name=waechter%;\
	/elseif (focus_name =/ "*wache*") \
		/let focus_name=wache%;\
	/endif%;\
	/return focus_name

/def -msimple -Fp20 -q -w -E(!focus_gilde) -t'Ok.' focus_new_fight = \
	/set opfer=%;\
	/set opfer_time 0

/ifdef (p_guild=~'dunkelelfen') -mregexp -Fp1000 -w -q -t'^(Auf wen|We[nm]) \
	willst Du .*\\?$' focus_spell_miss = \
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
		/let focus_tmp=$[focus_get_name(RE_OPFER)]%;\
		/if (opfer=~focus_tmp) \
			/set opfer_time=$[time()]%;\
		/elseif (opfer_pref !~ '' & focus_tmp =/ strcat('*',opfer_pref,'*')) \
			/set opfer=%{opfer_pref}%;\
			/set opfer_time=$[time()]%;\
		/elseif (opfer=~'' | (time()-opfer_time)>OPFER_CHANGE_TIME) \
			/set opfer=%{focus_tmp}%;\
			/set opfer_time=$[time()]%;\
			/echo -aCgreen -- Focus: %opfer%;\
			/if /ismacro eval_hook%; /then \
				/eval_hook focus_hook %opfer%;\
			/endif%;\
		/endif%;\
	/endif

;;; Beim Start

/if /ismacro compile_regexp%; /then \
	/compile_regexp opfer_regexp_opfer%;\
/endif
/add_to_hook re_ausgabe /focus_detect
