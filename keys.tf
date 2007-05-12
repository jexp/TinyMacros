; $Log: keys.tf,v $
; Revision 1.17  2002/12/06 15:50:31  mh14
; autoupdate von keypad belegungen war noch kaputt
;
; Revision 1.16  2002/12/06 15:18:42  mh14
; konfigurierbare keypad tastencodes erweitert um * / , sowie eigene belegungen der keypadtasten möglich
;
; Revision 1.15  2002/09/28 12:59:26  mh14
; alte liste wird erkannt und ueberschrieben
;
; Revision 1.14  2002/09/28 00:44:15  mh14
; Update bei /configure, Fehler beim initialem Laden der Listen
;
; Revision 1.13  2002/09/27 23:51:07  mh14
; Keypad konfigurierbar, kann sein, dass die Liste keys_bindings.list mal geloescht werden vorm tf-Start
;
; Revision 1.12  2002/09/16 09:13:03  mh14
; tastencodes jetzt konfigurierbar, werden aus liste gelesen, defaulteinstellungen fuer linux/windows
;
; Revision 1.11  2002/09/14 21:07:57  mh14
; Editiermodus mit Alt-E
;
; Revision 1.10  2002/08/14 13:18:53  mh14
; Anzeigefarben konfigurierbar
;
; Revision 1.9  2002/04/16 12:14:38  mh14
; config system
;
; Revision 1.8  2002/01/29 17:37:39  olm
; Ab sofort wird ein Hook bei Wechsel der Belegung ausgefuehrt:
; keys_changeto_x (x=1-9)
;
; Revision 1.7  2001/12/09 00:14:26  mh14
; bei setkey,setdesc wird ggf. die liste zuerst erzeugt
;
; Revision 1.6  2001/11/05 15:25:27  nieten
; %tmp war globale Variable
;
; Revision 1.5  2001/10/10 22:10:21  mh14
; Default-Konfiguration in .tf Files verschoben
;
; Revision 1.4  2001/09/30 01:21:31  mh14
;  bug in /set_mode behoben
;
; Revision 1.3  2001/09/12 22:27:23  mh14
; Refaktoriert,
; mehrfaches Neubinden der Funktionstasten ist raus
; Konfiguration in keys.def keys.cfg und customize.cfg
; /line in util.echo.tf verschoben
; etwas Doku geschrieben
;
; Revision 1.2  2001/09/12 12:04:42  olm
; Warnungen beim Belegungswechsel beseitigt
;
; Revision 1.1  2001/09/12 11:38:44  olm
; Mehrfach-Tastenbelegung

/set keys_tf_version $Id: keys.tf,v 1.17 2002/12/06 15:50:31 mh14 Exp $
/set keys_tf_author=Olli@mg.mud.de
/set keys_tf_requires=lists.tf
/set keys_tf_desc Mehrfach-Tastenbelegungen

; ********************* BEGIN CONFIG ********************
/add_to_hook connect /load_config -c keys

/if (key_mode=~"") \
	/set key_mode=1%;\
	/addsave key_mode%;\
	/endif

/addh info Flag fuer Display Mode (Anzeigen der Tastenbelegung bei Tastendruck, statt Ausfuehrung)
/addh syn 0 aus 1 ein
/addh keys_dmode var

/set keys_dmode=0

/addh info Flag fuer Editiermodus (Anzeigen aktuelle Belegung, Eingabe neues Kommando & Beschreibung)
/addh keys_edit_mode var

/set keys_edit_mode=0

/addh info wenn diese Variable auf 1 gesetzt ist, wird die Liste bei jeder Aenderung \
gespeichert.
/addh list tasten
/addh tasten_slist var
/set tasten_slist=1

