;; KOMponenten-Anzeige
;;
;; $Log: koma.tf,v $
;; Revision 1.16  2003/01/04 02:11:11  olm
;; Gesellen- und Magisterguertelunterstuetzung (dran denken:
;; CFG_ZAUBERER_KOMA_USE_GINHALT abschalten! *g*)
;;
;; Revision 1.15  2002/11/22 00:37:34  olm
;; Neue Funktion /koma_kiste. Zeigt den Inhalt von Swifts Zauberkiste im Raum
;; an. Dabei wird unabhaengig vom aktuellen Zweig alles angezeigt.
;;
;; Revision 1.14  2002/09/10 11:42:42  olm
;; Hilfe-Erzeugung ausgebaut, dauert zu lange.
;;
;; Revision 1.13  2002/06/28 22:14:52  nieten
;; Anzeige der Froschschenkel funzt jetzt
;;
;; Revision 1.12  2002/05/14 12:01:32  olm
;; Kerne des daemonischen Kuerbis werden nun auch erkannt.
;;
;; Revision 1.11  2002/04/17 22:21:44  olm
;; Die mumifizierte Hand ist in ginhalt auch abgeschnitten dargestellt, musste
;; noch zur Liste hinzugefuegt werden.
;;
;; Revision 1.10  2002/04/17 22:17:19  olm
;; Ab sofort wird bei /koma die Ausgabe von "ginhalt" getriggert. Dieses
;; Verhalten ist ueber die Variable CFG_ZAUBERER_KOMA_USE_GINHALT abzuschalten.
;; Per CFG_ZAUBERER_KOMA_TRIGGER_GINHALT kann gesteuert werden, ob grund-
;; saetzlich die Ausgabe von "ginhalt" umformatiert werden soll (Default: 0)
;;
;; Revision 1.9  2002/04/17 20:03:48  olm
;; Bugfix: bei einer Leerzeile in einem Makro sollte auch ein Semikolon
;; am Zeilenanfang stehen.
;;
;; Revision 1.8  2002/03/07 13:30:05  olm
;; Ein klein wenig Hilfetexte geschrieben.
;;
;; Revision 1.7  2002/03/04 20:12:09  olm
;; Nun wird der Zweigwechsel auch definitiv erkannt (hoffentlich *g*) - hatte
;; eine falsche Variable verwendet...
;;
;; Revision 1.6  2002/02/21 20:03:41  nieten
;; Formatierung von Haaren und Zungen korrigiert
;;
;; Revision 1.5  2002/02/19 17:55:46  olm
;; /koma_finger entfernt, dafuer wird nun /check_finger aus den
;; mg_properties aufgerufen
;;
;; Revision 1.3  2002/02/14 22:07:32  nieten
;; Nachtigallenzungen eingebaut
;;
;; Revision 1.2  2002/01/26 22:18:34  olm
;; kleiner Bugfix bei der Anzeige der Wandlungs-Kompos
;;
;; Revision 1.1  2002/01/26 22:10:30  olm
;; Komponentenanzeige der Zauberer, Aufruf per /koma
;;
;;
;; Aenderung:
;; 05.11.2001 Dotz@mg.mud.de
;; Efeu, Alkohol und Haare eingebau
;; Halbkaraeter zaehlen auch nur halb
;; --------------------------------------------------------------------

/set koma_tf_version=$Id: koma.tf,v 1.16 2003/01/04 02:11:11 olm Exp $
/set koma_tf_author=Olli@mg.mud.de
/set koma_tf_requires=lists.tf
/set koma_tf_desc=Komponenten-Anzeige der Zauberer

; Soll auf die Ausgabe von "ginhalt" mitgetriggert werden?
/set_var CFG_ZAUBERER_KOMA_TRIGGER_GINHALT 0

; Soll /koma ginhalt des ewigen Guertels benutzen?
/set_var CFG_ZAUBERER_KOMA_USE_GINHALT 1


/addh info \
Die Liste 'koma_zkompo_long' enthaelt die Kurzbeschreibungen der Zauberer\
komponenten. Ueber sie wird den einzelnen Komponenten eine numerische ID \
zugewiesen.
/addh koma_zkompo_long list 

/addh info \
Die Liste 'koma_zkompo_short' enthaelt Kurztexte, ueber die die Anzahl der \
Komponenten in ?koma_echo ausgegeben werden kann.
/addh koma_zkompo_short list 

/addh info \
Die Liste 'koma_zkompo_ewig' enthaelt Zuordnungen der numerischen ID einer \
ewigen Komponente zu der numerischen ID der jeweiligen normalen Komponente.
/addh koma_zkompo_ewig list

