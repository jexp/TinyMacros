; $Log: gag.tf,v $
; Revision 1.17  2003/01/02 03:44:19  olm
; Noch eine Meldung vergessen
;
; Revision 1.16  2003/01/02 03:37:31  olm
; Schlamm aus der Unterwelt (Wurzel) hinzugefuegt
;
; Revision 1.15  2002/10/30 09:17:06  rumburuk
; gag_tf_omb37 debuggt
;
; Revision 1.14  2002/10/29 22:57:11  rumburuk
; weitere Meldungen
;
; Revision 1.13  2002/10/29 21:56:32  rumburuk
; Maskierungen berichtigt
;
; Revision 1.12  2002/10/25 08:20:08  thufhnik
; im Kampf An- und Ausziehen sowie Zuecken und Wegstecken anderer gagen
;
; Revision 1.11  2002/10/24 12:05:43  rumburuk
; Typo raus
;
; Revision 1.10  2002/10/24 12:04:12  rumburuk
; Mal wieder paar Ombatismeldungen nachgetragen
;
; Revision 1.9  2002/10/24 07:30:49  rumburuk
; Andy, Mordillar
;
; Revision 1.8  2002/10/23 18:27:30  rumburuk
; gestank11 raus wegen Heilwurzel, Fixes bei Ombatis, Amanda komplett gagen
;
; Revision 1.7  2002/10/23 18:11:37  nieten
; Prioritaet der Ebenentrigger fuer Ombatis korrigiert
;
; Revision 1.6  2002/10/23 09:47:56  rumburuk
; Weitere Ombatis-Meldungen
;
; Revision 1.5  2002/10/22 14:29:16  rumburuk
; Weitere Meldungen von Ombatis eingebaut
;
; Revision 1.4  2002/10/22 12:26:17  rumburuk
; Erdgrube Lupinental
;
; Revision 1.3  2002/10/22 12:02:56  rumburuk
; Ombatisgager erweitert und debuggt, Weckergager richtig benamst
;
; Revision 1.2  2002/10/19 19:59:15  rumburuk
; Ombatis-Gager erweitert
;
; Revision 1.1  2002/10/19 17:41:00  rumburuk
; scratch
;

/set gag_tf_version $Id: gag.tf,v 1.17 2003/01/02 03:44:19 olm Exp $
/set gag_tf_author=Deepblue@mg.mud.de
/set gag_tf_desc=Gager gegen nervende Ausgaben
/set gag_tf_requires=

;;;
;;; Basis: Ringors gag.tf 
;;;

;;; Eventuell noch vorhandene Versionen der Trigger aus dem Speicher loeschen:
/purge -mglob gag_tf_*


;;; Alle Macros und Trigger koennen per Befehl wieder entfernt werden:
/def remove_gag_tf=\
	/purge -mglob gag_tf_*%;\
	/echo -paCred >>> Entferne Definitionen von: @{Cyellow}gag.tf%;/echo%;\
	/purge remove_gag_tf%;\
	/purge gag_ombatis



;;; Die leidige Furzkrankheit

/def -p6 -agCblue -mglob -q -t'Der Furz riecht, als wuerde * innerlich \
	verfaulen.' gag_tf_furz1
/def -p6 -agCblue -msimple -q -t'Widerliche Duenste erfuellen den Raum.' gag_tf_furz2
/def -p6 -agCblue -mglob -q -t'* laesst einen Stinkefurz fahren.' gag_tf_furz3
/def -p6 -agCblue -msimple -q -t'Fuerchterlicher Gestank erfuellt den Raum.' gag_tf_furz4
/def -p6 -agCblue -msimple -q -t'Du haeltst Dir die Nase zu.' gag_tf_furz5
/def -p6 -agCblue -mglob -q -t'* Furz stinkt wirklich grauenerregend.' gag_tf_furz6
/def -p6 -agCblue -mglob -q -t'Du musst Dich beinah uebergeben, als * Furz in \
	Deine Nase kriecht.' gag_tf_furz7

;;; Andere Gestanksarten (Wurzels Klo, Heilige Scheisse usw.)

