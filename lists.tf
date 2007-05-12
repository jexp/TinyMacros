; $Log: lists.tf,v $
; Revision 1.49  2003/01/07 17:03:36  nieten
; english docs
;
; Revision 1.48  2002/10/09 22:39:06  mh14
; Mehr Moeglichkeiten (Loeschen, Hinzufuegen) bei /editlist, Fehlerueberpruefung fuer leere Listen (oder noch nicht existente
;
; Revision 1.47  2002/10/01 12:35:17  nieten
; /isList gibt das Ergebnis jetzt wieder (wie in der Hilfe beschrieben) auch in %value zurueck
;
; Revision 1.46  2002/09/28 00:42:53  mh14
; isList, isEmptyList etwas refaktoriert
;
; Revision 1.45  2002/09/17 07:27:58  mh14
; loadarray jetzt mit -a versehen, da sonst das file_exists fehlschlaegt, es kennt ja keine lokalen pfade aus TFPATH
;
; Revision 1.44  2002/09/16 13:00:10  mh14
; grummel :) man sollte nich fehler durch fehler ersetzen, {-2} statt {3} war richtig
;
; Revision 1.43  2002/09/16 12:56:39  mh14
; fehler bei /uaddtolist bei mehrteiligen keys
;
; Revision 1.42  2002/06/05 07:50:37  mh14
; /editlistvalues tut jetzt wirklich was
;
; Revision 1.41  2002/05/04 17:06:03  mh14
; grummel pedantic
;
; Revision 1.40  2002/05/04 16:38:16  mh14
; editlistvalues sollte jetzt keine pedantic fehler mehr bringen
;
; Revision 1.39  2002/04/23 13:06:50  nieten
; /loadarray testet jetzt auf Existenz des Files
;
; Revision 1.38  2002/04/22 23:45:43  mh14
; erzeugen von verzeichnissen nur bei nicht geladenen listen (bei denen ist davon auszugehen, dass das verz. exisitiert
;
; Revision 1.37  2002/04/18 22:00:14  mh14
; addtolist vereinfacht
;
; Revision 1.36  2002/04/17 01:17:11  mh14
; -a bei loadlist,hloadlist raus, savelist,hsavelist,savearray legen jetzt bei bedarf die Verzeichnisse an
;
; Revision 1.35  2002/04/16 13:02:17  mh14
;  /custom erzeugt jetzt keine globalen Variablen mehr (grosse Fehlerursache), es nutzt /ret_vars aus util.tf, die Files wurden darauf angepasst
;
; Revision 1.34  2002/04/16 12:15:40  mh14
; /editlistvalues zum Interaktiven Editieren von Listen
;
; Revision 1.33  2002/04/01 08:00:25  mh14
; hvalue Bug behoben?
;
; Revision 1.32  2002/04/01 07:52:20  mh14
; hforeach Bug behoben
;
; Revision 1.31  2002/03/31 18:47:42  mh14
; diverse optimierungen u.a. foreach(10x schneller,unmakesub,makesub,haddlisttolist,haddtolist
;
; Revision 1.30  2002/03/28 20:26:17  mh14
; bug in uaddlisttolist entfernt
;
; Revision 1.29  2002/03/28 01:09:28  mh14
; Kommentare in Arrayfiles mit ; am Zeilenanfang moeglich, ;; wird zu ;
;
; Revision 1.28  2002/03/27 23:42:14  mh14
; loadarray, savearray
;
; Revision 1.27  2002/03/14 14:28:09  nieten
; Bug in der Doku zu /iskey raus
;
; Revision 1.26  2002/03/07 14:29:46  nieten
; einige Makros fuer Hashlisten geben jetzt Ergebnis auch per /return zurueck
; Doku tw. ergaenzt
;
; Revision 1.25  2002/02/13 14:11:34  mh14
; /custom nochmal umgestellt, mit der option -a[string] haengt es makdir oder string vor den pfad dran, ansonsten ist es wieder relativ
;
; Revision 1.24  2002/02/09 15:21:00  mh14
; /custom haengt jetzt %makdir an %load_dir an, WICHTIG inkompatible aenderung! lists.tf updaten
;
; Revision 1.23  2001/12/19 19:12:45  nieten
; /getfirstvalue kommt wieder mit Leerstring als value zurecht
;
; Revision 1.22  2001/12/13 17:14:34  nieten
; Gebrauch von %value reduziert
; Etliche Makros geben ihr Ergebnis jetzt nicht nur in %value, sondern auch als Rueckgagewert zurueck. Um Seiteneffekte zu verringern, moeglichst mit dem Rueckgabewert statt mit %value arbeiten.
; neues Makro /convert_regexp
;
; Revision 1.21  2001/12/08 22:43:21  mh14
; hloadnamedlist,hsavenamedlist,xxnamedlist beruecksichtigt jetzt parameter (z.b. -q) vor dem name
;
; Revision 1.20  2001/12/03 21:51:03  mh14
; hforeach debuggt
;
; Revision 1.19  2001/11/14 20:49:06  nieten
; /reggetidxofkey und /reggetidxofvalue deutlich benschleunigt
;
; Revision 1.18  2001/11/13 00:28:44  nieten
; /count_entries etwas erweitert, /getidxofkey und /getidxofvalue deutlich beschleunigt
;
; Revision 1.17  2001/10/31 21:32:43  nieten
; /hforeach legt keine Variable mit /test mehr an
;
; Revision 1.16  2001/10/22 11:41:13  mh14
; loadnamedlist/savenamedlist fuer pakete
;
; Revision 1.15  2001/10/10 22:10:21  mh14
; Default-Konfiguration in .tf Files verschoben
;
; Revision 1.14  2001/10/01 22:17:20  mh14
; createnewlist erzeugt nur eine neue liste, wenn noch keine liste da war
;
; Revision 1.13  2001/09/30 01:20:10  mh14
; isKey gibt jetzt auch nen returnwert zurueck
;
; Revision 1.12  2001/09/22 13:38:27  mh14
; quiet list loading
;
; Revision 1.11  2001/09/19 19:28:51  mh14
; uralte bugs fuer mehrstufige >2 listen behoben
;
; Revision 1.10  2001/09/18 14:39:24  nieten
; /isList erkennt auch leere Liste, Hilfe korrigiert
; neue Funktion isEmptyList
;
; Revision 1.9  2001/09/15 19:51:07  mh14
;  scrollverringerung beim listenladen
;
; Revision 1.8  2001/09/14 22:21:34  mh14
; hsortForEach mit forEach_key,_value
;
; Revision 1.7  2001/09/13 22:06:36  nieten
; /getidxofkey, /getidxofvalue
;
; Revision 1.6  2001/09/11 23:39:36  mh14
; showlist,hshowlist erweitert fuer bedingtes anzeigen von Sublisten,
; seitenweises Anzeigen
; forEach hat jetzt die lokalen Variablen forEach_key und forEach_value, die
; in den aufgerufenen eigenen Makros genutzt werden koennen (statt der
; Parameter - Fehler bei Leerzeichen in Schluesseln)
; editlist kann schon ein wenig was :)
;
; Revision 1.5  2001/09/09 19:16:59  mh14
; requires bereinigt
;
; Revision 1.4  2001/09/06 21:11:44  mh14
;  Log eingefuegt
;

/set lists_tf_version $Id: lists.tf,v 1.49 2003/01/07 17:03:36 nieten Exp $
/set lists_tf_author=Mesirii@mg.mud.de
/set lists_tf_requires=util.tf loading.tf util.echo.tf(1.21)
/set lists_tf_desc Key-Value Listen, Arrays, Sortierfunktionen, Iteratoren ...

/addh info \
Ersetzt Parameter1 durch Parameter2 im String, der als restlicher \
Parameter angegeben ist. Das Ergebnis wird mit /result zurueckgegeben, \
also ueber $() holen. Dabei koennen Parameter1 bzw. Parameter2 auch \space fuer Leerzeichen sein.
/addh syn /sreplace (suchtext|\space) (ersetztext|\space) string
/addh ex /sreplace beutel paket oeffne beutel@{N}\
wuerde "oeffne paket" zurueckgeben.
/addh return ueber /result den veraenderten String
/addh en info Replaces parameter1 by parameter2 in the string after parameter 2. Parameter1 or parameter2 can be "\space" denoting a blank.
/addh eh syn /sreplace (old|\space) (new|\space) string
/addh en ex /sreplace bag paket open bag@{N}\
would giv "open paket".
/addh en return Returns the changed string by /result.
/addh see substitution
/addh sreplace mak

/defh sreplace = \
    /let s=%1%;\
    /let r=%2%;\
    /let param=%-2%;\
    /let off=$[strstr(param,(s!~"\\space")?s:" ")]%;\
    /let res=#%;\
    /while (off!=-1) \
        /test res:=strcat(substr(res,0,strlen(res)-1),substr(param,0,off),(r!~"\space")?r:" ","#")%;\
	/test param:=substr(param,off+strlen((s!~"\space")?s:" "))%;\
        /test off:=strstr(param,(s!~"\space")?s:" ")%;\
    /done%;\
    /result strcat(substr(res,0,strlen(res)-1),param)


/addh info \
Erlaubt einen anderen Parameterseparator als das Leerzeichen. \
Dabei werden /paramparse als Parameter1 der Separator, als Parameter2 \
die gewuenschte Position (1,2,3,... oder -1,-2,-3,...) und als Rest die \
Parameter uebergeben.@{N}\
Achtung, /paramparse verwendet regmatch(), d.h. %P1 etc. aendern ihre Werte!
/addh return ueber /return
/addh syn /paramparse Separator [-](1,2,3.,.) Parameter
/addh ex Nach@{N}\
@{}  /set a=$[paramparse("&",3,"Das hier&ist aber& ein bloe&des Beispiel")]@{N}\
@{}  /set b=$(/paramparse & -3 Das hier&ist aber& ein bloe&des Beispiel)@{N}\
haette %a den Wert " ein bloe" und %b "ist aber".
/addh en info \
Allows the usage of a given separator for parameters instead of blanks. Parameter1 for /paramparse is the new separator, parameter2 the position (1,2,3... or -1,-2,-3,...), followed by the string to be separated.@{N}\
Warning: /paramparse uses regmatch(), so %P1, %PL etc. change!
/addh en return by /return
/addh en syn /paramparse separator [-](1,2,3,...) parameter_list
/addh en ex After \
@{}  /set a=$[paramparse("&",3,"This is&a really& silly ex&ample")]@{N}\
@{}  /set b=$(/paramparse & -3 This is&a really& silly ex&ample)@{N}\
%a and %b would contain " silly ex" and "a really" respectively.
/addh see substitution, regexp
/addh paramparse func

/defh paramparse =\
    /let sep=%1%;\
    /let pre=%;\
    /if (substr({-1},0,1)=~"-") \
        /let pre=-%;\
    /endif%;\
    /if (regmatch(strcat("([0-9]+) ([^",sep,"]*)(",sep,".*|$)"),{-1})==1) \
	/if ({P1}==1) \
	    /if (pre!~"-") \
	        /result {P2}%;\
	    /else \
	        /result substr({-1},strlen({P2})+strlen({P1})+strlen(sep)+1+strlen(pre))%;\
	   /endif%;\
	/else \
	    /paramparse %sep %pre$[{P1}-1] $[substr({-1},strlen({P2})+strlen({P1})+strlen(sep)+1+strlen(pre))]%;\
	/endif%;\
   /endif


/addh info \
Liefert einen Wert ungleich %error zurueck, wenn die uebergebene Variable dem Anschein nach eine Liste ist, also mit "<I@{}>" beginnt und endet.
/addh syn /isList listenname
/addh ex /if (isList("demo_list") =~ error) ...@{N}\
oder@{N}\
/isList demo_list@{N}\
/if (value =~ error) ...
/addh return %error bei Fehler als Rueckgabewert und in %value.
/addh en info \
Returns anything but %error, if the given variable seems to be a list (i.e. beginning and ending with "<I@{}>").
/addh en syn /isList list_name    or   isList("list_name")
/addh en ex /if (isList("demo_list") =~ error) ... @{N}\
or@{N}\
/isList demo_list@{N}\
/if (value =~ error) ...
/addh en return %error for non-lists by /return and in %value.
/addh var %value
/addh isList func

/def isList = \
    /let tmp=%;\
    /test tmp:=%1%;\
    /if (substr(tmp,0,3)!~"<I>" | substr(tmp,-3)!~"<I>") \
        /set value=%error%;\
    /else \
        /set value=0%;\
    /endif%;\
    /return value



/addh info \
Hat die gleiche Funktionalitaet wie /forEach, die Werte werden aber alphabetisch sortiert bearbeitet.
/addh syn /sortForEach listenname k[v] /makroname
/addh en info \
Like /forEach, but with sorted keys.
/addh en syn /sortForEach list_name k[v] /macroname
/addh var %value
/addh see /forEach
/addh sortForEach mak

/def sortForEach = \
    /set sort_cat_list=%;\
    /purge_vars sort_cat*%;\
    /forEach %1 k /sortForEach2%;\
    /sortForEach3 %*%;


/addh info \
Hat die gleiche Funktionalitaet wie /hforEach (also fuer Hashlisten), die Werte werden aber alphabetisch sortiert bearbeitet.
/addh syn /hsortForEach listenname k[v] /makroname
/addh en info \
Like /hforEach, but with sorted keys.
/addh en syn /hsortForEach list_name k[v] /macroname
/addh var %value
/addh see /hforEach
/addh hsortForEach mak

/def hsortForEach = \
    /set sort_cat_list=%;\
    /purge_vars sort_cat*%;\
    /hforEach %1 k /sortForEach2%;\
    /hsortForEach3 %*%;

; Hilfsfunktion fuer /hsortForEach
/def hsortForEach3 = \
    /test tokenize(" ",sort_cat_list)%;\
    /if ({2}=~"kv") \
	/hcopylist %1 hsortForEach%;\
    /endif%;\
    /let hsortForEach_kv=%2%;\
    /let hsortForEach_mak=%-2%;\
    /let count=0%;\
    /let sort_cat_value=%;\
    /while (++count<T0+1) \
	/test sort_cat_value:=\{T%{count}\}%;\
	/forEach sort_cat_%sort_cat_value k /hsortForEach4%;\
    /done%;

; Hilfsfunktion fuer /sortForEach
/def sortForEach3 = \
    /test tokenize(" ",sort_cat_list)%;\
    /if ({2}=~"kv") \
	/test hsortForEach:=%1%;\
    /endif%;\
    /let hsortForEach_kv=%2%;\
    /let hsortForEach_mak=%-2%;\
    /let count=0%;\
    /let sort_cat_value=%;\
    /while (++count<T0+1) \
	/test sort_cat_value:=\{T%{count}\}%;\
	/forEach sort_cat_%sort_cat_value k /sortForEach4%;\
    /done%;

; Hilfsfunktion fuer /hsortForEach
/def hsortForEach4 = \
    /if (hsortForEach_kv=~"kv") \
        /hgetdvalueof hsortForEach %*%;\
	/let param=$[strcat(hsortForEach_mak," ",{*}," ",value)]%;\
    /else \
	/let param=$[strcat(hsortForEach_mak," ",{*})]%;\
    /endif%;\
    /eval -s0 %param


; Hilfsfunktion fuer /sortForEach
/def sortForEach4 = \
    /let forEach_key=%*%;\
    /if (hsortForEach_kv=~"kv") \
	/getdvalueof hsortForEach %*%;\
	/let forEach_value=%value%;\
	/let param=$[strcat(hsortForEach_mak," ",{*}," ",value)]%;\
    /else \
	/let param=$[strcat(hsortForEach_mak," ",{*})]%;\
    /endif%;\
    /eval -s0 %param

; Hilfsfunktion fuer /(h)sortForEach
; prinzipiell basiert die Sache auf dem Abbilden von Strings der Laenge 5
; auf Integerzahlen sort_res:=sort_res*37+sort_class

/def sortForEach2 = \
    /let param=%*%;\
    /let sort_char=%;\
    /let sort_res=0%;\
    /let sort_count=-1%;\
    /while (++sort_count<5) \
	/let sort_class=0%;\
	/if (param!~"") \
	    /test sort_char:=substr(param,0,1)%;\
	    /test param:=substr(param,1)%;\
	    /if (sort_char=/"[a-zA-Z0-9]") \
	        /let sort_class=$[ascii(sort_char)]%;\
	        /if (sort_class>=97) \
		    /test sort_class:=sort_class-86%;\
	        /elseif (sort_class>=65) \
		    /test sort_class:=sort_class-54%;\
		/elseif (sort_class>=48) \
		    /test sort_class:=sort_class-47%;\
		/endif%;\
	    /endif%;\
	/endif%;\
	/test sort_res:=sort_res*37+sort_class%;\
    /done%;\
    /isList sort_cat_%sort_res%;\
    /if (value=~error) \
        /createlist sort_cat_%sort_res%; \
    /endif%;\
    /insertSortCat %sort_res%;\
    /xaddtolist sort_cat_%sort_res&%*&

/set sort_cat_list=

; pflegt eine sortierte Liste der Integerabbildungen der Strings

/def insertSortCat = \
    /if (sort_cat_list=~"") \
        /set sort_cat_list=%*%;\
	/return%;\
    /endif%;\
    /test tokenize(" ",sort_cat_list)%;\
    /let count=0%;\
    /let sort_cat_list2=%;\
    /while (++count<T0+1) \
	/test value:=\{T%{count}\}%;\
;/echo %count. %value<>%{*} -> %sort_cat_list2%;\
	/if (0+value<0+{*}) \
	    /if (sort_cat_list2=~"") \
	        /let sort_cat_list2=%value%;\
	    /else \
	        /let sort_cat_list2=%sort_cat_list2 %value%;\
	    /endif%;\
	/elseif (0+value==0+{*}) \
;/echo -e == %sort_cat_list%;\
	    /return%;\
        /else \
	    /let sort_cat_list3=$[substr(sort_cat_list,strlen(sort_cat_list2))]%;\
	    /set sort_cat_list=$[strcat(sort_cat_list2,(sort_cat_list2!~"")?" ":"",{*},(sort_cat_list2=~"")?" ":"",sort_cat_list3)]%;\
;/let sort_cat_list2%;\
;/echo -e <> %sort_cat_list%;\
	    /return%;\
        /endif%;\
    /done%;\
    /set sort_cat_list=$[strcat(sort_cat_list2," ",{*})]%;\
;/let sort_cat_list2%;\
;/echo -e >> %sort_cat_list%;\
;/set sort_cat_list%;\


/addh info \
Hashlisten basieren darauf, dass tf-Variablen beliebig zur Laufzeit erzeugt werden koennen. Fuer jeden Schluessel in der Liste wird der Hashwert (siehe /hash) gebildet und dieser an eine Variable mit dem Namen der Liste angehaengt (z.B. 'weapons___329874923'). In dieser Variablen wird nun eine normale Liste aller Schluessel-Wert-Paare gespeichert, deren Schluessel denselben Hashcode erzeugen. Der Zugriff auf die TF-Variablen ist um ein Vielfaches schneller als die Arbeit mit riesigen Strings.
/addh hashliste misc
/addh en info \
Hashlists use the ability of TF to create variables at run-time. For any key of a list a hash value is calculated (see /hash). Then key and value are stored in the variable listname___hashvalue (e.g. 'weapons___329874923'). All keys (and their values) with the same hash value are stored in this variable, using a normal list. Hash lists should be used for large lists, since they are much faster than normal lists.
/addh hashlists misc

/addh info \
Wandelt eine normale Liste in eine ?Hashliste mit dem gleiche Namen um.
/addh syn /hashlist listenname
/addh en info \
Converts a normal list into a hashlist with the same name.
/addh en syn /hashlist list_name
/addh see Hashliste
/addh en see hashlist
/addh var %value
/addh mak /getfirstkey, /getfirstvalue, /haddtolist, /deletekeyandvalue
/addh hashlist comm

/def hashlist = \
    /set hashlist_list=%;\
    /test hashlist_list:=%1%;\
    /let hashlist=%1%;\
    /getfirstkey hashlist_list%;\
    /while (value!~error) \
	 /let key=%value%;\
	 /getfirstvalue hashlist_list%;\
	 /test haddtolist(hashlist,key,value)%;\
	 /deletekeyandvalue hashlist_list %key%;\
	 /getfirstkey hashlist_list%;\
    /done


/addh info \
Wandelt eine ?Hashliste wieder in eine normale Liste mit dem gleichen Namenum. Das kann ggf. dauern. ;)
/addh syn /removehashed listenname
/addh see Hashliste
/addh en info \
Converts a hashlist into a normal list with the same name. Can take a while. :^)
/addh en syn /removehashed list_name
/addh en see hashlists
/addh var %value
/addh mak /tokenize
/addh removehashed comm

