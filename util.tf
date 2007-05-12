; $Log: util.tf,v $
; Revision 1.45  2003/07/25 14:59:22  olm
; Schoenheitskorrektur: ueberfluessiges /echo in /kill_process entfernt
; (/ifecho !opt_q /echo ...)
;
; Revision 1.44  2003/05/06 13:49:46  lje
;
; xtitle setzt jetzt Titel- und Iconnamen
;
; Revision 1.43  2002/09/25 23:21:36  mh14
; mkdir_all versucht jetzt nichtmehr leerstrings als verz. zu erzeugen
;
; Revision 1.42  2002/09/17 16:46:29  mh14
; grummel ~ mag die shell nich bei file_exists/dir_exists
;
; Revision 1.41  2002/09/16 18:20:48  nieten
; - /dir_exists und /file_exists arbeiten wieder wie vorher, d.h. der
;   Rueckgabewerte 1 (true) bedeutet, dass das Verzeichnis/File existiert
; - /edit_macros eingebaut
;
; Revision 1.40  2002/09/16 12:56:12  mh14
; negation bei file_exists is natuerlich quatsch
;
; Revision 1.39  2002/09/16 08:46:29  mh14
; dummes /c bei win_cmd entfernt war doppelt
;
; Revision 1.38  2002/09/15 13:42:24  mh14
; sys_mv fuer portabilitaet, negation der returnwerte bei sys-kommandos
;
; Revision 1.37  2002/08/14 11:40:25  mh14
; make_dos_path debuggt v2
;
; Revision 1.36  2002/08/14 11:36:29  mh14
; make_dos_path debuggt v2
;
; Revision 1.35  2002/08/14 11:31:42  mh14
; make_dos_path debuggt
;
; Revision 1.34  2002/05/04 15:42:18  mh14
; verbesserte windows erkennung (nt/9x) send_fast und send_fast_n zum schnellen schicken von kommandos ans mud
;
; Revision 1.33  2002/05/02 10:08:56  mh14
; OS Erkennung hoffentlich verallgemeinert
;
; Revision 1.32  2002/04/24 13:18:27  nieten
; Bei /deprecated kann ein ergaenzender Text angegeben werden.
;
; Revision 1.31  2002/04/23 09:11:45  mh14
; is_win fuer windowserkennung
;
; Revision 1.30  2002/04/22 23:48:34  mh14
; sh_sys als abbildung von /sys auf /sh /win_cmd und bedingtes umdefinieren von /sys auf /sh_sys unter windows
;
; Revision 1.28  2002/04/18 22:01:51  mh14
; doku von /pause debuggt
;
; Revision 1.27  2002/04/17 01:19:02  mh14
; find_in_tfpath sucht das uebergebene file im tfpath
;
; Revision 1.26  2002/04/16 13:01:22  mh14
; ret_vars ermoeglicht es mehrere lokale Variablen als Returnwert anzugeben
;
; Revision 1.25  2002/04/16 12:21:30  mh14
; /pause debuggt, /returns zur Rueckgabe von mehr als einem Wert /ifdo fuer bedingte Aktionen beim laden von files, wecho sinnvoller gestaltet
;
; Revision 1.24  2002/04/11 16:26:40  mh14
; mkdir kommt jetzt mit ~ zurecht
;
; Revision 1.23  2002/04/04 13:10:27  mh14
; /deprecated kann jetzt anzeigen was veraltet ist
;
; Revision 1.22  2002/04/03 12:14:37  mh14
; /pause zum automatischen Warten in Makros (intern aufsplitten per repeat) Parameter und lokale Variablen koennen weitergenutzt werden, /mkdir_all zum Rekursiven verzeichniserzeugen
;
; Revision 1.21  2002/03/29 22:30:05  mh14
; ifdef zum bedingten Definieren von Makros, /region um verschachtelte Makros ohne %% usw. zu definieren, mkdir kann nachfragen ob Verzeichnis erzeugt werden soll
;
; Revision 1.20  2001/12/03 12:57:52  mh14
; Defaultwerte bei shread
;
; Revision 1.19  2001/11/27 21:30:08  mh14
; * min,max debuggt
; * shread braucht jetzt weder shellscriptfile, noch batchfile, die kommandos
; dafuer werden /sh direkt uebergeben
; damit muss auch nich mehr auf OS Version getestet werden
; * file_exists, dir_exists testen es auf shellebene
; * rename_mac arbeitet jetzt verzoegert, dh. man kann auch makros umbenennen,
; die noch garnicht definiert sind :)
;
; Revision 1.18  2001/10/22 12:23:15  nieten
; /remove_packet loescht jetzt auch /remove_<Praefix>
;
; Revision 1.17  2001/10/10 22:10:21  mh14
; Default-Konfiguration in .tf Files verschoben
;
; Revision 1.16  2001/10/03 09:39:50  mh14
;  setos aus loading.tf in util.tf
;
; Revision 1.15  2001/10/01 22:16:52  mh14
; rename_mac, purge_renamed auf listen umgestellt
;
; Revision 1.14  2001/10/01 18:53:17  mh14
; shread angepasst, wie ext_read
;
; Revision 1.13  2001/10/01 01:45:36  mh14
; killall eingebaut, shread auf tfread.bat fuer windows angepasst, Prompttext bei shread
;
; Revision 1.12  2001/09/30 00:46:44  mh14
;  wecho benutzt jetzt eine callback funktion die in util.def definiert wird
;
; Revision 1.11  2001/09/27 21:03:47  nieten
; Bug in /rename_mac und /purge_renamed ausgebaut
;
; Revision 1.10  2001/09/27 14:47:52  nieten
; /rename_mac korrigiert und erweitert
; /purge_renamed und /remove_packet neu
;
; Revision 1.9  2001/09/25 21:26:52  mh14
;  rename_mac zum clonen/umbenennen von Makros eingebaut
;
; Revision 1.8  2001/09/11 23:51:01  mh14
; Funktion vlines sichtbare Zeilen
;
; Revision 1.7  2001/09/07 00:01:46  nieten
; wecho_hook sollte jetzt funktionieren
;
; Revision 1.6  2001/09/06 22:57:19  nieten
; wecho_attr statt wecho_color
;
; Revision 1.5  2001/09/06 22:44:07  mh14
;  wecho generalisiert
;
; Revision 1.4  2001/09/06 21:11:44  mh14
;  Log eingefuegt
;

