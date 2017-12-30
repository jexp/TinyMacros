; $Log: way.tf,v $
; Revision 1.49  2003/08/20 12:53:06  nieten
; /shorten produziert keine Ausgabe mehr
;
; Revision 1.48  2002/12/03 03:53:26  mh14
; setali benutzerfreundlicher
;
; Revision 1.47  2002/11/22 01:54:28  lje
;
; reverting to version 1.45
;
; Revision 1.45  2002/09/17 08:51:35  mh14
; do_wait_tri fuer Schiffe und Grossmaeule
;
; Revision 1.44  2002/09/08 15:13:07  mh14
; /walk verarbeitet jetzt auch zahlen in den befehlen
;
; Revision 1.43  2002/08/28 13:06:25  lje
; an neues compile_regexp angepasst
;
; Revision 1.42  2002/08/27 11:44:11  mh14
; /set_var Falschanwendungen debuggt
;
; Revision 1.41  2002/08/26 08:24:44  mh14
; Konfigurierbare Anzeige der Berechnungsbedinungen, show_dimension() zur Anzeige der Dimension, bloeder Fehler mit leerer portals varable hoffentlich gegengewirkt
;
; Revision 1.40  2002/08/23 12:10:18  thufhnik
; alte Algorithmen aus dem Code entfernt
;
; Revision 1.39  2002/08/22 14:17:09  thufhnik
; speedups mit hilfe der REGCOMP-extension falls vorhanden
;
; Revision 1.38  2002/07/02 09:48:55  mh14
; /set_var portals 1
;
; Revision 1.37  2002/06/11 20:04:13  mh14
; Dimensionsbug behoben
;
; Revision 1.36  2002/06/09 19:54:50  mh14
; portaleinstellung wird gespeichert
;
; Revision 1.35  2002/06/01 17:47:26  thufhnik
; bugfix in addoftenusedway
;
; Revision 1.34  2002/04/19 07:20:17  lje
; Prompt bei Knoteneingabe etwas verschoenert
;
; Revision 1.33  2002/04/18 20:08:56  mh14
; addnode mit mschau
;
; Revision 1.32  2002/04/18 14:02:53  mh14
; knotenerkennung auch mit mschau ein
;
; Revision 1.31  2002/04/16 12:22:22  mh14
; config-system anpassungen
;
; Revision 1.30  2002/04/11 13:15:46  mh14
; restricttoexit entmuellt, mapperzeugs wird jetzt nichtmehr von way.tf geladen
;
; Revision 1.29  2002/03/28 01:08:22  mh14
; add_trip und tgo erlauben temporaere ausfluege von knoten zu naheliegenden zielen (metzelmonster)
;
; Revision 1.28  2002/03/27 01:41:50  mh14
; Aenderung Dimensionsverwaltung 0-9 Paralellwelten
;
; Revision 1.27  2002/02/10 22:32:19  mh14
; Statuszeilendoku
;
; Revision 1.26  2002/01/31 22:12:01  mh14
; setzt den aktuellen knoten bei /end name
;
; Revision 1.25  2001/12/18 00:37:47  mh14
; /bgo geht zum letzten Startknoten von /go zurueck
;
; Revision 1.24  2001/12/08 22:37:40  mh14
; remove_from_cache macht jetzt nur clear_cache
;
; Revision 1.23  2001/12/06 10:58:02  mh14
; ausgabe beim fehlerhaften /wo abstellbar wo_show_bug
;
; Revision 1.22  2001/12/05 16:28:04  nieten
; Grabbing kann jetzt mit Hilfe von %getpoint_trig abgefragt werden
;
; Revision 1.21  2001/12/04 17:44:36  nieten
; /getpoint scrollt weniger bei angeschaltetem wecho
;
; Revision 1.20  2001/12/04 10:47:34  mh14
;  addnodeinfo erweitert (Editieren)
;
; Revision 1.19  2001/12/03 22:08:12  mh14
; ways_location eingebaut, damit die wege auch woanders liegen koennen
;
; Revision 1.18  2001/12/03 12:50:56  mh14
; /npcc benoetigt kein /voff mehr, standardmaessig 1 schritt per parameter mehr, maximale weglaenge auf 1000 erhoeht
;
; Revision 1.17  2001/11/30 13:21:48  mh14
; /wo und /addnode sollten sich jetzt nichtmehr von fremdscroll beeintraechtigen lassen, ausserdem /wo_raum fuer Anzeige der letzten P_LONG von /wo usw.
;
; Revision 1.16  2001/11/29 16:22:11  mh14
; delnodeinfo, keine leeren ()
;
; Revision 1.15  2001/11/29 16:10:40  mh14
; splitways * *
;
; Revision 1.14  2001/11/29 12:59:08  mh14
;  bug bei wegeingabe zahlen in rueckweg behoben
;
; Revision 1.13  2001/11/29 09:27:07  mh14
; hilfe fuer ago
;
; Revision 1.12  2001/11/28 10:59:23  mh14
; editway gibt jetzt den modifizierten weg noch einmal aus (ahab)
;
; Revision 1.11  2001/11/27 21:25:36  mh14
; * sl_* an neue status.tf angepasst
; * an first_connect hook angepasst
; * /von und /npc koennen jetzt parameter haben, die als aktionen beim fehler
; ausgefuehrt werden, z.B.
; /von stecke schluessel in tuer\%;drehe schluessel%;o%;/voff
; lustigerweise kann man damit sogar ne kleine if anweisung basteln
; /von oeffne tuer\%;/cw o%;o%;/voff%;
; dabei sind die Parameter: oeffne tuer\%;/cw o d.h. das wird im fehlerfall
; ausgefuehrt (/cw = befehl ausfuehren + cont_way )
; oder
; /npc toete kampfblech%;w%;/voff%;
;
; Revision 1.10  2001/10/25 20:48:36  mh14
; /wo debuggt (d.h. getpoint)
;
; Revision 1.9  2001/10/10 22:10:21  mh14
; Default-Konfiguration in .tf Files verschoben
;
; Revision 1.8  2001/10/08 17:52:21  mh14
; freeze_status ausgebaut
;
; Revision 1.7  2001/10/07 17:03:29  mh14
; Statuszeilen Modul fuer aktuellen Knoten
;
; Revision 1.6  2001/10/01 18:55:39  mh14
; fehler bei nutzung von value ueber ein read hinaus (paralleles ausfuehren von listenoperationen und zerstoerung von value durch die statuszeile) durch sichern in lokalen variablen behoben
;
; Revision 1.5  2001/09/11 20:56:47  mh14
; erweitertes read eingebaut
;
; Revision 1.4  2001/09/06 21:11:44  mh14
;  Log eingefuegt
;

/set way_tf_version $Id$
/set way_tf_author=Mesirii@mg.mud.de
/set way_tf_requires=!lists.tf util.sfunc.tf util.prompts.tf util.hooks.tf util.trigger.tf(1.18) util.vfunc(1.21)
/set way_tf_desc Wegesystem

; ********************* BEGIN CONFIG ********************
/cfg_info way	   Wegesystem

/cfg_info way WO_SHOW_BUG Fehlertext_bei_wo:wo_show_bug

/add_to_hook first_connect /load_config -c way
/addh info Schaltet die Ausgabe des gegrabbten Textes fuer den Raum bei einem fehlerhaften /wo ein bzw. aus
/addh wo_show_bug cfg

/set_var wo_show_bug 1

/cfg_info way PORTAL_NODE Portalknoten:portal_node
/set_var portal_node tport


/cfg_info way GO_SHOW_CONDITION Bedingungen_fuer_Berechnung
/cfg_set way GO_SHOW_CONDITION 1

/addh info Zeigt vor der Wegberechnung, die aktuell gueltigen Bedingungen, wie Portale, Gilde, Dimension, Spielerstatus usw
/addh dtype flag
/addh CFG_WAY_GO_SHOW_CONDITION cfg

/cfg_info way GO_SHOW_TEXT Ausgabetext_Bedingungen
/set_var CFG_WAY_GO_SHOW_TEXT %way_go_show_para %way_go_show_state  %way_go_show_portals %way_go_show_guild


/set way_go_show_para=$[ dimension()>0 ? strcat("@{Cred}Parawelt @{B}",dimension()) : "@{Cgreen}Normalwelt" ]@{x}
/set way_go_show_state=Status: $[ p_state=/"spieler" ? "@{Cgreen}" : "@{BCgreen}" ]%p_state@{x}
/set way_go_show_portals=Portale: $[portals ? "@{Cgreen}ein" : "@{Cred}aus" ]@{x}
/set way_go_show_guild=Gilde: @{Cyellow}%p_guild@{x}

/addh info Der Text der vor der Wegberechnung angezeigt wird um zu sehen welche Bedingungen gesetzt sind, kann Attribute, Makroaufrufe usw. enthalten
/addh ex %way_go_show_para %way_go_show_state  %way_go_show_portals %way_go_show_guild
/addh CFG_WAY_GO_SHOW_TEXT cfg

/set node_offset=0
/set gone_steps=0
/init_var lastpoint
/addsave lastpoint

/init_var showpoint
/addsave showpoint

/set_var dimension n
/addsave dimension

/set go=0
/cfg_info way MAX_WAY_LENGTH Maximale_Weglaenge:max_way_length
/set_var max_way_length=1000

/addsave llastpoint

/set test_way=0

/set_var portals 1

/add_to_hook loadsaved /if (portals=~"") /set portals=$[p_state=/"seher"]%; /endif
/addsave portals

/addh info \
Variable, die bestimmt, wie die Knoten dargestellt werden sollen
/addh ex \
wert   Beispiel@{N}\
short  mesi@{N}\
long   mesi Haus Mesirii (Ebene)@{N}\
geb    mesi (Ebene)@{N}\
info   mesi Haus Mesirii
/addh default long
/addh alitype var 

/cfg_info way ALI_TYPE Knotenformat:alitype

/set_var alitype long

/addh info \
Trennzeichen fuer das /walk == ?speedwalk
/addh see walk
/addh default ,
/addh movement_marker var

/cfg_info way MOVEMENT_MARKER Speedwalk_Trenner:movement_marker

/set_var movement_marker ,

/def def_walk_hook = /def -mglob -h"send %{movement_marker}*" h_walk = ${walk}

/add_to_hook first_connect /def_walk_hook

/set askway=0

/set verify=0 

/set online=1

/set nodelist=

/addsave rec
/addsave name
/addsave saved_wayto
/addsave saved_waybk

/def gtb = /gotank_back %*%;
/def gt = /gotank %*%;

; ********************* END CONFIG **********************
; Bitte Bedienungsanleitung lesen. (s.u.)

/cfg_info status way Wegesystem
/cfg_info status way PORTAL Portal

/cfg_set status way portal text_1 O
/cfg_set status way portal text @

/cfg_info status way NODE Knoten
/cfg_set status way node text !KEIN
/cfg_set status way node moved color n
/cfg_set status way node not_moved color B

/cfg_info status way DIMENSION Dimension
/cfg_set status way dimension color_0 n
/cfg_set status way dimension color_1 Cred
/cfg_set status way dimension color_2 BCred
/cfg_set status way dimension color_3 Cbgred
/cfg_set status way dimension color_4 BCbgred

/set sl_node_doc=Portale ein(O), aus(@), letzter Knotenpunkt, wenn nicht entfernt fett, Parawelt rot
/def sl_node = \
  /init_var show_point dimension portals%;\
  /set status_func_portals=(portals==1) ? CFG_STATUS_WAY_PORTAL_TEXT_1 : CFG_STATUS_WAY_PORTAL_TEXT%;\
  /set status_func_showpoint=(showpoint=~"") ? CFG_STATUS_WAY_NODE_TEXT : showpoint%;\
  /set status_attr_showpoint=strcat((saved_wayto!~"")?CFG_STATUS_WAY_MOVED_COLOR:CFG_STATUS_WAY_NOT_MOVED_COLOR,CFG_STATUS_WAY_DIMENSION_COLOR_$[dimension()])%;\
  /return strcat(status_var("portals",1)," ",status_var("showpoint",7))


/addh info \
Fuegt einen !kompletten Weg zur Liste ?ways hinzu.
/addh list ways
/addh see ~getway, ways
/addh ~addway mak
/def ~addway = /addlisttolist ways %* %;

/addh info \
Liefert einen kompletten Weg aus der Liste ?ways zurueck.
/addh list ways
/addh see ~addway, ways
/addh ~getway mak

/def ~getway = /getlistvalueof ways %* %;


/addh info \
Die Liste 'ways' enthaelt alle Wege in kompletter Form:@{N}\
Anfang: Subliste aller wegfuehrenden Wege, naechster Anfang ...@{N}\
Subliste: Ziel Dimension([n]ormal|[p]arawelt|[b]eides|[0-9].Parawelt)@{N}\
          Erlaubnis(siehe dort), Laenge des Wegs Weg, naechstes Ziel ...@{N}\
Aus dieser Liste werden zwei Indizes erzeugt: Der 'fromidx', der eine verkuerzte Form von Ways darstellt, d.h. ohne die eigentlichen Wege, und der 'toidx', der die nach Zielen gruppierte Liste enthaelt.
/addh see knoten, dimensionen, portale, wege
/addh list fromidx, toidx
/addh ways see

/addh info \
Die Knoten des Wegesystems halten dieses zusammen. Zwischen ihnen verlaufen die Wege. Die Knoten werden als Raeume erkannt, sie sind Anfangs-, Zwischen- und Zielpunkte jedes berechneten Weges. Die Knoten werden in allen Wegelisten abgespeichert.@{N}\
Fuer die Knoten gelten bestimmte Namenskonventionen:@{N}\
In den Knotennamen sollten nur Buchstaben, Zahlen und Unterstriche stehen.@{N}\
Kneipe: Kname, Laden: Lname, Portale tname, Seherhaeuser: ein paar Buchstaben des Namens des Sehers (kleingeschrieben)@{N}\
Es gibt ein paar reservierte Namen: tport, laden, kneipe.@{N}\
Bitte haltet Euch an die Konventionen, sie sind sehr wichtig.@{N}\
Fuer jeden Knoten kann mit /setali ein Aliasname vergeben werden, der dann ganz normal genutzt werden kann.@{N}\
Jeder der Knoten kann mittels /wo als Raum im Mud erkannt werden. \
Mit /lp kann man auch Knoten per Hand setzen, das sollte aber nicht \
noetig sein. Die Anzeigevariable fuer die Knoten lautet %showpoint. \
Diese zeigt auch die ggf. vorhandenen Aliase korrekt an.
/addh comm shownode, setali, appendnode, addnode, delnode, wo
/addh list lastpoints, nodealias, ways, toidx, fromidx, often, often2, tanken \
/addh see wege, tanken, spezialknoten, portale, knotenaliase
/addh var showpoint, lastpoint
/addh knoten see

/addh info \
Die Wege des Systems werden in einer grossen Liste (?ways) gespeichert. \
Sie werden durch Anfangs- und Endknoten und gewisse Einschraenkungen \
definiert. Die Eingabe der Wege kann direkt im Mud erfolgen. Es ist also \
nicht notwendig, die Listen von Hand zu bearbeiten (und auch nicht zu \
empfehlen!!!). Die Eingabe der Wege erfolgt einfach durch das einmalige \
Ablaufen des Weges. Wenn Sonderbewegungsbefehle entsprechend berueck\
sichtigt wurden, sind danach beide Wege (Hin- und Rueckweg) verfuegbar. \
Das Abspeichern eines Weges erfolgt mit /end (siehe dort).@{N}\
Es gibt mehere Kommandos zum Verwalten der Wege, die alle dieselbe \
Syntax haben:@{N}\
/kommando anfangsknoten|* endknoten|* @{B}(* * ist unzulaessig)@{n}@{N}\
ACHTUNG: Die Editierkommandos speichern die Aenderungen sofort ab!
/addh comm showway, editway, delway
/addh list disabled, often, often2
/addh wege see


/def addoften = /addtolist often %* %;
/def getoften = /getvalueof often %* %;
; intern
/addh info \
Setzt den aktuellen Knoten auf den uebergebenen Parameter. Der Inhalt der Variablen %cond_go wird geloescht. Wenn der Mapper aktiv ist (%mapper==1), wird ein 'go knotename' an den Mapper gesandt.
/addh var lastpoint, cond_go, showpoint
/addh see /cond_go, mapper
/addh lp2 mak
/def lp2 = \
	/if ({1}=~error) /break%; /endif%;\
	/set cond_go=%;\
	/set go=0%;\
	/set show_grabbed=0%;\
	/set gone_steps=0%;\
	/set lastpoint=%1 %;\
	/_getali %1 %;\
	/set showpoint=%value%;\
	/if (showpoint!~"") \
	/getali %1%;\
	/echo -p Knoten: %value.%;\
	/if (mapper==1) \
	   /send -wmapper go %showpoint%; \
	/endif%;\
	/else \
	  /echo Kein bekannter Knoten!%;\
	/endif%;\
        /begin %lastpoint %;

/addh info \
Setzt den aktuellen Knoten. Dabei wird nicht geprueft, ob dieser Knoten \
schon existiert. Das kann genutzt werden, wenn /wo versagt, oder wenn man \
von diesem neuen Knoten aus eine Weg erstellen will.(Dann aber nach dem \
/lp /appendnode aufrufen.)@{N}\
Der Puffer fuer die Wegaufzeichnung wird geloescht!!
/addh var showpoint, lastpoint
/addh see wo, knoten
/addh lp comm
/defh lp = \
	/if ({1}=~"") /echo Bitte Punkt angeben! %;\
        /else \
	  /set go=0%;\
	  /getnode %1 %;\
	  /lp2 %value%;\
        /endif %;
/addh info \
Nach manuellen Arbeiten an der Liste ways MUSS /wayindex aufgerufen werden, \
damit die Indexlisten neu erstellt werden!
/addh list fromidx, toidx
/addh see wege, ways
/addh var temp_list, temp_list2
/addh mak sort_idx_list, savelist, alle moeglichen Listenbefehle
/addh wayindex comm

/defh wayindex = \
	/fromindex%;\
	/toindex%;

/def fromindex = \
        /createlist fromidx %;\
;        /let reg=$[strcat("(([bpn0-9]) ([^ ]+) ([0-9]+))")]%;\
        /let widx=0%;\
        /getikey ways %widx%;\
        /while (value!~error) \
           /let key=%value %;\
           /getlistvalueof ways %key %;\
/let key%;\
           /if (value!~error) \
             /set temp_list=%value %;\
             /createlist temp_list2 %;\
             /while (temp_list!~"<I>") \
                /getfirstkey temp_list %;\
                /let key2=%value %;\
                /getfirstvalue temp_list %;\
;                /test $[regmatch(reg,value)] %;\
                /test $[regmatch(way_regexp_find6,value)] %;\
                /addtolist temp_list2 %key2 %P0 %;\
                /deletekeyandvalue temp_list %key2 %;\
             /done %;\
             /sort_idx_list temp_list2 %;\
             /addlisttolist fromidx %key %temp_list2 %;\
           /endif %;\
           /let widx=$[widx+1] %;\
           /getikey ways %widx%;\
        /done %;\
	/savelist %ways_location fromidx %;\
        /echo From-Index erstellt! %;

/def toindex=\
        /createlist toidx %;\
        /createlist temp_list2 %;\
;        /let reg=$[strcat("(([bpn0-9]) ([^ ]+) ([0-9]+))")]%;\
        /let widx=0%;\
        /getikey ways %widx%;\
        /while (value!~error) \
           /let key=%value %;\
/let key%;\
           /getlistvalueof ways %key %;\
           /if (value!~error) \
             /set temp_list=%value %;\
             /while (temp_list!~"<I>") \
                /getfirstkey temp_list %;\
                /let key2=%value %;\
                /getfirstvalue temp_list %;\
;                /test $[regmatch(reg,value)] %;\
                /test $[regmatch(way_regexp_find6,value)] %;\
                /addtolist temp_list2 %key2 %key %P0 %;\
                /deletekeyandvalue temp_list %key2 %;\
             /done %;\
           /endif %;\
           /let widx=$[widx+1] %;\
           /getikey ways %widx%;\
        /done %;\
        /while (temp_list2!~"<I>") \
          /getfirstkey temp_list2 %;\
          /let key=%value %;\
/let key%;\
          /createlist temp_list %;\
          /getvalueof temp_list2 %key %;\
          /while (value!~error) \
            /addtolist temp_list %value %;\
            /deletekeyandvalue temp_list2 %key %;\
            /getvalueof temp_list2 %key %;\
          /done %;\
          /sort_idx_list temp_list %;\
          /addlisttolist toidx %key %temp_list %;\
        /done %;\
	/savelist %ways_location toidx %;\
        /echo To-Index erstellt! %;

/addh info \
Sortiert eine Wegknotensubliste nach der Laenge der Teilwege.
/addh syn /sort_idx_list subliste
/addh var stemp_list
/addh sort_idx_list mak

/defh sort_idx_list = \
	/set stemp_list=%;\
        /test stemp_list:=%1 %;\
        /createlist %1 %;\
        /while (stemp_list!~"<I>") \
          /let idx=0 %;\
          /let min=1000 %;\
          /getivalue stemp_list %idx %;\
          /while (value!~error) \
;             /test $[regmatch("([bpn0-9]) ([^ ]+) ([0-9]+)",value)] %;\
             /test $[regmatch(way_regexp_find6,value)] %;\
             /if ({P3}<min) /let min=%P3 %; /let minidx=%idx %; /endif %;\
             /let idx=$[++idx] %;\
             /getivalue stemp_list %idx %;\
          /done %;\
          /getikey stemp_list %minidx %;\
          /let key=%value %;\
          /getivalue stemp_list %minidx %;\
	  /let key=%key %value %;\
	  /delikeyandvalue stemp_list %minidx %;\
          /addtolist %1 %key %;\
        /done %;

/addh info \
Initialisiert die Listen fuer das Wegberechnen.
/addh list froml_w, tol_w, froml_k, tol_k
/addh var nofrom, noto, fromlen, tolen, frommaxlen, tomaxlen
/addh initfind mak
; ~l_w Listen mit Wegen: Laenge Ziel (Weg aus :knoten:+)
; froml_k, tol_k schon getestete Knoten
; ~len: lgesamtlaenge in der Richtung
; no~ auf 1 gesetzt, wenn keine Wege mehr in ~l_w sind
; 
; ~maxlen
; 
/def initfind = \
        /createlist %2l_w%;\
        /createlist %2l_k%;\
        /addtolist %2l_k %1 0 0%;\
        /set %2len=0 %;\
        /set no%2=0 %;\
        /set %2maxlen=%gmaxlen %;\
	/set %2_ways_0 %1 :%1:\$%;

/def setparts = \
         /if ({-1}!=-1) \
           /set %1len=%2 %;\
           /set %1node=%3 %;\
           /set %1way=%4 %;\
        /else \
;/echo keine Wege mehr in %1l_w %; \
           /set no%1=1 %;\
        /endif %;