/def -b^[d b_toggle_dmode = /toggle_dmode

/def -b^[e b_toggle_edit_mode = /toggle keys_edit_mode%;/echo -p EditierModus @{BCred}$[keys_edit_mode ? "EIN" : "AUS"]@{x}-geschaltet!

/cfg_info keys Tastenbelegung

/cfg_info keys farbe Anzeigefarben
/cfg_info keys farbe TASTEN F-Tastenfarbe
/cfg_set keys farbe TASTEN Cyellow
/cfg_info keys farbe TEXT Textfarbe
/cfg_set keys farbe TEXT n
/cfg_info keys farbe EBENE_NR EbenenNummer
/cfg_set keys farbe EBENE_NR Cyellow,B
/cfg_info keys farbe EBENE_NAME EbenenName
/cfg_set keys farbe EBENE_NAME n

/cfg_info keys tasten Tastenliste

/addh info Speicherort siehe /hilfe custom (z.B. -c Mudverzeichnis, -c -p Mud/Spieler, garnix im TinyMacros Verzeichnis usw.)
/addh default -c Mudverzeichnis
/addh keys_list_location cfg
/cfg_info keys tasten LOCATION Speicherort:keys_list_location
/set_var keys_list_location=-c

/cfg_info keys tasten NAME Listenname:keys_list_name
/set_var keys_list_name=tasten

/addh info Taste mit Keycodes fuer Keybindings:@{N}\
0-9,+,-,*,/ sind fuer den Nummernblock@{N}\
f1-f12 fuer die Funktionstasten@{N}\
esc0-esc9 fuer die Ebenen
/addh update /keys_set_bindings
/addh keys_bindings cfg

/cfg_info keys tasten TASTENCODES Tastencodes:keys_bindings

/addh info Belegungen für Keypad@{N}\
0-9,+,-,*,/ sind fuer den Nummernblock mit Makros belegbar@{N}\
/addh update /keys_set_keypad
/addh keypad_keys cfg

/cfg_info keys tasten KEYPAD_MUD_MAKROS Keypad_Belegungen:keypad_keys

; ********************* END CONFIG **********************

/def keys_get_key = /getvalueof %keys_list_name %*
/def keys_set_key = /uaddtolist %keys_list_name %*
/def keys_del_key = /delallkeysandvalues %keys_list_name %*
/def keys_get_del_key = /getdvalueof %keys_list_name %*
/def keys_load_list = /loadnamedlist -q keys
/def keys_save_list = /savenamedlist -q keys
/def keys_create_new = /createnewlist %keys_list_name

/addh info \
Die Liste tasten enthaelt alle Tastenbelegungen. Sie ist sozusagen die zentrale Datenbank.
/addh tasten list

/addh info \
Intern. Fuegt eine Belegung ohne weitere Ueberpruefung in die Liste ein.
/addh list tasten
/addh see setkey
/addh syn /addlist modus nummer befehl kommentar@{N}\
alternativ Befehl und Kommentar mit Leerzeichen:@{N}\
/addlist modus nummer befehl parameter&kommentar text
/addh addlist mak

/def addlist = \
        /keys_create_new%;\
	/keys_del_key b%1f%2c%;\
	/keys_del_key b%1f%2d%;\
	/let off=$[strchr({-2},"&")]%;\
	/if (off>-1) \
	   /keys_set_key b%1f%2c $[substr({-2},0,off)]%;\
	   /keys_set_key b%1f%2d $[substr({-2},off+1)]%;\
	/else \
	   /keys_set_key b%1f%2c %3%;\
	   /keys_set_key b%1f%2d %-3%;\
	/endif%;

/addh info \
legt eine Tastenbelegung fest.
/addh syn /setkey Modus Taste Befehl Beschreibung@{N}\
Befehl und/oder Beschreibung mit Leerzeichen@{N}\
/setkey Modus Taste Befehl&Beschreibung
/addh ex /setkey 2 5 i Inventory@{N}\
/setkey 2 5 zuecke %waffe&Waffe zuecken
/addh list tasten
/addh setkey mak
/defh setkey = \
	/if ({#}<3) \
           /echo Syntax: /setkey Modus Taste Befehl Beschreibung%;\
	/else \
	   /addlist %*%;\
	   /if (getdesc({1})=~"") \
	      /setdesc %1 unbenannt%;\
           /endif%;\
	   /if (tasten_slist==1) \
		 /keys_save_list%;\
	    /endif%;\
	/endif%;

/addh info Intern. Waehlt die letzte Belegung, in der Tasten eingetragen sind.
/addh syn /selectlastmode
/addh selectlastmode mak
/defh selectlastmode = \
	/let i=10%;\
	/while (--i>0) \
	  /if (getdesc(i)!~"") \
	      /set_mode %i%;\
	      /return%;\
	  /endif%;\
	/done%;\
	/echo # Keine Tastenbelegungen mehr vorhanden!%;\

/addh info \
loescht eine eingetragene Tastenbelegung wieder.
/addh syn /delkey Belegung Taste
/addh list tasten
/addh delkey mak
/defh delkey = \
	/if ({2}=~"") \
		/echo Syntax: /delkey Modus Taste%;\
		/else \
		/keys_del_key b%1f%2c%;\
		/keys_del_key b%1f%2d%;\
		/let tmp 0%;\
	        /let i=0%;\
	        /while (++i<=12) \
	           /if (gettcmd(i)!~"") \
	              /let tmp 1%;\
	           /endif%;\
		/done%;\
		/if (tmp==0) \
			/keys_del_key b%1desc%;\
			/selectlastmode%;\
			/endif%;\
		/if (tasten_slist==1) /keys_save_list%; /endif%;\
		/endif%;

/addh info \
legt eine Beschreibung fuer einen der neun Modi fest.
/addh syn /setdesc Modus Beschreibung
/addh setdesc mak
/def setdesc = \
	/if ({2}=~"") \
		/echo Syntax: /setdesc Modus Beschreibung%;\
		/else \
		/keys_create_new%;\
		/keys_del_key b%1desc%;\
		/keys_set_key b%1desc %-1%;\
		/if (tasten_slist==1) \
		   /keys_save_list%;\
		/endif%;\
	/endif%;

/addh info \
liefert die Beschreibung eines Modus zurueck.
/addh syn /getdesc Modus
/addh return Beschreibung
/addh getdesc mak
/defh getdesc = \
	/if ({1}=~"") \
		/echo Syntax: /getdesc Modus%;\
		/else \
		/keys_get_key b%1desc%;\
		/return (value=~error)?"":value%;\
		/endif%;

/addh info \
liefert die Beschreibung fuer eine Tastenbelegung zurueck.
/addh syn /gettdesc Modus Taste
/addh return Beschreibung
/addh gettdesc mak
/defh gettdesc = \
	/if ({2}=~"") \
		/echo Syntax: /gettdesc Modus Taste%;\
	/else \
		/keys_get_key b%1f%2d%;\
		/return (value=~error)?"":value%;\
	/endif%;

/addh info \
liefert den Befehl fuer eine Tastenbelegung zurueck.
/addh syn /gettcmd Modus Taste
/addh return Beschreibung
/addh gettcmd mak
/defh gettcmd = \
	/if ({2}=~"") \
		/echo Syntax: /gettcmd Modus Taste%;\
		/else \
		/keys_get_key b%1f%2c%;\
		/if (value=~{error}) /return%;\
		/endif%;\
		/return value%;\
		/endif%;

/addh info \
Funktion die bei Tastendruck aufgerufen wird, wenn Display Modus (%keys_dmode) eingeschaltet ist wird die Belegung dargestellt, ansonsten der Befehl ausgefuehrt
/addh syn /key_press belegung key
/addh see keys_dmode
/addh key_press mak

/def key_press = \
	/if (keys_dmode==1) \
		/echo Mode %key_mode: F%1: $[gettcmd(key_mode,{1})] ($[gettdesc(key_mode,{1})]) %;\
		/elseif (keys_edit_mode==1) \
		/echo aktuelle Belegung: Mode %key_mode: F%1: $[gettcmd(key_mode,{1})] ($[gettdesc(key_mode,{1})]) %;\
		  /let key_cmd=$[shread("Neues Kommando: ",gettcmd(key_mode,{1}))]%;\
		  /let key_desc=$[shread("Neue Beschreibung: ",gettdesc(key_mode,{1}))]%;\
		  /let key_ok_string=Neue Belegung: Mode %key_mode: F%1: %key_cmd (%key_desc) Ok? (j / n):%;\
		  /if (shread(key_ok_string,"j")=/"j") \
		  /setkey %key_mode %1 %key_cmd&%key_desc%;\
		  /endif%;\
		  /b_toggle_edit_mode%;\
		/else \
		/eval -s0 $[gettcmd(key_mode,{1})]%;\
		/endif

/def toggle_dmode = \
	/toggle keys_dmode%;\
	/echo Display-Mode $[keys_dmode?"EIN":"AUS"]geschaltet.%;\

/def display_mode = \
	/if (keys_dmode==1) \
		/line%;\
		/echo !!! DISPLAY-MODE !!!%;\
		/endif%;\
	/display_keys%; \
	/display_all_modes%;\



/def display_all_modes = \
	/let i=0%;\
	/line (setzen mit Esc-x)%; \
	/let disp=%;\
	/while (++i<=9) \
	  /if (getdesc(i)!~"") \
	    /test disp:=strcat(disp,"@{x",CFG_KEYS_FARBE_EBENE_NR,"}",i,"@{x",CFG_KEYS_FARBE_EBENE_NAME,"}",pad(substr(getdesc(i),0,20),-20),"@{x}")%;\
	  /endif%;\
	  /if (strlen(disp)>columns()) \
	     /echo -p %disp%;\
	     /let disp=%;\
	  /endif%;\
	/done%;\
	/if (disp!~"") \
	   /echo -p %disp%;\
	/endif%;\
	/line%;

/def display_keys = \
	/line $[getdesc(key_mode)]%;\
	/let i=0%;\
	/let dispf1=%;\
	/let dispf2=%;\
	/let disp1=%;\
	/let disp2=%;\
	/let columns=$[(columns()-1)/12]%;\
	/while (++i<=12) \
	   /if (mod(i,2)==1) \
	     /test dispf1:=strcat(dispf1,"F",pad(i,-2*columns+1))%;\
	     /test disp1:=strcat(disp1,pad(substr(gettdesc(key_mode,i),0,columns*2-1),-columns*2))%;\
	   /else \
	     /test dispf2:=strcat(dispf2,"F",pad(i,-2*columns+1))%;\
	     /test disp2:=strcat(disp2,pad(substr(gettdesc(key_mode,i),0,columns*2-1),-columns*2))%;\
	   /endif%;\
	/done%;\
	/test disp2:=strcat(pad(" ",columns/2),disp2)%;\
	/test dispf2:=strcat(pad(" ",columns/2),dispf2)%;\
	/echo -p @{%CFG_KEYS_FARBE_TASTEN}%dispf1%;\
	/echo -p @{%CFG_KEYS_FARBE_TEXT}%disp1%;\
	/echo -p @{%CFG_KEYS_FARBE_TASTEN}%dispf2%;\
	/echo -p @{%CFG_KEYS_FARBE_TEXT}%disp2%;

/def set_mode = \
	/if (getdesc({1})=~"") \
		/echo # Keine Tastenbelegung!%;\
		/return%;\
		/endif%;\
	/set key_mode=%1%;\
	/eval_hook keys_changeto_%1%;\
;	/key_bind%;\
	/echo # $[getdesc({1})] - Hilfe mit Esc-0!%;

/addh info Setzt die Standardkeybindings (ESC 0-9 und F1-F12) fuer keys
/addh keys_set_bindings mak

/def keys_default_bindings = \
     /info info Creating default keybindings%;\
     /createlist keys_bindings%;\
     /addtolist keys_bindings 0 ^[Op%;\
     /addtolist keys_bindings 1 ^[Oq%;\
     /addtolist keys_bindings 2 ^[Or%;\
     /addtolist keys_bindings 3 ^[Os%;\
     /addtolist keys_bindings 4 ^[Ot%;\
     /addtolist keys_bindings 5 ^[Ou%;\
     /addtolist keys_bindings 6 ^[Ov%;\
     /addtolist keys_bindings 7 ^[Ow%;\
     /addtolist keys_bindings 8 ^[Ox%;\
     /addtolist keys_bindings 9 ^[Oy%;\
     /addtolist keys_bindings + ^[Ok%;\
     /addtolist keys_bindings - ^[Om%;\
     /addtolist keys_bindings , ^[On%;\
     /addtolist keys_bindings * ^[Oj%;\
     /addtolist keys_bindings / ^[Oo%;\
     /addtolist keys_bindings esc0 ^[0%;\
     /addtolist keys_bindings esc1 ^[1%;\
     /addtolist keys_bindings esc2 ^[2%;\
     /addtolist keys_bindings esc3 ^[3%;\
     /addtolist keys_bindings esc4 ^[4%;\
     /addtolist keys_bindings esc5 ^[5%;\
     /addtolist keys_bindings esc6 ^[6%;\
     /addtolist keys_bindings esc7 ^[7%;\
     /addtolist keys_bindings esc8 ^[8%;\
     /addtolist keys_bindings esc9 ^[9%;\
  /if (is_win()) \
     /addtolist keys_bindings f1 ^[[[A%;\
     /addtolist keys_bindings f2 ^[[[B%;\
     /addtolist keys_bindings f3 ^[[[C%;\
     /addtolist keys_bindings f4 ^[[[D%;\
     /addtolist keys_bindings f5 ^[[[E%;\
     /addtolist keys_bindings f6 ^[[17~%;\
     /addtolist keys_bindings f7 ^[[18~%;\
     /addtolist keys_bindings f8 ^[[19~%;\
     /addtolist keys_bindings f9 ^[[20~%;\
     /addtolist keys_bindings f10 ^[[21~%;\
     /addtolist keys_bindings f11 ^[[23~%;\
     /addtolist keys_bindings f12 ^[[24~%;\
  /else \
     /addtolist keys_bindings f1%;\
     /addtolist keys_bindings f2%;\
     /addtolist keys_bindings f3%;\
     /addtolist keys_bindings f4%;\
     /addtolist keys_bindings f5%;\
     /addtolist keys_bindings f6%;\
     /addtolist keys_bindings f7%;\
     /addtolist keys_bindings f8%;\
     /addtolist keys_bindings f9%;\
     /addtolist keys_bindings f10%;\
     /addtolist keys_bindings f11%;\
     /addtolist keys_bindings f12%;\
  /endif%;\
  /savelist keys_bindings%;

/def set_binding = \
     /getvalueof keys_bindings %1%;\
     /let binding=%?%;\
     /if (binding!~error & binding!~"") \
        /def -b'%binding' keys_tf_bind_%1 = %-1%;\
     /else \
        /def -B%1 keys_tf_bind_%1 = %-1%;\
     /endif%;\


/def keys_set_bindings = \
     /loadlist keys_bindings%;\
     /if (isList("keys_bindings")=~error | isEmptyList(keys_bindings) | getvalueof("keys_bindings","0")=~error) \
       /keys_default_bindings%;\
     /endif%;\
     /let i=0%;\
     /set_binding esc0 /display_mode%;\
     /while (++i<13) \
        /if (i<10) \
           /set_binding esc%i /set_mode %i%;\
	/endif%;\
	/set_binding f%i /key_press %i%;\
     /done%;\
     /keys_set_keypad%;\



/def keys_set_keypad = \
     /loadlist -c keypad_keys%;\
     /if (isList("keypad_keys")=~error | isEmptyList(keypad_keys) | getvalueof("keypad_keys","0")=~error) \
        /createlist keypad_keys%;\
	/addtolist keypad_keys 0 /i_vorw%;\
	/addtolist keypad_keys 1 /_sw%;\
	/addtolist keypad_keys 2 /_s%;\
	/addtolist keypad_keys 3 /_so%;\
	/addtolist keypad_keys 4 /_w%;\
	/addtolist keypad_keys 5 /_schaue%;\
	/addtolist keypad_keys 6 /_o%;\
	/addtolist keypad_keys 7 /_nw%;\
	/addtolist keypad_keys 8 /_n%;\
	/addtolist keypad_keys 9 /_no%;\
	/addtolist keypad_keys + /_ob%;\
	/addtolist keypad_keys - /_u%;\
     /endif%;\
     /foreach keypad_keys kv /set_binding
     
/add_to_hook first_connect /keys_set_keypad

/keys_set_bindings

/addh info \
@{N}Mehrfach-Tastenbelegungen.\
@{N}ermoeglicht, die F-Tasten mehrfach zu belegen, und durch einfache Tastenkombinationen \
zwischen den Belegungen hin- und herzuschalten.
/addh see setkey, delkey, setdesc, set_mode
/addh tut \
Hilfe zur Tastenbelegung gibt es mit Esc-0@{N}\
@{N}\
Die Funktionen@{N}\
Esc-0     zeigt die F-Tasten-Belegung im aktuellen Modus an@{N}\
Esc-<x>   wechselt auf Modus 1-9@{N}\
Esc-d     schaltet den Display-Modus an/aus. Im Display-Modus@{N}\
          werden nur Befehl und Beschreibung angezeigt.@{N}\
@{N}\
/setkey <b> <t> <befehl> <beschreibung>@{N}\
          setzt fuer die Taste F<t> im Modus <b> den Befehl <befehl>@{N}\
          Die Beschreibung wird auf <beschreibung> gesetzt.@{N}\
          Beispiel: /setkey 1 4 /ladestab Stab laden@{N}\
                    (wenn Modus 1 aktiv ist (Esc-1), dann bewirkt ein@{N}\
                     Druck auf F4, dass "/ladestab" ausgefuehrt wird.@{N}\
                     In der Uebersicht (Esc-0) wird "Stab laden" angezeigt.)@{N}\
          bisher nur Befehle aus einem Wort moeglich.@{N}\
@{N}\
/delkey <b> <t>@{N}\
          loescht den Befehl fuer die Taste F<t> im Modus <b>@{N}\
          Beispiel: /delkey 1 4@{N}\
                    (macht o.g. Beispiel rueckgaengig)@{N}\
@{N}\
/setdesc <b> <beschreibung>@{N}\
          setzt die Beschreibung fuer den Modus <b>.@{N}\
@{N}\
/set_mode <i>|<desc>@{N}\
          schaltet auf den Modus mit der Nummer i oder mit der@{N}\
          Beschreibung desc um (letzteres noch nicht implementiert!)

/addh var \
tasten_slist Wenn auf 1 gesetzt, wird die Liste bei jeder Aenderung gespeichert (default).

/addh_fileinfo
