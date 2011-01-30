; $Log: util.namestr.tf,v $
; Revision 1.3  2004/01/22 07:08:13  thufhnik
; winziges update
;
; Revision 1.2  2004/01/21 18:08:56  thufhnik
; =~ muss =/ heissen
;
; Revision 1.1  2004/01/21 18:04:19  thufhnik
; Scratch
;

/set util_namestr_tf_version=$Id: util.namestr.tf,v 1.3 2004/01/22 07:08:13 thufhnik Exp $
/set util_namestr_tf_author=Thufhir@mg.mud.de
/set util_namestr_tf_requires=util.vfunc.tf
/set util_namestr_tf_desc=Bearbeitung von Namen und Strings

;;; Variablen initialisieren
/set_var util_namestr_exclude_shorten=(besen|chen|kapitaen|schatten|schemen|\
	tropfen|wagen|wesen)$
/set_var util_namestr_must_shorten2=(baeren|daemonen|giganten)$
/set_var util_namestr_must_shorten1=(drachen)$
/set_var util_namestr_article=^([Ee]in(e[nmsr]?)?|[Dd](ie|as|e[rnms])) 

;;; Macros ab hier

/def util_namestr_shorten = \
	/if (regmatch(util_namestr_must_shorten2,{*})) \
		/echo -- $[substr({*},0,-2)]%;\
	/elseif (({*}=/'*en' & !regmatch(util_namestr_exclude_shorten,{*})) \
	    | regmatch(util_namestr_must_shorten1,{*})) \
		/echo -- $[substr({*},0,-1)]%;\
	/else \
		/echo -- %*%;\
	/endif

/def util_namestr_drop_article = \
	/if (regmatch(util_namestr_article,{*})) \
		/echo -- %PR%;\
	/else \
		/echo -- %*%;\
	/endif

;;; Beim Start

/if /ismacro compile_regexp%; /then \
	/compile_regexp util_namestr_article%;\
	/compile_regexp util_namestr_must_shorten2%;\
	/compile_regexp util_namestr_must_shorten1%;\
	/compile_regexp util_namestr_exclude_shorten%;\
/endif
