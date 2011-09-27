;Raum-Untersuche-Hilfe V1.10 vom 2010-05-22
;Author: Khidar
;Dieses Makro wird sowohl unter der GPLv2 als auch unter
; der CCPL 3.0 (diese kann unter
; http://creativecommons.org/licenses/by/3.0/legalcode
; eingesehen werden) veroeffentlicht

;Benutzung:
;/newx beginnt das untersuchen eines raumes
;/endx beendet (auch vorlaeufig) das untersuchen eines raumes
; /endx kann man auch zum inaktivieren des suchens benutzen
; wenn /endx ausgefuehrt wurde, werden keine neuen woerter
; aus der mudausgabe extrahiert
;/contx macht mit dem untersuchen eines raumes weiter, dh aus der
; mudausgabe wird wieder extrahiert
;/statusx zeigt den status (zB wenn man einmal zu schnell F4 getippt hat
; und das letzte in die eingabezeile kopierte wort wissen moechte)
;/purgex entfernt alle verwendeten makros, d.h. das raumuntersuchesystem

;eingebunden in tinymacros (einfach mit /load):
;zweckmaessigerweise f-tasten-keybindings auf /newx, /endx, /contx,
; /statusx und /x_quotesearch anlegen (siehe doku zu tinymacros)
;als info: /x_quotesearch holt das naechste detail in die Eingabezeile

;nur wenn standalone:
;F4 holt das naechste stichwort in die eingabezeile (unten binding 
; entkommentieren und evtl anpassen)

