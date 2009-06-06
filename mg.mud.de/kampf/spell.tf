; $Log: spell.tf,v $
; Revision 1.4  2002/02/10 22:36:40  mh14
; Statuszeilendoku
;
; Revision 1.3  2001/11/27 14:01:02  mh14
; sl_* angepasst an status.tf
;
; Revision 1.2  2001/10/08 17:58:46  mh14
; spell_repeat debuggt
;
; Revision 1.1  2001/10/07 19:06:08  mh14
; Spells in Listen, mit Check auf freie Haende,Magiepunkte,Waffenwegstecken,Statusmodul fuer spell_busy,spell
;
;
/set spell_tf_version $Id$
/set spell_tf_author=Mesirii@mg.mud.de
/set spell_tf_requires=lists.tf mg_properties.tf weapon.tf
/set spell_tf_desc Spellverwaltung mit Casting,Check auf freie Haende, Kosten,Sperrzeiten, Wiederholung

/def spell_add = /createnewlist %spell_list_name%;/uaddtolist %spell_list_name %* %;
/def spell_get = /getvalueof %spell_list_name %*%;

/def spell_set = \
          /let param=%*%;\
	  /spell_get %param%;\
	  /if (value=~error) \
	     /spell_set_var %param %; /set spell_name=%-3%;\
	  /else \
	     /set spell_name=%param%; /spell_set_var %value %; \
	  /endif %;

/def spell_show = \
     /echo Spell: %spell mit %spell_hands Haenden kostet %spell_mp Magiepunkte und sperrt %spell_busy_sek Sekunden %;

/def spell_set_var = \
     /set spell_hands=%1 %;\
     /set spell_mp=%2 %;\
     /set spell_busy_sek=%3 %;\
     /set spell=%-3 %;

/def spell_cast = \
;/set spell_busy%;\
      /if (spell_next_time-time()<=0) \
        /getfirstkey spell_queue%;\
;/set value%;\
        /if (value!~error) \
	   /let spell_next=%value%;\
	   /deletekeyandvalue spell_queue %spell_next%;\
	   /if (spell_name!~"") \
	     /iskey spell_queue %spell_name%;\
	     /if (value=~error) \
               /addtolist spell_queue %spell_name%;\
	     /endif%;\
	   /endif%;\
;	   /set spell_queue%;\
	   /spell_set %spell_next%;\
        /endif%;\
      /if (p_mp>=spell_mp) \
        /if (spell!~"") \
	  /set spell_next_time=$[time()+spell_busy_sek] %;\
	  /weapon_action %spell_hands %spell%;\
	  /spell_countdown_busy %;\
	/endif%;\
      /endif%;\
      /else \
;	/echo addtolist spell_queue %spell_name%;\
	/if (spell_name!~"") \
	  /iskey spell_queue %spell_name%;\
	  /if (value=~error) \
	    /addtolist spell_queue %spell_name%; \
	  /endif%;\
	/endif%;\
      /endif %;

/def spell_remaining_time = \
     /let tmp=$[spell_next_time-time()] %;\
	/if (tmp>0) /echo Restsperrzeit: %tmp Sekunden. %; /endif %;

/def spell_next_instant =\
	/set spell_busy=0 %;\
	/set spell_next_time=$[time()]%;

/def spell_countdown_busy =\
	/let tmp=$[spell_next_time-time()] %;\
	/if (tmp>0) \
	  /set spell_busy=%tmp%; \
	  /repeat -1 1 /spell_countdown_busy%; \
	/else \
	  /set spell_busy=0%; \
	  /spell_set%; \
	  /spell_cast%; \
	/endif %;

/def spell_set_and_cast = \
     /spell_set %*%;\
     /if (value!~error) /spell_cast%; /endif %;

/def spell_repeat = \
     /if ({1}!~"_inner") /set spell_do_repeat=1%; /else /shift%;/endif%;\
     /spell_set %*%; \
     /if (value!~error & p_mp>=spell_mp & spell_do_repeat) \
        /spell_cast%;\
	/repeat -%spell_busy 1 /spell_repeat _inner %*%;\
	/set spell_repeat_runs=1%;\
	/else \
	   /set spell_repeat_runs=0%;\
	/endif%;

/def spell_cond_repeat = \
     /if ({1}!~"_inner") /set spell_do_repeat=1%;/else /shift%;/endif%;\
     /spell_set %-1%;\
     /if (value!~error & test({1}) & spell_do_repeat & p_mp>=spell_mp) \
       /spell_cast%; \
       /repeat -%spell_busy 1 /spell_cond_repeat _inner %*%;\
       /set spell_cond_repeat_runs=1%; \
     /else \
       /set spell_cond_repeat_runs=0%; \
     /endif%;

/def spell_repeat_stop = /set spell_do_repeat=0

/set sl_spell_doc=Spellabkuerzung sowie Sperrzeit bis zum naechsten Spell, oder "go" wenn keine
/def sl_spell = \
  /init_var spell_name spell_busy_sek spell_busy status_spell_busy%;\
  /set status_func_spell_busy=strcat(spell_name,(spell_busy<=0)?strcat("[",(spell_busy_sek? : "go"),"]"):strcat("[",spell_busy,"]"))%;\
  /set status_attr_spell_busy=(spell_busy<=0)?"Cgreen":(spell_busy<spell_busy_sek/2)?"Cyellow":"Cred"%;\
  /return status_var("spell_busy",6)

/set sl_spell_busy_doc=Sperrzeit bis zum naechsten Spell
/def sl_spell_busy = \
  /init_var spell_name spell_busy_sek spell_busy status_spell_busy%;\
  /set status_func_spell_busy=(spell_busy<=0)?(spell_busy_sek? : "go"):spell_busy%;\
  /set status_attr_spell_busy=(spell_busy<=0)?"Cgreen":(spell_busy<spell_busy_sek/2)?"Cyellow":"Cred"%;\
  /return status_var("spell_busy",2)