/addh info \
INTERN. Erzeugt die notwendigen Komponentenlisten und wird bei Bedarf \
automatisch beim Laden es Pakets ausgefuehrt.
/addh list koma_zkompo_long, koma_zkompo_short, koma_zkompo_ewig
/addh syn /koma_createlists
/addh koma_createlists mak
/def koma_createlists = \
    /echo * Erzeuge Kompontenenliste...%;\
    /hcreatelist koma_zkompo_long%;\
    /hxaddtolist koma_zkompo_long&Flaeschchen mit Eiswasser&1%;\
    /hxaddtolist koma_zkompo_long&Flaeschchen mit Feuerwasser&2%;\
    /hxaddtolist koma_zkompo_long&Flaeschchen mit Drachenblut&3%;\
    /hxaddtolist koma_zkompo_long&Diamanten&4%;\
    /hxaddtolist koma_zkompo_long&Diamant&4%;\
    /hxaddtolist koma_zkompo_long&mumifizierte Hand eines Teufels&5%;\
    /hxaddtolist koma_zkompo_long&mumifizierte Hand eines Teufel&5%;\
    /hxaddtolist koma_zkompo_long&grosser Granitstein&6%;\
    /hxaddtolist koma_zkompo_long&riesige Glaskugel&7%;\
    /hxaddtolist koma_zkompo_long&mumifiziertes Zitteraalherz&8%;\
    /hxaddtolist koma_zkompo_long&Pendel aus reinem Mithril&9%;\
    /hxaddtolist koma_zkompo_long&ewige Saphir&10%;\
    /hxaddtolist koma_zkompo_long&ewige Rubin&11%;\
    /hxaddtolist koma_zkompo_long&endloses Wollknaeul&12%;\
    /hxaddtolist koma_zkompo_long&Lupe&13%;\
    /hxaddtolist koma_zkompo_long&Geologenhammer&14%;\
    /hxaddtolist koma_zkompo_long&grosses Schieferstueck&15%;\
    /hxaddtolist koma_zkompo_long&grosser Blutstein&16%;\
    /hxaddtolist koma_zkompo_long&Sturmvogelfedern&17%;\
    /hxaddtolist koma_zkompo_long&Sturmvogelfeder&17%;\
    /hxaddtolist koma_zkompo_long&Granitstuecke&18%;\
    /hxaddtolist koma_zkompo_long&Granitstueck&18%;\
    /hxaddtolist koma_zkompo_long&Blutsteine&19%;\
    /hxaddtolist koma_zkompo_long&Blutstein&19%;\
    /hxaddtolist koma_zkompo_long&Glasmurmeln&20%;\
    /hxaddtolist koma_zkompo_long&Glasmurmel&20%;\
    /hxaddtolist koma_zkompo_long&Silberpentagramm&21%;\
    /hxaddtolist koma_zkompo_long&Silberpentagramme&21%;\
    /hxaddtolist koma_zkompo_long&Portion Schwefel&23%;\
    /hxaddtolist koma_zkompo_long&Portionen Schwefel&23%;\
    /hxaddtolist koma_zkompo_long&mumifizierte Hand&24%;\
    /hxaddtolist koma_zkompo_long&mumifizierte Haende&24%;\
    /hxaddtolist koma_zkompo_long&einkaraetige Rubine&25%;\
    /hxaddtolist koma_zkompo_long&einkaraetiger Rubin&25%;\
    /hxaddtolist koma_zkompo_long&halbkaraetige Rubine&25%;\
    /hxaddtolist koma_zkompo_long&halbkaraetiger Rubin&25%;\
    /hxaddtolist koma_zkompo_long&ewige Rubin&26%;\
    /hxaddtolist koma_zkompo_long&einkaraetiger Saphir&28%;\
    /hxaddtolist koma_zkompo_long&einkaraetige Saphire&28%;\
    /hxaddtolist koma_zkompo_long&halbkaraetiger Saphir&28%;\
    /hxaddtolist koma_zkompo_long&halbkaraetige Saphire&28%;\
    /hxaddtolist koma_zkompo_long&Phiole mit reinem Wasser&29%;\
    /hxaddtolist koma_zkompo_long&Phiolen mit reinem Wasser&29%;\
    /hxaddtolist koma_zkompo_long&Phiole mit reinem Feuer&30%;\
    /hxaddtolist koma_zkompo_long&Phiolen mit reinem Feuer&30%;\
    /hxaddtolist koma_zkompo_long&halbkaraetiger Topas&31%;\
    /hxaddtolist koma_zkompo_long&halbkaraetige Topase&31%;\
    /hxaddtolist koma_zkompo_long&einkaraetiger Topas&31%;\
    /hxaddtolist koma_zkompo_long&einkaraetige Topase&31%;\
    /hxaddtolist koma_zkompo_long&Kern des grossen Kuerbis&32%;\
    /hxaddtolist koma_zkompo_long&Kerne des grossen Kuerbis&32%;\
    /hxaddtolist koma_zkompo_long&Kerne des daemonischen Kuerbis&32%;\
;   Der folgende Typo ist wirklich so in der P_SHORT.
    /hxaddtolist koma_zkompo_long&Kern des daemonschen Kuerbis&32%;\
    /hxaddtolist koma_zkompo_long&Silbernadel&33%;\
    /hxaddtolist koma_zkompo_long&Silbernadeln&33%;\
    /hxaddtolist koma_zkompo_long&Lasuritstein&34%;\
    /hxaddtolist koma_zkompo_long&Lasuritsteine&34%;\
    /hxaddtolist koma_zkompo_long&Giftefeuzweig&35%;\
    /hxaddtolist koma_zkompo_long&Giftefeuzweige&35%;\
    /hxaddtolist koma_zkompo_long&Zitteraalherz&36%;\
    /hxaddtolist koma_zkompo_long&Zitteraalherzen&36%;\
    /hxaddtolist koma_zkompo_long&Nachtigallenzunge&37%;\
    /hxaddtolist koma_zkompo_long&Nachtigallenzungen&37%;\
    /hxaddtolist koma_zkompo_long&Portion Fledermausblut&38%;\
    /hxaddtolist koma_zkompo_long&Portionen Fledermausblut&38%;\
    /hxaddtolist koma_zkompo_long&Paar Froschschenkel&39%;\
    /hxaddtolist koma_zkompo_long&Schwungfeder von Raben&40%;\
    /hxaddtolist koma_zkompo_long&Schwungfedern von Raben&40%;\
    /hxaddtolist koma_zkompo_long&Modellhaus&41%;\
    /hxaddtolist koma_zkompo_long&Modellhaeuser&41%;\
    /hxaddtolist koma_zkompo_long&rotes Haar&42%;\
    /hxaddtolist koma_zkompo_long&rote Haare&42%;\
    /hxaddtolist koma_zkompo_long&Flaeschchen mit reinem Alkohol&43%;\
    /hxaddtolist koma_zkompo_long&Phiole mit Schweiss von Alptraeumenden&44%;\
    /hxaddtolist koma_zkompo_long&Phiolen mit Schweiss von Alptraeumenden&44%;\
    /hxaddtolist koma_zkompo_long&Phiolen mit Schweiss von Alptraeum&44%;\
    /hxaddtolist koma_zkompo_long&Phiole mit Schweiss von Alptraeume&44%;\
    /hxaddtolist koma_zkompo_long&einkaraetiger Oktarin&45%;\
    /hxaddtolist koma_zkompo_long&einkaraetige Oktarine&45%;\
    /hxaddtolist koma_zkompo_long&halbkaraetiger Oktarin&45%;\
    /hxaddtolist koma_zkompo_long&halbkaraetige Oktarine&45%;\
    /hxaddtolist koma_zkompo_long&leuchtender Stift&46%;\
    /hxaddtolist koma_zkompo_long&leuchtende Stifte&46%;\
    /hxaddtolist koma_zkompo_long&Meteoritenstueck&47%;\
    /hxaddtolist koma_zkompo_long&Meteoritenstuecke&47%;\
    /hxaddtolist koma_zkompo_long&einkaraetiger Smaragd&48%;\
    /hxaddtolist koma_zkompo_long&einkaraetige Smaragde&48%;\
    /hxaddtolist koma_zkompo_long&halbkaraetiger Smaragd&48%;\
    /hxaddtolist koma_zkompo_long&halbkaraetige Smaragde&48%;\
    /hxaddtolist koma_zkompo_long&einkaraetiger Aquamarin&27%;\
    /hxaddtolist koma_zkompo_long&einkaraetige Aquamarine&27%;\
    /hxaddtolist koma_zkompo_long&halbkaraetiger Aquamarin&27%;\
    /hxaddtolist koma_zkompo_long&halbkaraetige Aquamarine&27%;\
    /hxaddtolist koma_zkompo_long&Quarzstein&49%;\
    /hxaddtolist koma_zkompo_long&Quarzsteine&49%;\
    /hxaddtolist koma_zkompo_long&Pendel&50%;\
    /hxaddtolist koma_zkompo_long&Phiole mit einem gebannten Blitz&51%;\
    /hxaddtolist koma_zkompo_long&Phiole mit reiner Erde&52%;\
    /hxaddtolist koma_zkompo_long&Phiole mit reiner Luft&53%;\
    /hxaddtolist koma_zkompo_long&Phiole mit reinem Wasser&54%;\
    /hxaddtolist koma_zkompo_long&Phiole mit reinem Eis&55%;\
    /hxaddtolist koma_zkompo_long&Phiolen mit gebannten Blitzen&51%;\
    /hxaddtolist koma_zkompo_long&Phiolen mit reiner Erde&52%;\
    /hxaddtolist koma_zkompo_long&Phiolen mit reiner Luft&53%;\
    /hxaddtolist koma_zkompo_long&Phiolen mit reinem Wasser&54%;\
    /hxaddtolist koma_zkompo_long&Phiolen mit reinem Eis&55%;\
    /hxaddtolist koma_zkompo_long&Schieferstueck&57%;\
