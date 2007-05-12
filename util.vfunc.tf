; $Log: util.vfunc.tf,v $
; Revision 1.25  2002/08/28 13:13:49  thufhnik
; im free die warning auch raus
;
; Revision 1.24  2002/08/28 13:11:34  lje
; bloede warning...
;
; Revision 1.23  2002/08/28 12:57:52  lje
; compile/free_regexp koennen nun ganze gruppen von Variablen (ueber glob-Pattern) bearbeiten
;
; Revision 1.22  2002/08/26 20:01:49  mh14
; /set_var debuggt
;
; Revision 1.21  2002/08/22 09:24:47  thufhnik
; hngl, und gleich nen bug
;
; Revision 1.20  2002/08/22 09:23:08  thufhnik
; ueberpruefung bei den regexp ob extension vorhanden
;
; Revision 1.19  2002/08/22 09:13:42  thufhnik
; /compile_regexp und /free_regexp hinzugefuegt
;
; Revision 1.18  2002/04/03 13:23:39  thufhnik
; /add -> /addh
;
; Revision 1.17  2002/04/03 13:20:51  thufhnik
; vergessenes % in set_var gefixt
;
; Revision 1.16  2002/04/03 12:27:08  mh14
; grummel
;
; Revision 1.15  2002/04/03 12:07:06  mh14
; /set_var zum Setzen von Variablen auf einen Wert wenn sie noch nicht gesetzt sind
;
; Revision 1.14  2002/04/01 19:10:29  thufhnik
; neue Funktion /set_flag
;
; Revision 1.13  2002/03/31 18:49:03  mh14
; purge_vars ist jetzt etwas optimaler
;
; Revision 1.12  2002/03/29 22:09:00  mh14
; self_update aktualisiert Variablen, /dep_var, /dset fuer abhaengige Variablen, random_param liefert nen zufaelligen parameter zuruec, get_param hat doku erhalten
;
; Revision 1.11  2001/10/08 17:49:20  mh14
; get_param holt teile einer Variablen wie Parameter
;
; Revision 1.10  2001/10/08 13:33:49  nieten
; Hilfe korrigiert
;
; Revision 1.9  2001/10/07 17:02:30  mh14
; init_var intialisiert Variablen, wenn sie noch nicht existieren, wenn ja bleiben sie unberuehrt
;
; Revision 1.8  2001/09/22 13:35:37  mh14
;  find_usages beschleunigt
;
; Revision 1.7  2001/09/16 19:53:39  mh14
; find_usages zum Auflisten aller Makros die ein Makro/eine Variable benutzen
;
; Revision 1.6  2001/09/14 22:19:53  mh14
;  inner_var fuer Aufloesung verschachtelter Variablenreferenzen
;
; Revision 1.5  2001/09/09 19:09:42  mh14
; help_de.list
;
; Revision 1.4  2001/09/06 21:11:44  mh14
;  Log eingefuegt
;

/set util_vfunc_tf_version $Id: util.vfunc.tf,v 1.25 2002/08/28 13:13:49 thufhnik Exp $
/set util_vfunc_tf_author=Mesirii@mg.mud.de
/set util_vfunc_tf_requires=
/set util_vfunc_tf_desc Variablenfunktionen, isVar, purge_vars, World lokal Variablen

/def isVar = \
     /listvar -s -msimple %*%|\
     /return {?}%;

/addh info \
Hilfsfunktionen zum Verwalten von Variablen, die nur lokal fuer eine Welt zustaendig sind.
/addh mak setw, getw, listw, unsetw, echow
/addh world_local see

/addh info \
Setzt die Variable ${world_name}_%1 auf den uebergebenen Wert. Nutzung ohne =
/addh mak getw, listw, unsetw, echow
/addh setw mak
/def setw = /test ${world_name}_%1:={-1}%;

/addh info \
Liefert den Wert der mit /setw gesetzten Variablen als Funktionsrueckgabewert oder in %?.
/addh mak setw, listw, unsetw, echow
/addh getw mak
/def getw = /return ${world_name}_%1%;

/addh info \
Listet alle Variablen auf, die lokal fuer diese Welt gesetzt sind.
/addh mak setw, unsetw, echow, getw
/addh listw mak
/def listw = /listvar ${world_name}_*

/addh info \
Loescht die Variable ${world_name}_%1, die mit /setw auf einen Wert gesetzt wurde.
/addh mak getw, listw, setw, echow
/addh unsetw mak
/def unsetw = /unset ${world_name}_%1%;