/set util_tf_version $Id$
/set util_tf_author=Mesirii@mg.mud.de
/set util_tf_requires=lists.tf
/set util_tf_desc diverse Hilfsmakros

; ********************* BEGIN CONFIG ********************
; gepatchtes tf
; /set async_read=on
; defaultmaessig kein Echo der eingegebenen Befehle
/set wecho 0
; defaultmaessig keine Attribute beim Echo der eingegebenen Befehle
/set wecho_attr=

/def wecho_expr = /return !go & kampf<=0

/def wecho_output = /echo -a%{wecho_attr} [%*]

; ********************* END CONFIG **********************

/set ISMACRO_CACHE_TIME=60

/hcreatelist ismacro_cache

/def ismacro_cache=\
     /let tvalue=%;\
     /test tvalue:=value%;\
     /let tmp=$[hgetvalueof("ismacro_cache",{1})]%;\
     /test value:=tvalue%;\
     /if (tmp=~error | abs(tmp)<time()) /return -1%; /endif%;\
     /return tmp>0%;

/def cache_macro = \
     /let tmp=%;\
     /test tmp:=value%;\
     /hdeletekeyandvalue ismacro_cache %1%;\
     /haddtolist ismacro_cache %1 $[(time()+ISMACRO_CACHE_TIME)*(({2}) ? 1 : -1)]%;\
     /test value:=tmp%;\
     
/def _ismacro = \
     /let tmp=%;\
     /test tmp:=ismacro_cache({1})%;\
     /if (tmp!=-1) /return %tmp%; /endif%;\
     /eval -s0 /test tmp:=\${%1}%;\
     /test tmp:=strlen(tmp)%;\
     /cache_macro %1 $[tmp>0]%;\
     /return tmp>0

;/if (ver()=/"*5*") /eval /def ismacro = ${_ismacro}%; /endif

; Feststellen des OS
/addh info \
Setzt die Variable OS auf das verwendete Betriebssystem (bisher 'win' und 'linux').
/addh var OS
/addh setos mak

/def setos = \
  /set win_sh=$(/listvar -v comspec)%;\
  /if (win_sh!~"") \
     /let off=$[strrchr(win_sh,"\\")]%;\
     /if (off>-1) \
        /set win_sh=$[substr(win_sh,off+1)]%;\
     /else \
        /info error Konnte COMSPEC @{B}%win_sh@{n} nicht parsen!%;\
     /endif%;\
     /set OS=win%;\
  /else \
     /let ver=$(/version)%;\
     /if (strstr(ver,"Darwin")>-1) /set OS=macos%;\
     /else \
       /set OS=linux%;\
     /endif%;\
  /endif%;

/addh info Schnelles Senden von Kommandos ans Mud, direkt als String mit char(13) (Return) getrennt
/addh ex /send_fast n%;o%;s
/addh syn /send_fast comm%;comm2%;comm3
/addh send_fast comm
/def send_fast = \
     /let param=%*%;\
     /test param:=replace("%;",strcat(char(13),SEND_PREFIX),param)%;\
     /send %param

/def send_fast_n = \
     /let count=%1%; /shift%;\
     /let param=%;\
     /test param:=strcat(SEND_PREFIX, {*},char(13))%;\
     /send $[strrep(param,count)]

;   /let verstring=$(/version)%;\
;    /if (regmatch("[Bb]uilt for ([^ ]+)",verstring)) \
; 	/set OS=$[tolower({P1})]%;\
;    /endif%;


