; $Log: xalias.tf,v $
; Revision 1.4  2003/08/04 10:01:51  lje
;
; Fix fuer Fernschreiber
;
; Revision 1.3  2003/04/08 09:31:10  lje
;
; xmore auch noch berücksichtigt
;
; Revision 1.2  2003/04/07 10:23:19  lje
;
; In more-Prompts sind Aliase nun auch aus.
;
; Revision 1.1  2001/12/08 23:19:30  mh14
; erweiterte aliasnamen (?,*,..) fileinfo,log,umbenannt,config list location
;

/set xalias_tf_version $Id: xalias.tf,v 1.4 2003/08/04 10:01:51 lje Exp $
/set xalias_tf_author=Vardion@mg.mud.de
/set xalias_tf_requires=functions.tf lists.tf
/set xalias_tf_desc=Erstellung von Aliases auf Client-Basis

;;; 'xalias.tf' - Erstellung von Aliasen auf Client-Basis

;;; Version 1.00
;;; Letzte Aenderung: 15.06.2001  (c) Vardion@MorgenGrauen

;;; Abhaengigkeiten:
;;; 	- functions.tf
;;;	- Mesiriis lists.tf

;;; Dieses Paket erlaubt das Erstellen beliebiger Aliase in TF, welche
;;; beliebige Macros ausfuehren koennen. In den Macros stehen dann alle dem
;;; Alias uebergebenen Parameter in normaler Form zur Verfuegung. Dabei
;;; koennen Aliase einerseits global (fuer alle Worlds gueltig) oder lokal
;;; (nur fuer die aktuelle World bzw Charakter gueltig) angelegt werden.

;;; Liste der Zur Verfuegung gestellten Macros:
;;;
;;; /alias [-c] <befehl> <macro>
;;;	-c       : legt ein charakterspezifisches Alias an (default: global)
;;;	<befehl> : Name des Alias (Case-insensitive, da TF bei -mglob immer
;;;	           case-insensitive arbeitet)
;;;	<macro>  : Ein beliebiges Macro, welches statt des Befehles
;;;	           ausgefuehrt werden soll
;;;
;;; /ali [-c] <befehl> <macro>
;;;	Kurzschreibweise fuer /alias
;;;
;;; /mgalias [-c] <befehl> <macro>
;;;	Wie /alias, allerdings werden Parameter in Mud-Alias-Notation
;;;	akzeptiert
;;;
;;; /unalias [-c] <befehl>
;;;	-c       : loescht ein charakterspezifisches Alias (default: global)
;;;	<befehl> : Name des Alias, das geloescht werden soll
;;;
;;; /unali [-c] <befehl>
;;;	Kurzschreibweise fuer /unalias
;;;
;;; /showalias [-c] <regexp>
;;;	-c       : zeigt charakterspezifische Aliase an (default: global)
;;;	<regexp> : Regexp zur Auswahl der anzuzeigenden Aliase
;;;
;;; /loadaliases
;;;	Laedt alle Aliase neu (eher fuer internen Gebrauch ;))

;;; Mein Dank gilt uebrigens Mesirii fuer seine grosse Hilfe und
;;; diverse Verbesserungsvorschlaege :-)

; ********************* BEGIN CONFIG ********************
/set alias_list_location=-daliases
; ********************* END CONFIG ********************


/def -hREDEF -ag alias_redef

;;; Leidere bugts manchmal und Teddy-Meldungen etc werden als Prompt gewertet -
;;; deswegen der Zusatztest mit strlen() und substr()
/def -p1 -q -F -hPROMPT alias_get_prompt = \
	/set aliprompt=$[strlen({*}) < 2 & {*} !~ ']' & {*} !~ '' | \
		strlen({*}) > 1 & substr({*}, -1, 1) !~ ':' & \
		substr({*}, -1, 1) !~ '>' & \
		substr({*}, 0, 8) !~ '--mehr--' & \
		substr({*}, 0, 8) !~ '*** More']

/def alidefhook = \
	/def -p10 -mglob -E(aliprompt&!alias_call) -h'SEND {$[replace("*","[*]",(replace("?","[?]",{1})))]}*' \
		alias_ali_$[escape_macro_name({1})] = \
		/set alias_call=1%%; \
		/shift%%; \
		%-1%%; \
		/set alias_call=0