;;;Heilige Scheisse
/def -p6 -agCblue -msimple -q -t'Die Heilige Scheisse stinkt zum Himmel.' gag_tf_gestank1
/def -p6 -agCblue -msimple -q -t'Du denkst   . o O (Ob da wer Sakrament und Exkrement verwechselt hat?)' gag_tf_gestank2
/def -p6 -agCblue -msimple -q -t'Du haeltst Dir die Nase zu.' gag_tf_gestank3
/def -p6 -agCblue -mglob -q -t'* haelt sich die Nase zu. Kein Wunder!' gag_tf_gestank4
/def -p6 -agCblue -msimple -q -t'Wie kann ein heiliges Objekt nur so stinken?' gag_tf_gestank5

;;; Klo
/def -p6 -agCblue -msimple -q -t'Du stinkst.' gag_tf_gestank10
;;; Wird auch Von Heilwurzeln genutzt - nicht gaggen
;;;/def -p6 -agCblue -mglob -q -t'* stinkt widerlich.' gag_tf_gestank11
/def -p6 -agCblue -mglob -q -t'* stinkt.' gag_tf_gestank12
/def -p6 -agCblue -mglob -q -t'* stinkt dass Dir fast schlecht wird.' gag_tf_gestank13
/def -p6 -agCblue -mglob -q -t'* riecht nach Kloake.' gag_tf_gestank14
/def -p6 -agCblue -mglob -q -t'* riecht wie frisch aus dem Misthaufen gekommen.' gag_tf_gestank15
/def -p6 -agCblue -mglob -q -t'* beleidigt Deine Nase.' gag_tf_gestank16
/def -p6 -agCblue -mglob -q -t'* riecht nach fauligen Faekalien.' gag_tf_gestank17
/def -p6 -agCblue -mglob -q -t'* stinkt uebel.' gag_tf_gestank18

;;;Drachenscheisse
/def -p6 -agCblue -msimple -q -t'Du stinkst abscheulich.' gag_tf_gestank20
/def -p6 -agCblue -mglob -q -t'* stinkt vor sich hin.' gag_tf_gestank21
/def -p6 -agCblue -mglob -q -t'* stinkt abscheulich.' gag_tf_gestank22

;;; Schlamm aus der Unterwelt, danke Wurzel!
/def -p6 -agCblue -msimple -q -t'Der Schlamm trocknet allmaehlich ...' gag_tf_gestank23
/def -p6 -agCblue -msimple -q -t'Der Schlamm ist getrocknet und broeselt von Deinem Koerper ab.' gag_tf_gestank24
/def -p6 -agCblue -msimple -q -t'Igitt! Der Schlamm klebt ueberall an Deinem Koerper.' gag_tf_gestank25
/def -p6 -agCblue -msimple -q -t'So ein Pech! Du schlitterst durch den Schlamm und faellst voll auf den Hintern.' gag_tf_gestank26
/def -p6 -agCblue -msimple -q -t'Huuiiih! Beinahe bist Du ausgerutscht und in den Schlamm gefallen.' gag_tf_gestank27


;;; Nervende NPC

/def -p6 -agCblue -mglob -q -t'Anne teilt Dir mit: *' gag_tf_npc1
/def -p6 -agCblue -mglob -q -t'Lady Janet ruft: *' gag_tf_npc2
/def -p6 -agCblue -mglob -q -t'Anne ruft: *' gag_tf_npc3
/def -p8 -agCblue -mglob -q -t'\\[Bierschuettler:Bruno\\] *' gag_tf_npc4
/def -p6 -agCblue -mglob -q -t'Eusebius *' gag_tf_npc5
/def -p6 -agCblue -mglob -q -t'Hippe *' gag_tf_npc6
/def -p6 -agCblue -mglob -q -t'Amanda *' gag_tf_npc7
/def -p6 -agCblue -mglob -q -t'Andy *' gag_tf_npc8
/def -p6 -agCblue -msimple -q -t'Mordillar kommt herein und verkuendet was von einer Party.' gag_tf_npc9

;;; Ombatis nervt. Weggegaggt wird er bei Erscheinen.
;;; Falls man ihn trotzdem erleben moechte (warum?) geht das mit /gag_ombatis
;;; off. Ruhe gibts dann wieder mit /gag_ombatis on.
;;; Die neuen Meldungen fehlen aber noch