/addh info Liefert True wenn OS irgendwie 'win' enthaelt
/addh is_win mak

/def is_win = \
     /return OS=/"*win*" | OS=/"*NT*"

/setos

/def hex = \
	/let hex=$[ascii({*})]%;\
	/let res=%;\
;/let hex%;\
	/let nibble=$[mod(hex,16)]%;\
;/let nibble%;\
	/test res:=(nibble<10)?nibble:char(ascii("A")+nibble-10)%;\
	/let hex=$[hex/16]%;\
	/let nibble=$[mod(hex,16)]%;\
	/test res:=strcat((nibble<10)?nibble:char(ascii("A")+nibble-10),res)%;\
	/result res%;

/addh info \
Zeigt die Dezimal, Hexcodes und die Character der Zeichen von 20 bis 127 an.
/addh showchars mak

/def showchars = \
	/let count=19%;\
	/while (++count<128) \
	   /echo $[count] $[char(count)] $[hex(char(count))] #%;\
	/done%;

/def showcolors = \
	/let res=%;\
	/let y=15%;\
/aput colors 0 black%;\
/aput colors 1 red%;\
/aput colors 2 green%;\
/aput colors 3 yellow%;\
/aput colors 4 blue%;\
/aput colors 5 magenta%;\
/aput colors 6 cyan%;\
/aput colors 7 white%;\
	/while (++y<24) \
	   /test res:=strcat(res,pad(y,-6))%;\
	/done%;\
	/test echo(strcat(pad(" ",10)," n    ",res))%;\
	/test echo(strcat(pad(" ",10,"normal",-6,"black",-6,"red",-6,"green",-6,"yellow",-6,"blue",-6,"magenta",-6,"cyan",-5,"white",-6)))%;\
	/let x=-1%;\
	/while (++x<8) \
	/test res:=strcat(pad(x,-2,aget("colors",x),-8))%;\
	/let y=15%;\
	 /test res:=strcat(res,"@{xnC",x,"}X ","@{xBC",x,"}X@{n}   ")%;\
	/while (++y<24) \
	   /test res:=strcat(res,"@{xnC",x,",C",y,"}X ","@{xBC",x,",C",y,"}X@{n}   ")%;\
	/done%;\
	/echo -p %res%;\
	/done%;

/addh info \
Entfernt einen bestimmten bzw. unbestimmten Artikel vom Parameter, unter Nutzung von regmatch.
/addh ex /artikel_entfernen Ein NPC - return NPC
/addh artikel_entfernen mak

/def artikel_entfernen = \
	/if (regmatch("(^| )([Dd](er|ie|as|en)|([Ee]in(|e|er|es|em|en))) ",{*})) \
	  /return strcat({PL},{P1},{PR})%;\
	/else /return {*}%; \
	/endif%;

