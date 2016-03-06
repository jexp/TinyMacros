; $Log: plakette.tf,v $
; Revision 1.12  2004/02/15 15:06:35  thufhnik
; /plakette_check funktionierte nur mit kills >999, peinlich. ;)
;
; Revision 1.11  2004/02/14 14:21:55  thufhnik
; p_eks in liste save
;
; Revision 1.10  2003/11/30 12:14:48  thufhnik
; Es gibt Leute, die richten das Teil auf sich selbst und wundern sich! ;)
;
; Revision 1.9  2003/10/22 15:52:42  thufhnik
; Forcierte Gag-Trigger ggf. loeschen
;
; Revision 1.8  2003/07/02 11:40:12  thufhnik
; Liste nach jedem Eintrag speichern, das autosave buggt leider etwas
;
; Revision 1.7  2003/06/23 12:05:40  thufhnik
; lies plakette -> lies duesterwaldplakette
;
; Revision 1.6  2003/06/19 17:17:37  thufhnik
; Liste mit Killdaten wird gespeichert
;
; Revision 1.5  2003/06/19 08:44:52  thufhnik
; Das Log sollte man drinlassen
;
; Revision 1.2  2003/06/17 14:29:28  thufhnik
; Kleinigkeiten
;
; Revision 1.1  2003/06/17 14:18:21  thufhnik
; Scratch
;

/set plakette_tf_version=$Id$
/set plakette_tf_author=Thufhir@mg.mud.de
/set plakette_tf_requires=util.repeat.tf inventory.tf properties.tf
/set plakette_tf_desc=Plakette Paraduesterwald

; Listen

/createlist plakette_auto_exclude
/addtolist plakette_auto_exclude Xetolosch

/set_var plakette_list_name kills 
/set_var plakette_list_location -c -p
/set_var plakette_auto_direct 1

; Makros und Trigger

/def -E(inv_plakette) -p0 -mglob -aCgreen -w -q -t'* richtet {ihre|seine} \
	Plakette auf Dich.' plakette = \
	/getvalueof plakette_auto_exclude %1%;\
	/if (value==error & tolower({1})!~p_name) \
		/def plakette_doit = \
			/if (plakette) \
				/unset plakette%%;\
        /if (plakette_auto_direct) \
          /send !\\\\richte plakette auf %%1%%;\
        /endif%%;\
      /endif%%;\
			/undef plakette_doit%;\
		/set plakette 1%;\
		/plakette_check%;\
		/repeat_once 1 /plakette_doit %1%;\
	/endif

/def -E(inv_plakette) -p0 -mglob -aCgreen -w -q -t'Du richtest Deine Plakette \
	auf *.' plakette_aktiv = \
	/getvalueof plakette_auto_exclude %1%;\
	/if (value==error) \
		/set plakette 1%;\
		/plakette_check%;\
	/endif

/def -E(inv_plakette&plakette) -aCblue -p0 -aCblue -msimple -q -t'Blitze \
	zucken zwischen den zwei Plaketten hin und her.' \
	plakette_challange_trig = \
	/unset plakette%;\
	/def -1 -p0 -mregexp -q -t'^Du hast ([0-9]+) Monster getoetet, \
		die ([^ ]+) noch nicht getoetet hat\\\\.$$' \
		plakette_challange1 = \
		/set plakette_challanger %%P2%%;\
		/set plakette_chall_m %%P1%%;\
		/def -1 -p0 -mregexp -q -t'^%%P2 hat ([0-9]+) Monster \
			getoetet, die Du noch nicht getoetet \
			hast\\\\\\\\.$$$' plakette_challange2 = \
			/set plakette_chall_p %%%P1%%%;\
			/repeat_once 0 /plakette_challange

/def plakette_challange = \
	/let plakette_chall_g $[p_eks+plakette_chall_p-plakette_chall_m]%;\
	/getvalueof %plakette_list_name %plakette_challanger%;\
	/if (value==error) \
		/echo -aCgreen Erstkills von %{plakette_challanger}: \
			%plakette_chall_g -%{plakette_chall_m} \
			+%{plakette_chall_p}%;\
	/else \
		/test regmatch("([0-9]+) ([0-9]+) ([0-9]+)",value)%;\
		/echo -aCgreen Erstkills von %{plakette_challanger}: \
			%{plakette_chall_g}/%{P1} -%{plakette_chall_m}/%{P2} \
			+%{plakette_chall_p}/%{P3}%;\
	/endif%;\
	/xuaddtolist %plakette_list_name&%{plakette_challanger}&\
		%{plakette_chall_g} %{plakette_chall_m} %{plakette_chall_p}%;\
	/savenamedlist plakette%;\
	/unset plakette_challanger%;\
	/unset plakette_chall_m%;\
	/unset plakette_chall_p

/def plakette_check = \
	/test getopts("f")%;\
	/if (inv_plakette | opt_f) \
		/def -1 -p3 -agCblue -mregexp -t'^ +\\\\+-+\\\\+$$' \
			plakette_g1%;\
		/def -p0 -agCblue -mregexp -t'^ +\\\\|.+\\\\|$$' \
			plakette_g2%;\
		/def -1 -p1 -agCblue -mregexp -t'^ +\\\\| +([0-9]+) +\
			verschiedene Monster getoetet, +\\\\|$$' plakette_g3 = \
			/plakette_set_eks %%P1%;\
		/def -1 -p2 -agCblue -mregexp -t'^ +\\\\+-+\\\\+$$' \
			plakette_g4 = /purge -mglob plakette_g*%;\
		/ascii_command lies duesterwaldplakette%;\
		/if (opt_f) \
			/test tf_prompt("plakette_test","/purge -mglob \
				plakette_g*")%;\
		/endif%;\
	/endif

/def plakette_set_eks = \
	/setprop eks %1%;\
	/if (p_eks > plakette_base_eks) \
		/let plakette_diff (+$[p_eks-plakette_base_eks])%;\
	/else \
		/let plakette_diff=%;\
	/endif%;\
	/echo -aCgreen Erstkills: %1 %plakette_diff

/def plakette_init = \
	/loadnamedlist plakette%;\
	/addlisttosave %{plakette_list_name} %{plakette_list_location} \
		%{plakette_list_name}%;\
	/if (p_eks) \
		/set plakette_base_eks %p_eks%;\
	/else \
		/set plakette_base_eks 0%;\
	/endif%;\
	/plakette_check -f

/add_to_hook loadsaved /plakette_init
/addsave p_eks