/addh info \
Gibt die angegebene Variable, die lokal fuer die aktuelle Welt gesetzt wurde, aus und gibt sie gleichzeitig als Funktionswert bzw. in %? zurueck.
/addh mak getw, listw, setw, unsetw
/addh echow mak
/def echow = /result ${world_name}_%1%;

/def purge_vars = \
	/quote -S /unset `/listvar -s %{*}%;\

/def rem_purge_vars = \
	/let purge_vars=$(/listvar -s %{*})%;\
	/let off=$[strchr(purge_vars," ")]%;\
	/while (off>-1) \
	   /unset $[substr(purge_vars,0,off)]%;\
	   /let purge_vars=$[substr(purge_vars,off+1)]%;\
	   /let off=$[strchr(purge_vars," ")]%;\
	/done%;\
	/unset %purge_vars%;

/addh info \
Erlaubt den Zugriff auf beliebig tief aufeinander verweisende Variablen (z.B. a2="a1" a1="a0" a0=5).
/addh syn /inner_var [tiefe] varname
/addh ex a2="a1" a1="a0" a0=5@{N}\
/inner_var a2 -> "a1"@{N}\
/inner_var 1 a2 -> "a1"@{N}\
/inner_var 2 a2 -> "a0"@{N}\
/inner_var 3 a2 -> "5"
/addh inner_var func

/def inner_var = \
     /if ({1}=/"[0-9]*") /let inner_var_num=%{1}%; /shift%; \
     /else /let inner_var_num=1%; /endif%;\
     /if (--inner_var_num==0) /return %{1}%; \
     /else /return inner_var(inner_var_num,%{1})%; \
     /endif%;

/addh info \
Listet alle Verwendungen des angegebenen Strings (Variable, Makroname) in allen Makros, die dem vorgegebenen Suchmuster (fuer list) entsprechen.
/addh syn /find_usages varname [List Pattern]
/addh ex /find_usages addtolist *find*@{N}\
/find_usages wecho_attr
/addh return per /result und in find_usage_list
/addh find_usages mak

/def find_usages = \
     /set find_usage_list=%;\
     /quote -S /find_usages_add_name `/list -s =*%**%;\
     /test find_usage_list:=substr(find_usage_list,2)%;\
     /result find_usage_list

/addh info \
Fuegt alles ab dem 3. Parameter der Variablen %find_usage_list hinzu.
/addh find_usages_add_name mak

/def find_usages_add_name = \
     /test find_usage_list:=strcat(find_usage_list,", ",{-2})%;

/addh info \
Initialisiert die uebergebenen Variablen als globale Variablen, wenn sie noch nicht gesetzt sind; wenn sie schon gesetzt sind, bleiben sie unberuehrt.
/addh init_var mak

