;;; 'zauberskills.tf' - Zauberer-Info anpassen
;;;

/set zauberskills_tf_version $Id: zauberskills.tf,v 1.2 2003/05/07 22:19:33 olm Exp $
/set zauberskills_tf_author=Vardion@mg.mud.de
/set zauberskills_tf_requires=
/set zauberskills_tf_desc=Anpassung der Zauberer-Einschaetzung

;;;
;;; Version: 1.19
;;; Letzte Aenderung: 05.08.2002  (c) Vardion@MorgenGrauen
;;;
;;; $Id: zauberskills.tf,v 1.2 2003/05/07 22:19:33 olm Exp $
;;;
;;; History:
;;;
;;;     Ver. 1.00:  Erste oeffentliche Version.
;;;
;;;     Ver. 1.01:  Umbenennung fast alle Variablen/Macros auf gaengige
;;;                 Konventionen.
;;;
;;;     Ver. 1.10:  Umorganisation der Trigger und Einbau der
;;;                 Bewertung fuer einzelne Sprueche.
;;;                 Ausserdem Verbesserung des remove-Macros.
;;;
;;;     Ver. 1.11   Alle Trigger wurden mit -q (quiet) versehen.
;;;
;;;	Ver. 1.12   Korrektur der benoetigten freien Haende fuer viele
;;;                 Sprueche (stand falsch auf den Webseiten).
;;;
;;;     Ver. 1.13   Korrektur der Regexp in zs_einzel2.
;;;
;;;     Ver. 1.14   Kleine Verbesserung an den echos von zs_kopf_ausgeben
;;;
;;;     Ver. 1.15   Max-Sprueche koennen jetzt in der Tabelle gegaggt werden
;;;                 (siehe Config-Teil). Ausserdem korrektur an einem
;;;                 Variablennamen.
;;;
;;;	Ver. 1.16   Die Sprueche 'Jammern' und 'Nerven' koennen jetzt aus
;;;                 der Tabelle rausgegaggt werden.
;;;
;;;	Ver. 1.17   Das Ausgabeformat, welches Llystrathe bei der Frage
;;;                 nach einzelnen Zweigen verwendet, wird nun auch
;;;                 ordentlich erkannt.
;;;
;;;     Ver. 1.18   Code etwas gesaeubert.
;;;
;;;     Ver. 1.19   Bezaubere braucht keine freien Haende mehr.
;;;
;;;
;;; Erlaeuterungen:
;;;
;;; Spruch Zwg LV Hnd Komponente Bewertung
;;; |      |   |  |   |          |
;;; |      |   |  |   |          +-------- Bewertung des Spruches
;;; |      |   |  |   +------------------- benoetigte Komponente
;;; |      |   |  +----------------------- benoetigte freie Haende
;;; |      |   +-------------------------- Gildenlevel des Spruches
;;; |      +------------------------------ Gildenzweig
;;; +------------------------------------- Zauberspruch / Faehigkeit
;;;

;;; Test auf bereits geladenes Paket
/if (ZS_GELADEN == 1) \
	/remove_zauberskills%; \
/endif

;;; Config

; Max-Sprueche in Tabelle rausgaggen?
/set ZS_GAG_MAX=0

; Jammern/Nerven in Tabelle rausgaggen?
/set ZS_GAG_JN=0

; Stufe -20
/set ZS_FARBE_0=BCred

; Stufe -19 bis -10
/set ZS_FARBE_1=Cred

; Stufe -9 bis -1
/set ZS_FARBE_2=Cyellow

; Stufe 0 bis 9
/set ZS_FARBE_3=Cgreen

; Stufe 10
/set ZS_FARBE_4=BCgreen

;;; Ende Config

;;; Version
/set ZS_VER 1.19
/set ZS_LA  05.08.2002

/set ZS_GELADEN=1
/eval /echo -p @{Cmagenta}>>> Lade Paket: @{Cblue}zauberskills.tf@{Cmagenta}    V%ZS_VER - %ZS_LA  (c) Vardion@MorgenGrauen