/def alias = \
	/if ({1} =~ '-c') \
		/let alilist=%privalis%; \
		/shift%; \
	/else \
		/let alilist=aliases_global%; \
		/let aliglobal=1%; \
	/endif%; \
	/if ({#} < 1) \
		/echo Syntax: /alias [-c] <aliname> <alitext>%;/break%; \
	/endif%; \
	/if ({#} == 1) \
		/showalias $[aliglobal ? '' : '-c'] %1%; \
		/break%; \
	/endif%; \
;	/if (!regmatch('^[a-zA-Z0-9_äöüÄÖÜß-]+$', {1})) \
;		/echo Ungueltiger Aliasname.%; \
;		/break%; \
;	/endif%; \
	/loadlist -q %alias_list_location %alilist%; \
	/uaddtolist %alilist %*%; \
	/savelist -q %alias_list_location %alilist%; \
	/echo $[aliglobal ? 'Globales' : ''] Alias '%1' wurde \
		definiert.%; \
	/let alias_name=$[strcat("alias_ali_",escape_macro_name({1}))]%;\
	/if (!aliglobal) \
		/purge -msimple %alias_name%; \
		/alidefhook %*%; \
		/loadlist -q %alias_list_location aliases_global%; \
		/getvalueof aliases_global %1%; \
		/if (value !~ error) \
			/echo Achtung! Neues Alias ueberschattet \
				globales Alias.%; \
		/endif%; \
	/else \
		/loadlist -q %alias_list_location %privalis%; \
		/getvalueof %privalis %1%; \
		/if (value !~ error) \
			/echo Achtung! Neues globales Alias wird von lokalem \
				Alias ueberschattet.%; \
		/else \
			/purge -msimple %alias_name%; \
			/alidefhook %*%; \
		/endif%; \
	/endif

/def ali = /alias %*

/def unalias = \
	/if ({1} =~ '-c') \
		/let alilist=%privalis%; \
		/shift%; \
	/else \
		/let alilist=aliases_global%; \
		/let aliglobal=1%; \
	/endif%; \
	/if ({#} < 1) \
		/echo Syntax: /unalias [-c] <aliname>%;/break%; \
	/endif%; \
        /loadlist -q %alias_list_location %alilist%; \
	/getdvalueof %alilist %1%; \
	/if (value !~ error) \
		/savelist -q %alias_list_location %alilist%; \
		/echo $[aliglobal ? 'Globales' : ''] Alias '%1' wurde \
			entfernt.%; \
	/else \
		/echo Ein $[aliglobal ? 'globales ' : ' ']Alias '%1' \
			existiert nicht!%; \
	/endif%; \
	/if (!aliglobal) \
		/purge -msimple alias_ali_%1%; \
		/loadlist -q %alias_list_location aliases_global%; \
		/getvalueof aliases_global %1%; \
		/if (value !~ error) \
			/echo Achtung! Globales Alias wird nun nicht mehr \
				ueberschattet.%; \
			/alidefhook %1 %value%; \
		/endif%; \
	/else \
		/loadlist -q %alias_list_location %privalis%; \
		/getvalueof %privalis %1%; \
		/if (value =~ error) \
			/purge -msimple alias_ali_%1%; \
		/endif%; \
	/endif

/def unali = /unalias %*

;;; Akzeptiert Alis mit Argumenten in MG-Notation
/def mgalias = \
	/let args=%-1%;\
	/let res=%;\
	/while (regmatch('(^|[^\\])\$([0-9]+)?(\*)?', args)) \
		/if ({P3} =~ '') \
			/test res:=strcat(res, {PL}, {P1}, '\%',{P2})%; \
		/elseif ({P2}=~'1' | {P2}=~'') \
			/test res:=strcat(res, {PL}, {P1}, '\%*')%; \
		/else \
			/test res:=strcat(res, {PL}, {P1}, '\%-',{P2}-1)%; \
		/endif%; \
		/test args:={PR}%; \
	/done%; \
	/test res:=strcat(res, args)%; \
	/alias %1 %res

/def showalias = \
	/if ({1} =~ '-c') \
		/let alilist=%privalis%; \
		/shift%; \
	/else \
		/let alilist=aliases_global%; \
		/let aliglobal=1%; \
	/endif%; \
	/if ({#} < 1) \
		/echo Syntax: /showalias [-c] <regexp>%;/break%; \
	/endif%; \
	/set showalias_matches=0%; \
	/loadlist -q %alias_list_location %alilist%; \
	/def showalias_show = \
		/if (regmatch('^%1$$', {1})) \
			/test ++showalias_matches%%; \
			/echo -- /alias %%*%%; \
		/endif%; \
	/foreach %alilist kv /showalias_show%; \
	/undef showalias_show%; \
	/if (!showalias_matches) \
		/echo Kein solches $[aliglobal ? 'globales' : 'lokales'] \
			Alias.%; \
	/endif%; \
	/unset showalias_matches

/def loadaliases = \
	/loadlist -q %alias_list_location aliases_global%; \
	/loadlist -q %alias_list_location %privalis%; \
	/purge -mglob alias_ali_*%; \
	/def -hREDEF -ag alias_redef%; \
	/foreach aliases_global kv /alidefhook%; \
	/foreach %privalis kv /alidefhook%; \
	/undef alias_redef%; \
	/echo Aliases fuer World '${world_name}' wurden geladen.

;; /savealiases ist nicht noetig, da jeder Alias beim per Hand erstellen eh
;; gespeichert wird

/def -p1 -F -hWORLD alias_world = \
	/if ({*} !~ '' & world_info('character') !~ '') \
		/set privalis=aliases_${world_name}%; \
		/loadaliases%; \
		/set aliprompt=1%; \
		/set alias_call=0%; \
	/endif

/if (world_info('character') !~ '') \
	/alias_world 1%; \
/endif

/undef alias_redef