/def removehashed = \
    /set value=$(/listvar -g -s %1___*)%;\
    /test tokenize(" ",value)%;\
    /let count=$[T0+1]%;\
    /while (--count>0) \
	/test value:=strcat(\{T%{count}\})%;\
	/unset %value%;\
    /done


/addh info \
Fuegt ein Schluessel-Wert-Paar zu einer ?Hashliste hinzu. Dabei kann der Schluessel auch mehrteilig sein, Trennung der Parameter durch '&'.
/addh syn /hxaddtolist listenname&schl ues sel&wert
/addh en info \
Appends a key-value-pair to a hashlist. The key may contain blanks, because the parameters are separated by '&'.
/addh en syn /hxaddtolist list_name&ke y&value
/addh see /haddtolist
/addh var %value
/addh mak /paramparse
/addh func hash
/addh hxaddtolist comm

/def hxaddtolist = \
    /let x1=$(/paramparse & 1 %*)%;\
    /let x2=$(/paramparse & 2 %*)%;\
    /let x3=$(/paramparse & -2 %*)%;\
    /let varname=$[strcat(x1,"___",hash(x2))]%;\
    /test value:=strcat(\{%varname\})%;\
    /if (value=~"") \
	/set %varname=$[strcat("<I>",x2,">I<",x3,"<I>")]%;\
    /else \
	/set %varname=$[strcat(value,x2,">I<",x3,"<I>")]%;\
    /endif


/addh info \
Fuegt ein Schluessel-Wert-Paar zu einer ?Hashliste hinzu. Dabei darf der Schluessel keine Leerzeichen enthalten.
/addh syn /haddtolist listenname schluessel wert
/addh en info \
Appends a key-value-pair to a hashlist. The key may not contain blanks.
/addh en syn /haddtolist list_name key value
/addh var %value
/addh func hash
/addh see /hxaddtolist
/addh haddtolist comm
	
/def haddtolist = \
    /let varname=$[strcat({1},"___",hash({2}))]%;\
    /test value:=%varname%;\
;    /set value=$(/listvar -g -s %varname)%;\
     /if (value=~"") \
        /set %varname=%;\
	/test %varname:=strcat("<I>",{2},">I<",{-2},"<I>")%;\
    /else \
	/test %varname:=strcat(value,{2},">I<",{-2},"<I>")%;\
    /endif


/addh info \
Wie /forEach fuer normale Listen, arbeitet /hforEach eine ?Hashliste durch. Dabei ist jedoch nicht wie bei /forEach eine Reihenfolge garantiert. Die Schluessel und/oder Werte werden dem angegebenen Makro als Parameter uebergeben.
/addh syn /hforEach listenname k[v] /makroname
/addh ex /hforeach demo_list k /echo Schluessel:@{N}\
wuerde nacheinander alle Schluessel von 'demo_list' ausgeben.
/addh en info \
Like /forEach, but for hash lists. Parameter1 is the name of the hash list. Parameter 2 may be 'k' (key) or 'kv' (key and value). The 3rd parameter is the name of a macro. This macro will be called for every entry of the list, with key (and value, if parameter2 is 'kv') as parameters.
/addh en syn /hforeach list_name k[v] /macroname
/addh en ex /hforeach demo_list k /echo Key:@{N}\
prints all keys of 'demo_list'.
/addh see /forEach
/addh mak /forEach
/addh var %value
/addh hforEach mak

/def hforEach = \
;    /purge_vars hForEach*%;\
    /let hforEachValue=$(/listvar -g -s %1___*)%;\
    /if (hforEachValue=~"") \
        /break%;\
    /endif%;\
    /test tokenize(" ",hforEachValue,"hForEach")%;\
    /let hforEachCount=$[hForEach0+1]%;\
    /let hforeach=%;\
    /set break_hforeach=0%;\
    /while (--hforEachCount>0 & break_hforeach==0) \
	/test hforeach:=hForEach%{hforEachCount}%;\
	/forEach %hforeach %-1%;\
    /done%;\
    /set break_hforeach=0%;


/addh info \
Verwaltet die aktuell geladenen Hashlisten in einer eigenen Liste, damit sie bei Aenderungen durch /saveall oder /savealllists gespeichert werden.
/addh syn /haddlisttosave listenname
/addh en info \
Marks a hash list to be saved by /saveall or /savealllists.
/addh en syn /haddlisttosave list_name
/addh see /hsavelist, /hloadlist, /hashliste, /saveall
/addh mak /deletekeyandvalue, /addtolist
/addh haddlisttosave comm

/def haddlisttosave = \
    /deletekeyandvalue hlists %1%;\
    /addtolist hlists %1 $[strlen($(/listvar %{1}___*))] %-1%;\


/addh info \
Erzeugt eine ?Hashliste, d.h. es werden alle Eintraege mit diesem Listennamen geloescht.
/addh syn /hcreatelist listenname
/addh en info \
Creates a hash list, i.e. all variables with this name are deleted.
/addh en syn /hcreatelist list_name
/addh see /createlist, Hashliste
/addh en see /createlist, hashlist
/addh hcreatelist comm

/def hcreatelist = \
    /quote -S /unset `/listvar -s %{1}___*


/addh info \
Erstellt eine Kopie der angegebenen ?Hashliste.
/addh syn /hcopylist quelllistenname ziellistenname
/addh en info \
Copies a hash list.
/addh en syn /hcopylist source_list dest_list
/addh mak /hcreatelist, /hcopylist2
/addh hcopylist comm

/def hcopylist = \
    /let hcopylist1=%1%;\
    /let hcopylist2=%2%;\
    /hcreatelist %2%;\
    /quote -S /hcopylist2 `/listvar %{1}___*%;

/def hcopylist2 = \
    /eval $[replace(strcat("/set ",hcopylist1,"___"),strcat("/set ",hcopylist2,"___"),{*})]%;


/addh info \
Analog zu /loadlist fuer normale Listen werden mit /hloadlist ?Hashlisten geladen. Die Dateien heissen 'listenname.hlist'. Es koennen alle von ?/custom verstandenen Optionen verwendet werden.@{N}\
Falls beim Laden ein Fehler auftrat, wird %error zurueckgegeben.
/addh syn /hloadlist [/custom-Optionen] listenname
/addh en info \
Like /loadlist for normal lists, /hloadlist loads a hash list. The file name is the name of the list with the suffix '.hlist'. All options of ?/custom can be used.@{N}\
An error ist denoted by a return value of %error.
/addh en syn /hloadlist [options for /custom] list_name
/addh see /hsavelist, /loadlist, /custom, Hashliste
/addh en see /hsavelist, /loadlist, /custom, hashlist
/addh mak /custom, /ifecho, /haddlisttosave
/addh var %load_dir
/addh hloadlist comm

/defh hloadlist = \
    /let res=0%;\
    /let param=%*%;\
    /custom %*%;\
    /test %?%;\
    /let list_name=%load_file%;\
    /load -q %load_dir%{list_name}.hlist%;\
    /if (!{?}) \
	/load -q %load_dir%{list_name}.hlist.tf%;\
	/if (!{?}) \
	    /ifecho !load_quiet Datei fuer Hash-Liste %list_name nicht gefunden!%;\
	    /let res=%error%;\
	    /break%;\
	/endif%;\
    /endif%;\
    /ifecho !load_quiet Hash-Liste %list_name geladen.%;\
    /haddlisttosave %list_name %param%;\
    /return res


/addh info \
Wie /savelist fuer normale Listen speichert /hsavelist ?Hashlisten ab. Die Dateien heissen 'listenname.hlist'. Es koennen alle von ?/custom verstandenen Optionen verwendet werden.@{N}\
Falls beim Speichern ein Fehler auftrat, wird %error zurueckgegeben.
/addh syn /hsavelist [/custom-Optionen] listenname
/addh en info \
Like /savelist for normal lists, /hsavelist saves hash lists. The file name ist the name of the list with the suffix '.hlist'. All options of ?/custom can be used.@{N}\
An error ist denoted by a return value of %error.
/addh en syn /hsavelist [options for /custom] list_name
/addh see /hloadlist, /savelist, /custom, Hashliste
/addh en see /hloadlist, /savelist, /custom, hashlist
/addh mak /custom, /hsavelist2, /addtolist, /deletekeyandvalue, /getvalueof, /ifecho
/addh var %value, %temp_handle, %hsavelen
/addh hsavelist comm