;
    /hxaddtolist koma_zkompo_long&Schieferstuecke&57%;\
    /hxaddtolist koma_zkompo_long&Wollknaeul&58%;\
    /hxaddtolist koma_zkompo_long&Wollknaeule&58%;\
    /hxaddtolist koma_zkompo_long&Phiole Phosphor&60%;\
    /hxaddtolist koma_zkompo_long&Phiolen Phosphor&60%;\
    /hxaddtolist koma_zkompo_long&Pestkroetenklaue&61%;\
    /hxaddtolist koma_zkompo_long&Pestkroetenklauen&61%;\
    /hxaddtolist koma_zkompo_long&Daemonenmaske&62%;\
    /hxaddtolist koma_zkompo_long&Daemonenmasken&62%;\
    /hxaddtolist koma_zkompo_long&Phoenixfeder&63%;\
    /hxaddtolist koma_zkompo_long&Phoenixfedern&63%;\
    /hxaddtolist koma_zkompo_long&Meteoriteneisennadel&64%;\
    /hxaddtolist koma_zkompo_long&Meteoriteneisennadeln&64%;\
    /hxaddtolist koma_zkompo_long&Auge eines Toten&65%;\
    /hxaddtolist koma_zkompo_long&Augen eines Toten&65%;\
    /hxaddtolist koma_zkompo_long&Basiliskenschuppe&66%;\
    /hxaddtolist koma_zkompo_long&Basiliskenschuppen&66%;\
    /hxaddtolist koma_zkompo_long&schlagendes Herz&67%;\
    /hxaddtolist koma_zkompo_long&schlagende Herzen&67%;\
    /hxaddtolist koma_zkompo_long&Flaeschchen Parfum&68%;\
    /hxaddtolist koma_zkompo_long&Portion Lotusbluetenstaub&69%;\
    /hxaddtolist koma_zkompo_long&Portionen Lotusbluetenstaub&69%;\
;
    /createlist koma_zkompo_ewig%;\
    /addtolist koma_zkompo_ewig 5 24%;\
    /addtolist koma_zkompo_ewig 6 18%;\
    /addtolist koma_zkompo_ewig 7 20%;\
    /addtolist koma_zkompo_ewig 8 36%;\
    /addtolist koma_zkompo_ewig 9 50%;\
    /addtolist koma_zkompo_ewig 11 25%;\
    /addtolist koma_zkompo_ewig 13 13%;\
    /addtolist koma_zkompo_ewig 14 14%;\
    /addtolist koma_zkompo_ewig 16 19%;\
    /addtolist koma_zkompo_ewig 26 25%;\
    /addtolist koma_zkompo_ewig 10 28%;\
    /addtolist koma_zkompo_ewig 15 57%;\
    /addtolist koma_zkompo_ewig 12 58%;\
    /createlist koma_zkompo_short%;\
;
    /addtolist koma_zkompo_short dblut 3%;\
    /addtolist koma_zkompo_short fw 2%;\
    /addtolist koma_zkompo_short eis 1%;\
    /addtolist koma_zkompo_short hand 24%;\
    /addtolist koma_zkompo_short haar 42%;\
    /addtolist koma_zkompo_short rubin 25%;\
    /addtolist koma_zkompo_short saphir 28%;\
    /addtolist koma_zkompo_short rabenfeder 40%;\
    /addtolist koma_zkompo_short sturmvogel 17%;\
    /addtolist koma_zkompo_short oktarin 45%;\
    /addtolist koma_zkompo_short aqua 27%;\
    /addtolist koma_zkompo_short smaragd 48%;\
    /addtolist koma_zkompo_short topas 31%;\
    /addtolist koma_zkompo_short lasurit 34%;\
    /addtolist koma_zkompo_short quarz 49%;\
    /addtolist koma_zkompo_short blutstein 19%;\
    /addtolist koma_zkompo_short kuerbiskerne 32%;\
    /addtolist koma_zkompo_short nadel 33%;\
    /addtolist koma_zkompo_short aalherz 36%;\
    /addtolist koma_zkompo_short murmel 20%;\
    /addtolist koma_zkompo_short pendel 50%;\
    /addtolist koma_zkompo_short granit 18%;\
    /addtolist koma_zkompo_short diamant 4%;\
    /addtolist koma_zkompo_short schweiss 44%;\
    /addtolist koma_zkompo_short pblitz 51%;\
    /addtolist koma_zkompo_short pwasser 29%;\
    /addtolist koma_zkompo_short pfeuer 30%;\
    /addtolist koma_zkompo_short perde 52%;\
    /addtolist koma_zkompo_short pluft 53%;\
    /addtolist koma_zkompo_short pwasser 54%;\
    /addtolist koma_zkompo_short peis 55%;\
    /addtolist koma_zkompo_short schwefel 23%;\
    /addtolist koma_zkompo_short stifte 46%;\
    /addtolist koma_zkompo_short schiefer 57%;\
    /addtolist koma_zkompo_short fledermaus 38%;\
    /addtolist koma_zkompo_short knaeul 58%;\
    /addtolist koma_zkompo_short lupe 13%;\
    /addtolist koma_zkompo_short hammer 14%;\
    /addtolist koma_zkompo_short phosphor 60%;\
    /addtolist koma_zkompo_short pkklaue 61%;\
    /addtolist koma_zkompo_short dmaske 62%;\
    /addtolist koma_zkompo_short phoenix 63%;\
    /addtolist koma_zkompo_short menadel 64%;\
    /addtolist koma_zkompo_short auge 65%;\
    /addtolist koma_zkompo_short haus 41%;\
    /addtolist koma_zkompo_short schuppe 66%;\
    /addtolist koma_zkompo_short herz 67%;\
    /addtolist koma_zkompo_short parfum 68%;\
    /addtolist koma_zkompo_short lotusbluete 69%;\
    /addtolist koma_zkompo_short efeu 35%;\
    /addtolist koma_zkompo_short alk 43%;\
    /addtolist koma_zkompo_short penta 21%;\
    /addtolist koma_zkompo_short zunge 37%;\
    /addtolist koma_zkompo_short meteor 47%;\
    /addtolist koma_zkompo_short schenkel 39%;\
    /hsavelist -c koma_zkompo_long%;\
    /savelist -c koma_zkompo_ewig%;\
    /savelist -c koma_zkompo_short%;

