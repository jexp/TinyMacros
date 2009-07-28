/set notes_tf_version $Id$
/set notes_tf_author=Mesirii@mg.mud.de
/set notes_tf_requires=
/set notes_tf_desc=Notes for rooms

/createnewlist notes

/def note_triggers = \
   /set note_triggers=%;\
   /foreach notes k /note_triggers2%;\
   /if (note_triggers!~"") \
       /def -mregexp -t\"^($[escape("",escape(".?*+()",note_triggers))])\$\" -p0 t_note_trigger = /test note_trigger({*})%;\
   /else \
       /purge t_note_trigger%;\
   /endif%;

/def note_triggers2 = \
   /test note_triggers:=(note_triggers=~"") ? {*} : strcat(note_triggers,"|",{*})

/def loadnotes = \
   /loadlist -c notes%;\
   /note_triggers

/loadnotes

/def note_trigger = \
     /getvalueof notes %*%;\
     /echo -aCgreen %value

/def note = \
     /set note=%*%;\
     /trig_grab -ag -C"%mud_short_look"  -p10000 -F0 -M"/note2 -s'.' " -n1

/def lnote = \
     /set note=%*%;\
     /trig_grab -ag -C"%mud_look_command" -p10000 -F0 -M/note2 -Blnote -Elnote 

/def note2 = \
     /test getopts("s:")%;\
     /let _key=%;\
     /test _key:={*}%;\
     /let _off=$[strstr(_key,"@{N}")]%;\
     /if (_off!=-1) /test _key:=substr(_key,0,_off)%;/endif%;\
     /if (opt_s!~"") /test _key:=strcat(_key,opt_s)%; /endif%;\
     /echo -aBCyellow Adding Note: %note for %_key%;\
     /test uaddtolist("notes",{_key},note)%;\
     /savelist -c notes%;\
     /note_triggers