/defh hsavelist = \
    /let res=0%;\
    /let param=%*%;\
    /set temp_handle=%;\
    /custom -a %*%;\
    /test %?%;\
    /let list_name=%load_file%;\
    /getvalueof hlists %list_name%;\
    /if ({?}=~error & !dir_exists(load_dir)) /mkdir_all %load_dir%; /endif%;\
    /test value:=%list_name%;\
    /let file=$[strcat(load_dir,{list_name},".hlist")]%;\
    /if ((temp_handle:=tfopen(file,"w"))==-1) \
	/echo %file File open failed!%;\
	/let res=%error%;\
	/break%;\
    /else \
	/set hsavelen=$[strlen($(/listvar %{list_name}___*))]%;\
	/quote -S /hsavelist2 `/listvar %{list_name}___*%;\
	/if ({?}==-1) \
	    /echo Write to file failed!%;\
	    /let res=%error%;\
	    /break%;\
	/endif%;\
    /endif%;\
    /getvalueof hlists %list_name%;\
    /if ((value!~error)|(strstr(value,hsavelen)!=0)) \
	/deletekeyandvalue hlists %list_name%;\
	/addtolist hlists %list_name %hsavelen %param%;\
    /endif%;\
    /test tfclose(temp_handle)%;\
    /unset temp_handle%;\
    /ifecho !load_quiet Saved hashlist %list_name%;\
    /return res

/def hsavelist2 = \
    /return tfwrite(temp_handle,{*})%;


/addh info \
Liefert die Anzahl der Schluessel in der angegebenen ?Hashliste zurueck.
/addh syn /hcount_entries listenname
/addh result Anzahl der Eintraege als Rueckgabewert
/addh see /count_entries, Hashliste
/addh en info \
Retuns the number of keys of a hash list.
/addh en syn /hcount_entries list_name
/addh en result number of entries by /return
/addh see /count_entries, hashlist
/addh var %value
/addh hcount_entries func

/def hcount_entries = \
    /set value=$(/listvar -g %{1}___*)%;\
    /let off=$[strstr(value,">I<")]%;\
    /let count_entries=0%;\
    /while (off>-1) \
	/test ++count_entries%;\
	/test value:=substr(value,off+3)%;\
	/test off:=strstr(value,">I<")%;\
    /done%;\
    /return count_entries


/addh info \
Wie /getvalueof fuer normale Listen liefert es den zum angegebenen Schluessel gehoerenden Wert bei ?Hashlisten. Falls der Schluessel nicht existiert, wird %error zurueckgegeben.
/addh syn /hgetvalueof listenname schluessel
/addh return zugehoeriger Wert als Rueckgabewert und in %value
/addh see /getvalueof, Hashliste, /getkeyofvalue
/addh en info \
Like /getvalue for normal lists, it returns the value of the given key or %error, if the key doesn't exist.
/addh en syn /hgetvalueof list_name key
/addh en see /getvalueof, hashlist, /getkeyofvalue
/addh var %value, %hvalue
/addh func hash
/addh hgetvalueof comm

/def hgetvalueof = \
    /let varname=$[strcat({1},"___",hash({-1}))]%;\
    /set hvalue=%;\
    /test hvalue:=strcat(\{%varname\})%;\
    /if (hvalue=~"") \
        /set value=%error%;\
    /else \
	/getvalueof hvalue %-1%;\
    /endif%;\
    /return value


/addh info \
Loescht alle Schluesseleintraege dieses Schluessels in der angegebenen ?Hashliste.
/addh syn /hdelallkeysandvalues listenname schluessel
/addh en info \
Deletes all entries with the given key in a hash list.
/addh en syn /hdelallkeysandvalues list_name key
/addh mak /hdeletekeyandvalue
/addh hdelallkeysandvalues comm

/def hdelallkeysandvalues = \
    /hdeletekeyandvalue %*%;\
    /while (value!~error) \
	/hdeletekeyandvalue %*%;\
    /done%;


/addh info \
Loescht den ersten Schluesseleintrag dieses Schluessels in der angegebenen ?Hashliste.
/addh syn /hdeletekeyandvalue listenname schluessel
/addh en info \
Deletes the first entry with the given key in a hash list.
/addh en syn /hdeletekeyandvalue list_name key
/addh mak /deletekeyandvalue
/addh var %hvalue, %value
/addh func hash
/addh hdeletekeyandvalue comm

/def hdeletekeyandvalue = \
    /let varname=$[strcat({1},"___",hash({-1}))]%;\
    /set hvalue=%;\
    /test hvalue:=strcat(\{%varname\})%;\
    /if (hvalue=~"") \
        /set value=%error%;\
    /else \
	/deletekeyandvalue hvalue %{-1}%;\
	/if (hvalue=~"<I>") \
	    /unset %varname%;\
	/else \
	    /set %varname=%hvalue%;\
	/endif%;\
    /endif%;


/addh info \
Liefert den ersten Wert, der mit dem angegebenen Schluessel in der ?Hashliste eingetragen ist, und loescht diesen Eintrag. Gut zum Durcharbeiten der Liste geeignet.@{N}\
Rueckgabe in %value und als return-Wert.
/addh syn /hgetdvalueof listenname schluessel
/addh en info \
Returns the value of the first entry with the given key in a hash list and delete it afterwards.@{N}\
Returns the value by /return and in %value.
/addh en syn /hgetvalueof list_name key
/addh see /getdvalueof, /hgetvalueof
/addh mak /getdvalueof
/addh var %value
/addh func hash
/addh hgetdvalueof comm

/def hgetdvalueof = \
    /let varname=$[strcat({1},"___",hash({-1}))]%;\
    /set hvalue=%;\
    /test hvalue:=strcat(\{%varname\})%;\
    /if (hvalue=~"") \
        /set value=%error%;\
    /else \
	/getdvalueof hvalue %{-1}%;\
	/if (hvalue=~"<I>") \
	    /unset %varname%;\
	/else \
	    /set %varname=%hvalue%;\
	/endif%;\
    /endif%;\
    /return value


/addh info \
Liefert den Wert des angegebenen Schluessels als Liste zurueck. D.h. wenn er vorher mit /haddlisttolist hinzugefuegt wurde, ist es notwendig, dies rueckgaengig zu machen. Die Ergebnisliste ist eine normale Liste. Sie kann mit@{N}\
/set listenname=%value@{N}\
oder@{N}\
/set listenname=$[hgetlistvalueof(...)]@{N}\
gesichert werden.
/addh syn /hgetlistvalueof listenname schluessel
/addh ex Die Zeilen@{N}\
@{}   /hgetlistvalueof waffen_list schwerter@{N}\
@{}   /set schwerter_list=%value@{N}\
und@{N}\
@{}   /set schwerter_list=$[hgetlistvalueof("waffen_list", "schwerter")]@{N}\
speichern beide die Subliste 'schwerter' der Hashliste 'waffen_list' in der Variablen %schwerter_list.
/addh return in %value und per /return
/addh en info \
Returns the value, which is a (normal) list, of the key.
/addh en syn /hgetlistvalueof list_name key
/addh en ex The lines@{N}\
@{}    /hgetlistvalueof weapons_list swords@{N}\
@{}    /set swords_list=%value@{N}\
or@{N}\
@{}    /set swords_list=$[hgetlistvalueof("weapons_list", "swords")]@{N}\
store the (normal) sublist 'swords' of the hash list 'weapons_list' in the variable %swords_list.
/addh en return in %value and by /return
/addh see /hgetvalueof, /getlistvalueof, /haddlisttolist, /hxaddlisttolist
/addh mak /hgetvalueof, /unmakesub
/addh var %value
/addh hgetlistvalueof comm

/def hgetlistvalueof = \
    /hgetvalueof %*%;\
    /test value:=unmakesub(value)%;\
    /return value


/addh info \
Fuegt die als Wert (%variable) angebebene Liste unter dem angegebenen Schluessel zur ?Hashliste hinzu. Dabei wird die Liste modifiziert, um als Subliste innerhalb der eigentlichen Liste erhalten zu bleiben.
/addh syn /haddlisttolist listenname schluessel wertliste
/addh ex @{N}\
/createlist schwerter_liste@{N}\
...@{N}\
/haddlisttolist waffen_liste schwerter %schwerter_liste
/addh en info \
Adds a (normal) list as the value of the key to a hash list. The list is changed into a sublist, so use ?/hgetlistvalueof to access it. Remember to give /haddlisttolist the list, not the name of the list.
/addh en syn /haddlisttolist list_name key value_list
/addh en ex @{N}\
/createlist swords_list@{N}\
...@{N}\
/haddlisttolist weapons_list swords %swords_list
/addh see /hgetlistvalueof, /addlisttolist, /makesub, /unmakesub, /hxaddlisttolist
/addh mak /haddtolist, /makesub
/addh var %value
/addh haddlisttolist mak

/def haddlisttolist = \
    /test value:=makesub({-2})%;\
    /test haddtolist({1},{2},value)%;


/addh info \
Fuegt die als Wert (%variable) angebebene Liste unter dem angegebenen Schluessel zur ?Hashliste hinzu. Dabei wird die Liste modifiziert, um als Subliste innerhalb der eigentlichen Liste erhalten zu bleiben. Damit der Schluessel auch Leerzeichen enthalten kann, muessen die Parameter durch '&' getrennt werden.
/addh syn /hxaddlisttolist listenname&schl ues sel&wertliste
/addh en info \
Same as ?/haddlisttolist, but the key may contain blanks. The paramteres are separated by '&'.
/addh en syn /hxaddlisttolist list_name&ke y&value_list
/addh see /hgetlistvalueof, /addlisttolist, /makesub, /unmakesub, /haddlisttolist
/addh mak /paramparse, /makesub
/addh var %value
/addh func hash
/addh hxaddlisttolist comm

/def hxaddlisttolist = \
     /let x1=$(/paramparse & 1 %*)%;\
     /let x2=$(/paramparse & 2 %*)%;\
     /let x3=$(/paramparse & -2 %*)%;\
     /let x3=$[makesub({x3})]%;\
     /let varname=$[strcat(x1,"___",hash(x2))]%;\
     /test value:=strcat(\{%varname\})%;\
     /if (value=~"") \
	/set %varname=$[strcat("<I>",x2,">I<",x3,"<I>")]%;\
    /else \
	/set %varname=$[strcat(value,x2,">I<",x3,"<I>")]%;\
    /endif%;\

;???
;; regmatch
/def hquerylist = \
    /let querystring=%{-2}%;\
;/let querystring%;\
    /let querysave=$[(({2}=~"kv")?"1":"0")]%;\
    /let queriedlist=%{1}%;\
    /hcreatelist hqueryresults%;\
    /let hquerycount=0%;\
    /let key=%;\
    /while (regmatch("q_([A-Za-z0-9_]+)",querystring)) \
	/test ++hquerycount%;\
	/let queryfield_%hquerycount=%P1%;\
;/let queryfield_%hquerycount%;\
	/let querystring=%PR%;\
    /done%;\
    /let querystring=%{-2}%;\
    /hforEach %1 k /hquerylist2%;

/def hquerylist2 = \
    /hgetlistvalueof %queriedlist %*%;\
    /if (value=~error) \
        /return%;\
    /endif%;\
    /set queriedlist2=%value%;\
    /set queriedlist3=%value%;\
;    /getfirstkey queriedlist3%;\
    /let hquerytcount=0%;\
    /while (++hquerytcount<=hquerycount) \
;/let hquerytcount%;\
	/test key:=\{queryfield_%{hquerytcount}\}%;\
;/let key%;\
	/getdvalueof queriedlist3 %key%;\
	/if (value!~error) \
	    /let q_%key=%value%;\
	/else \
	    /let q_%key=%;\
	/endif%;\
;/let q_%key%;\
;	 /getfirstkey queriedlist3%;\
    /done%;\
    /let key=%*%;\
    /set value=%queriedlist2%;\
    /test %querystring%;\
    /let res=%?%;\
;/echo -e %querystring -> %res%;\
    /if (res) \
	/hxaddlisttolist hqueryresults&%{*}&$[((querysave)?queriedlist2:"")]%;\
    /endif


/addh info \
Liefert eine (normale) Liste zurueck, in der alle Eintraege mit dem angegebenen Schluessel gesammelt sind.
/addh syn /hgetentrylist listenname schluessel
/addh return in %value und pre /return eine normale Liste der Eintraege und Werte
/addh en info \
Returns a (normal) list which contains all entrys of the hash list with the given key.
/addh en syn /hgetentrylist list_name key
/addh en return in %value and by /return
/addh mak /createlist, /getdvalueof, /xaddtolist
/addh func hash
/addh var %value, %hvalue
/addh hgetentrylist mak

/def hgetentrylist = \
    /let varname=$[strcat({1},"___",hash({-1}))]%;\
    /set hvalue=%;\
    /test hvalue:=strcat(\{%varname\})%;\
;/vdebug hvalue%;\
    /if (hvalue=~"") \
        /set value=%error%;\
    /else \
	/createlist hvalue2%;\
	/getdvalueof hvalue %-1%;\
	/while (value!~error) \
	    /xaddtolist hvalue2&%-1&%value%;\
	    /getdvalueof hvalue %-1%;\
	/done%;\
	/set value=%hvalue2%;\
    /endif%;\
    /return value


/addh info \
Die Felder sind einfach eine Abbildung auf TF-Variablen, in denen dann die Inhalte stehen. Dabei wird der Variablenname wie folgt zusammengesetzt: 'array_feldname___index'. Die hoechsten und niedrigsten Indizes stehen in 'array_feldname___maxlen' und '*___minlen', werden aber auch von /alen und /astart geliefert.
/addh en info \
Arrays are represented by tf-variables, which contain the data. The name of such a tf-variable is constructed this way: 'array-name___index'. The minimal and maximal index are stored in 'array-name___minlen' and 'array-name_maxlen' respectively, but you should use /astart and /alen instead.
/addh see /aget, /aput, /ashow, /asshow, /asort, /amsort, /aforEach, alen, astart, /aclear
/addh felder misc
/addh info \
Die Felder sind einfach eine Abbildung auf TF-Variablen, in denen dann die Inhalte stehen. Dabei wird der Variablenname wie folgt zusammengesetzt: 'array_feldname___index'. Die hoechsten und niedrigsten Indizes stehen in 'array_feldname___maxlen' und '*___minlen', werden aber auch von /alen und /astart geliefert.
/addh en info \
Arrays are represented by tf-variables, which contain the data. The name of such a tf-variable is constructed this way: 'array-name___index'. The minimal and maximal index are stored in 'array-name___minlen' and 'array-name_maxlen' respectively, but you should use /astart and /alen instead.
/addh see /aget, /aput, /ashow, /asshow, /asort, /amsort, /aforEach, alen, astart, /aclear
/addh arrays misc


/addh info \
Laedt ein File (Feldname.ary) Zeile fuer Zeile in ein Feld. Es koennen die von ?/custom verstandenen Optionen verwendet werden.
/addh syn /loadarray [custom-Optionen] feldname
/addh return 0 bei Fehler, sonst 1
/addh en info \
Loads the file 'array-name.ary' which contains an array. You may use the options of ?/custom.
/addh en syn /loadarray [custom-options] array_name
/addh en return 0=error, 1=ok
/addh ex /loadarray -l help_tips
/addh see /savearray
/addh loadarray mak

/def loadarray = \
    /custom -a %*%;\
    /test %?%;\
    /let idx=-1%;\
    /let file=%load_dir%load_file.ary%;\
    /let array_name=%L%;\
    /if (file_exists(file)) \
	/aclear %array_name%;\
        /quote -S /loadarray2 '%file%;\
	/ifecho !load_quiet Array %array_name von %load_dir%load_file.ary geladen%;\
	/return 1%;\
    /else \
        /info error Datei %load_dir%load_file.ary fuer Array %L nicht gefunden%;\
    /endif%;\
    /return 0


/def loadarray2 = \
     /let param=%*%;\
     /if (param=/";;*") /test param:=substr(param,1)%;\
     /elseif (param=/";*") /return%; \
     /endif%;\
     /test aput(array_name,alen(array_name)+1,param)


/addh info \
Speichert das angegebene Feld in das File 'Feldname.ary'. Fuer den Speicherort koennend die bekannten /mload Optionen angegeben werden (siehe /custom).
/addh syn /savearray [custom-Optionen] feldname
/addh en info \
Saves an array in the file 'array-name.ary'. You may use the options of ?/custom.
/addh en syn /savearray [custom-options] array_name
/addh see /loadarray
/addh ex /savearray -l help_tips
/addh savearray mak

/def savearray = \
         /let array_name=%L%;\
         /custom -a %*%;\
	 /test %?%;\
	 /let file=%load_file%;\
	 /if (!dir_exists(load_dir)) /mkdir_all %load_dir%; /endif%;\
	 /let idx=$[astart(array_name)-1]%;\
	 /let max_idx=$[alen(array_name)]%;\
	 /let savearray_handle=%;\
	 /test savearray_handle:=tfopen(strcat(load_dir,file,".ary"),"w")%;\
	 /if (savearray_handle>-1) \
	   /while (++idx<=max_idx) \
	      /test tfwrite(savearray_handle,aget(array_name,idx))%;\
	   /done%;\
	 /test tfclose(savearray_handle)


/addh info \
Liefert den Wert des Feldes am angegebenen Index zurueck.
/addh syn /aget feldname index
/addh return Wert in %value und als Rueckgabewert
/addh en info \
Returns the value of the array at the given index.
/addh en syn /aget array_name index
/addh en return value in %value and by /return
/addh see /aput
/addh var %value
/addh aget func

/def aget = \
    /test value:=\{array_%{1}___%{2}\}%;\
    /return value


/addh info \
Setzt den Wert des Feldes am angegebenen Index.
/addh syn /aput feldname index wert
/addh en info \
Sets the value of the array at the given index.
/addh en syn /aput array_name index value
/addh func astart, alen
/addh see /aget
/addh aput comm
	
/def aput = \
    /set array_%{1}___%{2}=%{-2}%;\
    /if (astart({1})>{2}) \
        /test array_%1___min_len:={2}%;\
    /endif%;\
    /if (alen({1})<{2}) \
        /test array_%1___max_len:={2}%;\
    /endif


/addh info \
Loescht die Variablen, die das angegebene Feld ausmachen, und setzt die min/max Indizes neu.
/addh syn /aclear feldname
/addh en info \
Deletes all variables belonging to the array and sets the min/maxlen to invalid values.
/addh en syn /aclear array_name
/addh see alen, astart
/addh mak /purge_vars
/addh aclear comm

/def aclear = \
    /purge_vars array_%1___*%;\
    /set array_%1___max_len=0%;\
    /set array_%1___min_len=$[0+error]


/addh info \
Liefert den hoechsten Index des angegebenen Feldes zurueck.
/addh syn /alen feldname
/addh return Index als Rueckgabewert
/addh en info \
Returns the maximal index of the array.
/addh en syn /alen array_name
/addh en return maximal index by /return
/addh see astart
/addh alen func

/def alen = \
    /return \{array_%{1}___max_len\}


/addh info \
Liefert den kleinsten Index des angegebenen Feldes zurueck.
/addh syn /astart feldname
/addh return Index als Rueckgabewert
/addh en info \
Returns the minimal index of the array.
/addh en syn /astart array_name
/addh en return minimal index by /return
/addh see alen
/addh astart func

/def astart = \
    /return \{array_%{1}___min_len\}


/addh info \
Zeigt alle Variablen an, die das angegebene Feld ausmachen.
/addh syn /ashow feldname
/addh en info \
Shows all variables belonging to the array.
/addh en syn /ashow array_name
/addh see /asshow
/addh ashow comm

/def ashow = \
    /listvar -g array_%{1}___*


/addh info \
Zeigt nur die Werte an, die das angegebene Feld ausmachen.
/addh syn /asshow feldname
/addh return Werte mit /result
/addh en info \
Returns only the values of the array.
/addh en syn /asshow array_name
/addh en return values by /result
/addh see /ashow
/addh func astart, alen
/addh mak /aget
/addh asshow comm

/def asshow = \
    /let count=$[alen({1})+1]%;\
    /let res=%;\
    /while (--count>=astart({1})) \
	/let res=$[aget({1},count)] %res%;\
    /done%;\
    /result res


/addh info \
Tauscht die Feldwerte an den angegebenen Indizes aus.
/addh syn /aswap feldname index1 index2
/addh en info \
Swaps two values of the array.
/addh en syn /aswap array_name index1 index2
/addh see /asort
/addh aswap mak

/def aswap = \
    /let tmp=%;\
    /test tmp:=\{array_%{1}___%{2}\}%;\
    /test array_%{1}___%{2}:=\{array_%{1}___%{3}\}%;\
    /test array_%{1}___%{3}:=tmp%;


/addh info \
Vergleichsfunktion auf Stringbasis (d.h. '112' < '65'). Liefert einen Wert < 0, wenn der Feldwert an 'index1' lexikografisch kleiner ist als an 'index2'. Bei Gleichheit wird 0 zurueckgegeben, ansonsten ein positiver Wert.
/addh syn /ascmp feldname index1 index2
/addh return in %value und als Rueckgabewert
/addh en info \
Compares two entrys of an array. Return value is < 0, if the string(!) at position 'index1' is lexicographically smaller than the string at position 'index2'. Returns 0 if they are equal, and > 0 otherwise.
/addh en syn /ascmp array_name index1 index2
/addh en return in %value and by /return
/addh see asicmp, ancmp, strcmp
/addh var %value
/addh ascmp func

/def ascmp = \
    /test value:=strcmp(\{array_%{1}___%{2}\},\{array_%{1}___%{3}\})%;\
    /return value%;


/addh info \
Vergleichsfunktion auf Stringbasis ohne Beruecksichtigung der Gross-/Kleinschreibung. Liefert einen Wert < 0, wenn der Feldwert an 'index1' lexikografisch kleiner ist als an 'index2'. Bei Gleichheit wird 0 zurueckgegeben, ansonste ein positiver Wert.
/addh syn /asicmp feldname index1 index2
/addh return in %value und als Rueckgabewert
/addh en info \
Same as ?/ascmp, but case-insensitive.
/addh en syn /asicmp array_name index1 index2
/addh en return in %value and by /return
/addh see ascmp, ancmp, sctrmp
/addh var %value
/addh asicmp func

/def asicmp = \
    /test value:=strcmp(tolower(\{array_%{1}___%{2}\}),tolower(\{array_%{1}___%{3}\}))%;\
    /return value%;


/addh info \
Vergleichsfunktion auf numerischer Basis. Liefert einen Wert < 0, wenn der Feldwert an 'index1' kleiner ist als an 'index2'. Bei Gleichheit wird 0 zurueckgegeben, ansonste ein positiver Wert.
/addh syn /ancmp feldname index1 index2
/addh return in %value und als Rueckgabewert
/addh en info \
Same as ?/ascmp, but with a numerical comparison (i.e. 112 > 65).
/addh en syn /ancmp array_name index1 index2
/addh en return in %value and by /return
/addh see asicmp, ascmp
/addh var %value
/addh ancmp func

/def ancmp = \
    /test value:=(\{array_%{1}___%{2}\}-\{array_%{1}___%{3}\})%;\
    /return value


/addh info \
Implementation von Merge-Sort fuer die Felder. Es werden das zu sortierende Feld, minIndex und maxIndex sowie der Name der Vergleichsfunktion uebergeben. Ausserdem ist es moeglich, ein Feld anzugeben, das in derselben Weise wie das Sortierfeld mitgetauscht wird. Als Vergleichsfunktionen kommen in erster Linie ascmp, asicmp (Default) und ancmp in Frage.
/addh syn /amsort feldname von bis [sortierfunc] [zweitfeld]
/addh ex /amsort baeume 4 10 ascmp obst
/addh result Das sortierte Feld in %amsort_base und das ggf. mitzusortierende zweite Feld in %amsort_base2.
/addh var %amsort_base = Sortierfeld, %amsort_func = Vergleichsfunktion, %amsort_base2 ggf. Zweitfeld, %value
/addh en info \
Merge-sort for arrays. Parameters are the array name, minimal and maximal index and the name of the compare function. Additionally, you may give a 5th parameter, which is an array name. This second array will be sorted like the first one. Compare function may be one of ascmp, asicmp (default) or ancmp.
/addh en syn /amsort array_name from to [compare function] [array_name2]
/addh en ex /amsort trees 4 10 ascmp fruits
/addh result The assorted array in %amsort_base, the optional second array in %amsort_base2.
/addh en var %amsort_base=assorted array, %amsort_func=compare function, %amsort_base2=2nd array, %value
/addh see /amsort1, asicmp, ascmp, ancmp
/addh mak /aclear, /amsort1
/addh amsort comm

/def amsort = \
    /aclear amsort%;\
    /aclear amsorti2%;\
    /let amsort_base=%1%;\
    /let amsort_func=%{4-asicmp}%;\
    /if ({5}!~"") \
        /let amsort_second=1%;\
	/let amsort_base2=%5%;\
    /else \
        /let amsort_second=0%;\
    /endif%;\
    /amsort1 %2 %3%;


/addh info \
Eigentliche Implementation des Merge-Sort-Algorithmus. Wird rekursiv aufgerufen. Das zu sortierende Feld steht in %amsort_base, das ggf. mitzusortierende Fehld in %amsort_base2 und die Vergleichsfunktion in %amsort_func
/addh syn /amsort1 von bis
/addh var %amsort_base = Sortierfeld, %amsort_func = Vergleichsfunktion, %amsort_base2 ggf. Zweitfeld
/addh en info \
Implemetation of the recursive merge sort. The array to be sorted is %amsort_base, the comparison is done be the function in %amsort_func. An optional second array is in %amsort_base2.
/addh en syn /amsort1 from to
/addh en var %amsort_base=assorted array, %amsort_func=compare function, %amsort_base2=2nd array, %value
/addh mak /aput
/addh func aget
/addh see /amsort
/addh amsort1 mak

/def amsort1 = \
    /if ({2}>{1}) \
	/let m=$[({2}+{1})/2]%;\
	/amsort1 %{1} %m%;\
	/amsort1 $[m+1] %{2}%;\
	/let i=$[m+1]%;\
	/while (i>{1}) \
	    /aput amsort $[i-1] $[aget(amsort_base,i-1)]%;\
	    /if (amsort_second) \
	        /aput amsorti2 $[i-1] $[aget(amsort_base2,i-1)]%;\
	    /endif%;\
	    /test --i%;\
	/done%;\
	/let j=%m%;\
	/while (j<{2}) \
	    /aput amsort $[{2}+m-j] $[aget(amsort_base,j+1)]%;\
	    /if (amsort_second) \
	        /aput amsorti2 $[{2}+m-j] $[aget(amsort_base2,j+1)]%;\
	    /endif%;\
	    /test ++j%;\
	 /done%;\
;/asshow amsort%;\
	 /let k=%{1}%;\
	 /while (k<={2}) \
	     /%amsort_func amsort %i %j%;\
	     /if ({?}<0) \
	         /test aput(amsort_base,k,aget("amsort",i))%;\
	         /if (amsort_second) \
	            /test aput(amsort_base2,k,aget("amsorti2",i))%;\
	         /endif%;\
	         /test ++i%;\
	     /else \
	         /test aput(amsort_base,k,aget("amsort",j))%;\
	         /if (amsort_second) \
	             /test aput(amsort_base2,k,aget("amsorti2",j))%;\
	         /endif%;\
	         /test --j%;\
	     /endif%;\
	     /test ++k%;\
        /done%;\
;/asshow amsort%;\
;/asshow a%;\
    /endif%;

;void mergesort(int a[], int l, int r) {
;        int i,j,k,m;
;
;        if (r > l) {
;                m = (r+l)/2;
;                mergesort(a,l,m);
;                mergesort(a,m+1,r);
;                for(i=m+1; i>l; i--) b[i-1] = a[i-1];
;                for(j=m; j<r; j++) b[r+m-j] = a[j+1];
;                for(k=l; k<=r; k++) a[k] = (b[i]<b[j]) ? b[i++] : b[j--];
;        }
;}


/addh info \
Quick-Sort-Implementation fuer die Felder. Es werden das zu sortierende Feld, minIndex und maxIndex sowie der Name der Vergleichsfunktion uebergeben. Ausserdem ist es moeglich, ein Feld anzugeben, das in der selben Weise wie das Sortierfeld mitgetauscht wird. Als Vergleichsfunktionen kommen in erster Linie ascmp, asicmp (Default) und ancmp in Frage.
/addh syn /asort feldname von bis [vergleichsfunktion] [zweitfeld]
/addh ex /asort baeume 4 10 ascmp obst
/addh en info \
Quick-sort for arrays. Parameters are the array name, minimal and maximal index and the name of the compare function. Additionally, you may give a 5th parameter, which is an array name. This second array will be sorted like the first one. Compare function may be one of ascmp, asicmp (default) or ancmp.
/addh en syn /amsort array_name from to [compare function] [array_name2]
/addh en ex /amsort trees 4 10 ascmp fruits
/addh see /amsort, asicmp, ascmp, ancmp
/addh mak /aswap
/addh asort comm

; feld, beginn, ende, sortierfunktion, array das ggf mitgeswappt werden soll
/def asort = \
    /let asort1=$[{2}-1]%;\
    /let asort2=$[{3}+1]%;\
    /let cmp=$[(asort1+asort2)/2]%;\
;/echo ivorn %2 $[aget({1},{2})]%;\
;/echo ihinten %3 $[aget({1},{3})]%;\
;/echo cmp %cmp $[aget({1},cmp)]%;\
    /if ({2}=~error) \
        /return%;\
    /endif%;\
    /if (abs({2}-{3})<=1) \
	/if (abs({2}-{3})==1) \
	    /%4 %1 %2 %3%;\
	    /if ({?}>0) \
	        /aswap %1 %2 %3%;\
	    /endif%;\
	/endif%;\
	/return%;\
    /endif%;\
    /while (asort1<asort2) \
	/%4 %1 $[++asort1] %cmp%;\
	/while (asort1<asort2 & {?}<0) \
	    /%4 %1 $[++asort1] %cmp%;\
	/done%;\
	/%4 %1 $[--asort2] %cmp%;\
	/while (asort2>asort1 & {?}>0) \
	    /%4 %1 $[--asort2] %cmp%;\
	/done%;\
	/if (asort1<asort2) \
;/echo vorn %asort1 $[aget({1},asort1)]%;\
;/echo hinten %asort2 $[aget({1},asort2)]%;\
	    /aswap %1 %asort1 %asort2%;\
	    /if ({5}!~"") \
	        /aswap %5 %asort1 %asort2%;\
	    /endif%;\
	/endif%;\
;	/test ++asort1%;\
;	/test --asort2%;\
;	/asshow %{1}%;\
    /done%;\
    /asort %1 %2 %asort2 %4%;\
    /asort %1 %asort1 %3 %4%;


/addh info \
Wie /forEach bzw. /hforEach fuer Listen arbeitet /aforEach alle Elemente eines Feldes durch, indem sie als Parameter fuer das uebergebene Makro genutzt werden.
/addh syn /aforEach feldname /makroname
/addh ex /aforEach baeume /ernte
/addh en info \
Like /forEach for lists, /aforeach walks through an array and calls the macro with every array entry as parameter.
/addh en syn /aforEach array_name /macro_name
/addh en ex "/aforEach trees /climb" would climb on every tree.
/addh func astart, alen, aget
/addh see /aforEach2, /asortforEach
/addh aforEach comm

/def aforEach = \
    /let aforEachcount=$[astart({1})-1]%;\
    /let aforEachcount_max=$[alen({1})]%;\
    /while (++aforEachcount<=aforEachcount_max) \
	/eval -s0 %-1 $[aget({1},aforEachcount)]%;\
    /done%;


/addh info \
Wie /forEach bzw. /hforEach fuer Listen arbeitet /aforEach2 alle Elemente zweier Felder durch, indem sie als Parameter fuer das uebergebene Makro genutzt werden.
/addh syn /aforEach2 feldname feldname2 /makroname
/addh en info \
Same as ?/aforEach, but the macro gets the elements of two arrays as parameters.
/addh en syn /aforEach2 array_name1 array_name2 /macro_name
/addh func astart, alen, aget
/addh see /aforEach, /asortforEach
/addh aforEach2 comm

/def aforEach2 = \
    /let aforEachcount=$[astart({1})-1]%;\
    /let aforEachcount_max=$[alen({1})]%;\
    /while (++aforEachcount<=aforEachcount_max) \
	/eval -s0 %{-2} $[aget({1},aforEachcount)] $[aget({2},aforEachcount)]%;\
    /done%;




/addh info \
Erfuellt dieselbe Funktion wie ?/forEach fuer Listen, nur dass die Elemente sortiert bearbeitet werden. Dabei kann in der Variablen %sort_alg (moeglichst als lokale Variable) der Sortieralgorithmus eingestellt werden ('asort' oder 'amsort'), sowie in der Variablen %comp_func die Vergleichsfunktion ('asicmp', 'ascmp', 'ancmp').
/addh syn /asortForEach listenname k[v] /makroname
/addh en info \
Same as ?/forEach, but the list is sorted first. The name of the sort macro ('asort' or 'amsort') should be defined in %sort_alg, and the name of the compare function ('asicmp', 'ascmp' or 'ancmp') in %comp_func.
/addh en syn /asortForEach list_name k[v] /macro_name
/addh var %sort_alg, %comp_func
/addh mak /aclear, /forEach, /aforEach, /asortForEach2, /asortForEach3
/addh func astart, alen
/addh see /forEach, /asort, /amsort, asicmp, ascmp, ancmp
/addh asortForEach comm

/def asortForEach = \
    /let asortForEach_idx=-1%;\
    /aclear asortForEach_keys%;\
    /if ({2}=~"kv") \
	/aclear asortForEach_values%;\
	/forEach %1 %2 /asortForEach2%;\
	/test %{sort_alg-asort}("asortForEach_keys",astart("asortForEach_keys"),alen("asortForEach_keys"),"%{comp_func-asicmp}","asortForEach_values")%;\
	/aforEach2 asortForEach_keys asortForEach_values %{-2}%;\
    /else \
	/forEach %1 $[(({2}=~"kx")?"kv":"k")] /asortForEach3%;\
	/test %{sort_alg-asort}("asortForEach_keys",astart("asortForEach_keys"),alen("asortForEach_keys"),"%{comp_func-asicmp}")%;\
	/aforEach asortForEach_keys %{-2}%;\
    /endif%;


/addh info \
Erfuellt dieselbe Funktion wie /hforEach fuer Hashlisten, nur dass die Elemente sortiert bearbeitet werden. Dabei kann in der Variablen %sort_alg (moeglichst als lokale Var) der Sortieralgorithmus eingestellt werden ('asort' oder 'amsort'), sowie in der Variablen %comp_func die Vergleichsfunktion ('asicmp', 'ascmp', 'ancmp').
/addh syn /hasortForEach listenname k[v] /makroname
/addh en info \
Same as ?/asortForEach, but for hash lists.
/addh en syn /hasortForEach list_name k[v] /macro_name
/addh see /hforEach, asort, amsort, asicmp, ascmp, ancmp, /asortForEach
/addh var %sort_alg, %comp_func
/addh mak /aclear, /hforEach, /aput, /asortForEach2, /asortForEach3
/addh func astart, alen
/addh hasortForEach comm

/def hasortForEach = \
    /let asortForEach_idx=-1%;\
    /aclear asortForEach_keys%;\
    /if ({2}=~"kv") \
	/aclear asortForEach_values%;\
	/hforEach %{1} %{2} /asortForEach2%;\
	/test %{sort_alg-asort}("asortForEach_keys",astart("asortForEach_keys"),alen("asortForEach_keys"),"%{comp_func-asicmp}","asortForEach_values")%;\
	/aforEach2 asortForEach_keys asortForEach_values %{-2}%;\
    /else \
	/hforEach %{1} $[(({2}=~"kx")?"kv":"k")] /asortForEach3%;\
	/test %{sort_alg-asort}("asortForEach_keys",astart("asortForEach_keys"),alen("asortForEach_keys"),"%{comp_func-asicmp}")%;\
	/aforEach asortForEach_keys %{-2}%;\
    /endif%;

; Hilfsfunktion zum Schreiben der Listen in ein Feld
/def asortForEach2 = \
    /aput asortForEach_keys $[++asortForEach_idx] %{1}%;\
    /aput asortForEach_values $[asortForEach_idx] %{-1}%;\

; Hilfsfunktion zum Schreiben der Liste in ein Feld
/def asortForEach3 = \
    /aput asortForEach_keys $[++asortForEach_idx] %*%;\


/addh info \
Die angegebenen Schluessel werden aus der als ersten Parameter angegebenen Lister geloescht und mit ihren Werten in die Liste 'split_list' eingetragen.@{N}\
Die Schluessel duerfen keine Leerzeichen enthalten.
/addh syn /split_list listenname schluessel1 [schluessel2 ...]
/addh en info \
The keys are deleted from the list and stored in the list 'split_list'.@{N}\
The keys must not contain spaces.
/addh en syn /split_list list_name key1 [key2 ...]
/addh mak /createlist, /getdvalueof, /addhtolist
/addh var %split_list, %value
/addh split_list mak

/def split_list = \
    /if ({#}>1) \
	/createlist split_list%;\
	/let split_list0=%1%;\
	/shift%;\
	/while ({#}>0) \
	    /let tmp=$[getdvalueof(split_list0,{1})]%;\
	    /if (tmp!~error) \
	        /addtolist split_list %1 %tmp%;\
	    /endif%;\
	    /shift%;\
	/done%;\
    /endif%;


/addh info \
Fuegt zwei Listen zusammen, wobei Schluessel, die in beiden Listen vorkommen, aus der zuerst angegebenen genommen werden. Die Ergebnisliste heisst 'merge_list'.
/addh return Ergebnisliste in %merge_list und per /return
/addh syn /merge_lists listenname1 listenname2
/addh en info \
Merges two lists. Keys, which appear in both lists, are taken from the first one. The result is in %merge_list.
/addh en return The merged list in %merge_list and by /return
/addh en syn /merge_lists list_name1 list_name2
/addh see /hmerge_lists
/addh var %merge_list, %merge_list2, %value
/addh mak /getfirstkey, /xaddtolist, /getdvalueof, /deletekeyandvalue
/addh func iskey
/addh merge_lists mak

/def merge_lists = \
    /if ({#}!=2) \
        /return%;\
    /endif%;\
    /set merge_list=%;\
    /test merge_list:=%1%;\
    /set merge_list2=%;\
    /test merge_list2:=%2%;\
    /let key=$[getfirstkey("merge_list2")]%;\
    /while (key!~error) \
	/if (iskey("merge_list",key)=~error) \
	    /getdvalueof merge_list2 %key%;\
	    /xaddtolist merge_list&%key&%value%;\
	/else \
	    /deletekeyandvalue merge_list2 %key%;\
	/endif%;\
	/let key=$[getfirstkey("merge_list2")]%;\
    /done%;\
    /return %merge_list


/addh info \
Kopiert in Inhalt der ersten in die zweite Liste, wobei je nach drittem Parameter (kv) Schluessel und/oder Werte kopiert werden. Dabei werden schon vorhandene Schluessel ueberschrieben.@{N}\
Die Schluessel der ersten Liste duerfen keine Leerzeichen enthalten.
/addh syn /umerge_lists2 quelllistenname zielllistenname k[v]
/addh ex /umerge_lists2 katzen tiere kv
/addh en info \
Copies the first list to the second list. Keys in list 2, which are also in list 1, are overwritten. Depending on the third parameter ('k', 'kv') keys and/or values are copied.@{N}\
The keys must not contain spaces.
/addh en syn /umerge_lists2 source_list_name dest_list_name k[v]
/addh en ex /umerge_lists2 cats animals kv
/addh mak /forEach, /uaddtolist
/addh umerge_lists2 mak

/def umerge_lists2 = \
    /if ({#}==3) \
	/forEach %1 %3 /uaddtolist %2%;\
    /endif%;	


/addh info \
Fuegt zwei Hashlisten zusammen, wobei Schluessel, die in beiden Listen vorkommen, aus der zuerst angegebenen genommen werden. Die Ergebnisliste heisst 'hmerge_list'.
/addh return Ergebnisliste %hmerge_list
/addh syn /hmerge_lists listenname1 listenname2
/addh en info \
Same as /merge_lists, but for hash lists. The merged list is stored in %hmerge_list'.
/addh en return merged list in %hmerge_list
/addh en syn /hmerge_lists list_name1 list_name2
/addh var %merge_lists, %value
/addh mak /hcopyList, /hforeEach, /hmerge_lists2
/addh hmerge_lists mak

/def hmerge_lists = \
    /if ({#}==2) \
	/set merge_list=%;\
	/hcopyList %1 hmerge_list%;\
	/set hmerge_list2=%2%;\
	/hforEach %2 k /hmerge_lists2%;\
    /endif%;

/def hmerge_lists2 = \
    /hgetvalueof hmerge_list %*%;\
    /if (value=~error) \
	/hgetvalueof %hmerge_list2 %*%;\
	/hxaddtolist hmerge_list&%{*}&%value%;\
    /endif%;


/addh info \
Erstellt eine leere Liste. Diese Liste wird in der globalen Variable mit dem angegebenen Namen gehalten. Eine evtl. vorhandene Liste mit dem gleichen Namen wird geloescht.
/addh syn /createlist listenname
/addh en info \
Creates an empty list, which is stored in the global variable with the same name. An existing list with this name is deleted.
/addh en syn /createlist list_name
/addh see /createnewlist
/addh createlist comm

/def createlist = /set %1=<I>


/addh info \
Erzeugt eine neue Liste, wenn die Liste noch nicht existiert
/addh syn /createnewlist listenname
/addh en info \
If there is no list with this name, it is created.
/addh en syn /createnewlist list_name
/addh see /createlist
/addh func isList
/addh mak /createlist
/addh createnewlist comm

/def createnewlist = \
    /if (isList({1})=~error) \
        /createlist %1%;\
    /endif%;


/addh info \
Fuegt einen Schluessel, in dem auch Leerzeichen enthalten sein koennen, und einen Wert, die durch ein kaufmaennisches UND ('&') getrennt sind, an den Anfang einer Liste ein. Schluessel oder Wert duerfen allerdings nicht mit einem Leerzeichen enden.
/addh syn /xaddbtolist listenname&schluessel&wert
/addh ex /xaddbtolist fruechte&reife Aepfel&10 Stueck
/addh en info \
Adds a key and value to the beginning of a list. The key may contain spaces (but not at the end), because the parameters are separated by '&'.
/addh en syn /xaddbtolist list_name&key&value
/addh en ex /xaddbtolist trousers&blue jeans&10
/addh mak /paramparse
/addh see /addbtolist, /xaddtolist, /xuaddtolist
/addh xaddbtolist comm

/def xaddbtolist = \
    /let x1=$(/paramparse & 1 %*)%;\
    /let x2=$(/paramparse & 2 %*)%;\
    /let x3=$(/paramparse & -2 %*)%;\
    /let tmp=%;\
    /test tmp:=%x1%;\
    /set %x1=$[strcat("<I>",x2,">I<",x3,tmp)]


/addh info \
Fuegt einen Schluessel, in dem auch Leerzeichen enthalten sein koennen, und einen Wert, die durch ein kaufmaennisches UND ('&') getrennt sind, am Ende einer Liste ein. Schluessel oder Wert duerfen allerdings nicht mit einem Leerzeichen enden.
/addh syn /xaddtolist listenname&schluessel&wert
/addh ex /xaddtolist fruechte&faule Birnen&8 Stueck
/addh en info \
Adds a key and value to a list. The key may contain spaces (but not at the end), because the parameters are separated by '&'.
/addh en syn /xaddtolist list_name&key&value
/addh en ex /xaddtolist drinks&ginger ale&5 bottles
/addh mak /paramparse
/addh see /addtolist, /xaddbtolist, /xuaddtolist
/addh xaddtolist comm

/def xaddtolist = \
    /let x1=$(/paramparse & 1 %*)%;\
    /let x2=$(/paramparse & 2 %*)%;\
    /let x3=$(/paramparse & -2 %*)%;\
    /let tmp=%;\
    /test tmp:=%x1%;\
    /set %x1=$[strcat(tmp,x2,">I<",x3,"<I>")]


/addh info \
Fuegt einen Schluessel, in dem auch Leerzeichen enthalten sein koennen, und einen Wert, die durch ein kaufmaennisches UND ('&') getrennt sind, am Ende einer Liste ein, nachdem alle bisherigen Vorkommen des Schluessels geloescht wurden. Schluessel oder Wert duerfen allerdings nicht mit einem Leerzeichen enden oder beginnen.
/addh syn /xuaddtolist listenname&schluessel&wert
/addh ex /xuaddtolist fruechte&faule Birnen&8 Stueck
/addh en info \
Adds a key and value to the end of a list after deleting all entries with this key. The key may contain spaces (but not at the end), because the parameters are separated by '&'.
/addh en syn /xuaddtolist list_name&key&value
/addh en ex /xuaddtolist drinks&white wine&5 bottles
/addh mak /paramparse, /delallkeysandvalues
/addh see /uaddtolist, /xaddtolist, /xaddbtolist
/addh xuaddtolist comm

/def xuaddtolist = \
    /let x1=$(/paramparse & 1 %*)%;\
    /let x2=$(/paramparse & 2 %*)%;\
    /let x3=$(/paramparse & -2 %*)%;\
    /delallkeysandvalues %x1 %x2%;\
    /let tmp=%;\
    /test tmp:=%x1%;\
    /set %x1=$[strcat(tmp,x2,">I<",x3,"<I>")]


/addh info \
Fuegt einen Schluessel (ohne Leerzeichen) und einen Wert an das Ende einer Liste an.
/addh syn /addtolist listenname schluessel wert
/addh en info \
Appends a key (without spaces) and a value to the end of a list.
/addh en syn /addtolist list_name key value
/addh en ex /addtolist weapons halberd two-handed, not on horse
/addh see /addbtolist, /xaddtolist, /uaddtolist, /getvalueof
/addh addtolist comm

/def addtolist = \
    /let tmp=%;\
    /test tmp:=%1%;\
    /set %1=%{tmp}%{2}>I<%{-2}<I>


/addh info \
Fuegt einen Schluessel (ohne Leerzeichen) und einen Wert an das Ende einer Liste an, nachdem alle bisherigen Vorkommen des Schluessels geloescht wurden.
/addh syn /uaddtolist listenname schluessel wert
/addh en info \
Adds a key and value to the end of a list after deleting all entries with this key.
/addh en syn /uaddtolist list_name key value
/addh see /addtolist, /addbtolist, /xuaddtolist, /getvalueof
/addh mak /deleteallkeysandvalues, /addtolist
/addh uaddtolist comm

/def uaddtolist = \
    /delallkeysandvalues %1 %2%;\
    /test addtolist({1},{2},{-2})%;


/addh info \
Fuegt einen Schluessel (ohne Leerzeichen) und einen Wert am Anfang einer Liste ein.
/addh syn /addbtolist listenname schluessel wert
/addh en info \
Adds a key and a value to the beginning of a list.
/addh en syn /addbtolist list_name key value
/addh see /addtolist, /xaddbtolist, /getvalueof
/addh addbtolist comm

/def addbtolist = \
    /let tmp=%;\
    /test tmp:=%1%;\
    /set %1=$[strcat("<I>",{2},">I<",{-2},tmp)]


/addh info \
Fuegt einen Schluessel (ohne Leerzeichen) und eine (Sub)Liste am Ende einer Liste an.@{N}\
In der Subliste werden die Listentrenner um eine Stufe erweitert.
;In der Subliste werden relevante Zeichen ersetzt (Stern->Klammeraffe, Doppelkreuz->kaufm. Und).
/addh syn /addlisttolist listenname schluessel subliste (der Inhalt!)
/addh ex /addlisttolist obst aepfel %apfelsorten
/addh en info \
Adds a key and a (sub)list as value to the end of a list.@{N}\
The list markers of the sublist are increased one level.
/addh en syn /addlisttolist list_name key sublist (not sublist_name!)
/addh en ex /addlisttolist weapon_list swords %sword_list
/addh see /addtolist, /getlistvalueof
/addh mak /makesub, /addtolist
/addh addlisttolist comm

/def addlisttolist = \
     /test addtolist({1},{2},makesub({-2}))


/addh info \
Fuegt einen Schluessel (ohne Leerzeichen) und eine (Sub)Liste am Ende einer Liste an, nachdem alle anderen Vorkommen dieses Schluessels geloescht wurden.@{N}\
In der Subliste werden die Listentrenner um eine Stufe erhoeht.
/addh syn /uaddlisttolist listenname schluessel subliste (der Inhalt!)
/addh ex /uaddlisttolist obst aepfel %apfelsorten
/addh en info \
Adds a key and a (sub)list as value to the end of a list after deleting all entries with this key.@{N}\
The list markers of the sublist are increased one level.
/addh en syn /uaddlisttolist list_name key sublist (not sublist_name!)
/addh en ex /uaddlisttolist weapon_list swords %sword_list
/addh see /addlisttolist, /uaddtolist, /getlistvalueof
/addh mak /unmakesub, /uaddtolist
/addh uaddlisttolist comm

/def uaddlisttolist = \
     /test uaddtolist({1},{2},makesub({-2}))


/addh info \
Fuegt einen Schluessel und eine (Sub)Liste am Ende einer Liste an. \
Dabei kann der Schluessel Leerzeichen enthalten. Die einzelnen Parameter muessen durch das Trennzeichen kaufmaennisches UND ('&') getrennt sein.@{N}\
In der Subliste werden die Listentrenner um eine Stufe erweitert.
/addh syn /xaddlisttolist listenname&schluessel&subliste (der Inhalt!)
/addh ex /xaddlisttolist rezepte&ohne Fleisch&%puddings
/addh en info \
Same as /addlisttolist, but the key may contain spaces. The parameters are separated by '&'.
/addh en syn /xaddlisttolist list_name&key&sublist
/addh en ex /xaddlisttolist armour&metal armour&%chainmail_list
/addh see /xaddtolist, /addlisttolist, /getlistvalueof
/addh mak /paramparse, /makesub
/addh xaddlisttolist comm

/def xaddlisttolist =\
    /let x1=$(/paramparse & 1 %*)%;\
    /let tmp=%;\
    /test tmp:=%x1%;\
    /let x2=$(/paramparse & 2 %*)%;\
    /let x3=$(/paramparse & -2 %*)%;\
    /let x3=$(/makesub %x3)%;\
    /set %x1=$[strcat(tmp,x2,">I<",x3,"<I>")]


/addh info \
Fuehrt fuer jedes Paar der Liste das angegebene Makro mit den entsprechenden Parametern (Schluessel und/oder Wert) aus. Der zweite Parameter sagt aus, was dem Makro uebergeben wird (key|value|key value).
/addh syn /forEach listenname (k|v|kv) /makro
/addh ex /forEach freunde k /finger
/addh en info \
For every entry of the list the macro is called with the parameters key ('k'), value ('v') or key and value ('kv').
/addh en syn /forEach list_name (k|v|kv) /macro_name
/addh en ex /forEach friends k /finger
/addh var %fetemp_list, %value, %break_forEach
/addh mak /getfirstkey, /deletekeyandvalue
/addh forEach comm

; todo key+value als block vorne abschneiden und splitten
; fuer k,v,x variablen setzen
;
/def forEach = \
    /let opt_k=$[{2}=/"*k*"]%;\
    /let opt_v=$[{2}=/"*v*"]%;\
    /let opt_x=$[{2}=/"*x*"]%;\
    /let opt_n=$[{2}=/"*n*"]%;\
    /let forEach_list=%;\
    /test forEach_list:=substr(%{1},3)%;\
    /set break_forEach=0%;\
    /let forEachCounter=0%;\
    /let forEach_key=%;\
    /let forEach_value=%;\
    /let forEach_makro=%;\
    /let off=%;/let off2=%;\
    /test forEach_makro:=opt_x|opt_n ? substr({-2},1) : {-2}%;\
    /while (forEach_list!~"" & !break_forEach) \
        /test off:=strstr(forEach_list,'>I<')%;\
	/test forEach_key:=substr(forEach_list,0,off)%;\
;	/test forEach_list:=substr(forEach_list,off+3)%;\
        /test off2:=strstr(forEach_list,'<I>')%;\
	/test forEach_value:=substr(forEach_list,off+3,off2-off-3)%;\
	/test forEach_list:=substr(forEach_list,off2+3)%;\
	/if (opt_n) \
	   /test %forEach_makro()%;\
	/elseif (opt_x) \
	    /test %{forEach_makro}(forEach_key,forEach_value)%;\
	/else \
	    /eval -s0 %forEach_makro $[opt_k ? forEach_key : ""] $[opt_v ? forEach_value : ""]%;\
	/endif%;\
	/test ++forEachCounter%;\
    /done%;\
    /set break_forEach=0%;


/addh info \
Wie /getvalueof nur, dass der Schluessel als regexp angegeben wird (ohne Klammern rundherum).@{N}\
Die regexp kann am Anfang und/oder Ende mit '^' bzw. '$' verankert werden. Um zu verhindern, dass ein abschliessendes '$' als Endekennzeichen aufgefasst wird, muss dieses verdoppelt werden. ('$' muss natuerlich ggf. mit '\' maskiert werden.)
/addh syn /reggetvalueof listenname Schluessel (als regexp)
/addh ex Die regexp von@{N}\
@{}  /reggetvalueof fruechte [a-z]*nue?sse?@{N}\
wuerde auf "walnuss", "haselnuesse" und "nussknacker" passen. Sollen nur Nussarten gefunden werden, muesste man@{N}\
@{}  /reggetvalueof fruechte [a-z]*nue?sse?\$@{N}\
verwenden.@{N}\
@{}  /reggetvalueof waehrungen ^(US|us)-\\\$\$@{N}\
wuerde nur den Wert der Schluessel "US-$" oder "us-$" zurueckgeben.
/addh return Erster zum Schluessel passender Wert als Rueckgabewert und in %value, %error bei Misserfolg.
/addh en info \
Same as ?/getvalueof, but the key is a regexp@{N}\
Start and end of the regexp can be denoted with '^' and '$' as usual. (So a trailing '$' must be escaped.)
/addh en syn /reggetvalueof list_name key_regexp
/addh en ex The regexp of@{N}\
@{}    /reggetvalueof fruits [a-z]*nuts?@{N}\
would match "walnut", "hazelnuts" and "nutcracker". To get nuts only,@{N}\
@{}    /reggetvalueof fruits [a-z]*nuts?\$@{N}\
can be used.@{N}\
@{}    /reggetvalueof currencies ^(US|us)-\\\$\$@{N}\
would only match "US-$" or "us-$".
/addh en return The value of the first matching key in %value and by /return; %error if there is no matching key.
/addh var %value
/addh see /convert_regexp, /getvalueof, regexp, /reggetkey
/addh func convert_regexp
/addh reggetvalueof func

/def reggetvalueof = \
    /let tmp=%;\
    /test tmp:=%1%;\
    /let reg=$[convert_regexp("k",{-1})]%;\
    /if (regmatch(reg,tmp) == 1) \
	/let whole=%PR%;\
	/let off=$[strstr(whole,"<I>")]%;\
	/if (off>-1) \
	    /set value=$[substr(whole,0,off)]%;\
	/else \
	    /set value=%error%;\
        /endif%;\
    /else \
	/set value=%error%;\
    /endif%;\
    /return value


/addh info \
Konvertiert eine uebergebene regexp so, dass mit ihr innerhalb von Listen gesucht werden kann. Der erste Parameter gibt an, ob die regexp auf einen Schluessel ('k') oder einen Wert ('v') passen soll. Die regexp kann am Anfang und/oder Ende mit '^' bzw. '$' verankert werden. Um zu verhindern, dass ein abschliessendes '$' als Endekennzeichen aufgefasst wird, muss dieses verdoppelt werden. ('$' muss natuerlich ggf. mit '\' maskiert werden.)
/addh syn /convert_regexp (k|v) regexp
/addh return die konvertierte regexp als Rueckgabewert mit /result
/addh ex /let reg=$[convert_regexp("k", "^(K|k)ette")]@{N}\
wuerde in %reg eine regexp speichern, die auf alle Schluessel passt, welche mit "Kette" oder "kette" beginnen. Durch@{N}\
@{}  /let reg=$(/convert_regexp v ([uU]s-|kanadische )\\\$\$@{N}\
wuerde ein regexp erzeugt, die auf alle Werte passt, welche mit "kanadische $", "us-$" oder "Us-$" enden.
/addh en info \
Converts a regexp in a way that it can be used to search in lists. The first parameter ('k' or 'v') tells /convert_regexp whether the pattern should match a key or a value. '^' and '$' have their usual meaning, so a trailing '$' must be escaped.
/addh en syn /convert_regexp (k|v) regexp
/addh en return the converted regexp by /result
/addh en ex /let reg=$[convert_regexp("k", "^(C|c)hain)]@{N}\
stores a regexp-pattern in %reg that would find all keys beginning with "Chain" or "chain". By@{N}\
@{}  /let reg=$(/convert_regexp v ([uU]s-|canadian )\\\$\$@{N}\
you would get a regexp that would match any key ending with "canadian $", "us-$" or "Us-$".
/addh see /reggetkey, /reggetvalue, /reggetvalueof, regexp
/addh convert_regexp func

/def convert_regexp = \
    /if ({1} =~ "k") \
       /let pre=<I>%;\
       /let post=>I<%;\
    /else \
       /let pre=>I<%;\
       /let post=<I>%;\
    /endif%;\
    /if (substr({2},0,1) =~ "^") \
        /let reg=$[strcat(pre,"(",substr({-1},1))]%;\
    /else \
        /let reg=$[strcat(pre,"([^",substr(pre,2,1),"]*",{-1})]%;\
    /endif%;\
    /if (substr({-1},strlen({-1})-1,1) =~ "$") \
        /test reg:=strcat(substr(reg,0,strlen(reg)-1),")",post)%;\
    /else \
        /test reg:=strcat(reg,"[^",substr(post,0,1),"]*)",post)%;\
    /endif%;\
    /result reg


/addh info \
Es wird der erste Schluessel geliefert, auf den die uebergebene regexp passt.
/addh syn /reggetkey listenname regexp
/addh return erster zur Regexp passender Schluessel als Rueckgabewert und in %value
/addh en info \
Returns the first key matching the regexp.
/addh en syn /reggetkey list_name regexp
/addh en return in %value and by /return
/addh see /convert_regexp, /getkeyofvalue, regexp, /reggetvalueof
/addh var %value
/addh func convert_regexp
/addh reggetkey func

/def reggetkey = \
    /let tmp=%;\
    /test tmp:=%1%;\
    /let reg=$[convert_regexp("k",{-1})]%;\
    /if (regmatch(reg,tmp)) \
        /let tmp=$[substr(tmp,strlen({PL})+3)]%;\
	/set value=$[substr(tmp,0,strstr(tmp,">I<"))]%;\
    /else \
        /set value=%error%;\
    /endif%;\
    /return value


/addh info \
Wie /getkeyofvalue nur, dass der Wert als regexp angegeben ist (ohne Klammern rundherum).
/addh syn /reggetkeyofvalue listenname regexp
/addh return erster zum Wert passender Schluessel als Rueckgabewert und in %value, %error bei Misserfolg
/addh en info \
Same as ?/getkeyofvalue, but the value is a regexp.
/addh en syn /reggetkeyofvalue list_name regexp
/addh en return First key which value matches the regexp in %value and by /return; %error if unsuccessful.
/addh see /convert_regexp, /reggetkeyofvalue, regexp, /reggetvalueof
/addh func convert_regexp
/addh var %value
/addh reggetkeyofvalue func

/def reggetkeyofvalue = \
    /let tmp=$[reggetvalue({1},{-1})]%;\
    /if (tmp !~ error) \
        /let tmp=$[getkeyofvalue({1},tmp)]%;\
    /endif%;\
    /set value=%tmp%;\
    /return value


/addh info \
Liefert den ersten Wert zurueck, auf den die regexp passt.
/addh syn /reggetvalue listenname regexp
/addh return erster zur regexp passender Wert als Rueckgabewert und in %value
/addh en info \
Returns the value of the first key matching the regexp.
/addh en syn /reggetvalue list_name regexp
/addh en return in %value and by /return
/addh see /convert_regexp, regexp
/addh func convert_regexp
/addh var %value
/addh reggetvalue func

/def reggetvalue = \
    /let tmp=%;\
    /test tmp:=%1%;\
    /let reg=$[convert_regexp("v",{-1})]%;\
    /if (regmatch(reg,tmp)) \
	/set value=$[substr({P0},3,strlen({P0})-6)]%;\
    /else \
        /set value=%error%;\
    /endif%;\
    /return value


/addh info \
Liefert den Index eines Wertes innerhalb einer Liste. Die Zaehlung beginnt bei 0. Das Ergebnis wird zurueckgegeben und in %value gespeichert. Ist der Wert nicht in der Liste, so ist das Ergebnis %error. Ist der Wert mehrmals in der Liste, wird der kleinste passende Index zurueckgegeben.
/addh syn /getidxofvalue (liste|listenname) wert
/addh ex Sowohl@{N}\
@{}  /test index:=getidxofvalue("skills_list","miserabel")@{N}\
als auch@{N}\
@{}  /test index:=getidxofvalue(skills_list,"miserabel")@{N}\
liefern den gleichen Wert.
/addh return Index oder %error als Rueckgabewert und in %value.
/addh en info \
Returns the first index of a value in a list. The first entry has number 0.
/addh en syn /getidxofvalue (list|list_name) value
/addh en ex Both@{N}\
@{}  /test index:=getidxofvalue("skills_list","miserable")@{N}\
and@{N}\
@{}  /test index:=getidxofvalue(skills_list,"miserable")@{N}\
would give the same result.
/addh en return index or %error by /return and in %value
/addh func count_entries, isVar
/addh var %value
/addh see /getidxofkey
/addh changes 1.18: Es kann sowohl der Listenname als auch direkt die Liste uebergeben werden. Ausserdem ist es jetzt eine Funktion.
/addh getidxofvalue func

/def getidxofvalue = \
; Man kann sowohl den Listennamen als auch die Liste uebergeben,
; d. h. sowohl getidxofvalue(skills_list,"miserabel") als auch
; getidxofvalue("skills_list","miserabel") sind moeglich.
    /let tmp=%1%;\
    /if (isVar(tmp))\
        /test tmp:=%tmp%;\
    /endif%;\
    /let pos=$[strstr(tmp,strcat(">I<",{-1},"<I>"))]%;\
    /if (pos == -1) \
        /set value=%error%;\
    /else \
        /test value:=count_entries(substr(tmp,0,pos))%;\
    /endif%;\
    /return value


/addh info \
Liefert den Index eines Schluessels innerhalb einer Liste. Die Zaehlung beginnt bei 0. Das Ergebnis wird zurueckgegeben und in %value gespeichert. Ist der Schluessel nicht in der Liste, so ist das Ergebnis %error. Ist der Schluessel mehrmals in der Liste, wird der kleinste passende Index zurueckgegeben.@{N}\
/addh syn /getidxofkey liste|listenname schluessel
/addh ex Sowohl@{N}\
@{}  /test index:=getidxofvalue("skills_list","50%")@{N}\
als auch@{N}\
@{}  /test index:=getidxofvalue(skills_list,"50%")@{N}\
liefern den gleichen Wert.
/addh return Index oder %error als Rueckgabewert und in %value.
/addh en info \
Returns the first index of a key in a list. The first entry has number 0.
/addh en syn /getidxofkey (list|list_name) key
/addh en ex Both@{N}\
@{}  /test index:=getidxofkey("skills_list","50%")@{N}\
and@{N}\
@{}  /test index:=getidxofkey(skills_list,"50%")@{N}\
would give the same result.
/addh en return index or %error by /return and in %value
/addh func count_entries, isVar
/addh var %value
/addh see /getidxofvalue
/addh changes 1.18: Es kann sowohl der Listenname als auch direkt die Liste uebergeben werden. Ausserdem ist es jetzt eine Funktion.
/addh getidxofkey func

/def getidxofkey = \
    /let tmp=%1%;\
    /if (isVar(tmp))\
        /test tmp:=%tmp%;\
    /endif%;\
    /let pos=$[strstr(tmp,strcat("<I>",{-1},">I<"))]%;\
    /if (pos == -1) \
        /set value=%error%;\
    /else \
        /test value:=count_entries(substr(tmp,0,pos+3))%;\
    /endif%;\
    /return value



/addh info \
Liefert den Index des ersten Wertes zurueck, auf den die regexp passt.@{N}\
Die Liste kann sowohl direkt als auch ueber ihren Namen angegeben werden (siehe Beispiel).
/addh syn /reggetidxofvalue (liste|listenname) regexp
/addh return Index des ersten zur regexp passenden Wertes oder %error als Rueckgabewert und in %value
/addh ex Sowohl@{N}\
@{}  /test index:=reggetidxofvalue("skills_list","5[0-9]%")@{N}\
als auch@{N}\
@{}  /test index:=reggetidxofvalue(skills_list,"5[0-9]%")@{N}\
liefern den gleichen Wert.
/addh en info \
Same as /getidxofvalue, but the value is search by a regexp.
/addh en syn /reggetidxofvalue (list|list_name) regexp
/addh en return index or %error by /return and in %value
/addh en ex Both@{N}\
@{}  /test index:=reggetidxofvalue("skills_list","5[0-9]%")@{N}\
and@{N}\
@{}  /test index:=reggetidxofvalue(skills_list,"5[0-9]%")@{N}\
would give the same result.
/addh see regexp, /reggetidxofkey, /getikey, /getivalue, /getidxofvalue
/addh func count_entries, isVar
/addh var %value
/addh changes 1.18: Es kann sowohl der Listenname als auch direkt die Liste uebergeben werden. Ausserdem ist es jetzt eine Funktion.
/addh reggetidxofvalue func

/def reggetidxofvalue = \
; Man kann sowohl den Listennamen als auch die Liste uebergeben,
; d. h. sowohl reggetidxofvalue(skills_list,".* miserabel") als auch
; reggetidxofvalue("skills_list",".* miserabel") sind moeglich.
    /let tmp=%1%;\
    /if (isVar(tmp)) \
        /test tmp:=%tmp%;\
    /endif%;\
    /if (regmatch(strcat(">I<(",{-1},"<I>)"),tmp)) \
	/test value:=count_entries(substr(tmp,0,strlen({PL})+3))%;\
    /else \
        /set value=%error%;\
    /endif%;\
    /return value


/addh info \
Liefert den Index des ersten Schluessels zurueck, auf den die regexp passt.@{N}\
Die Liste kann sowohl direkt als auch ueber ihren Namen angegeben werden (siehe Beispiel).
/addh syn /reggetidxofkey (liste|listenname) regexp
/addh return Index des ersten zur regexp passenden Schluessels oder %error als Rueckgabewert und in %value
/addh ex Sowohl@{N}\
@{}  /test index:=reggetidxofkey("skills_list",".* miserabel(st)?%")@{N}\
als auch@{N}\
@{}  /test index:=reggetidxofkey(skills_list,".* miserabel(st)?")@{N}\
liefern den gleichen Wert.
/addh en info \
Same as /getidxofkey, but the key is searched by a regexp.
/addh en syn /reggetidxofkey (list|list_name) regexp
/addh en return index or %error by /return and in %value
/addh en ex Both@{N}\
@{}  /test index:=reggetidxofkey("skills_list",".* (very )?miserable")@{N}\
and@{N}\
@{}  /test index:=reggetidxofkey(skills_list,".* (very )?miserable")@{N}\
would give the same result.
/addh see regexp, /getidxofkey, /getikey, /getivalue, /reggetidxofvalue
/addh func count_entries, isVar
/addh var %value
/addh changes 1.18: Es kann sowohl der Listenname als auch direkt die Liste uebergeben werden. Ausserdem ist es jetzt eine Funktion.
/addh reggetidxofkey func

/def reggetidxofkey = \
; Man kann sowohl den Listennamen als auch die Liste uebergeben,
; d. h. sowohl reggetidxofkey(skills_list,".* miserabel(st?)%") als auch
; reggetidxofkey("skills_list",".* miserabel(st)?") sind moeglich.
    /let tmp=%1%;\
    /if (isVar(tmp)) \
        /test tmp:=%tmp%;\
    /endif%;\
    /if (regmatch(strcat("<I>(",{-1},">I<)"),tmp)) \
	/test value:=count_entries(substr(tmp,0,strlen({PL})+3))%;\
    /else \
        /set value=%error%;\
    /endif%;\
    /return value


/addh info \
Liefert den ersten Wert mit diesem Schluessel zurueck.
/addh syn /getvalueof listenname schluessel
/addh return erster zum Schluessel passender Wert oder %error bei Fehler als Rueckgabewert und in %value
/addh ex /getvalueof waffen dolch
/addh en info \
Returns the value of the first entry with the given key.
/addh en syn /getvalueof list_name key
/addh en return value or %error by /return and in %value
/addh en ex /getvalueof weapons dagger
/addh var %value
/addh getvalueof func

/def getvalueof = \
    /let tmp=%;\
    /test tmp:=%1%;\
    /let off=$[strstr(tmp,strcat("<I>",{-1},">I<"))]%;\
    /if (off>-1) \
	/let tmp=$[substr(tmp,off+6+strlen({-1}))]%;\
	/set value=$[substr(tmp,0,strstr(tmp,"<I>"))]%;\
    /else \
        /set value=%error%;\
    /endif%;\
    /return value


/addh info \
Liefert bei aufeinanderfolgenden Aufrufen die verschiedenen Werte, die zu einem Schluessel in der Liste gespeichert sind.
/addh syn /getnextvalueof listenname schluessel
/addh return der Wert zu diesem Schluessel oder %error, wenn keine (mehr) vorhanden sind, als Rueckgabewert und in %value
/addh en info \
By calling /getnextvalueof you can get all values with the given key. (One by each call). %error means that there are no (more) matching keys.
/addh en syn /getnextvalueof list_name key
/addh en return the (next) value for this key or %error by /return and in %value
/addh var %value, %getnextvalueof, %getnextvalueof_off
/addh getnextvalueof func

/def getnextvalueof = \
    /if ((getnextvalueof!~{*}) | ({*}=~"")) \
	/set getnextvalueof=%*%;\
	/set getnextvalueof_off=0%;\
    /endif%;\
    /if ({*}=~"") \
        /set value=%error%;\
	/return value%;\
    /endif%;\
    /let tmp=%;\
    /test tmp:=%1%;\
    /let off=$[strnstr(tmp,getnextvalueof_off,strcat("<I>",{-1},">I<"))]%;\
    /test getnextvalueof_off:=(off==-1)?off:(off+1)%;\
    /if (off>-1) \
	/let tmp=$[substr(tmp,off+6+strlen({-1}))]%;\
	/set value=$[substr(tmp,0,strstr(tmp,"<I>"))]%;\
    /else \
        /set value=%error%;\
    /endif%;\
    /return value

/set getnextvalueof=


/addh info \
Liefert die Anzahl der Eintraege in der angegebenen Liste. Falls keine Liste uebergeben wurde, wird %error zurueckgegeben.
/addh syn /count_entries (liste|listenname)
/addh return ueber /result
/addh en info \
Returns the number of entries of the list or %error, if it is no list.
/addh en return by /result
/addh en syn /count_entries (list|list_name)
/addh ex /let cnt=$(/count_entries demo_list)@{N}\
/test cnt:=count_entries(demo_list)
/addh func isVar
/addh changes 1.18: Es kann sowohl der Listenname als auch direkt die Liste uebergeben werden. Ausserdem ist es jetzt eine Funktion.
/addh count_entries func

/def count_entries = \
    /let tmp=%1%;\
    /if (isVar(tmp))\
        /test tmp:=%tmp%;\
    /endif%;\
    /let off=$[strstr(tmp,"<I>")]%;\
    /let count_entries=-1%;\
    /while (off>-1) \
        /test ++count_entries%;\
	/let tmp=$[substr(tmp,off+3)]%;\
	/let off=$[strstr(tmp,"<I>")]%;\
    /done%;\
    /if (count_entries==-1) \
        /result error%;\
    /else \
        /result count_entries%;\
    /endif%;\


/addh info \
Gibt den ersten gefundenen zum Schluessel passenden Wert zurueck und loescht ggf. das Paar.
/addh syn /getdvalueof listenname schluessel
/addh return erster zum Schluessel passender Wert oder %error bei Fehler als Rueckgabewert und in %value
/addh en info \
Returns the value of the first occurance of the key and deletes this entry.
/addh en syn /getdvalueof list_name key
/addh en return value or %error by /return and in %value
/addh see /getvalueof, /deletekeyandvalue
/addh var %value
/addh getdvalueof func

/def getdvalueof = \
    /let tmp=%;\
    /test tmp:=%1%;\
    /let off=$[strstr(tmp,strcat("<I>",{-1},">I<"))]%;\
    /if (off>-1) \
	/let part1=$[substr(tmp,0,off)]%;\
	/let reg=$[substr(tmp,off+6+strlen({-1}))]%;\
	/let off=$[strstr(reg,"<I>")]%;\
	/set %1=$[strcat(part1,substr(reg,off))]%;\
	/set value=$[substr(reg,0,off)]%;\
    /else \
        /set value=%error%;\
    /endif%;\
    /return value


/addh info \
Beim Arbeiten mit Listen und Indizes ist zu beachten, dass die Zaehlung des Index bei Null beginnt!
/addh en info \
Remember that the first entry of a list has index 0!
/addh func geti, getidxofkey, getidxofvalue, reggetidxofkey, reggetidxofvalue, delikeyandvalue, getikey, getivalue
/addh index misc


/addh info \
Liefert den Teil der Liste zurueck, der am Index beginnt. Diese Funktion ist zum internen Gebrauch bestimmt. Der Index beginnt bei Null!
/addh syn /geti listenname index
/addh return Liste ab Index als Rueckgabewert und in %value oder %error, falls index zu gross ist
/addh en info \
Returns the part of the list beginning at the index. For internal use.
/addh en syn /geti list_name index
/addh en return list beginning at index or %error (if index is too large) by /return and in %value
/addh see index, /getikey, /getivalue, /delikeyandvalue
/addh var %value
/addh geti func

/def geti = \
    /let tmp=%;\
    /test tmp:=%1%;\
    /let idx=%2%;\
    /let off=$[strstr(tmp,"<I>")]%;\
    /while (idx>0) \
	/let tmp=$[substr(tmp,off+3)]%;\
	/let off=$[strstr(tmp,"<I>")]%;\
	/if (off==-1) \
	    /set value=%error%;\
	    /return value%;\
	/endif%;\
	/test --idx%;\
    /done%;\
    /set value=$[substr(tmp,off)]%;\
    /if (isEmptyList(value)) \
        /set value=%error%;\
    /endif%;\
    /return value


/addh info \
Loescht das Paar (Schluessel und Wert) am Index. Der Index beginnt bei Null!
/addh syn /delikeyandvalue listenname index
/addh return %error bei Misserfolg (Index zu gross) als Rueckgabewert und in %value
/addh en info \
Deletes the entry (key and value) at the given index.
/addh en syn /delikeyandvalue list_name index
/addh en return %error if index is too large by /return and in %value
/addh see index, /deletekeyandvalue, /deleteallkeys
/addh var %value
/addh delikeyandvalue comm 

/def delikeyandvalue = \
    /let tmp=%;\
    /test tmp:=%1%;\
    /let idx=%2%;\
    /let off=$[strstr(tmp,"<I>")]%;\
    /let part1=%;\
    /while (idx>-1) \
	/let part1=$[strcat(part1,substr(tmp,0,off+3))]%;\
	/let tmp=$[substr(tmp,off+3)]%;\
	/let off=$[strstr(tmp,"<I>")]%;\
	/if (off==-1) \
	    /set value=%error%;\
            /return value%;\
	/endif%;\
	/test --idx%;\
    /done%;\
    /let tmp=$[substr(tmp,off+3)]%;\
    /set %1=$[strcat(part1,tmp)]%;\
    /set value=0%;\
    /return value


/addh info \
Liefert den Wert an Position 'index'. Der Index beginnt bei Null!
/addh syn /getivalue listenname index
/addh return Wert am Index bzw. %error bei Misserfolg als Rueckgabewert und in %value
/addh en info \
Return the value at position 'index'. (Counting starts with 0!)
/addh en syn /getivalue list_name index
/addh en return value or %error (index too large) by /return and in %value
/addh see index, /getikey, /getidxofvalue
/addh mak /geti
/addh var %value
/addh getivalue func

/def getivalue =\
    /let tmp=$[geti({1},{2})]%;\
    /if (tmp!~error) \
	/let off=$[strstr(tmp,">I<")]%;\
	/let tmp=$[substr(tmp,off+3)]%;\
	/let tmp=$[substr(tmp,0,strstr(tmp,"<I>"))]%;\
    /endif%;\
    /set value=%tmp%;\
    /return value


/addh info \
Liefert den Schluessel mit dem angegebenen Index zurueck. Der Index beginnt bei Null!
/addh syn /getikey listenname index
/addh return Schluessel am Index, %error bei Misserfolg als Rueckgabewert und in %value
/addh en info \
Returns the key at position 'index'. (Counting starts with 0!)
/addh en syn /getikey list_name index
/addh en return key or %error (index too large) by /return and in %value
/addh see index, /getivalue, /getidxofkey
/addh mak /geti
/addh var %value
/addh getikey func

/def getikey = \
    /let tmp=$[geti({1},{2})]%;\
    /if (tmp!~error) \
	/let tmp=$[substr(tmp,3,strstr(tmp,">I<")-3)]%;\
    /endif%;\
    /set value=%tmp%;\
    /return value


/addh info \
Liefert zum gegebenen Wert den Schluessel. Wenn der Wert in der Liste nicht eineindeutig ist, wird der erste gefundene Schluessel geliefert.
/addh syn /getkeyofvalue listenname wert
/addh return Schluessel mit diesem Wert, %error bei Misserfolg als Rueckgabewert und in %value
/addh en info \
Returns the key of the first occurance of the given value.
/addh en syn /getkeyofvalue list_name value
/addh en return key or %error (value not found) by /return and in %value
/addh see /getvalueof
/addh var %value
/addh getkeyofvalue func

/def getkeyofvalue = \
    /let tmp=%;\
    /test tmp:=%1%;\
    /let off=$[strstr(tmp,strcat(">I<",{-1},"<I>"))]%;\
    /if (off>-1) \
	/let reg=$[substr(tmp,0,off)]%;\
	/let off=$[strrchr(reg,"<")]%;\
	/let tmp=%;\
	/while (substr(reg,off,3)!~"<I>") \
	    /let tmp=$[strcat(substr(reg,off),tmp)]%;\
	    /let reg=$[substr(reg,0,off)]%;\
	    /let off=$[strrchr(reg,"<")]%;\
	/done%;\
	/let tmp=$[strcat(substr(reg,off+3),tmp)]%;\
    /else \
        /let tmp=%error%;\
    /endif%;\
    /set value=%tmp%;\
    /return value



/addh info \
Falls der angegeben Schluessel nicht in der Liste enthalte ist, wird %error zurueckgegeben.
/addh syn /iskey listenname schluessel  oder  iskey("listenname", "schluessel")
/addh return %error bei Misserfolg als Rueckgabewert und in %value
/addh en info \
Returns %error, if the key cannot be found in the list.
/addh en syn /iskey list_name key  or  iskey("list_name", "key")
/addh en return by /return and in %value
/addh see /getvalueof
/addh var %value
/addh iskey func

/def iskey = \
    /let tmp=%;\
    /test tmp:=%1%;\
    /if (strstr(tmp,strcat("<I>",{-1},">I<"))!=-1) \
	/set value=0%;\
    /else \
        /set value=%error%;\
    /endif%;\
    /return value


/addh info \
Holt die Subliste, die dem Schluessel zugeordnet ist, aus der Liste und loescht sie.
/addh syn /getdlistvalueof listenname schluessel
/addh return Subliste, die dem Schluessel zugeordnet ist oder %error bei Misserfolg als Rueckgabewert und in %value
/addh en info \
Returns the sublist which is the value of the given key and deletes this entry.
/addh en syn /getdlistvalueof list_name key
/addh en return sublist or %error by /return and in %value
/addh see /getlistvalueof
/addh mak /getdvalueof, /makelistofvalue, /unmakesub
/addh var %value
/addh getdlistvalueof comm

/def getdlistvalueof = \
    /let tmp=$[getdvalueof({1},{-1})]%;\
    /if (tmp!~error) \
	/let tmp=$[unmakesub(tmp)]%;\
	/let tmp=$(/makelistofvalue %tmp)%;\
    /endif%;\
    /set value=%tmp%;\
    /return value


/addh info \
Substituiert im String Listentrennzeichen durch Sublistentrennzeichen usw.
/addh syn /makesub string
/addh return per /result
/addh en info \
Increases the level of the list markers by one, i.e. changes a list into a sublist, a sublist into a subsublist ...
/addh en return by /result
/addh see /getlistvalueof, /addlisttolist, /unmakesub
/addh makesub mak

/def makesub = \
     /result replace('I<','II<',replace('I>','II>',{*}))


/addh info \
Substituiert im String Sublistentrennzeichen durch Listentrennzeichen usw.
/addh syn /unmakesub string
/addh return per /result
/addh en info \
Decreases the level of the list markers by one, i.e. changes a sublist into a list, a subsublist into a sublist ...
/addh en return by /result
/addh see /getlistvalueof, /addlisttolist, /makesub
/addh unmakesub mak

/def unmakesub = \
     /result replace('II<','I<',replace('II>','I>',{*}))


/addh info \
Holt die Subliste, die dem Schluessel zugeordnet ist, aus der Liste.
/addh syn /getlistvalueof listenname schluessel
/addh return Subliste, die Schluessel zugeordnet ist, oder %error bei Misserfolg als Rueckgabewert und in %value
/addh en info \
Returns the sublist which is the value of the given key.
/addh en syn /getlistvalueof list_name key
/addh en return sublist or %error by /return and in %value
/addh see /getvalueof
/addh mak /getvalueof, /makelistofvalue, /unmakesub
/addh var %value
/addh getlistvalueof comm

/def getlistvalueof = \
    /let tmp=$[getvalueof({1},{-1})]%;\
    /if (tmp!~error) \
	/test tmp:=makelistofvalue(unmakesub(tmp))%;\
    /endif%;\
    /set value=%tmp%;\
    /return value


/def makelistofvalue = \
    /if (substr({*},0,3)!~"<I>") \
        /result strcat("<I>",{*},">I<<I>")%;\
    /else \
        /result {*}%;\
    /endif%;


/addh info \
Loscht das (erste) Paar Schluessel-Wert.
/addh syn /deletekeyandvalue listenname schluessel
/addh return %error bei Misserfolg (Schluessel nicht gefunden) als Rueckgabewert und in %value
/addh en info \
Deletes the (first) entry with the given key.
/addh en syn /deletekeyandvalue list_name key
/addh en return %error (key not found) by /return and in %value
/addh mak /getvalueof
/addh see /delallkeysandvalues, /delikeyandvalue, /getdvalueof, /getdlistvalueof
/addh var %value
/addh deletekeyandvalue comm

/def deletekeyandvalue = \
    /let tmp=$[getvalueof({1},{-1})]%;\
    /if (tmp!~error) \
	/let whole=$[strcat("<I>",{-1},">I<",tmp,"<I>")]%;\
	/test tmp:=%1%;\
	/let off=$[strstr(tmp,whole)]%;\
	/let part1=$[substr(tmp,0,off)]%;\
	/let part2=$[substr(tmp,off+strlen(whole)-3)]%;\
	/set %1=$[strcat(part1,part2)]%;\
    /endif%;\
    /set value=%tmp%;\
    /return value


/addh info \
Loscht alle Paare Schluessel-Wert.
/addh syn /delallkeysandvalues listenname schluessel
/addh return %error bei Misserfolg (Schluessel nicht gefunden) als Rueckgabewert und in %value
/addh en info \
Deletes all entries with the given key.
/addh en syn /delallkeysandvalue list_name key
/addh en return %error (key not found) by /return and in %value
/addh mak /deletekeyandvalue
/addh see /deletekeyandvalue, /delikeyandvalue, /getdvalueof, /getdlistvalueof
/addh var %value
/addh delallkeysandvalues comm

/def delallkeysandvalues = \
    /let tmp=$[deletekeyandvalue({1},{-1})]%;\
    /if (tmp!~error) \
        /while (tmp!~error) \
            /let tmp=$[deletekeyandvalue({1},{-1})]%;\
        /done%;\
	/let tmp=0%;\
    /endif%;\
    /set value=%tmp%;\
    /return value


/addh info \
Liefert den ersten Wert der Liste zurueck.
/addh syn /getfirstvalue listenname
/addh return erster Wert der Liste oder %error bei Misserfolg Rueckgabewert und in %value
/addh en info \
Returns the first value of the list.
/addh en syn /getfirstvalue list_name
/addh en return first value or %error by /return and in %value
/addh mak /getfirstkey, /getvalueof
/addh var %value
/addh getfirstvalue func

/def getfirstvalue = \
    /let tmp=%;\
    /test tmp:=%1%;\
    /let off=$[strstr(tmp,">I<")]%;\
    /if (off != -1) \
	/let tmp=$[substr(tmp,off+3)]%;\
	/let off=$[strstr(tmp,"<I>")]%;\
	/if (off != -1 ) \
	    /let tmp=$[substr(tmp,0,off)]%;\
	/else \
	    /let tmp=%error%;\
	/endif%;\
    /else \
	/let tmp=%error%;\
    /endif%;\
    /set value=%tmp%;\
    /return value%;


/addh info \
Liefert den ersten Schluessel der Liste zurueck.
/addh syn /getfirstkey listenname
/addh return erster Schluessel der Liste oder %error bei Misserfolg Rueckgabewert und in %value
/addh en info \
Returns the first key of the list.
/addh en syn /getfirstkey list_name
/addh en return first key or %error by /return and in %value
/addh var %value
/addh getfirstkey func

/def getfirstkey = \
    /let tmp=%;\
    /test tmp:=%1%;\
    /let tmp=$[substr(tmp,3,strstr(tmp,">I<")-3)]%;\
    /set value=$[tmp=~"" ? error : tmp]%;\
    /return value%;


;???
;; regmatch
/def savehrsublist = \
    /if (regmatch("^<II>.+>II<",{*})==1) \
	/set temp_list3=%*%;\
	/let string=$[strcat("/createlist sub_list")]%;\
	/set temp_list3=$(/replace <II> <I> %temp_list3)%;\
	/set temp_list3=$(/replace >II< >I< %temp_list3)%;\
	/if (tfwrite(temp_handle,"")==-1) \
	    /echo Write to file failed!%;\
	    /break 10%;\
	/endif%;\
	/if (tfwrite(temp_handle,string)==-1) \
	    /echo Write to file failed!%;\
	    /break 10%;\
	/endif%;\
	/getfirstkey temp_list3%;\
	/while (value!~error) \
	    /let key=%value%;\
	    /getvalueof temp_list3 %key%;\
	    /if (value!~error) \
	        /let xxx=%;\
	        /if (regmatch(" ",key)==1) \
		    /let xxx=x%;\
	        /endif%;\
		/if (tfwrite(temp_handle,"")==-1) \
		    /echo Write to file failed!%;\
		    /break 10%;\
		/endif%;\
		/if (xxx=~"x") \
	            /let string=$[strcat("/xaddtolist sub_list&",{key},"&")]%;\
		    /let string=$[strcat(string,{value})]%;\
		/else \
	            /let string=$[strcat("/addtolist sub_list ",{key})]%;\
		    /let string=$[strcat(string," ",{value})]%;\
		/endif%;\
		/if (tfwrite(temp_handle,string)==-1) \
		    /echo Write to file failed!%;\
		    /break 10%;\
		/endif%;\
	    /endif%;\
	    /deletekeyandvalue temp_list3 %key%;\
	    /getfirstkey temp_list3%;\
	/done%;\
	/result 1%;\
    /else \
        /result 0%;\
    /endif%;


/addh info \
Zeigt die angegebene ?Hashliste in einem lesbaren Format an. Sublisten werden eingerueckt.
/addh syn /hshowlist listenname
/addh en info \
Prints the hash list in a readable form.
/addh en syn /hshowlist list_name
/addh mak /hforEach
/addh hshowlist comm

/defh hshowlist = \
    /test getopts("pse","")%;\
    /if (opt_e) \
        /let echo_attrib=-e%;\
    /endif%;\
    /if (opt_p) \
        /let sl_more=%more%;\
	/more on%;\
    /endif%;\
    /hforEach %1 kv /showlist2%;\
    /if (opt_p & moresize()==0) \
        /more %sl_more%;\
    /endif%;


/addh info \
Zeigt die angegebene Liste in einem lesbaren Format an. Sublisten werden eingerueckt.
/addh syn /showlist [-s] [-p] [-e] listenname
/addh opt -s Sublisten werden rekursiv dargestellt.@{N}\
-p Die Ausgabe wird mit more seitenweise dargestellt.@{N}\
-e Die Ausgabe erfolgt auf tferr.
/addh en info \
Prints the list in a readable form. Sublists are indented.
/addh en syn /showlist [-s] [-p] [-e] list_name
/addh en opt -s sublist are printed in italic@{N}\
-p use more to prevent scrolling@{N}\
-e print list on tferr
/addh mak /forEach, /showlist2
/addh showlist comm

/def showlist = \
    /test getopts("eps","")%;\
    /if (opt_e) \
        /let echo_attrib=-e%;\
    /endif%;\
    /if (opt_p) \
        /let sl_more=%more%;\
	/more on%;\
    /endif%;\
    /forEach %1 kv /showlist2%;\
    /if (opt_p & moresize()==0) \
        /more %sl_more%;\
    /endif%;


/addh info \
Hilfsmethode von /showlist. Fuehrt fuer alle Elemente der Liste die Darstellung durch, ggf. werden Sublisten wieder mit /showlist angezeigt.
/addh en info \
Help macro of /showlist.
/addh mak /echo2, /unmakesub, /showlist
/addh see /showlist
/addh showlist2 mak

/def showlist2 =\
    /if ({forEach_value}=/"<II>*") \
        /echo2 -p %echo_attrib %forEach_key: <Subliste>%;\
        /if (opt_s) \
	    /let temp_show_list=$[unmakesub(forEach_value)]%;\
	    /showlist %echo_attrib -s temp_show_list%;\
	    /echo2 -p %echo_attrib %forEach_key: <Ende Subliste>%;\
	/endif%;\
    /else \
   	/echo2 %echo_attrib -p %forEach_key: %forEach_value%;\
    /endif


/addh info \
Liefert alle Schluessel der angegebenen Liste als mit Komata getrennte Liste zurueck.
/addh return per /result
/addh en info \
Returns all keys of a list separated by ','.
/addh en return by /result
/addh var %listKeys
/addh mak /forEach, /listKeys2
/addh listKeys comm

/def listKeys = \
    /set listKeys=%;\
    /forEach %1 k /listKeys2%;\
    /result substr(listKeys,2)%;

/def listKeys2 = \
    /set listKeys=%listKeys, %*%;


/addh info \
Zeigt die Liste an, so dass Wert aus Sublisten durch Komata getrennt werden und nicht jeweils auf einer Zeile stehen.
/addh syn /showshortlist listenname
/addh en info \
Prints a list. Sublists are separated by ',' and not printed in one line.
/addh en syn /showshortlist list_name
/addh mak /foreEach
/addh showshortlist comm

/defh showshortlist = \
    /forEach %1 kv /showshortlist2%;

/def showshortlist2 =\
    /if ({-1}=/"<II>*") \
	/echo2 -p -- %1:%;\
	/set temp_show_list=$[unmakesub({-1})]%;\
	/forEach temp_show_list kv /showshortlist3%;\
	/unset temp_show_list%;\
	/echolist%;\
    /else \
   	/echo2 -p %1: %-1%;\
    /endif%;

/def showshortlist3 = \
    /echolist $[strcat({1},": ",{-1})]%;


/addh info \
Speichert die angegebene Liste in menschenlesbarer Form. Die Datei heisst 'listenname.hr.list'. Es koennen die von ?/custom verstandenen Optionen verwendet werden.@{N}\
Achtung, /savehrlist verwendet regmatch(), d.h. %P1 etc. aendern ihre Werte!@{N}\
Falls beim Speichern ein Fehler auftrat, wird %error zurueckgegeben.
/addh syn /savehrlist [/custom-Optionen] listenname
/addh en info \
Saves a list in a human readable form in the file 'list_name.hr.list'. Options of ?/custom may be used.@{N}\
/savehrlist uses regmatch(), so %P1 etc. will lose their values.@{N}\
Returns %error if the saving was unsuccessfull.
/addh en syn /savehrlist [/custom-options] list_name
/addh mak /savehrsublist, /custom
/addh var %temp_list, %temp_handle, regmatch-Variablen
/addh see /savelist, tfio, /custom
/addh savehrlist comm

/defh savehrlist =\
    /let res=0%;\
    /custom -a %*%;\
    /test %?%;\
    /let list_name=%load_file%;\
    /if (!dir_exists(load_dir)) /mkdir_all %load_dir%; /endif%;\
    /set temp_list=%;\
    /set temp_handle=%;\
    /test temp_list:=%list_name%;\
    /if ((temp_handle:=tfopen(strcat(load_dir,{list_name},".hr.list"),"w"))==-1) \
	/echo File open failed!%;\
	/let res=%error%;\
	/break%;\
    /else \
	/let string=$[strcat("/createlist ",{list_name})]%;\
	/if (tfwrite(temp_handle,string)==-1) \
	    /echo Write to file failed!%;\
	    /let res=%error%;\
	    /break 2%;\
   	/endif%;\
	/getfirstkey temp_list%;\
	/while (value!~error) \
	    /let key=%value%;\
 	    /let xxx=%;\
	    /if (regmatch(" ",key)==1) \
	        /let xxx=x%;\
	    /endif%;\
	    /getvalueof temp_list %key%;\
	    /if (value!~error) \
	        /if ($(/savehrsublist %value)==0) \
		    /if (xxx=~"x") \
	                /let string=$[strcat("/xaddtolist ",{list_name},"&",{key},"&")]%;\
			/let string=$[strcat(string,{value})]%;\
		    /else \
		        /let string=$[strcat("/addtolist ",{list_name}," ",{key})]%;\
			/let string=$[strcat(string," ",{value})]%;\
		    /endif%;\
	        /else \
		    /if (xxx=~"x") \
		        /let string=$[strcat("/eval /xaddlisttolist ",{list_name},"&",{key},"&")]%;\
			/let string=$[strcat(string,"%sub_list")]%;\
		    /else \
		        /let string=$[strcat("/eval /addlisttolist ",{list_name}," ",{key})]%;\
			/let string=$[strcat(string," %sub_list")]%;\
		    /endif%;\
	        /endif%;\
		/if (tfwrite(temp_handle,"")==-1) \
		    /echo Write to file failed!%;\
		    /let res=%error%;\
		    /break 2%;\
		/endif%;\
		/if (tfwrite(temp_handle,string)==-1) \
		    /echo Write to file failed!%;\
		    /let res=%error%;\
		    /break 2%;\
		/endif%;\
	    /endif%;\
	    /deletekeyandvalue temp_list %key%;\
	    /getfirstkey temp_list%;\
	/done%;\
	/test tfclose(temp_handle)%;\
	/unset temp_handle%;\
	/echo Schreiben von %list_name beendet!%;\
	/unset temp_list%;\
    /endif%;\
    /return res


/addh info \
Speichert die angegebene Liste ab. Die Datei heisst 'listenname.list'. Eine ggf. vorhandene Aenderungsmarkierung wird geloescht. Es koennen die von ?/custom verstandenen Optionen verwendet werden.@{N}\
Falls beim Speichern ein Fehler auftrat, wird %error zurueckgegeben.
/addh syn /savelist [/custom-Optionen] listenname
/addh en info \
Saves a list in the file 'list_name.list'. An exisiting changes-flag ist reseted. Options of ?/custom may be used.@{N}\
/savelist returns %error if an error occured.
/addh en syn /savelist [/custom-options] list_name
/addh var %temp_handle, %value
/addh mak /deletekeyandvalue, /getvalueof, /custom, /addtolist, /deletekeyandvalue, /ifecho
/addh see /savehrlist, tfio, /custom
/addh savelist comm

/defh savelist = \
    /let res=0%;\
    /let param=%*%;\
    /set temp_handle=%;\
    /custom -a %*%;\
    /test %?%;\
    /let list_name=%load_file%;\
    /let tmp=$[getvalueof("lists",list_name)]%;\
    /if (tmp=~error & !dir_exists(load_dir)) /mkdir_all %load_dir%; /endif%;\
    /let tmp=%;\
    /test tmp:=%list_name%;\
    /let file=$[strcat(load_dir,{list_name},".list")]%;\
    /if ((temp_handle:=tfopen(file,"w"))==-1) \
	/echo %file File open failed!%;\
	/let res=%error%;\
	/break%;\
    /elseif (tfwrite(temp_handle,strcat("/set ",{list_name},"=",tmp))==-1) \
	/echo Write to file failed!%;\
	/let res=%error%;\
	/break%;\
    /endif%;\
    /let llen=$[strlen(tmp)]%;\
    /let tmp=$[getvalueof("lists",list_name)]%;\
    /if (tmp!~error | strstr(tmp,llen)) \
	/deletekeyandvalue lists %list_name%;\
	/addtolist lists %list_name %llen %param%;\
    /endif%;\
    /test tfclose(temp_handle)%;\
    /unset temp_handle%;\
    /ifecho !load_quiet Saved list %list_name%;\
    /return res


/addh info \
Laedt die Liste, die den Namen %parameter_list_name hat und in den Verzeichnis das durch die Optionen in %parameter_list_location vorgegeben ist. Dies ist vor allem fuer Pakete notwendig, fuer die der Parameter sinnvollerweise der Name des Pakets ist.
/addh syn /loadnamedlist paket_prefix
/addh ex Nach@{N}\
@{}  /set waffen_list_name=waffen@{N}\
@{}  /set waffen_list_location=ausruestung@{N}\
wuerde@{N}\
@{}  /loadnamedlist waffen@{N}\
die Liste `waffen` laden, welche im File 'ausruestung/waffen.list' gespeichert ist.
/addh en info \
Loads the list with the name %parameter_list_name from the directory denoted by %parameter_list_location. Useful for packages which should use their name as parameter.
/addh en syn /loadnamedlist package_prefix
/addh en ex After@{N}\
@{}  /set weapons_list_name=weapons@{N}\
@{}  /set weapons_list_location=things@{N}\
the line@{N}\
@{}  /loadnamedlist weapons@{N}\
would load the list 'weapons' from the file 'things/weapons.list'.
/addh see /savenamedlist, /loadlist
/addh loadnamedlist comm

/def loadnamedlist = \
    /eval /loadlist %-L \%%{L}_list_location \%%{L}_list_name


/addh info \
Speichert die Liste, die den Namen %parameter_list_name hat in dem Verzeichnis das durch die Optionen in %parameter_list_location vorgegeben ist. Dies ist vor allem fuer Pakete notwendig, fuer die der Parameter sinnvollerweise der Name des Pakets ist.
/addh syn /savenamedlist paket_prefix
/addh ex Nach@{N}\
@{}  /set waffen_list_name=waffen@{N}\
@{}  /set waffen_list_location=ausruestung@{N}\
wuerde@{N}\
@{}  /savenamedlist waffen@{N}\
die Liste 'waffen' im File 'ausruestung/waffen.list' speichern.
/addh en info \
Saves the list with the name %parameter_list_name in the directory denoted by &parameter_list_location. Useful for packages, which should use their name as parameter.
/addh en syn /savenamedlist package_prefix
/addh en ex After@{N}\
@{}  /set weapons_list_name=weapons@{N}\
@{}  /set weapons_list_location=things@{N}\
the line@{N}\
@{}  /loadnamedlist weapons@{N}\
would save the list 'weapons' into the file 'things/weapons.list'.
/addh see /loadnamedlist, /savelist
/addh savenamedlist comm

/def savenamedlist = \
    /eval /savelist %-L \%%{L}_list_location \%%{L}_list_name


/addh info \
Laedt die Liste, die den Namen %parameter_list_name hat und in den Verzeichnis das durch die Optionen in %parameter_list_location vorgegeben ist. Dies ist vor allem fuer Pakete notwendig, fuer die parameter sinnvollerweise der Name des Pakets ist.
/addh syn /hloadnamedlist paket_prefix
/addh en info \
Same as ?/loadnamedlist, but for hash lists.
/addh en syn /hloadnamedlist package_prefix
/addh see /hsavenamedlist, /loadnamedlist
/addh hloadnamedlist mak

/def hloadnamedlist = \
    /eval /hloadlist %-L \%%{L}_list_location \%%{L}_list_name



/addh info \
Speichert die Liste, die den Namen %parameter_list_name hat in dem Verzeichnis das durch die Optionen in %parameter_list_location vorgegeben ist. Dies ist vor allem fuer Pakete notwendig, fuer die parameter sinnvollerweise der Name des Pakets ist.
/addh syn /hsavenamedlist paket_prefix
/addh en info \
Same as ?/savenamedlist, but for hash lists.
/addh en syn /hsavenamedlist package_prefix
/addh see /hloadnamedlist, /savenamedlist
/addh hsavenamedlist mak

/def hsavenamedlist = \
    /eval /hsavelist %-L \%%{L}_list_location \%%{L}_list_name%;


/addh info \
Laedt die angegebene Liste aus der Datei 'listenname.list'. Dabei wird ihre Laenge als Veraenderungserkennung gemerkt. Es koennen die von ?/custom verstandenen Optionen verwendet werden. Falls /loadlist das File nicht laden kann, werden schon existente Listen unberuehrt gelassen, ansonsten wird eine neue Liste intialisiert.@{N}\
Gibt %error bei Fehler zurueck.
/addh syn /loadlist [/custom-Optionen] listenname
/addh en info \
Loads a list from the file 'listname.list'. Options of ?/custom may be used. If the list cannot be loaded, an existing list with this name is not changed, otherwise it will be overwritten. The length of the list is saved as a changed-flag.@{N}\
Return %error if loading was unsuccessfull.
/addh en syn /loadlist [/custom-options] list_name
/addh mak /addlisttosave, /createlist, /custom, /ifecho
/addh see /savelist
/addh loadlist comm

/defh loadlist = \
    /let res=0%;\
    /let param=%*%;\
    /custom %*%;\
    /test %?%;\
    /let list_name=%load_file%;\
    /load -q %load_dir%{list_name}.list%;\
    /if (!{?}) \
	/load -q %load_dir%{list_name}.list.tf%;\
	/if (!{?}) \
	    /test value:=%list_name%;\
	    /if (substr(value,0,3)!~"<I>") \
		/createlist %list_name%;\
		/ifecho !load_quiet Datei fuer Liste %list_name nicht gefunden, Liste %list_name erzeugt!%;\
	        /return error%;\
	    /else \
	        /ifecho !load_quiet Datei fuer Liste %list_name nicht gefunden!%;\
		/let res=error%;\
	    /endif%;\
	/endif%;\
    /endif%;\
    /ifecho !load_quiet Liste %list_name geladen.%;\
    /addlisttosave %list_name %param%;\
    /return res


/addh info \
Speichert die Laenge der angegebenen Liste als Veraenderungsmerkmal.
/addh syn /addlisttosave listenname
/addh en info \
Saves the length of the list as a changed-flag.
/addh en syn /addlisttosave list_name
/addh mak /deletekeyandvalue, /addtolist
/addh see /savelist, /loadlist, /savealllists
/addh list lists
/addh addlisttosave comm

/def addlisttosave = \
    /deletekeyandvalue lists %1%;\
    /let tmp=%;\
    /test tmp:=%1%;\
    /addtolist lists %1 $[strlen(tmp)] %-1


/addh info \
Speichert die veraenderten Listen ab.
/addh syn /savealllists
/addh en info \
Saves all changed lists.
/addh mak /createlist, /foreach
/addh see /savelist, /loadlist, /addlisttosave
/addh list lists
/addh var %tlists, %hlists2
/addh savealllists comm

/defh savealllists = \
    /createlist tlists%;\
    /forEach lists kv /sal2%;\
    /set lists=%tlists%;\
    /unset tlists%;\
    /createlist hlists2%;\
    /forEach hlists kv /hsal2%;\
    /set hlists=%hlists2%;\
    /unset hlists2%;


/addh info \
Ist eine Liste, die die geladenen Listen und deren Laenge beim Laden enthaelt. Die Laenge wird dann mit der aktuellen Laenge verglichen, um etwaige Veraenderungen feststellen zu koennen.
/addh en info \
%lists is a list that contains pairs of list name - list length. /loadlist, /loadhrlist and /addlisttosave store the length of a list in this list. /savealllist checks if the length has changed and saves the list in this case.
/addh see /savealllists, /addlisttosave, /loadlist, /loadhrlist
/addh lists list

/def sal2 = \
    /let tmp=%;\
    /test tmp:=%1%;\
;/echo $[strlen(tmp)]  == %{2} ??%;\
    /if ((strlen(tmp)!~{2}))\
; | (strlen(tmp)==3)) \
	/echo Saving list %1%;\
	/savelist %-2%;\
    /endif%;\
    /addtolist tlists %1 $[strlen(tmp)] %-2%;

/def hsal2 = \
    /let hlen=$[strlen($(/listvar -g %{1}___*))]%;\
    /if (hlen!~{2})\
	/echo Saving hashlist %1%;\
	/hsavelist %-2%;\
    /endif%;\
    /addtolist hlists2 %1 %hlen %-2%;


/addh info \
Laedt die angegebene Liste aus der Datei 'listenname.hr.list'. Dabei wird ihre Laenge als Veraenderungserkennung gemerkt. Es koennen alle von ?/custom verstandenen Optionen verwendet werden.@{N}\
Falls beim Laden ein Fehler auftrat, wird %error zurueckgegeben.
/addh syn /loadhrlist [/custom-Optionen] listenname
/addh en info \
Loads a list from the file 'listname.hr.list'. Options of ?/custom may be used.@{N}\
Returns %error if an error occured while loading.
/addh en syn /loadhrlist [/custom-options] list_name
/addh mak /addlisttosave, /createlist, /custom, /ifecho
/addh see /savehrlist, /loadlist, /savelist
/addh loadhrlist comm

/defh loadhrlist = \
    /let res=0%;\
    /let param=%*%;\
    /custom %*%;\
    /test %?%;\
    /let list_name=%load_file%;\
    /createlist %list_name%;\
    /load -q %load_dir%{list_name}.hr.list%;\
    /if (!{?}) \
	/load -q %load_dir%{list_name}.hr.list.tf%;\
	/if (!{?}) \
	    /_echo Datei fuer Liste %list_name nicht gefunden!%;\
	    /test value:=%list_name%;\
	    /if (substr(value,0,3)!~"<I>") \
		/createlist %list_name%;\
		/_echo Liste %list_name erzeugt!%;\
		/return error%;\
	    /endif%;\
	    /let res=%error%;\
	/endif%;\
    /endif%;\
    /ifecho !load_quiet Liste %list_name geladen.%;\
    /addlisttosave %list_name %param%;\
    /return error


/def editlist = \
    /let el_list=%1%;\
    /if (isList({1})=~error) \
       /echo %1 ist keine Liste!%;\
       /if (ext_read("Liste erzeugen?","j")=/"j") \
          /createlist %1%;\
       /endif%;\
    /else \
      /simple_menu Neu_Erzeugen Editieren Anzeigen%;\
      /set value=%?%;\
      /if (value==1) /createlist %el_list%;\
      /elseif (value==2) /editlistvalues %el_list%;\
      /elseif (value==3) /showlist -p %el_list%;\
      /endif%;\
    /endif

/def editlistvalues = \
     /let el_delim=§%;\
     /let el_list=%1%;\
     /set el_keys=%;\
     /foreach %el_list k /el_keys%;\
     /let old_pedantic=%pedantic%;\
     /set pedantic=0%;\
     /qsort strcmp %el_keys%;\
     /set el_keys=%?%;\
     /set pedantic=%old_pedantic%;\
     /echo %;\
     /simple_menu -a"da" -d"%el_delim" -t"a...Wert hinzufuegen, d nr|key...Wert loeschen, D ohne Nachfrage, q|return..beenden" %el_keys%;\
     /let el_choice=%?%;\
     /if (el_choice=/"a") \
        /let el_key=$[ext_read("Schluessel: ")]%;\
        /let el_value=$[ext_read("Wert: ")]%;\
	/test uaddtolist(el_list,el_key,el_value)%;\
	/echo %el_key, Wert: %el_value zur Liste %el_list hinzugefuegt!%;\
     /else \
     /if (el_choice=/"d*") \
	 /let el_ask=$[substr(el_choice,0,1)=~"d"]%;\
	 /let el_choice=$[substr(el_choice,1)]%;\
	 /get_param # %el_choice%;\
	 /let el_idx_max=%?%;\
	 /let el_idx=0%;\
	 /while (++el_idx<=el_idx_max) \
	     /get_param %el_idx %el_choice%;\
	     /let el_param=%?%;\
	     /if (el_param=/"[0-9]*") \
		 /let el_key=$[el_get_param(el_param)]%;\
	    /else \
		 /let el_key=%el_param%;\
	    /endif%;\
	    /if (iskey(el_list,el_key)!~error) \
	    /getvalueof %el_list %el_choice%;\
		/if (!el_ask | ext_read(strcat(el_key," aus Liste löschen? "),"j")=/"j") \
		   /deletekeyandvalue %el_list %el_key%;\
		   /echo %el_key aus %el_list geloescht!%;\
		/else \
		   /echo %el_key nicht aus %el_list geloescht!%;\
		/endif%;\
	    /else \
	       /info error %el_key ist nicht in der Liste %el_list enthalten!%;\
	    /endif%;\
	 /done%;\
     /else \
     /if (el_choice>0) \
; todo Schluessel mit Leerzeichen
        /let el_key=%;\
        /test el_key:=el_get_param(el_choice)%;\
	/getvalueof %el_list %el_key%;\
	/let el_value=%?%;\
	/let el_input=$[ext_read(strcat("Wert von ",el_key,": "),el_value)]%;\
	/if (el_input!~el_value) \
	   /test uaddtolist({el_list},{el_key},{el_input})%;\
	/endif%;\
     /else \
        /return%;\
     /endif%;\
     /endif%;\
     /endif%;\
     /editlistvalues %*

/def el_get_param = \
     /get_param %1 %el_keys%;\
     /return replace(el_delim," ",{?})

/def el_keys = \
     /set el_keys=%el_keys $[replace(" ",el_delim,forEach_key)]


/addh info \
Funktion, die 1 zurueckgibt, falls die uebergenen Liste leer ist, sonst 0.@{N}\
Achtung: Falls der uebergebene Parameter keine Liste ist, wird ebenfalls 0 zurueckgegeben.
/addh syn /isEmptyList liste  oder  isEmptyList(liste)
/addh ex /if (isEmptyList(test_list)) /echo Liste leer%; /endif@{N}\
/test isempty:=isEmptyList(test_list)
/addh en info \
Returns 1 if the parameter is an empty list, 0 otherwise@{N}\
If the parameters is no list, 0 is returned also.
/addh en syn /isEmptyList list  or  isEmptyList(list)  (not list_name!)
/addh en ex /if (isEmptyList(test_list)) /echo list is empty%; /endif@{N}\
/addh see isList
/addh isEmptyList func

/defh isEmptyList = \
    /return ({1} =~"<I>")


/addh info \
Die Listenverwaltung bildet den Grundstock fuer alle anderen Makros.@{N}\
Die Listen bestehen jeweils aus Schluessel-Wert-Paaren, die durch Trennzeichen getrennt in einem grossen String stehen. Der Wert eines Schluessels kann auch wieder eine (Sub)Liste sein.@{N}\
Achtung: Die Liste 'list' wird fuer interne Zwecke benoetigt und sollte nicht verwendet werden.
/addh en info \
Lists are used by many packages. They consist of pairs of keys and their values. These pairs are stored in a big string, separated by markers. A value may be a (sub)list.@{N}\
Caution: The list 'list' is reserved for internal use only and must not be used for other purposes.
/addh see /createlist, /addtolist, /getvalueof etc.
/addh listen misc 

/addh info \
Enthaelt Makros zum Umgang mit (Hash-)Listen, die aus Schluessel-Wert-Paaren bestehen, und Feldern; dabei kann der Wert auch wieder eine Liste sein.
/addh var %value (ganz wichtig)
/addh see index, listen
/addh en info \
Many macros implementing the data types list, hash list and array.
/addh en var %value (very important)
/addh en see lists, hashlists, index, array
/addh req loading.tf, util.tf
/addh changes \
1.20 Viele Makros geben nun ihr Ergebnis nicht nur in %value, sondern auch als Rueckgabewert zurueck. Die Verwendung von %value sollte soweit wie moeglich vermieden werden, um Seiteneffekte zu vermeiden.
/addh_fileinfo