/def check_single = \
	/let from=%1%;\
	/let to=%2%;\
	/getlistvalueof fromidx %from%;\
	/set temp_get_way=%value%;\
	/getdvalueof temp_get_way %to%;\
	/set gmaxlen=1000%;\
	/while (value!~error) \
;	  /test $[regmatch("([bpn0-9]) ([^ ]+) ([0-9]+)",value)] %;\
	  /test $[regmatch(way_regexp_find6,value)] %;\
	  /let plen=%P3%;\
	  /let ber=%P1%;\
	  /let allow=%P2 %;\
;	  /if (((ber=~"b")|(ber=~dimension))& \
	  /if ((same_dimension(ber))& \
		 ((allowed(allow)))) \
	     /if (1+plen<gmaxlen) /set gmaxlen=$[1+plen]%; /endif%;\
;/set gmaxlen%;\
;	     /break%;\
	  /endif%;\
	  /getdvalueof temp_get_way %to%;\
	/done%;


/addh info \
Enthaelt die Hauptschleife fuer das Wegesuchsystem, d.h. von den zwei Endpunkten aus werden sternfoermig die kuerzesten Wege gesucht, und bei Ueberschneidungen der beiden Netze wird der gefundene Gesamtweg benutzt.
/addh var portals, gmaxlen, break, 
/addh list l_k, temp_fromidx, temp_toidx
/addh mak initfind, getshortestway, find6
/addh find5 mak
/def find5 = \
;        /gettime %;\
        /set break=0 %;\
        /set gmaxlen=1000 %;\
; kopie von den indexlisten
; todo: indexlisten vorher saeubern
	/check_single %1 %2%;\
;/let find5count=0%;\
;/set gmaxlen%;\
        /set temp_fromidx=%fromidx %;\
        /set temp_toidx=%toidx %;\
; liste der schon getesteten knoten
        /createlist l_k%;\
; ggf. portale ignorieren
        /if (portals==0) /addtolist l_k %portal_node %; /endif %;\
; initialisierung fuer anfangsknoten
        /initfind %1 from %;\
        /initfind %2 to %;\
; solange noch nicht fertig, abwechselnd testen
        /while ((noto==0)|(nofrom==0)) \
; from - richtung testen
;/echo noto=%noto    	nofrom==%nofrom%;\
;/set tomaxlen%;\
           /if (nofrom==0) \
;/gettime %;\
             /getshortestway from %;\
;/echo from %value%;\
;/set value%;\
;/profile gsw from %value %;\
;	/echo from %value%;\
             /setparts from %value %;\
;/profile sp %;\
             /find6 %1 %2 from %;\
;/profile find6%;\
           /endif %;\
;/echo to %l_k%;\
           /if (noto==0) \
;/gettime %;\
             /getshortestway to %;\
;/profile gsw to %value%;\
;	/echo to %value%;\
             /setparts to %value %;\
;/profile sp %;\
             /find6 %2 %1 to %;\
;/profile find6%;\
           /endif %;\
;;/echo nofrom %nofrom noto %noto%;\
;;/set froml_k%;\
;;/set tol_k%;\
;;/echo to %l_k%;\
;;/if (++find5count==10) /_read%; /let find5count=0%; /endif%;\
;;/_read%;\
        /done %;\
	/set frommaxlen=0%;\
	/killlongerways from%;\
	/set tomaxlen=0%;\
	/killlongerways to%;

;/profile fertig %;
/addh info \
Fuehrt die Wegesuche fuer jeden einzelnen Knoten der Start- und Zielnetze aus.
/addh var (~ bedeutet jeweils from und to) ~len, ~node, ~way, ~maxlen, len, node, way, maxlen
/addh list ~ bedeutet jeweils from und to l_k, temp_~idx, temp_list
/addh mak iskey, disabled, allowed, testcon
/addh find6 mak
/def find6 = \
;/gettime %;\
           /eval /set len=\%%3len %;\
           /eval /set node=\%%3node %;\
           /eval /set way=\%%3way %;\
           /eval /set maxlen=\%%3maxlen %;\
;/echo to %tomaxlen from %frommaxlen %3 %maxlen%;\
         /iskey l_k %node %;\
;/echo find6 node: %node%;\
;/set l_k%;\
;;/echo find6 node %node way %way len %len maxlen %maxlen%;\
; wenn zielknoten noch nicht in liste
         /if (value=~error) \
; hinzufuegen
           /addtolist l_k %node %;\
           /getdlistvalueof temp_%3idx %node %;\
; und alle teilwege ausprobieren
;/set value%;\
           /if (value!~error) \
             /set temp_list=%value %;\
;            /deletekeyandvalue temp_%3idx %node %;\
;/profile %node anf %;\
             /while (temp_list!~"<I>") \
;/gettime %;\
               /getfirstkey temp_list %;\
               /let key=%value %;\
	       /if ({3}=~"from") /let dis=$(/disabled %node %key) %;\
		/else  /let dis=$(/disabled %key %node) %;\
	       /endif %;\
               /iskey l_k %key %;\
;/echolist %3 %node -> %key in l_k %value%;\
               /if ((value=~error)&(dis=~"0")) \
                 /getfirstvalue temp_list %;\
;                /test $[regmatch("([bpn0-9]) ([^ ]+) ([0-9]+)",value)] %;\
                 /test $[regmatch(way_regexp_find6,value)] %;\
                 /let plen=%P3%;\
                 /let ber=%P1%;\
	         /let allow=%P2 %;\
;/profile %key anf2 %;\
;/echolist allowed: %len+%plen<%maxlen $[((0+len+plen)<maxlen)] $[((ber=~"b")|(ber=~dimension))] $[((allowed(allow)))]%;\
;                 /if (((0+len+plen)<maxlen)&((ber=~"b")|(ber=~dimension))& \
                 /if (((0+len+plen)<maxlen)&(same_dimension(ber))& \
			((allowed(allow)))) \
                    /getdvalueof %3l_k %key %;\
;/echo find6 %3:  %node -> %key%;\
;                    /if (value=~error|((regmatch("^([0-9]+) ([0-9]+) (.+)",value))&((0+{P1}+{P2})>(len+plen)))) \
                    /if (value=~error|((regmatch(way_regexp_find6_3,value))&((0+{P1}+{P2})>(len+plen)))) \
;/echolist used: %value%;\
                       /if (node!~portal_node) \
		           /test value:=strcat(\{%{3}_ways_$[len+plen]\},key," ")%;\
			   /let temp_value=%value%;\
			     /if ({3}=~"from") \
				/set %3_ways_$[len+plen]=$[strcat(value,way,key,":$")]%;\
				/else \
				/set %3_ways_$[len+plen]=$[strcat(value," :",key,way,"$")]%;\
			     /endif %;\
;	/set %3_ways_$[len+plen]%;\
                       /endif %;\
; plen laenge neuer teilweg, len gesamtlaenge bisher
                       /addtolist %3l_k %key %plen %len %way%;\
                       /testcon %key %3%;\
	            /else \
		       /if (value!~error) \
			  /addtolist %3l_k %key %value%;\
	               /endif%;\
;		       /echo -aCred Fehler bei: %node -> %key ( %value )%;\
		    /endif%;\
;                    /else \
;                       /getvalueof %3l_k %key %;\
;                       /test $[regmatch("([0-9]+) ([0-9]+) (.+):$",value)] %;\
;                       /if (({P1}+{P2})>(len+plen)) \
;                        /if (node!~portal_node) \
;		          /test value:=strcat(\{%{3}_ways_$[len+plen]\},key," ")%;\
;                          /if ({3}=~"from") \
;			   /set %3_ways_$[len+plen]=$[strcat(value,way,key,":$")]%;\
;			   /else \
;			   /set %3_ways_$[len+plen]=$[strcat(value,":",key,way,"$")]%;\
;                          /endif %;\
;	/set %3_ways_$[len+plen]%;\
;                         /endif %;\
;                          /deletekeyandvalue %3l_k %key %;\
;                          /addtolist %3l_k %key %plen %len %way%;\
;                          /testcon %key %3%;\
;                       /endif %;\
;                    /endif %;\
                 /endif %;\
;/profile bdy %;\
               /endif %;\
               /deletekeyandvalue temp_list %key %;\
;	/echolist%;\
             /done %;\
           /endif %;\
        /endif %;


/def testfind = \
	/getnode %1%; /let from=%value%;\
	/getnode %2%; /let to=%value%;\
	/let t=$[time()]%;\
	/find5 %from %to%;\
	/echo Zeit: $[time()-t] %min_way %min_steps%;

/addh info \
Testet, ob sich Hinweg und Rueckweg schon treffen.
/addh var min_steps, gmaxlen, min_way, (~ bedeutet jeweils from bzw. to) ~slen, ~maxlen
/addh list ~l_k
/addh mak killlongerways
/addh testcon mak
/def testcon = \
; %2 == aufrufparameter von find6(%3)
; vs das entgegengesetzte
;/if ({2}=~"from" & {1}=~"tport") /set tol_k%; /endif%;\
        /if ({2}=~"to") /let vs=from %; \
	/else /let vs=to %; /endif %;\
; knoten in %1 aus gegenliste suchen
        /getvalueof $[strcat(vs,"l_k")] %1 %;\
; wenn gefunden==> ueberlappung
;/echo %1 hin %2 gegen%vs%;\
;/set %{vs}l_k%;\
        /if (value!~error) \
;/set froml_k%;\
;/set tol_k%;\
;/set value %;\
;/echo -aCred TESTCON %1 %2%;\
;          /test $[regmatch("([0-9]+) ([0-9]+)( :(.+):)?$",value)] %;\
           /test $[regmatch(way_regexp_testcon,value)] %;\
           /let vslen=%P2%;\
; vslen==Laenge des gesamtweges (gegenweg)
           /set %{vs}slen=$[{P2}+{P1}]%;\
; %{vs}len gesamtlaenge gegenweg
           /let vsplen=%P1%;\
; laenge neues wegstueck gegenweg
           /let vsway=%P4%;\
;/echo gegenrichtung: %vs : teilweg: %vslen wegstueck %vsplen gesamt $[vslen+vsplen] weg: %vsway %;\
           /getvalueof %2l_k %1 %;\
; weg aus aktueller liste
;          /test $[regmatch("([0-9]+) ([0-9]+)( :(.+):)?$",value)] %;\
           /test $[regmatch(way_regexp_testcon,value)] %;\
           /let svlen=%P2%;\
           /set %2slen=$[{P2}+{P1}]%;\
           /let svplen=%P1%;\
           /let svway=%P4%;\
;/echo testrichtung: %2 : teilweg: %svlen wegstueck %svplen gesamt $[svlen+svplen] weg: %svway %;\
;/echo tc %2 : %svlen %svplen %svway %;\
;/echo rueckweg(to)laenge %toslen hin(from)weglaenge %fromslen beide + teilstuecke $[vslen+vsplen+svlen+svplen] <maxlaenge %gmaxlen %;\
           /if ((vslen+vsplen+svlen+svplen)<gmaxlen) \
; maxlaenge ggf. reduzieren
             /set gmaxlen=$[vslen+vsplen+svlen+svplen] %; \
	     /set min_steps=%gmaxlen %;\
;/set min_steps%;\
;;/set gmaxlen%;\
             /if ({2}=~"from") \
		/set min_way=$[strcat(svway,":",{1},":",vsway)]%;\
             /else /set min_way=$[strcat(vsway,":",{1},":",svway)]%; \
             /endif %;\
;;/set min_way%;\
	     /if (substr(min_way,0,1)=~":") \
		/set min_way=$[substr(min_way,1)] %; /endif %;\
	     /if (substr(min_way,strlen(min_way)-1)=~":") \
		/set min_way=$[substr(min_way,0,strlen(min_way)-1)] %; /endif %;\
; /echo -aCred testcon %2  %min_way %min_steps %toslen %tomaxlen %gmaxlen %fromslen %vslen %vsplen%;\
; wenn teilweggesamtlaenge (mit wegstueck) < als maxlaenge fuer die richtung dann maxlaenge runtersetzen
;            /if (gmaxlen-fromslen<tomaxlen) \
             /if (toslen<tomaxlen & toslen>0) \
;;              /set tomaxlen=$[gmaxlen-fromslen]%;\
;min_steps was toslen
;               /set tomaxlen=%min_steps%;\
;               /set tomaxlen=%toslen%;\
               /set tomaxlen=%gmaxlen%;\
;;/set tomaxlen%;\
               /killlongerways to%;\
             /endif %;\
;            /if (gmaxlen-toslen<frommaxlen) \
             /if (fromslen<frommaxlen & fromslen>0) \
;              /set frommaxlen=$[gmaxlen-toslen]%;\
;               /set frommaxlen=%min_steps%;\
;               /set frommaxlen=%fromslen%;\
               /set frommaxlen=%gmaxlen%;\
;%fromslen%;\
               /killlongerways from %;\
             /endif %;\
	     /eval /set maxlen=\%%2maxlen %;\
;/echo -aCred %gmaxlen %tomaxlen %frommaxlen %;\
           /endif %;\
;	/_read%;\
        /endif %;

/addh info \
Loescht die Wege, die laenger als die angegebene Variable (from|to)maxlen sind aus der Liste (from|to)temp_list.
/addh var maxlen, (~ = from|to) ~maxlen, ~temp_list
/addh syn killlongerways (from|to)
/addh killlongerways mak

/def killlongerways= \
;/let t=$[time()]%;\
	/set output=$(/listvar -g -s %{1}_ways_*)%;\
;	/echo $[time()-t] killongerways %* %output%;\
;/let t=$[time()]%;\
;	/set %1maxlen%;\
;	/echo $[time()-t] %;\
;/let t=$[time()]%;\
;	   /set output%;\
	/let minlen=1%;\
	/test value:=strcat(\{%{1}maxlen\})%;\
	/let baselength=$[strlen(strcat({1},"_ways_"))]%;\
	/let off=$[strchr(output," ")]%;\
	/while  (off!=-1) \
	   /let alen=$[0+substr(output,baselength,off)]%;\
;	   /echo %alen%;\
	   /if (alen>value) \
	      /unset %{1}_ways_%alen%;\
	   /endif%;\
	   /set output=$[substr(output,off+1)]%;\
;	   /set output%;\
	   /let off=$[strchr(output," ")]%;\
	/done%;\
	/let alen=$[0+substr(output,baselength)]%;\
;	/echo %alen%;\
	/if (alen>value) \
	   /unset %{1}_ways_%alen%;\
	/endif%;\
;	/echo $[time()-t] %;\


;/set from_ways_10=ziel10 10 :5:6:7:$ziel11 11 :11:12:14:
;/set from_ways_15=ziel15 23 :5:6:7:
;/set from_ways_145=ziel0 0 :1:2:3:$ziel125 135 :0:0:0:

/addh info \
Liefert den kuerzesten Weg aus der Liste (from|to)l_w.
/addh var len, maxlen, (~ = from|to) ~templ_w, ~len, ~maxlen, ~l_w 
/addh return value=kuerzester Weg oder -1, wenn keine Wege mehr vorhanden sind oder sie eine Laenge >1000 haben.
/addh getshortestway mak
/def new_test_getshortestway = \
	/set fromlen=1%;\
	/let count=0%;\
	/set frommaxlen=50%;\
	/while (++count<500) \
	  /let x=$[rand(1,500)]%;\
	  /test value:=strcat(\{from_ways_%{x}\})%;\
	  /set from_ways_%x=$[strcat(value,"ziel",x," ",x,":adfklf:sdfjhakfh:dakflasf:sdkfaldsf:$")]%;\
;	  /set from_ways_%x%;\
	/done%;\
	/listvar -s -g from_ways_*%;\
	/let t=$[time()]%;\
	/set value=1%;\
;	/while (value!~"-1") \
;	/getshortestway from%;\
	/killlongerways from%;\
;	/done%;\
	/echo Time: $[time()-t]%;\
	/listvar -s -g from_ways_*%;


/def getshortestway = \
;/gettime%;\
; Laengen in Variablen z.B. from_ways_10 durch $ getrennt
        /let min=1000 %;\
	/test value:=strcat(\{%{1}len\})%;\
;/set value%;\
	/let minlen=1000%; \
;%value%;\
;/let minlen%;\
	/set output=$(/listvar -g -s %{1}_ways_*)%;\
;	/set output%;\
	/let baselength=$[strlen({1})+strlen("_ways_")]%;\
	/test output:=strcat(output," ")%;\
	/set output=$[substr(output,baselength)]%;\
;	/set output%;\
	/let off=$[strchr(output,' ')]%;\
	/while (off>-1) \
	  /let alen=$[substr(output,0,off)]%;\
;/echo #%alen#	%;\
	  /if ((0+alen)<(0+minlen)) /let minlen=%alen%; /endif%;\
	  /set output=$[substr(output,strlen(alen)+1+baselength)]%;\
	  /let off=$[strchr(output,' ')]%;\
;	  /set output%;\
;	  /let off%;\
	/done%;\
	/if (off==-1 & strlen(output)>0) \
	   /let alen=$[substr(output,0)]%;\
	   /if ((0+alen)<(0+minlen)) /let minlen=%alen%; /endif%;\
	/endif%;\
;/echo #%alen#	%;\
;	/while  (strstr(output,strcat({1},"_ways_",minlen," "))==-1) \
;	   /let minlen=$[++minlen]%;\
;	   /if (minlen==1000) /break%; /endif%;\
;	/done%;\
	/let min=%minlen%;\
;/let min%;\
        /if (min==1000) /set value=-1 %; \
        /else \
           /test value:=strcat(\{%{1}_ways_%{min}\})%;\
;/echo #%value#%;\
	   /let off=$[strchr(value,"$")]%;\
;/let off%;\
	   /if (off!=-1) \
;/let min%;\
;/set %{1}_ways_%min%;\
	      /if (substr(value,off+1)=~"") \
	        /unset %{1}_ways_%min%;\
	      /else \
	        /set %{1}_ways_%min=$[substr(value,off+1)]%;\
	      /endif%;\
              /set value=%min $[substr(value,0,off)]%;\
;/set value%;\
	   /else \
	      /set value=%min %value%;\
	      /unset %{1}_ways_%min%;\
	   /endif%;\
	/endif%;\
;	/set value%;
;/profile getshortestway end%;

;/def changeways = \
;        /createlist ways2 %;\
;        /getfirstkey ways %;\
;        /while (value!~error) \
;          /let key=%value %;\
;          /~getway %key %;\
;          /if (value!~error) \
;             /set temp_list3=%value %;\
;             /getfirstkey temp_list3 %;\
;             /createlist temp_list4 %;\
;             /while (value!~error) \
;                /let key2=%value %;\
;                /getvalueof temp_list3 %key2 %;\
;                /if (value!~error) \
;/addtolist temp_list4 %key2 b $[$(/count_steps %value)] %value%;\
;                /endif %;\
;                /deletekeyandvalue temp_list3 %key2 %;\
;                /getfirstkey temp_list3 %;\
;             /done %;\
;             /addlisttolist ways2 %key %temp_list4 %;\
;          /endif %;\
;          /deletekeyandvalue ways %key %;\
;          /getfirstkey ways %;\
;        /done %;

/addh info \
Berechnet die Laenge des Wegs ueber das Zaehlen von %;
/addh syn $(/count_steps Weg)
/addh return die Laenge ueber /echo, also $()
/addh count_steps mak
/def count_steps = \
   /let count=0 %;\
   /let param=%* %;\
   /let off=$[strstr(param,"%;")] %;\
   /while (off!=-1) \
     /let count=$[count+1] %;\
;     /echo $[substr(param,0,off)]%;\
     /if (substr(param,0,off)=/"{/von*|/npc}") /let count=$[count+20]%;\
     /endif%;\
     /let param=$[substr(param,off+2)] %;\
     /let off=$[strstr(param,"%;")] %;\
   /done %;\
;   /let count%;\
   /result %count %;
/addh info \
Damit kann man den Zustand 'askway' umschalten. Wenn askway eingeschaltet ist, wird der Weg berechnet und angezeigt. Dann wird auf eine Eingabe gewartet. Wenn diese (n)ein ist, wird der Weg nicht gegangen, ansonsten (Return) wird der Weg gegangen.
/addh see go
/addh var askway
/addh askway comm

/defh askway=/toggle askway %;\
	/set askway %;

/addh info \
Damit es nicht immer so muehselig ist, erst /wo und dann /go zu benutzen, habe ich den Befehl /gof hinzugefuegt, dessen erster Parameter der Ausgangsknoten ist.
/addh ex /gof start ziel
/addh see go, wo
/addh gof comm

/defh gof = \
	/lp %1%;\
	/_go %-1%;

/addh info \
ago fuehrt alles was nach dem Zielknoten als Parameter uebergeben wird am Ziel als Befehle aus. Die Parameter koennen TF oder Mudbefehle sein (Trennung durch %;)
/addh ex /ago kneipe kaufe bier
/addh ago comm

/defh ago = \
	/set after_go=%-1%;\
	/_go %1%;


/addh info \
die Variable %after_go kann beliebige Kommandos (Mud oder tf) enthalten, die nach erfolgreichem Ablaufen eines Weges ausgefuehrt werden. Der Trenner fuer tf sollte aber escaped werden.
/addh ex /set after_go /echo Jetzt bin ich fertig\%;tanze\%;@{N}\
	 /go ziel@{N}\
	 Jetzt bin ich fertig@{N}\
	 Du tanzt.
/addh see go
/addh after_go var

/addh info \
Testet ob er den aktuellen Raum kennt. Wenn ja, wird der Weg gegangen (via /_go), und wenn nicht, gibt es eine Fehlermeldung.
/addh see go, wo
/addh wgo comm

/defh wgo = /set wgo=%*%;/test getpoint("/wgo2","/echo Kein bekannter Knoten! Letzter bekannter Knoten: %showpoint.") %;

/def wgo2 = /lp2 %1%;\
	    /_go %wgo%;\
	    /unset wgo%;


/addh info Geht zum Knoten Startknoten des letzten /go zurueck
/addh bgo comm
/def bgo = \
     /getali %llastpoint%;\
	  /echo -p Gehe zu: %value%;/_go %llastpoint

/addh info \
Ist der wichtigste Befehl des Wegeprogramms.@{N}\
Syntax: /go [knoten1 knoten2 ...] endknoten@{N}\
Es wird ein Weg ueber die angegebenen Knoten zum Endknoten berechnet. \
Der Weg wird angezeigt und dann geht es los. ;)@{N}\
Da der Weg, der vom letzten bekannten Knoten aus gegangen wurde, mitgeloggt \
wurde, wird zuerst zu dem letzten bekannten Knoten gegangen, danach wird der \
berechnete Weg zum Zielknoten gegangen.@{N}\
Dabei gibt es folgende Besonderheiten: Fehler treten auf, wenn auf dem \
Weg zum letzten bekannten Knoten Wegebefehle auftreten, die keine Richtungs- \
befehle sind oder wenn der Rueckweg zum Knoten anders verlaeuft als der \
Hinweg.@{N}\
Fehler (Zyklus) werden gemeldet, wenn der Startknoten im Laufe des \
(erzwungenen) Weges wieder passiert wird.@{N}\
Waehrend des Weges kann allerlei passieren:@{N}\
Fall kein bekannter Startpunkt vorhanden ist, wird das gemeldet.@{N}\
Wenn ein Hindernis im Weg steht und das im Weg vorgesehen ist, wird \
man gefragt, ob man den Weg temporaer sperren will. Wenn ja, wird dies \
getan, und man kann mit /continue oder /c zum letzten Knotenpunkt zuruecklaufen \
Wenn nein, muss man das Hindernis beseitigen und kann dann mit /continue \
weiterlaufen bis zum Ziel.@{N}\
Wenn ein NPC vorgesehen ist, den man sowieso weghaut, gibt es die erste \
Variante nicht. Man bekommt aber eine schoene Meldung ;).@{N}\
Ausserdem koennen im Weg beliebige Makros enthalten sein, die dann alles \
moegliche machen. Zu diesen Sachen steht viel mehr unter Wegeingabe.@{N}\
Schon gegangene Wege werden in einer Liste temporaer zwischengespeichert, \
damit es beim zweiten Mal schneller geht. Wenn man einen Weg dauerhaft \
speichern will, so sollte man /ao benutzen.
/addh see /gof, %after_go
/addh changes 1.04 Fehlermeldung, wenn Teilknoten des Weges keine Ausgaenge hat, andere Fehlermeldungen praezisiert.@{N}\
  1.05 der Inhalt der Variablen %after_go wird nach komplettem Ablaufen des Weges ausgefuehrt.