/def -p7 -agCred -mregexp -q -t'^Ombatis sagt: Hallo (.*)! (.*) \
	hat mich zu Dir geschickt! :-\\)$' gag_tf_ombtrigger1=\
	/echo -aCred %P2 hat Dir einen Ombatis geschickt!%;\
	/gag_ombatis on

/def -p7 -agCgreen -msimple -q -t'Ombatis macht sich geschwind davon.' \
	gag_tf_ombtrigger2=\
		/def -1 -p7 -agCgreen -msimple -q -t'Knuddle wen?' \
			gag_tf_ombtrigger3=\
			/undef gag_tf_ombtrigger4%%;\
			/echo -aCgreen Ombatis ist weg.%%;\
			/gag_ombatis aus%;\
		/def -1 -p7 -agCgreen -msimple -q -t'Du knuddelst Ombatis.' \
			gag_tf_ombtrigger4 = /undef gag_tf_ombtrigger3%;\
		knuddel ombatis


/def gag_ombatis=\
	/if ({1} =~ 'on') \
		/if /!ismacro omb1%; /then \
			/def -p6 -agCblue -mglob -q -t'Bruno *' gag_tf_omb1%;\
			/def -p6 -agCblue -mglob -q -t'Dein Quaelgeist *' gag_tf_omb2%;\
			/def -p6 -agCblue -mglob -q -t'Der boese Geist *' gag_tf_omb3%;\
			/def -p6 -agCblue -mglob -q -t'Der chaotische Daemon *' gag_tf_omb4%;\
			/def -p6 -agCblue -mglob -q -t'Der fette Daemon *' gag_tf_omb5%;\
			/def -p6 -agCblue -mglob -q -t'Der Daemon *' gag_tf_omb6%;\
			/def -p6 -agCblue -mglob -q -t'Der fette Ombatis*' gag_tf_omb7%;\
			/def -p6 -agCblue -mglob -q -t'Der freche Typ *' gag_tf_omb8%;\
			/def -p6 -agCblue -mglob -q -t'Der Kobold *' gag_tf_omb9%;\
			/def -p6 -agCblue -mglob -q -t'Der Nervdaemon *' gag_tf_omb10%;\
			/def -p6 -agCblue -mglob -q -t'Der Nervsack *' gag_tf_omb11%;\
			/def -p6 -agCblue -mglob -q -t'Der nervtoetende Daemon *' gag_tf_omb12%;\
			/def -p6 -agCblue -mglob -q -t'Der Quaelgeist *' gag_tf_omb13%;\
			/def -p6 -agCblue -mglob -q -t'Die Nervensaege *' gag_tf_omb14%;\
			/def -p6 -agCblue -mglob -q -t'Ein Chaosdaemon *' gag_tf_omb15%;\
			/def -p6 -agCblue -mglob -q -t'Ein Daemon *' gag_tf_omb16%;\
			/def -p6 -agCblue -mglob -q -t'Ein Penner *' gag_tf_omb17%;\
			/def -p6 -agCblue -mglob -q -t'Ein Scherzkeks *' gag_tf_omb18%;\
			/def -p6 -agCblue -mglob -q -t'Ein Unhold *' gag_tf_omb19%;\
			/def -p6 -agCblue -mglob -q -t'Ein Unsichtbarer *' gag_tf_omb20%;\
			/def -p6 -agCblue -mglob -q -t'Ein Witzbold *' gag_tf_omb21%;\
			/def -p6 -agCblue -mglob -q -t'Etwas *' gag_tf_omb22%;\
			/def -p6 -agCblue -mglob -q -t'Jemand *' gag_tf_omb23%;\
			/def -p6 -agCblue -mglob -q -t'Ombatis *' gag_tf_omb24%;\
			/def -p6 -agCblue -mglob -q -t'Gruuuuummmmmel! {Ombatis|Ombatis\\'} Bauch \
				knurrt.' gag_tf_omb25%;\
			/def -p6 -agCblue -msimple -q -t'Zardoz teilt Dir mit: Ich wurde \
				gezwungen diesen Daemon zu programmieren!' gag_tf_omb26%;\
			/def -p6 -agCblue -msimple -q -t'Dies ist ein nervendes Echo von \
				Ombatis.' gag_tf_omb27%;\
			/def -p6 -agCblue -msimple -q -t'Du hoerst von irgendwo ein \
				Kichern.' gag_tf_omb28%;\
			/def -p6 -agCblue -msimple -q -t'Zardoz teilt Dir mit: Das muss \
				ein Bug sein. Ombatis ist eigentlich ganz lieb!' gag_tf_omb29%;\
			/def -p6 -agCblue -msimple -q -t'Kruuolq teilt Dir mit: So sind \
				diese Chaoten halt...' gag_tf_omb30%;\
			/def -p6 -agCblue -mglob -q -t'Du hast jetzt noch * Lebenspunkte \
				und * Magiepunkte.' gag_tf_omb31%;\
			/def -p6 -agCblue -msimple -q -t'Swift teilt Dir mit: Bierchen hat mich gezwungen, \
				diesen Daemon zu' gag_tf_omb32%;\
			/def -p6 -agCblue -msimple -q -t'Swift teilt Dir mit: programmieren!' gag_tf_omb33%;\
			/def -p6 -agCblue -msimple -q -t'Feuerwehr teilt Dir mit: Na, sind wir Chaoten nicht \
				absolut gemein?' gag_tf_omb34%;\
			/def -p6 -agCblue -msimple -q -t'Zardoz teilt Dir mit: Schuld ist Swift. Zu meinen Zeiten \
				war Ombatis ganz' gag_tf_omb35%;\
			/def -p6 -agCblue -msimple -q -t'Zardoz teilt Dir mit: lieb!' gag_tf_36%;\
			/def -p7 -agCblue -mglob -q -t'* zeigt Dir die Liste der anwesenden Spieler. ' \
				gag_tf_omb37 = \
				/def -p6 -agCblue -mglob -q -t'*' gag_tf_omb37a%%;\
				/def -1 -p7 -agCblue -mglob -q -t'* Siehst Du, soviele Spieler sind gerade da*' \
					gag_tf_omb37b = /undef gag_tf_omb37a%;\
			/def -p6 -agCblue -msimple -q -t'Armageddon ruft: Ich starte das Spiel jetzt neu !' \
				gag_tf_omb38%;\
			/def -p6 -agCblue -msimple -q -t'Armageddon ruft: Teile mir mit, wenn Du in den Laden gebracht \
				werden willst!' \
				gag_tf_omb39%;\
			/def -p6 -agCblue -msimple -q -t'Der Teddy knuddelt Dich ein letztes Mal.' \
				gag_tf_omb40%;\
			/def -p8 -agCblue -msimple -q -t'[Klerus:Arkshat] Waer ich doch Chaot geworden! *seufz*' \
				gag_tf_omb41%;\
			/def -p8 -agCblue -mglob -q -t'\\\\[Karate:*\\\\] ab wann macht man denn SEHR GELUNGENE schlaege\\\\?' \
				gag_tf_omb42%;\
			/def -p8 -agCblue -mglob -q -t'\\\\[Karate:*\\\\] ich hasse es immer auf die karawane zu warten' \
				gag_tf_omb43%;\
			/def -p8 -agCblue -msimple -q -t'[Karate:Funakoshi] In meiner Gilde sind nur lahme Kruecken. *seufz*' \
				gag_tf_omb44%;\
			/def -p8 -agCblue -mglob -q -t'\\\\[Karate:*\\\\] hat ja riesig viele karatekas heute :)' \
				gag_tf_omb45%;\
			/def -p8 -agCblue -mglob -q -t'\\\\[Karate:*\\\\] gibts auch waffen fuer karatekas\\\\?' \
				gag_tf_omb46%;\
			/def -p8 -agCblue -mglob -q -t'\\\\[Karate:*\\\\] warum sind karate-anfaenger so schwach\\\\?\\\\?\\\\?' \
				gag_tf_omb47%;\
			/def -p8 -agCblue -msimple -q -t'[Trves:Srabi sucht Ausbilder fuer 82 Kills]' \
			        gag_tf_omb48%;\
			/def -p8 -agCblue -msimple -q -t'[Trves:Elberet] verschenke: 2 paar Dornenstiefel' \
			        gag_tf_omb49%;\
			/def -p8 -agCblue -mglob -q -t'\\\\[Trves:*\\\\] gibts ne waffe, die magischen schaden macht \\\\?' \
				gag_tf_omb50%;\
			/def -p8 -agCblue -mglob -q -t'\\\\[Trves:*\\\\] kennt jemand ein gutes messer fuer waffenschlag\\\\?' \
				gag_tf_omb51%;\
			/def -p8 -agCblue -mglob -q -t'\\\\[Trves:*\\\\] was geht eigentlich als biellkyll\? Axte oder sowas\\\\?' \
				gag_tf_omb52%;\
			/def -p8 -agCblue -mglob -q -t'\\\\[Klerus:Brieseltrim\\\\]*' gag_tf_omb53%;\
			/def -p8 -agCblue -mglob -q -t'\\\\[Zauberer:*\\\\] Begegne Andy nie..gibts da nen Trick\\\\?' gag_tf_omb54%;\
			/def -p8 -agCblue -mglob -q -t'\\\\[Zauberer:*\\\\] was kann alles passieren, wenn \\'irgendwas\\' passiert ist\\\\?' gag_tf_omb55%;\
			/def -p8 -agCblue -mglob -q -t'\\\\[Zauberer:*\\\\] Irx, ich hab Paranoia :(. Kommt das auch vom \
				zaubern ueben\\\\?' gag_tf_omb56%;\
			/def -p8 -agCblue -mglob -q -t'\\\\[Zauberer:*\\\\] hat einer zufaellig ne Hose von Phlyaken ueber \\\\?' \
				gag_tf_omb57%;\
			/def -p8 -agCblue -msimple -q -t'[Zauberer:Llystrathe] Lauter Wurstzauberer anwesend! *seufz*' \
				gag_tf_omb58%;\
			/def -p8 -agCblue -msimple -q -t'[Abenteuer:Orktoeter seufzt: "Frueher war alles anders..." :)]' \
				gag_tf_omb59%;\
			/def -p8 -agCblue -mglob -q -t'\\\\[Allgemein:*\\\\] whahh der Phylaken hat mich huepf-verzaubert :((' \
				gag_tf_omb60%;\
			/def -p8 -agCblue -mglob -q -t'\\\\[Allgemein:*\\\\] hat jemand zufaellig einen pfirsich uebrig\\\\?' \
				gag_tf_omb61%;\
			/def -p8 -agCblue -mglob -q -t'\\\\[Allgemein:*\\\\] jmd. nen gruennen oder weissen kristall zuviel\\\\?' \
				gag_tf_omb62%;\
			/def -p8 -agCblue -mglob -q -t'\\\\[Allgemein:*\\\\] braucht jemand grad n bss \\\\?' gag_tf_omb63%;\
			/def -p8 -agCblue -mglob -q -t'\\\\[Allgemein:*\\\\] brauch wer ne drachenschuppe\\\\?' gag_tf_omb64%;\
			/def -p8 -agCblue -mglob -q -t'\\\\[Abenteuer:*\\\\] No Flooding please :)' gag_tf_omb65%;\
			/def -p8 -agCblue -mglob -q -t'\\\\[Abenteuer:*\\\\] wo im gebirge kann man ginseng finden\\\\?\\\\?\\\\?' \
				gag_tf_omb66%;\
			/def -p8 -agCblue -mglob -q -t'\\\\[Abenteuer:*\\\\] warum finde ich im badezimmer 1. Etage *' \
				gag_tf_omb67 = \
				/def -p8 -agCblue -mglob -1 -q -t'\\\\\\\\[Abenteuer:*\\\\\\\\] * da war doch immer eins \\\\\\\\?' \
					gag_tf_omb67a%;\
			/def -p8 -agCblue -mglob -q -t'\\\\[Klerus:*\\\\] kann mir mal bitte einer mein schwert entfluchen,*' \
				gag_tf_omb68 = \
				/def -p8 -agCblue -mglob -1 -q -t'\\\\\\\\[Klerus:*\\\\\\\\] * mehr los' \
					gag_tf_omb68a%;\
			/def -p8 -agCblue -msimple -q -t'[Klerus:Srabi] ich haenge in den katakomben und koennte hilfe gebrauchen,waere' \
				gag_tf_omb69 = \
				/def -p8 -agCblue -msimple -1 -q -t'[Klerus:Srabi] jemand so nett?' \
					gag_tf_omb69a%;\
			/def -p8 -agCblue -mglob -q -t'\\\\[Zauberer:*\\\\] in welcher gegend finde ich eigentlich haende*' \
				gag_tf_omb70 = \
				/def -p8 -agCblue -mglob -q -t'*' gag_tf_omb70a%%;\
				/def -1 -p9 -agCblue -mglob -q -t'\\\\\\\\[Zauberer:*\\\\\\\\]*kaufen\\\\\\\\?' \
					gag_tf_omb70b = /undef gag_tf_omb70a%;\
			/def -p8 -agCblue -mglob -q -t'\\\\[Abenteuer:*\\\\] gibt es im daemonenreich eine moeglichkeit,*' \
				gag_tf_omb71 = \
				/def -p8 -agCblue -mglob -1 -q -t'\\\\\\\\[Abenteuer:*\\\\\\\\] * ohne es zu killen\\\\\\\\?' \
					gag_tf_omb71a%;\
			/echo -aCgreen Ombatis nervt nun nicht mehr so sehr.%;\
    	/else \
			/echo -aCred Aber Du ignorierst Ombatis doch schon!%;\
	    /endif%;\
	/elseif (({1} =~ 'off')|({1} =~ 'aus')) \
		/for i 1 71 /if /ismacro gag_tf_omb%%i%%; /then /undef gag_tf_omb%%i%%; /endif%;\
	/if ({1} =~ 'off') /echo -aCgreen Okay, Du kannst Ombatis jetzt \
		wieder live erleben (warum auch immer) ...%;\ /endif%;\
	/else \
		/echo Syntax: /gag_ombatis <on/off>%;\
   	/endif


;;; Die Brille ist ja ganz nett, aber diese dumme Ausgabe stoert:

/def -p1 -agCblue -msimple -q -t'Du schielst durch die Brille und siehst:' \
    gag_tf_item1


;;; Die Meldung vom Wecker reicht auch einmal

/def -p1 -mregexp -q -t'^([A-Z][a-z]+)s\'? Wecker klingelt bei Dir.*$' gag_tf_weck1=\
	/def -p2 -aggCblue -mregexp -q -t'^%P1s\\'? Wecker klingelt \
		bei Dir.*$$' gag_tf_weck1a%;\
	/repeat -20 1 /purge gag_tf_weck1a

/def -p1 -mregexp -q -t'^([A-Z][a-z]+) piept Dich an\\.$' gag_tf_weck2=\
	/def -p2 -aggCblue -mregexp -q -t'^%P1 piept Dich an\\\\.$$' gag_tf_weck2a%;\
	/repeat -20 1 /purge gag_tf_weck2a



;;; Raummeldungen
;;; Irritierende Echos in Drakonien

/def -p6 -agCblue -msimple -q -t'Jemand teilt Dir mit: Schoene Gegend, nicht \
	wahr?' gag_tf_drak1

;;; Die neue Feuerebene scrollt auch so schon genug

/def -p1 -agCblue -msimple -q -t'Der Magmagigant schreit auf.' gag_tf_fe1
/def -p1 -agCblue -msimple -q -t'Der Feuerelementar windet sich in Qualen.' \
	gag_tf_fe2
/def -p1 -agCblue -msimple -q -t'Der Feuerelementar zeigt sich unbeeindruckt.' \
	gag_tf_fe3
/def -p1 -agCblue -mglob -q -t'Der Brutzler ist {entsetzt.|unbeeindruckt.}' \
    gag_tf_fe4

;;; Wenn jemand in ne Grube faellt interessiert das keinen
/def -p1 -agCblue -mglob -q -t'* ruft: !&$#\'!! Grube!' gag_tf_grube


;;; im Kampf An- und Ausziehen sowie Zuecken und Wegstecken anderer gaggen.

/def -p0 -E(kampf) -agCblue -q -mglob -q -t'* zieht * {aus.|an.}' gag_tf_wear
/def -p0 -E(kampf) -agCblue -q -mglob -q -t'* steckt * zurueck.' gag_tf_unwield
/def -p0 -E(kampf) -agCblue -q -mglob -q -t'* zueckt *.' gag_tf_wield