/def init_var = /while ({#}) /eval /set %1=\%%1%;/shift%;/done

/addh info \
Liefert den Parameter zurueck fuer den die Substitution von %1 zutrifft, praktisch um auf eine Space separierte Liste von Worte zuzugreifen
/addh syn /get_param subst param1 param2 ...
/addh ex /get_param 1 a b c -> a@{N}\
/get_param L a b c -> c@{N}\
/get_param -L a b c -> a b@{N}\
/get_param -1 a b c -> b c@{N}\
/get_param 3 a b c -> c
/addh get_param mak
/def get_param = \
     /let param=%1%;\
     /shift%;\
     /return {%param}

/addh info \
Liefert zufaellig einen der uebergebenen Parameter zurueck, wenn keine uebergeben wurden, dann einen Leerstring
/addh ex /random_param a b c -> Ergebnis a oder b oder c
/addh random_param mak

/def random_param = \
        /return {$[rand({#})+1]}

/addh info Erzeugt eine Liste abhaengiger Variablen von der angegebenen Variablen X, diese werden beim Setzen dieser Variablen X per /dset mit aktualisiert (per Selbstzuweisung, so dass sie z.B. in der Statuszeile aktualisiert werden).@{N}\
Mit nur einem Parameter werden die abhaengigen Variablen angezeigt
/addh see /undep_var, /dset
/addh syn /dep_var varname [depending_var]
/addh ex /dep_var a b@{N}\
/dep_var a (Zeigt Liste an)
/addh dep_var mak
      
/def dep_var = \
     /if ({#}>1 & {1}!~{2}) \
        /if (!isVar(strcat("dep_var_",{1}))) \
	   /set dep_var_%1=%; \
	/endif%;\
        /if /test (dep_var_%1!/strcat("*{",{2},"}*"))%; /then \
          /test dep_var_%1:=strcat(dep_var_%1," ",{2}," ")%;\
	/endif%;\
     /endif%;\
     /if ({#}==1) \
        /eval /echo Depending on %1 are: \%dep_var_%1%;\
     /endif%;

/addh info \
Loescht Variablen aus der Liste der abhaengigen Variablen der zuerst angegebenen Variablen
/addh syn /undep_var varname depending_var
/addh see /dep_var, /dset
/addh ex /undep_var a b
/addh undep_var mak

/def undep_var = \
     /if ({#}>1 & {1}!~{2} & (isVar(strcat("dep_var_",{1})))) \
        /test dep_var_%1:=replace(strcat(" ",{2}," "),"",dep_var_%1)%;\
     /endif%;\

/addh info \
Setzt die angegebene Variable auf den Wert, arbeitet genau wie /set nur dass abhaengige Variablen aktualisiert werden (d.h. per Selbstzuweisung /test a:=a) so dass die Statuszeile sie aktualisiert anzeigt. Wichtig ist das, wenn die Attribute (status_attr_varname) oder Anzeige (status_var|func_varname sich aus aus der hier gesetzten Variablen ergeben. Das passiert aber nur, wenn sich der Wert wirklich geaendert hat!
/addh syn /dset varname[[=| ]value]
/addh ex /dset a=10@{N}\
/dset a (Zeigt wie /set an)
/addh see dep_var, undep_var
/addh dset mak

/def dset = \
     /if ({1}!/"*=*") \
       /if ({#}>1) \
         /dset %1=%-1%;\
       /else \
         /set %1%;\
       /endif%;\
     /else \
       /let off=$[strchr({1},"=")]%;\
       /let dset_var=$[substr({1},0,off)]%;\
       /let dset_value=$[substr({*},off+1)]%;\
       /if /test ("%dset_var"!~dset_value)%; /then \
	    /set %*%;\
	    /eval /self_update \%dep_var_%{dset_var}%;\
       /endif%;\
     /endif%; \

/addh info \
Aktualisiert die angegebenen Variablen durch eine Selbstzuweisung (/test a:=a), damit sie eine Aktualisierung der  Statuszeile hervorrufen
/addh see /dep_var,/dset,/undep_var
/addh syn /self_update var1 var2 ...
/addh ex /self_update a b c
/addh self_update mak

/def self_update = \
     /while ({#}) \
        /test %{1}:=%{1}%;\
	/shift%;\
     /done%;

/addh info \
Setzt die Variable auf 1 wenn sie bisher nicht definiert oder Null war. Ansonsten wird eine Selbstzuweisung durchgefuehrt.
/addh see /self_update
/addh syn /set_flag var1
/addh ex /set_flag a
/addh set_flag mak

/def set_flag = \
     /set %1%|\
     /if (!{?}) \
        /set %1=1%;\
     /else \
        /test %{1} := %{1}?%{1}:1%;\
     /endif

/addh info \
Setzt die Variable auf den angegeben Wert, falls sie noch nicht gesetzt war
/addh syn /set_var varname value
/addh ex /set_var a bac
/addh set_var mak

/def set_var = \
     /if ({*}=/"*=*") \
        /let set_var=$[substr({*},0,strchr({*},'='))]%;\
	/set %set_var%|\
	/let do_set=%?%;\
     /else \
	/set %1%|\
	/let do_set=%?%;\
     /endif%;\
     /if (!{do_set}) \
        /set %*%;\
     /endif%;

/addh info \
Falls die Erweiterung 'REGCOMP' vorhanden ist, wird die uebergebene Variable, die eine regexp enthaelt, vorkompiliert.
/addh syn /compile_regexp glob_pattern
/addh ex /compile_regexp way_regexp_*
/addh compile_regexp
/def compile_regexp = \
	/if (have_ext('REGCOMP')) \
		/if ({1} =/ '*\\**' | {1} =/ '*\\?*') \
			/quote -S /compile_single_regexp `/listvar -mglob \
				-s %1%; \
		/else \
			/compile_single_regexp %1%; \
		/endif%; \
	/endif

/def compile_single_regexp = \
	/test %1:=regcomp(%1)

/addh info \
Falls die Erweiterung 'REGCOMP' vorhanden ist, wird die uebergebene Regexp wieder freigegeben.
/addh syn /free_regexp glob_pattern
/addh ex /free_regexp RE_REGEXP_*
/addh free_regexp
/def free_regexp = \
	/if (have_ext('REGCOMP')) \
		/if ({1} =/ '*\\**' | {1} =/ '*\\?*') \
			/quote -S /free_single_regexp `/listvar -mglob \
				-s %1%; \
		/else \
			/free_single_regexp %1%; \
		/endif%; \
	/endif

/def free_single_regexp = \
	/test regfree(%1)

/addh_fileinfo