/addh go comm


/defh go = /_go %*%;

/def _go = \
  /if (lastpoint=~"") /echo Zuerst Startpunkt mit /wo oder /lp setzen! %;\
  /else \
    /eval /eval /ifecho CFG_WAY_GO_SHOW_CONDITION -p %CFG_WAY_GO_SHOW_TEXT%;\
    /clear_actions%;\
;/gettime %;\
    /let param=%*%;\
    /let lastpt=%lastpoint%;\
    /set llastpoint=%lastpoint %;\
    /let ms=0%;\
    /let mw=%;\
    /while (param!~"") \
       /let off=$[strstr(param," ")] %;\
       /if (off==-1) \
	  /let nextpt=%param%;\
	  /let param=%;\
	/else \
         /let nextpt=$[substr(param,0,off)] %;\
         /let param=$[substr(param,off+1)] %;\
	/endif %;\
       /getnode %nextpt %;\
       /let nextpt=%value %;\
       /iskey fromidx %lastpoint%;\
       /if (value=~error) /let mw=%;/_getali %lastpoint%;/echo Knoten %value hat keine Ausgaenge!%;/break%;/endif %;\
       /iskey toidx %nextpt %;\
       /if (value=~error) /let mw=%;/_getali %nextpt%;/echo Knoten %value nicht erreichbar!%;/break%;/endif %;\
       /if ({#}==1 & nextpt=~lastpoint) /let mw=%;/_getali %lastpoint%;/echo -aB Zyklus: %value <-> %value %;/break%; /endif %;\
       /go2 %lastpt %nextpt %;\
       /if (min_steps=~max_way_length) /break 10 %; /endif %;\
       /let ms=$[ms+min_steps] %;\
       /let off=$[strstr(min_way,":")] %;\
       /let mw=$[strcat(mw,substr(min_way,off+1),":")] %;\
       /if (regmatch(strcat(":",lastpoint,":"),min_way)==1) /let mw=%;/echo -aB Zyklus %;/break%; /endif %;\
       /let lastpt=%nextpt%;\
    /done %;\
    /if (mw!~"") \
      /let mw=$[substr(mw,0,strlen(mw)-1)] %;\
      /set min_way=$[strcat(lastpoint,":",mw)]%;\
      /set min_steps=%ms%;\
;/profile go%;\
      /go_way %nextpt %;\
    /endif %;\
  /endif%;

; /go ziel
/def go2 = \
	  /set min_way= %;\
	  /set min_steps=%max_way_length %;\
	  /iskey toidx %2 %;\
	  /if (value=~error) /echo Zielpunkt unbekannt! %;\
	  /else \
	    /getoftenusedway %1 %2 %;\
	    /if ({value}=~error) \
	      /find2 %1 %2%;\
	    /endif %;\
	  /endif %;

/def check_way_cache = \
;	/echo %*%;\
	/hgetentrylist ways_cache $[strcat({1},"_",{2})]%;\
	/set check_way_cache=%value%;\
	/getdlistvalueof check_way_cache $[strcat({1},"_",{2})]%;\
        /set cached_way=0%;\
	/while (value!~error) \
	  /set cache_entry=%value%;\
	  /getvalueof cache_entry dim%;\
;	  /if (value=~"b" | value=~dimension) \
	  /if (same_dimension(value)) \
	     /getvalueof cache_entry allow%;\
	     /if (expr(value)) \
		/set cached_way=1%;\
	        /getvalueof cache_entry steps%;\
                /set min_steps=%value%;\
	        /getvalueof cache_entry way%;\
	        /set min_way=$[substr(value,1,strlen(value)-2)]%;\
	        /result 1%;\
	     /endif%;\
	  /endif%;\
	  /getdlistvalueof check_way_cache $[strcat({1},"_",{2})]%;\
	/done%;\
	/result 0%;

; speichert gefundene Wege in often2 zwischen
/def rem_find2 = \
     /getvalueof often2 $[strcat({1},"_",{2})] %;\
     /if (value=~error) \
        /find5 %* %;\
        /if (min_way!~"") \
           /addtolist often2 $[strcat({1},"_",{2})] %min_steps %min_way %;\
        /endif %;\
     /else /setminwaysteps %value %;\
     /endif %;

/def find2 = \
     /if (!check_way_cache({1},{2})) \
;	/echo find5%;\
        /find5 %* %;\
     /endif %;

/addh info \
Schaltet die Portale aus. Loescht die Liste zwischengespeicherter Wege.
/addh see portale, dimensionen, para, nopara, port
/addh var portals
/addh noport comm
/defh noport = \
        /set portals=0 %;\
	/_echo Keine Portale nutzen%;\
;        /createlist often2 %;

/addh info \
Schaltet die Portale ein. Loescht die Liste zwischengespeicherter Wege.
/addh see portale, dimensionen, para, nopara, noport
/addh var portals
/addh port comm

/defh port = \
        /if (p_state!~"seher") \
	   /echo -aCred Status ist nicht auf Seher, Portale werden trotzdem eingeschaltet%;\
	/endif%;\
        /set portals=1 %;\
	/_echo Portale aktiv%;\
;        /createlist often2 %;
;/port

/addh info \
Da die Portale in einem Wegesystem eine grosse Zeitersparnis bringen, werden sie auch extra behandelt. Es gibt einen Befehl zum Ein- und Ausschalten der Portale.@{N}\
Ausserdem gibt es einen Spezialknoten namens 'tport' (bzw. %portal_node), der das naechstgelegene Portal bezeichnet, und von dem aus nur die Portale funktionieren.
/addh comm port, noport
/addh var portals
/addh see Spezialknoten, Wege
/addh portale see

/addh info \
Da es neben der Normalwelt auch noch die Parawelt gibt und einige Weg dort \
nicht und andere nur dort funktionieren, ist die Einschraenkung Dimension \
mit in das Wegesystem integriert worden. @{N}\
Gueltige Werte dafuer sind (b)eide (n)ormal (p)arawelt, ([0-9]).Parawelt@{N}\
Bei der Wegeingabe kann so ein Weg entsprechend gekennzeichnet werden und \
diese Wege werden dann auch entsprechend beruecksichtigt.
/addh var dimension
/addh see para, nopara, ao, ways, wegeingabe, editway
/addh dimensionen see

/def dimension = \
  /if ({#}==1) \
    /let param=%1%;\
  /else /let param=%dimension%;\
  /endif%;\
  /return {param}=~"b" ? -1 : {param}=~"n" ? 0 : {param}=~"p" ? 1 : {param}%;\

/def same_dimension = \
     /return dimension({1})==-1 | dimension()==dimension({1})
  
/addh info \
Schaltet die aktuelle Dimension auf Parawelt um.
/addh see dimensionen, nopara, ways, editway, portale 
/addh var dimension
/addh wpara comm
/defh wpara = \
	/set dimension=$[{#}? dimension({1}) : 1]%;\
	/if (dimension!/"[0-9]") /echo -aCred Fehler beim Setzen der Dimension auf %1 -> dimension%; /break%; /endif%;\
	/if (mapper==1) /map opt para $[dimension>0 ? 1 : 0]%; /endif%;\
	/show_dimension

/addh info Farbige Anzeige der Dimension
/addh show_dimension mak

/def show_dimension = \
	/set dimension=$[dimension()]%;\
	/if (dimension>0) \
	/echo -aCred -p Parawelt @{B}%dimension@{n} gesetzt!%;\
	/else \
	/echo -aCgreen Normalwelt gesetzt!%;\
	/endif%;\

/addh info \
Schaltet die aktuelle Dimension auf Normalwelt um.
/addh see dimensionen, para, ways, editway, portale 
/addh var dimension
/addh nopara comm

/defh nopara = \
      /wpara 0

/addh info \
Fuehrt die Berechnung genauso wie /go aus und zeigt den Ergebnisweg komplett an. Der Weg wird nicht ausgefuehrt, aber trotzdem in den Cache geschrieben, so dass bei einem nachfolgenden /go sofort losgelaufen wird.
/addh see go
/addh ex /testway gilde
/addh syn /testway zielknoten
/addh testway comm

/def testway = \
	/set test_way=1%;\
	/_go %*%;

/addh info \
Erstellt aus der Abfolge der Knoten den eigentlichen Weg, testet ggf. ueber 'askway', ob man den Weg gehen will, geht zum letzten bekannten Knotenpunkt und startet von dort aus das Ablaufen des Weges. Vorher wird noch der Ultrakurzmodus  mittels ?mud_shortest_output eingeschaltet und vor dem letzten Befehl im Weg der Kurzmodus (?mud_short_output) eingeschaltet. 
/addh var askway, min_way, real_way, temp_way, min_steps, fulldetail, verify
/addh mak go_way3, gobk
/addh go_way mak
/def go_way = \
        /if ((min_way!~"")&(min_steps<max_way_length)) \
;	/echo go_way go=1%;\
	  /set go=1%;\
;	  /set go%;\
           /create_way %min_way %;\
; den letzen wegebefehl (xtramoves) suchen und das kurz davorhaengen
	   /if (real_way=~"") /break%; /endif%;\
           /let off=$[strrchr(substr(real_way,0,strlen(real_way)-1),";")+1]%;\
;	   /echo $[strcat(substr(real_way,off-2,1),";",substr(real_way,off,1))]%;\
	   /while (off>0 & (substr(real_way,off-2,1)!~"%" | substr(real_way,off,1)=~"/")) \
 	     /let off=$[strrchr(substr(real_way,0,off-1),";")+1] %;\
;	   /echo $[strcat(substr(real_way,off-2,1),";",substr(real_way,off,1))]%;\
	   /done%;\
           /let part1=$[substr(real_way,0,off)] %;\
           /let part2=$[substr(real_way,off)] %;\
           /set real_way=$[strcat(part1,"/cw /std_walk_mode 1%;",part2)] %;\
;/echo %real_way %;\
	  /if ((askway|test_way)&(echo(real_way))&(test_way | ext_read("Weg laufen? [n] ")!~"")) /if (test_way) /toggle test_way%; /endif%; /break %; /endif %;\
           %mud_shortest_output%;\
           /set fulldetail=%;\
           /set verify=0 %;\
           /let off=$[strrchr(substr(min_way,0,strlen(min_way)),":")] %;\
           /let part1=$[substr(min_way,off+1)] %;\
           /let part1=$[substr(part1,0,strlen(part1))] %;\
	   /set temp_way=%real_way %;\
            /set base_real_way=%real_way%;\
	   /set go_way3_param=%part1 %old_gonumber %;\
;	/echo go_way go=1%;\
	   /set go=1%;\
	   /set show_grabbed=0%;\
           /go_way3 %go_way3_param %;\
        /endif %;
;	/set go=0%;


/addh info \
Nach einer Unterbrechung fuehrt /continue oder kurz /c den Weg entweder \
weiter oder geht zum letzten Knoten zurueck. Es wird vorher wieder mit 'mud_shortest_output' in den Ultrakurzmodus geschaltet.
/addh see wegeingabe 
/addh continue comm
/defh c = /continue%;
/defh continue = /set go=1%; /if (verify==0) %mud_shortest_output%; /set show_grabbed=0%; /endif%;/cont_way %;

/addh info \
Geht den unterbrochenen Weg weiter. MUSS von eigenen Makros ausgefuehrt werden, nachdem sie ihre Funktion erfuellt haben.
/addh mak go_way3
/addh var go_way3_param
/addh see continue, wegeingabe
/addh cont_way mak
/def cont_way = /if (go==1) /go_way3 %go_way3_param%; /endif%;

/addh info \
Loescht die Prompts der letzten Befehle an das Mud, so dass ein aktueller \
Einlesetrigger, der die Ausgaben des Muds liest, nur noch die des letzten \
Befehls bekommt (ueber ?mud_recognize_command).
/addh see wegeingabe, mud_recognize_command
/addh var mud_recognize_command 
/addh syn /klp naechstes Makro mit Parametern
/addh klp mak
/def klp = /killlastprompts %* %;

;/def killlastprompts = /add_catchup_action %*

/def killlastprompts = \
; anpassen
    %mud_recognize_command%;\
    /def -1 -mregexp -agCgreen -t"%mud_recognize_output" -p200 t_klp = \
    /def -1 -mglob -q -h"PROMPT >*" -p200 t_klp2 = %*%;

/def rem=\
    /set nextmakro=/klp2 %* %;\
    /set fulldetail= %;\
    /def_psave_trig %;\
    /def_psave3_trig %;

/def klp2 = \
; damit die Prompts der vorangegangenen Kommandos abgefangen werden
; anpassen
    /if (regmatch(mud_recognize_output,fulldetail)) \
	/set fulldetail=%;\
	/eval -s0 %* %;\
    /else \
    /set nextmakro=/klp2 %* %;\
    /set fulldetail= %;\
    /def_psave_trig %;\
    /def_psave3_trig %;\
    /endif %;

/addh info \
In den Wegen koennen ja beliebige Makros enthalten sein. Ein paar nuetzliche sind schon vorhanden.
/addh see lwo, npc, von, voff, wait, tri, utri, stop, continue, cw, cond_stop, cond_go, no_cond_go, break_tri, do_tri
/addh wegmakros see

/addh info \
Wartet, bis der richtige Raum errreicht ist, und macht dann /wo. 
/addh see wegeingabe
/addh lwo mak
/def lwo = /klp /wo %;

/addh info \
Testet, ob ein NPC im Weg steht. Wenn ja, haelt es an. Mit /continue geht es \
dann weiter. Da es 'verify' einschaltet, muss nach dem kritischen Befehl das \
verify mit /voff wieder ausgeschaltet werden. 
/addh see wegeingabe, von, voff 
/addh var verify
/addh mak klp
/addh npc mak
/def npc = /von 2 %*

/def npcc = \
     /set verify_count=%{1-1}%;\
     /shift%;\
     /von 2 %*%;

/def std_walk_mode = \
	/if ({#}>0 & walk_mode!~mud_shortest_output) \
	   /set show_grabbed=1%;\
	/else \
	   /set show_grabbed=0%;\
	/endif%;\
	%{std_walk_mode-%mud_short_output}%;\
;	/cont_way%;

/addh info \
Schaltet 'verify' ein, d.h. bis /voff kommt wird, jeder Befehl auf Erfolg \
getestet. Wenn einer nicht erfolgreich ist, wird das mit der \
entsprechenden Fehlermeldung angezeigt. Mit dem Parameter 2 reagiert es \
so wie /npc. Nach dem kritischem Abschnitt muss verify mit /voff wieder \
ausgeschaltet werden. 
/addh see wegeingabe, von, voff 
/addh mak klp, cont_way
/addh var verify
/addh syn /von [2]
/addh ex fuer einen Weg: n%;/von%;zu testender Schritt%;/voff%;s%;
/addh von mak

/def von = \
;	   /set walk_mode%;\
;	   /set keep_mode=%walk_mode%;\
;	   /if (walk_mode=~mud_short_output) \
;	     /set keep_mode=1%;\
;	   /else /set keep_mode=0%;\
;	   /endif%;\
	   %mud_short_output%;\
	   /klp /von2 %{*-1}%;

/def von2 = \
     /if (verify_count<0) /set verify_count=1000%; /endif%;\
     /set verify=%1%;\
     /set verify_error_actions=%-1%;\
     /cont_way%;

/addh info \
Schaltet 'verify' aus. Danach werden alle Kommandos ohne Ueberpruefung ausgefuehrt.
/addh see wegeingabe, von
/addh var verify
/addh mak cont_way
/addh voff mak

/def voff = \
  /set_voff%;\
  /cont_way %;

/def set_voff = \
  /if (!show_grabbed) \
    %mud_shortest_output%; \
  /endif%; \
  /set show_grabbed=0%;\
  /set verify=0%;\
  /set verify_count=-1%;\
  /set verify_error_actions=%;\
  /set check_output=%;\


/addh info \
Fuehrt seinen Parameter aus und setzt dann den Weg fort.
/addh syn /cw Befehl
/addh mak cont_way
/addh cw mak
/def cw = \
	/eval %* %;\
	/cont_way %;

/addh info \
Wartet die angegebene Zahl Sekunden, bis der Weg weiter ausgefuehrt wird, und fuehrt ggf. das angegebenen Kommando aus. /wait kann benutzt werden, um im Zusammenhang mit /cond_go vor jedem Wegschritt eine Pause einzulegen (/cond_go /wait sekunden).
/addh syn /wait sekunden [kommando]
/addh mak cont_way
/addh see cond_go, no_cond_go
/addh wait mak

/def wait = \
	/if ({#}>1) /repeat -%1 1 %{-1}\%;/cont_way%;\
	    /else /repeat -%1 1 /cont_way%;\
	    /endif%;

/addh info \
Wenn innerhalb eines Weges angewandt, wird das Kommando gesetzt, das vor jedem Mud-Wegbefehl ausgefuehrt wird. Es kann z.B. zum Ueberpruefen komplexer Bedingungen in einem Gebiet genutzt werden, oder mit /wait zum Setzen einer Pause vor jedem Wegebefehl. Mit /no_cond_go wird dieser Modus wieder aufgehoben. Fuer die Kommandos, die mit /cond_go gesetzt werden, gelten folgende Bedingungen:@{N}\
* Der uebergebene Wegebefehl muss im Erfolgsfall ausgefuehrt werden.@{N}\
* Das Makro muss im Erfolgsfall mit /cont_way beendet werden, damit der Weg fortgesetzt werden kann.@{N}\
* Bei Komplettabbruch des Weges muss die Variable ?go auf 0 gesetzt werden.
/addh ex /def check = /echo naechster Befehl %*%;/cw%; /cond_go /check@{N}\
'/cond_go /wait 4' wartet vor jedem Wegebefehl 4 Sekunden
/addh var cond_go
/addh see wait, no_cond_go
/addh cond_go mak

/def cond_go = /set cond_go=%*%;/cont_way%;

/addh info \
Setzt den mit /cond_go gesetzten Befehl zurueck.
/addh no_cond_go mak
/def no_cond_go = /set cond_go=%;/cont_way%;

; Forderung: Makros muss Wegebefehl selbst ausfuehren und am Ende des aufgerufenen Makros !/cont_way /set go=0, fuer Komplettabbruch des Weges.
 
/addh info \
Haelt den Weg an. Er kann dann mit /continue fortgesetzt werden. Es wird der Kurzmodus (?mud_short_output) eingestellt und eine Meldung ausgegeben.
/addh stop mak
/def stop = /std_walk_mode%;/echo Stopped! (/continue)

/addh info \
Wenn die Bedingung erfuellt ist, wird an der Stelle der Weg angehalten und kann dann mit /continue fortgesetzt werden.
/addh syn /cond_stop bedingung
/addh ex /cond_stop 1==0 oder /cond_stop party (true, wenn party gesetzt und ungleich 0)
/addh mak cont_way
/addh cond_stop mak
/def cond_stop = /test %{*}%; /if (!{?}) /cont_way%; /else /std_walk_mode%; /echo Stopped ({*}) !%; /endif%;

/def golp = 	\
;	/listvar *count%;\
	/set cond_go=%;\
;	/no_cond_go%;\
	/if (!no_prompts) \
	  /add_catchup_action /lp2 %1\%;/set go=1\%;/set node_offset=%{2-0}%;\
	/else \
	  /lp2 %1%;/set go=1%;/set node_offset=%{2-0}%;\
	/endif%;\
;	/set prompt_action%;\
	/cont_way%;

/addh info \
Fuehrt den angegebenen Weg aus. Dabei werden die integrierten Sonderbefehle bzw. die eigenen Makros entsprechend beruecksichtigt. Beim Wegablaufen mit Ueberpruefung wird auf die Fehlerausgaben des Muds (?mud_blocking_output) getriggert. Wenn Prefixmakros innerhalb der Wege angegeben sind, werden sie vor jedem Mud-Befehl ausgefuehrt.
/addh var fulldetail, way_Trig, last_comm, nextmakro, mud_blocking_output
/addh mak bug_way, def_psave_trig, def_psave3_trig
/addh go_way3 mak
/def go_way3 = \
; anpassen
;	/echo anfang: $[substr(real_way,15)]%;\
;	/if (verify!=0) /set walk_mode%;/set fulldetail%; /endif%;\
;/set verify%;\
;/set fulldetail%;\
;      /if (verify!=0) \
;/echo c: %verify_count V: %verify %fulldetail%;\
;     /endif%;\
        /if (verify!=0 & --verify_count<-1) /set_voff%; /endif%;\
        /if (verify!=0 & ((verify<3 & fulldetail!~"" & !regmatch(mud_exits_output,fulldetail) & !regmatch(mud_darkness,fulldetail)) | verify==3 & regmatch(check_output,fulldetail))) \
           /bug_way %go_way3_param%;\
           /break %;\
	/else \
	/if (verify!=0 & show_grabbed & walk_mode!~mud_shortest_output) \
	  /echo2 -p %fulldetail%;\
	/endif%;\
          /if (real_way!~"") \
;	/echo go_way3 go=1%;\
	/set go=1%;\
	/let local_steps=0%;\
;/set go%;\
             /let off=$[strstr(real_way,"%;")] %;\
             /let comm=$[substr(real_way,0,off)] %;\
;/let comm%;\
             /set real_way=$[substr(real_way,off+2)] %;\
	     /set gone_steps=$[gone_steps+1]%;\
	     /test ++local_steps%;\
;/set gone_steps%;\
	     /set last_comm=%comm%;\
	     /set value=1%;\
;	     /set wayTrig=0 %;\
	     /set br=0%;\
;	       /if (check_prompt_action(local_steps)) \
;	          /set br=3%;/set br%;\
;	       /endif%;\
;/set cond_go%;\
	     /while ((cond_go=~"")&(substr(comm,0,1)!~"/")&(verify==0)&(br==0)) \
;/echo in while loop %comm%;\
               /eval -s0 -- %comm %;\
               /let off=$[strstr(real_way,"%;")] %;\
               /let comm=$[substr(real_way,0,off)] %;\
               /set real_way=$[substr(real_way,off+2)] %;\
	       /set gone_steps=$[gone_steps+1]%;\
	       /test ++local_steps%;\
;/set gone_steps%;\
;	       /if (check_prompt_action(local_steps)) \
;	          /set br=3%;/set br%;\
;	       /endif%;\
               /set last_comm=%comm%;\
               /set value=1%;\
	       /if (comm=~"" & real_way=~"") \
	         /if (no_prompts) \
	            /done_go %1%;\
	         /else \
		  /add_catchup_action /done_go %1%;\
	         /endif%;\
	       /return%;/endif%;\
	     /done%;\
	     /if (substr(comm,0,1)=~"/") /set br=1 %; /endif %;\
	     /if ((verify!=0)|(cond_go!~"")|(br!=0)) \
;	       /echo before golp %comm%;\
;	       /if (regmatch("^/golp (.+)$",comm)) \
;		  /echo lp2 %P1%;\
;/add_catchup_action /lp2 %P1\%;/set go=1%;\
;	          /lp2 %P1 %; \
;		  /let comm=%; /set br=0%; /set cond_go=%; \
;	       /elseif (substr(comm,0,1)=~"/") /set br=1 %; /else /set br=0 %;\
; ? Nur fuer Wegebefehle
;	/echo go_way3_2 go=1%;\
	/set go=1%;\
;/set go%;\
	       /if (br!=1 & cond_go!~"") \
	          /let comm=%cond_go %comm%;\
		 /set nextmakro=/go_way3 %go_way3_param %;\
	       /endif%;\
;/echo br %br comm %comm%;\
               /eval -s0 -- %comm %;\
	       /if (verify!=0) \
		 /set nextmakro=/go_way3 %go_way3_param %;\
		 /set fulldetail=%;\
		 /def_psave_trig%;\
		 /def_psave3_trig%;\
	       /else \
		 /if (br==0) /go_way3 %*%; /endif%;\
	         /if (br==3) \
;	           /let comm%;\
;	           /echo exiting go_way3 %br %;\
	           /if (!no_prompts) \
		     /add_catchup_action /go_way3 %go_way3_param %;\
	           /else \
	             /repeat -1 1 /go_way2 %go_way3_param %;\
	           /endif%;\
	         /endif%;\
	       /endif %;\
	     /endif%;\
	  /else \
;	    /if (go==1) \
	      /if (!no_prompts) \
	      /add_catchup_action /done_go %1%;\
	      /else \
	      /repeat -1 1 /done_go %1%;\
	      /endif%;\
;	    /endif%;\
          /endif %;\
    /endif %;

/def done_go = \
	/if (go!=0) \
	  /set go=0%;\
	  /set show_grabbed=0%;\
	  /echo Done!%;\
	  /done_go_ok %1%;\
;	  /test getpoint("/done_go_ok","/done_go_failed %1")%;\
	/endif%;

/def done_go_failed = \
        /echo -aCred Ziel %1 nicht erreicht oder erkannt! Letzter bekannter Knoten: %showpoint. Knoten %1 wird manuell gesetzt!%;\
	/echo2 -p %fulldetail%;\
	/lp2 %1%; \

/def done_go_ok = \
	/lp2 %1%;\
	/if (after_go!~"") \
	  /repeat -S 1 %after_go%;\
	/endif%;\
	/set after_go=%;\

/addh info \
Definiert einen Regexp-Trigger, der den Weg fortsetzt, wenn er triggert. 
/addh syn /tri regexp
/addh ex /tri (Ein Schiff kommt an\\.) 
/addh see wegeingabe, utri, regexp, do_tri, break_tri
/addh mak cont_way
/addh tri mak
/def tri = \
    /def -1 -t\"%*\" -mregexp wayTrig = /cont_way\%;

/addh info \
Definiert einen Regexp Trigger, der den Weg fortsetzt, wenn er triggert, und zwar mit dem Richtungsbefehl, dessen Px-Nummer als erster Parameter angegeben wird.
/addh ex '/dir_tri 1 Das Schild zeigt nach ([A-Za-z]+), ([A-Za-z]+) und ([A-Za-z]+)'. Dann wird die Richtung, die in der ersten Klammerung steht, als erster Wegebefehl ausgefuehrt.
/addh dir_tri mak

/def dir_tri = \
    /def -1 -t\"%-1\" -mregexp wayTrig = /cw \$[tolower({P%1})]\%;


/addh info So etwas wie ein if Trigger, er versucht das angegebene Kommando auszufuehren, kommt da TriggerTextOk, dann fuehrt er den Weg fort sonst wartet er auf TriggertextNaechsterVersuch und fuehrt dann den Befehl noch einmal aus und fuert den Weg fort. Zb gut geeignet fuer Schiffe,Grossmaeule usw. zum betreten.
/addh syn /do_wait_tri kommando,TriggertextOK,TriggertextNaechsterVersuch
/addh do_wait_tri mak

/def do_wait_tri = \
     /test tokenize(",",{*})%;\
     /def -1 -t"*%T2*" do_wait_tri1 = /purge do_wait_tri2\%;/cont_way%;\
     /def -1 -t"*%T3*" do_wait_tri2 = /purge do_wait_tri1\%;%T1\%;/cont_way%;\
     %T1

/addh info \
Fuehrt den vor der '(' uebergebenen Befehl aus und fuehrt den Weg fort, wenn der Trigger innerhalb der Klammern anspringt.
/addh syn /do_tri befehl(triggertext)
/addh see wegeingabe, utri, regexp, tri, break_tri
/addh mak cont_way
/addh ex /do_tri druecke knopf(Der Aufzug kommt an)
/addh do_tri mak

/def do_tri = \
    /let param=%*%;\
    /let off=$[strstr(param,"(")]%;\
    /if (off>-1) \
;       /msend -w 
	$[substr(param,0,off)]%;\
       /let param=$[substr(param,off)]%;\
    /endif%;\
    /def -1 -t\"%param\" -mregexp wayTrig = /cont_way\%;


; /break_tri (Das kannst Du nicht tun)%;nimm schlaufe%;/voff%;

/addh info \
Testet, ob einer der Befehle, die nach dem /break_tri und vor dem naechsten /voff kommen, dem Triggertext (regexp) entspricht, und bricht dann den Weg ab; ansonsten wird er fortgesetzt.
/addh see wegeingabe, utri, regexp, tri, do_tri, voff
/addh syn /break_tri triggertext%;befehle%;/voff%;
/addh ex /break_tri (Ohne Seil kommst Du hier nicht lang)%;kletter nach unten%;/voff%;
/addh break_tri mak
/def break_tri = \
    /set check_output=%*%;\
    /von 3%;\

/addh info \
Da nicht alle Befehle, die ans Mud geschickt werden, einen Prompt generieren, diese aber benoetigt, wird um festzustellen, ob ein Teilweg schon abgelaufen wurde, zaehlt dieses Makro den Promptzaehler eins hoeher und setzt dann den Weg fort.
/addh see h_action_prompt, cont_way
/addh next_prompt mak

/def next_prompt = /h_action_prompt%;/cont_way%;

/addh info \
Definiert einen Regexp-Trigger, der den Weg fortsetzt, wenn er triggert. Dieser Trigger macht zuerst ein %mud_look_command, um ggf. schon im Raum befindliche Dinge festzustellen. Daher ist es am besten, den Trigger mit einer zweiteiligen rexexp zu versehen. 
/addh syn /utri regexp
/addh ex /utri (Ein Schiff\\.|Ein Schiff kommt an\\.) 
/addh see wegeingabe, tri, regxexp
/addh utri mak
/def utri = \
    /tri %*%;\
; anpassen
    %mud_look_command %;

/addh info \
Wird ausgefuehrt, falls bei der ueberprueften Wegausfuehrung ein Fehler aufgetreten ist.@{N}\
Wenn verify=1 ist, wird gefragt, ob der Weg zwischen dem letzten und dem naechsten Knoten temporaer gesperrt werden soll. Es wird versucht, den Rueckweg zum letzten bekannten Knoten zu berechnen. Dieser kann dann mit /back zurueckgegangen werden. Ansonsten muss das Hindernis beseitigt werden und dann kann mit /c[ontinue] der Weg fortgesetzt werden.@{N}\
Ist verify==2, dann wird nur das Monster geknuddelt, das im Weg steht, und nach der Beseitigung ;) wird mit /c[ontinue] weitergegangen.
/addh var verify, fulldetail, real_way, temp_way, go_way3_param, online
/addh mak disable, vorwaerts
/addh version 1.01
/addh bug_way mak
/def bug_way = \
	/set go=0%;\
	/if (verify!=2) \
	  /echo -e Fehler bei der Wegausfuehrung! (weiter mit /c zurueck mit /back) %;\
	  /echo2 -p -e -aCred Errortext: #%fulldetail# %;\
	/elseif (verify==2) \
	  /echo -aB Monster im Weg! (weiter mit /c zurueck mit /back) %;\
; anpassen
	  /echo2 -p -e -aCred $[substr(fulldetail,4)] %;\
	  %mud_show_npc%;\
	/endif %;\
	/if (verify_error_actions!~"") \
	   /echo -aCyellow Ausfuehren der Aktionen: %verify_error_actions%;\
	   /eval %verify_error_actions%;\
	/endif%;\
	/std_walk_mode%;\
        /set value=-1%;\
        /set fulldetail=%;\
        /set real_way=$[strcat(last_comm,"%;",real_way)] %;\
	/set last_comm=%;\
        /let from=%lastpoint %;\
        /if ((regmatch(strcat("(^|:)",from,":([^:]+)"),min_way))) \
           /let to=%P2 %;\
	  /if (verify==1) \
           /_show_way %from %to %;\
           /if (shread("den misslungenen Weg temporaer sperren(j/[n])?")=/"j") \
	      /getali %from%; /let afrom=%value%;\
	      /getali %to%; /let ato=%value%;\
              /_disable %from %to %;\
	      /echo2 -p Weg von %afrom nach %ato temporaer gesperrt. @{N}Entsperren mit /enable %afrom %ato%;\
	   /endif%;\
	  /endif%;\
; Rest des Weges im Gesamtweg suchen
; NEU
; aktuelles Teilstueck
;/set base_real_way%;/set real_way%;\
	      /let off=$[strstr(base_way,strcat("/golp ",lastpoint))] %;\
	      /if (off==-1) /let treal_way=%base_way%;\
	      /else \
	         /let treal_way=$[substr(base_way,off)]%;\
	         /let off=$[strstr(treal_way,"%;")] %;\
	         /let treal_way=$[substr(treal_way,off+2)]%;\
	      /endif%;\
;
	      /let off=$[strstr(base_real_way,strcat("/golp ",lastpoint))] %;\
	      /if (off==-1) /let treal_way1=%base_real_way%;\
	      /else \
	         /let treal_way1=$[substr(base_real_way,off)]%;\
	         /let off=$[strstr(treal_way1,"%;")] %;\
	         /let treal_way1=$[substr(treal_way1,off+2)]%;\
	      /endif%;\
;/let treal_way1%;\
	      /let treal_way1=$[substr(treal_way1,0,strlen(treal_way1)-strlen(real_way))]%;\
; hinter /golp
;/let treal_way1%;\
	      /let off=$[strstr(treal_way,treal_way1)]%;\
;/echo offset: %off%;\
	      /let treal_way=$[substr(treal_way,0,strlen(treal_way1)+off)]%;\
; /let treal_way%;\
;/break%;\
;	      /let step_count=$[node_offset+gone_steps]%;\
;/echo %node_offset %gone_steps %step_count%;\
;	      /let treal_way_old=%treal_way%;\
;	      /let treal_way=%;\
;	      /while (--step_count>=0) \
;		/let off=$[strstr(treal_way_old,"%;")]%;\
;	        /let treal_way=$[strcat(treal_way,substr(treal_way_old,0,off+2))]%;\
;		/let treal_way_old=$[substr(treal_way_old,off+2)]%;\
;	      /done%;\
;	      /vdebug treal_way%;\
;	      /vdebug treal_way_old%;\
; END NEU
;	      /let off=$[strstr(temp_way,real_way)] %;\
; schon gegangenen Weg holen
;	      /let treal_way=$[substr(temp_way,0,off)] %;\
; bis zum vorherigen Knoten
;	      /let off=$[strstr(treal_way,"/golp")] %;\
;	      /while (off>-1) \
;	        /let treal_way=$[substr(treal_way,off)] %;\
;		/let off=$[strstr(treal_way,"%;")] %;\
;		/let treal_way=$[substr(treal_way,off+2)] %;\
;	        /let off=$[strstr(treal_way,"/golp")] %;\
;	      /done %;\
	      /if (mapper) \
	         /let bug_way_mapper=%treal_way%;\
	         /send -wmapper go %afrom%;\
	         /let off=$[strstr(bug_way_mapper,"%;")]%;\
	         /while (off>-1) \
	            /let bug_way_mappercomm=$[substr(bug_way_mapper,0,off)]%;\
	            /if (bug_way_mappercomm!/"/*") \
	              /send -wmapper %bug_way_mappercomm %;\
	            /endif%;\
	            /let bug_way_mapper=$[substr(bug_way_mapper,off+2)]%;\
	            /let off=$[strstr(bug_way_mapper,"%;")]%;\
	         /done%;\
	      /endif%;\
              /reverse %treal_way%;\
	      /set saved_waybk=$[strcat({mud_shortest_output},"%;",value,{mud_look_command},"%;","/lp ",from,"%;")]%;\
;	      /set go_way3_param=%from %2%;\
;           /endif %;\
	/endif%;

/addh info \
Wegstuecken koennen temporaer gesperrt werden. Das kann von Hand mittels /disable erfolgen, oder wenn bei der Ausfuehrung eines Weges ein Fehler auftrat.
/addh see disable, enable, verify
/addh sperren see

/addh info \
Diese Liste enthaelt die temporaer (wird nicht gespeichert) gesperrten Wegstuecke in der Form Anfangsknoten_Endknoten.@{N}\
Der dazugehoerige Befehl testet, ob die angegebenen Wegstuecken gesperrt sind.
/addh see enable, disable, go, sperren
/addh syn $(/disabled Knoten1 Knoten2)
/addh return ueber /echo - 0 bei nicht gesperrt, ansonsten 1
/addh disabled mak
/createlist disabled
/def disabled = \
        /getvalueof disabled $[strcat({1},"_",{2})] %;\
        /if (value=~error) /echo 0 %; /else /echo 1 %; /endif %;

/addh info \
Damit werden Wegstuecke temporaer gesperrt.
/addh syn /disable Anfangsknoten Endknoten 
/addh see enable, go, disabled, sperren
/addh list disabled
/addh disable comm
/defh disable = \
	/getnode %1 %;\
	/let part1=%value%;\
	/getnode %2 %;\
	/_disable %part1 %value %;

/def _disable = \
	/remove_from_cache %1 %2 %;\
        /addtolist disabled $[strcat({1},"_",{2})] %;

/def rem_remove_from_cache = \
	/if ({#}==2) /let to_remove=:%1:%2:%;\
	/else \
	/let to_remove=:%*:%;\
	/endif%;\
	/reggetidxofvalue ways_cache %to_remove %;\
	/while (value!~error) \
	   /delikeyandvalue ways_cache %value %;\
	   /reggetidxofvalue ways_cache %to_remove %;\
	/done %;\

;/createlist ways_cache
;/hloadlist %ways_location ways_cache

/addh info \
Der Wegecache speichert die bisher gelaufenen Wege, so dass sie kein zweites Mal berechnet werden muessen. Dabei werden alle Bedingungen (Para/Normalwelt und die Bedingungen im Weg) mit den zur Berechnung aktuellen Werten mit im Cache aufgenommen. Wenn kein Weg gefunden wird, der mit den aktuell gueltigen Werten berechnet wurde, wird er neu berechnet, ansonsten aus den Infos im Cache erzeugt.@{N}\
Der Cache wird beim Ausfuehren von /editway, /delway, /delnode, /addway usw. aktualisiert.
/addh see show_cache, remove_from_cache, clear_cache
/addh ex hier mal ein Beispiel fuer einen Cacheeintrag:@{N}\
-- neander_tpv:@{N}\
start: neander@{N}\
end: tpv@{N}\
steps: 35@{N}\
way: neander:neanderu:tdrachen:tport:tpv@{N}\
dim: n@{N}\
allow: (portals==1)&(p_state=/"seher")
/addh cache misc

/addh info \
Zeigt den Inhalt des Wegecaches sortiert an.
/addh see cache, remove_from_cache, clear_cache
/addh show_cache mak

/defh show_cache = \
	/hasortforEach ways_cache k /echolist%;\
	/echolist%;


/addh info \
Loescht den Cache mit den Wegen.
/addh see cache, remove_from_cache, show_cache
/addh clear_cache mak

/defh clear_cache = /hcreatelist ways_cache%;


/defh save_cache = \
	/hsavelist %ways_location ways_cache

/defh load_cache = \
	/hloadlist %ways_location ways_cache

/addh info \
Entfernt alle Wege aus dem Cache, die den angegebenen Knoten oder Teilweg enthalten.
/addh ex '/remove_from_cache knotenname' oder '/remove_from_cache knoten1 knoten2'.
/addh see cache, clear_cache, show_cache
/addh remove_from_cache mak

/defh rem_remove_from_cache = \
;	/timer start%;\
	/if ({#}==2) /let to_remove=:%1:%2:%;\
	/else \
	/let to_remove=:%*:%;\
	/endif%;\
;/let to_remove%;\
	/hquerylist ways_cache kv (q_way!/"*%{to_remove}*")%;\
;	/hshowlist hqueryresults%;\
	/hcreatelist ways_cache%;\
	/hcopylist hqueryresults ways_cache%;\
;	/hforEach ways_cache kv /remove_from_cache2%;\
;	/timer stop%; /echo Zeit %? s.%;

/def remove_from_cache = \
     /clear_cache	

/addh info \
Damit werden temporaer gesperrte Wegstuecke wieder freigegeben.
/addh syn /enable Anfangsknoten Endknoten 
/addh see disable, go, disabled, sperren
/addh list disabled
/addh enable comm
/defh enable = \
	/getnode %1 %;\
	/let part1=%value%;\
	/getnode %2 %;\
	/_enable %part1 %value %;
/def _enable = \
        /deletekeyandvalue disabled $[strcat({1},"_",{2})] %;


/addh info \
Zeigt alle Wege von und zum angegebenen Knoten, oder, wenn keiner angegeben wurde, des aktuellen Knotens an.
/addh see showwway
/addh showways comm

/defh showways = \
	/getnode %{*-%lastpoint} %;\
	/let from=%value%;\
	/showway %from *%;/showway * %from%;

/defh showaddways = \
	/getnode %{*-%lastpoint} %;\
	/let from=%value%;\
	/showaddway %from *%;/showaddway * %from%;

/addh info \
Aus der uebergebenen Abfolge der Wegknoten ermittelt diese Funktion den kompletten Weg.
/addh var real_way
/addh list ways
/addh syn /create_way Anfangsknoten:knoten1:knoten2:...:Endknoten
/addh create_way mak
/def create_way = \
     /set real_way=%;\
     /set base_way=%;\
     /let param=%*%;\
     /let off=$[strstr(param,":")] %;\
     /let npoint=$[substr(param,0,off)] %;\
     /let param=$[substr(param,off+1)] %;\
     /createlist cache_entry%;\
     /addtolist cache_entry start %npoint%;\
     /let create_start=%npoint%;\
     /let create_allow=(portals==%portals)%;\
     /let create_ber=$[dimension("b")]%;\
     /while (param!~"") \
       /let point=%npoint %;\
     /let off=$[strstr(param,":")] %;\
     /if (off>-1) /let npoint=$[substr(param,0,off)] %;\
       /let param=$[substr(param,off+1)] %;\
     /else /let npoint=%param%; /let param=%;\
     /endif %;\
;/echo -e %point -> %npoint %;\
/_getali %point %;\
;/echolist %value %;\
     /~getway %point %;\
     /if (value=~error) \
	   /echo Fehler beim Erzeugen des Wegs zwischen %point und %npoint%;\
	   /set base_way=%;\
	   /set real_way=%;\
	   /break%;\
     /else \
        /let akt_way=%value %;\
        /set temp_list=%akt_way %;\
        /getdvalueof temp_list %npoint %;\
	/let akt_way=%;\
	/while (akt_way=~"" & value!~error) \
;/set value%;\
            /if ((regmatch("([bpn0-9]) ([^ ]+) ([0-9]+) ?(.+)?",value))) \
	         /let ber=%P1%;\
	         /let allow=%P2%;\
	         /let akt_way2=%P4%;\
;                 /if (((ber=~"b")|((ber=~dimension)&(let(strcat("create_ber=",ber)))))& \
                 /if (same_dimension(ber) & \
		      allowed(allow)) \
;/vdebug allowed_expr%;\
;/vdebug create_allow%;\
;/vdebug point npoint%;\
		   /if (dimension(ber)>-1) \
		      /let create_ber=$[dimension(ber)]%;\
		   /endif%;\
		   /if (!cached_way & allowed_expr!~"" & strstr(create_allow,allowed_expr)==-1) \
	              /let create_allow=$[strcat(create_allow,"&",allowed_expr)]%;\
		   /endif%;\
                   /let akt_way=%akt_way2 %;\
;	           /echo %point -> %npoint %ber, %allow, %akt_way2%;\
		   /test optimize_way(real_way,{point},akt_way)%;\
	           /test real_way:=value%;\
	           /set base_way=$[strcat(base_way,"/golp ",{point},"%;",akt_way)] %;\
	           /break%;\
	         /endif%;\
	    /getdvalueof temp_list %npoint%;\
 	    /endif%;\
	/done%;\
        /if (value=~error) \
	   /echo Fehler beim Erzeugen des Wegs zwischen %point und %npoint%;\
	   /set base_way=%;\
	   /set real_way=%;\
           /break%;\
	/endif%;\
     /endif %;\
	/_getali %point %;\
	/echolist %value %;\
     /done %;\
        /let create_stop=%npoint%;\
	/if (!cached_way) \
	/addtolist cache_entry end %npoint%;\
	/addtolist cache_entry steps %min_steps%;\
	/addtolist cache_entry way $[strcat(":",min_way,":")]%;\
	/addtolist cache_entry dim %create_ber%;\
	/addtolist cache_entry allow %create_allow%;\
	/haddlisttolist ways_cache %{create_start}_%{create_stop} %cache_entry%;\
;	/addlisttolist ways_cache %{create_start}_%{create_stop} %cache_entry%;\
	/endif%;\
	/_getali %npoint %;\
	/echolist %value %;\
	/echolist %min_steps %;\
	/echolist %;\
        /let off=$[strstr(base_way,"%;")] %;\
        /set base_way=$[substr(base_way,off+2)] %;\
;	/set base_way%;\
;	/set real_way%;

/def get_anti_dir = \
      /getkeyofvalue comm_abbr %1%;\
      /if (value=~error) /set value=%1%; /let short=1%; /else /let short=0%; /endif%;\
      /if ({#}==2 & {2}=/"[0-9]") /let short=$[0+{2}]%; /endif%;\
      /getvalueof xtramoves %value%;\
      /if (short) /set value=$[substr(value,2)]%;/return %value%;\
      /else \
      /getvalueof comm_abbr $[substr(value,2)]%;\
      /return strcat(value)%;\
      /endif%;

/def optimize_way = \
;	/echo %{1} : %{2} : %{3}%;\
;	/set res=%{3}%;\
	/if ({1}=~"") \
	  /set value=%{3}%;\
;	  /result strcat(res)%;\
	  /return%;\
	/endif%;\
	/let oldway=%;\
	/test oldway:={1}%;\
	/if (oldway=/"%%;") \
	/let oldway=$[substr({1},0,strlen({1})-2)]%;\
	/endif%;\
	/let newway=%3%;\
;/let oldway%;\
;/let newway%;\
	/let opt_count=0%;\
	/let old_off=0%; /let new_off=0%;\
	/while (old_off>-1 & new_off>-1) \
	/let old_off=$[strrchr(oldway,"%")]%;\
	/if (old_off==-1) /if (strlen(oldway)>0) /let old_off=-2%; /else /break%; /endif%; /endif%;\
	/let new_off=$[strstr(newway,"%;")]%;\
	/if (new_off==-1) /break%; /endif%;\
;	/echo old %old_off new %new_off $[substr(newway,0,new_off)]%;\
	/get_anti_dir $[substr(newway,0,new_off)]%;\
;	/set value%;\
;	/echo old_cmd $[substr(oldway,old_off+2)]%;\
	/if (substr(oldway,old_off+2)=/value) \
	   /let opt_count=$[(0+opt_count)+1]%;\
	   /if (old_off>-1) \
	   /let oldway=$[substr(oldway,0,old_off)]%;\
	   /else \
	    /let oldway=%;\
	   /endif%;\
;	/let oldway%;\
	   /let newway=$[substr(newway,new_off+2)]%;\
;	/let newway%;\
	/else /break%;\
	/endif%;\
	/done%;\
	/set value=$[strcat(oldway,((strlen(oldway)>0)?"%;":""),"/golp ",{2}," ",opt_count,"%;",newway)]%;\
;	/result strcat(oldway,"%%;/golp ",{2}," ",opt_count,"%%;",newway)%;


/def addoftenusedway = \
  /getali %llastpoint %;\
  /let from=%value %;\
  /getali %lastpoint %;\
  /let to=%value %;\
  /echo -p %from -> %to zu den oft genutzen Wegen hinzufuegen(j/[n])? %;\
  /dokey DLINE %;\
  /if (ext_read("hinzufuegen (j/[n])? ")=/"j") \
;        /echo ue(b)erall (n)ormal (p)ara (Gueltigkeitsbereich) %;\
        /let b=$[ext_read("ue(b)erall (n)ormal (p)ara (0-9).Parawelt (Gueltigkeitsbereich) ",dimension)]%;\
        /if (b!/"[bpn0-9]") \
           /echo falsche Eingabe! Abbruch%;\
        /else \
         /let key=$[strcat(llastpoint,"_",lastpoint,"_",b)] %;\
         /addoften %key $[strcat(min_steps," ",min_way)] %;\
         /savelist %ways_location often %;\
       /endif %;\
  /endif %;

; /ad fuegt den zuletzt gegangenen Weg zur Liste der oft genutzeten Wege hinzu
/addh info \
fuegt den zuletzt gegangenen Weg zur Liste der fest gespeicherten Wege hinzu. \
Dabei wird die Dimension des Weges mit abgefragt.
/addh list often
/addh see dimensionen
/addh ao comm
/defh ao = /addoftenusedway %;

/def getoftenusedway = \
  /getoften $[strcat({1},"_",{2},"_",{dimension})] %;\
  /if (value=~error) \
    /getoften $[strcat({1},"_",{2},"_b")] %;\
  /endif %;\
  /if (value=~error) /break %;\
  /else \
    /setminwaysteps %value %;\
  /endif %;

/def setminwaysteps = \
     /set min_steps=%1 %;\
     /set min_way=%-1 %;

/addh info \
Die Einschraenkungen fuer die Wege sind wie folgt anzugeben:@{N}\
all - keine Einschraenkungen.@{N}\
spielername - nur derjenige kann diesen Weg benutzen.@{N}\
property:wert - diejenigen koennen den Weg benutzen, deren Properties dem \
angegebenn Wert entsprechen. Dabei reichen die zur Identifikation notwendigen \
Buchstaben (z.B. lev:10 fuer Level > 10); bei numerischen Properties wird \
angenommen, dass der Wert der Property groesser als der angegebene sein \
muss. Ansonsten muessen die Wertangaben mit dem Wert der Property mindestens \
den Anfangsbuchstaben gemeinsam haben. Also aufpassen mit den Wertangaben.@{N}\
logischer Ausdruck mit Properties: Dieser wird einfach ausgewertet, also\
alle Properties ausschreiben und bei der Konstruktion aufpassen.
/addh ex 'lev:10 (level>10)' oder '((p_guild=~"chaos")&(p_guild_level>6))' usw.
/addh see properties, wege, mud_properties
/addh einschraenkungen see

/addh info \
Testet, ob die aktuellen Properties erlauben, diesen Weg zu gehen.
/addh return ueber /echo. 1 bei Erfolg und 0 bei Misserfolg.
/addh see einschraenkungen
/addh allowed mak
/def allowed = \
	/set allowed_expr=%;\
	/if ({*}=~"all") /result 1%; /endif%;\
	/let param=%*%;\
;/echo %param%;\
	/if (strstr(${world_character},param)!=0) \
;	  /echo %param%;\
	  /let off=$[strstr(param,":")]%;\
	  /if (off>-1) \
	    /let key=$[substr(param,0,off)]%;\
;/let key%;\
;	    /reggetkey ${world_character} $[strcat("^",key,"")] %;\
;/echo  %key -> %value%;\
;	    /let key=%value%;\
	    /let allow=$[substr({1},off+1)]%;\
	    /getvalueof ${world_character} %key%;\
	    /if (value!~error) \
	      /if (regmatch("[0-9]+",value)) \
		 /if ((0+value)<(0+allow)) \
		   /result 0%;\
		 /else \
		   /set allowed_expr=(p_%key>%allow)%;\
		   /result 1%; \
		 /endif %;\
	      /elseif (strstr(tolower(value),tolower(allow))!=0) \
		   /result 0%;\
		/else \
	          /set allowed_expr=(p_%key=/"$[tolower(allow)]")%;\
		  /result 1%;\
	      /endif %;\
	    /endif%;\
	  /else \
;	    /test ({*}) %;\
	    /set allowed_expr=(%{*})%;\
	    /result test({*})%;\
	  /endif%;\
	/else \
	  /set allowed_expr=(p_name=~"%param")%;\
	  /result 1%;\
	/endif %;

; Gagtrigger
; anpassen

; Mit /port /noport wird die Benutzung der Portale ein und ausgeschaltet.
; (variable portals)
; Mit /wpara und /nopara wird die Dimension gesetzt (Variable dimension).

; Mit '/enable from to' und '/disable from to' koennen Wegstuecke temporaer 
; (fuer eine Sitzung) gesperrt werden.

; Wenn im Weg ein Wegstueck vorhanden ist, das schrittweise auf Erfolg getestet
; wird, dann bricht die Ausfuehrung an der Stelle ab, an der es nicht
; weitergeht.
; Es kann entweder das Wegstueck temporaer gesperrt werden und mit /continue 
; zum letzten besuchten Wegpunkt gegangen werden, oder das Wegstueck nicht
; gesperrt werden und das Hindernis beseitigt werden und dann mit /continue
; weitergegangen werden.


;/createlist nodealias
; in liste: node#alias
/def _getali = /getvalueof nodealias %1%;\
	/if (value=~error) /set value=%1%;/endif %;

/addh info \
Liefert das Alias zum Knoten; wenn keins vorhanden ist, dann den Knotennamen selbst.
/addh getali mak


/def getali = /_getali %* %;\
	/let getali=@{B}%value@{n}%;\
	/if (alitype!~"short" & alitype!~"" & {#}==1) \
	   /getnode %*%;\
	   /getlistvalueof nodeinfo %value%;\
	   /if (value!~error) \
	      /set getali2=%value%;\
	      /if (alitype=~"long" | alitype=~"info") \
	      /getvalueof getali2 info%;\
	      /if (value!~error) /let getali=%getali %value%; /endif%;\
	      /endif%;\
	      /if (alitype=~"long" | alitype=~"geb") \
	      /getvalueof getali2 gebiet%;\
	      /if (value!~error & value!~"") /let getali=%getali (%value)%; /endif%;\
	      /endif%;\
	   /endif%;\
	/endif%;\
	/set value=%getali%;

/addh info \
Liefert den Knotennamen zum Alias; wenn kein Alias vorhanden ist, wird der Parameter zurueckgegeben.
/addh getnode mak

/def getnode = \
	/if ({1}=/"*\\**") \
	  /let getnode_param=%*%;\
	  /set getnode=%;\
;/let getnode_param%;\
	  /forEach nodealias kv /getnode2%;\
	  /if (getnode=~"") \
	    /if (getnode_list=~"") \
	      /forEach toidx k /getnode2%;\
	    /else \
;/echo $[strcat("( |^)(",replace("*","[^ ]*",getnode_param),")($| )")]%;\
	      /if (regmatch(strcat("( |^)(",replace("*","[^ ]*",getnode_param),")($| )"),getnode_list)) \
		 /set getnode=%P2%;\
	      /endif%;\
	    /endif%;\
	  /endif%;\
	  /set value=%getnode%;\
	/else \
	/getkeyofvalue nodealias %1 %;\
	/if (value=~error) /set value=%1%; /endif %;\
	/endif%;

/set getnode_list=

/def getnode2 = \
	/if ({#}==1) /set getnode_list=%getnode_list %1%;/endif%;\
	/if ({#}==2 & {2}=/getnode_param | {1}=/getnode_param) \
	  /set getnode=%1%;\
	/endif%;


; /setali altesAlias neues Alias
; oder /setali knotenname Alias
/addh info \
Fuer die Wegknotennamen, die beim Erstellen der Wege vergeben wurden, koennen im Nachhinein Aliase vergeben werden, je nach persoenlichem Geschmack. Deshalb bitte die Knotennamen eindeutig und verstaendlich vergeben, damit auch ein anderer was damit anfangen kann.@{N}\
Intern wird trotzdem mit den Knotennamen gearbeitet ;)
/addh see /setali, Knoten
/addh Knotenaliase see

/addh info \
Erlaubt fuer beliebige Wegeknoten Aliase zu vergeben. Die Liste der Aliase wird sofort im Anschluss abgespeichert.
/addh syn /setali zeigt alle Aliase an.\
@{N} '/setali knoten alias' erzeugt das Alias fuer den Knoten.\
@{N} '/setali alias neues_alias' ueberschreibt das vorhandene Alias.\
@{N} '/setali alias' loescht das Alias.
/addh list nodealias, lastpoints
/addh mak forEach, echolist
/addh see Knotenaliase
/addh setali comm
/defh setali = \
	/if ({*}=~"") /echo alle Aliase (Knotenname Alias)%;\
	   /forEach nodealias kv /echolist%;\
	   /echolist %;\
	/else \
	  /loadlist %ways_location nodealias%;\
	  /getkeyofvalue nodealias %1 %;\
	  /if (value!~error) \
	     /let key=%value %;\
	     /deletekeyandvalue nodealias %key %;\
	     /if ({2}=~"") \
	        /echo -p Alias @{B}%1@{n} geloescht! %;\
	     /else \
	       /addtolist nodealias %key %2 %;\
	       /echo -p Alias von @{B}%1@{n} auf @{B}%2@{n} geaendert %;\
	     /endif %;\
	  /elseif ({#}>1) \
	     /iskey toidx %1 %;\
	     /if (value=~error) /iskey fromidx %1%; /endif%;\
	     /if (value!~error) \
	     	/echo -p Fuege neues Alias @{B}%2@{n} fuer Knoten @{B}%1@{n} hinzu %;\
	       /addtolist nodealias %1 %2 %;\
	     /else \
	       /echo -p @{B}%1@{n} ist kein Knotenname %;\
	     /endif %;\
	  /else \
	  /info error Syntax: /setali knotenname aliasname zu Setzen oder /setalias aliasname zum Loeschen!%;\
	  /endif %;\
	/endif %;\
	/savelist %ways_location nodealias %;


; anpassen
/def addxm = /addtolist xtramoves %* %;
/def xaddxm = /xaddtolist xtramoves&%* %;
/def getxm = /getvalueof xtramoves %* %;

/def i_vorw = /input /vorwaerts .%; /dokey BSPC %;
; anpassen

/def def_eval_test =/def -t\"%mud_what_output\" -mregexp -p100 -1 eval_test = \
;	/echo eingegebenes Kommando nicht erfolgreich! \%;\
	/undef eval_hook \%; %;

; anpassen
/def def_eval_hook = /def -1 -q -mglob -h"PROMPT >*" -p100 -F h_eval_hook = \
;	/echo Kommando erfolgreich \%;\
	/undef eval_test %;\
	/vorwaerts2 %;

/defh verify=/if (verify==1) /set verify=0 %; /else /set verify=1 %; /endif %; /set verify %;

/addh info \
Die Wegeingabe muss von einem Knotenpunkt starten, der entweder mit /wo oder mit /lp gesetzt wurde. Es gibt zwei Arten Wege einzugeben:@{N}\
Mit /weg werden alle Kommandos, die eingegeben werden, im Hin- und (sofern es erkennbar ist) auch im Rueckweg abgespeichert.@{N}\
Wenn einfach mit dem Ziffernblock durch die Gegend gewandert wird, werden die Schritte auch mitgeloggt. Spezielle Befehle koennen durch die 0-Taste des Ziffernblocks eingegeben werden. Sofern bekannt. wird auch deren Umkehrung im Rueckweg gespeichert, wenn nicht. wird nach einer gefragt. Diese Befehle werden sofort ausgefuehrt. Mit dieser Taste koennen auch die im Weg enthaltenen Makros eingegeben werden.@{N}\
Wenn man mit dem Weg fertig ist, macht man einfach /end. Sofern man an einem bekannten Knoten steht, wird das erkannt, ansonsten wird man zur Namensverleihung gebeten.@{N}\
Dann wird der Weg abgespeichert (siehe dort).
/addh see weg speichern, weg editieren, weg, end, lp, wo
/addh wegeingabe see

/set weg=0
/addh info \
Speichert ab dem Einschalten @{B}alle@{n} Kommandos im Hin- und (sofern erahnbar) auch im Rueckweg. Ab dem Ausschalten per /weg oder /end dann nicht mehr.
/addh syn einschalten mit /weg und ausschalten mit /weg oder /end
/addh mak vorwaerts
/addh var weg, wegeingabe
/addh hook SEND
/addh see wege, 
/addh weg comm
/defh weg = \
	/toggle weg%;\
	/if (weg) \
	  /echo Ab jetzt wird jede Eingabe zum Weg hinzugefuegt! %;\
	  /echo Ende mit /weg oder /end (zum speichern) %;\
	/else \
	  /echo Wegeingabe beendet! (ggf mit /end abspeichern) %;\
	/endif %;


/addh info \
Ein Send-Hook, der auch als Makro aufgerufen werden kann und die Syntax des ?speedwalk versteht. Er fuegt die expandierten Bewegungen den Wegespeichern des Wegesystems hinzu. Das Besondere ist, dass das Trennzeichen ?movement_marker selbst gesetzt werden kann und dass die Befehle als eine Zeile an das Mud gesendet werden. Das Trennzeichen muss auch vor dem ersten Befehl auftauchen, damit nicht beliebige ans Mud gesendete Strings untersucht werden muessen.
/addh see shorten, customize.tf
/addh ex [/walk ],5o,2n,25 klatsche,ob,schaue
/addh syn regexp: (/walk )?(,([0-9]+)?[^0-9,]+)+
/addh version 1.03
/addh list xtramoves
/addh var movement_marker
/addh changes \
1.03 Der Hook kommuniziert mit der Mapper Application ?mapper.tf, wenn die Variable ?mapper auf 1 gesetzt ist. Wenn %automapper auf 1 gesetzt ist, werden Bewegungen sofort in neue Ausgaenge umgewandelt.@{N}\
	Der Hook wird jetzt erst in der customize.tf definiert, wenn der 'movement_marker' feststeht, damit unnoetige Sufrufe vermieden werden. Susserdem kommen sich so hoffentlich die verschiedenen Send-Hooks nicht mehr in die Quere.@{N}\
1.04 * Einbindung des Mappers (?mapper.tf). Die Befehle, die ans Mud gesandt werden, bekommt auch der Mapper, sofern (%mapper==1). Wenn (%automapper==1) werden dem Mapper zuvor die Befehle zum Erzeugen der Ausgaenge uebermittelt.@{N}\
     * Bug beim Speichern des Rueckweges behoben.
/addh walk comm
/defh walk = \
	   /let comm=%*%;\
	   /let reg=%;\
	   /test reg:=strcat("^",movement_marker,"([0-9]+)?([^0-9][^",movement_marker,"]*)")%;\
	/if (substr(comm,0,1)=~movement_marker) \
	   /let back=%;\
	   /let subst=%;\
;	     /add_action_count -1 walk subtract%;\
	   /while (regmatch(reg,comm)) \
	     /let res=$[strrep(strcat({P2},"%;"),{P1-1})] %;\
	       /n %{P1-1} %{P2}%;\
;	     /add_action_count %{P1-1} walk %{P1-1}x%{P2}%;\
	     /if (icc_s==1) \
  		 /send -wicc $[strrep(strcat("ae ",{P2},char(10),{P2},char(10)),{P1-1})] %;\
	     /endif%;\
	     /if (mapper) \
		/if (automapper) \
  		  /send -wmapper $[strrep(strcat("ae ",{P2},char(10),{P2},char(10)),{P1-1})] %;\
		/else \
		  /send -wmapper $[strrep(strcat({P2},char(10)),{P1-1})] %;\
	       /endif%;\
	     /endif%;\
;	     /msend - %res%;\
	     /let subst=$[strcat(subst,res)]%;\
	     /let comm=%{PR}%;\
	     /getvalueof xtramoves %{P2}%;\
	     /if (value!~error) \
;	       /let back=$[strcat(movement_marker,{P1},substr(value,2),back)]%;\
	       /let back=$[strcat(strrep(strcat(substr(value,2),"%;"),{P1-1}),back)]%;\
	     /endif%;\
	   /done%;\
	   /if (go==0) \
	     /rueckwaerts $[substr(back,0,strlen(back)-2)]%;\
	     /add $[substr(subst,0,strlen(subst)-2)]%;\
	   /endif%;\
	 /else \
;	   /msend - %*%;\
	 /endif%;

/addh info \
Ueberprueft alle Eingaben auf Richtungsbefehle und speichert diese ab.\
Wenn die Wegaufzeichnung eingeschaltet wurde, werden _alle_ Eingaben abgespeichert. Natuerlich wird auch der Rueckweg gleich mit erzeugt.
/addh mak vorwaerts
/addh var weg, wegeingabe
/addh list xtramoves
/addh hook SEND
/addh changes \
1.03 unterstuetzt die Mapper Application (siehe ?walk).@{N}\
1.04 Einbindung des Mappers (?mapper.tf). Die Befehle, die ans Mud gesandt werden, bekommt auch der Mapper, sofern (%mapper==1). Wenn (%automapper==1) werden dem Mapper zuvor die Befehle zum Erzeugen der Ausgaenge uebermittelt.
/addh version 1.04
/addh see wege, hooks
/addh h_move hook

/def -hSEND -q -F h_move = \
	/if (go==0|mapways) \
	/let comm=%*%;\
	/if (substr(comm,0,1)!~movement_marker & ((strlen(comm)<5)|weg)) \
	  /getvalueof xtramoves %comm%;\
	  /let comm_back=%value%;\
	  /if (weg | comm_back!~error) \
	  /if (mapper) \
	      /if (automapper) \
		/send -wmapper - ae %*%;\
	      /endif%;\
	      /send -wmapper - %*%;\
	   /endif%;\
	   /if (!go) \
            /set last_comm=%comm %;\
	    /add %comm%;\
	    /if (comm_back!~error) \
	    /rueckwaerts $[substr(comm_back,2)]%;\
	    /endif%;\
	   /endif%;\
	  /endif%;\
	/endif%;\
	/endif%;

/addh info \
Speichert den angegebenen Wegebefehl im Hinweg. Wenn 'verify' eingeschaltet ist, passiert das nur bei erfolgreicher Ausfuehrung des Befehls. Wenn online eingeschaltet ist, wird der Befehl sofort ausgefuehrt, ansonsten nicht. \
@{N}Wenn der Rueckbefehl bekannt ist, wird er im Rueckweg gespeichert. Dabei kann ggf. nachgefragt werden. Wenn der Rueckbefehl nicht bekannt ist, wird nachgefragt. \
Wenn ein '+' vor dem Befehl steht, wird versucht, ihn und auch den Rueckbefehl zu expandieren ('soob' wird zu 'suedostoben' etc.).
/addh see online, verify, rueckwaerts, wegeingabe
/addh syn /vorwaerts [+]befehle
/addh vorwaerts comm


/defh vorwaerts = \
   /let to=%* %;\
   /if (substr(to,0,1)=~"+") /let to=$(/expand_comm $[substr(to,1)]) %; \
   /endif %;\
   /set last_comm=%to %;\
   /if ((online==1)&(substr(to,0,1)!~"/")) \
     /if (icc_s==1) \
	 /send -wicc $[strrep(strcat("ae ",{P2},char(10),{P2},char(10)),{P1-1})] %;\
     /endif%;\
     /if (verify==1) \
       /def_eval_test %;\
       /def_eval_hook %;\
       /msend %to %;\
;       /add_action_count 1 vorwaerts %to %;\
     /else \
       /msend %to %;\
;       /add_action_count 1 vorwaerts %to %;\
       /vorwaerts2 %;\
     /endif %;\
   /else \
;      /if (regmatch("^/u?tri ",to)==1) /set last_comm=$(/replace . \\\\. %to)%;\
;      /endif %;\
      /vorwaerts2 %;\
   /endif %;	

/def vorwaerts2 = \
   /let to=$[strcat(last_comm)] %;\
   /getxm %to %;\
   /if (to!/"/*" & (value=~error | value=/"1 *")) \
       /add %{to} %;\
   /else \
     /add %{to} %;\
   /endif%;\
   /let i=1%;\
;/echo alle ohne %i %to # %* %;\
   /while ((value=~error)&(to!~"")) \
     /let to=-L%i %;\
     /eval /set tempvw=\%%to %;\
     /let to=%tempvw %;\
;/echo alle ohne %i %to # %* %;\
     /let i=$[i+1] %;\
     /getxm %to %;\
   /done %;\
   /unset tempvw%;\
;/echo xx %value %;\
;   /if (value=~error) /input /rueckwaerts %;\
;   /else \
     /let reg=$[strcat("([0|1]) (.*)$")] %;\
     /if (regmatch(reg,value)) \
       /if ({P1}==0) /rueckwaerts %P2 %;\
       /else \
          /input /rueckwaerts %P2%;\
       /endif %;\
     /endif %;\
;   /endif %;

; anpassen
/addh info \
Liefert den Wert, der in der Liste 'comm_abbr' zum Parameter steht, ansonsten den Parameter selbst.
/addh expand_comm mak
/def expand_comm = \
     /getvalueof comm_abbr %* %;\
     /if (value=~error) /echo %* %; /else /echo %value %;\
     /endif %;

;/createlist lastpoints

/set nextmakro= %;
/addh info \
Ersetzt alle vorhandenen Knotenbeschreibungen durch die des aktuellen Raumes. Wenn der zusaetzliche Parameter Zeilenzahl angegeben wird, wird nur die gewuenschte Anzahl Zeilen gespeichert. Ansonsten wird die Variabel ?addlines beachtet. Wenn die Zeilenzahl 0 ist, wird die komplette Raumbeschreibung bis zu den Ausgaengen gespeichert.
/addh see knoten, appendnode, delnode
/addh var lastpoint, addlines
/addh mak getnode, getali
/addh syn /addnode [knoten [zeilenzahl]]
/addh addnode comm
/defh addnode = \
     /if ({1}=~"") /let anode=%lastpoint %; \
     /else \
        /getnode %1%; \
	/let anode=%value %;\
     /endif %;\
	/_getali %anode %;\
	/echo -p Beschreibung fuer Knoten %value ersetzt %;\
	/iskey lastpoints %anode %;\
	/if (value!~error) /delallkeysandvalues lastpoints %anode %; \
	  /savelist -q %ways_location lastpoints %;\
	/else \
	  /iskey nodeinfo %anode%;\
	  /if (value=~error) \
	    /addnodeinfo %anode%;\
	  /endif%;\
	/endif %;\
	/_addpoint %anode %2%;

/addh info \
Fuegt eine @{B}zusaetzliche@{n} Knotenbeschreibung fuer den aktuellen Raum zur Liste hinzu. Wenn der zusaetzliche Parameter Zeilenzahl angegeben wird, wird nur die gewuenschte Anzahl Zeilen gespeichert. Ansonsten wird die Variabel ?addlines beachtet. Wenn die Zeilenzahl 0 ist, wird die komplette Raumbeschreibung bis zu den Ausgaengen gespeichert.
/addh see knoten, addnode, delnode
/addh var lastpoint, addlines
/addh mak getnode, getali
/addh syn /appendnode [knoten [zeilenzahl]]
/addh appendnode comm
/defh appendnode = \
     /if ({*}=~"") /let anode=%lastpoint %; \
     /else \
        /getnode %1 %; \
	/let anode=%value %;\
     /endif %;\
	/getali %anode %;\
	/echo -p Beschreibung fuer Knoten %value hinzugefuegt %;\
     /_addpoint %anode %2%;

/addh info \
Loescht den Knoten mit all seinen Wegen (mit Abfrage).@{N}\
Vor dem Loeschen werden die Wegelisten neu geladen, um Inkonsistenzen zu vermeiden.
/addh see addnode, appendnode, knoten
/addh var lastpoint
/addh mak getnode, getali, delallkeysandvalues, delway
/addh list lastpoints
/addh syn /delnode [knoten]
/addh delnode comm
/defh delnode = \
	/if ({*}=~"") /let anode=%lastpoint %; \
	/else \
	   /getnode %*%; \
	   /let anode=%value %;\
	/endif %;\
	/_getali %anode %;\
	/if (ext_read(sprintf("Knoten #1 loeschen (j/[n])? ",value))=/"j") \
	  /loadlist %ways_location lastpoints%;\
	  /delallkeysandvalues lastpoints %anode %;\
	  /set nodelist=%;\
	  /savelist -q %ways_location lastpoints %;\
	  /deletekeyandvalue nodeinfo %anode%;\
	  /savelist -q %ways_location nodeinfo %;\
	  /delway %anode *%;\
	  /delway * %anode%;\
	/endif%;

/addh info \
Liest die aktuelle Raumbeschreibung ein, begrenzt sie bis einschliesslich der Ausgaenge und speichert sie in %fulldetail.
/addh var %fulldetail, %getpoint_trig
/addh addpoint mak
;/def addpoint = /_addpoint %* %;
/def _addpoint = \
     /if ({1}=~"") /let this=%lastpoint %; /else /let this=%1 %; /endif %;\
       /trig_grab -Baddpoint_start -Paddpoint_end -ag -C"%mud_look_command" -M"/addpoint2 %this %{2-%addlines}"%;\
       /set getpoint_trig=%?

/def rem = \
       /set fulldetail=%;\
       /def_psave_trig %;\
       /def_psave3_trig %;\
       /set nextmakro=/addpoint2 %this %{2-%addlines}%;\
       %mud_look_command %;

/addh info \
Begrenzt die Raumbeschreibung, die in %fulldetail steht, auf bis einschliesslich der Ausgaenge. Die Variable %room_npcs wird auf den Rest gesetzt.
/addh var mud_exits_output
/addh restricttoexit mak
/def restricttoexit = \
; anpassen
;     /set fulldetail%;\
     /set room_npcs=%;\
; mschau
     /if (regmatch("^(@{N})?[[][^]]+[]]",fulldetail)) \
        /set fulldetail=%PR%;\
     /endif%;\
     /if (regmatch("^@{N}Du schielst durch die Brille und siehst:",fulldetail)) \
        /set fulldetail=%PR%;\
/endif%;\

     /if (regmatch(mud_exits_output,fulldetail)) \
	/let off=$[strrchr({PL},"@")]%;\
	/if (off>-1) \
	   /set room_exits=$[substr({PL},off)]%P0%;\
	   /set fulldetail=$[substr({PL},0,off)]%;\
	/else \
	   /if ({#} & {1}=="noexits") \
	   /set fulldetail=%PL%;\
	   /else /set fulldetail=%PL%P0%;\
	   /endif%;\
	/endif%;\
;        /set fulldetail=%PL%P0%;\
	/set room_npcs=%PR%;\
	/if (strstr(room_npcs,"@{N}")==0) \
	  /set room_npcs=$[substr(room_npcs,4)]%;\
	/endif%;\
     /endif %;

/def addpoint2 = \
;     /echo2 -p %fulldetail %;\
;	/let off=$[strchr(fulldetail,"&")]%;\
;	/let this=$[substr(fulldetail,0,off)]%;\
;	/set fulldetail=$[substr(fulldetail,off+1)]%;\
	/test fulldetail:=strcat("@{N}",fulldetail)%;\
	/restricttoexit%;\
	/let this=%1%;\
	/let lines=%2%;\
 	/if (lines!=0) \
	/let temp_fulldetail=$[substr(fulldetail,4)]%;\
;	/let temp_fulldetail%;\
	/set fulldetail=%;\
	/while (lines>0) \
	   /let off=$[strstr(temp_fulldetail,"@{N}")]%;\
	   /if (off==-1) /let lines=1%; /let off=$[strlen(temp_fulldetail)]%; /endif%;\
	   /set fulldetail=$[strcat(fulldetail,"@{N}",substr(temp_fulldetail,0,off))]%;\
	   /let temp_fulldetail=$[substr(temp_fulldetail,off+4)]%;\
	   /let lines=$[lines-1]%;\
	/done%;\
	/endif%;\
	/loadlist %ways_location lastpoints%;\
;	/deletekeyandvalue lastpoints %this%;\
;	/let this%;\
;	/set fulldetail%;\
       /addtolist lastpoints %this %fulldetail %;\
	/set nodelist=%;\
;	/set fulldetail=$[substr(fulldetail,12)]%;\
;	/let off=$[strchr(fulldetail,"&")]%;\
;	/set fulldetail=$[substr(fulldetail,off+1)]%;\
	/wo_raum%;\
        /savelist -q %ways_location lastpoints %;\
	/if (mapper) /send -wmapper ai ways %this%; /endif%;\
	/lp %this

/addh info \
Zeigt die Raummeldung an, die das letzte, /wo, /end, /wgo, /addnode verarbeitet hat
/addh wo_raum comm

/def wo_raum = \
	/echo2 -aCyellow -p %fulldetail


/addh info \
Erkennt aus der Langbeschreibung, die das Kommando produziert das als erster Parameter \
übergeben wird den Zielraum (wenn bekannt) und geht dorthin. Der zweite Parameter wird \
zur Identifikation der Zeile vor der Raumbeschreibung gebraucht.
/addh goto comm

/def goto = \
   /trig_grab -b%2 -Paddpoint_end -ag -C"%1" \
    -M'/test getpoint2("/_go","/echo Knoten nicht gefunden!")'%;\
   /set getpoint_trig=%?

/addh info \
Erkennt, welcher Knoten der aktuelle Raum ist.
/addh syn /wo
/addh see knoten, knotenaliase
/addh wo comm
/defh wo = /test getpoint("/lp2","/unknown_node %showpoint") %;

/def unknown_node = \
     /echo -p Kein bekannter Knoten! Letzter bekannter Knoten: @{Cred}%1@{n}.%;\
     /if (wo_show_bug) \
       /wo_raum%;\
     /endif%;

/addh info \
Vergleicht die aktuelle Raumbeschreibung mit der Liste 'lastpoints' und liefert ggf. den entsprechenden Raum.
/addh var %getpoint_trig
/addh getpoint mak

/def getpoint = \
       /trig_grab -Baddpoint_start -Paddpoint_end -ag -C"%mud_look_command" -M'/test getpoint2("%1","%{-1}")'%;\
       /set getpoint_trig=%?

/def rem = \
     /def_psave_trig %;\
     /def_psave3_trig %;\
     /set fulldetail= %;\
     /set nextmakro=/test getpoint2("%{1}","%{-1}")%;\
     %mud_look_command %;

/def lookup_lastpoints = \
      /if (getpoint=~"") \
        /set value=%lastpoints%;\
      /else \
        /test value:=\{%getpoint\}%;\
      /endif%;\
      /let char_count=0%;\
      /let res_key=%;\
      /let new_fulldetail=%;\
      /let old_fulldetail=$[substr(fulldetail,4)]%;\
      /let off=$[strstr(old_fulldetail,"@{N}")]%;\
;
	/if (off>-1) \
	  /let new_fulldetail=$[strcat(new_fulldetail,"@{N}",substr(old_fulldetail,0,off))]%;\
	  /let old_fulldetail=$[substr(old_fulldetail,off+4)]%;\
	/else \
	  /let new_fulldetail=$[strcat(new_fulldetail,old_fulldetail)]%;\
	  /let old_fulldetail=%;\
	/endif%;\
;
      /let off=$[strstr(value,strcat(">I<",new_fulldetail))] %;\
      /while (off>-1) \
      /let reg=$[substr(value,0,off)]%;\
      /set value=$[substr(value,off+3)]%;\
      /let off=$[strstr(value,"<I>")]%;\
      /let _new_count=$[strcmpn(fulldetail,value)]%;\
      /if (_new_count>0 & _new_count>char_count) \
        /let char_count=%_new_count%;\
	   /let off=$[strrchr(reg,"<")] %;\
	   /while (substr(reg,off,3)!~"<I>") \
	     /let res_key=$[strcat(substr(reg,off),res_key)]%;\
	     /let reg=$[substr(reg,0,off)]%;\
	     /let off=$[strrchr(reg,"<")] %;\
	   /done %;\
	   /let res_key=$[strcat(substr(reg,off+3),res_key)] %;\
;	   /let res_key%;\
      /endif%;\
      /let off=$[strstr(value,strcat(">I<",new_fulldetail))] %;\
     /done%;\
     /if (char_count>strlen(new_fulldetail)) /set value=%res_key%;\
     /else /set value=%error%; /endif%;

/def getpoint2 = \
      /test fulldetail:=strcat("@{N}",fulldetail)%;\
      /restricttoexit noexits%;\
;      /test fulldetail:=strcat(fulldetail,room_exits)%;\
     /lookup_lastpoints%;\
     /if (value!~error & value!/"keys_*" & {#}>0) /eval -s0 %1 %value %; \
     /elseif ({#}>1) /eval -s0 %-1 %; /endif %;

/addh info \
Die Nummer des Triggers, der beim Grabben der Raumbeschreibung von ?/getpoint verwendet wird.@{N}\
Durch "-E(!trig_is_active(getpoint_trig))" lassen sich andere Trigger fuer die Zeit des Grabbens abschalten.
/addh see /getpoint
/addh getpoint_trig var

/addh info \
Fuegt fuer alle Knoten des Wegesystems eine Erkennung hinzug (mit Abfrage).
/addh addallpoints comm

/defh addallpoints = \
     /set temp_list3=%ways %;\
     /getfirstkey temp_list3 %;\
     /while (value!~error) \
       /let key=%value %;\
       /addpointgo %key %;\
       /getlistvalueof temp_list3 %key %;\
       /if (value!~error) \
          /set temp_list2=%value %;\
	  /getfirstkey temp_list2 %;\
	  /while (value!~error) \
	    /let subkey=%value %;\
	    /addpointgo %subkey %;\
	    /deletekeyandvalue temp_list2 %subkey %;\
	    /getfirstkey temp_list2 %;\
	  /done %;\
       /endif %;\
       /deletekeyandvalue temp_list3 %key %;\
       /getfirstkey temp_list3 %;\
     /done %;    

/createlist temp_points
/def addpointgo = \
     /getvalueof lastpoints %1 %;\
     /if (value!~error) /addtolist temp_points %1 %; /endif %;\
     /getvalueof temp_points %1 %;\
     /if (value=~error) \
       /addtolist temp_points %1%;\
       /getali %1 %;\
       /if (ext_read(sprintf("Gehe zu #1 (j/n) ",value))=/"j") \
	   /_getali %1 %;\
	   /_go %value %;\
	   /lp2 %1 %;\
           /if (ext_read("Uebernehmen(j/n) ")=/"j") \
 	     /addnode %;\
	   /endif %;\
	 /endif %;\
     /endif %;

/addh info \
Zeigt Knoten an.
/addh see wege, knoten
/addh syn '/shownode *' zeigt alle Knoten an. (Dauert ein bisschen.)@{N}\
'/shownode knoten' zeigt die Beschreibung fuer den Knoten an.@{N}\
'/shownode' zeigt die Beschreibung fuer den aktuellen Knoten an.
/addh var nodelist (Speicher fuer Knotenliste)
/addh changes 3.11.99 /shownode arbeitet jetzt auch mit Wildcards, d.h. '/shownode t*' zeigt alle Knoten, an die mit 't' beginnen (Gross/Kleinschreibung egal).
/addh shownode comm

/defh shownode = \
     /if ({1}=/"*\\*") \
/debug %*%;\
	/set shownode_param=%*%;\
	/set nodelist=%;\
;	/if (nodelist=~"") \
	  /forEach toidx k /shownode2%;\
;	/endif %;\
	/echo Vorhandene Knotenpunkte: %;\
        /echo -p %nodelist %;\
     /else \
	/if ({*}=~"") /let anode=%lastpoint %; \
	/else \
	   /getnode %* %; \
	   /let anode=%value %;\
	/endif %;\
	   /getali %anode 0%;\
	   /echo -p Beschreibung fuer Knoten %value: %;\
	       /getlistvalueof nodeinfo %anode%;\
	       /if (value!~error) \
	         /set temp_nodeinfo=%value%;\
	         /set output=%;\
		 /getvalueof temp_nodeinfo info%;\
	         /set output=%value%;\
	         /getvalueof temp_nodeinfo gebiet%;\
	         /set output=$[strcat(output," (",value,")@{N}")]%;\
	         /echo2 -p %output%;\
	       /endif%;\
	   /getnextvalueof%;\
	   /getnextvalueof lastpoints %anode %;\
	   /let anode_value=%value%;\
	   /if (value=~error) /echo keine Langbeschreibung vorhanden! %;\
	   /else \
	       /while (anode_value!~error) \
	         /echo2 -p %anode_value %;\
	         /echo %;\
	         /getnextvalueof lastpoints %anode%;\
	         /let anode_value=%value%;\
	       /done%;\
	   /endif %;\
      /endif %;

/def shownode2 = \
	/_getali %*%;\
	/if (shownode_param=~"*" | value=/shownode_param) \
	/if (nodelist=~"") \
	  /set nodelist=%value %;\
	/else /set nodelist=$[strcat(nodelist,", ",value)] %;\
	/endif%;\
	/endif%;

/addh info \
Vergleicht die Raumbeschreibungen in der Liste und zeigt Knoten mit denselben Raumbeschreibungen an.
/addh comparelastpoints comm
/defh comparelastpoints = \
     /set temp_list=%lastpoints %;\
     /getfirstvalue temp_list %;\
     /while (value!~error) \
	/let room=%value %;\
	/getkeyofvalue %1 %room%;\
	/if (value!~error) \
	   /let key1=%value %;\
	   /getfirstkey temp_list %;\
	   /let key2=%value %;\
	   /echo %key1 aus %1 ist gleich %key2 aus lastpoints %;\
	/endif %;\
	/getfirstkey temp_list %;\
	/let key=%value %;\
	/deletekeyandvalue temp_list %key %;\
	/getfirstvalue temp_list %;\
     /done %;


/addh info \
Uebergibt den uebergebenen Weg ueber die Variable %shorten an /shorten und liefert dessen Ergebnis zurueck.
/addh mak shorten
/addh shorten2 mak
/def shorten2 = \
	/set shorten=%*%;\
;/set shorten%;\
	/let res=$[shorten("shorten")]%;\
;/set shorten%;\
;/let res%;\
	/result res%;

/addh info \
Wandelt den uebergebenen Weg aus dem Format 'o%;w%;w%;gehe nach oben%;s%;s%;s%;' in ',o,2w,gehe nach oben,3s' um. Dieses kann mit /walk oder direkt ueber den Sendhook genutzt werden.
/addh syn /shorten variablenname
/addh shorten mak

/def shorten = \
     /let t=%;\
     /test t:=%*%;\
     /let res=%;\
     /while (t!~"") \
       /let off=$[strstr(t,"%;")]%;\
       /if (off>-1) \
         /let comm=$[substr(t,0,off+2)] %;\
;/let comm%;\
         /let count=1%;\
	 /let t=$[substr(t,off+2)]%;\
;/let t%;\
	 /while (strstr(t,comm)==0) \
	   /let count=$[count+1]%;\
	   /let t=$[substr(t,off+2)]%;\
	 /done%;\
	 /let res=$[strcat(res,",",(count>1)?count:"",substr(comm,0,strlen(comm)-2))]%;\
       /endif%;\
     /done%;\
	/result res%;
;     /let res%;

/def checkways = \
     /set t3=%;\
     /set t4=%;\
     /let count=0%;\
     /test t3:=ways%;\
     /while ((value!~error) & (strlen(t3)>3)) \
       /getfirstkey t3%;\
;/echo from %value%;\
       /getdlistvalueof t3 %value%;\
       /test t4:=value%;\
       /while ((value!~error) & (strlen(t4)>3)) \
         /getfirstkey t4%;\
;/echo to %value%;\
         /getdvalueof t4 %value%;\
         /let count=4%;\
	 /let off=0%;\
	 /while ((off>-1) & (count>0)) \
	   /let off=$[strchr(value," ")]%;\
	   /if (off>-1) \
	     /set value=$[substr(value,off+1)]%;\
	   /endif%;\
	   /let count=$[count-1]%;\
	 /done%;\
	 /if (off>-1) /shorten value%; /endif%;\
       /done%;\
     /done%;

/def add = \
     /set saved_wayto=$[strcat(saved_wayto,{*},"%;")]%;
/def rueckwaerts = \
     /let to=%*%;\
     /getxm %to %;\
     /if (to!/"/*" & (value=~error | value=/"1 *")) \
       /let to=%{to}%;\
     /endif%;\
     /set saved_waybk=$[strcat(to,"%;",saved_waybk)] 

/def rueck = /rueckwaerts %*
/def norm = /set rec=1%;
/def rev = /set rec=2%;
/def both = /set rec=3%;
/def dorec = /norm %;
/def norec = /set rec=0 %;
/def setvar = /set var=%{1} %;
/def initbk = /set %{var}bk= %; 
/def initto = /set %{var}to= %; 
/def wayinit = /initbk %;/initto %;/set name= %;
/setvar saved_way
/wayinit
/norec

; anpassen nur das hinter dem =

;/set gonumbers=0 %;
;/def toggle_gonumbers = /if (gonumbers="0") /set gonumbers=1 %;\
;/echo Ziffern ein%;\
;	/bind 1 = /_sw%;/bind 2 = /_s%; /bind 3 = /_so%; /bind 4 = /_w%;\
;	/bind 5 = /_schaue%;/bind 6 = /_o%;/bind 7 = /_nw%;/bind 8 = /_n%;\
;	/bind 9 = /_no%;/bind + = /_u%;/bind - = /_ob%;/bind 0 = /i_vorw%;\
;	/bind . = /_u%;\
;  /else /set gonumbers=0 %;\
; /echo Ziffern aus%;\
;	/unbind 1%;/unbind 2%;/unbind 3%;/unbind 4%;/unbind 5%;\
;	/unbind 6%;/unbind 7%;/unbind 8%;/unbind 9%;/unbind +%;/unbind -%;\
;	/unbind 0%;/unbind .%;\
;  /endif%;

/addh info \
Geht bis zum letzten bekannten Knoten zurueck, sofern ab diesem nur Richtungsbefehle verwendet wurden.
/addh see go, wegeingabe
/addh gobk comm
/def goto = /go_saved_way to %1 %;
/defh gobk = /go_saved_way bk %1 %;/lp2 %lastpoint%;

/def go_saved_way = /let temp_var=$[strcat("saved_way",{1})] %; \
	/set go=0%;\
	/test value:=optimize_way2(%temp_var)%;\
;	/set value%;\
	/if ((value!~error)&(value!~"")) \
;	/echo shortened gobk/to %value%;\
	   /eval %value %;\
	/endif %;\
	/both%;

/def start = /rev%; /initbk%;
/def _back = /set go=0%;/gobk%;/norm%;
/def back = /gobk%;

/createnewlist tripnodes

/addh info \
Temporaerer Ausflug von nem Knoten: Zum Zielraum (z.B. NPC) laufen, dort /add_trip eingeben und schon kommt man per /tgo knoten in den Zielraum@{N}\
Loeschen per /add_trip direkt am Knoten oder /add_trip Knotenname
/addh see tgo
/addh add_trip comm
/def add_trip = \
     /if (strlen(saved_wayto)==0 | {#}==1) \
        /deletekeyandvalue ednodes %{1-%lastpoint}%;\
     /else \
	/createlist add_trip%;\
	/addtolist add_trip node %lastpoint%;\
	/addtolist add_trip to $[optimize_way2(saved_wayto)]%;\
	/addtolist add_trip bk $[optimize_way2(saved_waybk)]%;\
	/deletekeyandvalue tripnodes %lastpoint%;\
	/addlisttolist tripnodes %lastpoint %add_trip%;\
     /endif%;

/addh info \
Wenn temporaere Ausfluege fuer den aktuellen oder Zielknoten eingetragen sind, dann werden diese beruecksichtigt!
/addh see add_trip
/addh tgo comm
/def tgo = \
        /getlistvalueof tripnodes %lastpoint%;\
	/if (value!~error & strlen(saved_wayto)>0) \
	   /set tgo=%value%;\
	   /getvalueof tgo bk%;\
	   /eval %value%;\
	/endif%;\
        /getnode %1%;\
	/let to=%value%;\
	/getlistvalueof tripnodes %to%;\
	/if (value!~error) \
	   /set tgo=%value%;\
	   /getvalueof tgo to%;\
	   /set after_go=/eval %value%;\
	   /getvalueof tgo node%;\
	   /_go %value%;\
	/else /_go %to%;\
	/endif%;

/def optimize_way2 = \
	/let cutdown=1%;\
	/let olast=%; /let prelast=%*%;\
	/while (cutdown==1) \
 	    /test tokenize("\%;",prelast)%;\
	    /let i=$[0+T0-1]%;\
	    /let cutdown=0%;\
	    /while (--i>0) \
	        /test olast:=strcat(\{T$[i+1]\})%;\
	        /test prelast:=strcat(\{T%{i}\})%;\
;/echo %prelast - %olast%;\
	        /get_anti_dir %olast%;\
	        /if (prelast=~value) \
	          /let cutdown=1%;\
	          /set T%i=%;\
		  /set T$[i+1]=%;\
	          /test --i%;\
                /endif%;\
	    /done%;\
	      /let i=$[0+T0]%;\
	      /let prelast=%;\
	      /while (--i>0) \
		 /test olast:=strcat(\{T$[i]\})%;\
		 /if (olast!~"") \
		     /let prelast=$[strcat(olast,"%;",prelast)]%;\
		 /endif%;\
	      /done%;\
;	    /let prelast%;\
	/done%;\
	/result prelast%;

; begin aktueller Wegepunkt
/def begin = /both%; /wayinit %;/set name=%{1} %;
; end aktueller Wegepunkt nach dem laufen

/addh info \
Beendet die Wegeingabe. Wenn der aktuelle Raum als Knoten erkannt wird, wird er sofort als Endknoten benutzt, ansonsten muss einer eingeben werden. Dann speichert es den Weg ab. Dabei wird gefragt, ob das mit Defaultwerten (s)chnell, mit vorherigem (e)ditieren oder (n)icht geschehen soll. (Nach Aenderunen in tf geht das direkte Editieren nicht mehr, der Weg muss erst mit (s)chnell gespeichert werden und dann mit /editway editiert werden.)@{N}\
Fuer das Editieren bitte dort nachsehen.@{N}\
Die Wege werden @{B}sofort@{N} auf die Platte gespeichert.@{N}\
Falls der Knoten neu ist, wird seine Beschreibung auch erfasst. Dabei wird die ggf. angegebene Zeilenzahl fuer die Speicherung benutzt, ansonsten die Variable ?addlines 
/addh see wege editieren, einschraenkungen
/addh list ways, fromidx, toidx
/addh syn /end [endknoten [zeilenzahl]] 
/addh end comm
/defh end = \
	/if (weg==1) \
	  /set weg=0%;\
;	  /undef speicherweg %;\
	/endif %;\
	/if ({1}=~"") /test getpoint("/end2 -1","/end3") %; /else \
	  /getnode %1 %;\
	  /let param=%value%;\
	  /iskey lastpoints %value%;\
	  /end2 $[(value!~error)?"-1":"0"] %param %2%;\
	/endif %;

/def end2 = \
	/let setlp=%1 %;\
;/let setlp%;\
	/shift%;\
	/do_save %name %1 to %;\
	/if (value!~error & setlp>-1) /let setlp=1 %; /endif %;\
	/do_save %1 %name bk %;\
	/if ((value!~error & setlp>-1)|(setlp>0)) \
;/let setlp%;\
	  /iskey nodeinfo %1%;\
	  /if (value=~error) \
            /addnodeinfo %1%;\
	  /endif%;\
	  /_addpoint %1 %2%; \
	  /lp2 %1 %; \
	/endif %;\
	/if (setlp==-1) /lp2 %1%; /endif%;

/def end3 = \
	/echo Dieser Punkt ist nicht bekannt! %;\
	/let anode=$[tolower(shread("Name oder zum Abbruch nur Enter: "))]%;\
	/if (anode!~"") \
	  /getnode %anode %;\
	  /end2 0 %value %;\
	/endif %;

/def _edit_way = \
	/_show_way %1 %2%;\
	/let _edit_way_value=%value%;\
	/if (shread("Diesen Weg editieren (j/[n])")!/"j") /break%;/endif%;\
;/echo %1 %2 %value%;\
	/editway2 %1 %2 %_edit_way_value%;\
;/echo posteditway%;\
;/set value%;\
	/if (value!~error) \
	/let sway=%value %;\
;/let sway%;\
;/echo predel%;\
	   /_del_way2 %1 %2%;\
;/echo postdel%;\
	   /_add_way %1 %2 %sway%;\
;/echo postadd%;\
	   /echo Ergebnis der Modifikation:%;\
	   /_show_way %1 %2%;\
	/endif %;

;/editway2 from to ([bpn0-9]) allow len way
/def editway2 = \
	/let sway=%-5%;\
	/getali %1 %;\
	/let from=%value %;\
	/getali %2 %;\
	/let to=%value %;\
;	/if (sway!~"") \
	  /let bereich=%3%;\
	  /let allow=%4 %;\
	  /let slen=%5 %;\
	  /let sway=$[ext_read("Weg ggf. editieren, sonst Return: ",sway)]%;\
	  /let slen=$[$(/count_steps %sway)] %;\
	  /let bereich=$[ext_read("ue(b)erall (n)ormal (p)ara (0-9).Parawelt (Gueltigkeitsbereich) :",bereich)] %;\
	  /if (regmatch("([bpn0-9])",bereich)==0) \
	     /echo falsche Eingabe! Nicht geaendert %;\
	     /let bereich=%3%;\
	  /endif%;\
	  /echo Einschraenkung (wer den Weg benutzen kann):%;\
	  /echo -p @{B}all@{n} - keine; @{B}name@{n} - nur derjenige %;\
	  /echo -p race:rasse, guild:gilde, state:status (spieler, seher) %;\
	  /echo nach dem : reichen die zur identifikation notwendigen Anfangsbuchstaben %;\
	  /echo oder eine gueltige expression (z.B. p_lp>180) %;\
	  /echo siehe player datensatz (/whoami) %;\
	  /let allow=$[ext_read("Einschraenkung: ",allow)]%;\
	  /let alen=$[ext_read("Laenge des Weges (Gewicht): ",slen)] %;\
	  /if (regmatch("[0-9]+",alen)==0) \
	    /echo falsche Eingabe, nicht geaendert!%;\
	    /let alen=%5%;\
	  /endif %;\
	  /set value=$[strcat(bereich," ",allow," ",alen," ",sway)] %;\
;	/else /set value=-1%;\
;	/endif %;	

/addh info \
Kehrt den angegebenen Weg um und speichert ihn ab.
/addh syn /reverseway (knoten1|*) (knoten2|*)
/addh reverseway comm
/defh reverseway = \
	/set nextmakro=/_reverse_way %;\
	/forEachWay %* %;

/def _reverse_way = \
	/_show_way %1 %2 %;\
	/let _reverse_way_value=%value%;\
	/if (shread("Diesen Weg umgekehrt speichern (Rueckweg) (j/[n])")=/"j") \
	/_reverse_way2 %1 %2 %_reverse_way_value%;\
	/let _reverse_way_value=%value%;\
	/echo neuer Rueckweg: %_reverse_way_value%;\
	/dokey DLINE %;\
	/let input=$[tolower(shread("Speichern? [j/n/(e)ditieren]"))]%;\
	/if (input=/"n") /break%;/endif%;\
	/if (input=~"e") \
  	  /editway2 %2 %1 %_reverse_way_value%;\
	/endif%;\
	/if (input=/"[ej]") \
	/if (_reverse_way_value!~error) \
	/let sway=%_reverse_way_value %;\
	/let reverse_way_temp2=%temp_list2%;\
	/let reverse_way_temp=%temp_list2%;\
	   /_del_way2 %2 %1%;\
	   /_add_way %2 %1 %sway%;\
	/set temp_list2=%reverse_way_temp%;\
	/set temp_list=%reverse_way_temp%;\
	/endif %;\
	/endif%;\
	/endif%;\

/def _reverse_way1 = \
	/let from=%1 %;\
	/let to=%2 %;\
	/getali %1 %;\
	/let alifrom=%value %;\
	/getali %2 %;\
	/let alito=%value %;\
;	/echo -p %alifrom -> %alito %;\
	/~getway %from %;\
	/if (value=~error) /echo Weg existiert nicht%; /break %; \
	/else \
	  /set temp_list=%value %;\
	  /getvalueof temp_list %to %;\
	  /if (value=~error) \
	    /echo Weg existiert nicht%; /break %; \
	  /else \
	    /_reverse_way2 %from %to %value %;\
	  /endif%;\
	/endif %;

/def _reverse_way2 = \
	/reverse %-5%;\
	/set value=%3 %4 %5 %value%;


/def reverse = \
	/let res=%;\
	/let sway=%*%;\
	 /let off=$[strstr(sway,"%;")] %;\
 	 /while (off!=-1) \
	   /let comm=$[substr(sway,0,off)] %;\
	   /getvalueof xtramoves %comm%;\
	   /if (value!~error) /let comm=$[substr(value,2)]%; /endif%;\
	   /if (comm!/"/*") /let res=$[strcat(comm,"%;",res)]%; /endif%;\
	   /let sway=$[substr(sway,off+2)] %;\
	   /let off=$[strstr(sway,"%;")] %;\
	/done %;\
	/set value=%res%;

/def do_save = \
	/let temp_var=$[strcat(var,{3})] %;\
	/eval /set value=\%%temp_var %;\
	/do_save2 %* %; 

/def do_save2 = \
	/let sway=%value %;\
	/getali %1 %;\
	/let from=%value %;\
	/getali %2 %;\
	/let to=%value %;\
	/echo -p %from -> %to : %sway %;\
	/let slen=$[$(/count_steps %sway)] %;\
	/dokey DLINE %;\
	/if (shread("Speichern [j/n]?")=/"[sj]") \
	  /let alen=%slen%;\
	  /set value=$[strcat("b all ",alen," ",sway)] %;\
	  /echo speichere Weg: %value %;\
	/else /set value=%error%; /break %;\
	/endif %;\
	/if (value!~error) /_add_way %1 %2 %value %;/endif %;
; info!

/addh info \
Fuegt den als Parameter uebergebenen Weg mit Standardparametern (b all laenge) zur Wegeliste hinzu. Der Weg kann dann mit /editway editiert werden.
/addh addway info
/def addway = \
	/let from=%1%;\
	/let to=%2%;\
	/let sway=%-2%;\
	/let slen=$[$(/count_steps %sway)] %;\
	/echo  %from %to b all %slen %sway%;\
	/_add_way %from %to b all %slen %sway%;

/def addway2 = \
	/set pedantic off%;\
	/getnode %1%;\
	/let from=%value%;\
	/getnode %2%;\
	/let to=%value%;\
	/let dim=%3%;\
	/if (regmatch("(.)([0-9]+)([+]([0-9]+))?",dim)) \
	  /let slen=$[{P2}]%;\
	  /let dim=%P1%;\
	/endif%;\
	/let allow=%4%;\
	/let sway=%-4%;\
	/let slen=$[slen+$(/count_steps %sway)] %;\
	/echo  %from %to %dim %allow %slen %sway%;\
	/_add_way2 %from %to %dim %allow %slen %sway%;

/def _add_way2 = \
	/let from=%1%;\
	/shift%;\
	/getlistvalueof ways %from%;\
	/if (value=~error) \
	   /createlist add_way2%;\
	/else \
	  /set add_way2=%value%;\
	  /deletekeyandvalue ways %from%;\
	  /remove_from_cache %from%;\
	/endif%;\
	/addtolist add_way2 %*%;\
	/addlisttolist ways %from %add_way2%;

	
/addh info \
Laedt die Wegelisten neu, besonders vor Aenderungen wegen der Konsistenz zu empfehlen.
/addh loadways mak
/def loadways = /loadlist -q %ways_location ways%;/loadlist -q %ways_location fromidx%;/loadlist -q %ways_location toidx%;

/addh info \
Speichert die Wegelisten (z.B. nach Aenderungen) ab (wegen der Konsistenz).
/addh saveways info

/def saveways = /savelist -q %ways_location ways%;/savelist -q %ways_location fromidx%;/savelist -q %ways_location toidx%;

/def loadnodes = /loadlist %ways_location lastpoints%;\
	/loadlist %ways_location nodeinfo%;/loadlist %ways_location nodealias%;

/def savenodes = /savelist %ways_location lastpoints%;\
	/savelist %ways_location nodeinfo%;/savelist %ways_location nodealias%;

; das eigentliche Hinzufuegen zu den Listen
/def _add_way = \
	/loadways%;\
;   	/createlist often2 %;\
	/let sway=$[strcat("<I>",{2},">I<",{-2},"<I>")] %;\
	/test $[regmatch("(([bpn0-9]) ([^ ]+) [0-9]+)",{-2})] %;\
	/let part1=%P0 %;\
	/~getway %1 %;\
	/let from=%1%;/let to=%2%;\
	/if (value=~error) \
	   /~addway %1 %sway %;\
	   /addlisttolist fromidx %1 $[strcat("<I>",{2},">I<",part1,"<I>")] %;\
	   /getlistvalueof toidx %2 %;\
	   /if (value=~error) \
	     /addlisttolist toidx %2 $[strcat("<I>",{1},">I<",part1,"<I>")] %;\
	   /else \
	     /set temp_list2=%value %;\
	     /addtolist temp_list2 %1 %part1 %;\
	     /sort_idx_list temp_list2 %;\
	     /deletekeyandvalue toidx %2 %;\
	     /addlisttolist toidx %2 %temp_list2 %;\
	   /endif%;\
	/else \
	   /set temp_list=%value %;\
	   /getlistvalueof fromidx %1%;\
	   /set temp_list2=%value %;\
	   /getlistvalueof toidx %2 %;\
	   /set temp_list3=%value %;\
	   /getvalueof temp_list %2 %;\
	   /if (value!~error) \
		/echo2 -p Weg %from -> %to existiert schon: %value %;\
		/dokey DLINE %;\
		/if (shread("Loeschen (j/[n])?")=/"j") \
		  /deletekeyandvalue temp_list %2 %;\
		  /deletekeyandvalue temp_list2 %2 %;\
		  /deletekeyandvalue temp_list3 %1 %;\
	        /endif %;\
	   /endif %;\
	   /let sway=$[strcat(temp_list,substr(sway,3))] %;\
	   /deletekeyandvalue ways %1 %;\
	   /~addway %1 %sway %;\
	   /addtolist temp_list2 %2 %part1%;\
	   /sort_idx_list temp_list2 %;\
	   /deletekeyandvalue fromidx %1 %;\
	   /addlisttolist fromidx %1 %temp_list2 %;\
	   /if (temp_list3=~error) \
	     /addlisttolist toidx %2 $[strcat("<I>",{1},">I<",part1,"<I>")] %;\
	   /else \
	     /addtolist temp_list3 %1 %part1 %;\
	     /sort_idx_list temp_list3 %;\
	     /deletekeyandvalue toidx %2 %;\
	     /addlisttolist toidx %2 %temp_list3 %;\
	   /endif%;\
	/endif %;\
	/remove_from_cache %from %to%;\
	/saveways%;\
	/set value=1 %;


; '/_del_way from to' loescht den weg from -> to mit Sbfrage
/def _del_way = \
	/let from=%1 %;\
	/let to=%2 %;\
	/_show_way %from %to %;\
	/dokey DLINE %;\
	/if (shread("Loeschen(j/[n])?")=/"j") \
	  /_del_way2 %*%;\
	/endif %;

/def _del_way2= \
      /loadways%;\
      /let from=%1 %;\
      /let to=%2 %;\
;      /createlist often2 %;\
      /~getway %from %;\
      /if (value=~error) /break %; \
      /else \
	/set temp_list=%value %;\
	/deletekeyandvalue temp_list %to %;\
	/if (temp_list!~"<I>") \
	  /deletekeyandvalue ways %from %;\
	  /~addway %from %temp_list %;\
	/else \
	  /deletekeyandvalue ways %from %;\
	/endif%;\
;	/savelist %ways_location ways %;\
	/getlistvalueof fromidx %from %;\
	/set temp_list=%value %;\
	/deletekeyandvalue temp_list %to %;\
	/if (temp_list!~"<I>") \
	  /deletekeyandvalue fromidx %from %;\
	  /addlisttolist fromidx %from %temp_list %;\
	/else \
	  /deletekeyandvalue fromidx %from %;\
	/endif%;\
;	/savelist %ways_location fromidx %;\
	/getlistvalueof toidx %to %;\
	/set temp_list=%value %;\
	/delallkeysandvalues temp_list %from %;\
	/if (temp_list!~"<I>") \
	  /deletekeyandvalue toidx %to %;\
	  /addlisttolist toidx %to %temp_list %;\
	/else \
	  /deletekeyandvalue toidx %to %;\
	/endif%;\
;	/savelist %ways_location toidx %;\
	/remove_from_cache %from %to%;\
	/saveways%;\
      /endif %;

/defh splitways = /set nextmakro=/splitway %;\
	/forEachWay %*%;


/addh info \
Beim Editieren von Wegen wird nach folgenden Angaben gefragt:@{N}\
Weg selbst, kann editiert werden, muss danach aber ausfuehrbar sein ;)@{N}\
Gueltigkeitsbereich: ue(b)erall, nur (n)ormalwelt, nur (p)arawelt (0-9).Parawelt.@{N}\
Einschraenkungen: all-keine, der Rest siehe Einschraenkungen.@{N}\
Laenge des Weges: = Gewicht beim Berechnen, also bei langwierigen Wegen hochsetzen.
/addh see einschraenkungen, dimension, editway, showway, delway
/addh editieren see

; /splitway knoten1 knoten2 anzahl der schritte ab dem gespalten werden soll
/addh info \
Splittet einen Weg in zwei Teilwege auf. Dafuer wird die Anzahl der zum ersten Weg gehoerenden Befehle als Parameter uebergeben und kann dann auch spaeter interaktiv veraendert werden. Es wird nach dem neuen Zwischenknoten gefragt, dann werden die neuen Wege gespeichert und das Loeschen des alten Weges abgefragt.
/addh see editway, showway
/addh ex /splitway knoten1 knoten2 anzahl_befehle_in_erstem_teilweg@{N}\
	 z.B. /splitway haus kneipe 5
/addh splitway comm

/defh splitway = \
	/getnode %1%;\
	/let from=%value%;\
	/getnode %2%;\
	/let to=%value%;\
	/_show_way %from %to%;\
;	/let _edit_way_value=%value%;\
	/if (shread("Diesen Weg splitten (j/[n])")!/"j") /break%;/endif%;\
	/getlistvalueof ways %from%;\
	/if (value!~error) \
	   /set temp_way_list=%value%;\
	   /getvalueof temp_way_list %to%;\
	   /if (value!~error) \
	      /let reg=$[strcat("([bpn0-9]) ([^ ]+) ([0-9]+) ?")]%;\
	      /test regmatch(reg,value)%;\
	      /let sway=%PR%;\
	      /let allow=%P2%;\
	      /let ber=%P1%;\
	      /let llen=%P3%;\
	      /let count=%3%;\
	      /while (count>-1) \
	      /let sway1=%;\
	      /let sway2=%sway%;\
	      /while (--count>=0) \
	        /let off=$[strstr(sway2,"%;")]%;\
	        /let sway1=$[strcat(sway1,substr(sway2,0,off+2))]%;\
	        /let sway2=$[substr(sway2,off+2)]%;\
	      /done%;\
	      /echo Weg1: %1 -> %sway1%;\
	      /echo Weg2: %sway2  -> %2%;\
	      /let x=$[shread("Richtig? (Jj), wenn nicht, neuer Wert fuer den Split")]%;\
	      /if (x=/"j*") \
	         /let x=$[shread("Knotennamen fuer Zwischenknoten eingeben:")]%;\
	         /loadways%;\
		 /echo Weg hinzugefuegt: %from %x %ber %allow $[count_steps(sway1)] %sway1%;\
		 /_add_way %1 %x %ber %allow $[count_steps(sway1)] %sway1%;\
		 /echo Weg hinzugefuegt: %x %2 %ber %allow $[count_steps(sway2)] %sway2%;\
		 /_add_way %x %to %ber %allow $[count_steps(sway2)] %sway2%;\
	         /_del_way %from %to%;\
;	         /saveways%;\
	         /echo Bitte den Knoten %x noch mit /addnode (im Raum) eintragen%;\
	      /elseif (x=/"[0-9]*") /let count=$[0+x]%;\
	      /else /let count=-1%;/echo Abbruch!%;\
	      /endif%;\
	      /done%;\
	   /else \
	   /echo von %1 nach %2 gibt es keinen Weg%;\
	   /endif%;\
	/else /echo von %1 fuehrt kein Weg weg!%;\
	/endif%;

/addh info \
Editieren von Wegen (mit jeweiliger Abfrage).
/addh syn \
'/editway * knoten' editiert alle Wege an, die zum Knoten hinfuehren.@{N}\
'/editway knoten *' editiert alle Wege an, die vom Knoten wegfuehren.@{N}\
'/editway knoten1 knoten2' editiert den Weg zwischen den Knoten an.
/addh see wege editieren, showway, delway, einschraenkungen
/addh editway comm

; Syntax /editway from to, einer der beiden Parameter kann ein * sein
/defh editway = /set nextmakro=/_edit_way %;\
	/forEachWay %* %;

; /showway zeigt Wege an 
; Syntax /showway from to, einer der beiden Parameter kann ein * sein
/addh info \
Zeigt Wege an.
/addh syn \
'/showway * knoten' zeigt alle Wege an, die zum Knoten hinfuehren.@{N}\
'/showway knoten *' zeigt alle Wege an, die vom Knoten wegfuehren.@{N}\
'/showway knoten1 knoten2' zeigt den Weg zwischen den Knoten an.
/addh see wege editieren, editway, delway
/addh showway comm

/defh showway = /set nextmakro=/_show_way %;\
	/if (strchr("*",{*})==-1) /set nextmakro=$[strcat(nextmakro," _all_")]%; /echo all%;/endif%;\
	/forEachWay %* %;

/defh showaddway = /set nextmakro=/_show_add_way %;\
	/if (strchr("*",{*})==-1) /set nextmakro=$[strcat(nextmakro," _all_")]%; /echo all%;/endif%;\
	/forEachWay %* %;

; /delway loescht Wege
; Syntax /delway from to, einer der beiden Parameter kann ein * sein
/addh info \
Loescht Wege (mit jeweiliger Abfrage).
/addh syn \
'/delway * knoten' loescht alle Wege an, die zum Knoten hinfuehren.@{N}\
'/delway knoten *' loescht alle Wege an, die vom Knoten wegfuehren.@{N}\
'/delway knoten1 knoten2 loescht' den Weg zwischen den Knoten an.
/addh see wege editieren, showway, editway
/addh delway comm
/defh delway = /set nextmakro=/_del_way %;\
	/forEachWay %* %;

/addh info \
Fuehrt fuer alle Wege, die den Parametern entsprechen, das Makro in \%nextmakro aus mit den Wegeknoten als Parameter.
/addh ex /set nextmakro /echo von %1 zu %2%;@{N}\
/forEachWay * gilde%;@{N}\
/addh syn /forEachWay knoten1|* knoten2|*
/addh forEachWay mak
/def forEachWay = \
;	/set freeze_status=1%;\
	/if ({1}!~"*") /getnode %1%; /let from=%value %;\
	/else \
           /let from=%1 %;\
	/endif %;\
	/if ({2}!~"*") /getnode %2%; /let to=%value %;\
	/else \
           /let to=%2 %;\
	/endif %;\
	/let save_temp2=%;\
	/if (from=~"*") /getlistvalueof toidx %to %;\
	   /if (value!~error) \
	      /set temp_list2=%value %;\
	      /let idx=0 %;\
	      /getikey temp_list2 %idx %;\
	      /while (value!~error) \
	        /let from=%value %;\
	        /getivalue temp_list2 %idx%;\
	        /test save_temp2:=temp_list2%;\
		/eval %nextmakro %from %to %;\
	        /test temp_list2:=save_temp2%;\
	        /let idx=$[++idx] %;\
	        /getikey temp_list2 %idx %;\
	      /done %;\
	   /endif %;\
	/elseif (to=~"*") /getlistvalueof fromidx %from %;\
	   /if (value!~error) \
	      /set temp_list2=%value %;\
	      /let idx=0 %;\
	      /getikey temp_list2 %idx %;\
	      /while (value!~error) \
	        /let to=%value %;\
	        /getivalue temp_list2 %idx%;\
	        /test save_temp2:=temp_list2%;\
		/eval %nextmakro %from %to %;\
	        /test temp_list2:=save_temp2%;\
	        /let idx=$[++idx] %;\
	        /getikey temp_list2 %idx %;\
	      /done %;\
	   /endif %;\
	/else /eval %nextmakro %from %to %;\
	/endif %;\
;	/set freeze_status=0%;\

/def _show_way = \
	/if ({1}=~"_all_") /let all=1%; /shift%; /else /let all=0%; /endif%;\
	/let from=%1 %;\
	/let to=%2 %;\
	/getali %1 %;\
	/let alifrom=%value %;\
	/getali %2 %;\
	/let alito=%value %;\
	/echo -p %alifrom -> %alito %;\
	/~getway %from %;\
	/if (value=~error) /echo Weg existiert nicht%; /break %; \
	/else \
	  /set temp_list=%value %;\
	  /getvalueof temp_list %to %;\
	  /if (value=~error) \
	    /echo Weg existiert nicht%; /break %; \
	  /else \
	    /while (value!~error) \
	      /let lastvalue=%value%;\
	      /echo %value %;\
	      /echo %;\
	      /deletekeyandvalue temp_list %to%;\
	      /getvalueof temp_list %to%;\
	      /if (all==0) /break%; /endif%;\
	    /done%;\
	    /set value=%lastvalue%;\
	  /endif%;\
	/endif %;

/def _show_add_way = \
	/if ({1}=~"_all_") /let all=1%; /shift%; /else /let all=0%; /endif%;\
	/let from=%1 %;\
	/let to=%2 %;\
	/getali %1 %;\
	/let alifrom=%value %;\
	/getali %2 %;\
	/let alito=%value %;\
	/echo -p %alifrom -> %alito: %;\
	/~getway %from %;\
	/if (value=~error) /echo Weg existiert nicht%; /break %; \
	/else \
	  /set temp_list=%value %;\
	  /getvalueof temp_list %to %;\
	  /if (value=~error) \
	    /echo Weg existiert nicht%; /break %; \
	  /else \
	    /while (value!~error) \
	      /let lastvalue=%value%;\
	      /echo /_add_way %from %to %value%;\
	      /echo %;\
	      /deletekeyandvalue temp_list %to%;\
	      /getvalueof temp_list %to%;\
	      /if (all==0) /break%; /endif%;\
	    /done%;\
	    /set value=%lastvalue%;\
	  /endif%;\
	/endif %;

/addh info \
Benennt den angegebenen Knoten um.
/addh syn /renamenode knoten neuername
/addh list lastpoints, ways, fromidx, toidx, often, disabled, tanken, often2
/addh renamenode comm
/defh renamenode = \
	/iskey lastpoints %1%;\
	/if ({#}!=2) /hilfe renamenode %; /break%; /endif %;\
	/if (value=~error) /echo Knoten %1 exitiert nicht!%;\
	/else \
	  /loadways%;\
	  /loadlist %ways_location lastpoints%;\
	  /loadlist %ways_location nodealias%;\
	  /loadlist %ways_location often%;\
	  /let old=<I>%1>I<%; /let new=<I>%2>I<%;\
	/set ways=$[replace(old,new,ways)]%;\
	/set lastpoints=$[replace(old,new,lastpoints)]%;\
	/set fromidx=$[replace(old,new,fromidx)]%;\
	/set toidx=$[replace(old,new,toidx)]%;\
	/set nodealias=$[replace(old,new,nodealias)]%;\
	/set nodeinfo=$[replace(old,new,nodeinfo)]%;\
;	/set often=$[replace(old,new,often)]%;\
;	/set disabled=$[replace(old,new,disabled)]%;\
;	/set often2=$[replace(old,new,often2)]%;\
	/createlist often%;\
;	/createlist often2%;\
	/createlist disabled%;\
	/set tanken=$[replace(old,new,tanken)]%;\
	  /let old=<II>%1>II<%; /let new=<II>%2>II<%;\
	/set ways=$[replace(old,new,ways)]%;\
	/set fromidx=$[replace(old,new,fromidx)]%;\
	/set toidx=$[replace(old,new,toidx)]%;\
	/echo Fertig: %1 durch %2 ersetzt%;\
	  /remove_from_cache %1%;\
	  /saveways%;\
	  /savelist -q %ways_location lastpoints%;\
	  /savelist -q %ways_location nodealias%;\
	  /savelist -q %ways_location nodeinfo%;\
	  /savelist -q %ways_location often%;\
	/endif%;

;	
;	/savelist %ways_location ways%;\
;	/savelist %ways_location lastpoints%;\
;	/savelist %ways_location fromidx%;\
;	/savelist %ways_location toidx%;\
;	/savelist %ways_location nodealias%;\
;	/savelist %ways_location often%;\
;	/savelist %ways_location tanken%;

/addh info \
/rush erlaubt es, lange unverzweigte Wege schnell abzulaufen. Es erwartet als Parameter eine Startrichtung und beginnt, in diese Richtung zu laufen. Dabei wird jeweils der Ausgang benutzt, mit dem man weiterkommt und nicht zurueck.@{N}\
/rush stoppt, wenn es einen Fehler bemerkt (z.B. blockender NPC) und schickt dann ggf. dem Mapper einen Befehl rueckwaerts, damit dieser wieder auf dem aktuellen Knoten steht. Ausserdem wird noch angehalten, wenn eine Verzweigung gefunden wird, oder der Weg in einer Sackgasse endet.@{N}\
Wenn man dem Mapper auf 'automapping' stellt, wird die Bewegung mitgezeichnet.
/addh ex /rush n
/addh rush comm
/defh rush = \
	/getvalueof xtramoves %1%;\
	/if (value=~error) \
	   /let rush_last=none%;\
	/else \
	   /let rush_back=$[substr(value,2)]%;\
	   /getvalueof comm_abbr %rush_back%;\
	   /if (value!~error) \
	   /let rush_last=%value%;\
	   /else \
	     /let rush_last=%rush_back%;\
	   /endif%;\
	/endif%;\
	%mud_short_output%;\
	/set fulldetail=%;\
	/def_psave_trig%;\
	/def_psave3_trig 2%;\
	/set nextmakro=/rush2 %rush_last %rush_back%;\
;	/echo noback %rush_last send: %1%;\
	%1%;

/def rush2 = \
;	/set fulldetail%;\
;/echo \%1: %1%;\
	/if (regmatch(mud_exits_output,fulldetail)) \
	  /let rush2_exits=%P2%;\
;/echo %rush2_exits%;\
	  /let count=0%;\
	  /while (regmatch(mud_exits_regexp,rush2_exits))\
;/echo \%P1 %P1%;\
	    /if (++count>2) /echo2 -p %fulldetail%; /echo -aCred Verzweigung! Stop!%; \
	      /break 2%; /endif%;\
	    /if ({P1}!~{1}) \
;/echo erlaubt %P1%;\
		/getkeyofvalue comm_abbr %P1%;\
		/if (value=~error) \
		   /let rush_last=none%;\
	           /let rush_send=%P1%;\
		/else \
;/echo send %value%;\
	           /let rush_send=%value%;\
		   /getvalueof xtramoves %value%;\
;/echo backward %value%;\
	           /let rush_back=$[substr(value,2)]%;\
		   /getvalueof comm_abbr %rush_back%;\
;/echo noback %value%;\
		   /let rush_last=%value%;\
		/endif%;\
;/let rush_send%;\
	    /endif%;\
	    /let rush2_exits=%PR%;\
	  /done%;\
	  /if (count==1) /echo -aCred Sackgasse!%; /echo2 -p %fulldetail%; /break%; /endif%;\
	  /if (count<3) \
	    /set fulldetail=%;\
	    /def_psave_trig%;\
	    /def_psave3_trig 1%;\
;	    /echo noback %rush_last send: %rush_send%;\
	    /set nextmakro=/rush2 %rush_last %rush_back%;\
	    %rush_send%;\
	  /else /echo -aCred Verzweigung! Stop!%;\
	  /endif%;\
	  /else /echo -aCred Fehler!%;\
	  /echo2 -p %fulldetail%;\
	  /if (mapper==1) /send -wmapper %2%; /endif%;\
	/endif%;
	
;/loadlist %ways_location nodeinfo in customize.tf

/addh info Loescht Zusatzinformationen ueber einen Knoten, wenn keiner angegeben wird, werden die Infos zum aktuellen Knoten geloescht
/addh syn /delnodeinfo [knoten]
/addh delnodeinfo comm

/defh delnodeinfo =\
	/loadlist -q %ways_location nodeinfo%;\
        /if ({#}==0) /let xread=%showpoint%;\
	/else \
	   /let xread=%1%;\
	/endif%;\
	/getnode %xread%;\
	/let tdest=%value%;\
	/getlistvalueof nodeinfo %tdest%;\
	/let temp_nodeinfo=%value%;\
	/if (value!~error) \
	  /echo Vorhandene Knoteninfos:%;\
	  /showlist temp_nodeinfo%;\
	  /if (ext_read("Knoteninfos loeschen (j/[n])? ")=/"j") \
	    /deletekeyandvalue nodeinfo %tdest%;\
	    /savelist -q %ways_location nodeinfo%;\
	  /endif%;\
	/else /echo Keine Knoteninformationen fuer %xread!%;\
	/endif%;

/addh info \
Fuegt der Liste mit den Knoteninfos (nodeinfo) den angebebenen Knoten sowie ein Gebiet und einen Infostring hinzu. Die Bedienung erfolgt interaktiv.
/addh list nodeinfo
/addh addnodeinfo comm

/defh addnodeinfo =\
	/loadlist -q %ways_location nodeinfo%;\
        /if ({#}==0) /let xread=%showpoint%;\
	/else \
	   /let xread=%1%;\
	/endif%;\
	/if ({#}==0) \
  	   /let xread=$[ext_read("Knotenname: ",xread)]%;\
	/else \
	   /echo Knotenname: %xread%;\
	/endif%;\
	/getnode %xread%;\
	/let tdest=%value%;\
	/getlistvalueof nodeinfo %tdest%;\
	/if (value=~error) \
	  /createlist temp_nodeinfo%;\
	/else \
	  /set temp_nodeinfo=%value%;\
	/endif%;\
	/getvalueof temp_nodeinfo gebiet%;\
	/if (value=~error) /set value=%; /endif%;\
	/uaddtolist temp_nodeinfo gebiet $[ext_read("Gebiet: ",value)]%;\
	/echo Beschreibung (u.a. auch Tanke, Kneipe, Monster usw):%;\
	/getvalueof temp_nodeinfo info%;\
	/if (value=~error) /set value=%; /endif%;\
	/uaddtolist temp_nodeinfo info $[ext_read("Beschreibung: ",value)]%;\
	/getali %tdest%;\
	/echo2 -p Knoten: %value%;\
	/showlist temp_nodeinfo%;\
	  /deletekeyandvalue nodeinfo %tdest%;\
	  /addlisttolist nodeinfo %tdest %temp_nodeinfo%;\
	  /savelist -q %ways_location nodeinfo%;

/def addnodeinfo2 = \
	/if ({#}!=3) /echo Fehler : %* /break%; /endif%;\
	/createlist addnodeinfo2%;\
	/addtolist addnodeinfo2 info %2%;\
	/addtolist addnodeinfo2 gebiet %3%;\
	/addlisttolist nodeinfo %1 %addnodeinfo2%;


/addh info \
Sucht in den Knoteninfomationen alle Knoten, die im angegebenen Gebiet liegen.
/addh nodes_geb comm

/addh info \
Sucht in den Knoteninfomationen alle Knoten, die im Text den angegebenen String enthalten.
/addh nodes_info comm

/defh nodes_geb = /nodes_search gebiet %*
/defh nodes_info = /nodes_search info %*

/addh info \
Durchforstet die Liste der Knoteninfos nach Knoten, die in dem uebergebenen Attribut den als Restparameter uebergebenen Substring (ignore case) enthalten.
/addh ex /nodes_search gebiet Ebene
/addh nodes_search mak

/def nodes_search = \
	/set output=Knoten mit Attribut %1 %-1@{N}%;\
 	/let nodeinfo_key=%1%;\
	/let nodeinfo_search=$[strcat("*",tolower({-1}),"*")]%;\
	/forEach nodeinfo kv /nodes_geb2%;\
	/echo2 -p %output%;


/def nodes_geb2 = \
	/set temp_nodeinfo=%-1%;\
	/let key=%1%;\
	/set temp_nodeinfo=$(/unmakesub %temp_nodeinfo)%;\
	/getvalueof temp_nodeinfo %nodeinfo_key%;\
	/if (value!~error & value!~"" & value=/nodeinfo_search) \
	  /getvalueof temp_nodeinfo info%;\
	  /let nodes_geb2=%value%;\
	  /getali %key 0%;\
	  /set output=$[strcat(output,value,": ",nodes_geb2)]%;\
	  /getvalueof temp_nodeinfo gebiet%;\
	  /set output=$[strcat(output," (",value,")@{N}")]%;\
	/endif%;\

/def clean_lastpoints = \
     /createlist lastpoints2%;\
     /def _clean_lastpoints=/test fulldetail:={-1},restricttoexit(),addtolist("lastpoints2",{1},fulldetail)%;\
     /foreach lastpoints kv /_clean_lastpoints%;\
     /test lastpoints:=lastpoints2%;\
     /savenodes%;\
     /unset lastpoints2%;

;;; Regexps setzen und ggf. vorkompilieren

/set way_regexp_find6=([bpn0-9]) ([^ ]+) ([0-9]+)
/set way_regexp_find6_2=([0-9]+) ([0-9]+) (.+):$
/set way_regexp_find6_3=^([0-9]+) ([0-9]+) (.+)
/set way_regexp_testcon=([0-9]+) ([0-9]+)( :(.+):)?$
/compile_regexp way_regexp_*%;\

/addh info \
Diese Datei enthaelt das komplette Wegesystem! Es ist soweit wie moeglich mudunabhaengig (ggf. sind geringe Anpassungen fuer andere Muds notwendig).@{N}\
Vor Benutzung bitte folgende Hilfe-Punkte lesen: knoten, wege, go, wo. Den Rest dann bei Bedarf.
/addh changes \
1.01 Das Problem mit dem tfread()/read() wurde durch /myread in ?util.tf geloest. Deshalb wurde bug_way zweigeteilt. Falls irgendwo noch das Problem mit dem read() auftritt, bitte Mail an mich.@{N}\
1.02 Es wird jetzt /shread in den Makros verwendet, das sollte keine Probleme mehr machen.@{N}\
Die /speedwalk-Syntak wird per Makro und Send-Hook unterstuetzt /walk.@{N}\
1.03 /walk und /h_move unterstuetzen jetzt den Mapper ?mapper.tf (<a href="map/Mapper.html">siehe auch dort</a>).@{N}\
1.03 Neues Makro /cond_stop fuer bedingtes Anhalten auf Wegen, einige nicht customizable Fehler rausgenommen.@{N}\
1.04 * Fehlermeldungen von /go erweitert.@{N}\
     * Ausgabe der durchlaufenen Knoten und bei /wo.@{N}\
     * Prefix-Makros fuer jeden Wegebefehl eines Bereiches (/cond_go).@{N}\
     * Einbindung von Mapper in /h_move, /wo, bzw. bei /go.@{N}\
     * Bei der Nutzung von verify (/von, /npc) in den Wegen ist jetzt bei einem Hindernis sowohl /c[ontinue] (weiterlaufen, nachdem Hindernis beseitigt ist) als auch /back (zurueck zum letzten passierten Knoten) moeglich.@{N}\
     * /addway zum direkten Hinzufuegen eines Weges.@{N}\
     * Wegen der Konsistenz der Listen werden die Wegelisten vor jeder Veraenderung neu geladen und danach wieder gespeichert.@{N}\
     * Fehler in /renamenode (hoffentlich) behoben ,)@{N}\
1.05 * /gof erlaubt jetzt auch die Angabe des Startknotens (also kein /wo vorher).@{N}\
     * Der Inhalt der Variable %after_go wird jetzt nach dem Ablaufen eines Weges mittels /go ausgefuehrt.@{N}\
     * /para fuer Stroh in /wpara umbenannt.@{N}\
     * Einbindung der Parawelt des Mappers in /wpara und /nopara.@{N}\
     * Neues sehr hilfreiches makro /rush zum schnellen Ablaufen langer, unverzweigter Wege.@{N}\
1.06 (3.11.99) /shownode arbeitet jetzt auch mit Wildcards.@{N}\
1.07 (13.12.99) /go ist in /_go umbenannt worden, damit eigene Kreationen das /go ersetzen koennen. Kandidaten dafuer sind '/gof start ziel' oder '/wgo ziel' (testet den Startknoten) (z.B. /def go = /wgo %*%;).@{N}\
    /break_tri bricht einen Weg ab, wenn ein Triggertext anschlaegt.@{N}\
    /do_tri fuehrt einen Befehl aus und fuehrt den Weg dann fort, wenn der Trigger anschlaegt.@{N}\
1.07 (05.01.00) * /shownode, /nodes_geb und /nodes_info zeigen jetzt auch Aliase richtig an.@{N}\
	* /goto und /gobk optimieren jetzt den Weg (n%;s%; raus), bevor der weg vom letzten Knoten wiederholt bzw. zum letzten Knoten zurueckgegangen wird.@{N}\
	* An den Grenzen der Teilwege gibt es eine Optimierung (n%;s%; raus).
/addh req loading.tf, lists.tf, util.tf, help.tf, in dem Verzeichnis ${world_host}: xtramoves.list.tf, comm_abbr.list.tf, customize.tf, way.list.tf, fromidx.list.tf, toidx.list.tf, lastpoints.list.tf, [nodealias.list.tf]
/addh tut \
Detaillierte Bedienungsanleitung: siehe auch ?wege.@{N}\
Siehe auch ?wegeingabe.@{N}\
Wenn man sich mit Kommandos durch die Gegend bewegt, die in der Liste xtramoves stehen (es sind schon die meisten Richtungskommandos drin), wird der Hin- und Rueckweg mitgeloggt. _Wenn_ man den Weg zurueckgehen koennen will, oder den Weg (ohne editieren) abspeichern will, dann muss man die wegespezifischen Sachen (Spezialkommandos) extra eingeben. Dazu einfach die Taste "0"  auf dem Ziffernblock druecken oder selber "/vorwaerts" eintippen.@{N}\
Es kommt dann: /vorwaerts - dahinter einfach den Befehl eintragen, der dann sofort ausgefuehrt wird und ggf. (bei komplexen Sachen) kommt danach noch ein /rueckwaerts (eventuell mit Vorgabe). Wenn im Weg bei /rueckwaerts oder /vorwaerts nichts kommen soll, dann einfach Enter druecken.@{N}\
Wenn man einen Weg speichern will, tippt man einfach an dem Punkt, wo er enden soll, "/end Name" ein und dann wird der Weg von letztem Punkt zu Name gespeichert; Wenn der Endpunkt schon bekannt ist, reicht auch /end. Noch ein paar Fragen beantworten ... fertig.@{N}\
In den Wegen koennen auch noch witzige Makros enthalten sein (siehe ?wegmakros).@{N}\
Zum Wegebearbeiten exisiteren folgende Kommandos:@{N}\
Mit "/delway" kann man einen Weg aus der Wegeliste loeschen. Es erfolgt eine Abfrage und die Wegeliste wird abgespeichert!!!@{N}\
Mit "/showway from to" kann man sich einen Weg from -> to anzeigen lassen (als Wildcard ist einmal * erlaubt, also alle Wege von/zu einem Punkt).@{N}\
Mit "/editway" kann man Wege nachtraeglich editieren.@{N}\
Knotenkommandos: siehe auch ?knoten@{N}\
"/shownode name" oder "/shownode *" zeigt die Beschreibungen fuer den Knoten oder eine Liste aller Knoten an.@{N}\
"/addnode [name]" ersetzt alle vorhandenen Beschreibungen fuer den aktuellen oder angegebenen Knoten durch die aktuelle Raumbeschreibung.@{N}\
"/appendnode [name]" fuegt die Raumbeschreibung der Liste hinzu.@{N}\
"/delnode [name]" loescht den Knoten und alle Wege, die zu ihm hin- oder von ihm wegfuehren.@{N}\
"/wo" stellt den aktuellen Knoten fest und zeigt ihn an.@{N}\
"/setali" vergibt Aliase fuer Knotennamen (die etwas laenger sein koennen).@{N}

/addh_fileinfo

