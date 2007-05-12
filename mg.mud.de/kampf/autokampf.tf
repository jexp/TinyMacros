; $Log: autokampf.tf,v $
; Revision 1.4  2002/09/10 15:10:28  thufhnik
; Nutzung von repeat_once
;
; Revision 1.3  2002/03/03 19:25:07  thufhnik
; Autokampf kann jetzt auch tf-macros verarbeiten
;
; Revision 1.2  2002/02/24 20:33:03  thufhnik
; echo fuer Testzwecke entfernt
;
; Revision 1.1  2002/02/24 20:24:10  thufhnik
; Scratch
;

/set autokampf_tf_version $Id: autokampf.tf,v 1.4 2002/09/10 15:10:28 thufhnik Exp $
/set autokampf_tf_author=Thufhir@mg.mud.de
/set autokampf_tf_requires=
/set autokampf_tf_desc=Automatisches Wiedererstellen von Zaubern etc.

; Variablen initialisieren

/set autokampf 0

; die eigentlichen Macros

/def autokampf = \
	/if ({#} == 0) \
		/toggle autokampf%;\
	/elseif ({1} =~ "ein" | {1} =~ "on" | {1} =~ "an" | {1} =~ "1") \
		/set autokampf 1%;\
	/elseif ({1} =~ "aus" | {1} =~ "off" | {1} =~ "0") \
		/set autokampf 0%;\
	/else \
		/echo Syntax: /autokampf [ein|an|on|1|aus|off|0]%;\
		/return%;\
	/endif%;\
	/if (autokampf) \
		/echo -aCgreen *** Autokampf EIN%;\
	/else \
		/echo -aCgreen *** Autokampf AUS%;\
	/endif

/def autokampf_update = \
	/if (autokampf) \
		/addtolist autokampf_todo %1%;\
		/repeat_once 0 /eval_hook autokampf%;\
	/endif

/def autokampf_hook = \
  /if (autokampf) \
    /getfirstkey autokampf_todo%;\
    /if (value !~ error) \
      /let autokampf_spell=%value%;\
      /getvalueof autokampf_spells %autokampf_spell%;\
      /if (value=~error) \
        /deletekeyandvalue autokampf_todo %autokampf_spell%;\
        /repeat -0 1 /eval_hook autokampf%;\
      /else \
        /let autokampf_ison=%;\
        /test regmatch("([^ ]+) +([0-9]+) +([0-9]+)",value)%;\
        /test autokampf_ison:=$[{P1}]%;\
	/if (autokampf_ison) \
          /deletekeyandvalue autokampf_todo %autokampf_spell%;\
          /repeat -0 1 /eval_hook autokampf%;\
        /else \
          /if (p_mp >= {P3}) \
            /if (substr(autokampf_spell,0,1) !~ "/") \
               /send !\\%autokampf_spell%;\
            /else \
              /let autokampf_spell=$[substr(autokampf_spell,1)]%;\
              /%autokampf_spell%;\
            /endif%;\
          /endif%;\
          /eval /repeat -%P2 1 /eval_hook autokampf%;\
        /endif%;\
      /endif%;\
    /endif%;\
  /endif

; Sachen nach dem Laden starten

/createlist autokampf_todo
/add_to_hook autokampf /autokampf_hook