;das ist /x <was> - wenn <was> schon im puffer war, gibts ne meldung
;/xx <was> untersucht, unabhaengig davon ob <was> schon im puffer ist
;zeilen, die mit [ (kanaele) oder * (neuer artikel in der mpa) anfangen,
; werden ignoriert
;es gibt eine meldung, wenn die erste zeile einer detailbeschreibung
; schon mal auftauchte, die beschreibung wird aber sicherheitshalber
; trotzdem nochmal durchsucht, das lesen kann man sich aber sparen
;die variable x_displaytime steuert die ausgabe der Zeitausschrift
; nach /x bzw /xx - prinzipbedingt ist das die eingestellte zeit
; bis eine sekunde kuerzer als eingestellt - genauer kann das tf nicht
;
;bei bedarf: aktiviere tastatur-logging mit /log -i <logfile>


;zu ueberspringende worte
/def x_skipsearch=/set x_skipsearch=das der die du dich dir er es \
  sowas ausgaenge ausgang \
  nord norden west westen ost osten sued sueden \
  nordost nordosten suedost suedosten \
  suedwest suedwesten nordwest nordwesten \
  von im in hier an dort tutszt blutdaemon
/x_skipsearch
;grundsuchworte, werden in jedem raum untersucht
;worte mit anfang ! werden ohne 'unt' ans mud geschickt
/def x_newsearch=/set x_newsearch=waende boden grund decke himmel \
  !schnuppere !lausche !grabe
/x_newsearch
;setze zeitanzeige nach /x bzw. /xx - 0 schaltet aus
/set x_displaytime=2

;Startwerte einsetzen+schau
/def newx=/set x_untaktiv=1%;/set x_tosearch=%x_newsearch%;\
  /set x_searched=%x_skipsearch%;/set x_linescheckcount=0%;\
  /set x_tempcheckcount=0%;/set x_tempcheckline=1%;schau

;suchen fortsetzen (zb wenn kampf dazwischenkam und man mit /endx
;ausschaltete)
/def contx=/set x_untaktiv=1%;/echo -aCred Zeilenauswertung eingeschaltet!

;untersuchung beenden
/def xaus=/endx
;untersuchung beenden
/def endx=/set x_untaktiv=0%;/echo -aCred Zeilenauswertung ausgeschaltet!

;status anzeigen
/def statusx=/echo Noch zu untersuchen: %x_tosearch%;\
  /echo -aCgreen Bereits untersucht: %x_searched%;\
  /echo Zeilenauswertestatus ist: %x_untaktiv%;\
  /echo Displaytime ist: %x_displaytime

;raumuntersuchesystem entfernen
/def purgex=/purge newx%;/purge contx%;/purge xaus%;/purge endx%;\
  /purge statusx%;/purge x_skipsearch%;/purge x_newsearch%;\
  /purge x_getsearchline%;/purge x_checkthatline%;\
  /purge x_checkskip%;/purge x_quotesearch%;/purge x_quotesearch2%;\
  /purge x%;/purge xx%;/purge x_removelist%;/purge x_addlistsr%;\
  /purge purgex

;hilfsmakro
/def x_ls = /eval /echo %%{%{1}}

;regexp auf ankommende zeile(n)
/def -mregexp -F -p80000 -t'^[^[*](.*)$' x_getsearchline=\
  /if /test $[(x_untaktiv+0)]%;/then \
    /set x_tempcheckcount=0%;\
    /set x_linealreadypresent=0%;\
    /if /test $[(x_tempcheckline)]%;/then \
      /while (x_tempcheckcount <= x_linescheckcount) \
        /set x_tmplinesx=$[($(/x_ls x_tmplines$[(x_tempcheckcount)]))]%;\
;	/echo -aCyellow %x_tmplinesx%;\
        /if (x_tmplinesx =~ {*}) \
          /echo -aCred Zeile war schon mal vorhanden...%;\
          /set x_linealreadypresent=1%;\
        /endif%;\
	/set x_tempcheckcount=$[(x_tempcheckcount+1)]%;\
      /done%;\
      /if /test $[(x_linealreadypresent-1)]%;/then \
        /set x_linescheckcount=$[(x_linescheckcount+1)]%;\
;/x_ls x_linescheckcount%;\
;        /echo -aCyellow %x_linescheckcount%;\
        /set x_tmplines$[(x_linescheckcount)]=$[({*})]%;\
;        /echo -aCyellow $[($(/x_ls x_tmplines$[(x_linescheckcount)]))]%;\
      /endif%;\
    /endif%;\
    /set x_checkline=%{*}%;\
    /x_checkthatline %x_checkline%;\
    /set x_tempcheckline=0%;\
  /endif
;auseinandernehmen der ankommenden zeile
;solange parameter vorhanden, wenn gross anfangend,
; noch nicht in einer der suchlisten enthalten
;auskommentiert: kleingeschriebenes wort an quellsuchliste davor-/anhaengen
; random wegen moeglicher scripttests
/def x_checkthatline=\
  /while /test $[({#})]%;/do \
    /if (regmatch('([A-Z]+[a-z]+)[^a-z]*',{1})) \
      /set x_tempexpr=$[tolower({P1})]%;\
      /set x_checkskip=0%;\
      /x_checkskip %x_tosearch%;\
      /x_checkskip %x_searched%;\
      /if /test $[(!x_checkskip+0)]%;/then \
;        /if ((rand(15))>0) \
          /set x_tosearch=%x_tempexpr %x_tosearch%;\
;        /else \
;          /set x_tosearch=%x_tosearch %x_tempexpr%;\
;        /endif%;\
      /endif%;\
    /endif%;\
    /shift%;\
  /done
;  /echo %x_tosearch

;pruefung auf enthaltensein in der uebergebenen liste
/def x_checkskip=\
  /while /test $[({#}&!x_checkskip)]%;/do \
    /if /test $[(x_tempexpr=~{1})]%;/then \
      /set x_checkskip=1%;\
    /endif%;\
    /shift%;\
  /done

;Keybinding nur entkommentieren, wenn es nicht mit den TinyMacros, sondern
; standalone verwendet wird
;bindkey auf: naechsten ausdruck in tastaturpuffer kopieren
;F4 triggers
;/def -b'^[[[D' x_quotesearch3=/x_quotesearch

;ausdruck aus quellliste entfernen und in zielliste eintragen
/def x_quotesearch=\
  /x_quotesearch2 %x_tosearch
/def x_quotesearch2=\
  /grab /x %{1}%;\
  /set x_temp2expr=%{1}%;\
  /set x_tempexpr=%{1}%;\
  /x_removelist %x_tosearch%;\
  /x_addlistsr %x_searched

/def xx=\
  /set x_tempexpr=%{1}%;\
  /x_removelist %x_tosearch%;\
  /x_addlistsr %x_searched%;\
  /if (!x_untaktiv+0) \
    /echo -ahCgreen Zeilenauswertung ist nicht aktiv.%;\
  /endif%;\
  /set x_tempexpr=%{*}%;\
;  /if (!x_containedexpr+0) \
    /if /test $[(x_tempexpr =/ "!*")]%;/then \
      /test regmatch('!(.*)', x_tempexpr)%;\
      /send %{P1}%;\
      /else \
      /set x_tempcheckline=1%;\
      /send unt %x_tempexpr%;\
    /endif%;\
    /if (x_displaytime+0) \
      /repeat -%x_displaytime 1 /echo \
        -aCcyan %x_displaytime Sekunden sind um.%;\
    /endif%;\
;    /else \
;    /echo -aCred %x_tempexpr wurde schon untersucht.%;\
;  /endif

/def x=\
  /set x_tempexpr=%{1}%;\
  /x_removelist %x_tosearch%;\
  /x_addlistsr %x_searched%;\
  /if (!x_untaktiv+0) \
    /echo -ahCgreen Zeilenauswertung ist nicht aktiv.%;\
  /endif%;\
;  /set x_tempexpr=%{*}%;\
  /if /test $[(x_tempexpr=~x_temp2expr)]%;/then \
    /set x_tempexpr=%{*}%;\
    /if /test $[(x_tempexpr =/ "!*")]%;/then \
      /test regmatch('!(.*)', x_tempexpr)%;\
      /send %{P1}%;\
      /else \
      /set x_tempcheckline=1%;\
      /send unt %x_tempexpr%;\
    /endif%;\
    /if (x_displaytime+0) \
      /repeat -%x_displaytime 1 /echo \
        -aCcyan %x_displaytime Sekunden sind um.%;\
    /endif%;\
    /else \
    /set x_tempexpr=%{*}%;\
    /if (!x_containedexpr+0) \
      /if /test $[(x_tempexpr =/ "!*")]%;/then \
        /test regmatch('!(.*)', x_tempexpr)%;\
        /send %{P1}%;\
        /else \
        /set x_tempcheckline=1%;\
        /send unt %x_tempexpr%;\
      /endif%;\
      /if (x_displaytime+0) \
        /repeat -%x_displaytime 1 /echo \
          -aCcyan %x_displaytime Sekunden sind um.%;\
      /endif%;\
      /else \
      /echo -aCred %x_tempexpr wurde schon untersucht.%;\
    /endif%;\
  /endif

/def x_removelist=\
  /set x_tosearch=\0x20%;\
  /while /test $[({#})]%;/do \
    /if /test $[(x_tempexpr!~{1})]%;/then \
      /set x_tosearch=%x_tosearch %{1}%;\
    /endif%;\
    /shift%;\
  /done

/def x_addlistsr=\
  /set x_containedexpr=0%;\
  /while /test $[({#}&!(x_containedexpr+0))]%;/do \
    /if /test $[(x_tempexpr=~{1})]%;/then \
      /set x_containedexpr=1%;\
    /endif%;\
    /shift%;\
  /done%;\
  /if /test $[(!(x_containedexpr+0))]%;/then \
    /set x_searched=%x_tempexpr %x_searched%;\
  /endif