/addh info \
Schaltet ein Echo der zum Mud gesendten Kommandos ein und aus. Falls kein Parameter uebergeben wurde, wird die jeweils andere Einstellung verwendet. Wird '0' bzw. '1' als Parameter uebergeben, wird das Echo unabhaengig von der alten Einstellung. aus- bzw. eingeschaltet. Das Echo wird mit dem in 'wecho_attr' angegebenen Attributen ausgegeben.
/addh var wecho
/addh see wecho_attr
/addh syn /wecho [0|1]
/addh wecho comm
/defh wecho = \
    /if ({#} == 0) \
	/toggle wecho%;\
    /else \
	/set wecho=%1%;\
    /endif%;\
    /if (wecho) \
       /def -E(wecho_expr()) -q -F -hSEND wecho_hook = /wecho_output \%*%;\
    /else \
       /undef wecho_hook%;\
    /endif%;

/def wecho_expr = /return 1

/addh info \
Mit der Variablen 'wecho_attr' koennen Attribute und Farbe des von /wecho ausgegeben Echos festgelegt werden. Die Aenderung wird erst nach '/wecho 1' bzw. zweimaligem '/wecho' wirksam.
/addh see /wecho
/addh var wecho_attr
/set wecho_attr=


/addh info \
Fuehrt den uebergebenen String per /test aus, speichert ggf. vorhandene Ausgaben in der Variablen 'output' und gibt per /return das Ergebnis des ausgefuehrten Strings zurueck.
/addh ex /test_quiet /list -s makroname@{N}\
	 In 'output' stehen alle gefundenen Makros oder nichts.@{N}\
	 Der Rueckgabewert ist der vom /list.
/addh var output
/addh test_quiet mak

/def test_quiet = /set output=$(/test %{*}%;/let test_quiet_res=%{?}%;)%;/return test_quiet_res%;

/addh info \
Kommando, das nichts tut. Es ist notwendig, weil '%;' als Body eines Makros ein Newline ans Mud sendet.
/addh nop mak
/def nop =/test 0%;

/addh info \
Liefert das Minimum von zwei Zahlenwerten ueber /echo zurueck. \
Also Ergebnis mit $() holen.
/addh return ueber /echo das Minimum der Zahlen
/addh see substitutions
/addh min mak
/defh min = /result {1}>{2} ?{2} :{1}

/addh info \
Liefert das Maximum von zwei Zahlenwerten ueber /echo zurueck. \
Also Ergebnis mit $() holen.
/addh return ueber /echo das Maximum der Zahlen
/addh see substitutions
/addh max mak

/defh max = /result {1}<{2} ?{2} :{1}

/addh info \
Lazy Call im Makrokontext. Es wird erst gecheckt, ob das Makro existiert, bevor es mit seinen Parametern ausgefuehrt wird. Falls es nicht existiert, wird mit /debug eine Fehlermeldung erzeugt.
/addh ex /lazym foo bar -> /foo bar oder Not Found foo 
/addh syn /lazym makroname parameters
/addh lazym mak
/def lazym=\
    /if (ismacro({1})) \
       /eval -s0 /%*%;\
    /else \
       /debug Not Found %1%;\
    /endif%;

/addh info \
Lazy Call im Funktionskontext. Es wird erst gecheckt ob die Funktion existiert, bevor sie mit ihren Parametern ausgefuehrt wird. Falls sie nicht existiert, wird mit /debug eine Fehlermeldung erzeugt.
/addh ex /test lazyf("foo",bar) -> /test foo(bar) oder Not Found foo 
/addh syn /test lazyf("makroname",parameter..)
/addh lazyf mak

/def lazyf=\
    /if (ismacro({1})) \
       /test %{1}({2},{3},{4},{5},{6},{7},{8},{9})%;\
    /else \
       /debug Not Found %1%;\
    /endif%;

/addh info \
Ersatz fuer read(), das durch 'tfread' ersetzt wurde. Noetig, wenn die Eingabe direkt weiterverwendet werden soll, z.B. in einer regexp.
/addh ex /echo /_read @{N} /if (_read() =~ "test") ...
/addh return die Eingabe
/addh see tfread, read
/addh _read mak
/def _read = /let tfread_tmp=%; /test tfread(tfread_tmp) %; /return tfread_tmp%;

/addh info konvertiert einen CygWin Path in einen Dos Pfad
/addh make_dos_path info
/def make_dos_path = \
        /let param=$[replace("$HOME","%HOME%",{*})]%;\
	/let param=$[replace("/","\\",param)]%;\
	/if (regmatch("^([\\]cygdrive|[\\])[\\]([A-Za-z])",param)) \
	   /let param=%P2:%PR%;\
	/endif%;\
	/result param%;

/addh info \
Ersetzt read, tfread, _read in asynchronen Makros. Es ist ein boeser Workaround, der mit dem Shellscript 'tfread' arbeitet, das in dem Verzeichnis %makdir liegen muss. Ansonsten funktioniert es wie das normale /read. Der gelesene Wert steht ausserdem in 'read_value'.
/addh return der eingelesene Wert.
/addh syn /shread Prompttext
/addh hook hresume_shread
/addh var read_value, makdir
/addh mak sh, load
/addh shread mak
/def shread = \
	/if (async_read==1) /return ext_read({1},{2})%;\
	/else \
        /def -hRESUME -1 -ag hresume_shread= /test 0%; \
	  /let shread_input=Eingabe%;\
	  /if ({#}>1) /let shread_input=%shread_input %1 [%2]%;\
	  /elseif ({#}>0) /let shread_input=%shread_input %1%;\
	  /endif%;\
	  /sh -q echo -n "%{shread_input}: ";read read_value;echo "/set read_value=\$read_value" >%{makdir}/read_val.tf%;\
	  /load -q %{makdir}/read_val.tf%;\
	  /return (read_value=~"" & {#}>1) ? {2} : read_value%;\
        /endif%;

/addh info Killt alle Prozesse, die den uebergebenen Parameter enthalten
/addh opt q keine Ausgabe beim Kill
/addh syn /killall [-q] matchtext
/addh ex /repeat -10 10 /echo foo%;/killall foo
/addh killall mak

/def killall = \
	/test getopts("q","0")%;\
	/quote -S /kill_process %1 `/ps

/addh info wird von killall genutzt um den Prozess zu matchen und zu toeten
/addh syn kill_process matchtext single line from ps
/addh kill_process mak

/def kill_process = \
	/if (strstr({-5},{1})>-1) \
	  /ifecho !opt_q Killing: %-1%;\
	  /kill %2%;\
	/endif%;

/addh info \
Setzt den Titel des xterms.
/addh xtitle comm
/defh xtitle = /echo -r \033]0;%*\007

/def recall_file = \
   /def recall_write = /test tfwrite(recall_handle,{*})%; \
   /test recall_handle:=tfopen(strcat("recall_",{1},".log"),"w")%; \
   /quote -S /recall_write `/recall %{-1}


/addh info Anzahl der sichtbaren Ausgabezeilen
/addh vlines func

/def vlines = /return (lines() - (visual ? isize+1 : 0))

/def make_home = /return (({*}=/"~*") ? replace("~",HOME,{*}) : {*})%;

/def file_exists = \
        /make_home %*%;\
	/sys [ -f "%?" ]%;\
	/return !{?}

/def dir_exists = \
        /make_home %*%;\
	/sys [ -d "%?" ]%;\
	/return !{?}

/def sh_quiet = \
	/sys "%*"%;\
	/return !{?}


/def mkdir = \
     /test getopts("a",0)%;\
     /if (!dir_exists({*})) \
     /if (!opt_a | ext_read(strcat("Verzeichnis '",{*},"' exisitiert nicht, erzeugen? (j/n)"),"j")=/"j") \
        /mkdir_all %*%;\
     /endif%;\
     /endif%;\
     /return !{?}

/def win_cmd = \
     /sh_sys %win_sh /c %*

/def sh_sys = \
     /def -ag -1 -hRESUME h_sh_sys_resume = /test 0%;\
     /sh -q %*

/if (is_win()) \
    /eval /def -i sys = ${sh_sys}%; \
/endif

/def sys_mv = \
     /let oldfile=$[make_home({1})]%;\
     /let newfile=$[make_home({2})]%;\
	 /if (is_win()) \
	   /win_cmd move "$[make_dos_path(oldfile)]" "$[make_dos_path(newfile)]"%;\
	 /else /sys mv "%oldfile" "%newfile"%;\
	 /endif%;\
	 /return !{?}
     
/def mkdir_all = \
     /let param=%*%;\
     /let dir=%;\
     /let param=$[make_home(param)]%;\
     /while (param!~"") \
       /let off=$[strchr(param,"/")]%;\
       /let off=$[off>-1 ? off : strlen(param)]%;\
       /let dir=$[strcat(dir,substr(param,0,off))]%;\
       /let param=$[substr(param,off)]%;\
       /if (dir!~"" & !dir_exists(dir)) \
	 /if (is_win()) \
	   /win_cmd md "$[make_dos_path({*})]"%;\
	 /else /sys mkdir "%dir"%;\
	 /endif%;\
       /endif%;\
       /let dir=$[strcat(dir,substr(param,0,1))]%;\
       /let param=$[substr(param,1)]%;\
     /done%;


/addh info Makro das aequivalent zu cat <<EOF ... EOF inner Shell einen Bereich bis zum naechsten Marker (Parameter 2), literal evaluiert und dahinter die Bearbeitung des Makros fortsetzt.@{N}\
Besonders gut dazu zu gebrauchen, Trigger und Makros in anderen zu definieren, ohne Massen von % und $ zu verschwenden und nen Knoten im Hirn zu bekommen.@{N}\
Ausserdem wenn im Text dieses Bereichs diese TF Sonderzeichen (%,$) z.B. als Textformatierung genutzt werden.@{N}\
Die ganze Sache kann auch verschachtelt eingesetzt werden um beliebig tiefe Makrodefinitionshierarchien aufzubaun.@{N}\
Leider muss das aktuelle Makro als Parameter uebergeben werden, da keine Moeglichkeit besteht dieses innerhalb von /region zu ermitteln.

/addh syn /return region('%0','MARKER')%;....Makrotext....MARKER

/addh ex /def x = /return region('%0',EOF')%;/def y=/echo in y 1%;/echo in y 2%;EOF/echo in x

; Beispiel fuer /region
; /def x = \
;      /purge y%;\
;      /purge z%;\
;      /return region('%0','EOF')%;\
;      /def -msimple -t"Das ist ein Test" y = \
;      /echo def%;\
;      /return region('%0','YYY')%;\
;      /def z = /echo zzz%;/echo zzz2%;YYY\
;      /echo def2%;\
;      EOF\
;      /echo abc2%;\
;      /trigger Das ist ein Test

/addh region mak

/def region = \
     /let region_off=%;\
     /eval /let region_mak=\${%1}\%;/return region_mak%;\
     /let region_mak=%?%;\
     /let region_str=/return region('\%0','%2')\%;%;\
     /test region_off:=strstr(region_mak,region_str)+strlen(region_str)%;\
     /test region_mak:=substr(region_mak,region_off)%;\
     /test region_off:=strstr(region_mak,{2})%;\
     /eval -s0 $[substr(region_mak,0,region_off)]%;\
     /eval $[substr(region_mak,region_off+strlen({2}))]%;\

/addh info \
Hilfsmakro das das laestige Aufsplitten eines Makros in Teilstuecke die mit Pausen voneinander getrennt werden sollen (wait) erledigt@{N}\
Dabei muss der Makroname (%0), die Pausenzeit und die Parameter des Makros angegeben werden (damit diese von dem aufgeteilten Teilen weiter genutzt werden koennen, ggf. koennen noch Namen von lokalen Variablen angegeben werden, die ebenfalls weitergereicht werden sollen
/addh syn /return pause('%0',time,'%*'[,'localvarname1',...,'localvarnameN']) (time: Sekunden oder hh:mm:ss, ohne ')
/addh ex @{N}\
/def test_pause = \@{N}\
     /let a=teststring%;\@{N}\
     /echo Start Test%;\@{N}\
     /return pause('%0',3,'\%*')
/addh pause mak

/def pause = \
     /let pause_off=%;\
     /let makname=%1%;\
     /let time=%2%;\
     /eval /let pause_mak=\${%makname}\%;/return pause_mak%;\
     /let pause_mak=%?%;\
     /shift 2%;\
     /let params=%;\
     /let param_str=%;\
     /if ({#}) \
        /let params=%1%;\
	/let param_str=,'\%*'%;\
        /shift%;\
     /endif%;\
     /let locvar_str=%;\
     /let locvar_let=%;\
     /while ({#}) \
        /let locvar_str=%locvar_str,'%1'%;\
        /test locvar_let:=strcat(locvar_let,' /let %1=',%1,'\%;')%;\
	/shift%;\
     /done%;\
     /let pause_str=/return pause('\%0',%time%{param_str}%{locvar_str})\%;%;\
     /test pause_off:=strstr(pause_mak,pause_str)+strlen(pause_str)%;\
     /test pause_mak:=substr(pause_mak,pause_off)%;\
     /if (pause_mak!/"*%;") /let pause_mak=%pause_mak\%;%;/endif%;\
     /let pause_name=pause_%makname_$[time()]%;\
     /def %pause_name=%{locvar_let}%{pause_mak}/purge %pause_name%;\
     /repeat -%time 1 /%pause_name %params%;\
  
/addh info \
Conditional def, nur wenn der Ausdruck, der als 1. Parameter uebergeben wird 1 ist wird das /def gemacht
/addh syn /ifdef expr normal def parameters
/addh ex /ifdef is_file_loaded("status.tf") sl_lp = /initvar p_lp%; .... @{N}\
      /ifdef p_guild=~"zauberer" -t"bla Hand Eis" zaubi_hand_eis = ....
/addh ifdef mak

/def ifdef = \
     /if /test %{1}%; /then /def %-1%; /endif

/addh info \
Conditional def, nur wenn der Ausdruck, der als 1. Parameter uebergeben wird 1 ist, wird der rest ausgefuehrt
/addh syn /ifdo expr tf-code
/addh ex /ifdo !islist(comm_ebenen_list)\@{N}\
 /createlist comm_ebenen_list@{N}\
 /addtolist comm_ebenen_list team Cblue Cyellow
/addh ifdo mak

/def ifdo = \
     /if /test %{1}%; /then /eval %-1%; /endif

/addh info \
Benennt ein Makro um bzw. erstellt eine Kopie davon. Damit wird sichergestellt, dass die Probleme mit Parametern nicht auftreten (Leerzeichenverlust bei Makros, auf neun begrenzte Parameteranzahl fuer Funktionen).@{N}\
Das soll genutzt werden, um Kommandos aus den Namespaces der Files in benutzerfreundliche Namen umzuwandeln.@{N}\
Wird ein dritter Parameter uebergeben, so wird die Umbennung in der Variablen %renamed_list_<Paramter 3> gespeichert. Will man nun die Makros eines Pakets vollstaendig entfernen, so lassen sich mit ?/purge_renamed auch die Kopien der Makros loeschen.
/addh syn /rename_mac neuer_name alter_name [paketname]
/addh ex /rename_mac wo ways_where ways
/addh see /purge_renamed
/addh mak /createnewlist, /uaddtolist
/addh rename_mac comm

/defh rename_mac = \
    /if ({#} == 3) \
	/createnewlist renamed_list_%3%;\
	/uaddtolist renamed_list_%3 %1%;\
	/uaddtolist renamed_list_%3 %2%;\
;	/let list_name=renamed_list_%3%;\
;	/eval /set %list_name=\%%list_name %1%;\
; warum keine liste? multiples vorkommen?
    /endif%;\
    /purge -msimple %1%;\
    /def %1 = /eval $${%2}%%;/def %1=$${%2}



/addh info \
Dem Makro wird ein Paketname uebergeben, woraufhin alle Makros, die in der Variablen %renamed_list_<Paketname> stehen, mittels /purge geloescht werden. Diese Funktion ist in Verbindung mit ?/rename_mac dazu gedacht, das vollstaendige Entfernen von Paketen zu erleichtern und trotzdem die Moeglichkeit zu erhalten, Makros z. B. laenderspezifische Namen zu geben. Ein Makro zum Entfernen des Paktes comm.tf koennte dann so aussehen:@{N}\
/def comm_remove = \@{N}\
@{n}    /purge -mglob comm_*%;\@{N}\
@{n}    /purge_renamed comm%;\@{N}\
@{n}    ...@{N}\
(Einfacher geht's natürlich mit "/remove_packet comm".)
/addh syn /purge_renamed ways
/addh see /rename_mac, /remove_packet
/addh ex Nach@{N}\
/rename_mac wo ways_where ways@{N}\
/rename_mac gehe go ways@{N}\
/rename_mac keine_portale noport ways@{N}\
wuerde@{N}\
/purge_renamed ways@{N}\
die Makros /wo, /gehe und /keine_portale loeschen.
/addh mak /forEach
/addh purge_renamed comm

/defh purge_renamed = \
	/forEach renamed_list_%1 k /purge -msimple%;\
	/unset renamed_list_%1

/defh rem_purge_renamed = \
    /let list_name=renamed_list_%1%;\
    /eval /purge_renamed2 \%%list_name%;\
    /unset %list_name

/def rem_purge_renamed2 = \
    /while ({#}) \
	/echo checking %1%;\
	/purge -msimple %1%;\
	/shift%;\
    /done%;

/addh info \
Dieses Makro hilft beim vollstaendigen Entfernen aller Makros, Trigger, Hooks, Variablen eines Pakets. Es werden mittels /purge alle Makros, Trigger und Hooks geloescht, die mit dem angegeben Praefix (ein '_' wird dahinter ergaenzt) beginnen. Ausserdem wird das Makro /remove_<Praefix> geloescht. Desweiteren werden alle mit ?/rename_mac erstellten Kopien dieser Makros geloescht, sofern beim Aufruf von /rename_mac das entsprechende Praefix mit uebergeben wurde. Schliesslich werden noch alle mit dem Praefix beginnende Variablen geloescht. Ausser dem Praefix koennen noch Makro- und/oder Variablennamen uebergeben werden, die dann ebenfalls mit /purge bzw. /unset geloescht werden.
/addh syn /remove_packet praefix [weitere Makro-/Variablennamen]
/addh ex Der Aufruf von@{N}\
/remove_packet comm rufe last_partner@{N}\
loescht alle Makros, Trigger, Hooks und Variablen, die mit "comm_" beginnen, sowie das Makro /rufe, die Variable %last_partner und /remove_comm.@{N}\
Wurde vorher mit@{N}\
/rename_mac tmh comm_tm_hist comm@{N}\
das Makro /comm_tm_hist kopiert, so loescht das obige /remove_packet auch /tmh.
/addh see /purge_renamed, /rename_mac
/addh mak /purge_renamed
/addh remove_packet comm

/defh remove_packet = \
    /purge -mglob %1_*%;\
    /purge_renamed %1%;\
    /quote -S /unset `"/listvar -mglob -s %1_*%;\
    /purge -msimple remove_%1%;\
    /shift%;\
    /while ({#}) \
	/if (ismacro({1})) \
	    /purge -msimple %1%;\
	/else \
	    /unset %1%;\
	/endif%;\
	/shift%;\
    /done%;

/addh info \
Fuegt den Parameter zu einer Liste hinzu, die veraltete Makros/Variablen enthaelt. Es kann optional ein ergaenzender Text angegeben werden, der ggf. bei ?/check_deprecated mit ausgegeben wird.
/addh syn /deprecated name (var|mak) [ergaenzender Text]
/addh ex /deprecated mud_shortest_output var@{N}\
/addh /deprecated /seher m Heisst jetzt /become_seer.
/addh deprecated mak

/def deprecated = \
    /createnewlist deprecated%;\
    /addtolist deprecated %*

/addh info \
Ueberprueft die Liste der veralteten Variablen/Makros und gibt die entsprechenden Fehlermeldungen aus.
/addh check_deprecated mak

/def check_deprecated = \
    /foreach deprecated kv /check_deprecated2

/def check_deprecated2 = \
    /if (strlen(forEach_value) > 2) \
        /let msg=$[strcat("(", substr(forEach_value,2), ")")]%;\
    /else \
	/let msg=%;\
    /endif%;\
    /if (forEach_value=/"m*" & isMacro(forEach_key)) \
        /info error Makro: @{B}%forEach_key@{n} is deprecated, \
	    please remove %msg%;\
    /elseif (forEach_value=/"v*" & isVar(forEach_key)) \
        /info error Variable: @{B}%forEach_key@{n} is deprecated, \
	    please unset %msg%;\
    /else \
        /info warning Something named: @{B}%forEach_key@{n} is \
	    deprecated! %msg%;\
    /endif

/addh info \
Gibt alle uebergebenen Parameter als String zurueck der diese ueber ein /test %? als lokale Variablen R1 .. Rn setzt
/addh syn /return returns(expr1,...,exprN)
/addh ex /let a=5%;/let c=3%;/return returns(a,10,c*30)@{N}\
 dann /test %?%;/echo %R1 %R2 %R3 -> 5 10 90
/addh returns mak

/def returns = \
     /let result=%;\
     /let count=0%;\
     /while ({#}) \
        /test ++count%;\
        /test result:=strcat(result,'let("R',{count},'=',{1},'"),')%;\
        /shift%;\
     /done%;\
     /return substr(result,0,-1)

/addh info \
Gibt alle uebergebenen Variablen als String zurueck der diese ueber ein /test %? wieder als lokale Variablen setzt
/addh syn /return ret_vars('var1',...,'varN')
/addh ex /let a=5%;/let c=3%;/return ret_vars('a','c')@{N}\
 dann /test %?%;/echo %a %c -> 5 3
/addh ret_vars mak

/def ret_vars = \
     /let result=%;\
     /while ({#}) \
        /test result:=strcat(result,'let("',{1},'=',escape('"',{%1}),'"),')%;\
        /shift%;\
     /done%;\
     /return substr(result,0,-1)

/addh info Sucht das uebergebene File im TFPATH
/addh syn find_in_tfpath [verz/]filename
/addh ex find_in_tfpath way.tf
/addh find_in_tfpath mak

/def find_in_tfpath = \
     /if ({#}==1) \
        /if (TFPATH!~"") \
	  /find_in_tfpath %TFPATH %1%;\
	  /return {?}%;\
        /elseif (file_exists({1})) \
	  /return {1}%;\
	/else /return%;\
	/endif%;\
     /else \
        /let find_in_tfpath_file=%L%;\
        /while ({#}>1) \
	   /let tmp=$[strcat({1},({1}!/"*/"? "/" : ""),find_in_tfpath_file)]%;\
	   /if (file_exists(tmp)) \
	      /return tmp%; \
	   /endif%;\
	   /shift%;\
	/done%;\
     /endif%;\
     /return


/addh info \
Ein /edit fuer mehrere Makros auf einmal. Der erste Parameter gibt die neue Option (siehe /def) an, der Rest wird als Makroliste bzw. Patternliste aufgefasst. Jedes Makro dieser Liste erhaelt dann die neue Option.@{N}\
/edit_macros ist vor allem dazu gedacht, einfach konfigurierbare Faerbetrigger zu ermoeglichen, ohne jedesmal auf "/eval /def -a%color ..." zurueckgreifen zu muessen (siehe Beispiel).
/addh syn /edit_macros <Attribut> Pattern1 [Pattern2 ...]
/addh ex \
Nach@{N}\
/edit_macros -aCcyan t_team_info_* t_team_af*@{N}\
wuerden die Texte aller Trigger, auf die das (glob-)Muster t_team_info_* bzw. t_team_af* passt, in cyan ausgegeben.@{N}\
/eval /edit_macros -a%team_color t_team_info_* t_team_af*@{N}\
wuerde dazu die Farbe aus der Variablen %team_color nehmen.@{N}\
/test edit_macros("-p30 -E(flag)", "t_team_af*", "t_team_weg")@{N}\
ist ein Beispiel fuer eine Option mit Leerzeichen.
/addh edit_macros comm

/def edit_macros = \
    /let new_opt=%1%;\
    /shift%;\
    /while ({#}) \
	/quote -S /edit_macros2 %new_opt `/list -s %1%;\
	/shift%;\
    /done

/def edit_macros2 = \
    /edit %1 #$[substr({3},0,-1)]



/addh info \
Enthaelt Makros und Kommandos, die immer wieder gebraucht werden, die aber unabhaengig vom Mud sind. Alle Makros sind sehr nuetzlich auch fuer den gelegentliche Nutzer.
/addh over dc, quit
/addh list ${world_character}tosave, ${world_character}saved, tosave
/addh var echolist, loadall, wecho
/addh changes 0.00 /echo2 zur Ausgabe von Newlines mit einem /echo.@{N}\
	1.00 /completion und Stack (/push, /pop).@{N}\
	/timer zum Zeitmessen im Sekundenbereich.@{N}\
	1.01 /myread fuer Keyboardeingaben von asynchronen Makros.@{N}\
	     /tokenize fuer das Aufspalten von Strings.@{N}\
	1.02 /shread als funktionierenden Workaround fuer das Read in asynchronen Makros.@{N}\
	1.04 Fuer /shread ist jetzt auch ein Binary fuer Windows vorhanden, deshalb musste auch der Dateiname der Ergebnisdatei auf 8+3 angepasst werten.@{N}\
	Hilfsfunktionen fuer die Nutzung world-lokaler Variablen hinzugefuegt (siehe ?world_local).@{N}\
	Die Trigger zum Auslesen der Mudausgabe eines oder mehrerer Kommandos wurden in 'util.tf' verschoben (siehe /catch_output).@{N}\
	1.05 Die Funktionen zum Umleiten von Mudausgaben in andere Fenster sowie die Ersetzung von Abkuerzungen in gesendetem Text wurden von der ${world_host}/comm.tf in die util.tf verschoben, da sie nicht mudspezifisch sind.@{N}\
             /wecho etwas erweitert.
/addh hook CONNECT, DISCONNECT, SIGHUP
/addh_fileinfo