/def remove_zauberskills = \
	/purge -mglob zs_*%; \
	/quote -S /unset `"/listvar -mglob -s ZS_*"%; \
	/undef remove_zauberskills%; \
	/echo -p @{Cred}>>> Entferne Paket: @{Cblue}zauberskills.tf

;;; auf Einzelbewertung triggern
/def -p220 -mglob -q -ag -t'Llystrathe teilt Dir mit: Du beherrschst {*} \
	gemessen an *' zs_einzel1 = \
	/test set('ZS_SPRUCH_NAME=$[pad({7}, -18)]')%; \
	/def -p220 -mregexp -n1 -q -ag -t'^Llystrathe teilt Dir mit:( \
		Gildengrad)? ([a-zMN ]+)\\\\.$$' zs_einzel2 = \
		/set ZS_SPRUCH_WERTUNG=%%P2%%; \
		/set ZS_TABELLE=0%%; \
		/zs_kopf_ausgeben%%; \
		/zs_zeile_ausgeben

;;; auf Beginn der Liste triggern
/def -p220 -msimple -q -ag -t'Llystrathe teilt Dir mit: Folgendes ist von \
	Deinen Fertigkeiten zu halten:' zs_kopftrigger = \
	/set ZS_TABELLE=1%; \
	/zs_kopf_ausgeben

;;; auf Listenzeile triggern
/def -p220 -mregexp -q -ag -t'^Llystrathe teilt Dir mit: ([a-zA-Z ]+): \
	([a-zMN ]+)$' zs_zeilentrigger = \
	/test set('ZS_SPRUCH_NAME=$[substr(pad({P1}, -18), 0, 18)]')%; \
	/test set('ZS_SPRUCH_WERTUNG=%P2')%; \
	/zs_zeile_ausgeben
	

;;; Tabellenkopf ausgeben
/def zs_kopf_ausgeben = \
	/if (ZS_TABELLE == 1) \
		/echo -- ----------------------------------------------------\
			-----------------------%; \
	/endif%; \
	/echo -aB    Spruch            Zwg LV  Hnd Komponente      Bewertung%; \
	/if (ZS_TABELLE == 1) \
		/echo -- ----------------------------------------------------\
			-----------------------%; \
	/endif

;;; Tabellenzeile
/def  zs_zeile_ausgeben = \
	/let ZS_JN=0%; \
	/if     (ZS_SPRUCH_NAME =~ 'Insgesamt         ') \
		/test let('ZS_SP_ZWG=   ')%; \
		/test let('ZS_SP_LEV=  ')%; \
		/test let('ZS_SP_KOM=               ')%; \
		/test let('ZS_SP_HND=   ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Zaubern allgemein ') \
		/test let('ZS_SP_ZWG=   ')%; \
		/test let('ZS_SP_LEV=  ')%; \
		/test let('ZS_SP_KOM=               ')%; \
		/test let('ZS_SP_HND=   ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Zauberstab        ') \
		/test let('ZS_SP_ZWG=   ')%; \
		/test let('ZS_SP_LEV=  ')%; \
		/test let('ZS_SP_KOM=               ')%; \
		/test let('ZS_SP_HND= 1 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Entkraefte        ') \
		/test let('ZS_SP_ZWG=   ')%; \
		/test let('ZS_SP_LEV= 9')%; \
		/test let('ZS_SP_KOM=               ')%; \
		/test let('ZS_SP_HND= 0 ')%; \
; Angriff
	/elseif (ZS_SPRUCH_NAME =~ 'Hand              ') \
		/test let('ZS_SP_ZWG=Ang')%; \
		/test let('ZS_SP_LEV= 3')%; \
		/test let('ZS_SP_KOM=Eisw,Feuw,Drabl')%; \
		/test let('ZS_SP_HND=2-3')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Giftpfeil         ') \
		/test let('ZS_SP_ZWG=Ang')%; \
		/test let('ZS_SP_LEV= 5')%; \
		/test let('ZS_SP_KOM=Giftefeu       ')%; \
		/test let('ZS_SP_HND= 1 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Blitz             ') \
		/test let('ZS_SP_ZWG=Ang')%; \
		/test let('ZS_SP_LEV= 6')%; \
		/test let('ZS_SP_KOM=Zitteraalherz  ')%; \
		/test let('ZS_SP_HND= 1 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Feuerball         ') \
		/test let('ZS_SP_ZWG=Ang')%; \
		/test let('ZS_SP_LEV= 7')%; \
		/test let('ZS_SP_KOM=Blutstein      ')%; \
		/test let('ZS_SP_HND=1-3')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Verletze          ') \
		/test let('ZS_SP_ZWG=Ang')%; \
		/test let('ZS_SP_LEV= 8')%; \
		/test let('ZS_SP_KOM=div. Edelsteine')%; \
		/test let('ZS_SP_HND= 2 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Erdbeben          ') \
		/test let('ZS_SP_ZWG=Ang')%; \
		/test let('ZS_SP_LEV= 9')%; \
		/test let('ZS_SP_KOM=Meteoritenerz  ')%; \
		/test let('ZS_SP_HND= 1 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Feuerwalze        ') \
		/test let('ZS_SP_ZWG=Ang')%; \
		/test let('ZS_SP_LEV= 9')%; \
		/test let('ZS_SP_KOM=Phosphor       ')%; \
		/test let('ZS_SP_HND= 2 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Todeszauber       ') \
		/test let('ZS_SP_ZWG=Ang')%; \
		/test let('ZS_SP_LEV=10')%; \
		/test let('ZS_SP_KOM=Kroetenklaue   ')%; \
		/test let('ZS_SP_HND= 2 ')%; \
; Abwehr
	/elseif (ZS_SPRUCH_NAME =~ 'Schutz            ') \
		/test let('ZS_SP_ZWG=Abw')%; \
		/test let('ZS_SP_LEV= 3')%; \
		/test let('ZS_SP_KOM=               ')%; \
		/test let('ZS_SP_HND= 1 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Wille             ') \
		/test let('ZS_SP_ZWG=Abw')%; \
		/test let('ZS_SP_LEV= 5')%; \
		/test let('ZS_SP_KOM=               ')%; \
		/test let('ZS_SP_HND= 0 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Schutzhuelle      ') \
		/test let('ZS_SP_ZWG=Abw')%; \
		/test let('ZS_SP_LEV= 6')%; \
		/test let('ZS_SP_KOM=Schieferstueck ')%; \
		/test let('ZS_SP_HND= 1 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Rueste            ') \
		/test let('ZS_SP_ZWG=Abw')%; \
		/test let('ZS_SP_LEV= 7')%; \
		/test let('ZS_SP_KOM=Granit         ')%; \
		/test let('ZS_SP_HND= 2 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Teleport          ') \
		/test let('ZS_SP_ZWG=Abw')%; \
		/test let('ZS_SP_LEV= 8')%; \
		/test let('ZS_SP_KOM=Schwefel       ')%; \
		/test let('ZS_SP_HND= 0 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Zauberschild      ') \
		/test let('ZS_SP_ZWG=Abw')%; \
		/test let('ZS_SP_LEV= 9')%; \
		/test let('ZS_SP_KOM=Basil.schuppe  ')%; \
		/test let('ZS_SP_HND= 1 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Schutzzone        ') \
		/test let('ZS_SP_ZWG=Abw')%; \
		/test let('ZS_SP_LEV= 9')%; \
		/test let('ZS_SP_KOM=Modellhaus     ')%; \
		/test let('ZS_SP_HND= 2 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Bann              ') \
		/test let('ZS_SP_ZWG=Abw')%; \
		/test let('ZS_SP_LEV=10')%; \
		/test let('ZS_SP_KOM=Herz           ')%; \
		/test let('ZS_SP_HND= 1 ')%; \
; Illusion
	/elseif (ZS_SPRUCH_NAME =~ 'Stimme            ') \
		/test let('ZS_SP_ZWG=Ill')%; \
		/test let('ZS_SP_LEV= 2')%; \
		/test let('ZS_SP_KOM=               ')%; \
		/test let('ZS_SP_HND= 1 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Rausch            ') \
		/test let('ZS_SP_ZWG=Ill')%; \
		/test let('ZS_SP_LEV= 5')%; \
		/test let('ZS_SP_KOM=Alkohol        ')%; \
		/test let('ZS_SP_HND= 1 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Erschaffe         ') \
		/test let('ZS_SP_ZWG=Ill')%; \
		/test let('ZS_SP_LEV= 6')%; \
		/test let('ZS_SP_KOM=Wollknaeul     ')%; \
		/test let('ZS_SP_HND= 2 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Illusion          ') \
		/test let('ZS_SP_ZWG=Ill')%; \
		/test let('ZS_SP_LEV= 7')%; \
		/test let('ZS_SP_KOM=Nachtig.zunge  ')%; \
		/test let('ZS_SP_HND= 0 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Schattenkaempfer  ') \
		/test let('ZS_SP_ZWG=Ill')%; \
		/test let('ZS_SP_LEV= 8')%; \
		/test let('ZS_SP_KOM=Rabenfeder     ')%; \
		/test let('ZS_SP_HND= 1 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Gefaehrte         ') \
		/test let('ZS_SP_ZWG=Ill')%; \
		/test let('ZS_SP_LEV= 9')%; \
		/test let('ZS_SP_KOM=Schweiss       ')%; \
		/test let('ZS_SP_HND= 2 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Daemonenfratze    ') \
		/test let('ZS_SP_ZWG=Ill')%; \
		/test let('ZS_SP_LEV= 9')%; \
		/test let('ZS_SP_KOM=Daemonenmaske  ')%; \
		/test let('ZS_SP_HND= 1 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Verwirrung        ') \
		/test let('ZS_SP_ZWG=Ill')%; \
		/test let('ZS_SP_LEV=10')%; \
		/test let('ZS_SP_KOM=Phoenixfeder   ')%; \
		/test let('ZS_SP_HND= 1 ')%; \
; Beherrschung
	/elseif (ZS_SPRUCH_NAME =~ 'Zwingtanz         ') \
		/test let('ZS_SP_ZWG=Beh')%; \
		/test let('ZS_SP_LEV= 4')%; \
		/test let('ZS_SP_KOM=               ')%; \
		/test let('ZS_SP_HND= 0 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Erzwinge          ') \
		/test let('ZS_SP_ZWG=Beh')%; \
		/test let('ZS_SP_LEV= 5')%; \
		/test let('ZS_SP_KOM=rotes Haar     ')%; \
		/test let('ZS_SP_HND= 0 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Stille            ') \
		/test let('ZS_SP_ZWG=Beh')%; \
		/test let('ZS_SP_LEV= 6')%; \
		/test let('ZS_SP_KOM=               ')%; \
		/test let('ZS_SP_HND= 0 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Befriede          ') \
		/test let('ZS_SP_ZWG=Beh')%; \
		/test let('ZS_SP_LEV= 7')%; \
		/test let('ZS_SP_KOM=Pendel         ')%; \
		/test let('ZS_SP_HND= 1 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Schmerzen         ') \
		/test let('ZS_SP_ZWG=Beh')%; \
		/test let('ZS_SP_LEV= 8')%; \
		/test let('ZS_SP_KOM=Silbernadel    ')%; \
		/test let('ZS_SP_HND= 1 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Bezaubere         ') \
		/test let('ZS_SP_ZWG=Beh')%; \
		/test let('ZS_SP_LEV= 9')%; \
		/test let('ZS_SP_KOM=Parfum         ')%; \
		/test let('ZS_SP_HND= 0 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Irritiere         ') \
		/test let('ZS_SP_ZWG=Beh')%; \
		/test let('ZS_SP_LEV= 9')%; \
		/test let('ZS_SP_KOM=Lotusstaub     ')%; \
		/test let('ZS_SP_HND= 0 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Beschwoere        ') \
		/test let('ZS_SP_ZWG=Beh')%; \
		/test let('ZS_SP_LEV=10')%; \
		/test let('ZS_SP_KOM=Pentagramm     ')%; \
		/test let('ZS_SP_HND= 2 ')%; \
; Hellsicht
	/elseif (ZS_SPRUCH_NAME =~ 'Werte             ') \
		/test let('ZS_SP_ZWG=Hel')%; \
		/test let('ZS_SP_LEV= 2')%; \
		/test let('ZS_SP_KOM=               ')%; \
		/test let('ZS_SP_HND= 0 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Identifiziere     ') \
		/test let('ZS_SP_ZWG=Hel')%; \
		/test let('ZS_SP_LEV= 5')%; \
		/test let('ZS_SP_KOM=               ')%; \
		/test let('ZS_SP_HND= 0 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Finde             ') \
		/test let('ZS_SP_ZWG=Hel')%; \
		/test let('ZS_SP_LEV= 6')%; \
		/test let('ZS_SP_KOM=Glasmurmel     ')%; \
		/test let('ZS_SP_HND= 2 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Schaetz           ') \
		/test let('ZS_SP_ZWG=Hel')%; \
		/test let('ZS_SP_LEV= 7')%; \
		/test let('ZS_SP_KOM=Lupe           ')%; \
		/test let('ZS_SP_HND= 0 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Nachtsicht        ') \
		/test let('ZS_SP_ZWG=Hel')%; \
		/test let('ZS_SP_LEV= 8')%; \
		/test let('ZS_SP_KOM=Fledermausblut ')%; \
		/test let('ZS_SP_HND= 2 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Wahrsagen         ') \
		/test let('ZS_SP_ZWG=Hel')%; \
		/test let('ZS_SP_LEV= 9')%; \
		/test let('ZS_SP_KOM=Diamant        ')%; \
		/test let('ZS_SP_HND= 1 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Vorahnung         ') \
		/test let('ZS_SP_ZWG=Hel')%; \
		/test let('ZS_SP_LEV= 9')%; \
		/test let('ZS_SP_KOM=Met.eisennadel ')%; \
		/test let('ZS_SP_HND= 0 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Observiere        ') \
		/test let('ZS_SP_ZWG=Hel')%; \
		/test let('ZS_SP_LEV=10')%; \
		/test let('ZS_SP_KOM=Auge ein. Toten')%; \
		/test let('ZS_SP_HND= 1 ')%; \
; Verwandlung
	/elseif (ZS_SPRUCH_NAME =~ 'Licht             ') \
		/test let('ZS_SP_ZWG=Ver')%; \
		/test let('ZS_SP_LEV= 1')%; \
		/test let('ZS_SP_KOM=               ')%; \
		/test let('ZS_SP_HND= 0 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Wasserwandlung    ') \
		/test let('ZS_SP_ZWG=Ver')%; \
		/test let('ZS_SP_LEV= 5')%; \
		/test let('ZS_SP_KOM=Fl. mit Wasser ')%; \
		/test let('ZS_SP_HND= 2 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Extrahand         ') \
		/test let('ZS_SP_ZWG=Ver')%; \
		/test let('ZS_SP_LEV= 6')%; \
		/test let('ZS_SP_KOM=mumifiz. Hand  ')%; \
		/test let('ZS_SP_HND= 2 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Anpassung         ') \
		/test let('ZS_SP_ZWG=Ver')%; \
		/test let('ZS_SP_LEV= 7')%; \
		/test let('ZS_SP_KOM=               ')%; \
		/test let('ZS_SP_HND= 2 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Schnell           ') \
		/test let('ZS_SP_ZWG=Ver')%; \
		/test let('ZS_SP_LEV= 8')%; \
		/test let('ZS_SP_KOM=Sturmvogelfeder')%; \
		/test let('ZS_SP_HND= 0 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Selbstverwandlung ') \
		/test let('ZS_SP_ZWG=Ver')%; \
		/test let('ZS_SP_LEV= 9')%; \
		/test let('ZS_SP_KOM=Kuerbiskern    ')%; \
		/test let('ZS_SP_HND= 2 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Wandlung          ') \
		/test let('ZS_SP_ZWG=Ver')%; \
		/test let('ZS_SP_LEV= 9')%; \
		/test let('ZS_SP_KOM=Phiole m. Elem.')%; \
		/test let('ZS_SP_HND= 2 ')%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Imagomation       ') \
		/test let('ZS_SP_ZWG=Ver')%; \
		/test let('ZS_SP_LEV=10')%; \
		/test let('ZS_SP_KOM=Alraune        ')%; \
		/test let('ZS_SP_HND= 2 ')%; \
; bisher unbekannte Sprueche
	/elseif (ZS_SPRUCH_NAME =~ 'Jammern           ') \
		/test let('ZS_SP_ZWG= ? ')%; \
		/test let('ZS_SP_LEV= ?')%; \
		/test let('ZS_SP_KOM=               ')%; \
		/test let('ZS_SP_HND= ? ')%; \
		/let ZS_JN=1%; \
	/elseif (ZS_SPRUCH_NAME =~ 'Nerven            ') \
		/test let('ZS_SP_ZWG= ? ')%; \
		/test let('ZS_SP_LEV= ?')%; \
		/test let('ZS_SP_KOM=               ')%; \
		/test let('ZS_SP_HND= ? ')%; \
		/let ZS_JN=1%; \
; unbekannter Spruch / Fehler
	/else \
		/test let('ZS_SP_ZWG= ? ')%; \
		/test let('ZS_SP_LEV= ?')%; \
		/test let('ZS_SP_KOM=    ?          ')%; \
		/test let('ZS_SP_HND= ? ')%; \
	/endif%; \
; Bewertungen
	/let ZS_MAX=0%; \
	/if     (ZS_SPRUCH_WERTUNG =~ 'unaussprechbar uebel') \
		/let ZS_SP_BEW=@{%ZS_FARBE_0}-20 %ZS_SPRUCH_WERTUNG%; \
		/let ZS_VALUE=-20%;\
	/elseif (ZS_SPRUCH_WERTUNG =~ 'aeusserst uebel') \
		/let ZS_SP_BEW=@{%ZS_FARBE_1}-19 %ZS_SPRUCH_WERTUNG%; \
		/let ZS_VALUE=-19%;\
	/elseif (ZS_SPRUCH_WERTUNG =~ 'sehr uebel') \
		/let ZS_SP_BEW=@{%ZS_FARBE_1}-18 %ZS_SPRUCH_WERTUNG%; \
		/let ZS_VALUE=-18%;\
	/elseif (ZS_SPRUCH_WERTUNG =~ 'miserabelst') \
		/let ZS_SP_BEW=@{%ZS_FARBE_1}-17 %ZS_SPRUCH_WERTUNG%; \
		/let ZS_VALUE=-17%;\
	/elseif (ZS_SPRUCH_WERTUNG =~ 'aeusserst miserabel') \
		/let ZS_SP_BEW=@{%ZS_FARBE_1}-16 %ZS_SPRUCH_WERTUNG%; \
		/let ZS_VALUE=-16%;\
	/elseif (ZS_SPRUCH_WERTUNG =~ 'miserabel') \
		/let ZS_SP_BEW=@{%ZS_FARBE_1}-15 %ZS_SPRUCH_WERTUNG%; \
		/let ZS_VALUE=-15%;\
	/elseif (ZS_SPRUCH_WERTUNG =~ 'noch miserabel') \
		/let ZS_SP_BEW=@{%ZS_FARBE_1}-14 %ZS_SPRUCH_WERTUNG%; \
		/let ZS_VALUE=-14%;\
	/elseif (ZS_SPRUCH_WERTUNG =~ 'aeusserst schlecht') \
		/let ZS_SP_BEW=@{%ZS_FARBE_1}-13 %ZS_SPRUCH_WERTUNG%; \
		/let ZS_VALUE=-13%;\
	/elseif (ZS_SPRUCH_WERTUNG =~ 'sehr schlecht') \
		/let ZS_SP_BEW=@{%ZS_FARBE_1}-12 %ZS_SPRUCH_WERTUNG%; \
		/let ZS_VALUE=-12%;\
	/elseif (ZS_SPRUCH_WERTUNG =~ 'reichlich schlecht') \
		/let ZS_SP_BEW=@{%ZS_FARBE_1}-11 %ZS_SPRUCH_WERTUNG%; \
		/let ZS_VALUE=-11%;\
	/elseif (ZS_SPRUCH_WERTUNG =~ 'ziemlich schlecht') \
		/let ZS_SP_BEW=@{%ZS_FARBE_1}-10 %ZS_SPRUCH_WERTUNG%; \
		/let ZS_VALUE=-10%;\
	/elseif (ZS_SPRUCH_WERTUNG =~ 'schlecht') \
		/let ZS_SP_BEW=@{%ZS_FARBE_2} -9 %ZS_SPRUCH_WERTUNG%; \
		/let ZS_VALUE=-9%;\
	/elseif (ZS_SPRUCH_WERTUNG =~ 'gerade noch schlecht') \
		/let ZS_SP_BEW=@{%ZS_FARBE_2} -8 %ZS_SPRUCH_WERTUNG%; \
		/let ZS_VALUE=-8%;\
	/elseif (ZS_SPRUCH_WERTUNG =~ 'aeusserst ungenuegend') \
		/let ZS_SP_BEW=@{%ZS_FARBE_2} -7 %ZS_SPRUCH_WERTUNG%; \
		/let ZS_VALUE=-7%;\
	/elseif (ZS_SPRUCH_WERTUNG =~ 'ungenuegend') \
		/let ZS_SP_BEW=@{%ZS_FARBE_2} -6 %ZS_SPRUCH_WERTUNG%; \
		/let ZS_VALUE=-6%;\
	/elseif (ZS_SPRUCH_WERTUNG =~ 'aeusserst mangelhaft') \
		/let ZS_SP_BEW=@{%ZS_FARBE_2} -5 %ZS_SPRUCH_WERTUNG%; \
		/let ZS_VALUE=-5%;\
	/elseif (ZS_SPRUCH_WERTUNG =~ 'sehr mangelhaft') \
		/let ZS_SP_BEW=@{%ZS_FARBE_2} -4 %ZS_SPRUCH_WERTUNG%; \
		/let ZS_VALUE=-4%;\
	/elseif (ZS_SPRUCH_WERTUNG =~ 'mangelhaft') \
		/let ZS_SP_BEW=@{%ZS_FARBE_2} -3 %ZS_SPRUCH_WERTUNG%; \
		/let ZS_VALUE=-3%;\
	/elseif (ZS_SPRUCH_WERTUNG =~ 'gerade noch mangelhaft') \
		/let ZS_SP_BEW=@{%ZS_FARBE_2} -2 %ZS_SPRUCH_WERTUNG%; \
		/let ZS_VALUE=-2%;\
	/elseif (ZS_SPRUCH_WERTUNG =~ 'so gerade eben noch mangelhaft') \
		/let ZS_SP_BEW=@{%ZS_FARBE_2} -1 so g. e. noch mangelhaft%; \
		/let ZS_VALUE=-1%;\
	/elseif (ZS_SPRUCH_WERTUNG =~ 'mit Mueh und Not ausreichend') \
		/let ZS_SP_BEW=@{%ZS_FARBE_3}  0 m. Mueh u. Not ausreich.%; \
		/let ZS_VALUE=0%;\
	/elseif (ZS_SPRUCH_WERTUNG =~ 'nur knapp ausreichend') \
		/let ZS_SP_BEW=@{%ZS_FARBE_3}  1 %ZS_SPRUCH_WERTUNG%; \
		/let ZS_VALUE=1%;\
	/elseif (ZS_SPRUCH_WERTUNG =~ 'ausreichend') \
		/let ZS_SP_BEW=@{%ZS_FARBE_3}  2 %ZS_SPRUCH_WERTUNG%; \
		/let ZS_VALUE=2%;\
	/elseif (ZS_SPRUCH_WERTUNG =~ 'gut ausreichend') \
		/let ZS_SP_BEW=@{%ZS_FARBE_3}  3 %ZS_SPRUCH_WERTUNG%; \
		/let ZS_VALUE=3%;\
	/elseif (ZS_SPRUCH_WERTUNG =~ 'schon fast befriedigend') \
		/let ZS_SP_BEW=@{%ZS_FARBE_3}  4 %ZS_SPRUCH_WERTUNG%; \
		/let ZS_VALUE=4%;\
	/elseif (ZS_SPRUCH_WERTUNG =~ 'befriedigend') \
		/let ZS_SP_BEW=@{%ZS_FARBE_3}  5 %ZS_SPRUCH_WERTUNG%; \
		/let ZS_VALUE=5%;\
	/elseif (ZS_SPRUCH_WERTUNG =~ 'sehr befriedigend') \
		/let ZS_SP_BEW=@{%ZS_FARBE_3}  6 %ZS_SPRUCH_WERTUNG%; \
		/let ZS_VALUE=6%;\
	/elseif (ZS_SPRUCH_WERTUNG =~ 'ziemlich gut') \
		/let ZS_SP_BEW=@{%ZS_FARBE_3}  7 %ZS_SPRUCH_WERTUNG%; \
		/let ZS_VALUE=7%;\
	/elseif (ZS_SPRUCH_WERTUNG =~ 'wirklich gut') \
		/let ZS_SP_BEW=@{%ZS_FARBE_3}  8 %ZS_SPRUCH_WERTUNG%; \
		/let ZS_VALUE=8%;\
	/elseif (ZS_SPRUCH_WERTUNG =~ 'sehr gut') \
		/let ZS_SP_BEW=@{%ZS_FARBE_3}  9 %ZS_SPRUCH_WERTUNG%; \
		/let ZS_VALUE=9%;\
	/elseif (ZS_SPRUCH_WERTUNG =~ 'aussergewoehnlich gut') \
		/let ZS_SP_BEW=@{%ZS_FARBE_4} 10 %ZS_SPRUCH_WERTUNG%; \
		/let ZS_VALUE=10%;\
		/let ZS_MAX=1%; \
	/elseif (ZS_SPRUCH_WERTUNG =~ 'gar nicht') \
		/let ZS_SP_BEW=@{%ZS_FARBE_0}-20 %ZS_SPRUCH_WERTUNG%; \
		/let ZS_VALUE=-20%;\
	/else  \
		/let ZS_SP_BEW=  ? %ZS_SPRUCH_WERTUNG%; \
	/endif%; \
	/if ((ZS_TABELLE == 0) | ((ZS_MAX & ZS_GAG_MAX) == 0) & \
		((ZS_JN & ZS_GAG_JN) == 0)) \
		/echo -p %ZS_SPRUCH_NAME%ZS_SP_ZWG %ZS_SP_LEV  %ZS_SP_HND \
			%ZS_SP_KOM %ZS_SP_BEW%; \
	/endif%;\
	/if (ismacro('eval_hook')) \
		/eval_hook set_skillability $[tolower({ZS_SPRUCH_NAME})] %ZS_VALUE%;\
	/endif

