; $Log: util.debug.tf,v $
; Revision 1.8  2002/03/27 01:33:19  mh14
; run_tests, do_test verschoben aus lists.test err_code
;
; Revision 1.7  2001/11/02 20:01:09  nieten
; /watch_var & co hinzugefuegt
;
; Revision 1.6  2001/09/09 19:09:42  mh14
; help_de.list
;
; Revision 1.5  2001/09/07 00:04:20  mh14
;  test_result fuer Unit Testing
;
; Revision 1.4  2001/09/06 21:11:44  mh14
;  Log eingefuegt
;

/set util_debug_tf_version $Id: util.debug.tf,v 1.8 2002/03/27 01:33:19 mh14 Exp $
/set util_debug_tf_author=Mesirii@mg.mud.de
/set util_debug_tf_requires=lists.tf
/set util_debug_tf_desc=Debug-Funktionen, Variablenueberwachung

/addh info \
Macht nur ein /echo der Parameter, wenn die Variable 'debug' auf 1 gesetzt ist.
/addh var debug
/addh debug mak
/def debug = /if (debug==1) /echo -e %*%; /endif%;

/addh info \
Gibt alle Variablen, die /vdebug als Parameter uebergeben werden, mit Name und Wert auf stderr aus, wenn 'debug' auf 1 gesetzt ist.
/addh vdebug mak
/def vdebug = \
     /if (debug) \
	 /while ({#}) \
	     /eval /echo -e %1 (\%%1) %; \
	     /shift%; \
	 /done%; \
     /endif%;

/addh info \
Wertet das Ergebnis eines Unit Test Bestandteils aus. Dazu wird als Parameter die Testbedingung uebergeben. Die Variablen param und res muessen im Test benutzt werden, und sind hier als lokale Variablen verfuegbar
/addh ex /test_result 
/addh syn /test_result Bedingung
/addh var res, param
/addh test_result mak

/def test_result = \
	/if /test (%*)%; /then \
	   /echo Ok: param (%param) result (%res) Test: (%*)%;\
	/else \
	   /echo Fehler: param (%param) result (%res) Test: (%*)%;\
	/endif 



/addh info \
Diese Liste enthaelt die Namen der zu ueberwachenden Variablen als Key und ihre Inhalte als Value. Sie wird mittels /watch_loop und /watch_check_var aktualisiert.
/addh see /watch_var, /watch_loop, /watch_check_var, watch_action_list
/addh watch_list list


/addh info \
Falls bei Aenderung einer Variablen ein Makro aufgerufen werden soll, steht das Paar Variablenname/Makro in dieser Liste.
/addh see /watch_var, /watch_loop, /watch_check_var, watch_list
/addh watch_action_list list


/addh info \
Legt das Zeitintervall (in Sekunden) fest, in dem die zu ueberwachenden Variablen auf etwaige Veraenderungen geprueft werden.@{N}\
Sollte insbesondere auf langsamen Rechnern nicht zu klein gewaehlt werden. Der Wert 0 beendet die Ueberwachung.
/addh see /watch_loop
/addh watch_time var

/set watch_time=2


/addh info \
Dieses Flag regelt, ob eine Variablenueberwachung stattfindet.
/addh see /watch_loop, /watch_var
/addh watch_active var

/set watch_active=0


/addh info \
Mit diesem Makro lassen sich Aenderungen von Variableninhalten ueberwachen. Dazu wird in der Liste ?watch_list fuer jede zu ueberwachende Variable ihr Name und aktueller Inhalt gespeichert. Diese Liste wird dann mittels ?/watch_loop bzw. ?/watch_check_var alle ?%watch_time Sekunden mit den aktuellen Werten verglichen. Wurde eine Veraenderung festgestellt, wird diese ausgegeben und die Liste aktualiesert.@{N}\
Aufrufmoeglichkeiten:@{N}\
1. ohne Parameter: Startet bzw. stoppt die Variablenueberwachung.@{N}\
2. ein Parameter: Falls der Parameter der Name einer globalen Variable ist, wird sie mit ihrem aktuellen Inhalt an die Liste watch_list angehaengt bzw. aus ihr geloescht, falls sie dort schon vorhanden war. Außerdem wird die Variablenueberwachung gestartet, falls dies noch nicht der Fall war.@{N}\
3. mehr als ein Parameter: Wie bei 2., jedoch wird der restliche Teil der Parameter in der Liste ?watch_action_list eingetragen und ausgefuehrt, falls sich die angegebene Variable aendert.@{N}\
(Durch "/set watch_active=0" wird uebrigens nach spaetestens %watch_time Sekunden die Ueberwachung komplett beendet.)
/addh ex \
/watch_var LP@{N}\
startet die Ueberwachung der globalen Variable %LP. Nach@{N}\
/set LP=-200@{N}\
erscheint nach kurzer Zeit@{N}\
# watch: %LP=-200@{N}\
Moechte man die Ueberwachung von %LP beenden, genuegt ein zweiter Aufruf von@{N}\
/watch_var LP@{N}\
Moechte man die Veraendung von %LP hervorheben, so laesst sich das z. B. mit@{N}\
/watch_var LP /echo -aCyellow aktuelle LP: %LP@{N}\
erreichen. Eine Veraendung von %LP fuehrt dann zu@{N}\
# watch: %LP=-200@{N}\
@{Cyellow}aktuelle LP: -200@{n}
/addh see /watch_loop, %watch_time, %watch_active, watch_list, watch_action_list
/addh var %watch_active
/addh list watch_list, watch_action_list
/addh syn /watch_var [Variablenname [Makro]]
/addh watch_var comm

/defh watch_var = \
; /createlist zum Zeitpunkt des Ladens noch nicht definiert, deshalb:
    /if (isList("watch_list")=~error) \
        /createlist watch_list%;\
	/createlist watch_action_list%;\
    /endif%;\
    /if ({#} == 0) \
	/toggle watch_active%;\
	/if (watch_active) \
	    /echo # watching on%;\
	/endif%;\
	/if (!isEmptyList("watch_list")) \
	    /repeat -%watch_time 1 /watch_loop%;\
	/endif%;\
	/return%;\
    /endif%;\
    /let watch_var=%1%;\
    /if (substr(watch_var,0,1) =~ "%") \
	/test watch_var:=substr(watch_var,1)%;\
    /endif%;\
    /if (!isvar(watch_var)) \
	/echo error: \%%watch_var is no global variable%;\
	/return%;\
    /endif%;\
    /getvalueof watch_list %watch_var%;\
    /if (value=~error) \
; neue Variable an Liste anhaengen
	/let watch_contents=%;\
	/test watch_contents:=%watch_var%;\
	/xaddtolist watch_list&%watch_var&%watch_contents%;\
	/if ({#} > 1) \
	    /xaddtolist watch_action_list&%watch_var&%-1%;\
	/endif%;\
	/if (!watch_active) \
	    /set watch_active=1%;\
	    /repeat -%watch_time 1 /watch_loop%;\
	/endif%;\
    /else \
; Variable aus Liste loeschen
	/deletekeyandvalue watch_list %watch_var%;\
	/deletekeyandvalue watch_action_list %watch_var%;\
	/test watch_active:=isEmptyList("watch_list") ? 0 : 1%;\
    /endif


/addh info \
Falls ?%watch_active und %watch_time beide nicht 0 sind, ruft fuer jede in ?watch_list aufgefuehrte Variable ?/watch_check_var auf. Danach wird %watch_list aktualisiert. Anschliessend ruft /watch_loop sich mit einer Verzoegerung von %watch_time Sekunden selber wieder auf.
/addh list watch_list
/addh var %watch_active, %watch_time
/addh mak /watch_check_var
/addh watch_loop mak

/def watch_loop = \
    /if (watch_active & watch_time) \
	/createlist watch_list2%;\
	/foreach watch_list kv /watch_check_var%;\
	/set watch_list=%watch_tmp_list%;\
	/repeat -%watch_time 1 /watch_loop%;\
    /else \
	/echo # watching off%;\
    /endif%;\



/addh info \
Ueberprueft, ob die als erster Parameter uebergebene Variable als Wert die uebrigen Parameter enthaelt. Ist dies nicht der Fall, wird eine entsprechende Meldung ausgegeben. Taucht die Variable in ?watch_action_list auf, so wird dann ausserdem das ihr zugewiesen Makro ausgefuehrt. In jedem Fall wird das Paar Variablename/aktueller Wert an die Liste watch_tmp_list angehaengt.
/addh syn /watch_check_var Variablenname Wert
/addh list watch_list, watch_action_list
/addh watch_check_var mak

/def watch_check_var = \
    /let watch_contents=%1%;\
    /test watch_contents:=%watch_contents%;\
    /if (watch_contents !~ {-1}) \
	/echo # watch: \%%1=%watch_contents%;\
	/getvalueof watch_action_list %1%;\
	/if (value!~error) \
	    /eval -s0 %value%;\
	/endif%;\
    /endif%;\
    /xaddtolist watch_tmp_list&%1&%watch_contents


/def nop=/test 0%;

; Damit das grepen nach "error" keine Probleme macht, bitte
; /test_result mit err_code statt mit error benutzen.
/eval /set err_code=%error



;*************
; Hilfsmakros
;*************

; Gibt "Testing /<Makroname>" aus und ruft dann /<Makroname> auf.
; '/do_test forEach' wuerde also
; Testing /forEach
; ausgeben und dann '/test_forEach' aufrufen.
; Falls man erst alle hier stehenden Makros definieren moechte, setze
; man %just_define auf 1. Dies verhindert def Aufruf der Testmakros.
/def do_test = \
    /echo -aB Testing /%1%;\
    /if (just_define!~"1") \
	/test_%1%;\
    /endif

/def run_tests = \
/echo -aCred RUNNING TESTS NOW!%;\
/eval_hook run_test%;\
/quit%;\

/addh_fileinfo


