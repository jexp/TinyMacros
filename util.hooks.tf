; $Log: util.hooks.tf,v $
; Revision 1.9  2002/04/16 12:20:21  mh14
; is_hook
;
; Revision 1.8  2001/10/19 14:36:11  mh14
; add_to_hook_begin zum anfuegen an den anfang eines hooks, kosmetische aenderungen
;
; Revision 1.7  2001/10/07 17:00:55  mh14
; eval_hook refaktoriert
;
; Revision 1.6  2001/09/09 19:16:59  mh14
; requires bereinigt
;
; Revision 1.5  2001/09/09 19:09:42  mh14
; help_de.list
;
; Revision 1.4  2001/09/06 21:11:44  mh14
;  Log eingefuegt
;

/set util_hooks_tf_version $Id$
/set util_hooks_tf_author=Mesirii@mg.mud.de
/set util_hooks_tf_requires=
/set util_hooks_tf_desc Hooks=einfach erweiterbare Makrolisten, die bei bestimmten Gelegenheiten aufgerufen werden koennen

/addh info \
Die Hooks sind eine Ansammlung von Befehlen, die in den Makros hook_hookname gespeichert sind. Ueber die Ausfuehrungsreihenfolge kann keine Annahme getroffen werden. Sie sind dazu praktisch, bei einem Ereignis eine Reihe vorher nicht festgelegter Anweisungen auszufuehren.
/addh see /eval_hook, /add_to_hook, /remove_from_hook, /remove_hook
/addh hooks see

/addh info \
Fuegt zu dem angegebenen Hook Anweisungen hinzu. Dabei sollte die letzte nicht mit '%;' abgeschlossen werden. Im Hook kann auf die Makroparameter Bezug genommen werden.
/addh syn /add_to_hook hookname anweisungen
/addh ex /add_to_hook reload /mload %param
/addh mak hook_%hookname
/addh version 1.01
/addh changes 1.01 testet, ob hook existiert
/addh add_to_hook mak
/def add_to_hook =\
     /if (!(ismacro(strcat("hook_",{1})))) /def hook_%1%; /endif%;\
     /if (strstr(${hook_%1},{-1})==-1) /def hook_%1=$[strcat(${hook_%1},{-1},(substr({-1},strlen({-1})-2))!~"%;"?"%;":"")] %; /endif%;

/addh info \
Fuegt dem angegebenen Hook Anweisungen als erste Anweisungen an. Dabei sollte die letzte nicht mit '%;' abgeschlossen werden. Im Hook kann auf die Makroparameter Bezug genommen werden.
/addh syn /add_to_hook_begin hookname anweisungen
/addh ex /add_to_hook_begin reload /mload %param
/addh mak hook_%hookname
/addh version 1.01
/addh changes 1.01 testet, ob hook existiert
/addh add_to_hook_begin mak
/def add_to_hook_begin =\
     /if (!(ismacro(strcat("hook_",{1})))) /def hook_%1%; /endif%;\
     /if (strstr(${hook_%1},{-1})==-1) /def hook_%1=$[strcat({-1},(substr({-1},strlen({-1})-2))!~"%;"?"%;":"",${hook_%1})] %; /endif%;

/addh info \
Entfernt aus dem angegebenen Hook vorher hinzugefuegte Anweisungen. Dazu muss der String exakt uebereinstimmen.
/addh syn /remove_from_hook hookname anweisungen
/addh ex /add_to_hook testhook /echo %*@{N}\
/remove_from_hook /echo %*
/addh remove_from_hook mak
/addh version 1.01
/def remove_from_hook =\
	/let param=$[strcat({-1},(substr({-1},strlen({-1})-2)!~"%;"?"%;":""))]%;\
	/let off=$[strstr(${hook_%1},param)]%;\
	/if (off>-1) \
	  /def hook_%1=$[strcat(substr(${hook_%1},0,off),substr(${hook_%1},off+strlen(param)))]%;\
	  /if (${hook_%1}=~"") /undef hook_%1%; /endif%;\
	/endif%;

/def clear_hook = /if (ismacro(strcat("hook_",{1}))) /undef hook_%1%; /endif%;

/addh info \
Entfernt den angegebenen Hook.
/addh syn /remove_hook hookname
/addh remove_hook mak
/def remove_hook = /undef hook_%1%;

/addh info \
Fuehrt den angegebenen Hook mit den uebergebenen Parametern aus.
/addh mak hook_%hookname
/addh version 1.01
/addh changes 1.01 Testet, ob Hook existiert.
/addh eval_hook mak

/def eval_hook = /if (ismacro(strcat("hook_",{1}))) /hook_%1 %-1%; /endif%;

/def is_hook = /return ismacro(strcat("hook_",{1}))

/addh_fileinfo