/hloadlist -q -c koma_zkompo_long
/loadlist -q -c koma_zkompo_ewig
/loadlist -q -c koma_zkompo_short

/addh info \
Ueberprueft, ob die uebergebene Kurzbeschreibung zu einer Zaubererkomponente \
passt. Ist dies der Fall, so wird die numerische ID zurueckgeliefert. Handelt \
es sich um eine ewige Komponente, so wird die numerische ID der jeweiligen \
normalen Komponente zurueckgeliefert, und die Variable ?koma_ewig wird auf \
1 gesetzt.
/addh syn /isZKompo p_short
/addh ex /isZKompo Flaeschchen mit Feuerwasser
/addh isZKompo mak
/def isZKompo = \
    /set koma_ewig=0%;\
    /hgetvalueof koma_zkompo_long %*%;\
    /let id=%value%;\
    /if (id=~error) /result error%;/endif%;\
    /getvalueof koma_zkompo_ewig %id%;\
    /if (value!~error) \
	/set koma_ewig=1%;\
	/let id=%value%;\
    /endif%;\
    /result id%;

/addh info INTERN.
/addh getCount mak
/def getCount = /result ({*}=/"[0-9]*")?{*}:1

/addh info \
INTERN. Definiert den Trigger fuer den Guertelinhalt, und weist den jeweil\
igen IDs die Anzahlen zu.
/addh syn /koma_getlines_unt
/addh koma_getlines_unt mak
/def koma_getlines_unt = \
    /def -mregexp -ag -p9999 -t"^(Eine?|Der|Die|Coronas|[0-9]+) ([^.]+)[.]( [(]([0-9]+)[)])?( +(Eine?|Der|Die|Coronas|[0-9]+) ([^.]+)[.]( [(]([0-9]+)[)])?)?" t_koma_02 = \
	/let id=$$[isZKompo({P2})]%%;\
	/let old=%%;\
	/if (id!~error) \
	    /let cnt=$$[getCount({P1})]%%;\
; zwei Halbkaraeter = ein Einkaraeter
	    /if (strstr({P2},"halbkaraetige")==0) \
	        /test cnt:=cnt/2%%;\
	    /endif%%;\
	    /let mult=%%P4%%;\
	    /if (mult=~"") /let mult=1%%;/endif%%;\
	    /test old:=\{koma_inv_%%id\}%%;\
	    /if (old!=-1) \
		/if (koma_ewig==1) \
		    /set koma_inv_%%id=-1%%;\
		/else \
		    /set koma_inv_%%id=$$[old+cnt*mult]%%;\
		/endif%%;\
	    /endif%%;\
	/endif%%;\
	/if ({P7}!~"") \
	    /let id=$$[isZKompo({P7})]%%;\
	    /if (id!~error) \
		/let cnt=$$[getCount({P6})]%%;\
		/if (strstr({P7},"halbkaraetige")==0) \
	            /test cnt:=cnt/2%%;\
		/endif%%;\
		/let mult=%%P9%%;\
		/if (mult=~"") /let mult=1%%;/endif%%;\
		/test old:=\{koma_inv_%%id\}%%;\
		/if (old!=-1) \
		    /if (koma_ewig==1) \
			/set koma_inv_%%id=-1%%;\
		    /else \
			/set koma_inv_%%id=$$[old+cnt*mult]%%;\
		    /endif%%;\
		/endif%%;\
	    /endif%%;\
	/endif%;\
	/def -1 -msimple -ag -p9999 -t"Du hast kein Alias \\"endtrigger_koma\\" definiert." t_koma_03 = \
	    /purge t_koma_02*%%;\
	    /koma_display%;

/def -ag -msimple -p9998 \
	-t'--- Guertelinhalt: -----------------------------------------------------------' \
	t_koma_ginhalt = \
	/if (CFG_ZAUBERER_KOMA_TRIGGER_GINHALT==1) \
		/koma_getlines_ginhalt%;\
	/else \
		/echo - --- Guertelinhalt: -----------------------------------------------------------%;\
	/endif%;

/addh info \
INTERN. Definiert den Trigger fuer den Guertelinhalt per ginhalt, und weist den jeweil\
igen IDs die Anzahlen zu.
/addh syn /koma_getlines_ginhalt
/addh koma_getlines_ginhalt mak
/def koma_getlines_ginhalt = \
    /let j=$[hcount_entries('koma_zkompo_long')]%;\
    /let i=1%;\
    /while (i<=j) \
            /unset koma_inv_%i%;\
            /let i=$[i+1]%;\
    /done%;\
    /def -mregexp -ag -p9999 -t"([0-9]+) ([^0-9]+)(([0-9]+) ([^0-9]+))?" t_koma_02 = \
        /let id=$$[isZKompo({P2})]%%;\
        /let old=%%;\
        /if (id!~error) \
            /let cnt=$$[getCount({P1})]%%;\
