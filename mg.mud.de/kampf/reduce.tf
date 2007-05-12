
;;; reduce.tf - der Nachfolger von Ringors legendaerem kampfmeldungen.tf

/set reduce_tf_version $Id: reduce.tf,v 2.22 2004/07/16 08:27:32 thufhnik Exp $
/set reduce_tf_author=Thufhir@mg.mud.de
/set reduce_tf_requires=util.vfunc.tf util.hooks.tf
/set reduce_tf_desc=Kampfscrollreduzierer

; ALLGEMEINE SACHEN (WICHTIG!!!!)
; Dieses File tut im Prinzip das gleiche wie Ringors kampfmeldungen.tf es 
; getan haben. Leider laessen sich die kampfmeldungen an originaler Stelle
; nicht mehr finden.
;
; Mit Ringors Einverstaendnis habe ich einige Aenderungen vorgenommen und 
; dieses File entstehen lassen.
; Die Nutzung dieses Files setzt voraus, dass Ringor mit keinem, aber auch
; absolut _keinem_ Fehler, der durch die Nutzung entsteht oder entstanden 
; sein koennte, belaestigt wird. Das Debuggen und die eventuelle Hilfe zur 
; Installation uebernehme ich, also belaestigt den Kampfzerg bitte nicht 
; und beschert ihm unnoetige Arbeit, sondern wendet Euch vertrauensvoll an 
; den Zauberzwerg also an mich (Thufhir!).
; Vielen Dank an die ausdauernden Betatester Ahab, Asuka und Eldaron!
; 
; HINWEISE 
; Wichtig: einmal tippen: "angriffsmeldung an"... das kurzinfo hat wenig
; Sinn...
; Nachdem die kampfmeldungen.tf vom author aus dem Netz genommen wurden
; muesste ich die Ausgaben irgendwann mal dokumentieren...
; evtl. darf ich die ja zitieren, ich werde den Meister in der naechsten
; Zeit mal bitten...
;
; Generell hat sich intern einiges geaendert, zB. habe ich einige Trigger -
; meiner Einschaetzung nach - sauberer gemacht und die meisten Trigger sind
; nur aktiv, wenn sie wirklich gebraucht werden. Weiterhin sind einige 
; Spells der Tanjian und neue Meldungen beim Verletze & Giftpfeil der Zauberer 
; hinzugekommen. Die Treffermeldungen des Wasserstrahls der Katzenkrieger 
; haben ein voellig falsches Bild geliefert (kein Wunder, dass die 
; alle irgendwie deprimiert sind, voellig unterschaetzt der Spell). Auch sind
; in reduce.tf bereits weitere kleinere Abwehrhelfer und die 
; Karatekombinationen beruecksichtigt (auch wenn sie noch keine Auswirkungen 
; haben).
;
; Kleinere Schaeden koennen jetzt ausgeblendet werden, das heisst sie werden
; einfach nicht mehr angezeigt, siehe hierzu: /re_damage_ignore
;
; Weitere Ergaenzungen werden dann in neuen Versionsnummern
; dokumentiert.
;
; Die Sterne, besser gesagt das was keine Sterne sind, bedeuten Folgendes:
; (Danke, Eldaron, dass du ein wenig Ordnung reingebracht hast. ;)
; R*******  Ziel bekommt Rueckendeckung von einem Spieler.
; 2*******  Ziel bekommt Rueckendeckung von zwei Spielern. 3-n analog dazu ;-)
; *S******  Ziel hat den Schlag mit Schildparade abgewehrt. Bei 'magenta' war
;           man selbst das Ziel, 'gelb' steht fuer die Parade eines Gegners.
; **P*****  Ziel hat den Schlag mit Waffenparade abgewehrt. Farben siehe oben.
; ***S****  SMS-Abwehr (Schwert oder Speer)
; ***K****  Kieferknochen
; ***D****  Drachenschuppe(Abwehr)
; ***H****  Drachenschuppe(Heilung)
; ***M****  der Magiewesenzahn zieht MP
; ***L****  der Magiewesenzahn zieht LP
; ***2****  SMS+Knochen/Schuppe(Abwehr)
; ***2****  SMS+Schuppe(Heilung) (andere Farbe)
; ****R***  Paracelsus' gruene Robe
; ****U***  Bambis Umhang
; ****T***  Tsunamis Toga heilt
; ****E***  Eistrollschamanenpanzer
; ****G***  Panzer der Gier hat gesaugt
; ****M***  Robe der Magie gibt KP zurueck
; ****A***  Aura der Delfen
; ****Z***  Zauberschild
; ****2***  ESP + Umhang oder sonst was von oben
; *****G**  Silvanas Gluecksbringer
; *****K**  Morgoths Himmelkreuz oder das Kreuz aus der Gruft
; *****N**  Nonnes Nixenhaaar
; *****A**  Grummelbeisseramuletit
; *****O**  Obsidianamulett von Ananas
; ******T*  Toeters Totenschaedel
; ******H*  Morgoths Eishelm
; ******P*  Tillys Pudelmuetze
; ******M*  Tsunamis Myrthenkranz
; ******C*  Tillys Chaosball
; ******A*  Die Maske von Patryns Riesen
; ******F*  Feuerhelm
; ******2*  2 der letzten 7 Items
; ******3*  3 der letzten 7 Items usw.
; *******D  Paracelsus' Drachenring
; *******A  AFR oder AER
; *******R  so ein roetlich leuchtender Ring
; *******E  der oktarine Ring aus Para-Moulokin saugt einem Feind Energie
; *******S  der oktarine Ring aus Para-Moulokin saugt einem selbst Energie
; *Xxxxx**  Ziel hat mit einer Karatetechnik abgewehrt. Bei eigener Abwehr
;           bedeutet 'magenta' eine gelungene und 'rot' eine misslungene
;           Abwehr. Analog dazu werden die Farben 'gelb' und 'blau' fuer 
;           Karate-Abwehr von Gegnern benutzt.
; *Auswe**  ein Karateka oder Kaempfer weicht Magie aus
; *DeSch**  Schutzschild der Dunkelelfen
;
; Fuer mich und fuer Euch hier nochmal die Meldungen mit den
; entsprechenden Schaeden (vorweg die Nummern die in RE_SCHADEN dafuer
; stehen)
;       1  verfehlt:       0
;       2  gekitzelt:      1
;       3  gekratzt:       2-3
;       4  getroffen:      4-5
;       5  hart:           6-10
;       6  sehr hart:      10-20
;       7  Krachen:        21-30
;       8  Schmettern:     31-50
;       9  Brei:           51-75
;      10  Pulver:         76-100
;      11  zerstaeubt:     101-150
;      12  atomisiert:     151-200
;      13  vernichtet:     201+
;      15  fehler:         ---
; 101-114  maximum:        je nach wert s.o.
;
;
;       Variablenname      I Farbe fuer        I Defaultwert
;       ===================I===================I==================
;       RE_FARBE_1/38/51   I verfehlen         I n
;       RE_FARBE_2/39/52   I kitzeln           I Cgreen
;       RE_FARBE_3/40/53   I kratzen           I Cgreen
;       RE_FARBE_4/41/54   I treffen           I Cyellow
;       RE_FARBE_5/42/55   I hart              I Cyellow
;       RE_FARBE_6/43/56   I sehr hart         I Cyellow
;       RE_FARBE_7/44/57   I Krachen           I Cmagenta
;       RE_FARBE_8/45/58   I zerschmettern     I Cmagenta
;       RE_FARBE_9/46/59   I zu Brei           I Cred
;       RE_FARBE_10/47/60  I pulverisieren     I Cred
;       RE_FARBE_11/48/61  I zerstaeuben       I Cbgred
;       RE_FARBE_12/49/62  I atomisieren       I Cbgred
;       RE_FARBE_13/50/63  I vernichten        I Cbgmagenta
;       -------------------I-------------------I------------------
;       RE_FARBE_14        I normale Angriffe  I Cgreen
;       RE_FARBE_15        I Extras Zauberer   I Cmagenta
;       RE_FARBE_16        I Extras Kaempfer   I Cmagenta
;       RE_FARBE_17        I Todesstoss lasch  I Cgreen
;       RE_FARBE_18        I Todesstoss toedl. I Cred
;       RE_FARBE_19        I Taktik Kaempfer   I Cyellow
;       RE_FARBE_20        I Karate            I Cyellow
;       RE_FARBE_21        I andere Gilden     I Cmagenta
;       RE_FARBE_22        I Artillerie        I Cblue
;       -------------------I-------------------I------------------
;       RE_FARBE_23        I eigene Ab. gelung.I Cmagenta
;       RE_FARBE_24        I eigene Ab. missl. I Cred
;       RE_FARBE_25        I fremde Ab. gelung.I Cyellow
;       RE_FARBE_26        I fremde Ab. missl. I Cblue
;       RE_FARBE_27        I SMS/Kieferknochen I Cgreen
;       RE_FARBE_28        I                   I Cgreen
;       RE_FARBE_29        I Amu               I Cmagenta
;       RE_FARBE_30        I Heilung           I Cmagenta
;       -------------------I-------------------I------------------
;       RE_FARBE_31        I Waffe geraten     I Cred
;       RE_FARBE_32        I Opfer: Du         I Cred
;       RE_FARBE_33        I Opfer: Gegner     I Cgreen
;       RE_FARBE_34        I Opfer: andere     I n
;       RE_FARBE_35        I Standard-Farbe    I n
;       RE_FARBE_36        I Fehler            I Cbgblue
;       RE_FARBE_37        I Waffen-Funktionen I Cred
;       ===================I===================I==================
;
; Konfiguration der Ausgabezeile:
; ===============================
;
; Die Standard-Ausgabezeile hat folgendes Format:
;
;                             Angreifer         Opfer     Abwehr   Pfeil      
;                                 |               |          |     |     
;   ....normal/Schwert..... Du........... : Gegner....... ******** -> hart
;        |    |    |                      |                             |
;        Angriffsart                 Fuellzeichen            Trefferstaerke
;
; Die Reihenfolge der Ausgabe dieser Bloecke kann frei konfiguriert werden.
; Lediglich der Block 'Angriffsart' ist eine feste Kombination von drei 
; einzelnen Elementen, die innerhalb dieses Blockes nicht umsortiert werden 
; koennen. 
;
; Je nach gewuenschter Reihenfolge ist es vielleicht angebracht, das 
; Fuellzeichen umzudefinieren oder ganz zu loeschen. Wenn ein anderes Zeichen
; als der ':' ausgegeben werden soll, muss die Variable 'RE_FUELLZEICHEN' das
; gewuenschte Zeichen enthalten. Soll auf die Ausgabe des Fuellzeichens ganz
; verzichtet werden, muss die Variable 'RE_FUELLZEICHEN' den Begriff 'Nichts'
; enthalten; wird sie einfach nur geloescht, wird der Standard ':' benutzt!
;
; In jedem Fall *muessen* aber alle sieben Bloecke definiert werden. Auch wenn
; das Fuellzeichen auf 'Nichts' gesetzt ist, muss der Block trotzdem in der
; Definition der Ausgabezeile an einer Stelle auftauchen.
;
; Die eigentliche Definition der Ausgabezeile geschieht nun nach dem Schema
; "/set RE_ELEMENT_<nummer>=<blockname>". Es muss jede <nummer> von 1 bis 7
; definiert werden. Fuer <blockname> sind die aus der obigen Skizze 
; ersichtlichen Namen einzutragen.
;
; Die Standard-Ausgabezeile erhaelt man dann mit folgenden Zeilen:
;
;     /set RE_ELEMENT_1=Angriffsart
;     /set RE_ELEMENT_2=Angreifer
;     /set RE_ELEMENT_3=Fuellzeichen
;     /set RE_ELEMENT_4=Opfer
;     /set RE_ELEMENT_5=Abwehr
;     /set RE_ELEMENT_6=Pfeil
;     /set RE_ELEMENT_7=Trefferstaerke
;
;
; Die Konfiguration der Treffermeldungen:
; =======================================
;
; Wer statt der Texte wie "zu Brei" vielleicht lieber Zahlenwerte ausgegeben
; haben moechte oder lieber eigene Texte haette, der kann die Treffermeldungen
; frei konfigurieren.
;
; Fuer die Treffermeldungen stehen zehn Zeichen zur Verfuegung. Werden 
; laengere Texte angegeben, so werden diese entsprechend gekuerzt. 
;
; Fuer jeden zu aendernden Text muss ein Befehl nach dem Muster
; "/set RE_SCHADEN_<nummer>=<text>" im Konfigurationsfile angegeben werden.
;
; Die einzelnen Originalmeldungen sind in folgender Tabelle mit den
; entsprechenden Variablennamen aufgelistet:
;
;        Variablenname I   Meldung   II  Variablenname I  Meldung
;        ==============+=============++================+===========
;        RE_SCHADEN_1  I verfehlt    II  RE_SCHADEN_9  I zu Brei    
;        RE_SCHADEN_2  I gekitzelt   II  RE_SCHADEN_10 I Pulver
;        RE_SCHADEN_3  I gekratzt    II  RE_SCHADEN_11 I zerstaeubt
;        RE_SCHADEN_4  I getroffen   II  RE_SCHADEN_12 I atomisiert
;        RE_SCHADEN_5  I hart        II  RE_SCHADEN_13 I vernichtet
;        RE_SCHADEN_6  I sehr hart   II  RE_SCHADEN_14 I Maximum!
;        RE_SCHADEN_7  I Krachen     II  RE_SCHADEN_15 I Fehler!
;        RE_SCHADEN_8  I Schmettern  II
;        ==========================================================
;
;
; HISTORY
;
; $Log: reduce.tf,v $
; Revision 2.22  2004/07/16 08:27:32  thufhnik
; Meldung fuer Blitzhand wurde erweitert
;
; Revision 2.21  2004/05/10 10:43:27  chbr
; Gloinsons Sahnetorten sollen auch ensprechend gewuerdigt werden
;
; Revision 2.20  2004/03/24 09:12:25  thufhnik
; kleiner Bugfix in Kami Wind
;
; Revision 2.19  2004/03/23 10:12:28  thufhnik
; - /re_purge_some ist jetzt mit in /re_loeschen und somit gestrichen
; - /re_loeschen wird jetzt auch in /re_angriff aufgerufen
; - Ein * extra im Waffenwurf fuer Blicke
;
; Revision 2.18  2004/03/15 11:12:42  thufhnik
; Ein par kleinere CFode-Optimierungen
;
; Revision 2.17  2003/10/12 19:25:35  thufhnik
; Kleine Bereinigung in re_attack_break
;
; Revision 2.16  2003/10/12 19:01:20  thufhnik
; Runenschwerter im Schwerttanz der Delfen
;
; Revision 2.15  2003/09/05 12:07:45  thufhnik
; hngl, der bug war noch ganz anders gelagert. ;(
;
; Revision 2.14  2003/09/05 11:55:47  thufhnik
; in Aura war noch ein kleiner Bug
;
; Revision 2.13  2003/08/24 20:29:34  thufhnik
; Delfen Aura
;
; Revision 2.12  2003/08/24 16:04:59  thufhnik
; Delfen Entziehe
; Delfen Parade (bei den Kaempfern mit im Trigger)
; Delfen Schutzschild auch passiv
;
; Revision 2.11  2003/08/11 09:17:08  thufhnik
; - Gildenspezifische Sachen nur noch laden wenn gebraucht, alle Leute, die
;   mehrere chars in einem Fenster benutzen bitte in der reduce.cfg:
;   /set RE_MULTIPLAYER_TF 1
; - Kleiner Bugfix in der Feuerlanze
;
; Revision 2.10  2003/08/05 16:21:30  thufhnik
; Dunkelelfenschild
;
; Revision 2.9  2003/06/23 14:24:29  thufhnik
; Waffenfunktionen des Kriegshamsters
;
; Revision 2.8  2003/06/16 14:25:54  thufhnik
; Bugfix in der Waffenfkt. des Zynh
;
; Revision 2.7  2003/06/16 14:10:59  thufhnik
; Zombiering wurde umgebaut
;
; Revision 2.6  2003/02/28 11:15:23  thufhnik
; Bugfix im Daemonenreport
;
; Revision 2.5  2003/02/25 14:43:19  thufhnik
; kleine Ergaenzung zum Feuerhelm
;
; Revision 2.4  2002/11/22 18:58:11  thufhnik
; regexp benutzen PCRE wenn vorhanden
;
; Revision 2.0  2002/10/30 20:59:56  thufhnik
; Trigger-Prioritaeten ueberarbeitet
; Trigger bereinigt (neu entstandene Bugs dabei leider moeglich!)
; alte Logs geloescht
; Feuerball der Zauberer hat ne neue Meldung bekommen
;
;
;
;   T O D O
;  =========
; - Grummelbeisserdolch (Waffenfunktion?): Der Grummeldolch grummelt <bla>.
; - Bei Arashi die Laehmung in die Abwehr: <bla> wirkt etwas desorientiert.
;   (wird wahrscheinlich leider nicht gehen, da die Meldung NACH der Schaden-
;   meldung kommt und der Angriff bereits ausgegeben wurde
; - /re_damage_ignore dokumentieren...
; - Prioritaeten der Trigger muessen mal konsistent umgebaut werden
; - Wenn Waffennamen oder Spells spezielle Sachen enthalten zB "*Eis*" dann
;   koennte man das entsprechend einfaerben
; - Die Variablennamen fuer die Farben sind wirklich nicht besonders schoen
;   bei Zeiten mal umbauen, so dass auch reduce.cfg und reduce.def kompatibel
; - Bugs ausbauen... (sind da welche? ;)


;;; Alte Defs aus dem Speicher loeschen

;/purge -mglob re_*
;/purge remove_reduce

;;; defines, falls nicht cvs-tf

/if /!ismacro set_var%; /then \
	/def set_var=/set %*%;\
/endif

/if /!ismacro ifdef%; /then \
	/def ifdef = \
		/if /test %%{1}%%; /then \
			/def %%-1%%;\
		/endif%;\
/endif

;;; Konfigurierbare Sachen

/set_var RE_MULTIPLAYER_TF 0

/set_var RE_FARBE_ESP Cgreen
/set_var RE_FARBE_RINGE Cmagenta
/set_var RE_FARBE_TSCH Cmagenta

; Messerkreis
/set_var RE_FARBE_MK Cbgmagenta
/set_var RE_TRENNER_MK==
; Steintrollpanzer
/set_var RE_FARBE_STP Cgreen
/set_var RE_TRENNER_STP S

;;; Variablen initialisieren

/set RE_BUMI_START 0
/set RE_BUMI_FANG 0
/set RE_BUMI_STOP 0
/set RE_BUMI_RAUS_START 0
/set RE_BUMI_RAUS_STOP 0

/for RE_i 0 9 /set RE_BUMI_RAUS_%RE_i ???
/for RE_i 0 9 /set RE_BUMI_WERFER_%RE_i ???
/set RE_SCHADEN=
/set RE_KARATE_AUSNAHMEN \
	Awase-zuki Awz \
	Fumikomi-geri Fog \
	Hasami-zuki Haz \
	Kagi-zuki Kaz \
	Kizami-zuki Kiz \
	Mae-geri-keage Mgka \
	Mawashi-geri Mag \
	Heito-uke Htu \
	Kakiwake-uke Kiu \
	Keito-uke Keu \
	Morote-tsukami-uke Motsu \
	Shuto-uke Shu \
	Soto-sukui-uke Ssuu \
	Uchi-sukui-uke Usuu \
	STOP 
/set_var RE_FARBLISTE n Cgreen Cgreen Cyellow Cyellow Cyellow Cmagenta \
	Cmagenta Cred Cred Cbgred,Cwhite Cbgred,Cwhite Cbgmagenta,Cwhite \
	Cgreen Cmagenta Cmagenta Cgreen Cred Cyellow Cyellow Cmagenta Cblue \
	Cmagenta Cred Cyellow Cblue Cgreen Cgreen Cmagenta Cmagenta Cred Cred \
	Cgreen n n Cbgblue,Cwhite Cred n Cgreen Cgreen Cyellow Cyellow \
	Cyellow Cmagenta Cmagenta Cred Cred Cbgred,Cwhite Cbgred,Cwhite \
	Cbgmagenta,Cwhite n Cgreen Cgreen Cyellow Cyellow Cyellow Cmagenta \
	Cmagenta Cred Cred Cbgred,Cwhite Cbgred,Cwhite Cbgmagenta,Cwhite STOP
/set_var RE_SCHADENLISTE verfehlt.gekitzelt.gekratzt.getroffen.hart.sehr hart.\
	Krachen.Schmettern.zu Brei.Pulver.zerstaeubt.atomisiert.vernichtet.\
	Maximum!.Fehler!.STOP
/set_var RE_FUELLZEICHEN :
/set_var RE_PT _
/set_var RE_ELEMENT_1 Angriffsart
/set_var RE_ELEMENT_2 Angreifer
/set_var RE_ELEMENT_3 Fuellzeichen
/set_var RE_ELEMENT_4 Opfer
/set_var RE_ELEMENT_5 Abwehr
/set_var RE_ELEMENT_6 Pfeil
/set_var RE_ELEMENT_7 Trefferstaerke
/set_var RE_IGNORIERE=
/set_var RE_IGNORIERE_AKTIV 0
/set_var RE_IGNORIERE_POSITIV 1
/set_var RE_DAM_IGNORE 0
/set_var RE_DAM_IGNORE_WHO 0

/for RE_i 1 10 /set RE_PT%RE_i=0
/for RE_i 1 10 /test RE_PT%RE_i:=strrep(RE_PT,RE_i)

;; Statusanzeige ein (in Kampfzeilen)
/set_var RE_STATUS_SHOW 0
;; Statusanzeige anhaengen an Matrix/Fokus usw. Meldung
/set_var RE_STATUS_APPEND 0
;; kurze Statusanzeige statt Matrixmeldung
/set_var RE_STATUS_SIMPLE 1
;; hier kann ein Usermakro drin stehen, das den Status ausgibt
;; Parameter %1 Status in %, %-1 Name NPC
;/set_var RE_STATUS_ECHO_USER
;; Farben in Kampfzeilen, wenn 0 dann Prozente im Fuellzeichen
/set_var RE_STATUS_COLOR 1
;; Attribute fuer Matrixmeldung, Kurzanzeige
/set_var RE_STATUS_ATTR Cblue

;; Farben fuer Statuscodierung in Kampfzeilen
/set_var RE_STATUS_ATTR_100 BCblue
/set_var RE_STATUS_ATTR_90 Cblue
/set_var RE_STATUS_ATTR_80 BCgreen
/set_var RE_STATUS_ATTR_70 Cgreen
/set_var RE_STATUS_ATTR_60 BCyellow
/set_var RE_STATUS_ATTR_50 Cyellow
/set_var RE_STATUS_ATTR_40 BCred
/set_var RE_STATUS_ATTR_30 Cred
/set_var RE_STATUS_ATTR_20 Br
/set_var RE_STATUS_ATTR_10 r
/set_var RE_STATUS_ATTR_0 n


;;; Alle Macros und Trigger koennen per Befehl wieder entfernt werden:

/def remove_reduce = \
	/echo -paCred >>> Entferne Paket: @{Cyellow}reduce.tf%;\
	/echo%;\
	/if /ismacro free_regexp%; /then \
		/free_regexp RE_REGEXP_*%;\
	/endif%;\
	/quote -S /unset `"/listvar -mglob -s RE_*%;\
	/quote -S /unset `"/listvar -mglob -s reduce_tf_*%;\
	/purge -mglob re_*%;\
	/purge remove_reduce


;;; Ist kampfmeldungen.tf von Ringor noch geladen? Dann muss es geloescht
;;; werden... die Trigger kommen sich verstaendlicherweise in die Quere

/def re_del_kampfmeldungen=\
	/if /ismacro remove_kampfmeldungen%; /then \
		/remove_kampfmeldungen%;\
	/endif


;;; Nicht konfigurierte Variablen auf Defaultwerte setzen

/def re_setcolours=\
	/let RE_FARBZAEHLER 1%;\
	/while (RE_FARBLISTE !~ 'STOP') \
		/if /test RE_FARBE_%{RE_FARBZAEHLER} =~ ''%; /then \
			/set RE_FARBE_%RE_FARBZAEHLER $[substr(RE_FARBLISTE,0,\
				strstr(RE_FARBLISTE, ' '))]%;\
		/endif%;\
		/test ++RE_FARBZAEHLER%;\
		/set RE_FARBLISTE $[substr(RE_FARBLISTE, \
			strstr(RE_FARBLISTE, ' ')+1)]%;\
	/done


;;; Nicht konfigurierte Treffermeldungen auf Defaultwerte setzen

/def re_setschaeden=\
	/let RE_SCHADENZAEHLER 1%;\
	/let RE_SPuffer 1%;\
	/while (RE_SCHADENLISTE !~ 'STOP') \
		/if /test RE_SCHADEN_%{RE_SCHADENZAEHLER} =~ ''%; /then \
			/set RE_SCHADEN_%RE_SCHADENZAEHLER \
				$[substr(RE_SCHADENLISTE, 0, \
				strstr(RE_SCHADENLISTE, '.'))]%;\
		/else \
			/test RE_SPuffer := RE_SCHADEN_%{RE_SCHADENZAEHLER}%;\
			/test RE_SCHADEN_%{RE_SCHADENZAEHLER} := \
				substr(RE_SPuffer, 0, 10)%;\
		/endif%;\
		/test ++RE_SCHADENZAEHLER%;\
		/set RE_SCHADENLISTE $[substr(RE_SCHADENLISTE, \
			strstr(RE_SCHADENLISTE, '.')+1)]%;\
	/done


;;; Variablen, die jede Kampfrunde geloescht werden
 
/def re_loeschen=\
	/set RE_SCHADEN_OUT=%;\
	/set RE_SCHADEN_SUB 0%;\
	/set RE_KARATE 0%;\
	/set RE_KARATE_ABWEHR=%;\
	/set RE_AFR *%;\
	/set RE_AMU *%;\
	/set RE_SMS *%;\
	/set RE_TSCH *%;\
	/set RE_ESP *%;\
	/set RE_SCHILD *%;\
	/set RE_PARADE *%;\
	/set RE_RDECKUNG *%;\
	/set RE_WAFFE ???%;\
	/set RE_ABWEHR *%;\
	/set RE_OPFER ???%;\
	/set RE_ANGREIFER ???%;\
	/set RE_TMP_FUELLZEICHEN=%;\
	/set RE_TMP_TRENNER=%;\
	/set RE_TMP_TRENNER_OPFER=%;\
	/set RE_SICHER @{%RE_FARBE_35}/@{%RE_FARBE_35}%;\
	/set RE_ART %RE_PT4@{%RE_FARBE_14}normal@{%RE_FARBE_35}%;\
	/purge re_nixenhaar_1%;\
	/if ((time() - RE_TAN_ZEIT) > 9 & RE_TAN_TMP !~ '') \
		/purge -mglob re_tan_kshira_s*%;\
		/set RE_TAN_TMP=%;\
	/endif


;;; Das Ausgabemakro frei konfiguriert zusammenbasteln
 
/def re_ausgabezeile_basteln=\
	/let RE_ELEMENT 1%;\
	/let RE_i 1%;\
	/while (RE_i < 8) \
		/test RE_ELEMENT := RE_ELEMENT_%{RE_i}%;\
		/if (RE_ELEMENT =~ '') \
			/let RE_ELEMENT <leer>%;\
		/endif%;\
		/if (RE_ELEMENT =/ 'Angriffsart') \
			/let RE_AUSGABEZEILE $[strcat(RE_AUSGABEZEILE, \
				' %RE_ART%RE_SICHER%RE_WAFFE')]%;\
                /elseif (RE_ELEMENT =/ 'Angreifer') \
			/let RE_AUSGABEZEILE $[strcat(RE_AUSGABEZEILE, \
				' %RE_ANGREIFER')]%;\
                /elseif (RE_ELEMENT =/ 'Fuellzeichen') \
			/if (RE_FUELLZEICHEN !/ 'nichts') \
			    /set RE_FUELLZEICHEN=$[substr(RE_FUELLZEICHEN, 0, 1)]%;\
			    /let RE_AUSGABEZEILE $[strcat(RE_AUSGABEZEILE, \
					' %{RE_TMP_FUELLZEICHEN-%RE_FUELLZEICHEN}')]%;\
			/endif%;\
		/elseif (RE_ELEMENT =/ 'Opfer') \
			/let RE_AUSGABEZEILE $[strcat(RE_AUSGABEZEILE, \
				' %RE_OPFER')]%;\
		/elseif (RE_ELEMENT =/ 'Abwehr') \
			/let RE_AUSGABEZEILE $[strcat(RE_AUSGABEZEILE, \
				' %RE_ABWEHR')]%;\
		/elseif (RE_ELEMENT =/ 'Pfeil') \
			/let RE_AUSGABEZEILE $[strcat(RE_AUSGABEZEILE, \
				' %RE_TRENNER')]%;\
		/elseif (RE_ELEMENT =/ 'Trefferstaerke') \
			/let RE_AUSGABEZEILE $[strcat(RE_AUSGABEZEILE, \
				' %RE_SCHADEN_OUT')]%;\
		/else \
			/let RE_FEHLER 1%;\
			/echo -aCred Unbekanntes Element '%RE_ELEMENT' in \
				Variable 'RE_ELEMENT_%RE_i'!%;\
		/endif%;\
		/test ++RE_i%;\
	/done%;\
	/if (RE_FEHLER !~ '') \
		/echo -aCred Benutze die Standard-Ausgabezeile!%;\
		/def re_ausgabe_zeile=\
			/echo -w -p @{%%RE_FARBE_35}  \
				%%RE_ART%%RE_SICHER%%RE_WAFFE \
				%%RE_ANGREIFER : %%RE_OPFER %%RE_ABWEHR \
				%%RE_TRENNER %%RE_SCHADEN%;\
	/else \
		/let RE_AUSGABEZEILE $[strcat('/echo -w -p @{%RE_FARBE_35}  ', \
			RE_AUSGABEZEILE)]%;\
		/def re_ausgabe_zeile=%RE_AUSGABEZEILE%;\
	/endif


;;; Die konfigurierten Treffermeldungstexte auf zehn Zeichen einruecken
 
/def re_treffer_einruecken=\
	/if (RE_ELEMENT_7 =/ 'Trefferstaerke') \
		/for RE_i 1 18 /set RE_MELDUNG_PRE_%%RE_i=%;\
		/for RE_i 1 18 /set RE_MELDUNG_POST_%%RE_i=%;\
	/else \
		/for RE_i 1 18 /set RE_MELDUNG_PRE_%%RE_i=%;\
		/let RE_i 1%;\
		/let RE_Laenge 1%;\
		/while (RE_i < 19) \
			/test RE_Laenge := RE_SCHADEN_%RE_i%;\
			/set RE_MELDUNG_POST_%RE_i=$[strrep(RE_PT, \
				10-strlen(RE_Laenge))]%;\
			/test ++RE_i%;\
		/done%;\
	/endif


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;                   Verschiedene  Routinen                   ;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;; Angriffsmeldungen koennen 2zeilig sein... *fluch* wer gibt Monstern
;;; so haesslich lange Namen und Waffen?

/def -mregexp -agCblue -Fp999999 -q -mregexp -t'^  [A-Z].+ greifs?t ' \
	re_attack_break = \
	/set RE_BREAKBUFFER=%;\
	/if ({PR} !/ '*.') \
		/test RE_BREAKBUFFER:=strcat({P0},{PR})%;\
		/re_str_can_break2%;\
	/else \
		/test substitute(strcat({P0},{PR}), 'x')%;\
	/endif

;;; Einige Treffermeldungen werden umgebrochen.... ;(
;;; Wenn das passieren kann, sollte vor den Treffer-triggern dieses Macro
;;; aufgerufen werden

/def re_str_can_break=\
	/purge -mglob re_str_can_break_tr*%;\
	/set RE_BREAKBUFFER=%;\
	/def -1 -mregexp -agCblue -Fp9999999 -q -mregexp -t'^  [A-Z]' \
		re_str_can_break_tr1 = \
		/if ({PR} !/ '*.' & {PR} !/ '*!') \
			/test RE_BREAKBUFFER:=strcat({P0},{PR})%%;\
			/re_str_can_break2%%;\
		/endif

/def re_str_can_break2=\
	/def -1 -mregexp -agCblue -Fp9999999 -q -mregexp -t'^  ([^ ].*[.!])$$' \
		re_str_can_break_tr2 = \
		/test RE_BREAKBUFFER:=strcat(RE_BREAKBUFFER,' ',{P1})%%;\
		/test substitute(RE_BREAKBUFFER)


;;; Nuetzliche Mini-Makros, die den Code etwas lesbarer machen
 
/def re_waffe_geraten=\
	/set RE_SICHER @{%RE_FARBE_31}/@{%RE_FARBE_35}%;\

/def re_genitiv_loeschen=\
	/let RE_Genitiv %{*}%;\
	/if ((RE_Genitiv =/ '*s') | (RE_Genitiv =/ '*\'')) \
		/let RE_Genitiv $[substr(RE_Genitiv, 0, -1)]%;\
	/endif%;\
	/echo -- %RE_Genitiv


;;; Karate-Namen ordentlich kuerzen.
;;; Aus "Hau-drauf-wie-nix" wird ein handliches "Hdwn" - jetzt inkl. Ausnahmen.
 
/def re_karatekuerzen=\
	/let RE_Karate %{*}%;\
	/let RE_Zeiger $[strstr(RE_KARATE_AUSNAHMEN, strcat(RE_Karate, ' '))]%;\
	/if (RE_Zeiger >= 0) \
		/let RE_Karate $[substr(RE_KARATE_AUSNAHMEN, \
			RE_Zeiger+strlen(RE_Karate)+1)]%;\
		/echo -- $[substr(RE_Karate, 0, strstr(RE_Karate, ' '))]%;\
	/else \
		/let RE_Puffer $[substr(RE_Karate, 0, 1)]%;\
		/while /let RE_i $[strstr(RE_Karate, '-')]%; /test RE_i >= 0%;\
		    /do \
			/let RE_Puffer $[strcat(RE_Puffer, substr(RE_Karate, \
				RE_i+1, 1))]%;\
			/let RE_Karate $[substr(RE_Karate, RE_i+1)]%;\
		/done%;\
		/echo -- %RE_Puffer%;\
	/endif


;;; Artikel aus Namen rauskuerzen
 
/def re_artikelkuerzen=\
	/if (regmatch(RE_REGEXP_ARTICLE, {*})) \
		/set RE_ARTICLE 1%;\
		/echo -- %PR%;\
	/else \
		/set RE_ARTICLE 0%;\
		/echo -- %{*}%;\
	/endif


;;; Namen kuerzen. Hoffentlich kann man nachher noch erahnen, was es
;;; heissen soll ;-)

/def re_namekuerzen=\
	/if ({#} < 2) \
		/echo -- ???%;\
		/return%;\
	/endif%;\
	/let RE_Pufferzeile %{-1}%;\
	/let RE_Laenge %{1}%;\
	/if (strlen(RE_Pufferzeile) > RE_Laenge+3) \
		/if (regmatch(RE_REGEXP_NAMEKUERZEN, RE_Pufferzeile)) \
			/let RE_Puffer %P0%;\
		/else \
			/if /let RE_NPuffer $[strrchr(RE_Pufferzeile, ' ')]%;\
				/test RE_NPuffer >= 0%; /then \
				/let RE_Puffer $[substr(RE_Pufferzeile, \
					RE_NPuffer)]%;\
			/else \
				/let RE_Puffer %RE_Pufferzeile%;\
			/endif%;\
		/endif%;\
	/else \
		/let RE_Puffer %RE_Pufferzeile%;\
	/endif%;\
	/if (strlen(RE_Puffer) > RE_Laenge+3) \
		/let RE_Puffer $(/re_leerzeichenkuerzen %RE_Puffer)%;\
	/endif%;\
	/echo -- $[substr(RE_Puffer, 0, RE_Laenge)]


;;; Namen mit Leerzeichen und/oder '-' kuerzen
 
/def re_leerzeichenkuerzen=\
	/let RE_Puffer2 %{*}%;\
	/while /let RE_i $[strchr(RE_Puffer2, '- .')]%; \
	    /test ((RE_i >= 0) & (strlen(RE_Puffer2) > RE_i+1))%; /do \
		/let RE_Puffer3 $[strcat(RE_Puffer3, substr(RE_Puffer2, 0, \
			(RE_i+2)/3), substr(RE_Puffer2, RE_i, 1) =~ '-' ? \
			'-' : RE_PT)]%;\
	        /let RE_Puffer2 $[substr(RE_Puffer2, RE_i+1)]%;\
	/done%;\
	/let RE_Puffer3 %RE_Puffer3%RE_Puffer2%;\
	/echo -- %{RE_Puffer3}


;;; 'Verbotene' Zeichen im Angreifer-Namen umwandeln

/def re_namekorrigieren=\
	/echo $[replace('\'', '_', \
		replace('`', '_', \
		replace('?', '_', \
		replace(' ', '_', \
		replace('.', '_', \
		replace(',', '_', \
		replace('-', '_', {*})))))))]
	
;;; Die Abwehr-Anzeige zusammenbasteln

/def re_abwehr=\
	/if (RE_RDECKUNG !~ '*') \
		/if (RE_OPFER =~ 'Dich') \
			/set RE_ABWEHR @{%RE_FARBE_23}%{RE_RDECKUNG}\
				@{%RE_FARBE_35}%;\
		/else \
			/set RE_ABWEHR @{%RE_FARBE_25}%{RE_RDECKUNG}\
				@{%RE_FARBE_35}%;\
		/endif%;\
	/endif%;\
	/if (RE_TSCH !~ '*') \
		/set RE_TSCH @{%RE_FARBE_29}%{RE_TSCH}@{%RE_FARBE_35}%;\
	/endif%;\
	/if (RE_AFR !~ '*') \
		/set RE_AFR @{%RE_FARBE_RINGE}%{RE_AFR}@{%RE_FARBE_35}%;\
	/endif%;\
	/if (RE_KARATE) \
        	/set RE_KARATE_ABWEHR $[strcat(RE_KARATE_ABWEHR, '@{', \
			RE_FARBE_35, '}', strrep('*', 5-strlen(\
			RE_KARATE_ABWEHR)))]%;\
		/if (RE_KARATE == 4) \
			/set RE_ABWEHR $[strcat(RE_ABWEHR, '@{', RE_FARBE_23, \
				'}', RE_KARATE_ABWEHR, RE_TSCH, RE_AFR)]%;\
        	/elseif (RE_KARATE == 3) \
			/set RE_ABWEHR $[strcat(RE_ABWEHR, '@{', RE_FARBE_25, \
				'}', RE_KARATE_ABWEHR, RE_TSCH, RE_AFR)]%;\
		/elseif (RE_KARATE == 2) \
			/set RE_ABWEHR $[strcat(RE_ABWEHR, '@{', RE_FARBE_24, \
				'}', RE_KARATE_ABWEHR, RE_TSCH, RE_AFR)]%;\
		/else \
			/set RE_ABWEHR $[strcat(RE_ABWEHR, '@{', RE_FARBE_26, \
				'}', RE_KARATE_ABWEHR, RE_TSCH, RE_AFR)]%;\
		/endif%;\
	/else \
		/if (RE_ESP !~ '*') \
			/set RE_ESP @{%RE_FARBE_ESP}%{RE_ESP}@{%RE_FARBE_35}%;\
		/endif%;\
		/set RE_ABWEHR $[strcat(RE_ABWEHR, RE_SCHILD, RE_PARADE, \
			RE_SMS, RE_ESP, RE_AMU, RE_TSCH, RE_AFR)]%;\
	/endif


;;; Standard-Treffermeldungen aufbereiten
 
/def re_macro=\
	/if (RE_SCHADEN_NACH =/ 'sehr*') \
		/set RE_SCHADEN 6%;\
	/elseif (RE_SCHADEN_NACH =~ 'hart') \
		/set RE_SCHADEN 5%;\
	/elseif (RE_SCHADEN_NACH =/ 'mit dem*') \
		/set RE_SCHADEN 7%;\
	/elseif (RE_SCHADEN_NACH =~ 'zu Brei') \
		/set RE_SCHADEN 9%;\
	/elseif (RE_SCHADEN_VOR =/ 'verfehl*') \
		/set RE_SCHADEN 1%;\
	/elseif (RE_SCHADEN_VOR =/ 'kitzel*') \
		/set RE_SCHADEN 2%;\
	/elseif (RE_SCHADEN_VOR =/ 'kratzt*') \
		/set RE_SCHADEN 3%;\
	/elseif (RE_SCHADEN_VOR =/ 'triff*') \
		/set RE_SCHADEN 4%;\
	/elseif (RE_SCHADEN_VOR =/ 'zerschmetter*') \
		/set RE_SCHADEN 8%;\
	/elseif (RE_SCHADEN_VOR =/ 'pulverisier*') \
		/set RE_SCHADEN 10%;\
	/elseif (RE_SCHADEN_VOR =/ 'zerstaeub*') \
		/set RE_SCHADEN 11%;\
	/elseif (RE_SCHADEN_VOR =/ 'atomisier*') \
		/set RE_SCHADEN 12%;\
	/elseif (RE_SCHADEN_VOR =/ 'vernichte*') \
		/set RE_SCHADEN 13%;\
	/else \
		/set RE_SCHADEN 15%;\
	/endif%;\
	/re_ausgabe


;;; aktuelle Waffe aus den gespeicherten Werten 'erraten'
 
/def re_waffe_restaurieren=\
	/let RE_ANAME $(/re_namekorrigieren %RE_ANGREIFER)%;\
	/test RE_WAFFE := RE_WAFFE_%{RE_ANAME}%;\
	/if (RE_WAFFE =~ '') \
		/set RE_WAFFE ???%;\
	/else \
		/test RE_ART := RE_ART_%{RE_ANAME}%;\
		/re_waffe_geraten%;\
	/endif


;;; Neue Meldung ausgeben

/def re_ausgabe_vorbereiten=\
	/set RE_ANGREIFER $(/re_artikelkuerzen %RE_ANGREIFER)%;\
	/set RE_OPFER $(/re_artikelkuerzen %RE_OPFER)%;\
	/let RE_DAM_IGN 0%;\
	/let RE_TRENNER_OUT=%;\
	/if (RE_TMP_TRENNER!~"" & (RE_TMP_TRENNER_OPFER=~"" | RE_ANGREIFER=/ strcat(RE_TMP_TRENNER_OPFER,"*"))) \
	   /test RE_TRENNER_OUT:=strcat("@{x",RE_FARBE_%{RE_TMP_TRENNER},"}",RE_TRENNER_%{RE_TMP_TRENNER},"@{x}")%;\
	/endif%;\
	/if (regmatch(RE_REGEXP_SELF, RE_ANGREIFER)) \
		/let RE_FARBEN_OFFSET 37%;\
                /set RE_TRENNER=%{RE_TRENNER_OUT-@{%RE_FARBE_33\}-}@{%RE_FARBE_33}>@{%RE_FARBE_35}%;\
		/set RE_ANGREIFER=Du%;\
	        /set RE_AKT_GEGNER=%RE_OPFER%;\
	/elseif (regmatch(RE_REGEXP_SELF, RE_OPFER)) \
		/if (RE_DAM_IGNORE_WHO == 1 | RE_DAM_IGNORE_WHO == 2) \
			/let RE_DAM_IGN 1%;\
		/endif%;\
		/let RE_FARBEN_OFFSET 50%;\
                /set RE_TRENNER=@{%RE_FARBE_32}<@{%RE_FARBE_35}%{RE_TRENNER_OUT-@{%RE_FARBE_32\}-}%;\
	        /set RE_AKT_GEGNER=%RE_ANGREIFER%;\
		/set RE_OPFER=Dich%;\
	/else \
		/if (RE_DAM_IGNORE_WHO == 2) \
			/let RE_DAM_IGN 1%;\
		/endif%;\
		/let RE_FARBEN_OFFSET 0%;\
                /set RE_TRENNER=@{%RE_FARBE_34}-@{%RE_FARBE_35}%{RE_TRENNER_OUT-@{%RE_FARBE_34\}-}%;\
	/endif%;\
	/eval_hook re_ausgabe%;\
	/set RE_OPFER $(/re_namekuerzen 13 %RE_OPFER)%;\
	/set RE_ANGREIFER $(/re_namekuerzen 13 %RE_ANGREIFER)%;\
	/if (regmatch(RE_REGEXP_NUMBER, RE_SCHADEN)) \
		/if (RE_DAM_IGN & (RE_SCHADEN <= RE_DAM_IGNORE)) \
			/return 0%;\
		/endif%;\
		/if ({P0} > 0 & {P0} < 14) \
			/test RE_SCHADEN := RE_SCHADEN_%P0%;\
			/if (RE_SCHADEN_SUB < 0) \
				/if (strlen(RE_SCHADEN) > 7) \
					/test RE_SCHADEN := \
						substr(RE_SCHADEN,0,7)%;\
				/endif%;\
				/let RE_SUBSCHADEN=(-)%;\
			/elseif (RE_SCHADEN_SUB > 0) \
				/if (strlen(RE_SCHADEN) > 7) \
					/test RE_SCHADEN := \
						substr(RE_SCHADEN,0,7)%;\
				/endif%;\
				/let RE_SUBSCHADEN=(+)%;\
			/else \
				/let RE_SUBSCHADEN=%;\
			/endif%;\
			/test RE_SCHADEN_OUT := \
				strcat(RE_MELDUNG_PRE_%P0, '@{', \
				RE_FARBE_$[RE_FARBEN_OFFSET+{P0}], '}', \
				RE_SCHADEN, RE_SUBSCHADEN, '@{', RE_FARBE_35, \
				'}', RE_MELDUNG_POST_%P0)%;\
		/elseif ({P0} > 100 & {P0} < 114) \
			/test RE_SCHADEN_OUT:=strcat(RE_MELDUNG_PRE_14, '@{', \
				RE_FARBE_$[RE_FARBEN_OFFSET-100+{P0}], '}', \
				RE_SCHADEN_14, '@{', RE_FARBE_35, '}', \
				RE_MELDUNG_POST_14)%;\
		/else \
			/test RE_SCHADEN_OUT:=strcat(RE_MELDUNG_PRE_15, '@{', \
				RE_FARBE_36, '}', \
				RE_SCHADEN_15, '@{', RE_FARBE_35, '}', \
				RE_MELDUNG_POST_15)%;\
		/endif%;\
	/endif%;\
	/re_abwehr%;\
	/if (RE_WFUNC !~ '') \
		/set RE_ART %RE_WFUNC%;\
		/unset RE_WFUNC%;\
	/endif%;\
	/return 1


/def re_ausgabe=\
	/if (!re_ausgabe_vorbereiten()) \
		/re_loeschen%;\
		/return 0%;\
	/endif%;\
	/if (RE_WAFFE =~ '???') \
		/if (RE_ANGREIFER =~ RE_FLAECHE_ANGREIFER) \
			/if ((time() - RE_FLAECHE_ZEIT) < 10) \
				/set RE_WAFFE %RE_FLAECHE_WAFFE%;\
				/set RE_ART %RE_FLAECHE_ART%;\
				/re_waffe_geraten%;\
			/else \
				/unset RE_FLAECHE_ANGREIFER%;\
				/re_waffe_restaurieren%;\
				/purge re_zau_fb_2%;\
			/endif%;\
		/else \
			/unset RE_FLAECHE_ANGREIFER%;\
			/purge re_zau_fb_2%;\
			/re_waffe_restaurieren%;\
		/endif%;\
	/endif%;\
	/if (RE_ANGREIFER =/ '*en') \
		/let RE_IGNORIERE_P_A $[strcat('*', substr(RE_ANGREIFER, 0, \
			-1), '*')]%;\
	/else \
		/let RE_IGNORIERE_P_A $[strcat('*', RE_ANGREIFER, '*')]%;\
	/endif%;\
	/if (RE_OPFER =/ '*en') \
		/let RE_IGNORIERE_P_O $[strcat('*', substr(RE_OPFER, 0, -1), \
			'*')]%;\
	/else \
		/let RE_IGNORIERE_P_O $[strcat('*', RE_OPFER, '*')]%;\
	/endif%;\
	/if (!(RE_IGNORIERE_AKTIV & ((RE_IGNORIERE_POSITIV & \
	    ((RE_IGNORIERE =/ RE_IGNORIERE_P_A) | \
	    (RE_IGNORIERE =/ RE_IGNORIERE_P_O))) | \
	    (!RE_IGNORIERE_POSITIV & (RE_IGNORIERE !/ RE_IGNORIERE_P_A) & \
	    (RE_IGNORIERE !/ RE_IGNORIERE_P_O))))) \
	        /set RE_ANGREIFER_ORG=%RE_ANGREIFER%;\
	        /set RE_OPFER_ORG=%RE_OPFER%;\
	        /set RE_WAFFE_ORG=%RE_WAFFE%;\
		/set RE_ANGREIFER $[strcat(RE_ANGREIFER, strrep(RE_PT, \
			13-strlen(RE_ANGREIFER)))]%;\
		/set RE_WAFFE $[strcat(RE_WAFFE, strrep(RE_PT, \
			12-strlen(RE_WAFFE)))]%;\
		/set RE_OPFER $[strcat(RE_OPFER, strrep(RE_PT, \
			13-strlen(RE_OPFER)))]%;\
		/re_ausgabe_status%;\
		/re_ausgabe_zeile%;\
	/endif%;\
	/re_loeschen

/def re_ausgabe_status = \
	/if (RE_STATUS_SHOW) \
	   /let RE_STATUS_NAME=RE_STATUS_$(/re_namekorrigieren \
		%RE_ANGREIFER_ORG)%;\
	   /quote -S /let RE_STATUS_NAME= `/listvar -s -mregexp \
		^$[substr(RE_STATUS_NAME,0,-1)].?$$$%;\
	   /let RE_STATUS_VALUE=%;\
	   /test RE_STATUS_VALUE:=%RE_STATUS_NAME%;\
	   /if (RE_STATUS_VALUE!~"") \
	      /if (RE_STATUS_COLOR) \
	        /eval /test RE_ANGREIFER:=strcat("@{",RE_STATUS_ATTR_%{RE_STATUS_VALUE},"}",RE_ANGREIFER,"@{x}")%;\
	      /else \
	        /set RE_TMP_FUELLZEICHEN=$[+RE_STATUS_VALUE<100 ? substr(RE_STATUS_VALUE,0,1) : "!"]%;\
	      /endif%;\
	   /endif%;\
	   /let RE_STATUS_NAME=RE_STATUS_$(/re_namekorrigieren %RE_OPFER_ORG)%;\
	   /let RE_STATUS_VALUE=%;\
	   /test RE_STATUS_VALUE:=%RE_STATUS_NAME%;\
	   /if (RE_STATUS_VALUE!~"") \
	      /if (RE_STATUS_COLOR) \
	        /eval /test RE_OPFER:=strcat("@{",RE_STATUS_ATTR_%{RE_STATUS_VALUE},"}",RE_OPFER,"@{x}")%;\
	      /else \
	        /set RE_TMP_FUELLZEICHEN=$[+RE_STATUS_VALUE<100 ? substr(RE_STATUS_VALUE,0,1) : "!"]%;\
	      /endif%;\
	   /endif%;\
	/endif%;\

;;; Schwerttanz der Dunkelelfenkaempfer

/def -p2 -q -agCblue -mglob -t'  Das Runenschwert greift * an.' re_rsangriff = \
	/re_loeschen%;\
	/let RE_ANAME Das Runenschwert%;\
	/set RE_WAFFE Schwerttanz%;\
	/set RE_ART %RE_PT4@{%RE_FARBE_15}Delfen@{%RE_FARBE_35}%;\
	/let RE_ANAME $(/re_namekorrigieren $(/re_namekuerzen 13 \
		$(/re_artikelkuerzen %RE_ANAME)))%;\
	/set RE_ART_%{RE_ANAME} %RE_ART%;\
	/set RE_WAFFE_%{RE_ANAME} %RE_WAFFE

;;; Die normalen Angriffe
 
/def -p1 -q -agCblue -mregexp -t'^  ([^ ].+) greifs?t ([a-z\'\\` ]*([A-Z].*) \
	mit .*|(([a-z\'\\` ]*[A-Z][-A-Za-z\'\\`]* )+)([-A-Za-z\'\\` ]*)) \
	an\\.$' re_angriff=\
	/re_loeschen%;\
	/let RE_ANAME %P1%;\
	/if ({P4} =~ '') \
		/test regmatch(RE_REGEXP_ATTACK_KIND, {P2})%;\
		/set RE_WAFFE=%P1%PR%;\
	/else \
		/set RE_WAFFE=%P6%;\
	/endif%;\
	/if ((RE_WAFFE =~ 'brennenden Haenden') | \
	    (RE_WAFFE =~ 'flammenden Haenden')) \
		/set RE_WAFFE Feuerhand%;\
	/elseif (RE_WAFFE =~ 'feuchten Haenden') \
		/set RE_WAFFE Wasserhand%;\
	/elseif ((RE_WAFFE =~ 'aetzenden Haenden') | \
	    (RE_WAFFE =~ 'saeuretriefenden Haenden')) \
		/set RE_WAFFE Saeurehand%;\
	/elseif (RE_WAFFE =~ 'giftigen Haenden') \
		/set RE_WAFFE Gifthand%;\
	/elseif (RE_WAFFE =~ 'magischen Haenden') \
		/set RE_WAFFE Magiehand%;\
	/elseif ((RE_WAFFE =~ 'eisigen Haenden') | \
	    (RE_WAFFE =~ 'eiskalten Haenden')) \
		/set RE_WAFFE Eishand%;\
	/elseif (RE_WAFFE =~ 'leuchtenden Haenden') \
		/set RE_WAFFE Akshara%;\
	/elseif (RE_WAFFE =/ '*blutruenstig *') \
		/set RE_WAFFE $[substr(RE_WAFFE, \
			strstr(RE_WAFFE, 'blutruenstig ')+13)]%;\
		/set RE_ART %RE_PT3@{%RE_FARBE_19}Raserei@{%RE_FARBE_35}%;\
	/elseif (RE_WAFFE =/ '*vorsichtig *') \
		/set RE_WAFFE $[substr(RE_WAFFE, \
			strstr(RE_WAFFE, 'vorsichtig ')+11)]%;\
		/set RE_ART .@{%RE_FARBE_19}SchKroete@{%RE_FARBE_35}%;\
	/elseif (RE_WAFFE =/ '*schlangengleich *') \
		/set RE_WAFFE $[substr(RE_WAFFE, \
			strstr(RE_WAFFE, 'schlangengleich ')+16)]%;\
		/set RE_ART %RE_PT2@{%RE_FARBE_19}Schlange@{%RE_FARBE_35}%;\
	/elseif (RE_WAFFE =/ 'Blitzen aus {Deinen|seinen|ihren} Fingerkuppen') \
		/set RE_WAFFE Blitzhand%;\
	/elseif (RE_WAFFE =/ '*misslungenen *') \
		/if (RE_WAFFE =/ '*total *') \
			/let RE_WAFFE_P (--)%;\
		/else \
			/let RE_WAFFE_P (-)%;\
		/endif%;\
		/set RE_WAFFE $[substr(RE_WAFFE, \
			strstr(RE_WAFFE, 'misslungenen ')+13)]%;\
		/set RE_ART %RE_PT4@{%RE_FARBE_20}Karate@{%RE_FARBE_35}%;\
		/set RE_WAFFE $(/re_karatekuerzen %RE_WAFFE)%;\
		/set RE_WAFFE $[strcat(RE_WAFFE, strrep(RE_PT, \
			5-strlen(RE_WAFFE)), RE_WAFFE_P)]%;\
	/elseif (RE_WAFFE =/ '*gelungenen *') \
		/if (RE_WAFFE =/ '*sehr *') \
			/let RE_WAFFE_P (++)%;\
		/else \
			/let RE_WAFFE_P (+)%;\
		/endif%;\
		/set RE_WAFFE $[substr(RE_WAFFE, \
			strstr(RE_WAFFE, 'gelungenen ')+11)]%;\
		/set RE_ART %RE_PT4@{%RE_FARBE_20}Karate@{%RE_FARBE_35}%;\
		/set RE_WAFFE $(/re_karatekuerzen %RE_WAFFE)%;\
		/set RE_WAFFE $[strcat(RE_WAFFE, strrep(RE_PT, \
			5-strlen(RE_WAFFE)), RE_WAFFE_P)]%;\
	/elseif (regmatch(RE_REGEXP_KARATEKOMBI, RE_WAFFE)) \
		/let RE_WAFFE_P %P2%;\
		/set RE_WAFFE $(/re_karatekuerzen %P1)%;\
		/let RE_WAFFE_P $(/re_karatekuerzen %RE_WAFFE_P)%;\
		/set RE_WAFFE $[strcat(RE_WAFFE, '+', RE_WAFFE_P)]%;\
		/set RE_ART @{%RE_FARBE_20}Karatekomb@{%RE_FARBE_35}%;\
	/endif%;\
	/set RE_WAFFE $(/re_namekuerzen 12 %RE_WAFFE)%;\
	/let RE_ANAME $(/re_namekorrigieren $(/re_namekuerzen 13 \
		$(/re_artikelkuerzen %RE_ANAME)))%;\
	/set RE_ART_%{RE_ANAME} %RE_ART%;\
	/set RE_WAFFE_%{RE_ANAME} %RE_WAFFE


;;; normale Schadenmeldungen

/def -p1 -q -agCblue -mregexp -t'^  ([^ ].+) (verfehls?t|kitzels?t|kratzt|\
	triffs?t|schlaegs?t|zerschmetters?t|pulverisiers?t|zerstaeubs?t|\
	atomisiers?t|vernichtes?t) (.+)\\.$' re_schaden=\
	/let RE_Pufferzeile=%P0%;\
	/set RE_SCHADEN_VOR %P2%;\
	/set RE_ANGREIFER %P1%;\
	/let RE_Puffer %P3%;\
	/if (regmatch(RE_REGEXP_ATTACK, RE_Puffer)) \
		/set RE_SCHADEN_NACH %P1%;\
		/set RE_OPFER %PL%;\
	/else \
		/set RE_OPFER %RE_Puffer%;\
		/set RE_SCHADEN_NACH=%;\
	/endif%;\
	/if (regmatch(RE_REGEXP_ATTACK2, RE_Pufferzeile) \
	    & RE_SCHADEN_NACH =~ '') \
		/test substitute(RE_Pufferzeile, 'x')%;\
		/re_loeschen%;\
	/else \
		/re_macro%;\
	/endif


;;; Abgewehrte Spells geben keine Treffermeldung
 
/def -p1 -q -mglob -t'* {wehrt|wehrst} {Deinen|den} {Spruch|Zauber} ab.' \
	re_spell_abgew = /re_loeschen

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;;                Statusauswertung
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; /re_set_status 10 Portalwaechter


/def re_set_status = \
        /let RE_STATUS_NAME=RE_STATUS_$(/re_namekorrigieren \
		$(/re_namekuerzen 13 $(/re_artikelkuerzen %-1)))%;\
	/if ({1}>0) \
	  /set %RE_STATUS_NAME=%{1}%;\
	/else \
	  /unset %RE_STATUS_NAME%;\
	  /break%;\
	/endif%;\
	/re_echo_status %*

/def re_echo_status = \
        /if (RE_STATUS_ECHO_USER!~"") \
	   /eval -s0 %RE_STATUS_ECHO_USER %*%;\
	/elseif (RE_STATUS_APPEND) \
	   /echo -ax%RE_STATUS_ATTR %RE_STATUS_TEXT %1\%%;\
	/elseif (RE_STATUS_SIMPLE) \
	   /echo -ax%RE_STATUS_ATTR %-1: %1\%%;\
	/endif%;

/set RE_DEF_STATUS_COUNT=0

/def re_def_status = \
   /def -Fp110 -mglob -q -ag -t'* %-L' re_status_$[++RE_DEF_STATUS_COUNT] = \
   /set RE_STATUS_TEXT=\%*\%;\
   /re_set_status %L \%-L$[{#}-1]

;;; Kampfinfo der Matrix
/def -Fp111 -mglob -q -t'Matrix: *' re_matrix = /substitute %-1

/def -Fp111000 -mglob -aCyellow -q -t'{Tutszt|Harkuhu|Graiop|Yrintri|Irkitis|\
	Flaxtri} teilt Dir mit: *' re_status_demon = \
	/if ({*}=/"*[.)!]") \
		/substitute %-4%; \
	/else \
		/let re_statusstr=%-4%;\
		/substitute -ag%;\
		/def -1 -Fp112000 -mglob -aCyellow -t'%1 teilt Dir mit: *' \
			re_status_demon1 = \
			/let re_statusstr=%{re_statusstr} %%-4%%;\
			/substitute %%re_statusstr%;\
	/endif%;\

/def -Fp110 -mglob -q -t"* faellt tot zu Boden." re_status_tot = \
     /set RE_STATUS_TEXT=%*%;\
     /re_set_status 0 %-L4



/re_def_status ist absolut fit. 100
/re_def_status ist leicht geschwaecht. 90
/re_def_status ist schon etwas geschwaecht. 90
/re_def_status ist schon ein wenig schwaecher. 90
/re_def_status fuehlte sich auch schon besser. 80
/re_def_status fuehlte sich heute auch schon besser. 80
/re_def_status fuehlte sich heute schon besser. 80
/re_def_status ist leicht angekratzt. 70
/re_def_status sieht ein wenig angekratzt aus. 70
/re_def_status ist leicht angeschlagen. 70
/re_def_status ist nicht mehr taufrisch. 60
/re_def_status sieht nicht mehr taufrisch aus. 60
/re_def_status ist deutlich angekratzt. 60
/re_def_status sieht recht mitgenommen aus. 50
/re_def_status macht einen mitgenommenen Eindruck. 50
/re_def_status schwankt und wankt. 40
/re_def_status wankt bereits bedenklich. 40
/re_def_status ist in keiner guten Verfassung. 30
/re_def_status war auch schon in besserer Verfassung. 30
/re_def_status war auch schon mal besserer drauf. 30
/re_def_status war auch schon mal deutlich besser drauf. 30
/re_def_status braucht dringend aerztliche Behandlung. 20
/re_def_status braucht dringend einen Arzt. 20
/re_def_status ist schon so gut wie bei Lars. 10
/re_def_status steht auf der Schwelle des Todes. 10

/re_def_status steht auf der Schwelle zu einer besseren Welt. 10
/re_def_status braucht den beruehmten Arzt. 20
/re_def_status hats mit der Verfassung. 30
/re_def_status wankt und schwankt. Sieht gut fuer uns aus :-) 40
/re_def_status sieht zum Mitnehmen aus. 50
/re_def_status ist nicht mehr frisch. Und wie Tau schon gar nicht! 60
/re_def_status hat schon einige Kratzer abbekommen. 70
/re_def_status fuehlte sich auch schon schlechter. 80
/re_def_status ist ganz ganz leicht angeschwaechlicht. 90
/re_def_status ist absolut fit. Was immer das heissen mag... 100


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 				  Gilden
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Blitzmeldungen, die von einigen Gilden gebraucht werden:

/def re_blitzschaden = \
	/purge -mglob re_blitz_s*%;\
	/def -1 -p3 -agCblue -q -w -mregexp -t'^  ([A-Z].+) Blitz laesst \
		(.+) (etwas|hell|kurz) (aufleuchten|glimmen|auflodern)\\\\.' \
		re_blitz_s1 = \
		/set RE_OPFER %%P2%%;\
		/if ({P4} =~ 'auflodern') \
			/set RE_SCHADEN 9%%;\
		/elseif ({P3} =~ 'etwas' | {P3} =~ 'kurz') \
			/set RE_SCHADEN 5%%;\
		/elseif ({P3} =~ 'hell') \
			/set RE_SCHADEN 6%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_blitz_s*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  [A-Z].+ Blitz \
		(laesst|verschmort|verbrennt|braet|zerreisst|zerfetzt|\
		atomisiert|vernichtet) (.+) (die Haare zu Berge stehen|\
		Haut|Haut russig schwarz|durch|vollstaendig)\\\\.$$' \
		re_blitz_s2 = \
		/set RE_OPFER %%P2%%;\
		/if ({P1} =~ 'vernichtet') \
			/set RE_SCHADEN 13%%;\
		/elseif ({P1} =~ 'atomisiert') \
			/set RE_SCHADEN 12%%;\
		/elseif ({P1} =~ 'zerfetzt') \
			/set RE_SCHADEN 11%%;\
		/elseif ({P1} =~ 'zerreisst' & {P3} =~ 'vollstaendig') \
			/set RE_SCHADEN 10%%;\
		/elseif ({P1} =~ 'braet') \
			/set RE_SCHADEN 8%%;\
		/elseif ({P1} =~ 'verschmort') \
			/set RE_OPFER $$(/re_genitiv_loeschen %%RE_OPFER)%%;\
			/set RE_SCHADEN 7%%;\
		/elseif ({P1} =~ 'verbrennt') \
			/set RE_OPFER $$(/re_genitiv_loeschen %%RE_OPFER)%%;\
			/set RE_SCHADEN 7%%;\
		/elseif ({P1} =~ 'laesst') \
			/set RE_SCHADEN 1%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_blitz_s*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  ([A-Z].+) zucks?t \
		(leicht |)unter .* Blitz zusammen\\\\.$$' re_blitz_s3 = \
		/if ({P2} =~ 'leicht ') \
			/set RE_SCHADEN 2%%;\
		/else \
			/set RE_SCHADEN 3%%;\
		/endif%%;\
		/set RE_OPFER %%P1%%;\
		/re_ausgabe%%;\
		/purge -mglob re_blitz_s*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  [A-Z].+ Blitz \
		schiesst ins Leere\\\\.$$' re_blitz_s4 = \
		/set RE_SCHADEN 1%%;\
		/re_ausgabe%%;\
		/purge -mglob re_blitz_s*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  [A-Z].+ Blitz \
		zerreisst (.+)\\\\.$$' re_blitz_s5 = \
		/set RE_OPFER %%P1%%;\
		/set RE_SCHADEN 9%%;\
		/re_ausgabe%%;\
		/purge -mglob re_blitz_s*


;;; ABENTEURER

; Pfeil
; siehe bei den Chaoten

; Feuerball
; siehe Waffenwurf der Kaempfer

; Saeurestrahl

/def -p1 -q -agCblue -mglob -t'* fuchtelt seltsam in der Luft herum und \
	schiesst einen *' re_ab_saeure1 = \
	/purge re_ab_saeure1_1%;\
	/if ({*} !/ '*.') \
		/def -1 -p1 -q -mglob -agCblue -t'*.' re_ab_saeure1_1%;\
	/endif%;\
	/set RE_ART %RE_PT5@{%RE_FARBE_21}Magie@{%RE_FARBE_35}%;\
	/set RE_WAFFE Saeure

/def -p1 -q -agCblue -mglob -t'* schiesst einen Saeurestrahl auf *' \
	re_ab_saeure2 = \
	/set RE_ART %RE_PT5@{%RE_FARBE_21}Magie@{%RE_FARBE_35}%;\
	/set RE_WAFFE Saeure
	

;;; KARATE

/def -p1 -q -agCblue -mregexp -t'^  ([^ ].+) wehrs?t .+ Angriff mit einem \
	(.+) ab\\.$' re_karate_abwehr=\
	/set RE_KARATE_ABWEHR $(/re_karatekuerzen %P2)%;\
	/if ({P1} =~ 'Du') \
		/set RE_KARATE 4%;\
	/else \
		/set RE_KARATE 3%;\
	/endif

/def -p1 -q -agCblue -mregexp -t'^  ([^ ].+) versuchs?t,? .+ Angriff mit \
	einem (.+) abzuwehren\\.$' re_karate_abwehr2=\
	/set RE_KARATE_ABWEHR $(/re_karatekuerzen %P2)%;\
	/if ({P1} =~ 'Du') \
		/set RE_KARATE 2%;\
	/else \
		/set RE_KARATE 1%;\
	/endif

/def -p1 -q -agCblue -mglob -t'  * weicht {dem|Deinem} Angriff geschickt \
	aus.' re_karate_ausw_pass = \
	/set RE_KARATE_ABWEHR Auswe%;\
	/set RE_KARATE 3

/ifdef (RE_MULTIPLAYER_TF|p_guild=~""|p_guild=~"karate") -p1 -q -agCblue \
	-msimple -t'  Du weichst dem Angriff aus.' re_karate_ausw_akt = \
	/set RE_KARATE_ABWEHR Auswe%;\
	/set RE_KARATE 4


;;; KATZENKRIEGER

;;; Krallenschlag

/def -p2 -q -agCblue -mglob -t'* {schlaegt|schlaegst} mit ausgefahrenen \
	Krallen auf *' re_katzen_kralle = \
	/set RE_WAFFE Krallenschl%;\
	/set RE_ART %RE_PT4@{%RE_FARBE_21}Katzen@{%RE_FARBE_35}

;;; Blitz

/def -p4 -q -agCblue -mregexp -t'^([^ ].+) schleuders?t einen Blitz auf \
	(.+)\\.$' re_katzen_blitz = \
	/set RE_ANGREIFER %P1%;\
	/set RE_OPFER %P2%;\
	/set RE_WAFFE Blitz%;\
	/set RE_ART %RE_PT4@{%RE_FARBE_21}Katzen@{%RE_FARBE_35}%;\
	/re_blitzschaden

;;; Todeskralle

/def -p1 -q -agCblue -mglob -t'* {schlaegt|schlaegst} blitzschnell mit \
	ausgefahrenen Krallen auf *' re_katzen_tkralle = \
	/if ({*} !/ '* ein.') \
		/def -p1 -agCblue -q -1 -mglob -t'*ein.' re_katzen_tkralle_1%;\
	/endif%;\
	/set RE_WAFFE Todeskralle%;\
	/set RE_ART %RE_PT4@{%RE_FARBE_21}Katzen@{%RE_FARBE_35}

;;; Wasserstrahl

;  Pyros' Wasserstrahl verfehlt Dich. (-0 LP)
;  Ein Wasserspritzer streift Thufhir. (-1LP)
;  Dfender spritzt Thufhir klitschnass. (-5LP)
;  Dfender trifft Thufhir mit einem Wasserstrahl. (-10LP)
;  Dfender trifft den Drakonierwaechter hart mit einem Wasserstrahl. (-30 LP)
;  Dfender trifft das Kampfblech sehr hart mit einem Wasserstrahl. (-48 LP)
;  Pyros bringt Dich mit einem Wasserstrahl aus dem Gleichgewicht. (-55 LP)
;  Dfender bringt den Stahldrachen mit einem Wasserstrahl aus dem
;  Gleichgewicht.

/def -p1 -q -agCblue -mregexp -t' forms?t mit ([Ds]einen|ihren) Haenden einen \
	Trichter, aus dem ein' re_katzen_wasser = \
	/purge -mglob re_katzen_wasser_*%;\
	/set RE_ANGREIFER %PL%;\
	/re_str_can_break%;\
	/def -1 -p1 -q -agCblue -mregexp -t'^(Wasserstrahl )?schiesst. \
		Diesen richtes?t (Du|er|sie) auf (.+)\\\\.$$' \
		re_katzen_wasser_0 = \
		/set RE_OPFER %%P3%%;\
		/set RE_WAFFE Wasserstrahl%%;\
		/set RE_ART %RE_PT4@{%%RE_FARBE_21}Katzen@{%%RE_FARBE_35}%;\
	/def -1 -p2 -q -agCblue -mregexp -t'^  ([^ ].*) Wasserstrahl verfehlt \
		.+\\\\.$$' re_katzen_wasser_1 = \
		/set RE_SCHADEN 1%%;\
		/re_ausgabe%%;\
		/purge -mglob re_katzen_wasser_*%;\
	/def -1 -p2 -q -agCblue -mregexp -t'^  Ein Wasserspritzer streift .+\
		\\\\.$$' re_katzen_wasser_2 = \
		/set RE_SCHADEN 2%%;\
		/re_ausgabe%%;\
		/purge -mglob re_katzen_wasser_*%;\
	/def -1 -p2 -q -agCblue -mregexp -t'^  [^ ].+ spritzt .+ \
		klitschnass\\\\.$$' re_katzen_wasser_3 = \
		/set RE_SCHADEN 4%%;\
		/re_ausgabe%%;\
		/purge -mglob re_katzen_wasser_*%;\
	/def -1 -p2 -q -agCblue -mregexp -t'^  [^ ].+ triffs?t \
		(.+) mit einem Wasserstrahl\\\\.$$' \
		re_katzen_wasser_4 = \
		/if ({P1} =/ '* sehr hart') \
			/set RE_SCHADEN 8%%;\
		/elseif ({P1} =/ '* hart') \
			/set RE_SCHADEN 7%%;\
		/else \
			/set RE_SCHADEN 6%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_katzen_wasser_*%;\
	/def -1 -p2 -q -agCblue -mregexp -t'^  [^ ].+ brings?t .+ mit \
		einem Wasserstrahl aus dem Gleichgewicht\\\\.$$' \
		re_katzen_wasser_5 = \
		/set RE_SCHADEN 9%%;\
		/re_ausgabe%%;\
		/purge -mglob re_katzen_wasser_*

;;; Giftdolch

/def -p1 -q -agCblue -mglob -t'* {streicht|streichst} mit einer Tollkirsche \
	ueber *' re_katzen_gdolch = \
	/purge -mglob re_katzen_gdolch_*%;\
	/def -p1 -q -agCblue -mglob -t'* huellt sich kurz in ein * gruenes \
		Leuchten.' re_katzen_gdolch_1 = \
		/if ({L3} =~ 'schwaches') \
			/set RE_WAFFE G-Dolch.(+1)%%;\
		/elseif ({L3} =~ 'leichtes') \
			/set RE_WAFFE G-Dolch.(+2)%%;\
		/elseif ({L3} =~ 'kraeftiges') \
			/set RE_WAFFE G-Dolch.(+3)%%;\
		/elseif ({L3} =~ 'starkes') \
			/set RE_WAFFE G-Dolch.(+4)%%;\
		/elseif ({L3} =~ 'grelles') \
			/set RE_WAFFE G-Dolch.(+5)%%;\
		/endif%;\
	/def -p1 -q -agCblue -mglob -t'* huellt sich leider nicht in ein \
		gruenes Leuchten.' re_katzen_gdolch_2 = \
		/set RE_WAFFE G-Dolch.(+0)%;\
	/def -p1 -q -agCblue -mglob -t'* stoesst blitzschnell mit * zu.' \
		re_katzen_gdolch_3 = \
		/if (RE_WAFFE !/ 'G-Dolch*') \
			/set RE_WAFFE Giftdolch%%;\
		/endif%%;\
		/set RE_ART %RE_PT4@{%%RE_FARBE_21}Katzen@{%%RE_FARBE_35}%%;\
		/purge -mglob re_katzen_gdolch_*


;;; KAEMPFER

;;; Kniestoss

/def -p1 -q -agCblue -mglob -t'* {rammst|rammt} * das Knie in den \
	Koerper.' re_kaempfer_knies=\
	/set RE_WAFFE Kniestoss%;\
	/set RE_ART %RE_PT5@{%RE_FARBE_16}extra@{%RE_FARBE_35}

;;; Kopfstoss

/def -p1 -q -agCblue -mregexp -t'^[^ ].+ stoesst .+ ((seinen|\
	ihren) Kopf in den Leib|heftig mit (dem|Deinem) Kopf)\\.$' \
	re_kaempfer_kopfs = \
	/set RE_WAFFE Kopfstoss%;\
	/set RE_ART %RE_PT5@{%RE_FARBE_16}extra@{%RE_FARBE_35}

;;; Kampftritt

/def -p1 -q -agCblue -mregexp -t'^[^ ].+ (versetzt .+ einen \
	heimtueckischen Kampftritt|tritt .+ heimtueckisch)\\.$' \
	re_kaempfer_ktritt=\
	/set RE_WAFFE Kampftritt%;\
	/set RE_ART %RE_PT5@{%RE_FARBE_16}extra@{%RE_FARBE_35}

;;; Ellbogenschlag

/def -p2 -q -agCblue -mglob -t'* {schlaegst|schlaegt} * mit {Deinem|dem|seinen\
	|ihren} Ellbogen.' re_kaempfer_eschlag=\
	/set RE_WAFFE Ellbogenschl%;\
	/set RE_ART %RE_PT5@{%RE_FARBE_16}extra@{%RE_FARBE_35}

;;; Schildstoss

/def -p1 -q -agCblue -mglob -t'* machst einen gelungenen Schildstoss gegen \
	*.' re_kaempfer_schilds=\
	/set RE_WAFFE Schildstoss%;\
	/set RE_ART %RE_PT5@{%RE_FARBE_16}extra@{%RE_FARBE_35}

/def -Fp1 -q -agCblue -mregexp -t'^([^ ].*) stoesst (.*) mit (.*)$' \
	re_kaempfer_schilds2=\
	/set RE_Zeilenanfang %P0%;\
	/if (RE_Zeilenanfang !/ '*.') \
		/def -Fp1 -q -1 -agCblue -mregexp -t'([^ ].+)$$' \
			re_kaempfer_schilds2b=\
			/let Zeile %%RE_Zeilenanfang %%P0%%;\
			/if ((Zeile !/ '*dass es nur so kracht.')&\
			    (Zeile !/ '*kraeftig in den Koerper.')) \
				/if (RE_WAFFE !~ 'Kopfstoss') \
					/substitute -ax -- %%Zeile%%;\
				/endif%%;\
			/else \
				/set RE_WAFFE Schildstoss%%;\
				/set RE_ART %RE_PT5@{%RE_FARBE_16}extra\
					@{%RE_FARBE_35}%%;\
			/endif%;\
	/else \
		/if ((RE_Zeilenanfang !/ '*dass es nur so kracht.')&\
		    (RE_Zeilenanfang !/ '*kraeftig in den Koerper.')) \
			/if (RE_WAFFE !~ 'Kopfstoss') \
				/substitute -ax -- %RE_Zeilenanfang%;\
			/endif%;\
		/else \
			/set RE_WAFFE Schildstoss%;\
			/set RE_ART %RE_PT5@{%RE_FARBE_16}extra@{%RE_FARBE_35}%;\
		/endif%;\
	/endif

;;; Waffenschlag
 
/def -p2 -q -agCblue -mregexp -t'^[^ ].+ schlaegs?t .+ (fies mit|\
	ploetzlich und) ' re_kaempfer_wschlag = \
	/if ({PR} !/ '*.') \
		/def -p1 -1 -q -agCblue -mglob -t'*.' re_kaempfer_wschlag_g%;\
	/endif%;\
	/set RE_WAFFE Waffenschlag%;\
	/set RE_ART %RE_PT5@{%RE_FARBE_16}extra@{%RE_FARBE_35}

;;; Waffenwurf
 
/def -Fp1 -q -agCblue -mregexp -t'^([A-Z][-A-Za-z, \'\\`]+) wirfs?t (.+) \
	nach (.+)\\.$' re_kaempfer_wwurf = \
	/if (({P2} =/ '* Blick*')|({P2} =/ '* Wecker')|({P2} =/ '* Torte')|\
	    ({P2} =/ '*silberne Nadel')|({P2} =/ '*Schneeba*')|\
	    ({P2} =/ '* Kissen*') | ({P2} =/ '* Eiswolke') | \
	    ({P2} =/ '* Sahnetorte*') | \
	    ({P1} =/ 'Dein Freund *') | ({P1} =/ 'Deine Freundin *')) \
		/substitute -ax -- %P0%;\
	/else \
		/if ({P2} =/ '*Feuerball') \
			/set RE_WAFFE Feuer%;\
			/set RE_ART %RE_PT5@{%RE_FARBE_21}Magie@{%RE_FARBE_35}%;\
		/else \
			/set RE_WAFFE $(/re_namekuerzen 12 \
				$(/re_artikelkuerzen %P2))%;\
			/set RE_ART @{%RE_FARBE_16}Waffenwurf@{%RE_FARBE_35}%;\
		/endif%;\
	/endif

;;; Todesstoss
 
/def -p1 -q -agCblue -mregexp -t'^[^ ].+ setzt einen ([a-z]+ |)Todesstoss \
	gegen ' re_kaempfer_todess=\
	/purge re_kaempfer_todess2%;\
	/if ({PR} !/ '* an.') \
		/def -p1 -agCblue -q -1 -mglob -t'* an.' re_kaempfer_todess2%;\
	/endif%;\
	/if ({P1}=~'') \
		/set RE_ART %RE_PT5@{%RE_FARBE_17}lasch@{%RE_FARBE_35}%;\
	/elseif ({P1}=~'harmlosen ') \
		/set RE_ART %RE_PT3@{%RE_FARBE_17}harmlos@{%RE_FARBE_35}%;\
	/elseif ({P1}=~'maechtigen ') \
		/set RE_ART %RE_PT2@{%RE_FARBE_18}maechtig@{%RE_FARBE_35}%;\
	/elseif ({P1}=~'moerderischen ') \
		/set RE_ART %RE_PT2@{%RE_FARBE_18}toedlich@{%RE_FARBE_35}%;\
	/else \
		/set RE_ART %RE_PT7@{%RE_FARBE_17}???@{%RE_FARBE_35}%;\
	/endif%;\
	/set RE_WAFFE Todesstoss

;;; Rueckendeckung

/def -p1 -q -agCmagenta -mregexp -t' faengs?t den (Angriff|Schlag von .+)\
	( gegen .+|, der eigentlich .+ treffen sollte,) etwas ab\\.$' \
	re_kaempfer_rueckend = \
	/if (RE_RDECKUNG =~ '*') \
		/set RE_RDECKUNG R%;\
	/elseif (RE_RDECKUNG =~ 'R') \
		/set RE_RDECKUNG 2%;\
	/else \
		/test ++RE_RDECKUNG%;\
	/endif

; folgender Trigger ist jetzt (hoffentlich!) oben mit drin:
;/def -p1 -q -agCmagenta -mregexp -t' faengs?t den Schlag von .+ gegen .+ \
;	etwas ab\\.$' re_kaempfer_rueckend2 = \
;	/if (RE_RDECKUNG =~ '*') \
;		/set RE_RDECKUNG R%;\
;	/elseif (RE_RDECKUNG =~ 'R') \
;		/set RE_RDECKUNG 2%;\
;	/else \
;		/test ++RE_RDECKUNG%;\
;	/endif

;;; Parade (auch der Delfen) und Schildparade

/def -p1 -q -agCmagenta -mregexp -t'^([^ ].+) pariers?t .+ Angriff mit \
	(.+)\\.$' re_kaempfer_parade = \
	/if ({P1} =~ 'Du') \
		/let RE_FarbPuffer %RE_FARBE_23%;\
	/else \
		/let RE_FarbPuffer %RE_FARBE_25%;\
	/endif%;\
	/if (({P2} =/ '*Kieferknochen')|({P2} =/ '*[Ss]child*')|\
	    ({P2} =/ '*[Ss]chuppe*')|({P2} =/ '*Harpyienfedern')) \
		/set RE_SCHILD @{%RE_FarbPuffer}S@{%RE_FARBE_35}%;\
	/else \
		/set RE_PARADE @{%RE_FarbPuffer}P@{%RE_FARBE_35}%;\
	/endif

;;; Magieausweichen

/def re_kaempfer_magausw = \
	/purge re_kaempfer_magausw_gag%;\
	/if ({PR} !/ '*.') \
		/def -1 -Fp31 -q -agCmagenta -mglob -t'*.' \
			re_kaempfer_magausw_gag%;\
	/endif%;\
	/set RE_KARATE_ABWEHR Auswe%;\
	/set RE_KARATE 3

/def -p1 -q -agCmagenta -mregexp -t'^[^ ].+ machs?t einen \
	S(prung nach hinten und weichs?t|alto rueckwaerts und entgehs?t) so' \
	re_kaempfer_magausw_1 = \
	/re_kaempfer_magausw

/def -p1 -q -agCmagenta -mregexp -t'^[^ ].+ ducks?t [Ds]ich ganz \
	geschwind und tauchs?t so unter' re_kaempfer_magausw_2 = \
	/re_kaempfer_magausw

; folgender Trigger sollte jetzt (hoffentlich!) in magausw_1
; mit drin sein:
;/def -p1 -q -agCmagenta -mregexp -t'^[^ ].+ machs?t einen Salto \
;	rueckwaerts und entgehs?t so' re_kaempfer_magausw_3 = \
;	/re_kaempfer_magausw

/def -p1 -q -agCmagenta -mregexp -t'^[^ ].+ umtaenzels?t den Angriff \
	(vollstaendig|teilweise)\\.$' re_kaempfer_magausw_4 = \
	/set RE_KARATE_ABWEHR Auswe%;\
	/set RE_KARATE 3


;;; CHAOTEN

/def -p1 -q -agCblue -mglob -t'{Tutszt|Harkuhu|Graiop|Yrintri|Irkitis|Flaxtri} \
	weicht dem Angriff aus.' re_chaos_daemon_ausw = \
	/set RE_KARATE_ABWEHR $[substr({1},0,5)]%;\
	/set RE_KARATE 2

/def -Fp1 -q -agCblue -mregexp -t'^[^ ].+ feuers?t (.+) auf .+ ab\\.$' \
	re_chaos_cb=\
	/if ({P1} =/ '*magischen Pfeil') \
		/set RE_ART %RE_PT5@{%RE_FARBE_21}Magie@{%RE_FARBE_35}%;\
		/set RE_WAFFE Magie%;\
	/else \
		/set RE_ART %RE_PT5@{%RE_FARBE_21}Chaos@{%RE_FARBE_35}%;\
		/if ({P1} =/ '*Fluch') \
			/set RE_WAFFE Boese%;\
                /elseif ({P1} =/ '*Terrorattacke') \
                        /set RE_WAFFE Terror%;\
		/elseif ({P1} =/ '*Wasserstrahl') \
			/set RE_WAFFE Wasser%;\
		/elseif ({P1} =/ '*Flammenkugel') \
			/set RE_WAFFE Feuer%;\
		/elseif ({P1} =/ '*Strahl') \
			/set RE_WAFFE Magie%;\
		/elseif ({P1} =/ '*Eiswolke') \
			/set RE_WAFFE Eis%;\
		/elseif ({P1} =/ '*Kampfschrei') \
			/set RE_WAFFE Krach%;\
		/elseif ({P1} =/ '*Saeureregen') \
			/set RE_WAFFE Saeure%;\
		/elseif ({P1} =/ '*Sturm') \
			/set RE_WAFFE Sturm%;\
		/elseif ({P1} =/ '*Gift') \
			/set RE_WAFFE Gift%;\
		/elseif ({P1} =/ '*Blitz') \
			/set RE_WAFFE Blitz%;\
		/elseif ({P1} =/ '*Daumenschraube*') \
			/let RE_PHYS 1%;\
			/set RE_WAFFE Quetschen%;\
		/elseif ({P1} =/ '*Magierschaedel') \
			/let RE_PHYS 1%;\
			/set RE_WAFFE Explosion%;\
		/elseif ({P1} =/ '*Peitschenhieb') \
			/let RE_PHYS 1%;\
			/set RE_WAFFE Peitsche%;\
		/elseif ({P1} =/ '*Felsbrocken') \
			/let RE_PHYS 1%;\
			/set RE_WAFFE Schlag%;\
		/elseif ({P1} =/ '* Pfeil') \
			/let RE_PHYS 1%;\
			/set RE_WAFFE Stich%;\
		/elseif ({P1} =/ '*Messer*') \
			/let RE_PHYS 1%;\
			/set RE_WAFFE Schnitt%;\
		/elseif ({P1} =/ '*Widerhaken') \
			/let RE_PHYS 1%;\
			/set RE_WAFFE Reissen%;\
		/else \
			/re_loeschen%;\
			/substitute -ax -- %P0%;\
		/endif%;\
		/if (RE_PHYS) \
			/if ({P1} =/ '*brennend*') \
				/set RE_WAFFE Feuer+%RE_WAFFE%;\
			/elseif ({P1} =/ '*eisig*') \
				/set RE_WAFFE Eis+%RE_WAFFE%;\
			/elseif ({P1} =/ '*schreiend*') \
				/set RE_WAFFE Krach+%RE_WAFFE%;\
			/elseif ({P1} =/ '*fluessig*') \
				/set RE_WAFFE Wasser+%RE_WAFFE%;\
			/elseif ({P1} =/ '*satanisch*') \
				/set RE_WAFFE Boese+%RE_WAFFE%;\
			/elseif ({P1} =/ '*giftig*') \
				/set RE_WAFFE Gift+%RE_WAFFE%;\
			/elseif ({P1} =/ '*stuermisch*') \
				/set RE_WAFFE Sturm+%RE_WAFFE%;\
			/elseif ({P1} =/ '*aetzend*') \
				/set RE_WAFFE Saeure+%RE_WAFFE%;\
			/elseif ({P1} =/ '*terrorverbreitend*') \
				/set RE_WAFFE Terror+%RE_WAFFE%;\
			/elseif ({P1} =/ '*magisch*') \
				/set RE_WAFFE Magie+%RE_WAFFE%;\
			/elseif ({P1} =/ '*blitzend*') \
				/set RE_WAFFE Blitz+%RE_WAFFE%;\
			/endif%;\
			/set RE_WAFFE $[substr(RE_WAFFE, 0, 12)]%;\
		/endif%;\
	/endif

;;; Verbanne

/def -p1 -q -agCblue -mglob -t'* {hebt|hebst} die Arme empor und \
	{wirft|wirfst} uebelste Worte gegen *.' re_chaos_vb=\
	/set RE_WAFFE Verbannen%;\
	/set RE_ART %RE_PT5@{%RE_FARBE_21}Chaos@{%RE_FARBE_35}


;;; BIERSCHUETTLER

;;; Hitzschlag

/def -p1 -q -agCblue -mglob -t'* {erzeugt|erzeugst} einen Hitzeschlag gegen \
	*.' re_bier_hs=\
	/set RE_WAFFE Hitze%;\
	/set RE_ART %RE_PT5@{%RE_FARBE_21}Magie@{%RE_FARBE_35}

/def -p1 -q -agCblue -mglob -t'* ueberrascht Dich mit einem Hitzeschlag.' \
	re_bier_hs2=\
	/set RE_WAFFE Hitze%;\
	/set RE_ART %RE_PT5@{%RE_FARBE_21}Magie@{%RE_FARBE_35}

;;; Erdbeben
 
/def -p1 -agCblue -q -mregexp -t'^([^ ].+) knies?t kurz nieder und klatscht \
	mit den Haenden auf den Boden\\.$' re_bier_eb=\
	/set RE_FLAECHE_ANGREIFER $(/re_namekuerzen 13 \
		$(/re_artikelkuerzen %P1))%;\
	/purge -mglob re_bier_eb_*%;\
	/def -1 -p1 -agCblue -q -msimple -t'Ploetzlich beginnt die Erde zu \
		beben.' re_bier_eb_2=\
		/set RE_FLAECHE_ZEIT $$[time()]%%;\
		/set RE_FLAECHE_WAFFE Erdbeben%%;\
		/set RE_WAFFE Erdbeben%%;\
		/set RE_FLAECHE_ART %RE_PT5@{%%RE_FARBE_21}Magie\
			@{%%RE_FARBE_35}%%;\
		/set RE_ART %RE_PT5@{%%RE_FARBE_21}Magie@{%%RE_FARBE_35}%%;\
		/repeat -1 1 /purge re_bier_eb_3%;\
	/def -1 -p1 -aCred -q -msimple -t'Etwas faellt von der Decke und \
		trifft Dich.' re_bier_eb_3

;;; Nebel

/def -p1 -agCblue -q -mregexp -t'^([^ ].+) erzeugs?t einen Mini-Hitzeschlag, \
	der die Bierschuerze trifft\\.( Ploetzlich)?$' re_bier_nb=\
	/purge -mglob re_bier_nb_*%;\
	/set RE_FLAECHE_ANGREIFER $(/re_namekuerzen 13 \
		$(/re_artikelkuerzen %P1))%;\
	/def -1 -p1 -agCblue -q -mregexp -t'^(Ploetzlich )?erscheint eine? \
		(Gewitterwolke|Eiswolke|dichter Nebel)( und erfasst Dich)?\
		\\\\.' re_bier_nb_2=\
		/set RE_FLAECHE_ZEIT $$[time()]%%;\
		/if ({P2} =~ 'Gewitterwolke') \
			/set RE_FLAECHE_WAFFE Blitz-Nebel%%;\
		/elseif ({P2} =~ 'Eiswolke') \
			/set RE_FLAECHE_WAFFE Eis-Nebel%%;\
		/elseif ({P2} =~ 'dichter Nebel') \
			/set RE_FLAECHE_WAFFE Wasser-Nebel%%;\
		/endif%%;\
		/set RE_WAFFE %%RE_FLAECHE_WAFFE%%;\
		/set RE_FLAECHE_ART %RE_PT5@{%%RE_FARBE_21}Magie\
			@{%%RE_FARBE_35}%%;\
		/set RE_ART %RE_PT5@{%%RE_FARBE_21}Magie@{%%RE_FARBE_35}

;;; ZAUBERER

;;; Giftpfeil

/ifdef (RE_MULTIPLAYER_TF|p_guild=~""|p_guild=~"zauberer") -p1 -q -agCblue \
	-msimple -t'  Du murmelst die vorgeschriebenen Worte fuer den \
	Giftpfeil.' re_zau_gpfeil = \
	/purge -mglob re_zau_gpfeil_*%;\
	/def -1 -p1 -q -agCblue -mregexp -t'^  Aus Deiner Hand schiesst ein \
		giftgruener Pfeil auf (.+)\\\\.' re_zau_gpfeil_1 = \
		/set RE_OPFER %%P1%%;\
		/set RE_ANGREIFER Du%%;\
		/set RE_WAFFE Giftpfeil%%;\
		/set RE_ART %RE_PT2@{%RE_FARBE_15}Zauberei@{%RE_FARBE_35}%%;\
		/re_zgiftschaden

/def -p1 -q -agCblue -mglob -t'  * murmelt: Khratrx venthrax whu!' \
	re_zau_gpfeil2 = \
	/purge -mglob re_zau_gpfeil_*%;\
	/def -1 -p1 -q -agCblue -mregexp -t'^  Aus (.+) Hand schiesst ein \
		giftgruener Pfeil (in Deine Richtung|auf (.+) zu)\\\\.' \
		re_zau_gpfeil_1 = \
		/set RE_ANGREIFER $$(/re_genitiv_loeschen %%P1)%%;\
		/if ({P2} =~ 'in Deine Richtung') \
			/set RE_OPFER Dich%%;\
		/else \
			/set RE_OPFER %%P3%%;\
		/endif%%;\
		/set RE_WAFFE Giftpfeil%%;\
		/set RE_ART %RE_PT2@{%RE_FARBE_15}Zauberei@{%RE_FARBE_35}%%;\
		/re_zgiftschaden

/def re_zgiftschaden = \
	/purge -mglob re_zgiftschaden_*%;\
	/def -p2 -1 -q -agCblue -mregexp -t'^  .* schiesst einen Giftpfeil \
		auf den Boden\\\\.' re_zgiftschaden_0 = \
		/set RE_SCHADEN 1%%;\
		/re_ausgabe%%;\
		/purge -mglob re_zgiftschaden_*%;\
	/def -p2 -q -1 -agCblue -mregexp -t'^  .* Giftpfeil (bohrt sich in \
		den Boden|laesst .* gruen anlaufen|laesst .* taumeln)\\\\.$$' \
		re_zgiftschaden_1 = \
		/if ({P1} =/ 'bohrt *') \
			/set RE_SCHADEN 1%%;\
		/elseif ({P1} =/ '* gruen *') \
			/set RE_SCHADEN 6%%;\
		/elseif ({P1} =/ '* taumeln*') \
			/set RE_SCHADEN 7%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_zgiftschaden_*%;\
	/def -p2 -1 -q -agCblue -mregexp -t'^  .* (kratzt|triffs?t) \
		.* mit einem Giftpfeil( worauf .*)?\\\\.?$$' \
		re_zgiftschaden_2 = \
		/if ({P2} !~ '' & {P2} !/ '*.*') \
			/def -mglob -p1 -agCblue -1 -t'  *wird.' \
				re_zgifts_temp%%;\
		/endif%%;\
		/if ({P1} =~ 'kratzt') \
			/set RE_SCHADEN 3%%;\
		/elseif ({P1} =/ 'triff*' & {P2} =~ '') \
			/set RE_SCHADEN 4%%;\
		/elseif ({P1} =/ 'triff*' & {P2} !~ '') \
			/set RE_SCHADEN 5%%;\
		/else \
			/set RE_SCHADEN 15%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_zgiftschaden_*

;;; Blitz

/ifdef (RE_MULTIPLAYER_TF|p_guild=~""|p_guild=~"zauberer") -p1 -q -agCblue \
	-msimple -t'  Du murmelst die vorgeschriebenen Worte fuer den Blitz.' \
	re_zau_blitz = \
	/purge -mglob re_zau_blitz_*%;\
	/def -1 -p1 -q -agCblue -msimple -t'  Aus Deiner Hand loesen sich \
		mehrere grelle Blitze.' re_zau_blitz_1 = \
		/set RE_ANGREIFER Du%%;\
		/set RE_WAFFE Blitz%%;\
		/set RE_ART %RE_PT2@{%RE_FARBE_15}Zauberei@{%RE_FARBE_35}%%;\
		/re_blitzschaden

/def -p1 -q -agCblue -mregexp -t'^  Aus (.+) Hand loesen sich grelle \
	Blitze und schiessen auf Dich zu\\.$' re_zau_blitz1 = \
	/set RE_ANGREIFER $(/re_genitiv_loeschen %P1)%;\
	/set RE_WAFFE Blitz%;\
	/set RE_ART %RE_PT2@{%RE_FARBE_15}Zauberei@{%RE_FARBE_35}%;\
	/re_blitzschaden

/def -p1 -q -agCblue -mglob -t'  * murmelt: Illuhxio fulhraxtrj whu!' \
	re_zau_blitz2 = \
	/purge -mglob re_zau_blitz_*%;\
	/def -1 -p1 -q -agCblue -mregexp -t'^  Aus (.+) Hand loesen sich \
		ploetzlich grelle Blitze\\\\.$$' re_zau_blitz_1 = \
		/set RE_ANGREIFER $$(/re_genitiv_loeschen %%P1)%%;\
		/set RE_WAFFE Blitz%%;\
		/set RE_ART %RE_PT2@{%RE_FARBE_15}Zauberei@{%RE_FARBE_35}%%;\
		/re_blitzschaden

;;; Feuerball

/def -p1 -q -agCblue -mregexp -t' laesst eine (kleine |gewaltige )?Kugel \
	aus Feuer entstehen\\.$' re_zau_fb = \
	/if ({P1} =~ 'kleine ') \
		/set RE_FBALL (-)%;\
	/elseif ({P1} =~ 'gewaltige ') \
		/set RE_FBALL (+)%;\
		/set RE_FLAECHE_ANGREIFER %PL%;\
		/set RE_FLAECHE_WAFFE Feuerball%;\
		/set RE_FLAECHE_ART %RE_PT2@{%RE_FARBE_15}Zauberei@{%RE_FARBE_35}%;\
		/set RE_FLAECHE_TIME $[time()]%;\
	/else \
		/set RE_FBALL=%;\
		/set RE_FLAECHE_ANGREIFER %PL%;\
		/set RE_FLAECHE_WAFFE Feuerball%;\
		/set RE_FLAECHE_ART %RE_PT2@{%RE_FARBE_15}Zauberei@{%RE_FARBE_35}%;\
		/set RE_FLAECHE_TIME $[time()]%;\
	/endif%;\
	/purge -mglob re_zau_fb_*%;\
	/def -1 -p1 -q -agCblue -mglob -t'* {schleuderst|schleudert} die Kugel \
		in * Richtung.' re_zau_fb_1 = /re_str_can_break%;\
	/def -p2 -q -agCblue -mregexp -t'^  (([^ ].+) (wird durch|Feuerball \
		verfehlt|Feuerball bringt|Feuerball versengt|Feuerball \
		entzuendet|Feuerball trifft|Feuerball kocht|Feuerball roestet|\
		Feuerball verbrennt) (.+) (Feuerball reichlich warm|\
		meilenweit|zum Schwitzen|Haare und Augenbrauen|Kleidung|an \
		der Schulter|wie einen Hummer|auf kleiner Flamme|russig \
		schwarz|fast zu Asche)?|Dein Feuerball verfehlt (.+))\\\\.$$' \
		re_zau_fb_2 = \
		/set RE_WAFFE Feuerball%%RE_FBALL%%;\
		/set RE_ART %RE_PT2@{%%RE_FARBE_15}Zauberei@{%%RE_FARBE_35}%%;\
		/if ({P6} !~ '') \
			/set RE_ANGREIFER Du%%;\
			/set RE_OPFER %%P6%%;\
			/set RE_SCHADEN meilenweit%%;\
		/elseif ({P2} =~ 'Dir') \
			/set RE_OPFER Dich%%;\
			/set RE_ANGREIFER $$(/RE_genitiv_loeschen %%P4)%%;\
			/set RE_SCHADEN zum Schwitzen%%;\
		/else \
			/set RE_ANGREIFER=$$(/RE_genitiv_loeschen %%P2)%%;\
			/set RE_OPFER %%P4%%;\
			/if ({P3} =~ 'Feuerball entzuendet') \
				/set RE_OPFER $$(/RE_genitiv_loeschen \
					%%RE_OPFER)%%;\
			/endif%%;\
			/set RE_SCHADEN %%P5%%;\
		/endif%%;\
		/if (RE_SCHADEN =~ 'meilenweit') \
			/set RE_SCHADEN 1%%;\
		/elseif (RE_SCHADEN =~ 'zum Schwitzen') \
			/set RE_SCHADEN 5%%;\
		/elseif (RE_SCHADEN =~ 'Haare und Augenbrauen') \
			/set RE_SCHADEN 6%%;\
		/elseif ((RE_SCHADEN =~ 'Kleidung') | \
		    (RE_SCHADEN =~ 'an der Schulter')) \
			/set RE_SCHADEN 7%%;\
		/elseif (RE_SCHADEN =~ 'wie einen Hummer') \
			/set RE_SCHADEN 8%%;\
			/set RE_SCHADEN_SUB -1%%;\
		/elseif (RE_SCHADEN =~ 'auf kleiner Flamme') \
			/set RE_SCHADEN 8%%;\
			/set RE_SCHADEN_SUB 1%%;\
		/elseif (RE_SCHADEN =~ 'russig schwarz') \
			/set RE_SCHADEN 9%%;\
		/elseif (RE_SCHADEN =~ 'fast zu Asche') \
			/set RE_SCHADEN 110%%;\
		/else \
			/set RE_SCHADEN 15%%;\
		/endif%%;\
		/re_ausgabe

;;; Verletze Feuer

/def -p1 -q -agCblue -mregexp -t' richtes?t einen gewaltigen Flammenstrahl auf \
	(.+)\\.$' re_zau_ver_f = \
	/purge re_zau_ver_f_1%;\
	/set RE_WAFFE Feuer%;\
	/set RE_ART %RE_PT2@{%RE_FARBE_15}Zauberei@{%RE_FARBE_35}%;\
	/set RE_ANGREIFER %PL%;\
	/set RE_OPFER %P1%;\
	/re_str_can_break%;\
	/def -p2 -q -1 -agCblue -mregexp -t'^  [^ ].+ (Flammen|Feuer)\
		strahl (produziert nur heisse Luft|bringt .+ zum Schwitzen|\
		trifft .+|macht .+ die Hoelle heiss|braet .+ gut durch\\\\. \
		Steak medium|aeschert .+ einfach ein)[!.]$$' \
		re_zau_ver_f_1 = \
		/if ({P2} =~ 'produziert nur heisse Luft') \
			/set RE_SCHADEN 1%%;\
		/elseif ({P2} =/ 'bringt * zum Schwitzen') \
			/set RE_SCHADEN 5%%;\
		/elseif ({P2} =/ 'trifft * und bringt * Haut zum Kokeln') \
			/set RE_SCHADEN 8%%;\
		/elseif ({P2} =/ 'trifft * Es riecht *') \
			/set RE_SCHADEN 7%%;\
		/elseif ({P2} =/ 'trifft *') \
			/set RE_SCHADEN 6%%;\
		/elseif ({P2} =/ 'macht * die Hoelle heiss') \
			/set RE_SCHADEN 9%%;\
		/elseif ({P2} =/ 'braet * gut durch*') \
			/set RE_SCHADEN 10%%;\
		/elseif ({P2} =/ 'aeschert * einfach ein') \
			/set RE_SCHADEN 111%%;\
		/else \
			/set RE_SCHADEN 15%%;\
		/endif%%;\
		/re_ausgabe
	
;;; Verletze Eis

/def -p1 -q -agCblue -mregexp -t' huells?t (.+) in einen Schneesturm \
	ein\\.$' re_zau_ver_e = \
	/purge re_zau_ver_e_1%;\
	/set RE_WAFFE Eis%;\
	/set RE_ART %RE_PT2@{%RE_FARBE_15}Zauberei@{%RE_FARBE_35}%;\
	/set RE_ANGREIFER %PL%;\
	/set RE_OPFER %P1%;\
	/re_str_can_break%;\
	/def -p2 -q -1 -agCblue -mregexp -t'^  [^ ].+ (zaubers?t eine \
		Schneeflocke( herbei)?|blaest .+ kalten Wind ins Gesicht|\
		triffs?t .+ mit einem kleinen Schneesturm|wirbels?t .+ mit \
		einem kleinen Schneesturm durcheinander|kleiner Schneesturm \
		friert .+ fast die Nase ab|Schneesturm schmettert Eiskristalle \
		auf .+|Schneesturm laesst fast .+ Haende abfrieren|Schneesturm \
		schockgefriert .+ zu Staub)\\\\.$$' re_zau_ver_e_1 = \
		/if ({P1} =/ '* eine Schneeflocke*') \
			/set RE_SCHADEN 1%%;\
		/elseif ({P1} =/ '* Wind ins Gesicht') \
			/set RE_SCHADEN 5%%;\
		/elseif ({P1} =/ 'triff* mit einem kleinen Schneesturm') \
			/set RE_SCHADEN 6%%;\
		/elseif ({P1} =/ 'wirbel* durcheinander') \
			/set RE_SCHADEN 7%%;\
		/elseif ({P1} =/ '* fast die Nase ab') \
			/set RE_SCHADEN 8%%;\
		/elseif ({P1} =/ '* schmettert Eiskristalle auf *') \
			/set RE_SCHADEN 9%%;\
		/elseif ({P1} =/ '* Haende abfrieren') \
			/set RE_SCHADEN 10%%;\
		/elseif ({P1} =/ '*Schneesturm schockgefriert *') \
			/set RE_SCHADEN 111%%;\
		/else \
			/set RE_SCHADEN 15%%;\
		/endif%%;\
		/re_ausgabe

;;; Verletze Magie

/def -p1 -q -agCblue -mregexp -t' huells?t (.+) in einen Wirbel \
	aus Funken\\.$' re_zau_ver_m = \
	/purge re_zau_ver_m_1%;\
	/set RE_WAFFE Magie%;\
	/set RE_ART %RE_PT2@{%RE_FARBE_15}Zauberei@{%RE_FARBE_35}%;\
	/set RE_ANGREIFER %PL%;\
	/set RE_OPFER %P1%;\
	/re_str_can_break%;\
	/def -p2 -q -1 -agCblue -mregexp -t'^  [^ ].+ (produziers?t (nur )?\
		ungefaehrliche Funken|magischen? Funken umschwirren .+|\
		magischen? Funken treffen .+|magischen? Funken lassen .+ \
		erschaudern|magischen? Funken rauben .+ den Atem|magischen? \
		Funken lassen .+ altern|magischen? Funken bringen .+ die \
		Kaelte des Todes|magischen? Funken bringen .+ um den \
		Verstand)\\\\.$$' re_zau_ver_m_1 = \
		/if ({P1} =/ '* ungefaehrliche Funken') \
			/set RE_SCHADEN 1%%;\
		/elseif ({P1} =/ '* Funken umschwirren *') \
			/set RE_SCHADEN 5%%;\
		/elseif ({P1} =/ '* Funken treffen *') \
			/set RE_SCHADEN 6%%;\
		/elseif ({P1} =/ '* Funken lassen * erschaudern') \
			/set RE_SCHADEN 7%%;\
		/elseif ({P1} =/ '* Funken rauben * den Atem') \
			/set RE_SCHADEN 8%%;\
		/elseif ({P1} =/ '* Funken lassen * altern') \
			/set RE_SCHADEN 9%%;\
		/elseif ({P1} =/ '* die Kaelte des Todes') \
			/set RE_SCHADEN 10%%;\
		/elseif ({P1} =/ '* bringen * um den Verstand') \
			/set RE_SCHADEN 111%%;\
		/else \
			/set RE_SCHADEN 15%%;\
		/endif%%;\
		/re_ausgabe

;;; Verletze Wasser

/def -p1 -q -agCblue -mregexp -t' richtes?t einen gewaltigen Wasserstrahl \
	auf (.+)\\.$' re_zau_ver_w = \
	/purge -mglob re_zau_ver_w_1%;\
	/set RE_WAFFE Wasser%;\
	/set RE_ART %RE_PT2@{%RE_FARBE_15}Zauberei@{%RE_FARBE_35}%;\
	/set RE_ANGREIFER %PL%;\
	/set RE_OPFER %P1%;\
	/re_str_can_break%;\
	/def -p2 -q -1 -agCblue -mregexp -t'^  [^ ].+ (zaubers?t einen \
		kleinen Regen|spritzt .+ klitschnass|triffs?t \
		.+ mit einem Wasserstrahl( .*)?|brings?t .+ mit einem \
		Wasserstrahl aus dem Gleichgewicht|spuels?t .+ mit einem \
		heftigen Wasserstrahl fast weg|laesst .+ in einer Sintflut \
		untergehen)\\\\.$$' re_zau_ver_w_1 = \
		/if ({P1} =/ '* kleinen Regen') \
			/set RE_SCHADEN 1%%;\
		/elseif ({P1} =/ '* klitschnass') \
			/set RE_SCHADEN 5%%;\
		/elseif ({P1} =/ '* mit einem Wasserstrahl') \
			/set RE_SCHADEN 6%%;\
		/elseif ({P1} =/ '* aus dem Gleichgewicht') \
			/set RE_SCHADEN 7%%;\
		/elseif ({P1} =/ '* in den Bauch') \
			/set RE_SCHADEN 8%%;\
		/elseif ({P1} =/ '* ins Auge') \
			/set RE_SCHADEN 9%%;\
		/elseif ({P1} =/ '* fast weg') \
			/set RE_SCHADEN 10%%;\
		/elseif ({P1} =/ 'laesst * in einer Sintflut*') \
			/set RE_SCHADEN 111%%;\
		/else \
			/set RE_SCHADEN 15%%;\
		/endif%%;\
		/re_ausgabe

;;; Verletze Wind

/def -p1 -q -agCblue -mregexp -t' laesst eine Windhose um (.*) \
	entstehen\\.$' re_zau_ver_l = \
	/purge re_zau_ver_l_1%;\
	/set RE_WAFFE Wind%;\
	/set RE_ART %RE_PT2@{%RE_FARBE_15}Zauberei@{%RE_FARBE_35}%;\
	/set RE_ANGREIFER %PL%;\
	/set RE_OPFER %P1%;\
	/re_str_can_break%;\
	/def -p2 -q -1 -agCblue -mregexp -t'^  [^ ].+ (zaubers?t ein \
		Windhoeschen|Windhose zerzaust .+ die Haare|triffs?t .+ mit \
		einer kleinen Windhose|wirbels?t .+ mit einer kleinen Windhose \
		durcheinander|kleine Windhose schmettert .+ zu Boden|kleine \
		Windhose hebt .+ zwei Meter in die Luft|Windhose zerfetzt .+|\
		Orkan zerfetzt .+ in kleine Stuecke)\\\\.$$' re_zau_ver_l_1 = \
		/if ({P1} =/ '* ein Windhoeschen') \
			/set RE_SCHADEN 1%%;\
		/elseif ({P1} =/ '* die Haare') \
			/set RE_SCHADEN 5%%;\
		/elseif ({P1} =/ '* einer kleinen Windhose') \
			/set RE_SCHADEN 6%%;\
		/elseif ({P1} =/ '* Windhose durcheinander') \
			/set RE_SCHADEN 7%%;\
		/elseif ({P1} =/ '* zu Boden') \
			/set RE_SCHADEN 8%%;\
		/elseif ({P1} =/ '* in die Luft') \
			/set RE_SCHADEN 9%%;\
		/elseif ({P1} =/ 'Windhose zerfetzt *') \
			/set RE_SCHADEN 10%%;\
		/elseif ({P1} =/ 'Orkan zerfetzt *') \
			/set RE_SCHADEN 111%%;\
		/else \
			/set RE_SCHADEN 15%%;\
		/endif%%;\
 		/re_ausgabe

;;; Verletze Saeure

/def -p1 -q -agCblue -mregexp -t' huells?t (.*) in einen Saeurenebel \
	ein\\.$' re_zau_ver_s = \
	/purge re_zau_ver_s_1%;\
	/set RE_WAFFE Saeure%;\
	/set RE_ART %RE_PT2@{%RE_FARBE_15}Zauberei@{%RE_FARBE_35}%;\
	/set RE_ANGREIFER %PL%;\
	/set RE_OPFER %P1%;\
	/re_str_can_break%;\
	/def -p2 -q -1 -agCblue -mregexp -t'^  (Der (dichte )?\
		Saeurenebel|Ploetzlich|Auf) (zerfaellt sofort|reizt \
		.+ Haut|greift .+ Haut an|bilden sich Blasen auf Deiner \
		Haut|.+ Haut bilden sich Blasen|laesst .+ Fleisch \
		aufquellen|frisst tiefe Wunden in .+ Fleisch|loest .+ \
		das Fleisch von den Knochen|loest .+ Fleisch einfach \
		auf)\\\\.$$' re_zau_ver_s_1 = \
		/if ({P3} =~ 'zerfaellt sofort') \
			/set RE_SCHADEN 1%%;\
		/elseif ({P3} =/ 'reizt * Haut') \
			/set RE_SCHADEN 5%%;\
		/elseif ({P3} =/ 'greift * Haut an') \
			/set RE_SCHADEN 6%%;\
		/elseif ({P3} =/ '*bilden sich Blasen*') \
			/set RE_SCHADEN 7%%;\
		/elseif ({P3} =/ '* Fleisch aufquellen') \
			/set RE_SCHADEN 8%%;\
		/elseif ({P3} =/ '* tiefe Wunden in * Fleisch') \
			/set RE_SCHADEN 9%%;\
		/elseif ({P3} =/ '* von den Knochen') \
			/set RE_SCHADEN 10%%;\
		/elseif ({P3} =/ 'loest * Fleisch einfach auf') \
			/set RE_SCHADEN 111%%;\
		/else \
			/set RE_SCHADEN 15%%;\
		/endif%%;\
		/re_ausgabe

;;; Verletze Laerm

/def -p1 -q -agCblue -mregexp -t' bruells?t (.+) mit ungeheurer \
	Lautstaerke an\\.$' re_zau_ver_k = \
	/purge re_zau_ver_k_1%;\
	/set RE_WAFFE Krach%;\
	/set RE_ART %RE_PT2@{%RE_FARBE_15}Zauberei@{%RE_FARBE_35}%;\
	/set RE_ANGREIFER %PL%;\
	/set RE_OPFER %P1%;\
	/re_str_can_break%;\
	/def -p2 -q -1 -agCblue -mregexp -t'^  [^ ].+ (kraechzt \
		nur leise|Schrei tut Dir in den Ohren weh|Schrei \
		scheint .+ kaum zu stoeren|Schrei droehnt in Deinem \
		Kopf|zuckt merklich zusammen|Schrei hinterlaesst ein ekliges \
		Pfeifen in Deinen Ohren|verzieht das Gesicht vor Schmerzen|\
		Schrei laesst Dich fast ertauben|haelt sich krampfhaft die \
		Ohren zu|Schrei laesst fast Deinen Kopf explodieren|haelt \
		sich krampfhaft den Kopf fest|Schrei fegt .+ einfach um|\
		Schrei zwingt .+ in die Knie)\\\\.$$' re_zau_ver_k_1 = \
		/if ({P1} =/ '* nur leise') \
			/set RE_SCHADEN 1%%;\
		/elseif (({P1} =/ '* den Ohren weh') | \
		    ({P1} =/ '* kaum zu stoeren')) \
			/set RE_SCHADEN 5%%;\
		/elseif (({P1} =/ '* in Deinem Kopf') | \
		    ({P1} =/ '* merklich zusammen')) \
			/set RE_SCHADEN 6%%;\
		/elseif (({P1} =/ '* in Deinen Ohren') |\
		    ({P1} =/ '* Gesicht vor Schmerzen')) \
			/set RE_SCHADEN 7%%;\
		/elseif (({P1} =/ '* fast ertauben') | \
		    ({P1} =/ '* die Ohren zu')) \
			/set RE_SCHADEN 8%%;\
		/elseif (({P1} =/ '* Kopf explodieren') | \
		    ({P1} =/ '* den Kopf fest')) \
			/set RE_SCHADEN 9%%;\
		/elseif ({P1} =/ '* einfach um') \
			/set RE_SCHADEN 10%%;\
		/elseif ({P1} =/ 'Schrei zwingt * in die Knie') \
			/set RE_SCHADEN 111%%;\
		/else \
			/set RE_SCHADEN 15%%;\
		/endif%%;\
		/re_ausgabe

;;; Verletze Gift

/def -p1 -q -agCblue -mregexp -t' bewirfs?t (.*) mit einer Kugel \
	aus eklig gruenem( Schleim\\.)?$' re_zau_ver_g = \
	/purge -mglob re_zau_ver_g_*%;\
	/if ({P2} !~ ' Schleim.') \
		/def -1 -p1 -q  -agCblue -msimple -t'Schleim.' re_zau_ver_g_0%;\
	/endif%;\
	/set RE_WAFFE Gift%;\
	/set RE_ART %RE_PT2@{%RE_FARBE_15}Zauberei@{%RE_FARBE_35}%;\
	/set RE_ANGREIFER %PL%;\
	/set RE_OPFER %P1%;\
	/re_str_can_break%;\
	/def -p2 -q -1 -agCblue -mregexp -t'^  [^ ].+ (laesst \
		eine Kugel eklig gruenen Schleim zu Boden fallen|kannst den \
		vergifteten Schleim nicht kontrollieren|Schleimkugel streift \
		.+|(triffs?t|bedecks?t|huells?t|ertraenks?t) .+ (in|mit) \
		einer Kugel( aus)? eklig gruene[mn] Schleim(.*)?)\\\\.$$' \
		re_zau_ver_g_1 = \
		/if ({P1} =/ '* zu Boden fallen' | \
		    {P1} =/ '* Schleim nicht kontrollieren') \
			/set RE_SCHADEN 1%%;\
		/elseif ({P1} =/ '* streift *') \
			/set RE_SCHADEN 5%%;\
		/elseif ({P1} =/ '* am Arm') \
			/set RE_SCHADEN 7%%;\
		/elseif ({P1} =/ '* ins Gesicht') \
			/set RE_SCHADEN 8%%;\
		/elseif ({P1} =/ 'bedeck* gruenen Schleim') \
			/set RE_SCHADEN 9%%;\
		/elseif ({P1} =/ 'triff* mit einer Kugel *') \
			/set RE_SCHADEN 6%%;\
		/elseif ({P1} =/ 'huell* Schleim ein') \
			/set RE_SCHADEN 10%%;\
		/elseif ({P1} =/ 'ertraenk* Schleim') \
			/set RE_SCHADEN 111%%;\
		/else \
			/set RE_SCHADEN 15%%;\
		/endif%%;\
		/re_ausgabe

;;; TANJIAN

;;; Kaminari

/def -p1 -q -agCblue -w -mregexp -t' lenks?t die sich entladenden \
	Energien auf (.+)\\.$' re_tan_kaminari = \
	/set RE_ANGREIFER %PL%;\
	/set RE_OPFER %P1%;\
	/set RE_WAFFE Kaminari%;\
	/set RE_ART %RE_PT3@{%RE_FARBE_15}Tanjian@{%RE_FARBE_35}%;\
	/re_blitzschaden

/def -p1 -q -agCblue -w -mregexp -t' konzentriert sich und (seine|ihre) \
	Augen beginnen leicht zu gluehen\\.$' re_tan_kaminari2 = \
	/purge -mglob re_tan_kaminari2_*%;\
	/set RE_ANGREIFER %PL%;\
	/set RE_WAFFE Kaminari%;\
	/set RE_ART %RE_PT3@{%RE_FARBE_15}Tanjian@{%RE_FARBE_35}%;\
	/def -1 -p1 -agCblue -q -w -mglob -t'Kleine Blitze zucken um \
		* herum durch die Luft.' re_tan_kaminari2_1%;\
	/def -1 -p1 -agCblue -q -w -mregexp -t'Die Blitze rasen auf \
		(.+) zu\\\\.$$' re_tan_kaminari2_2 = \
		/set RE_OPFER %%P1%%;\
		/purge -mglob re_tan_kaminari2_*%%;\
		/re_blitzschaden

;;; Arashi

/def -p1 -agCblue -q -w -mregexp -t'^Bewegung kommt in die Luft und (.+) \
	lenks?t sie auf (.+)$' re_tan_arashi = \
	/if ({P2} =/ '*.') \
		/set RE_OPFER $[substr({P2},0,-1)]%;\
	/else \
		/set RE_OPFER %P2%;\
		/def -1 -p1 -agCblue -q -w -mregexp -t'\\\\.$$' \
			re_tan_arashi_break = /set RE_OPFER %%RE_OPFER %%PL%;\
	/endif%;\
	/set RE_ANGREIFER %P1%;\
	/set RE_WAFFE Arashi%;\
	/set RE_ART %RE_PT3@{%RE_FARBE_15}Tanjian@{%RE_FARBE_35}%;\
	/re_tan_arashischaden

/ifdef (RE_MULTIPLAYER_TF|p_guild=~""|p_guild=~"tanjian") -p1 -agCblue -q -w \
	-msimple -t'Du konzentrierst Dich auf die Dich umgebende Luft.' \
	re_tan_arashi1 = \
	/purge -mglob re_tan_arashi_*%;\
	/set RE_ANGREIFER Du%;\
	/set RE_WAFFE Arashi%;\
	/set RE_ART %RE_PT3@{%RE_FARBE_15}Tanjian@{%RE_FARBE_35}%;\
	/def -1 -p2 -agCblue -q -w -msimple -t'Ein starker Wind kommt \
		auf.' re_tan_arashi_1%;\
	/re_tan_arashischaden

/def -p1 -agCblue -q -w -mregexp -t' legt den Kopf in den Nacken und \
	konzentriert sich\\.$' re_tan_arashi2 = \
	/set RE_TAN_TMP %PL%;\
	/set RE_TAN_ZEIT $[time()]%;\
	/purge -mglob re_tan_arashi_*

/def -p1 -agCblue -q -w -msimple -t'Ein starker Wind kommt auf.' \
	re_tan_arashi3 = \
	/if (RE_TAN_TMP !~ '') \
		/set RE_ANGREIFER %RE_TAN_TMP%;\
	/else \
		/set RE_ANGREIFER ???%;\
	/endif%;\
	/set RE_WAFFE Arashi%;\
	/set RE_ART %RE_PT3@{%RE_FARBE_15}Tanjian@{%RE_FARBE_35}%;\
	/def -1 -p1 -agCblue -q -w -mregexp -t'Ploetzlich scheint sich \
		der Wind auf (.+) zu konzentrieren\\\\.$$' \
		re_tan_arashi_2 = \
		/set RE_OPFER %%P1%%;\
		/purge -mglob re_tan_arashi_*%%;\
		/re_tan_arashischaden

/def re_tan_arashischaden = \
	/purge -mglob re_tan_arashischaden_*%;\
	/re_str_can_break%;\
	/def -1 -p2 -agCblue -q -w -msimple -t'  Ein leichter Wind kommt \
		auf.' re_tan_arashischaden_0 = \
		/set RE_SCHADEN 1%%;\
		/set RE_TAN_TMP=%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_arashischaden_*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  Ein Windhauch \
		(streift .+|kratzt .+|trifft .+)\\\\.$$' \
		re_tan_arashischaden_1 = \
		/if ({P1} =/ 'streift *') \
			/set RE_SCHADEN 1%%;\
		/elseif ({P1} =/ 'kratzt *') \
			/set RE_SCHADEN 2%%;\
		/elseif ({P1} =/ 'trifft * sehr hart') \
			/set RE_SCHADEN 6%%;\
		/elseif ({P1} =/ 'trifft * hart') \
			/set RE_SCHADEN 5%%;\
		/elseif ({P1} =/ 'trifft *') \
			/set RE_SCHADEN 3%%;\
		/endif%%;\
		/if (RE_OPFER =~ '???' | RE_OPFER =~ '') \
			/let RE_OPFERTMP %%P1%%;\
			/if (regmatch('trifft (.+) sehr hart', RE_OPFERTMP)) \
				/set RE_OPFER %%P1%%;\
			/elseif (regmatch('trifft (.+) hart', RE_OPFERTMP)) \
				/set RE_OPFER %%P1%%;\
			/elseif (regmatch('(trifft|kratzt|streift) (.+)', \
			    RE_OPFERTMP)) \
				/set RE_OPFER %%P1%%;\
			/endif%%;\
		/endif%%;\
		/set RE_TAN_TMP=%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_arashischaden_*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  Ein Windstoss \
		schuettelt (.+) durch\\\\.$$' \
		re_tan_arashischaden_2 = \
		/if ({P1} =/ '* kraeftig') \
			/set RE_SCHADEN 8%%;\
		/else \
			/set RE_SCHADEN 7%%;\
		/endif%%;\
		/if (RE_OPFER =~ '???' | RE_OPFER =~ '') \
			/let RE_OPFERTMP %%P1%%;\
			/if (regmatch(' kraeftig\$',RE_OPFERTMP)) \
				/set RE_OPFER %%PL%%;\
			/else \
				/set RE_OPFER %%RE_OPFERTMP%%;\
			/endif%%;\
		/endif%%;\
		/set RE_TAN_TMP=%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_arashischaden_*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  Eine Windboee? haut (.+) \
		um\\\\.$$' re_tan_arashischaden_3 = \
		/set RE_OPFER %%P1%%;\
		/set RE_SCHADEN 9%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_arashischaden_*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  Ein Wirbelwind wirbelt \
		(.+) herum\\\\.$$' re_tan_arashischaden_4 = \
		/set RE_OPFER %%P1%%;\
		/set RE_SCHADEN 10%%;\
		/set RE_TAN_TMP=%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_arashischaden_*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  [^ ].+ Sturm \
		(schleudert .+ zu Boden|zerfetzt .+|vernichtet .+)\\\\.$$' \
		re_tan_arashischaden_5 = \
		/if ({P1} =/ 'schleudert *') \
			/set RE_SCHADEN 11%%;\
		/elseif ({P1} =/ 'zerfetzt *') \
			/set RE_SCHADEN 12%%;\
		/elseif ({P1} =/ 'vernichtet *') \
			/set RE_SCHADEN 13%%;\
		/endif%%;\
		/if (RE_OPFER =~ '???' | RE_OPFER =~ '') \
			/let RE_OPFERTMP %%P1%%;\
			/if /test regmatch('schleudert (.+) zu', \
			    RE_OPFERTMP)%%; /then \
				/set RE_OPFER %%P1%%;\
			/elseif /test regmatch('^(zerfetzt|vernichtet) ', \
			    RE_OPFERTMP)%%; /then \
				/set RE_OPFER %%PR%%;\
			/endif%%;\
		/endif%%;\
		/set RE_TAN_TMP=%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_arashischaden_*

;;; Samusa

/def -p1 -q -w -agCblue -mregexp -t' lenks?t die Kaelte auf (.+)\\.$' \
	re_tan_samusa = \
	/set RE_ANGREIFER %PL%;\
	/set RE_OPFER %P1%;\
	/set RE_WAFFE Samusa%;\
	/set RE_ART %RE_PT3@{%RE_FARBE_15}Tanjian@{%RE_FARBE_35}%;\
	/re_tan_samusaschaden

/def -p1 -q -agCblue -mregexp -t' konzentriert sich mit halb geschlossenen \
	Augen\\.$' re_tan_samusa2 = \
	/set RE_TAN_ZEIT $[time()]%;\
	/set RE_TAN_TMP=%PL

/def -p1 -q -w -agCblue -msimple -t'Es wird ploetzlich kaelter.' \
	re_tan_samusa3 = \
	/purge re_tan_samusa3_1%;\
	/def -1 -p1 -q -w -agCblue -mregexp -t'Auf (.+) Haut bilden sich \
		ploetzlich (kleine |)Eiskristalle[.!]$$' \
		re_tan_samusa3_1 =\
		/set RE_OPFER $$(/re_genitiv_loeschen %%P1)%%;\
		/set RE_WAFFE Samusa%%;\
		/set RE_ART %RE_PT3@{%%RE_FARBE_15}Tanjian@{%%RE_FARBE_35}%%;\
		/if (RE_TAN_TMP !~ '') \
			/set RE_ANGREIFER %%RE_TAN_TMP%%;\
		/else \
			/set RE_ANGREIFER=???%%;\
		/endif%%;\
		/set RE_TAN_TMP=%%;\
		/re_tan_samusaschaden

/def re_tan_samusaschaden = \
	/purge -mglob re_tan_samusa_s*%;\
	/def -1 -p2 -q -w -agCblue -mregexp -t'^  [^ ].+ froestels?t\\\\.$$' \
		re_tan_samusa_s1 = \
		/set RE_SCHADEN 1%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_samusa_s*%;\
	/def -1 -p2 -q -w -agCblue -mglob -t'  Ein kalter Hauch streift *.' \
		re_tan_samusa_s2 = \
		/set RE_SCHADEN 1%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_samusa_s*%;\
	/def -1 -p2 -q -w -agCblue -mglob -t'  Die Kaelte {brennt|kitzelt} \
		auf * Haut.' re_tan_samusa_s3 = \
		/if ({3} =~ 'brennt') \
			/set RE_SCHADEN 3%%;\
		/elseif ({3} =~ 'kitzelt') \
			/set RE_SCHADEN 2%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_samusa_s*%;\
	/def -1 -p2 -q -w -agCblue -mregexp -t'^  [^ ].+ Haut bekommt \
		einen (leichten |)Blaustich\\\\.$$' re_tan_samusa_s4 = \
		/if ({P2} =~ '') \
			/set RE_SCHADEN 3%%;\
		/elseif ({P2} =~ 'leichten ') \
			/set RE_SCHADEN 2%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_samusa_s*%;\
	/def -1 -p2 -q -w -agCblue -mregexp -t'^  Eine eisige Boee? wirbelt \
		(.+) herum\\\\.$$' re_tan_samusa_s5 = \
		/if ({P1} =/ '* maechtig') \
			/set RE_SCHADEN 7%%;\
		/elseif ({P1} =/ '* etwas ') \
			/set RE_SCHADEN 5%%;\
		/else \
			/set RE_SCHADEN 6%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_samusa_s*%;\
	/def -1 -p2 -q -w -agCblue -mglob -t'  {Kalter|Eiskalter} Regen \
		prasselt auf * herab.' re_tan_samusa_s6 = \
		/if ({1} =~ 'Kalter') \
			/set RE_SCHADEN 8%%;\
		/elseif ({1} =~ 'Eiskalter') \
			/set RE_SCHADEN 9%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_samusa_s*%;\
	/def -1 -p2 -q -w -agCblue -mregexp -t'^  [^ ].+ schreis?t vor \
		Kaelte\\\\.$$' re_tan_samusa_s7 = \
		/set RE_SCHADEN 10%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_samusa_s*%;\
	/def -1 -p2 -q -w -agCblue -mglob -t'  Ein Eishagel \
		{zerschmettert|zermatscht} *.' re_tan_samusa_s8 = \
		/if ({3} =~ 'zerschmettert') \
			/set RE_SCHADEN 11%%;\
		/elseif ({3} =~ 'zermatscht') \
			/set RE_SCHADEN 12%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_samusa_s*%;\
	/def -1 -p2 -q -w -agCblue -mglob -t'  Toedliche Kaelte umfaengt *.' \
		re_tan_samusa_s9 = \
		/set RE_SCHADEN 13%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_samusa_s*

;;; Kshira

/def -p1 -q -w -agCblue -mregexp -t' lenks?t Angst und Terror auf .+ \
	Gegner\\.$' re_tan_kshira = \
	/set RE_TAN_TMP %PL%;\
	/set RE_TAN_ZEIT $[time()]%;\
	/re_tan_kshiraschaden

/def -p1 -q -w -agCblue -mregexp -t' konzentriert sich\\.$' re_tan_kshira2 = \
	/set RE_TAN_TMP %PL%;\
	/set RE_TAN_ZEIT $[time()]

/def -p1 -q -w -agCblue -msimple -t'Du spuerst ploetzlich eine \
	furchteinfloessende Macht um Dich herum.' re_tan_kshira3 = \
	/purge re_tan_kshira3_1%;\
	/set RE_TAN_ZEIT $[time()]%;\
	/def -1 -p1 -q -w -agCblue -msimple -t'Angst und Terror greifen um \
		sich.' re_tan_kshira3_1 = \
		/re_tan_kshiraschaden

/def re_tan_kout=\
	/set RE_WAFFE Kshira%;\
	/set RE_ART %RE_PT3@{%RE_FARBE_15}Tanjian@{%RE_FARBE_35}%;\
	/if (RE_TAN_TMP !~ '') \
		/set RE_ANGREIFER %RE_TAN_TMP%;\
	/else \
		/set RE_ANGREIFER ???%;\
	/endif%;\
	/re_ausgabe

/def re_tan_kshiraschaden=\
	/purge -mglob re_tan_kshira_s*%;\
	/def -p2 -q -w -agCblue -mregexp -t'^  Die Angst (kann|schmettert|\
		nagt an) (.+) (nichts anhaben|zu Boden|Eingeweiden)\
		\\\\.$$' re_tan_kshira_s1 = \
		/set RE_OPFER %%P2%%;\
		/if ({P3} =~ 'nichts anhaben') \
			/set RE_SCHADEN 1%%;\
		/elseif ({P3} =~ 'zu Boden') \
			/set RE_SCHADEN 7%%;\
		/elseif ({P3} =~ 'Eingeweiden') \
			/set RE_OPFER $$(/re_genitiv_loeschen %%RE_OPFER)%%;\
			/set RE_SCHADEN 8%%;\
		/else \
			/set RE_SCHADEN 15%%;\
		/endif%%;\
		/re_tan_kout%;\
	/def -p2 -q -w -agCblue -mregexp -t'^  ([^ ].+) (zitters?t\
		( etwas)?|schlotters?t mit den Knien|quellen vor Angst die \
		Augen aus dem Kopf|stirbs?t vor Angst)\\\\.$$' \
		re_tan_kshira_s2 = \
		/set RE_OPFER %%P1%%;\
		/if ({P2} =/ 'zitter*') \
			/set RE_SCHADEN 2%%;\
		/elseif ({P2} =/ '* mit den Knien') \
			/set RE_SCHADEN 3%%;\
		/elseif ({P2} =/ 'quellen vor Angst die Augen *') \
			/set RE_SCHADEN 12%%;\
		/elseif ({P2} =/ '* vor Angst') \
			/set RE_SCHADEN 13%%;\
		/else \
			/set RE_SCHADEN 15%%;\
		/endif%%;\
		/re_tan_kout%;\
	/def -p2 -q -w -agCblue -mglob -t'  Der Terror zermuerbt *.' \
		re_tan_kshira_s3 = \
		/set RE_OPFER %%-3%%;\
		/set RE_SCHADEN 6%%;\
		/re_tan_kout%;\
	/def -p2 -q -w -agCblue -mregexp -t'^  Der Terror (trifft|\
		zerreisst) (.+) (hart|Gehirn)\\\\.$$' re_tan_kshira_s4 = \
		/set RE_OPFER %%P2%%;\
		/if ({P3} =~ 'hart') \
			/set RE_SCHADEN 5%%;\
		/elseif ({P3} =~ 'Gehirn') \
			/set RE_OPFER $$(/re_genitiv_loeschen %%RE_OPFER)%%;\
			/set RE_SCHADEN 10%%;\
		/else \
			/set RE_SCHADEN 15%%;\
		/endif%%;\
		/re_tan_kout%;\
	/def -p2 -q -w -agCblue -mregexp -t'^  Angst und Terror (martern|\
		zerfetzen) (.+) Koerper\\\\.$$' re_tan_kshira_s5 = \
		/set RE_OPFER $$(/re_genitiv_loeschen %%P2)%%;\
		/if ({P1} =~ 'martern') \
			/set RE_SCHADEN 9%%;\
		/elseif ({P1} =~ 'zerfetzen') \
			/set RE_SCHADEN 11%%;\
		/endif%%;\
		/re_tan_kout

;;; Kami

/def -Fp1 -q -mregexp -t' richtes?t (.+) auf (.+)[!\\.]$' \
	re_tan_kami = \
	/set RE_TAN_ANGREIFER=%PL%;\
	/set RE_TAN_OPFER=%P2%;\
	/if /ismacro ut_str2weapon%; /then \
		/let RE_TAN_KAMITMPSTR=%PL%P0%;\
		/let RE_TAN_KAMIWEAPON=$(/ut_str2weapon %P1)%;\
		/if (RE_TAN_KAMIWEAPON =~ UT_WAFFE) \
			/substitute -agCblue %RE_TAN_KAMITMPSTR%;\
		/endif%;\
	/endif

;;; Kami Feuer

/def -p1 -q -w -agCblue -mglob -t'* ist ploetzlich von einer Flammenlohe \
	umgeben.' re_tan_kami_feuer = \
	/if (RE_TAN_ANGREIFER !~ '') \
		/set RE_ANGREIFER %RE_TAN_ANGREIFER%;\
	/else \
		/set RE_ANGREIFER ???%;\
	/endif%;\
	/if (RE_TAN_OPFER !~ '') \
		/set RE_OPFER %RE_TAN_OPFER%;\
	/else \
		/set RE_OPFER ???%;\
	/endif%;\
	/set RE_WAFFE Kami.Feuer%;\
	/set RE_ART %RE_PT3@{%RE_FARBE_15}Tanjian@{%RE_FARBE_35}%;\
	/set RE_TAN_OPFER=%;\
	/set RE_TAN_ANGREIFER=%;\
	/purge -mglob re_tan_kami_feuerschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mglob -t'  Ein warmer Lufthauch \
		streift *.' re_tan_kami_feuerschaden_1 = \
		/set RE_SCHADEN 1%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_feuerschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  Ein Flammenstrahl (streift \
		.+|trifft .+)\\\\.$$' re_tan_kami_feuerschaden_2 = \
		/if ({P1} =/ 'streift * leicht') \
			/set RE_SCHADEN 1%%;\
		/elseif ({P1} =/ 'streift *') \
			/set RE_SCHADEN 2%%;\
		/elseif ({P1} =/ 'trifft * sehr hart') \
			/set RE_SCHADEN 6%%;\
		/elseif ({P1} =/ 'trifft * hart') \
			/set RE_SCHADEN 5%%;\
		/elseif ({P1} =/ 'trifft *') \
			/set RE_SCHADEN 4%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_feuerschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  Ein (grosser|maechtiger|\
		gigantischer) Flammenstrahl (roestet .+|kocht .+|aeschert \
		.+|atomisiert .+)\\\\.$$' re_tan_kami_feuerschaden_3 = \
		/if ({P2} =/ 'roestet * durch') \
			/set RE_SCHADEN 8%%;\
		/elseif ({P2} =/ 'roestet *') \
			/set RE_SCHADEN 7%%;\
		/elseif ({P2} =/ 'kocht * gar') \
			/set RE_SCHADEN 10%%;\
		/elseif ({P2} =/ 'kocht *') \
			/set RE_SCHADEN 9%%;\
		/elseif ({P2} =/ 'aeschert *') \
			/set RE_SCHADEN 11%%;\
			/if ({P2} !/ '* ein.') \
				/def -1 -p1 -agCblue -q -w -mglob -t'*ein.' \
					re_tan_kami_feuerschaden_3g%%;\
			/endif%%;\
		/elseif ({P2} =/ 'atomisiert *') \
			/set RE_SCHADEN 12%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_feuerschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  [^ ].+ verpuffs?t in \
		einem Flammenstrahl\\\\.$$' re_tan_kami_feuerschaden_4 = \
		/set RE_SCDHADEN 13%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_feuerschaden_*

;;; Kami Saeure

/def -p1 -q -w -agCblue -mglob -t'Gruenlicher Schleim benetzt ploetzlich *.' \
	re_tan_kami_saeure = \
	/if (RE_TAN_ANGREIFER !~ '') \
		/set RE_ANGREIFER %RE_TAN_ANGREIFER%;\
	/else \
		/set RE_ANGREIFER ???%;\
	/endif%;\
	/if (RE_TAN_OPFER !~ '') \
		/set RE_OPFER %RE_TAN_OPFER%;\
	/else \
		/set RE_OPFER ???%;\
	/endif%;\
	/set RE_WAFFE Kami.Saeure%;\
	/set RE_ART %RE_PT3@{%RE_FARBE_15}Tanjian@{%RE_FARBE_35}%;\
	/set RE_TAN_OPFER=%;\
	/set RE_TAN_ANGREIFER=%;\
	/purge -mglob re_tan_kami_saeureschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  Ein Saeurestrahl (schiesst \
		an .+ vorbei|streift .+|trifft .+|aetzt .+ an|veraetzt \
		.+)\\\\.$$' re_tan_kami_saeureschaden_1 = \
		/if ({P1} =/ 'schiesst *') \
			/set RE_SCHADEN 1%%;\
		/elseif ({P1} =/ 'streift * leicht') \
			/set RE_SCHADEN 1%%;\
		/elseif ({P1} =/ 'streift *') \
			/set RE_SCHADEN 2%%;\
		/elseif ({P1} =/ 'trifft * sehr hart') \
			/set RE_SCHADEN 6%%;\
		/elseif ({P1} =/ 'trifft * hart') \
			/set RE_SCHADEN 5%%;\
		/elseif ({P1} =/ 'trifft *') \
			/set RE_SCHADEN 4%%;\
		/elseif ({P1} =/ 'aetzt * an') \
			/set RE_SCHADEN 7%%;\
		/elseif ({P1} =/ 'veraetzt * etwas') \
			/set RE_SCHADEN 8%%;\
		/elseif ({P1} =/ 'veraetzt * Gesicht') \
			/set RE_SCHADEN 9%%;\
		/elseif ({P1} =/ 'veraetzt * total') \
			/set RE_SCHADEN 10%%;\
		/else \
			/set RE_SCHADEN 15%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_saeureschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mglob -t'  Eine Saeureflut loesst * auf.' \
		re_tan_kami_saeureschaden_2 = \
		/if ({L2} =~ 'voellig') \
			/set RE_SCHADEN 12%%;\
		/else \
			/set RE_SCHADEN 11%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_saeureschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  [^ ].+ vergeht in einer \
		Saeureflut\\\\.$$' re_tan_kami_saeureschaden_3 = \
		/set RE_SCHADEN 13%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_saeureschaden_*

;;; Kami Eis

/def -p1 -q -w -agCblue -mglob -t'Auf * bilden sich ploetzlich grosse \
	Eiskristalle.' re_tan_kami_eis = \
	/if (RE_TAN_ANGREIFER !~ '') \
		/set RE_ANGREIFER %RE_TAN_ANGREIFER%;\
	/else \
		/set RE_ANGREIFER ???%;\
	/endif%;\
	/if (RE_TAN_OPFER !~ '') \
		/set RE_OPFER %RE_TAN_OPFER%;\
	/else \
		/set RE_OPFER ???%;\
	/endif%;\
	/set RE_WAFFE Kami.Eis%;\
	/set RE_ART %RE_PT3@{%RE_FARBE_15}Tanjian@{%RE_FARBE_35}%;\
	/set RE_TAN_OPFER=%;\
	/set RE_TAN_ANGREIFER=%;\
	/purge -mglob re_tan_kami_eisschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mglob -t'  Ein kalter Lufthauch laesst * \
		froesteln.' re_tan_kami_eisschaden_1 = \
		/set RE_SCHADEN 1%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_eisschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  Ein kleiner Eissplitter \
		(streift .+|trifft .+)\\\\.$$' re_tan_kami_eisschaden_2 = \
		/if ({P1} =/ 'streift * leicht') \
			/set RE_SCHADEN 1%%;\
		/elseif ({P1} =/ 'streift *') \
			/set RE_SCHADEN 2%%;\
		/elseif ({P1} =/ 'trifft * sehr hart') \
			/set RE_SCHADEN 6%%;\
		/elseif ({P1} =/ 'trifft * hart') \
			/set RE_SCHADEN 5%%;\
		/elseif ({P1} =/ 'trifft *') \
			/set RE_SCHADEN 4%%;\
		/else \
			/set RE_SCHADEN 15%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_eisschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mglob -t'  Hagelkoerner schlagen * \
		entgegen.' re_tan_kami_eisschaden_3 = \
		/set RE_SCHADEN 7%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_eisschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mglob -t'  Ein starker Eishagel trifft *.' \
		re_tan_kami_eisschaden_4 = \
		/set RE_SCHADEN 8%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_eisschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  Kopfgrosse Eisbaelle \
		treffen (.+)\\\\.$$' re_tan_kami_eisschaden_5 = \
		/if ({P1} =/ '* sehr hart') \
			/set RE_SCHADEN 11%%;\
		/elseif ({P1} =/ '* hart') \
			/set RE_SCHADEN 10%%;\
		/else \
			/set RE_SCHADEN 9%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_eisschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mglob -t'  Eine toedliche Kaelte huellt * \
		ein.' re_tan_kami_eisschaden_6 = \
		/set RE_SCHADEN 12%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_eisschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  [^ ].+ verwandels?t .+ in \
		einen Eisblock\\\\.$$' re_tan_kami_eisschaden_7 = \
		/set RE_SCHADEN 13%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_eisschaden_*

;;; Kami Gift

/def -p1 -q -w -agCblue -mglob -t'Ein gruenlicher Schimmer umgibt \
	ploetzlich *.' re_tan_kami_gift = \
	/if (RE_TAN_ANGREIFER !~ '') \
		/set RE_ANGREIFER %RE_TAN_ANGREIFER%;\
	/else \
		/set RE_ANGREIFER ???%;\
	/endif%;\
	/if (RE_TAN_OPFER !~ '') \
		/set RE_OPFER %RE_TAN_OPFER%;\
	/else \
		/set RE_OPFER ???%;\
	/endif%;\
	/set RE_WAFFE Kami.Gift%;\
	/set RE_ART %RE_PT3@{%RE_FARBE_15}Tanjian@{%RE_FARBE_35}%;\
	/set RE_TAN_OPFER=%;\
	/set RE_TAN_ANGREIFER=%;\
	/purge -mglob re_tan_kami_giftschaden_*%;\
	/def -1 -p2 -agCblue -q -w -msimple -t'  Nichts passiert.' \
		re_tan_kami_giftschaden_1 = \
		/set RE_SCHADEN 1%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_giftschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  Ein gruener Lichtstrahl \
		(streift .+|trifft .+)\\\\.$$' re_tan_kami_giftschaden_2 = \
		/if ({P1} =/ 'streift * leicht') \
			/set RE_SCHADEN 1%%;\
		/elseif ({P1} =/ 'streift *') \
			/set RE_SCHADEN 2%%;\
		/elseif ({P1} =/ 'trifft * sehr hart') \
			/set RE_SCHADEN 6%%;\
		/elseif ({P1} =/ 'trifft * hart') \
			/set RE_SCHADEN 5%%;\
		/elseif ({P1} =/ 'trifft *') \
			/set RE_SCHADEN 4%%;\
		/else \
			/set RE_SCHADEN 15%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_giftschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  Ein giftgruener Blitz \
		trifft (.+)\\\\.$$' re_tan_kami_giftschaden_3 = \
		/if ({P1} =/ '* sehr hart') \
			/set RE_SCHADEN 9%%;\
		/elseif ({P1} =/ '* hart') \
			/set RE_SCHADEN 8%%;\
		/else \
			/set RE_SCHADEN 7%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_giftschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mglob -t'  Eine giftgruene Wolke \
		huellt * ein.' re_tan_kami_giftschaden_4 = \
		/set RE_SCHADEN 10%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_giftschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mglob -t'  Ein Giftpfeilhagel geht \
		auf * nieder.' re_tan_kami_giftschaden_5 = \
		/set RE_SCHADEN 11%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_giftschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  Ein giftgruene(s Wallen \
		schmettert .+ zu Boden|r Keil spaltet .+)\\\\.$$' \
		re_tan_kami_giftschaden_6 = \
		/if ({P1} =/ '* Keil spaltet *') \
			/set RE_SCHADEN 13%%;\
		/elseif ({P1} =/ '* Wallen schmettert *') \
			/set RE_SCHADEN 12%%;\
		/else \
			/set RE_SCHADEN 15%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_giftschaden_*

;;; Kami Blitz

/def -p1 -q -w -agCblue -mregexp -t'^[^ ].+ ist ploetzlich von \
	kleinen Blitzen umgeben\\.$' re_tan_kami_blitz = \
	/if (RE_TAN_ANGREIFER !~ '') \
		/set RE_ANGREIFER %RE_TAN_ANGREIFER%;\
	/else \
		/set RE_ANGREIFER ???%;\
	/endif%;\
	/if (RE_TAN_OPFER !~ '') \
		/set RE_OPFER %RE_TAN_OPFER%;\
	/else \
		/set RE_OPFER ???%;\
	/endif%;\
	/set RE_WAFFE Kami.Blitz%;\
	/set RE_ART %RE_PT3@{%RE_FARBE_15}Tanjian@{%RE_FARBE_35}%;\
	/set RE_TAN_OPFER=%;\
	/set RE_TAN_ANGREIFER=%;\
	/purge -mglob re_tan_kami_blitzschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mglob -t'  Ein Gluehwuermchen fliegt \
		an * vorbei.' re_tan_kami_blitzschaden_1 = \
		/set RE_SCHADEN 1%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_blitzschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  Ein fahler Blitz streift \
		(.+)\\\\.$$' re_tan_kami_blitzschaden_2 = \
		/if ({P1} =/ '* leicht') \
			/set RE_SCHADEN 1%%;\
		/else \
			/set RE_SCHADEN 2%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_blitzschaden_*%;\
	/def -1 -p4 -agCblue -q -w -mregexp -t'^  Ein Blitz trifft (.+)\
		\\\\.$$' re_tan_kami_blitzschaden_3 = \
		/if ({P1} =/ '* sehr hart') \
			/set RE_SCHADEN 6%%;\
		/elseif ({P1} =/ '* hart') \
			/set RE_SCHADEN 5%%;\
		/else \
			/set RE_SCHADEN 4%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_blitzschaden_*%;\
	/def -1 -p4 -agCblue -q -w -mregexp -t'^  Ein (greller|heftiger|\
		gigantischer|unglaublicher) Blitz (trifft .+|schmettert .+ zu \
		Boden|zerfetzt .+|zerreisst .+|atomisiert .+|vernichtet .+)\
		\\\\.$$' re_tan_kami_blitzschaden_4 = \
		/if ({P2} =/ 'trifft * sehr hart') \
			/set RE_SCHADEN 8%%;\
		/elseif ({P2} =/ 'trifft * hart') \
			/set RE_SCHADEN 7%%;\
		/elseif ({P2} =/ 'schmettert * zu Boden') \
			/set RE_SCHADEN 9%%;\
		/elseif ({P2} =/ 'zerfetzt *') \
			/set RE_SCHADEN 10%%;\
		/elseif ({P2} =/ 'zerreisst *') \
			/set RE_SCHADEN 11%%;\
		/elseif ({P2} =/ 'atomisiert *') \
			/set RE_SCHADEN 12%%;\
		/elseif ({P2} =/ 'vernichtet *') \
			/set RE_SCHADEN 13%%;\
		/else \
			/set RE_SCHADEN 15%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_blitzschaden_*

;;; Kami Wasser

/def -p1 -q -w -agCblue -mglob -t'Auf * bilden sich ploetzlich einige \
	Wassertropfen.' re_tan_kami_wasser = \
	/if (RE_TAN_ANGREIFER !~ '') \
		/set RE_ANGREIFER %RE_TAN_ANGREIFER%;\
	/else \
		/set RE_ANGREIFER ???%;\
	/endif%;\
	/if (RE_TAN_OPFER !~ '') \
		/set RE_OPFER %RE_TAN_OPFER%;\
	/else \
		/set RE_OPFER ???%;\
	/endif%;\
	/set RE_WAFFE Kami.Wasser%;\
	/set RE_ART %RE_PT3@{%RE_FARBE_15}Tanjian@{%RE_FARBE_35}%;\
	/set RE_TAN_OPFER=%;\
	/set RE_TAN_ANGREIFER=%;\
	/purge -mglob re_tan_kami_wasserschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  Ein Wassertropfen \
		(faellt zu Boden|streift .+|trifft .+)\\\\.$$' \
		re_tan_kami_wasserschaden_1 = \
		/if ({P1} =~ 'faellt zu Boden') \
			/set RE_SCHADEN 1%%;\
		/elseif ({P1} =/ 'streift *') \
			/set RE_SCHADEN 1%%;\
		/elseif ({P1} =/ 'trifft *') \
			/set RE_SCHADEN 2%%;\
		/else \
			/set RE_SCHADEN 15%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_wasserschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  Ein Wasserstrahl \
		(trifft .+|bricht .+ die Knochen|spuelt .+ hinfort)\\\\.$$' \
		re_tan_kami_wasserschaden_2 = \
		/if ({P1} =/ 'trifft * sehr hart') \
			/set RE_SCHADEN 6%%;\
		/elseif ({P1} =/ 'trifft * hart') \
			/set RE_SCHADEN 5%%;\
		/elseif ({P1} =/ 'trifft *') \
			/set RE_SCHADEN 4%%;\
		/elseif ({P1} =/ 'bricht * die Knochen') \
			/set RE_SCHADEN 10%%;\
		/elseif ({P1} =/ 'spuelt * hinfort') \
			/set RE_SCHADEN 11%%;\
		/else \
			/set RE_SCHADEN 15%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_wasserschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  Eine Wasserfontaene \
		trifft (.+)\\\\.$$' re_tan_kami_wasserschaden_3 = \
		/if ({P1} =/ '* sehr hart') \
			/set RE_SCHADEN 9%%;\
		/elseif ({P1} =/ '* hart') \
			/set RE_SCHADEN 8%%;\
		/else \
			/set RE_SCHADEN 7%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_wasserschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mglob -t'  Ein Wasserfall \
		{zerschmettert|vernichtet} *.' \
		re_tan_kami_wasserschaden_4 = \
		/if ({3} =~ 'zerschmettert') \
			/set RE_SCHADEN 12%%;\
		/elseif ({3} =~ 'vernichtet') \
			/set RE_SCHADEN 13%%;\
		/else \
			/set RE_SCHADEN 15%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_wasserschaden_*

;;; Kami Wind

/def -p1 -q -w -agCblue -mglob -t'Ploetzlich geht ein leises Heulen von * \
	aus.' re_tan_kami_wind = \
	/if (RE_TAN_ANGREIFER !~ '') \
		/set RE_ANGREIFER %RE_TAN_ANGREIFER%;\
	/else \
		/set RE_ANGREIFER ???%;\
	/endif%;\
	/if (RE_TAN_OPFER !~ '') \
		/set RE_OPFER %RE_TAN_OPFER%;\
	/else \
		/set RE_OPFER ???%;\
	/endif%;\
	/set RE_WAFFE Kami.Wind%;\
	/set RE_ART %RE_PT3@{%RE_FARBE_15}Tanjian@{%RE_FARBE_35}%;\
	/set RE_TAN_OPFER=%;\
	/set RE_TAN_ANGREIFER=%;\
	/purge -mglob re_tan_kami_windschaden_*%;\
	/def -1 -p2 -agCblue -q -w -msimple -t'  Ein leichter Wind kommt \
		auf.' re_tan_kami_windschaden_1 = \
		/set RE_SCHADEN 1%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_windschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  Ein Windhauch (streift .+|\
		trifft .+)\\\\.$$' re_tan_kami_windschaden_2 = \
		/if ({P1} =/ 'streift * leicht') \
			/set RE_SCHADEN 1%%;\
		/elseif ({P1} =/ 'streift *') \
			/set RE_SCHADEN 2%%;\
		/elseif ({P1} =/ 'trifft * sehr hart') \
			/set RE_SCHADEN 6%%;\
		/elseif ({P1} =/ 'trifft * hart') \
			/set RE_SCHADEN 5%%;\
		/elseif ({P1} =/ 'trifft *') \
			/set RE_SCHADEN 4%%;\
		/else \
			/set RE_SCHADEN 15%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_windschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mglob -t'  Eine Windboee haut * um.' \
		re_tan_kami_windschaden_3 = \
		/set RE_SCHADEN 7%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_windschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mglob -t'  Ein Wirbelwind schleudert \
		* herum.' re_tan_kami_windschaden_4 = \
		/set RE_SCHADEN 8%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_windschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  Eine (maechtige |\
		unglaubliche |)Druckwelle (schleudert .+ zu Boden|zerfetzt .+|\
		zermatscht .+)\\\\.$$' re_tan_kami_windschaden_5 = \
		/if ({P2} =/ 'schleudert * zu Boden') \
			/if ({P1} =~ 'maechtige ') \
				/set RE_SCHADEN 10%%;\
			/else \
				/set RE_SCHADEN 9%%;\
			/endif%%;\
		/elseif ({P2} =/ 'zerfetzt *') \
			/if ({P1} =~ 'maechtige') \
				/set RE_SCHADEN 12%%;\
			/else \
				/set RE_SCHADEN 11%%;\
			/endif%%;\
		/elseif ({P2} =/ 'zermatscht *') \
			/set RE_SCHADEN 13%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_windschaden_*

;;; Kami Magie

/def -p1 -q -w -agCblue -mregexp -t'^[^ ].+ leuchtet ploetzlich in oktarinem \
	Licht\\.$' re_tan_kami_magie = \
	/if (RE_TAN_ANGREIFER !~ '') \
		/set RE_ANGREIFER %RE_TAN_ANGREIFER%;\
	/else \
		/set RE_ANGREIFER ???%;\
	/endif%;\
	/if (RE_TAN_OPFER !~ '') \
		/set RE_OPFER %RE_TAN_OPFER%;\
	/else \
		/set RE_OPFER ???%;\
	/endif%;\
	/set RE_WAFFE Kami.Magie%;\
	/set RE_ART %RE_PT3@{%RE_FARBE_15}Tanjian@{%RE_FARBE_35}%;\
	/set RE_TAN_OPFER=%;\
	/set RE_TAN_ANGREIFER=%;\
	/purge -mglob re_tan_kami_magieschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  (Nichts passiert|\
		Du spuerst ein merkwuerdiges Kribbeln|Irgendetwas scheint \
		.+ zu kitzeln)\\\\.$$' re_tan_kami_magieschaden_1 = \
		/set RE_SCHADEN 1%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_magieschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mglob -t'  Kleine Funken kitzeln *.' \
		re_tan_kami_magieschaden_2 = \
		/set RE_SCHADEN 2%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_magieschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  Ein (h|gr)elles \
		Leuchten flackert um .+ herum auf\\\\.$$' \
		re_tan_kami_magieschaden_3 = \
		/if ({P1} =~ 'h') \
			/set RE_SCHADEN 4%%;\
		/elseif ({P1} =~ 'gr') \
			/set RE_SCHADEN 5%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_magieschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  Ein Funken(strahl|regen) \
		(trifft .+|huellt .+)\\\\.$$' re_tan_kami_magieschaden_4 = \
		/if ({P2} =/ 'trifft * sehr hart') \
			/set RE_SCHADEN 8%%;\
		/elseif ({P2} =/ 'trifft * hart') \
			/set RE_SCHADEN 7%%;\
		/elseif ({P2} =/ 'trifft *') \
			/set RE_SCHADEN 6%%;\
		/elseif ({P2} =/ 'huellt * vollstaendig ein') \
			/set RE_SCHADEN 10%%;\
		/elseif ({P2} =/ 'huellt * ein') \
			/set RE_SCHADEN 9%%;\
		/else \
			/set RE_SCHADEN 15%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_magieschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  Etwas (zerreisst|scheint) \
		.+ innerlich( zu zerreissen)?\\\\.$$' \
		re_tan_kami_magieschaden_5 = \
		/set RE_SCHADEN 11%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_magieschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  [^ ].+ wir(st|d) \
		(atomisiert|vernichtet)\\\\.$$' re_tan_kami_magieschaden_6 = \
		/if ({P2} =~ 'atomisiert') \
			/set RE_SCHADEN 12%%;\
		/elseif ({P2} =~ 'vernichtet') \
			/set RE_SCHADEN 13%%;\
		/else \
			/set RE_SCHADEN 15%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_magieschaden_*

;;; Kami Krach

/def -p1 -q -w -agCblue -mglob -t'Von * geht ploetzlich ein seltsames Summen \
	aus.' re_tan_kami_krach = \
	/if (RE_TAN_ANGREIFER !~ '') \
		/set RE_ANGREIFER %RE_TAN_ANGREIFER%;\
	/else \
		/set RE_ANGREIFER ???%;\
	/endif%;\
	/if (RE_TAN_OPFER !~ '') \
		/set RE_OPFER %RE_TAN_OPFER%;\
	/else \
		/set RE_OPFER ???%;\
	/endif%;\
	/set RE_WAFFE Kami.Krach%;\
	/set RE_ART %RE_PT3@{%RE_FARBE_15}Tanjian@{%RE_FARBE_35}%;\
	/set RE_TAN_OPFER=%;\
	/set RE_TAN_ANGREIFER=%;\
	/purge -mglob re_tan_kami_krachschaden_*%;\
	/def -1 -p2 -agCblue -q -w -msimple -t'  Ein leises \
		Pfeifen ertoent.' re_tan_kami_krachschaden_1 = \
		/set RE_SCHADEN 1%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_krachschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mglob -t'  Ein schriller Pfeifton \
		bereitet * Schmerzen.' \
		re_tan_kami_krachschaden_2 = \
		/set RE_SCHADEN 1%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_krachschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mglob -t'  Ein schmerzhaftes Fiepen \
		laesst * aufschreien.' re_tan_kami_krachschaden_3 = \
		/set RE_SCHADEN 2%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_krachschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  Ein (lautes|unglaubliches) \
		Kreischen (trifft .+|zerfetzt .+|vernichtet .+)\\\\.$$' \
		re_tan_kami_krachschaden_4 = \
		/if ({P2} =/ 'trifft * sehr hart') \
			/set RE_SCHADEN 6%%;\
		/elseif ({P2} =/ 'trifft * hart') \
			/set RE_SCHADEN 5%%;\
		/elseif ({P2} =/ 'trifft *') \
			/set RE_SCHADEN 4%%;\
		/elseif ({P2} =/ 'zerfetzt *') \
			/set RE_SCHADEN 12%%;\
		/elseif ({P1} =/ 'vernichtet *') \
			/set RE_SCHADEN 13%%;\
		/else \
			/set RE_SCHADEN 15%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_krachschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mglob -t'  Eine unsichtbare Macht \
		schuettelt * durch.' re_tan_kami_krachschaden_5 = \
		/set RE_SCHADEN 7%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_krachschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  Dissonante Schallwellen \
		werfen .+ (um|aus der Bahn)\\\\.$$' \
		re_tan_kami_krachschaden_6 = \
		/if ({P1} =~ 'um') \
			/set RE_SCHADEN 8%%;\
		/elseif ({P1} =~ 'aus der Bahn') \
			/set RE_SCHADEN 9%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_krachschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  Ein ohrenbetaeubender Laerm \
		laesst .+ (stoehnen|zerplatzen)\\\\.$$' \
		re_tan_kami_krachschaden_7 = \
		/if ({P1} =~ 'stoehnen') \
			/set RE_SCHADEN 10%%;\
		/elseif ({P1} =~ 'zerplatzen') \
			/set RE_SCHADEN 11%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_krachschaden_*

;;; Kami Terror

/def -p1 -q -w -agCblue -mregexp -t'^[^ ].+ wird ploetzlich von einer \
	schwarzen Wolke umgeben\\.$' re_tan_kami_terror = \
	/if (RE_TAN_ANGREIFER !~ '') \
		/set RE_ANGREIFER %RE_TAN_ANGREIFER%;\
	/else \
		/set RE_ANGREIFER ???%;\
	/endif%;\
	/if (RE_TAN_OPFER !~ '') \
		/set RE_OPFER %RE_TAN_OPFER%;\
	/else \
		/set RE_OPFER ???%;\
	/endif%;\
	/set RE_WAFFE Kami.Terror%;\
	/set RE_ART %RE_PT3@{%RE_FARBE_15}Tanjian@{%RE_FARBE_35}%;\
	/set RE_TAN_OPFER=%;\
	/set RE_TAN_ANGREIFER=%;\
	/purge -mglob re_tan_kami_terrorschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  Die schwarze Wolke \
		(loest sich wieder auf|streift .+|trifft .+|laesst .+ vor \
		Angst zittern|floesst .+ Angst ein)\\\\.$$' \
		re_tan_kami_terrorschaden_1 = \
		/if ({P1} =~ 'loest sich wieder auf') \
			/set RE_SCHADEN 1%%;\
		/elseif ({P1} =/ 'streift * leicht') \
			/set RE_SCHADEN 1%%;\
		/elseif ({P1} =/ 'streift *') \
			/set RE_SCHADEN 2%%;\
		/elseif ({P1} =/ 'trifft * sehr hart') \
			/set RE_SCHADEN 6%%;\
		/elseif ({P1} =/ 'trifft * hart') \
			/set RE_SCHADEN 5%%;\
		/elseif ({P1} =/ 'trifft *') \
			/set RE_SCHADEN 4%%;\
		/elseif ({P1} =/ 'laesst * vor Angst zittern') \
			/set RE_SCHADEN 7%%;\
		/elseif ({P1} =/ 'floesst * Angst ein') \
			/set RE_SCHADEN 8%%;\
		/else \
			/set RE_SCHADEN 15%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_terrorschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mglob -t'  Die Angst bereitet * \
		Schmerzen.' re_tan_kami_terrorschaden_2 = \
		/set RE_SCHADEN 9%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_terrorschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  [^ ].+ (schreis?t vor \
		Angst|wir(st|d) innerlich von Furcht zerfressen)\\\\.$$' \
		re_tan_kami_terrorschaden_3 = \
		/if ({P1} =/'schrei* vor Angst') \
			/set RE_SCHADEN 10%%;\
		/elseif ({P1} =/ 'wir* innerlich von Furcht zerfressen') \
			/set RE_SCHADEN 11%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_terrorschaden_*%;\
	/def -1 -p2 -agCblue -q -w -mregexp -t'^  Eine unglaubliche Angst \
		laesst .+ (Herz still stehen|sterben)\\\\.$$' \
		re_tan_kami_terrorschaden_4 = \
		/if ({P1} =~ 'Herz still stehen') \
			/set RE_SCHADEN 12%%;\
		/elseif ({P1} =~ 'sterben') \
			/set RE_SCHADEN 13%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_tan_kami_terrorschaden_*

;;; Tsume (Clanspell)

/def -p1 -q -agCblue -mregexp -t'^([^ ].*) schlaegs?t \
	(ploetzlich auf|Deine Faeuste in) (.+)$' re_tan_tsume = \
	/if ({P3} !/ '*.') \
		/def -p50 -F -n1 -agCblue -mglob -t'*.' re_tan_tsume_g%;\
	/endif%;\
	/set RE_WAFFE Tsume%;\
	/set RE_ART %RE_PT5@{%RE_FARBE_16}extra@{%RE_FARBE_35}


;;; KLERIKER

;;; Blitz

/def -p1 -agCblue -q -mregexp -t'^([^ ].+) (hebt|erhebst) die Haende gen \
	Himmel und beschwoers?t ' re_klerus_blitz = \
	/purge re_klerus_blitz_1%;\
	/if ({PR} !/ '*.') \
		/def -p1 -agCblue -q -1 -mglob -t'*herab.' re_klerus_blitz_0%;\
	/endif%;\
	/set RE_WAFFE Blitz%;\
	/set RE_ART %RE_PT4@{%RE_FARBE_21}Klerus@{%RE_FARBE_35}%;\
	/set RE_ANGREIFER %P1%;\
	/re_str_can_break%;\
	/def -1 -p5 -agCblue -q -mregexp -t'^  ((Der Blitz verfehlt|Du \
		fuehlst|Es knistert auf|Kleine Funken springen auf|Auf der \
		Haut|Der Blitz brennt sich in|Der Blitz schlaegt hart in|\
		Der Blitz wirkt sich verheerend auf|Der Blitz hat verheerende \
		Auswirkungen auf die Gesundheit) (.+) ((wenn auch nur )?\
		knapp|Haut( umher)?|springen kleine Funken umher|ein|\
		Gesundheit aus)|([^ ].*) (wird etwas statisch aufgeladen|\
		knistert etwas|zucks?t elektrisiert zusammen))\\\\.$$' \
		re_klerus_blitz_1 = \
		/let RE_Zeilenpuffer=%%P0%%;\
		/if ({P2} !~ '') \
			/let RE_KSCHADEN_1 %%P2%%;\
			/let RE_KSCHADEN_2 %%P4%%;\
			/set RE_OPFER %%P3%%;\
		/else \
			/let RE_KSCHADEN_1 Nix%%;\
			/let RE_KSCHADEN_2 %%P8%%;\
			/set RE_OPFER %%P7%%;\
		/endif%%;\
		/if (RE_KSCHADEN_2 =/ '*knapp') \
			/set RE_SCHADEN 1%%;\
		/elseif (RE_KSCHADEN_2 =/ '*statisch aufgeladen') \
			/set RE_SCHADEN 2%%;\
		/elseif ((RE_KSCHADEN_1 =/ '* knistert auf') | \
		    (RE_KSCHADEN_2 =~ 'knistert etwas')) \
			/set RE_SCHADEN 3%%;\
		/elseif (RE_KSCHADEN_2 =/ '* elektrisiert zusammen') \
			/set RE_SCHADEN 4%%;\
		/elseif (RE_KSCHADEN_2 =~ 'Haut umher') \
			/set RE_SCHADEN 5%%;\
		/elseif (RE_KSCHADEN_2 =/ '* kleine Funken umher') \
			/set RE_OPFER $$(/re_genitiv_loeschen %%RE_OPFER)%%;\
			/set RE_SCHADEN 5%%;\
		/elseif (RE_KSCHADEN_1 =/ '* brennt sich in') \
			/set RE_SCHADEN 6%%;\
		/elseif (RE_KSCHADEN_1 =/ '* schlaegt hart in') \
			/set RE_SCHADEN 7%%;\
		/elseif (RE_KSCHADEN_1 =/ '* wirkt sich verheerend *') \
			/set RE_SCHADEN 109%%;\
		/elseif (RE_KSCHADEN_1 =/ '* hat verheerende Auswirkungen *') \
			/set RE_OPFER $$(/re_genitiv_loeschen %%RE_OPFER)%%;\
			/set RE_SCHADEN 109%%;\
		/else \
			/set RE_SCHADEN 15%%;\
		/endif%%;\
		/re_ausgabe

;;; Donner

/def -p1 -q -agCblue -mregexp -t'^(Der Koerper (.*) verkrampft sich vor \
	Konzentration|(Du) konzentrierst Deine Gedanken auf einen Donner)\\.$' \
	re_klerus_donner = \
	/set RE_FLAECHE_WAFFE Donner%;\
	/set RE_WAFFE Donner%;\
	/set RE_FLAECHE_ART %RE_PT4@{%RE_FARBE_21}Klerus@{%RE_FARBE_35}%;\
	/set RE_ART %RE_PT4@{%RE_FARBE_21}Klerus@{%RE_FARBE_35}%;\
	/if ({P3} =~ '') \
		/set RE_FLAECHE_ANGREIFER $(/re_namekuerzen 13 \
			$(/re_genitiv_loeschen $(/re_artikelkuerzen %P2)))%;\
	/else \
		/set RE_FLAECHE_ANGREIFER Du%;\
	/endif%;\
	/set RE_FLAECHE_ZEIT $[time()]

/def -p1 -q -agCblue -mregexp -t'^([^ ].*) (furzt tierisch|laesst tierisch \
        einen Stinkefurz fahren)\\.$' re_klerus_donner2 = \
	/if (RE_FLAECHE_WAFFE =~ 'Donner') \
		/unset RE_FLAECHE_ANGREIFER%;\
	/endif

/def -p1 -agCblue -q -msimple -t'Ein gewaltiger Donner erschuettert Dein \
	Trommelfell.' re_klerus_donner3 = \
	/if (RE_FLAECHE_WAFFE =~ 'Donner') \
		/unset RE_FLAECHE_ANGREIFER%;\
	/endif

;;; Laeutern

/def -p1 -agCblue -F -q -mregexp -t'^([^ ].*) laeuters?t (den Geist .*|.* \
	Geist)\\.$' re_klerus_laeutern = \
	/set RE_ANGREIFER %P1%;\
	/purge -msimple re_klerus_laeutern_1%;\
	/def -p2 -1 -agCblue -q -mregexp -t'^  ([^ ].*) (geschieht jedoch \
		nichts|kann(st)? darueber aber nur lachen|stecks?t das aber \
		locker weg|machs?t boese Miene zum guten Spiel|\
		(bekommst )?Kopfschmerzen|wird speiuebel|windes?t (D|s)ich \
		vor Schmerzen|platzt fast der Schaedel|zerreisst Dich \
		innerlich|wird innerlich zerrissen)\\\\.$$' \
		re_klerus_laeutern_1 = \
		/set RE_SCHADEN %%P2%%;\
		/set RE_WAFFE Laeutern%%;\
		/set RE_ART %RE_PT4@{%%RE_FARBE_21}Klerus@{%%RE_FARBE_35}%%;\
		/set RE_OPFER %%P1%%;\
		/if ((RE_OPFER =~ 'Es') | (RE_OPFER =~ 'Dir') | \
		    (RE_OPFER =~ 'Du')) \
			/set RE_OPFER Dich%%;\
		/endif%%;\
		/if (RE_SCHADEN =/ '* nichts') \
			/set RE_SCHADEN 1%%;\
		/elseif (RE_SCHADEN =/ '* lachen') \
			/set RE_SCHADEN 2%%;\
		/elseif (RE_SCHADEN =/ '* locker weg') \
			/set RE_SCHADEN 4%%;\
		/elseif (RE_SCHADEN =/ '* guten Spiel') \
			/set RE_SCHADEN 5%%;\
		/elseif (RE_SCHADEN =/ '*Kopfschmerzen') \
			/set RE_SCHADEN 6%%;\
		/elseif (RE_SCHADEN =/ '* speiuebel') \
			/set RE_SCHADEN 7%%;\
		/elseif (RE_SCHADEN =/ '* vor Schmerzen') \
			/set RE_SCHADEN 8%%;\
		/elseif (RE_SCHADEN =/ '* der Schaedel') \
			/set RE_SCHADEN 9%%;\
		/elseif (RE_SCHADEN =/ '*innerlich*') \
			/set RE_SCHADEN 110%%;\
		/else \
			/set RE_SCHADEN 15%%;\
		/endif%%;\
		/re_ausgabe

;;; Erloese

/def -p1 -agCblue -F -q -mregexp -t' sprichs?t ein kurzes Gebet der \
	Erloesung (fuer|auf) (.+)\\.$' re_klerus_erloese = \
	/set RE_ANGREIFER %PL%;\
	/set RE_OPFER %P2%;\
	/set RE_WAFFE Erloese%;\
	/set RE_ART %RE_PT4@{%RE_FARBE_21}Klerus@{%RE_FARBE_35}%;\
	/purge -mglob re_klerus_erloese_*%;\
	/def -p2 -1 -agCblue -q -msimple -t'  Die Erloesung geht voll \
		daneben.' re_klerus_erloese_1 = \
		/set RE_SCHADEN 1%%;\
		/re_ausgabe%%;\
		/purge -mglob re_klerus_erloese_*%;\
	/def -p2 -1 -agCblue -q -mglob -t'  Ein kurzes Gluehen erscheint \
		zwischen * Haenden, verlischt aber sofort wieder' \
		re_klerus_erloese_2 = \
		/set RE_SCHADEN 1%%;\
		/re_ausgabe%%;\
		/purge -mglob re_klerus_erloese_*%;\
	/def -p2 -1 -agCblue -q -mregexp -t'  ([^ ].+) (fuehlst ein kurzes \
		Kribbeln|schuettelt sich kurz|spuers?t den Hauch der Erloesung|\
		bemerkst ein leichtes Ziehen|zuckt elektrisiert zusammen)\
		\\\\.$$' re_klerus_erloese_3 = \
		/if ({P2} =~ 'fuehlst ein kurzes Kribbeln') \
			/set RE_SCHADEN 1%%;\
		/elseif ({P2} =~ 'schuettelt sich kurz') \
			/set RE_SCHADEN 1%%;\
		/elseif ({P2} =/ '* den Hauch der Erloesung') \
			/set RE_SCHADEN 2%%;\
		/elseif ({P2} =~ 'bemerkst ein leichtes Ziehen') \
			/set RE_SCHADEN 4%%;\
		/elseif ({P2} =~ 'zuckt elektrisiert zusammen') \
			/set RE_SCHADEN 4%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_klerus_erloese_*%;\
	/def -p2 -1 -agCblue -q -mregexp -t'^  Ein (helles )?Licht \
		tanzt vor Deinen Augen umher\\\\.$$' re_klerus_erloese_4 = \
		/if ({P1} =~ 'helles ') \
			/set RE_SCHADEN 6%%;\
		/else \
			/set RE_SCHADEN 5%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_klerus_erloese_*%;\
	/def -p2 -1 -agCblue -q -mregexp -t'^  Vor .+ Augen tanzt ein \
		(helles )?Licht umher\\\\.$$' re_klerus_erloese_5 = \
		/if ({P1} =~ 'helles ') \
			/set RE_SCHADEN 6%%;\
		/else \
			/set RE_SCHADEN 5%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_klerus_erloese_*%;\
	/def -p2 -1 -agCblue -q -mregexp -t'^  Ein gleissendes Licht \
		umgibt .+ Kopf\\\\.$$' re_klerus_erloese_6 = \
		/set RE_SCHADEN 8%%;\
		/set RE_SCHADEN_SUB -1%%;\
		/re_ausgabe%%;\
		/purge -mglob re_klerus_erloese_*%;\
	/def -p2 -1 -agCblue -q -mglob -t'  Grelle Lichtblitze zucken um * \
		Koerper.' re_klerus_erloese_7 = \
		/set RE_SCHADEN 9%%;\
		/re_ausgabe%%;\
		/purge -mglob re_klerus_erloese_*%;\
	/def -p2 -1 -agCblue -q -mregexp -t'^  [^ ].+ komms?t der \
		Erloesung immer naeher\\\\.$$' re_klerus_erloese_8 = \
		/set RE_SCHADEN 10%%;\
		/re_ausgabe%%;\
		/purge -mglob re_klerus_erloese_*%;\
	/def -p2 -1 -agCblue -q -mregexp -t'^  [^ ].+ Kopf beginnt zu \
		Gluehen\\\\.$$' re_klerus_erloese_9 = \
		/set RE_SCHADEN 11%%;\
		/re_ausgabe%%;\
		/purge -mglob re_klerus_erloese_*%;\
	/def -p2 -1 -agCblue -q -mregexp -t'^  [^ ].+ gesamter Koerper \
		glueht grell auf\\\\.$$' re_klerus_erloese_10 = \
		/set RE_SCHADEN 12%%;\
		/re_ausgabe%%;\
		/purge -mglob re_klerus_erloese_*%;\
	/def -p2 -1 -agCblue -q -mregexp -t'^  [^ ].+ wird von dem \
		Licht zerfetzt\\\\.$$' re_klerus_erloese_11 = \
		/set RE_SCHADEN 13%%;\
		/re_ausgabe%%;\
		/purge -mglob re_klerus_erloese_*

;;; der Messerkreis trifft%RE_PT2.

/def -p1 -mglob -agCmagenta -F -t'* wird ein wenig tranchiert.' \
	re_klerus_mk = \
	/set RE_TMP_TRENNER=MK%;\
	/set RE_TMP_TRENNER_OPFER=$(/re_namekuerzen 13 \
		$(/re_artikelkuerzen %-L4))%;
	
;;; Goetterzorn

/def -p1 -agCblue -F -q -mregexp -t' beschwoers?t den Zorn der Goetter \
	gegen (.+)\\.$' re_klerus_goetterzorn = \
	/set RE_ANGREIFER %PL%;\
	/set RE_OPFER %P1%;\
	/set RE_WAFFE Goetterzorn%;\
	/set RE_ART %RE_PT4@{%RE_FARBE_21}Klerus@{%RE_FARBE_35}%;\
	/purge -mglob re_klerus_goetterzorn_*%;\
	/if (RE_ANGREIFER =~ 'Du') \
		/def -p31 -1 -agCblue -q -msimple -t'Kandri steht Dir bei \
			und erhoeht Deinen Zorn.' re_klerus_goetterzorn_1%;\
	/endif%;\
	/def -p2 -1 -agCblue -q -mregexp -t'^  Der Zorn der Goetter \
		(verfehlt .+ knapp|streift .+|brennt sich in .+ ein|schlaegt \
		hart in .+ ein|wirkt sich verheerend auf Deine Gesundheit aus|\
		hat verheerende Auswirkungen auf die Gesundheit .+)\\\\.$$' \
		re_klerus_goetterzorn_2 = \
		/if ({P1} =/ 'verfehlt *') \
			/set RE_SCHADEN 1%%;\
		/elseif ({P1} =/ 'streift *') \
			/set RE_SCHADEN 5%%;\
		/elseif ({P1} =/ 'brennt sich in *') \
			/set RE_SCHADEN 8%%;\
		/elseif ({P1} =/ 'schlaegt hart in *') \
			/set RE_SCHADEN 9%%;\
		/elseif ({P1} =/ '* Gesundheit *') \
			/set RE_SCHADEN 110%%;\
		/else \
			/set RE_SCHADEN 15%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_klerus_goetterzorn_*%;\
	/def -p2 -1 -agCblue -q -mregexp -t'^  [^ ].+ ((fuehlst|bemerkt) \
		den Zorn der Goetter|zucks?t elektrisiert zusammen)\\\\.$$' \
		re_klerus_goetterzorn_3 = \
		/if ({P1} =/ '* den Zorn der Goetter') \
			/set RE_SCHADEN 3%%;\
		/elseif ({P1} =/ '* elektrisiert zusammen') \
			/set RE_SCHADEN 6%%;\
		/endif%%;\
		/re_ausgabe%%;\
		/purge -mglob re_klerus_goetterzorn_*%;\
	/def -p2 -1 -agCblue -q -mglob -t'  Auf der Haut * springen kleine \
		Funken umher.' re_klerus_goetterzorn_4 = \
		/set RE_SCHADEN 7%%;\
		/re_ausgabe%%;\
		/purge -mglob re_klerus_goetterzorn_*%;\
	/def -p2 -1 -agCblue -q -msimple -t'  Kleine Funken springen auf \
		Deiner Haut umher.' re_klerus_goetterzorn_5 = \
		/set RE_SCHADEN 7%%;\
		/re_ausgabe%%;\
		/purge -mglob re_klerus_goetterzorn_*


;;; DUNKELELFEN

;;; Feuerlanze (vorerst nur aktiv)

/ifdef (RE_MULTIPLAYER_TF|p_guild=~""|p_guild=~"dunkelelfen") -Fp3 -t"  *[^.] \
	Feuerlanze *[^.]" -mglob re_broken_trig=\
	/set RE_BROKEN_BUFFER=%*%;\
	/substitute -ag%;\
	/def -p4 -ag -F -t"*" -mglob re_broken_trig2 =\
	/if ({L}=/"*.")\
		/purge re_broken_trig2%%;\
		/substitute \%RE_BROKEN_BUFFER %%*%%;\
	/else \
		/set RE_BROKEN_BUFFER=\%RE_BROKEN_BUFFER %%*%%;\
		/substitute -ag%%;\
	/endif

/ifdef (RE_MULTIPLAYER_TF|p_guild=~""|p_guild=~"dunkelelfen") -p2 -ag -mglob \
	-t"Du konzentrierst Dich auf * und ploetzlich schiesst*" \
	re_feuerlanze_prepare = \
	/set RE_TRIG_FEUERLANZE=1%;\
	/def -p1 -ag -t'*lanze auf {ihn.|sie.|es.}' re_feuer_lanze_gag = \
		/undef re_feuer_lanze_gag

/ifdef (RE_MULTIPLAYER_TF|p_guild=~""|p_guild=~"dunkelelfen") -p1 -agCblue \
	-E(RE_TRIG_FEUERLANZE) -mglob -t"  Deine Feuerlanze \
	schwaerzt die Haut *." re_feuerlanze_1 = \
	/shift 5%;\
	/set RE_WAFFE Feuerlanze%;\
	/set RE_ART %RE_PT4@{%RE_FARBE_21}Delfen@{%RE_FARBE_35}%;\
	/set RE_ANGREIFER Du%;\
	/set RE_OPFER %*%;\
	/set RE_SCHADEN 1%;\
	/set RE_TRIG_FEUERLANZE=0%;\
	/re_ausgabe

/ifdef (RE_MULTIPLAYER_TF|p_guild=~""|p_guild=~"dunkelelfen") -p1 -agCblue \
	-E(RE_TRIG_FEUERLANZE) -mglob -t"  Deine Feuerlanze fuegt \
	* einige leichte Verbrennungen zu." re_feuerlanze_2 = \
	/shift 3%;\
	/set RE_WAFFE Feuerlanze%;\
	/set RE_ART %RE_PT4@{%RE_FARBE_21}Delfen@{%RE_FARBE_35}%;\
	/set RE_ANGREIFER Du%;\
	/set RE_OPFER %-L4%;\
	/set RE_SCHADEN 5%;\
	/set RE_TRIG_FEUERLANZE=0%;\
	/re_ausgabe
 
/ifdef (RE_MULTIPLAYER_TF|p_guild=~""|p_guild=~"dunkelelfen") -p1 -agCblue \
	-E(RE_TRIG_FEUERLANZE) -mglob -t"  Deine Feuerlanze \
	versengt * die Haut." re_feuerlanze_3 = \
	/shift 3%;\
	/set RE_WAFFE Feuerlanze%;\
	/set RE_ART %RE_PT4@{%RE_FARBE_21}Delfen@{%RE_FARBE_35}%;\
	/set RE_ANGREIFER Du%;\
	/set RE_OPFER %-L2%;\
	/set RE_SCHADEN 6%;\
	/set RE_TRIG_FEUERLANZE=0%;\
	/re_ausgabe
 
/ifdef (RE_MULTIPLAYER_TF|p_guild=~""|p_guild=~"dunkelelfen") -p1 -agCblue \
	-E(RE_TRIG_FEUERLANZE) -mglob -t"  Deine Feuerlanze fuegt \
	* schwere Verbrennungen zu." re_feuerlanze_4 = \
	/shift 3%;\
	/set RE_WAFFE Feuerlanze%;\
	/set RE_ART %RE_PT4@{%RE_FARBE_21}Delfen@{%RE_FARBE_35}%;\
	/set RE_ANGREIFER Du%;\
	/set RE_OPFER %-L3%;\
	/set RE_SCHADEN 7%;\
	/set RE_TRIG_FEUERLANZE=0%;\
	/re_ausgabe

/ifdef (RE_MULTIPLAYER_TF|p_guild=~""|p_guild=~"dunkelelfen") -p3 -agCblue \
	-E(RE_TRIG_FEUERLANZE) -mglob -t'  Deine Feuerlanze \
	schlaegt mit voller Wucht in * ein.' re_feuerlanze_5a = \
	/shift 7%;\
	/set RE_WAFFE Feuerlanze%;\
	/set RE_ART %RE_PT4@{%RE_FARBE_21}Delfen@{%RE_FARBE_35}%;\
	/set RE_ANGREIFER Du%;\
	/set RE_OPFER %-L1%;\
	/set RE_SCHADEN 8%;\
	/set RE_SCHADEN_SUB -1%;\
	/set RE_TRIG_FEUERLANZE=0%;\
	/re_ausgabe
 
/ifdef (RE_MULTIPLAYER_TF|p_guild=~""|p_guild=~"dunkelelfen") -p1 -agCblue \
	-E(RE_TRIG_FEUERLANZE) -mglob -t"  Deine Feuerlanze \
	roestet * bei lebendigem Leibe." re_feuerlanze_5b = \
	/shift 3%;\
	/set RE_WAFFE Feuerlanze%;\
	/set RE_ART %RE_PT4@{%RE_FARBE_21}Delfen@{%RE_FARBE_35}%;\
	/set RE_ANGREIFER Du%;\
	/set RE_OPFER %-L3%;\
	/set RE_SCHADEN 8%;\
	/set RE_SCHADEN_SUB 1%;\
	/set RE_TRIG_FEUERLANZE=0%;\
	/re_ausgabe
 
/ifdef (RE_MULTIPLAYER_TF|p_guild=~""|p_guild=~"dunkelelfen") -p1 -agCblue \
	-E(RE_TRIG_FEUERLANZE) -mglob -t"  Deine Feuerlanze \
	verbrennt * bei lebendigem Leibe." re_feuerlanze_6 = \
	/shift 3%;\
	/set RE_WAFFE Feuerlanze%;\
	/set RE_ART %RE_PT4@{%RE_FARBE_21}Delfen@{%RE_FARBE_35}%;\
	/set RE_ANGREIFER Du%;\
	/set RE_OPFER %-L3%;\
	/set RE_SCHADEN 9%;\
	/set RE_TRIG_FEUERLANZE=0%;\
	/re_ausgabe

/ifdef (RE_MULTIPLAYER_TF|p_guild=~""|p_guild=~"dunkelelfen") -p1 -agCblue \
	-E(RE_TRIG_FEUERLANZE) -mglob -t"  Deine Feuerlanze laesst \
	* einen Raub der Flammen werden." re_feuerlanze_7 = \
	/shift 3%;\
	/set RE_WAFFE Feuerlanze%;\
	/set RE_ART %RE_PT4@{%RE_FARBE_21}Delfen@{%RE_FARBE_35}%;\
	/set RE_ANGREIFER Du%;\
	/set RE_OPFER %-L5%;\
	/set RE_SCHADEN 10%;\
	/set RE_TRIG_FEUERLANZE=0%;\
	/re_ausgabe

/ifdef (RE_MULTIPLAYER_TF|p_guild=~""|p_guild=~"dunkelelfen") -p1 -agCblue \
	-E(RE_TRIG_FEUERLANZE) -mglob -t"  Deine Feuerlanze \
	verwandelt * in Russ und Asche." re_feuerlanze_8 = \
	/shift 3%;\
	/set RE_WAFFE Feuerlanze%;\
	/set RE_ART %RE_PT4@{%RE_FARBE_21}Delfen@{%RE_FARBE_35}%;\
	/set RE_ANGREIFER Du%;\
	/set RE_OPFER %-L3%;\
	/set RE_SCHADEN 11%;\
	/set RE_TRIG_FEUERLANZE=0%;\
	/re_ausgabe
 
/ifdef (RE_MULTIPLAYER_TF|p_guild=~""|p_guild=~"dunkelelfen") -p1 -agCblue \
	-E(RE_TRIG_FEUERLANZE) -mglob -t"  Deine Feuerlanze laesst \
	* den Flammentod sterben." re_feuerlanze_9 = \
	/shift 3%;\
	/set RE_WAFFE Feuerlanze%;\
	/set RE_ART %RE_PT4@{%RE_FARBE_21}Delfen@{%RE_FARBE_35}%;\
	/set RE_ANGREIFER Du%;\
	/set RE_OPFER $(/re_namekuerzen 13 $(/re_artikelkuerzen %-L3))%;\
	/set RE_SCHADEN 12%;\
	/set RE_TRIG_FEUERLANZE=0%;\
	/re_ausgabe

/ifdef (RE_MULTIPLAYER_TF|p_guild=~""|p_guild=~"dunkelelfen") -p1 -agCblue \
	-E(RE_TRIG_FEUERLANZE) -mglob -t"  Deine Feuerlanze \
	verbannt * aus diesem Raum-Zeitkontinuum." re_feuerlanze_10 = \
	/shift 3%;\
	/set RE_WAFFE Feuerlanze%;\
	/set RE_ART %RE_PT4@{%RE_FARBE_21}Delfen@{%RE_FARBE_35}%;\
	/set RE_ANGREIFER Du%;\
	/set RE_OPFER $(/re_namekuerzen 13 $(/re_artikelkuerzen %-L4))%;\
	/set RE_SCHADEN 13%;\
	/set RE_TRIG_FEUERLANZE=0%;\
	/re_ausgabe

;;; Aura

/def -p1 -agCblue -mglob -t'* Aura leuchtet {hellrot|rot|orange|gelb} auf.' \
	re_dunkelelfen_aura = /re_set_esp A

;;; Entziehe

/ifdef (RE_MULTIPLAYER_TF|p_guild=~""|p_guild=~"dunkelelfen") -p1 -agCblue \
	-mglob -t'Du entziehst * einen Teil {seiner|ihrer} Lebensenergie.' \
	re_delfen_entziehe = \
	/set RE_WAFFE Entziehe%;\
	/set RE_ART %RE_PT4@{%RE_FARBE_21}Delfen@{%RE_FARBE_35}

/def -p1 -agCblue -mglob -t'* legt zwei Finger an * Schlaefe, worauf \
	{er|sie|es}*' re_delfen_entziehe_passiv = \
	/if ({L1}!~"fuehlt.") \
		/def -1 -p1 -agCblue -mregexp -t'fuehlt\\\\. ?$$' \
			re_delfen_entziehe_gag%;\
	/endif%;\
	/set RE_WAFFE Entziehe%;\
	/set RE_ART %RE_PT4@{%RE_FARBE_21}Delfen@{%RE_FARBE_35}


;;; WERWOELFE

;;; Kralle

/def -p1 -agCblue -mglob -t'* schlaegt * mit einem maechtigen Krallenschlag.' \
	re_wwolf_klaue = \
	/set RE_ART %RE_PT3@{%RE_FARBE_21}Werwolf@{%RE_FARBE_35}%;\
	/set RE_WAFFE Kralle

/def -p1 -agCblue -mglob -t'Du verpasst * einen {deftigen|kraeftigen} \
	Krallenschlag.' re_wwolf_klaue2 = \
	/set RE_ART %RE_PT3@{%RE_FARBE_21}Werwolf@{%RE_FARBE_35}%;\
	/set RE_WAFFE Kralle

;;; Fellgriff 

/def -p1 -agCblue -mglob -t'* greifst * mit vollen Krallen ins Fleisch.' \
	re_wwolf_fellgriff_1 = \
	/set RE_ART %RE_PT3@{%RE_FARBE_21}Werwolf@{%RE_FARBE_35}%;\
	/set RE_WAFFE Fellgriff

/def -p1 -agCblue -mglob -t'* schlaegt * mit einer maechtigen Kralle ins \
	Fleisch.' re_wwolf_fellgriff_2 = \
	/set RE_ART %RE_PT3@{%RE_FARBE_21}Werwolf@{%RE_FARBE_35}%;\
	/set RE_WAFFE Fellgriff

;;; Ansturm 

/def -p1 -agCblue -mglob -t'* schmeisst {sich|dich} auf *' \
	re_wwolf_ansturm = \
	/set RE_ART %RE_PT3@{%RE_FARBE_21}Werwolf@{%RE_FARBE_35}%;\
	/set RE_WAFFE Ansturm

;;; Wuergekralle

/def -p1 -agCblue -mregexp -t' wuergs?t .+ mit (Deinen )?Krallen\\.$' \
	re_wwolf_wuergekralle = \
	/set RE_ART %RE_PT3@{%RE_FARBE_21}Werwolf@{%RE_FARBE_35}%;\
	/set RE_WAFFE Wuergekralle 

;;; Wasserstrahl

/def -p1 -agCblue -mregexp -t' erzeugs?t einen (kleinen |grossen |\
	ordentlichen |gigantischen |)Wasserschwall gegen (.*)\\.$' \
	re_wwolf_wasserstrahl = \
	/set RE_ART %RE_PT3@{%RE_FARBE_21}Werwolf@{%RE_FARBE_35}%;\
	/set RE_WAFFE Wasserstrahl

/def -p1 -agCblue -mglob -t'* scheint * mit einem {Wasserstrahl|Wasserschwall} \
	hinwegzuspuelen.' re_wwolf_wasserstrahl_2 = \
	/set RE_ART %RE_PT3@{%RE_FARBE_21}Werwolf@{%RE_FARBE_35}%;\
	/set RE_WAFFE Wasserstrahl

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 			die kleinen Abwehr-Helferchen
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Schwertmeisterschwert (SMS)

/def -p1 -q -agCmagenta -msimple -t'Es gelingt Dir mit dem Schwert, den \
	Schlag Deines Gegners etwas abzufangen.' re_sms = \
	/if (RE_SMS =~ '*') \
		/set RE_SMS @{%RE_FARBE_27}S@{%RE_FARBE_35}%;\
	/else \
		/set RE_SMS @{%RE_FARBE_27}2@{%RE_FARBE_35}%;\
	/endif

;;; Speermeister-Speer (SMS)

/def -p1 -q -agCmagenta -msimple -t'Du faengst einen Teil des Angriffes \
	durch eine schnelle Bewegung mit Deinem' re_smspeer = \
	/purge re_smspeer_1%;\
	/def -1 -p1 -q -agCmagenta -msimple -t'Speer ab.' re_smspeer_1%;\
	/if (RE_SMS =~ '*') \
		/set RE_SMS @{%RE_FARBE_27}S@{%RE_FARBE_35}%;\
	/else \
		/set RE_SMS @{%RE_FARBE_27}2@{%RE_FARBE_35}%;\
	/endif

/def -p1 -q -agCmagenta -mglob -t'* gelingt es, durch eine schnelle \
	Bewegung mit dem Speer, einen Teil des' re_smspeer2 = \
	/purge re_smspeer_1%;\
	/def -1 -p1 -q -agCmagenta -msimple -t'Angriffes abzufangen.' \
		re_smspeer_1%;\
	/if (RE_SMS =~ '*') \
		/set RE_SMS @{%RE_FARBE_27}S@{%RE_FARBE_35}%;\
	/else \
		/set RE_SMS @{%RE_FARBE_27}2@{%RE_FARBE_35}%;\
	/endif

;;; Kieferknochen

/def -p1 -q -agCmagenta -msimple -t'Der Kieferknochen faengt den Schlag \
	des Gegners ab.' re_kk = \
	/if (RE_SMS =~ 'S') \
		/set RE_SMS @{%RE_FARBE_27}2@{%RE_FARBE_35}%;\
	/else \
		/set RE_SMS @{%RE_FARBE_27}K@{%RE_FARBE_35}%;\
	/endif

;;; Drachenschuppe

/def -p1 -q -agCmagenta -msimple -t'Die Drachenschuppe faengt den Angriff \
	ab.' re_dschuppe = \
	/if (RE_SMS =~ 'S') \
		/set RE_SMS @{%RE_FARBE_27}2@{%RE_FARBE_35}%;\
	/else \
		/set RE_SMS @{%RE_FARBE_27}D@{%RE_FARBE_35}%;\
	/endif

/def -p1 -q -agCmagenta -msimple -t'Die Drachenschuppe wandelt das Feuer \
	in heilende Waerme.' re_dschuppe2 = \
	/if (RE_SMS =~ 'S') \
		/set RE_SMS @{%RE_FARBE_30}2@{%RE_FARBE_35}%;\
	/else \
		/set RE_SMS @{%RE_FARBE_30}H@{%RE_FARBE_35}%;\
	/endif

/def -p1 -q -agCmagenta -mglob -t'* Drachenschuppe wandelt * Feuer in \
	heilende Waerme*.' re_schuppe3 = \
	/set RE_SMS @{%RE_FARBE_25}H@{%RE_FARBE_35}

;;; Anti-Feuerring (AFR)

/def -p1 -q -agCmagenta -msimple -t'Dein Ring zieht die Flammen auf sich \
	und bewahrt Dich so vor Schaden.' re_afr = /set RE_AFR A

;;; Anti-Eisring (AER)

/def -p1 -q -agCmagenta -msimple -t'Dein Ring saugt etwas Kaelte auf.' \
	re_aer = /set RE_AFR A

;;; Drachenring

/def -p1 -q -agCmagenta -msimple -t'Der Drachenring verwandelt den \
	Angriff in eine Heilung.' re_dring = /set RE_AFR D

;;; irgend son Ring halt ;)

/def -p1 -q -agCmagenta -msimple -t'Dein Ring glueht auf einmal rot auf.' \
	re_iring = /set RE_AFR R

;;; Oktariner Ring aus Para-Moulokin

/def -p1 -q -agCmagenta -msimple -t'Der Ring entzieht Dir einen Teil \
	Deiner magischen Kraefte.' re_okta = /set RE_AFR S

/def -p1 -q -agCmagenta -mglob -t'Der Ring labt sich an der Magie ein*.' \
	re_okta2 = /set RE_AFR E

;;; Kreuz

/def -p1 -q -agCmagenta -msimple -t'Das Kreuz faengt an zu leuchten.' re_kreuz=\
	/set RE_AMU @{%RE_FARBE_29}K@{%RE_FARBE_35}

;;; Grummelbeisseramulett

/def -p1 -q -agCmagenta -msimple -t'Dein Amulett huellt Dich in eine \
    heilige Aura, die den Angriff schwaecht.' re_nochsonamu = \
    /set RE_AMU @{%RE_FARBE_29}A@{%RE_FARBE_35}

;;; Gluecksbringer

/def -p1 -q -agCmagenta -msimple -t'Dein Gluecksbringer reflektiert den \
	Angriff.' re_gbringer = \
	/set RE_AMU @{%RE_FARBE_29}G@{%RE_FARBE_35}

;;; Himmelskreuz

/def -p1 -q -agCmagenta -msimple -t'  Dein heiliges Kreuz faengt den \
	Angriff ab.' re_hkreuz = \
	/set RE_AMU @{%RE_FARBE_29}K@{%RE_FARBE_35}

;;; Haar der Nixe

/def -p1 -q -agCmagenta -msimple -t'Das Haar einer Nixe absorbiert einen \
	Teil des Angriffs.' re_nixenhaar = \
	/purge re_nixenhaar_1%;\
	/set RE_AMU @{%RE_FARBE_29}N@{%RE_FARBE_35}%;\
	/def -1 -p1 -q -agCmagenta -msimple -t'Ein Ohr zerfaellt unter der \
		Wucht des Schadens, den es abgewehrt hat.' re_nixenhaar_1

;;; Amulett von Ananas

/def -p1 -q -agCmagenta -msimple -t'Das Amulett aus Obsidian pulsiert, \
	es scheint kurz schwarz zu strahlen.' re_ananas_amu = \
	/set RE_AMU @{%RE_FARBE_29}O@{%RE_FARBE_35}

;;; TSCH setzen

/def re_set_tsch = \
	/if (RE_TSCH =~ '*') \
		/set RE_TSCH %1%;\
	/elseif (regmatch(RE_REGEXP_SETDEFEND, RE_TSCH)) \
		/test ++RE_TSCH%;\
	/else \
		/set RE_TSCH 2%;\
	/endif

;;; Totenschaedel

/def -p1 -q -agCmagenta -msimple -t'Vom Schaedel geht kurzzeitig ein \
	Leuchten aus.' re_tschaedel = /re_set_tsch T

;;; Eishelm

/def -p1 -q -agCmagenta -msimple -t'Dein Helm kuehlt sich kurz ab.' \
	re_ehelm = /re_set_tsch H

;;; Pudelmuetze von Tilly

/def -p1 -q -agCmagenta -mregexp -t'[A-Z].+ Pudelmuetze gibt ein wuetendes \
	Bellen von sich, ' re_pmuetze = \
	/if ({PR} !/ '*an.') \
		/def -agCblue -1 -mglob -p1 -q -t'*an.' re_pmuetze_1%;\
	/endif%;\
	/re_set_tsch P

/def -p1 -q -agCmagenta -mglob -t'Die Pudelmuetze von * gibt ein wuetendes \
	Bellen von sich. *' re_pmuetze2 = \
	/if ({PR} !/ '*um.') \
		/def -agCblue -1 -mglob -p1 -q -t'*um.' re_pmuetze_1%;\
	/endif%;\
	/re_set_tsch P

/def -p1 -q -agCmagenta -msimple -t'Die Pudelmuetze von Yim Thoelke bellt \
	Dich wuetend an. Aengstlich weichst Du' re_pmuetze3 = \
	/def -agCblue -msimple -1 -p30 -q -F -t'etwas zurueck.' re_pmuetze_1%;\
	/re_set_tsch P

;;; Feuerhelm

/def -p1 -q -agCmagenta -msimple -t'Der Helm schuetzt Dich vor dem \
	Feuer.' re_fhelm = /re_set_tsch F

/def -p1 -q -agCmagenta -mglob -t'* Helm wehrt das Feuer ab.' re_fhelm2 = \
	/re_set_tsch F

;;; Myrthenkranz

/def -p1 -q -agCmagenta -msimple -t'Der Myrthenkranz lindert Deine \
	Schmerzen. Du fuehlst Dich gleich besser.' re_mkranz = \
	/re_set_tsch M

;;; Chaosball

/def -p1 -q -agCmagenta -msimple -t'Der Chaosball leuchtet auf und \
	pulsiert in hellem Licht.' re_chaosball = \
	/re_set_tsch C

;;; Maske von Patryns Riesen

/def -p1 -q -agCmagenta -mglob -t'* Maske glueht kurz in einem \
	giftigen Gruen auf.' re_rmaske = \
	/re_set_tsch A

;;; ESP setzen

/def re_set_esp = \
	/if (RE_ESP =~ '*') \
		/set RE_ESP %1%;\
	/elseif (regmatch(RE_REGEXP_SETDEFEND, RE_ESP)) \
		/test ++RE_ESP%;\
	/else \
		/set RE_ESP 2%;\
	/endif

;;; gruene Robe

/def -p1 -q -agCmagenta -msimple -t'Deine Robe schuetzt Dich.' re_grobe = \
	/re_set_esp R

;;; Umhang aus Trollhaeuten

/def -p1 -q -agCmagenta -msimple -t'Der Umhang knistert stark.' \
	re_trumhang = /re_set_esp U

;;; Toga aus der Gladischule

/def -p1 -q -agCmagenta -msimple -t'Die goldenen Faeden der Toga \
	leuchten auf und heilen Dich etwas.' re_toga = /re_set_esp T

;;; Eisschamanenpanzer

/def -p1 -q -agCmagenta -msimple -t'Der Eisschamanenpanzer unterstuetzt \
	Deine Abwehrkraefte.' re_espanzer = /re_set_esp E

;;; Panzer der Gier

/def -p1 -q -agCmagenta -msimple -t'Der Panzer naehrt sich an Deiner \
	Energie.' re_panzerg = /re_set_esp G

;;; Robe der Magie

/def -p1 -q -agCmagenta -msimple -t'Die Robe der Magie gibt Dir neue \
	Kraft.' re_rdmagie = /re_set_esp M

;;; Steintrollpanzer

/def -p1 -q -agCmagenta -mglob -t'* verstaucht sich bei dem Schlag die Hand.' \
	re_stpanzer = \
	/set RE_TMP_TRENNER=STP%;\
	/set RE_TMP_TRENNER_OPFER=$(/re_namekuerzen 13 \
		$(/re_artikelkuerzen %-L7))

;;; Zauberschild

/ifdef (RE_MULTIPLAYER_TF|p_guild=~""|p_guild=~"zauberer") -p1 -q -agCmagenta \
	-msimple -t'Dein Zauberschild reflektiert den Angriff.' re_zschild = \
	/re_set_esp Z

;;; Schutzschild der Dunkelelfen

/def -p1 -q -agCmagenta -mregexp  -t' Schutzschild blitzt einmal kurz \
	(heftig |kraeftig |leicht |)auf\\.$' re_delfenschild = \
	/set RE_KARATE_ABWEHR DeSch%;\
	/if ({P1}=~'' | {P1}=~'leicht') \
		/set RE_KARATE 2%;\
	/else \
		/set RE_KARATE 4%;\
	/endif

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;				Waffenfunktionen
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Flammendolch

/def -p1 -q -agCblue -msimple -t'Flammen schiessen aus dem Dolch hervor.' \
	re_flammendolch = \
	/set RE_WAFFE Flammendolch%;\
	/set RE_WFUNC @{%RE_FARBE_37}Waffen-Fkt@{%RE_FARBE_37}

;;; Zynh

/def -p1 -q -agCblue -mglob -t'Ein kleiner Blitz schiesst aus der Spitze von \
	Zynh auf *' re_zynh = \
	/if ({L1} !/ '*.') \
		/def -1 -q -agCblue -mglob -t'*.' re_zynh_gag%;\
	/endif%;\
	/set RE_WAFFE Zynh%;\
	/set RE_WFUNC @{%RE_FARBE_37}Waffen-Fkt@{%RE_FARBE_37}

;;; Kriegshamster

/def -p1 -q -agCblue -msimple -t'Der Hamster stuerzt sich auf Deinen Gegner.' \
	re_kriegshamster1 = \
	/set RE_WAFFE Kriegshamster%;\
	/set RE_WFUNC @{%RE_FARBE_37}.stuerzend@{%RE_FARBE_37}

/def -p1 -q -agCblue -msimple -t'Der Hamster beisst Deinen Gegner mit Genuss.' \
	re_kriegshamster2 = \
	/set RE_WAFFE Kriegshamster%;\
	/set RE_WFUNC @{%RE_FARBE_37}%RE_PT2beissend@{%RE_FARBE_37}

;;; Vollstrecker

/def -p1 -q -agCblue -msimple -t'Der Vollstrecker schlaegt mit groesster \
	Freude besonders kraeftig auf' re_vstrecker = \
	/set RE_WAFFE Vollstrecker%;\
	/set RE_WFUNC @{%RE_FARBE_18}Todesstoss@{%RE_FARBE_37}%;\
	/def -1 -p1 -q -agCblue -msimple -t'Deinen Gegner ein, als er merkt, \
		dass dieser kurz vorm Ende steht!' re_vstrecker_1

/def -p1 -q -agCblue -mglob -t'Der Vollstrecker versucht, * den Todesstoss \
	zu versetzen!' re_vstrecker2 = \
	/set RE_WAFFE Vollstrecker%;\
	/set RE_WFUNC @{%RE_FARBE_18}Todesstoss@{%RE_FARBE_37}

/def -p1 -q -agCblue -mglob -t'Der Vollstrecker schlaegt mal * zu.' \
	re_vstrecker3 = \
	/set RE_WAFFE Vollstrecker%;\
	/set RE_WFUNC @{%RE_FARBE_37}Waffen-Fkt@{%RE_FARBE_37}

;;; Magiewesenzahn (MWZ)

/def -p1 -q -agCblue -msimple -t'Der Magiewesenzahn entlaedt sich mit einem \
	grellen Blitz!' re_mwz = \
	/set RE_WAFFE Magiewesenza%;\
	/set RE_WFUNC @{%RE_FARBE_37}Waffen-Fkt@{%RE_FARBE_37}

/def -p1 -q -agCblue -mglob -t'Du spuerst wie der Magiewesenzahn sich tief \
	in * bohrt.' re_mwz2 = \
	/set RE_WAFFE Magiewesenza%;\
	/set RE_WFUNC @{%RE_FARBE_18}Todesstoss@{%RE_FARBE_37}

/def -p1 -q -agCblue -mglob -t'Der Magiewesenzahn zerrt an den Kraeften *.' \
	re_mwz3 = \
	/set RE_WAFFE Magiewesenza%;\
	/set RE_WFUNC @{%RE_FARBE_18}Todesstoss@{%RE_FARBE_37}

/def -p1 -q -agCblue -mglob -t'Der Magiewesenzahn entzieht Dir * \
	und leuchtet kurz rot auf.' re_mwz4 = \
	/if ({5} =~ 'Lebenskraft') \
		/let RE_MWZ=L%;\
	/elseif ({5} =~ 'magische')\
		/let RE_MWZ=M%;\
	/else \
		/let RE_MWZ=?%;\
	/endif%;\
	/if (RE_SMS =~ '*') \
		/set RE_SMS @{%RE_FARBE_32}%RE_MWZ@{%RE_FARBE_35}%;\
	/else \
		/set RE_SMS @{%RE_FARBE_32}2@{%RE_FARBE_35}%;\
	/endif

;;; Silberner Dolch

/def -p1 -q -agCblue -mglob -t'Der Dolch {durchdringt|bohrt|reisst|glueht|\
	zerfetzt|zerstoert|vernichtet} *' re_sdolch = \
	/set RE_WAFFE Silberdolch%;\
	/set RE_WFUNC @{%RE_FARBE_37}Waffen-Fkt@{%RE_FARBE_37}

;;; Zombiering

/def -p1 -q -agCblue -mglob -t'Der Ring an * Hand schiesst einen feurigen \
	Blitz auf*' re_zombring_passiv = \
	/purge re_zombring_2%;\
	/if ({L1} !/ '*.') \
		/def -1 -p1 -q -agCblue -mglob -t'*.' re_zombring_2%;\
	/endif%;\
	/set RE_WFUNC @{%RE_FARBE_37}Waffen-Fkt@{%RE_FARBE_37}%;\
	/set RE_WAFFE Zombiering

/def -p1 -q -agCblue -msimple -t'Der Ring an Deiner Hand funkelt kurz und \
	schiesst dann einen feurigen Blitz' re_zombring_aktiv = \
	/purge re_zombring_2%;\
	/def -1 -p1 -q -agCblue -mglob -t'auf *.' re_zombring_2%;\
	/set RE_WFUNC @{%RE_FARBE_37}Waffen-Fkt@{%RE_FARBE_37}%;\
	/set RE_WAFFE Zombiering

;;; Mjoelnir

/def -p1 -q -agCblue -msimple -t'Mjoelnir schlaegt zu.' re_mjoelnir = \
	/set RE_TRIG_MJOELNIR 1

/def -p1 -q -agCblue -E(RE_TRIG_MJOELNIR) -msimple -t'Du hoerst ein sehr \
	lautes Knirschen.' re_mjoelnir_sub1 = \
	/set RE_WFUNC .sehr laut%;\
	/set RE_TRIG_MJOELNIR 0
 
/def -p1 -q -agCblue -E(RE_TRIG_MJOELNIR) -msimple -t'Du hoerst ein lautes \
	Knirschen.' re_mjoelnir_sub2 = \
	/set RE_WFUNC %RE_PT6laut%;\
	/set RE_TRIG_MJOELNIR 0
 
/def -p1 -q -agCblue -E(RE_TRIG_MJOELNIR) -msimple -t'Du hoerst ein \
	Knirschen.' re_mjoelnir_sub3 = \
	/set RE_WFUNC %RE_PT4normal%;\
	/set RE_TRIG_MJOELNIR 0
 
/def -p1 -q -agCblue -E(RE_TRIG_MJOELNIR) -msimple -t'Du hoerst ein leises \
	Knirschen.' re_mjoelnir_sub4 = \
	/set RE_WFUNC %RE_PT5leise%;\
	/set RE_TRIG_MJOELNIR 0

/def -p1 -q -agCblue -E(RE_TRIG_MJOELNIR) -msimple -t'Du hoerst ein sehr \
	leises Knirschen.' re_mjoelnir_sub5 = \
	/set RE_WFUNC sehr leise%;\
	/set RE_TRIG_MJOELNIR 0
 
/def -p1 -q -agCblue -E(RE_TRIG_MJOELNIR) -msimple -t'Der Hammer gaehnt \
	gelangweilt.' re_mjoelnir_sub6 = \
	/set RE_WFUNC %RE_PT3Gaehnen%;\
	/set RE_TRIG_MJOELNIR 0

;;; WBPD-Abzeichen

/def -p1 -q -agCblue -msimple -t'Ein Blitz zischt aus dem WBPD-Abzeichen.' \
        re_wbpd_abzeichen = \
        /set RE_WFUNC @{%RE_FARBE_37}Waffen-Fkt@{%RE_FARBE_37}%;\
        /set RE_WAFFE WBPD-Abzeich


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;				Artillerie
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Steine (Kampfstock)

/def -p1 -q -agCblue -mglob -t'* {schleuderst|schleudert} einen Stein nach \
	*.' re_steine =\
	/set RE_ART @{%RE_FARBE_22}Artillerie@{%RE_FARBE_35}%;\
	/set RE_WAFFE Stein

;;; Wurfsterne

/def -p5 -q -agCblue -mregexp -t' nimms?t einen Wurfstern in die Hand \
	und wirfs?t ihn nach ' re_wstern = \
	/purge -mglob re_wstern_*%;\
	/if ({PR} !/ '*.') \
		/def -p50 -F -n1 -q -agCblue -mglob -t'*' re_wstern_1%;\
	/endif%;\
	/def -1 -p3 -q -agCblue -mregexp -t'^  (Du|([^ ].*) Wurfstern) \
		(verfehlt|meilenweit an|zischt an|zischt knapp an|kratzt|\
		triffs?t|verpasst|schneidet|schlaegt|enthauptet|bleibt in|\
		zerfetzt) (.*) (meilenweit|vorbei|leicht|am Arm|einen \
		radikalen Kurzhaarschnitt|fast die Hand ab|Bein|fast den Kopf \
		ab|fast|Brust stecken|die Eingeweide).' re_wstern_s1 = \
		/set RE_ART @{%%RE_FARBE_22}Artillerie@{%%RE_FARBE_35}%%;\
		/set RE_WAFFE Wurfstern%%;\
		/set RE_SCHADEN %%P3%%;\
		/let RE_WSCHADEN_1 %%P5%%;\
		/if ({P2} !~ '') \
			/set RE_ANGREIFER %%P2%%;\
		/else \
			/set RE_ANGREIFER %%P1%%;\
		/endif%%;\
		/set RE_OPFER %%P4%%;\
		/if (regmatch(' Ohr', RE_OPFER)) \
			/set RE_OPFER %%PL%%;\
		/endif%%;\
		/if ((RE_OPFER =~ 'Dich') | (RE_OPFER =~ 'Deinem') | \
		    (RE_OPFER =~ 'Dir') | (RE_OPFER =~ 'Dein') | \
		    (RE_OPFER =~ 'Deiner')) \
			/set RE_OPFER Dich%%;\
		/endif%%;\
		/if ((RE_ANGREIFER !~ 'Du') & (RE_ANGREIFER !~ 'Dein') & \
		    (RE_ANGREIFER !~ 'Du wirfst den') & \
		    (RE_ANGREIFER !~ 'Der')) \
			/set RE_ANGREIFER $$(/re_genitiv_loeschen \
				%%RE_ANGREIFER)%%;\
		/else \
			/set RE_ANGREIFER Du%%;\
		/endif%%;\
		/if ((RE_SCHADEN =~ 'verfehlt') | (RE_SCHADEN =~ \
		    'meilenweit an')) \
			/set RE_SCHADEN 1%%;\
		/elseif (RE_SCHADEN =/ 'zischt *') \
			/set RE_OPFER $$(/re_genitiv_loeschen %%RE_OPFER)%%;\
			/set RE_SCHADEN 3%%;\
		/elseif (RE_SCHADEN =~ 'kratzt') \
			/set RE_SCHADEN 5%%;\
		/elseif ((RE_SCHADEN =/ 'triff*t') | (RE_SCHADEN =~ \
		    'verpasst') | (RE_SCHADEN =~ 'schneidet')) \
			/set RE_SCHADEN 6%%;\
		/elseif (RE_WSCHADEN_1 =~ 'Bein') \
			/set RE_OPFER $$(/re_genitiv_loeschen %%RE_OPFER)%%;\
			/set RE_SCHADEN 7%%;\
		/elseif ((RE_SCHADEN =~ 'schlaegt') | (RE_SCHADEN =~ \
		    'enthauptet')) \
			/set RE_SCHADEN 7%%;\
		/elseif (RE_SCHADEN =~ 'bleibt in') \
			/set RE_OPFER $$(/re_genitiv_loeschen %%RE_OPFER)%%;\
			/set RE_SCHADEN 8%%;\
		/elseif (RE_WSCHADEN_1 =~ 'die Eingeweide') \
			/set RE_SCHADEN 108%%;\
		/else \
			/set RE_SCHADEN 15%%;\
		/endif%%;\
		/re_ausgabe

;;; Robins Pfeile

/def -p1 -q -agCblue -mglob -t'* {legst|legt} einen Pfeil auf die Sehne * \
	Bogens und {spannst|spannt} ihn.' re_rpfeil = \
	/purge re_rpfeil_1%;\
	/def -1 -p1 -q -agCblue -mglob -t'Als * die Sehne loslaesst, schnellt \
		der Pfeil davon.' re_rpfeil_1 = \
		/set RE_ART @{%%RE_FARBE_22}Artillerie@{%%RE_FARBE_35}%%;\
		/set RE_WAFFE Robins Pfeil

;;; Paracelsus' Armbrust

/def -p1 -q -agCblue -mglob -t'* schiesst mit dem *bolzen auf *' re_pabrust = \
	/set RE_ART @{%RE_FARBE_22}Artillerie@{%RE_FARBE_35}%;\
	/set RE_WAFFE Armbrust

;;; Bumerangs

/def re_bumizeiger_aktualisieren=\
	/while /test (time() - RE_BUMI_ZEIT_%{RE_BUMI_START} > 10) & \
	    (RE_BUMI_START != RE_BUMI_STOP)%; /do \
		/set RE_BUMI_START $[mod((RE_BUMI_START + 1), 10)]%;\
	/done%;\
	/while /test (time() - RE_BUMI_ZEIT_%{RE_BUMI_FANG} > 20) & \
	    (RE_BUMI_FANG != RE_BUMI_START)%; /do \
		/set RE_BUMI_FANG $[mod((RE_BUMI_FANG + 1), 10)]%;\
	/done%;\
	/while /test (time() - RE_BUMI_RAUS_ZEIT_%{RE_BUMI_RAUS_START} > 10) & \
	    (RE_BUMI_RAUS_START != RE_BUMI_RAUS_STOP)%; /do \
		/set RE_BUMI_RAUS_START $[mod((RE_BUMI_RAUS_START + 1), 10)]%;\
	/done

/def re_bumi_aus = \
	/re_bumizeiger_aktualisieren%;\
	/if /test ((RE_BUMI_FANG != RE_BUMI_STOP) & \
	   ((time() - RE_BUMI_ZEIT_%{RE_BUMI_FANG}) >= 2))%; /then \
		/if (RE_BUMI_START == RE_BUMI_FANG) \
			/set RE_BUMI_START $[mod((RE_BUMI_START + 1), 10)]%;\
		/endif%;\
		/set RE_BUMI_FANG $[mod((RE_BUMI_FANG + 1), 10)]%;\
	/endif

/def -p2 -q -mglob -t'* {faengt|faengst} den *Bumerang {geschickt.|ab.}' \
	re_bumi1 = /re_bumi_aus 

/def -p1 -q -agCblue -mglob -t'* faengt den *Bumerang geschickt.' re_bumi2

/def -p2 -q -mregexp -t'^([^ ].*) wirfs?t den .*Bumerang( nach .*)?\\.$' \
	re_bumi3 = \
	/set RE_BUMI_WERFER_%RE_BUMI_STOP %P1%;\
	/set RE_BUMI_ZEIT_%RE_BUMI_STOP $[time()]%;\
	/set RE_BUMI_STOP $[mod((RE_BUMI_STOP + 1), 10)]

/def -p4 -q -agCblue -mglob -t'* wirft den *Bumerang*.' re_bumi4

/def -p1 -q -msimple -t'Zwei Bumerangs stossen in der Luft zusammen und \
	stuerzen ab.' re_bumi5 = \
	/re_bumi_aus%;\
	/re_bumi_aus

/def -p1 -q -mglob -t'Der *Bumerang bohrt sich in den Boden.' re_bumi6 = \
	/re_bumi_aus

/def -p1 -q -mglob -t'Der *Bumerang fliegt nach *.' re_bumi7 = \
	/re_bumizeiger_aktualisieren%;\
	/test RE_BUMI_RAUS_%RE_BUMI_RAUS_STOP := \
		RE_BUMI_WERFER_%{RE_BUMI_START}%;\
	/set RE_BUMI_RAUS_ZEIT_%RE_BUMI_RAUS_STOP $[time()]%;\
	/if (RE_BUMI_START != RE_BUMI_STOP) \
		/set RE_BUMI_START $[mod((RE_BUMI_START + 1), 10)]%;\
	/endif%;\
	/set RE_BUMI_RAUS_STOP $[mod((RE_BUMI_RAUS_STOP + 1), 10)]

/def -p1 -q -mglob -t'Der *Bumerang fliegt wieder herein.' re_bumi8 = \
	/re_bumizeiger_aktualisieren%;\
	/test RE_BUMI_WERFER_%RE_BUMI_STOP :=\
		RE_BUMI_RAUS_%{RE_BUMI_RAUS_START}%;\
	/set RE_BUMI_ZEIT_%RE_BUMI_STOP $[time()]%;\
	/set RE_BUMI_STOP $[mod((RE_BUMI_STOP + 1), 10)]%;\
	/if (RE_BUMI_RAUS_START != RE_BUMI_RAUS_STOP) \
		/set RE_BUMI_RAUS_START $[mod((RE_BUMI_RAUS_START + 1), 10)]%;\
	/endif

/def -p3 -q -agCblue -mregexp -t'(Der .*Bumerang (fliegt ueber|zischt an|\
	schwirrt knapp an|rasiert|trifft|schlaegt|zerschmettert|zermatscht|\
	pulverisiert|zerstaeubt|atomisiert) (.*) (hinweg|ein Haarbueschel ab|\
	am Kopf|hart am Kopf|sehr hart am Kopf|den Kopf ein|den Kopf in \
	kleine Stueckchen|den Kopf zu Brei|den Kopf|vorbei)|([^ ].*) \
	weichs?t dem .*Bumerang (gerade noch rechtzeitig|geschickt) aus)\\.$' \
	re_bumi9 = \
	/set RE_WAFFE Bumerang%;\
	/set RE_ART @{%RE_FARBE_22}Artillerie@{%RE_FARBE_35}%;\
	/re_waffe_geraten%;\
	/if ({P5} !~ '') \
		/set RE_OPFER %P5%;\
		/let RE_Schaden_Vor verfehlt%;\
	/else \
		/set RE_OPFER %P3%;\
		/let RE_Schaden_Vor %P2%;\
		/let RE_Schaden_Nach %P4%;\
	/endif%;\
	/re_bumizeiger_aktualisieren%;\
	/if (RE_BUMI_START != RE_BUMI_STOP) \
		/test RE_ANGREIFER := RE_BUMI_WERFER_%{RE_BUMI_START}%;\
		/set RE_BUMI_START $[mod((RE_BUMI_START + 1), 10)]%;\
	/else \
		/set RE_ANGREIFER ???%;\
	/endif%;\
	/if (regmatch(' (sehr |)hart', RE_OPFER)) \
		/set RE_OPFER %PL%;\
		/let RE_Schaden_Nach %P0 %RE_Schaden_Nach%;\
	/endif%;\
	/if (RE_OPFER =/ '* Kopf') \
		/let RE_Schaden_Nach Kopf %RE_Schaden_Nach%;\
		/set RE_OPFER $[substr(RE_OPFER, 0, -5)]%;\
	/endif%;\
	/if ((RE_OPFER =~ 'Du') | (RE_OPFER =~ 'Dir') | (RE_OPFER =~ \
	    'Deinem') | (RE_OPFER =~ 'Dich')) \
		/set RE_OPFER Dich%;\
	/endif%;\
	/if ((RE_Schaden_Vor =~ 'verfehlt') | (RE_Schaden_Vor =~ 'zischt an')) \
		/set RE_SCHADEN 1%;\
	/elseif ((RE_Schaden_Vor =~ 'schwirrt knapp an') | \
	    (RE_Schaden_Vor =~ 'fliegt ueber')) \
		/set RE_OPFER $(/re_genitiv_loeschen %RE_OPFER)%;\
		/set RE_SCHADEN 1%;\
	/elseif (RE_Schaden_Vor =~ 'rasiert') \
		/set RE_SCHADEN 3%;\
	/elseif (RE_Schaden_Nach =~ 'am Kopf') \
		/set RE_SCHADEN 4%;\
	/elseif (RE_Schaden_Nach =~ 'hart am Kopf') \
		/set RE_SCHADEN 5%;\
	/elseif (RE_Schaden_Nach =~ 'sehr hart am Kopf') \
		/set RE_SCHADEN 6%;\
	/elseif (RE_Schaden_Vor =~ 'schlaegt') \
		/set RE_SCHADEN 7%;\
	/elseif (RE_Schaden_Vor =~ 'zerschmettert') \
		/set RE_SCHADEN 8%;\
	/elseif (RE_Schaden_Vor =~ 'zermatscht') \
		/set RE_SCHADEN 9%;\
	/elseif (RE_Schaden_Vor =~ 'pulverisiert') \
		/set RE_SCHADEN 10%;\
	/elseif (RE_Schaden_Vor =~ 'zerstaeubt') \
		/set RE_SCHADEN 11%;\
	/elseif (RE_Schaden_Vor =~ 'atomisiert') \
		/set RE_SCHADEN 12%;\
	/else \
		/set RE_SCHADEN 15%;\
	/endif%;\
	/re_ausgabe

;;; Armitages Armbrust

/def -p2 -q -agCblue -mglob -t'Du zielst sorgsam auf * und laesst den \
	Bolzenpfeil von der Sehne*' re_aarmbrust = \
	/purge re_aarmbrust_1%;\
	/if ({L1} !~ 'schnellen.') \
		/def -1 -q -p32 -agCblue -mglob -t'*schnellen.' \
			re_aarmbrust_1%;\
	/endif%;\
	/set RE_ART @{%RE_FARBE_22}Artillerie@{%RE_FARBE_35}%;\
	/set RE_WAFFE Handarmbrust

/def -p2 -q -agCblue -mregexp -t' schiesst mit seiner Handarmbrust einen \
	Bolzenpfeil auf' re_aarmbrust2 = \
	/purge re_aarmbrust_1%;\
	/if ({PR} !/ '*.') \
		/def -1 -q -p32 -agCblue -mglob -t'*ab.' \
			re_aarmbrust_1%;\
	/endif%;\
	/set RE_ART @{%RE_FARBE_22}Artillerie@{%RE_FARBE_35}%;\
	/set RE_WAFFE Handarmbrust

; Voodoo-Nadeln von Armitage

/def -p2 -q -agCblue -mregexp -t' ergreifs?t eine Voodoonadel und zuecks?t \
	sie\\.$' re_vnadeln = \
	/purge -mglob re_vnadeln_*%;\
	/def -1 -p32 -q -agCblue -mglob -t'Die Voodoonadel leuchtet auf, \
		zersplittert und trifft *' re_vnadeln_2 = \
		/if ({*} !/ '*.') \
			/def -Fp2 -q -agCblue -mglob -t'*' re_vnadeln_3 = \
				/if ({*} =/ '*.') \
					/purge re_vnadeln_3%%%;\
				/endif%%;\
		/endif%;\
	/set RE_FLAECHE_ANGREIFER %PL%;\
	/set RE_FLAECHE_WAFFE Voodoo-Nadel%;\
	/set RE_FLAECHE_ART @{%RE_FARBE_22}Artillerie@{%RE_FARBE_35}%;\
	/set RE_FLAECHE_ZEIT $[time()]


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Ignorieren von kleinen Schaeden
;;;
;;; vorerst undokumentiert...
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

/def re_damage_ignore = \
	/echo%;\
	/if (regmatch('^dam', {1})) \
		/if (regmatch(RE_REGEXP_NUMBER, {2})) \
			/set RE_DAM_IGNORE %P0%;\
		/else \
			/set RE_DAM_IGNORE 0%;\
		/endif%;\
	/elseif ({1} =~ 'aus' | {1} =~ 'off') \
		/set RE_DAM_IGNORE_WHO 0%;\
	/elseif ({1} =~ 'mich' | {1} =~ 'me') \
		/set RE_DAM_IGNORE_WHO 1%;\
		/if (RE_DAM_IGNORE == 0) \
			/set RE_DAM_IGNORE 1%;\
		/endif%;\
	/elseif ({1} =~ 'alle' | {1} =~ 'all') \
		/set RE_DAM_IGNORE_WHO 2%;\
		/if (RE_DAM_IGNORE == 0) \
			/set RE_DAM_IGNORE 1%;\
		/endif%;\
	/else \
		/echo Syntax: /re_damage_ignore {dam[age] <x>|aus|mich|me|\
			all|alle}%;\
	/endif%;\
	/if (RE_DAM_IGNORE_WHO == 1) \
		/let RE_DAM_OUT Du ignorierst die auf Dich gerichteten \
			Schaeden%;\
	/elseif (RE_DAM_IGNORE_WHO == 2) \
		/let RE_DAM_OUT Du ignorierst alle Schaeden%;\
	/else \
		/let RE_DAM_OUT Du ignorierst keine Schaeden%;\
	/endif%;\
	/echo %RE_DAM_OUT kleiner oder gleich %RE_DAM_IGNORE.%;\
	/echo


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Ein "ignoriere" fuer Kampfmeldungen von Spielern und/oder NPCs.
;;;
;;; Setzen und Loeschen von Namen auf der Liste geht mit /re_filter <name>,
;;; ein /re_filter ohne Parameter zeigt an, wer alles ignoriert wird.
;;; Mit '/re_filter aus' kann das Ignorieren ausgeschaltet werden, ohne die
;;; Liste zu loeschen. Eingeschaltet wird dann wieder mit '/re_filter ein'.
;;;
;;; Aus der Ignoriere-Liste kann man mit '/re_filter anzeigen') ganz
;;; schnell das Gegenteil machen: es werden dann nur noch die Kampfmeldungen
;;; von den Leuten angezeigt, die auf der Liste stehen (Anmerkung dazu: eigene
;;; Angriffsmeldungen lauten auf 'Du', die eigene Abwehr ignoriert man mit
;;; 'Dich'). Das "normale" Verhalten erhaelt man dann wieder mit
;;; '/re_filter ignorieren').
;;;
;;; Aus Geschwindigkeitsgruenden werden die Namen auch ignoriert, wenn sie nur
;;; ein Teilstring des ignorierten Namens sind;
;;; ein '/re_filter Gardewaechter' ignoriert deshalb auch einen einfachen
;;; "Waechter".
;;;
;;; Die Namen auf der Ignoriere-Liste werden zwar alle in Kleinbuchstaben
;;; gewandelt, aber bei zu langen Namen ist es wichtig, sie exakt anzugeben,
;;; da sonst der Algorithmus zum Kuerzen des Namens anders kuerzen wuerde als
;;; spaeter im Kampf.
;;;
;;; Die Namen werden in der Variablen RE_IGNORIERE gespeichert; wer seine
;;; Liste schon beim Laden zur Verfuegung haben will, sollte die Variable in
;;; seinem Konfigurationsfile entsprechend setzen. Zu beachten ist dabei, dass
;;; die Namen in der Kurzform gespeichert werden. Im Zweifelsfall also die
;;; Ignoriere-Liste per /re_filter erstellen und die so erstellte Variable
;;; auslesen und abspeichern.

/def re_filter=\
/if ({*} =~ '') \
	/if (RE_IGNORIERE =~ '') \
		/let RE_AUSGABE_STRING Die Liste ist leer.%;\
	/else \
		/let RE_IGNORIERE_PUFFER %RE_IGNORIERE%;\
		/let RE_POSITION 0%;\
		/let RE_AUSGABE_STRING Die Liste beinhaltet zur Zeit: .%;\
		/while /test (RE_POSITION := strchr(substr(RE_IGNORIERE_PUFFER,\
		    1), '#')) != -1%; /do \
			/let RE_AUSGABE_STRING $[strcat(substr(\
				RE_AUSGABE_STRING, 0, -1), substr(\
				RE_IGNORIERE_PUFFER, 1, RE_POSITION), ', .')]%;\
			/let RE_IGNORIERE_PUFFER=$[substr(RE_IGNORIERE_PUFFER, \
				RE_POSITION+1)]%;\
		/done%;\
		/if (strlen(RE_AUSGABE_STRING) > 33) \
			/let RE_AUSGABE_STRING $[strcat(substr(\
				RE_AUSGABE_STRING, 0, -3),  ' und .')]%;\
		/endif%;\
		/let RE_AUSGABE_STRING $[strcat(substr(RE_AUSGABE_STRING, 0, \
			-1), substr(RE_IGNORIERE_PUFFER, 1), RE_PT)]%;\
	/endif%;\
	/let RE_AUSGABE_P1 $[RE_IGNORIERE_AKTIV ? 'aktive' : 'inaktive']%;\
	/let RE_AUSGABE_P2 $[RE_IGNORIERE_POSITIV ? 'Ignoriere' : 'Anzeige']%;\
	/echo -w -aCgreen Dein Kampfscroll-Filter ist zur Zeit eine \
		%{RE_AUSGABE_P1} %{RE_AUSGABE_P2}-Liste.%;\
	/echo -w -aCgreen %RE_AUSGABE_STRING%;\
/elseif ( ({*} =~ 'ein') | ({*} =~ 'an') | ({*} =~ 'on') ) \
	/set RE_IGNORIERE_AKTIV 1%;\
	/re_filter%;\
/elseif ( ({*} =~ 'aus') | ({*} =~ 'off') )\
	/set RE_IGNORIERE_AKTIV 0%;\
	/re_filter%;\
/elseif ({*} =/ 'ignoriere*') \
	/set RE_IGNORIERE_POSITIV 1%;\
	/re_filter%;\
/elseif ({*} =/ 'anzeige*') \
	/set RE_IGNORIERE_POSITIV 0%;\
	/re_filter%;\
/elseif ( {*} =~ 'hilfe' ) \
	/echo -w -aCyellow >>> Syntax: /re_filter [ein|an|on|aus|off]%;\
	/echo -w -aCyellow >>>         /re_filter [anzeigen|ignorieren]%;\
	/echo -w -aCyellow >>>         /re_filter [hilfe]%;\
/else \
	/let RE_IGNORIERE_KURZ $[tolower($(/re_namekuerzen 13 \
		$(/re_artikelkuerzen %{*})))]%;\
	/if (RE_IGNORIERE =/ strcat('*', RE_IGNORIERE_KURZ, '*')) \
		/echo -w -aCyellow Du nimmst \'%RE_IGNORIERE_KURZ\' von Deiner \
			Bewertungs-Liste herunter:%;\
		/let RE_POSITION $[strstr(RE_IGNORIERE, RE_IGNORIERE_KURZ)-1]%;\
		/set RE_IGNORIERE=$[tolower(strcat(substr(RE_IGNORIERE, 0, \
			RE_POSITION), substr(RE_IGNORIERE, RE_POSITION+\
			strlen(RE_IGNORIERE_KURZ)+1)))]%;\
	/else \
		/echo -w -aCyellow Du schreibst \'%RE_IGNORIERE_KURZ\' auf \
			Deine Bewertungs-Liste:%;\
		/set RE_IGNORIERE $[strcat(tolower(RE_IGNORIERE), '#', \
			RE_IGNORIERE_KURZ)]%;\
	/endif%;\
        /re_filter%;\
/endif


;;; Version und Datum aus dem cvs in die Variable schreiben & 
;;; regexpvars initialisieren

/def re_init = \
	/test regmatch(' ([0-9]+\\\\.[0-9]+) ([0-9]+)\\\\/([0-9]+)\\\\/\
		([0-9]+) ', reduce_tf_version)%;\
	/set RE_Version=%P1%;\
	/set RE_LA=%P4.%P3.%P2 Thufhir@MorgenGrauen%;\
	/if /!ismacro eval_hook%; /then \
		/def eval_hook=/return 1%;\
	/endif%;\
	/set RE_REGEXP_ARTICLE=%;\
	/set RE_REGEXP_ATTACK_KIND=%;\
	/if (ismacro("have_ext") & have_ext("PCRE")) \
		/test RE_REGEXP_ARTICLE:="^(:?[Dd](:?e(:?[rsmn]|\
			in(:?e[srnm]?)?)|ie|as)|[Ee]in(e[srmn]?)?) "%;\
		/set RE_REGEXP_SELF=^D(:?u|i(:?ch|r)|ein(:?e[nmr]?)?)\$%;\
		/test RE_REGEXP_ATTACK_KIND:=' (blutruenstig |vorsichtig |\
			schlangengleich |)mit (:?ihre[rmn] |seine[rmn] |\
			eine[rm] |de[mrn] |)'%;\
		/set RE_REGEXP_NUMBER=\\d+%;\
	/else \
		/test RE_REGEXP_ARTICLE:="^([Dd](e([rsmn]|\
			in(e[srnm]?)?)|ie|as)|[Ee]in(e[srmn]?)?) "%;\
		/set RE_REGEXP_SELF=^D(u|i(ch|r)|ein(e[nmr]?)?)\$%;\
		/test RE_REGEXP_ATTACK_KIND:=' (blutruenstig |vorsichtig |\
			schlangengleich |)mit (ihre[rmn] |seine[rmn] |\
			eine[rm] |de[mrn] |)'%;\
		/set RE_REGEXP_NUMBER=[0-9]+%;\
	/endif%;\
	/set RE_REGEXP_NAMEKUERZEN=[A-Z].*%;\
	/set RE_REGEXP_KARATEKOMBI=mit (.+) kombinierten (.+)%;\
	/set RE_REGEXP_ATTACK=%;\
	/test RE_REGEXP_ATTACK:=' (am Bauch|hart|sehr hart|mit dem Krachen \
		brechender Knochen|in kleine Stueckchen|zu Brei)\$'%;\
	/set RE_REGEXP_ATTACK2=%;\
	/test RE_REGEXP_ATTACK2:='(kitzel|schlaeg|zerschmetter)s?t '%;\
	/set RE_REGEXP_SETDEFEND=^[2-8]\$%;\
	/if /ismacro compile_regexp%; /then \
		/compile_regexp RE_REGEXP_*%;\
	/endif

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;             einige Sachen schonmal starten                 ;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

/re_init
/re_setcolours
/re_setschaeden
/re_ausgabezeile_basteln
/re_treffer_einruecken
/re_loeschen
/re_del_kampfmeldungen


;;; evtl. Meldung beim Laden ausgeben

/if (mload_file !/ '*reduce*') \
	/eval /echo -paCmagenta >>> Lade Paket: @{Cyellow}$[pad('reduce.tf', \
		-18)]@{Cmagenta} V$[pad(RE_Version, -4)] - %RE_LA%;\
/endif