; zwei Halbkaraeter = ein Einkaraeter
            /if (strstr({P2},"halbkaraetige")==0) \
                /test cnt:=cnt/2%%;\
            /endif%%;\
            /test old:=\{koma_inv_%%id\}%%;\
            /if (old!=-1) \
                /if (koma_ewig==1) \
                    /set koma_inv_%%id=-1%%;\
                /else \
                    /set koma_inv_%%id=$$[old+cnt]%%;\
                /endif%%;\
            /endif%%;\
        /endif%%;\
        /if ({P4}!~"") \
            /let id=$$[isZKompo({P5})]%%;\
            /if (id!~error) \
                /let cnt=$$[getCount({P4})]%%;\
                /if (strstr({P5},"halbkaraetige")==0) \
                    /test cnt:=cnt/2%%;\
                /endif%%;\
                /test old:=\{koma_inv_%%id\}%%;\
                /if (old!=-1) \
                    /if (koma_ewig==1) \
                        /set koma_inv_%%id=-1%%;\
                    /else \
                        /set koma_inv_%%id=$$[old+cnt]%%;\
                    /endif%%;\
                /endif%%;\
            /endif%%;\
        /endif%;\
	/def -1 -msimple -ag -p9999 -t'--- ewig: --------------------------------------------------------------------' t_koma_03 = \
		/undef t_koma_02%%;\
		/koma_getlines_ginhalt_ewig%;

/def koma_getlines_ginhalt_ewig = \
	/def -mglob -t'*' -ag -p9998 t_koma_03 = \
		/let koma_gl1=$$[substr({*},0,38)]%%;\
		/let koma_gl2=$$[substr({*},38)]%%;\
		/get_param -1 %%koma_gl1%%;\
		/let koma_gl1=%%?%%;\
        	/let id=$$[isZKompo(koma_gl1)]%%;\
                /if (koma_ewig==1) \
                    /set koma_inv_%%id=-1%%;\
		/endif%%;\
		/if (strlen(koma_gl2)>0) \
			/get_param -1 %%koma_gl2%%;\
			/let koma_gl2=%%?%%;\
			/let id=$$[isZKompo(koma_gl2)]%%;\
			/if (koma_ewig==1) \
				/set koma_inv_%%id=-1%%;\
			/endif%%;\
		/endif%;\
	/def -1 -msimple -ag -p9999 -t'------------------------------------------------------------------------------' t_koma_04 = \
		/purge t_koma_03%%;\
		/koma_display%;


/addh info \
Mit dieser Funktion wird der Guertelinhalt eines Zauberers in immer dem \
gleichen Format dargestellt. "ginhalt" des ewigen Guertels liefert zwar \
etwas aehnliches, nur ist da die Reihenfolge der Komponenten nicht fest\
gelegt.
/addh syn /koma
/addh koma mak
/def koma = \
	/if (CFG_ZAUBERER_KOMA_USE_GINHALT==1) \
		/koma_ginhalt%;\
	/else \
		/koma_unt%;\
	/endif%;

/def koma_ginhalt = \
	/if (CFG_ZAUBERER_KOMA_TRIGGER_GINHALT!=1) \
		/def -1 -ag -msimple -p9999 \
                       -t'--- Guertelinhalt: -----------------------------------------------------------' \
			t_koma_ginhalt_once = \
    			/koma_getlines_ginhalt%;\
	/endif%;\
	!ginhalt

/def koma_unt_intern = \
        /set koma_displayall=%;\
        /koma_getlines_unt%;\
        !alias endtrigger_koma%;
			

/def koma_unt = \
    /set koma_guertel=%;\
    /let j=$[hcount_entries('koma_zkompo_long')]%;\
    /let i=1%;\
    /while (i<=j) \
            /unset koma_inv_%i%;\
            /let i=$[i+1]%;\
    /done%;\
    /def -msimple -ag -p9999 -1 -F -t"Dieser Guertel wirkt gleichermassen anmutig als auch furchteinfloessend auf" t_koma_e01 = \
    	/undef t_koma_e08%%;\
	/undef t_koma_e12%%;\
	/set koma_guertel=ewig%%;\
    	/def -msimple -ag -p9999 -1 -F -t"Dich. Ein volles Dutzend schimmernder kalkweisser Knochenplaettchen ziert in" t_koma_e02%%;\
    	/def -msimple -ag -p9999 -1 -F -t"voellig gleichen Abstaenden das breite silberfarbene Band aus unzaehlbar" t_koma_e03%%;\
    	/def -msimple -ag -p9999 -1 -F -t"vielen filigranen Kettengliedern. Die Guertelschnalle passt hervorragend in" t_koma_e04%%;\
    	/def -msimple -ag -p9999 -1 -F -t"dieses Arrangement: Auf einer Brosche aus schwarz glaenzendem Onyx prangt ein" t_koma_e05%%;\
    	/def -msimple -ag -p9999 -1 -F -t"hellichter Strahlenkranz aus langen spitzen Zaehnen! Wem moegen die wohl mal" t_koma_e06%%;\
    	/def -msimple -ag -p9999 -1 -F -t"gehoert haben?" t_koma_e07%%;\
    	/def -msimple -ag -p9999 -1 -F -t"Er enthaelt:" t_koma_01 = \
		/koma_unt_intern%;\
    /def -msimple -ag -p9999 -1 -F -t"Dies ist ein einfacher Guertel, wie ihn die Gesellen der Akademie der" t_koma_e08 = \
    	/undef t_koma_e01%%;\
	/undef t_koma_e12%%;\
    	/set koma_guertel=Gesellen%%;\
    	/def -msimple -ag -p9999 -1 -F -t"geistigen Kraft zu Taramis tragen. Er ist schlicht gehalten und weist keine" t_koma_e09%%;\
	/def -msimple -ag -p9999 -1 -F -t"ueberfluessigen Verzierungen auf - wohl aber zahlreiche Beutel, die fuer die" t_koma_e10%%;\
	/def -msimple -ag -p9999 -1 -F -t"Komponenten gedacht sind." t_koma_e11%%;\
	/def -msimple -ag -p9999 -1 -F -t"Er enthaelt:" t_koma_01 = \
		/koma_unt_intern%;\
    /def -msimple -ag -p9999 -1 -F -t"Dies ist ein reich geschmueckter Guertel, wie ihn die Magister der Akademie" t_koma_e12 = \
   	/undef t_koma_e01%%;\
	/undef t_koma_e08%%;\
	/set koma_guertel=Magister%%;\
	/def -msimple -ag -p9999 -1 -F -t"der geistigen Kraft zu Taramis tragen. Er ist reich in den Farben der Gilde -" t_koma_e13%%;\
	/def -msimple -ag -p9999 -1 -F -t"purpur, gold und blau - geschmueckt und verfuegt ueber zahlreiche kleine" t_koma_e14%%;\
	/def -msimple -ag -p9999 -1 -F -t"Beutel, in denen Zauberkomponenten aufbewahrt werden koennen." t_koma_e15%%;\
	/def -msimple -ag -p9999 -1 -F -t"Er enthaelt:" t_koma_01 = \
		/koma_unt_intern%;\
    !unt guertel in mir%;

/def koma_kiste = \
    /let j=$[hcount_entries('koma_zkompo_long')]%;\
    /let i=1%;\
    /while (i<=j) \
            /unset koma_inv_%i%;\
            /let i=$[i+1]%;\
    /done%;\
    /def -msimple -ag -p9999 -1 -F -t'Eine kleine Kiste aus Birnbaumholz. Da diesem seltenen Holz selbst magische' t_koma_e01%;\
    /def -msimple -ag -p9999 -1 -F -t'Faehigkeiten nachgesagt werden, ist es wohl das ideale Material, um die' t_koma_e02%;\
    /def -msimple -ag -p9999 -1 -F -t'teilweise gefaehrlichen Komponenten eines Zauberers darin unterzubringen.' t_koma_e03%;\
    /def -msimple -ag -p9999 -1 -F -t'Die Zauberkiste ist geoeffnet.' t_koma_e04%;\
    /def -msimple -ag -p9999 -1 -F -t'Die Zauberkiste ist geschlossen.' t_koma_e05 = \
	/purge t_koma_e*%%;\
	/purge t_koma_01%%;\
	/def -msimple -ag -p9999 -1 -F -t'Du oeffnest eine Zauberkiste.' t_koma_oeffnen%%;\
	!oeffne zauberkiste%%;\
	/koma_kiste%;\
    /def -msimple -ag -p9999 -1 -F -t'Sowas siehst Du da nicht!' t_koma_e06 = \
	/purge t_koma_e*%%;\
	/purge t_koma_01%%;\
        /echo -p @{Cwhite}--@{Cyellow}--@{Cwhite}[ @{Cmagenta}KOMA: Keine Kiste vorhanden!%;\
    /def -msimple -ag -p9999 -1 -F -t'Sie enthaelt:' t_koma_01 = \
	/set koma_displayall=1%%;\
	/koma_getlines_unt%%;\
	!alias endtrigger_koma%;\
    !unt zauberkiste in raum

/addh info \
INTERN. Liefert zu einer uebergebenen KurzID die Anzahl der vorhandenen \
Komponenten, mit dem jeweiligen Ausgabeformat versehen (?koma_format).
/addh see koma_format
/addh syn /koma_echo_variable kurzid
/addh ex /koma_echo_variable alk
/addh koma_echo_variable mak
/def koma_echo_variable = \
    /let kev_pos=$[strchr({*},':')]%;\
    /if (kev_pos!=-1) \
	/let kev_name=$[substr({*},0,kev_pos)]%;\
	/let kev_pad=$[substr({*},kev_pos+1)]%;\
    /else \
	/let kev_name=%*%;\
	/let kev_pad=%;\
    /endif%;\
    /if (kev_name=/"[0-9]*") \
	/let kev_id=%kev_name%;\
    /else \
	/getvalueof koma_zkompo_short %kev_name%;\
	/if (value=~error) /result '#NAME?'%;/endif%;\
	/let kev_id=%value%;\
    /endif%;\
    /let count=%;\
    /test count:=\{koma_inv_%kev_id\}%;\
    /let kev_formatfkt=1%;\
    /test kev_formatfkt:=\{koma_format_%kev_name\}%;\
    /let kev_format=n%;\
    /if (kev_formatfkt!~"") \
	/if (count==-1) /let count=9999999%;/endif%;\
	/test kev_format:=%kev_formatfkt%;\
	/if (count==9999999) /let count=-1%;/endif%;\
    /endif%;\
    /if (count==-1) /let count=ew.%;/endif%;\
    /if (kev_name=~"lupe") \
	/result strcat("@{",kev_format,"}","Lupe")%;\
    /endif%;\
    /if (kev_name=~"hammer") \
	/result strcat("@{",kev_format,"}","Hammer")%;\
    /endif%;\
    /if (kev_pad!~"") \
	/result strcat("@{",kev_format,"}",pad(count,kev_pad))%;\
    /else \
	/result strcat("@{",kev_format,"}",count)%;\
    /endif%;

/addh info \
Gibt eine Textzeile aus, in der Vorkommen von KurzIDs durch die entsprech\
enden Anzahlen ersetzt werden. Die KurzIDs werden dabei von '&' eingeschlos\
sen. Die Ausgabe kann ausserdem rechtsbuendig auf eine gewisse Anzahl von \
Stellen formatiert werden. \
Es wird immer der Wert genommen, der bei der letzten Aktualisierung per \
/koma festgestellt wurde.
/addh syn /koma_echo formatstring
/addh ex /koma_echo Feuerwasser: &fw&
/addh ex /koma_echo Eiswaasser:  &eis:3&
/addh koma_echo mak
/def koma_echo = \
    /let ke_out=%;\
    /let line=%;\
    /test line:={*}%;\
    /let pos=$[strchr(line,'&')]%;\
    /while (pos!=-1) \
	/test ke_out:=strcat(ke_out,substr(line,0,pos))%;\
	/test line:=substr(line,pos+1)%;\
	/let pos1=$[strchr(line,'&')]%;\
	/if (pos1==-1) \
	    /echo %% koma_echo: unmatched &%;\
	    /return%;\
	/else \
	    /let varname=$[substr(line,0,pos1)]%;\
	    /test line:=substr(line,pos1+1)%;\
	    /test ke_out:=strcat(ke_out,koma_echo_variable(varname))%;\
	/endif%;\
	/let pos=$[strchr(line,'&')]%;\
    /done%;\
    /test echo(strcat(ke_out,line),'',1)%;

/addh info Gibt die Magisterkomponenten des Zweigs Verwandlung aus.
/addh syn /koma_display_zweig_verwandlung
/addh koma_display_zweig_verwandlung mak
/def koma_display_zweig_verwandlung = \
    /echo -p @{Cwhite}--@{Cyellow}--@{Cwhite}[ @{Cmagenta}Magisterzweig: @{Cyellow}Wandlung @{Cwhite}]@{Cyellow}--@{Cwhite}--------------------------------------%;\
    /koma_echo @{Cyellow}P@{Ccyan}hiolen: @{Cyellow}Blitz &pblitz:3&  @{Cyellow}Eis &peis:3&  @{Cyellow}Erde &perde:3&  @{Cyellow}Feuer &pfeuer:3&  @{Cyellow}Luft &pluft:3&  @{Cyellow}Wasser &pwasser:3&%;\
    /koma_echo @{Cyellow}K@{Ccyan}erne      @{Cwhite}(@{Cblue}s.verw.@{Cwhite})   &kuerbiskerne:3&%;\
    /if (koma_displayall=~"") \
        /echo -aCwhite - -----------------------------------------------------------------------%;\
    /endif

/addh info Gibt die Magisterkomponenten des Zweigs Angriff aus.
/addh syn /koma_display_zweig_angriff
/addh koma_display_zweig_angriff mak
/def koma_display_zweig_angriff = \
    /echo -p @{Cwhite}--@{Cyellow}--@{Cwhite}[ @{Cmagenta}Magisterzweig: @{Cyellow}Angriff @{Cwhite}]@{Cyellow}--@{Cwhite}---------------------------------------%;\
    /koma_echo @{Cyellow}M@{Ccyan}eteorit   @{Cwhite}(@{Cblue}erdbeben@{Cwhite})  &meteor:3&     @{Cyellow}P@{Ccyan}hospor  @{Cwhite}(@{Cblue}fwalze@{Cwhite})    &phosphor:3&%;\
    /koma_echo @{Cyellow}P@{Ccyan}estkr.kl. @{Cwhite}(@{Cblue}todesz.@{Cwhite})   &pkklaue:3&%;\
    /if (koma_displayall=~"") \
        /echo -aCwhite - -----------------------------------------------------------------------%;\
    /endif

/addh info Gibt die Magisterkomponenten des Zweigs Illusion aus.
/addh syn /koma_display_zweig_illusion
/addh koma_display_zweig_illusion mak
/def koma_display_zweig_illusion = \
    /echo -p @{Cwhite}--@{Cyellow}--@{Cwhite}[ @{Cmagenta}Magisterzweig: @{Cyellow}Illusion @{Cwhite}]@{Cyellow}--@{Cwhite}--------------------------------------%;\
    /koma_echo @{Cyellow}S@{Ccyan}chweiss   @{Cwhite}(@{Cblue}gefaehrte@{Cwhite}) &schweiss:3&     @{Cyellow}M@{Ccyan}aske    @{Cwhite}(@{Cblue}dfratze@{Cwhite})   &dmaske:3&%;\
    /koma_echo @{Cyellow}P@{Ccyan}hoenixf.  @{Cwhite}(@{Cblue}verw.@{Cwhite})     &phoenix:3&%;\
    /if (koma_displayall=~"") \
        /echo -aCwhite - -----------------------------------------------------------------------%;\
    /endif

/def koma_display_zweig_hellsicht = \
    /echo -p @{Cwhite}--@{Cyellow}--@{Cwhite}[ @{Cmagenta}Magisterzweig: @{Cyellow}Hellsicht @{Cwhite}]@{Cyellow}--@{Cwhite}-------------------------------------%;\
    /koma_echo @{Cyellow}D@{Ccyan}iamant    @{Cwhite}(@{Cblue}wahrsagen@{Cwhite}) &diamant:3&     @{Cyellow}M@{Ccyan}.nadel  @{Cwhite}(@{Cblue}vorahnung@{Cwhite}) &menadel:3&%;\
    /koma_echo @{Cyellow}A@{Ccyan}ugen      @{Cwhite}(@{Cblue}observ.@{Cwhite})   &phoenix:3&%;\
    /if (koma_displayall=~"") \
        /echo -aCwhite - -----------------------------------------------------------------------%;\
    /endif

/addh info Gibt die Magisterkomponenten des Zweigs Abwehr aus.
/addh syn /koma_display_zweig_abwehr
/addh koma_display_zweig_abwehr mak
/def koma_display_zweig_abwehr = \
    /echo -p @{Cwhite}--@{Cyellow}--@{Cwhite}[ @{Cmagenta}Magisterzweig: @{Cyellow}Abwehr @{Cwhite}]@{Cyellow}--@{Cwhite}----------------------------------------%;\
    /koma_echo @{Cyellow}S@{Ccyan}chuppen   @{Cwhite}(@{Cblue}zschild@{Cwhite})   &schuppe:3&     @{Cyellow}H@{Ccyan}aus     @{Cwhite}(@{Cblue}schutzz.@{Cwhite})  &haus:3&%;\
    /koma_echo @{Cyellow}H@{Ccyan}erz       @{Cwhite}(@{Cblue}bann@{Cwhite})      &herz:3&%;\
    /if (koma_displayall=~"") \
        /echo -aCwhite - -----------------------------------------------------------------------%;\
    /endif

/addh info Gibt die Magisterkomponenten des Zweigs Beherrschung aus.
/addh syn /koma_display_zweig_beherrschung
/addh koma_display_zweig_beherrschung mak
/def koma_display_zweig_beherrschung = \
    /echo -p @{Cwhite}--@{Cyellow}--@{Cwhite}[ @{Cmagenta}Magisterzweig: @{Cyellow}Beherrschung @{Cwhite}]@{Cyellow}--@{Cwhite}----------------------------------%;\
    /koma_echo @{Cyellow}P@{Ccyan}arfum     @{Cwhite}(@{Cblue}bezaubere@{Cwhite}) &parfum:3&     @{Cyellow}L@{Ccyan}otusbl. @{Cwhite}(@{Cblue}irritiere@{Cwhite}) &lotusbluete:3&%;\
    /koma_echo @{Cyellow}P@{Ccyan}entagramm @{Cwhite}(@{Cblue}beschwoere@{Cwhite})      &penta:3&%;\
    /if (koma_displayall=~"") \
	/echo -aCwhite - -----------------------------------------------------------------------%;\
    /endif

/addh info INTERN.
/addh koma_display_zweig_ mak
/def koma_display_zweig_ = /nop

/addh info \
Gibt die vorhandenen Komponenten aus, wie sie beim letzten Aufruf von /koma \
festgestellt wurden.
/addh syn /koma_display
/addh koma_display mak
/def koma_display = \
    /echo -p @{Cwhite}--@{Cyellow}--@{Cwhite}[ @{Cmagenta}Komponenten @{Cwhite}]@{Cyellow}--@{Cwhite}--------------------------------------------------%;\
    /koma_echo @{Cyellow}H@{Ccyan}andkompos: @{Cyellow}Feuer &fw:3&  @{Cyellow}Eis &eis:3&  @{Cyellow}Dblut &dblut:3&                   &lupe& &hammer&%;\
    /echo -aCwhite - -----------------------------------------------------------------------%;\
    /koma_echo @{Cyellow}S@{Ccyan}turmvogel @{Cwhite}(@{Cblue}schnell@{Cwhite})   &sturmvogel:3&     @{Cyellow}M@{Ccyan}urmel   @{Cwhite}(@{Cblue}finde@{Cwhite})     &murmel:3&%;\
    /koma_echo @{Cyellow}R@{Ccyan}abenfeder @{Cwhite}(@{Cblue}schatten@{Cwhite})  &rabenfeder:3&     @{Cyellow}P@{Ccyan}endel   @{Cwhite}(@{Cblue}befriede@{Cwhite})  &pendel:3&%;\
    /koma_echo @{Cyellow}B@{Ccyan}lutsteine @{Cwhite}(@{Cblue}fb@{Cwhite})        &blutstein:3&     @{Cyellow}G@{Ccyan}ranit   @{Cwhite}(@{Cblue}rueste@{Cwhite})    &granit:3&%;\
    /koma_echo @{Cyellow}N@{Ccyan}adeln     @{Cwhite}(@{Cblue}schmerzen@{Cwhite}) &nadel:3&     @{Cyellow}F@{Ccyan}lederm. @{Cwhite}(@{Cblue}nachts.@{Cwhite})   &fledermaus:3&%;\
    /koma_echo @{Cyellow}H@{Ccyan}aende     @{Cwhite}(@{Cblue}xhand@{Cwhite})     &hand:3&     @{Cyellow}S@{Ccyan}chiefer @{Cwhite}(@{Cblue}huelle@{Cwhite})    &schiefer:3&%;\
    /koma_echo @{Cyellow}A@{Ccyan}alherz    @{Cwhite}(@{Cblue}blitz@{Cwhite})     &aalherz:3&     @{Cyellow}S@{Ccyan}chwefel @{Cwhite}(@{Cblue}teleport@{Cwhite})  &schwefel:3& @{Cwhite}(&stifte:3& @{Ccyan}Stifte@{Cwhite})%;\
    /koma_echo @{Cyellow}W@{Ccyan}ollknaeul @{Cwhite}(@{Cblue}erschaffe@{Cwhite}) &knaeul:3&     @{Cyellow}E@{Ccyan}feu     @{Cwhite}(@{Cblue}giftpfeil@{Cwhite}) &efeu:3&%;\
    /koma_echo @{Cyellow}H@{Ccyan}aar       @{Cwhite}(@{Cblue}erzwinge@{Cwhite})  &haar:3&     @{Cyellow}A@{Ccyan}lkohol  @{Cwhite}(@{Cblue}rausch@{Cwhite})    &alk:3&%;\
    /koma_echo @{Cyellow}Z@{Ccyan}ungen     @{Cwhite}(@{Cblue}illusion@{Cwhite})  &zunge:3&     @{Cyellow}S@{Ccyan}chenkel @{Cwhite}(@{Cblue}frosche@{Cwhite})   &schenkel:3&%;\
    /echo -aCwhite - -----------------------------------------------------------------------%;\
    /koma_echo @{Cyellow}E@{Ccyan}delsteine: @{Cyellow}Rubin &rubin:3&  @{Cyellow}Saphir  &saphir:3&  @{Cyellow}Topas &topas:3&  @{Cyellow}Oktarin &oktarin:3&%;\
    /test koma_echo('            @{Cyellow}Aquam &aqua:3&  @{Cyellow}Smaragd &smaragd:3&  @{Cyellow}Quarz &quarz:3&  @{Cyellow}Lasurit &lasurit:3&')%;\
    /echo%;\
    /if (koma_displayall!~"") \
	/koma_display_zweig_angriff%;\
	/koma_display_zweig_abwehr%;\
	/koma_display_zweig_verwandlung%;\
	/koma_display_zweig_beherrschung%;\
	/koma_display_zweig_illusion%;\
	/set koma_displayall=%;\
	/koma_display_zweig_hellsicht%;\
    /else \
	/koma_display_zweig_%p_sub_guild%;\
    /endif

; Trigger, um den Zweigwechsel zu erkennen
/def -msimple -t"OK, Du bist freiwillig zurueckgetreten." koma_ruecktritt = \
    /set p_sub_guild=%;

/def -msimple -t"Herzlichen Glueckwunsch zu Deiner Position!" koma_neuerzweig = \
    /check_finger%;\


/if (hcount_entries("koma_zkompo_long")!=129) \
    /koma_createlists%;\
/endif

/if (p_sub_guild=~"") \
    /check_finger%;\
/endif%;

/if (!ismacro("mload")) \
    /eval /echo -paCcyan >>> Lade Datei: @{Cyellow}$[pad('koma.tf', -19)] @{Ccyan} - $[pad('Komponenten-Anzeige', 41)]%;\
/endif

;; HILFE

;/def hgetkeyofvalue_intern = \
;	/if (hgetkeyofvalue_result=~"") \
;		/set hkg1=%1%;\
;		/shift%;\
;		/set hkg2=%-L1%;\
;		/set hkg3=%L1%;\
;		/if (hkg1=~hkg3) \
;			/set hgetkeyofvalue_result=%hkg2%;\
;		/endif%;\
;	/endif%;

;/def hgetkeyofvalue = \
;	/set hgetkeyofvalue_result=%;\
;	/hforeach %1 kv /hgetkeyofvalue_intern %-1%;\

;/if (build_help=~1) \
;	/def koma_buildhelp1 = \
;	        /hgetkeyofvalue koma_zkompo_long %%2%%;\
;		/addh info Variable, die folgende Anzahl enthaelt: %%hgetkeyofvalue_result%%;\
;		/addh koma_inv_%%2 var%%;\
;	        /addh info Anzeigeformat fuer: %%hgetkeyofvalue_result%%;\
;	        /addh koma_format_%%1 cfg%;\
;	/forEach koma_zkompo_short kv /koma_buildhelp1%;\
;	/undef koma_buildhelp1%;\
;/endif%;

/addh info \
KOMponenten-Anzeige fuer die Zauberergilde im MorgenGrauen (mg.mud.de)@{N}\
Ueber /koma wird der Guertelinhalt eingelesen und in einer uebersichtlichen, \
immer gleich aufgebauten Darstellung angezeigt.
/addh req lists.tf
/addh see koma
/addh_fileinfo

