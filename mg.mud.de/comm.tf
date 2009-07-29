; $Log: comm.tf,v $
; Revision 1.93  2003/08/25 13:03:28  nieten
; remote-Trigger etwas sicherer gemacht
;
; Revision 1.92  2003/03/14 14:00:54  nieten
; Spieler Geist buggt nun nicht mehr auf -Moerder rum
;
; Revision 1.91  2002/11/19 18:25:29  nieten
; weitere Anpassung an 256 Farben
;
; Revision 1.90  2002/11/19 17:12:15  nieten
; an 256-Farben-Patch angepasst (Attribut n -> x)
;
; Revision 1.89  2002/10/23 17:38:29  nieten
; keine Piepser durch %comm_beep_teilemit bei eigenem tm/frufe
;
; Revision 1.88  2002/10/18 19:12:35  nieten
; kein Problem mit lokal/global bei %window_options mehr
;
; Revision 1.87  2002/10/18 19:09:50  nieten
; ausgehende intermud-tm's korrigiert
;
; Revision 1.86  2002/10/18 19:02:32  nieten
; weitere Parameter fuer das Logfenster moeglich
;
; Revision 1.85  2002/10/16 16:33:44  nieten
; Froesche sind keine NPCs mehr
;
; Revision 1.84  2002/10/11 21:46:29  nieten
; Bug bei mehrzeiligen Ebenen-Emotes raus
;
; Revision 1.83  2002/10/07 22:48:24  nieten
; Auch Mudnamen mit 'ungewoehnlichen' Zeichen werden nun bei tm erkannt.
;
; Revision 1.82  2002/10/07 22:29:27  nieten
; eigenen intermud-tms beruecksichtigt
;
; Revision 1.81  2002/10/01 12:35:41  nieten
; Matrixkreis und Teamrufe erscheinen nun im Kommunikationsfenster (wo sie hingehoeren), nicht mehr im Ebenenfenster.
;
; Revision 1.80  2002/09/24 14:12:24  nieten
; Bugfix fuer Feindschaftsband
;
; Revision 1.79  2002/09/24 13:57:14  nieten
; - 'Jemand' ist kein NPC mehr.
; - Feindschaftsband (hoffentlich) eingebaut.
;
; Revision 1.78  2002/09/23 17:22:59  nieten
; Prioritaet fuer Matrix-Trigger angepasst
;
; Revision 1.77  2002/09/23 17:07:16  nieten
; wieder mal remote-Erkennung debuggt
;
; Revision 1.76  2002/09/20 13:06:48  nieten
; remote-Erkennung verbessert
;
; Revision 1.75  2002/09/19 21:03:52  nieten
; tm's von Gaesten und aus anderen Muds werden ebenfalls erkannt
;
; Revision 1.74  2002/09/19 17:34:17  nieten
; - Bessere Satzende-Erkennung (fuer Folgezeilen)
; - /comm_t_remote2 gibt auch Nicht-remotes aus (huestel)
;
; Revision 1.73  2002/09/17 08:44:54  mh14
; comm_lives war einmal global gesetzt
;
; Revision 1.72  2002/09/16 18:21:57  nieten
; in den Logfiles sollten keine Attribute mehr auftauchen
;
; Revision 1.71  2002/09/15 14:11:16  mh14
; (bla) teilt dir mit: , geht jetzt wieder?
;
; Revision 1.70  2002/09/14 19:42:03  mh14
; *seufz* bs-teilemit_von/an nochmal repariert, ganz alte version mit /trigger, ausserdem konfigurierbar jetzt die praefixe fuer die mitteilungsarten
;
; Revision 1.69  2002/09/14 19:05:31  mh14
; bs_teilemit_von/an wird wieder richtig hier definiert, da sonst die version aus der crypt.tf benutzt wurde, auch wenn die comm.tf geladen war
;
; Revision 1.68  2002/09/13 21:06:50  nieten
; NPC-Erkennung sollte wieder funktionieren (%comm_last_partner(_living) sollte
; *nur* von /comm_check_living gesetzt werden)
;
; Revision 1.67  2002/09/13 18:04:45  mh14
; bs_teilemit_von/an wird jetzt nur noch bei bedarf definiert, comm_format_tm schaut jetzt nach ob parameter gesetzt sind
;
; Revision 1.66  2002/09/11 16:41:39  nieten
; kein Faerben/Loggen innerhalb von MPA-Artikeln/Mails mehr
;
; Revision 1.65  2002/09/10 14:59:41  nieten
; - Doppel-tms sollten jetzt wirklich klappen
;
; Revision 1.64  2002/09/10 14:20:44  nieten
; - bessere remote-Erkennung
; - Faelle wie "X sagt: Y teilt Dir mit: bla" sollten jetzt korrekt erkannt
;   werden
;
; Revision 1.63  2002/09/09 08:18:50  mh14
; ankommende frufe werden jetzt auch mit Freund(in) angezeigt
;
; Revision 1.62  2002/09/08 17:17:31  mh14
; kann jetzt auch eigenen Formatierung fuer Mitteilungstexte (tm,stm,frufe) verarbeiten, ist konfigurierbar
;
; Revision 1.61  2002/09/08 14:14:47  mh14
; name des sagenden als dritter parameter der comm_ebenen_list
;
; Revision 1.60  2002/08/27 13:55:25  nieten
; Logging und Faerben von CTMs sollte jetzt klappen
;
; Revision 1.59  2002/08/16 18:08:26  nieten
; remote-Erkennung sollte jetzt besser klappen
;
; Revision 1.58  2002/08/07 20:00:49  nieten
; remoten klappt jetzt auch, wenn %p_name Gross/Kleinschreibung nicht beruecksichtigt
;
; Revision 1.57  2002/08/07 19:43:37  nieten
; remoten sollte jetzt besser klappen
;
; Revision 1.56  2002/08/01 14:01:17  nieten
; keine Kollision der beiden remote-Trigger mehr
;
; Revision 1.55  2002/07/18 15:40:52  nieten
; - Trigger sind nicht mehr -F, Prioritaet ist aber immer <= 10
; - /comm_write_ebene gibt Blanks am Anfang jetzt korrekt aus
; - /comm_t_ebene und /comm_format_ebene kommen jetzt auch mit mehrzeiligen
;   emotes zurecht.
; - %comm_living und %comm_non_living werden in jedem Fall gespeichert
; - comm_check_living() kommt jetzt auch mit (hoffentlich) Magierpresays zurecht
;
; Revision 1.54  2002/06/25 15:28:33  nieten
; femotes und remotes koennen eingefaerbt werden (/hilfe comm_(f|r)emote_colors)
;
; Revision 1.53  2002/06/13 11:57:52  mh14
; comm_ebenen_list als Parentknoten markiert
;
; Revision 1.52  2002/06/12 12:52:12  nieten
; - Doppelpunkt bei "sag" wieder drin.
; - Auch bei den Ebenen wird nun bei %comm_color_lines=1 alles eingefaerbt.
;
; Revision 1.51  2002/06/11 18:17:49  nieten
; %comm_color_lines zum Faerben der ganzen Zeile eingebaut
;
; Revision 1.50  2002/06/09 19:55:42  mh14
; ebenenfarben werden jetzt geladen, wwar nen bug
;
; Revision 1.49  2002/06/07 07:14:07  mh14
; bug bei auswertung von special-tm farben
;
; Revision 1.48  2002/05/31 15:18:19  nieten
; - bei nicht gesetzten %mud_short_who wird !\kkwer benutzt
; - Spielernamen, die irrtuemlich in %comm_non_living auftauchen, werden
;   nach Moeglichkeit wieder geloescht
;
; Revision 1.47  2002/04/26 13:41:34  nieten
; Farbauswahl korrigiert
;
; Revision 1.46  2002/04/26 13:32:18  nieten
; Doku ergaenzt
;
; Revision 1.45  2002/04/26 13:08:36  nieten
; - /comm_t_teilemit2 debuggt
; - Farbauswahl beschleunigt
;
; Revision 1.44  2002/04/24 13:40:17  nieten
; Hngl, neue Variablen sollten jetzt funzen.
;
; Revision 1.43  2002/04/24 13:23:15  nieten
; - an Config-System angepasst
; - %comm_echo_colors wegen besserer Konfigurierbarkeit in 4 Variablen
;   %comm_(sag|tm|frufe|stm)_colors aufgespalten
;
; Revision 1.42  2002/04/18 22:37:51  mh14
; isList richtig angewendet
;
; Revision 1.41  2002/04/18 22:03:24  mh14
; config-system
;
; Revision 1.40  2002/04/16 13:02:17  mh14
;  /custom erzeugt jetzt keine globalen Variablen mehr (grosse Fehlerursache), es nutzt /ret_vars aus util.tf, die Files wurden darauf angepasst
;
; Revision 1.39  2002/04/16 12:26:22  mh14
; /bs_teilemit_* aus crypt.cfg fuer special-tms
;
; Revision 1.38  2002/04/12 20:11:19  nieten
; %comm_window legt fest, ob Kommunikation ueberhaupt geloggt werden soll
;
; Revision 1.37  2002/04/11 15:43:38  nieten
; - comm_living und comm_non_living sind jetzt Listen, die im Verzeichnis ${world} gespeichert werden
; - Bug in /comm_format_ebene raus
; - Bug in /comm_check_living2 raus
; - ein paar Dokus korrigiert
; - Doku zu %comm_matrix
; - /comm_printable_attributes steht zwar noch drin, wird aber nicht mehr
;   verwendet (durch /replace ersetzt)
;
; Revision 1.36  2002/03/07 15:50:43  nieten
; /comm_filter_attributes ist jetzt /remove_attributes in util.echo.tf
;
; Revision 1.35  2002/02/13 14:51:32  nieten
; \ vergessen
;
; Revision 1.34  2002/02/13 14:47:27  nieten
; Hilfstexte angepasst
;
; Revision 1.33  2002/02/13 14:11:36  mh14
; /custom nochmal umgestellt, mit der option -a[string] haengt es makdir oder string vor den pfad dran, ansonsten ist es wieder relativ
;
; Revision 1.32  2002/02/10 21:22:41  mh14
; bug beim laden :(
;
; Revision 1.31  2002/02/10 21:18:28  mh14
; Beruecksichtigung von special tm's z.B. gecryptete
;
; Revision 1.30  2002/02/09 21:47:34  mh14
; bug bei moerderebene raus
;
; Revision 1.29  2002/02/09 20:42:38  mh14
; ebenen refaktoriert, matrix darauf angepasst, eigenens ebenen log
;
; Revision 1.28  2002/02/09 19:23:40  mh14
; matrixkreis eingebaut, per default aus, in comm.cfg einschalten
;
; Revision 1.27  2002/01/23 14:58:04  nieten
; Bug mit %comm_last_partner_living endlich behoben
;
; Revision 1.26  2001/12/06 17:15:14  nieten
; Teammeldungen werden wieder eingefaerbt
;
; Revision 1.25  2001/12/05 15:03:59  nieten
; ";\" statt "%;\" bringt mich noch mal ins Grab
;
; Revision 1.24  2001/12/05 14:22:20  nieten
; Trigger an neues way.tf bzw. /trig_grab angepasst. Hilfe erweitert.
;
; Revision 1.23  2001/12/05 01:39:50  nieten
; Bug in /comm_check_living bzw. /comm_update_living behoben
;
; Revision 1.22  2001/12/04 22:52:15  nieten
; E-Option von comm_t_ebene an neues way.tf angepasst
;
; Revision 1.21  2001/12/04 16:20:02  nieten
; /comm_t_ebene verbessert
;
; Revision 1.20  2001/11/28 12:27:13  mh14
; check auf nutzerverzeichnis fuer logs verzeichnis
;
; Revision 1.19  2001/10/30 19:52:04  nieten
; verwendet jetzt /trig_grab
;
; Revision 1.18  2001/10/29 18:38:32  nieten
; Logilfe ist nun ${world_host}/${world_character}/comm.log.
; Logfenster wird beim Entfernen des Pakets geloescht.
; /comm_t_ebene nutzt nun /comm_write zur Ausgabe, neue Variable comm_ebenen_window
;
; Revision 1.17  2001/10/25 16:28:30  nieten
; /check_living2 debuggt
;
; Revision 1.16  2001/10/25 13:13:01  nieten
; /check_living und /update_living sollten jetzt auch mir der inkonsequenten Gross-/Kleinschreibung vom MG zurecht kommen
;
; Revision 1.15  2001/10/24 17:21:48  nieten
; /check_living und /update_player ueberarbeitet
;
; Revision 1.14  2001/10/22 16:40:56  nieten
; neue Funktion /comm_filter_attributes
;
; Revision 1.13  2001/10/22 16:07:33  nieten
; debuggt (/comm_add_ebene steht am Anfang noch nicht zur Verfuegung)
;
; Revision 1.12  2001/10/15 17:22:15  nieten
; /comm_printable_attributes kommt nun auch mit " im String klar
;
; Revision 1.11  2001/10/15 16:18:14  nieten
; Trigger comm_t_ebene jetzt nicht -F (args)
;
; Revision 1.10  2001/10/15 12:57:02  nieten
; Variablen sollte jetzt wirklich alle mit comm_ anfangen.
; neue Funtion comm_printable_attributes
;
; Revision 1.9  2001/10/11 18:00:21  nieten
; auch lokale Variablen fangen jetzt mit "comm_" an
;
; Revision 1.8  2001/10/10 22:10:22  mh14
; Default-Konfiguration in .tf Files verschoben
;
; Revision 1.7  2001/10/04 17:22:45  nieten
; Trigger springen nur noch an, wenn "psave_trig" nicht definiert ist.
; -> keine Ausgabe bei "/wo" etc.
;
; Revision 1.6  2001/10/04 15:26:42  nieten
; /comm_t_ebene ueberarbeitet, so dass keine Teamnamen mehr bei /wo ausgegeben werden
;
; Revision 1.5  2001/10/04 14:55:19  nieten
; "/requires customize.tf" durch "/requires util.completion.def" ersetzt
;
; Revision 1.4  2001/10/03 09:45:29  mh14
; debuggt
;
; Revision 1.3  2001/10/01 20:24:07  mh14
; debuggt /set, /let ohne = entfernt
;
; Revision 1.2  2001/10/01 01:51:40  mh14
; /send rausgenommen
;
; Revision 1.1  2001/09/27 21:51:10  nieten
; erste Version
;

/set comm_tf_version=$Id$
/set comm_tf_author=Dotz@mg.mud.de
/set comm_tf_requires=!help.tf !config.tf util.tf(1.18) util.sfunc.tf(1.8) util.trigger.tf(1.11) util.windows.tf lists.tf loading.tf(1.33) util.completion.def, util.echo.tf(1.13)
/set comm_tf_desc=Einfaerbung und Formatierung der Kommunikation, Logging und einfache History

; ********************* BEGIN CONFIG ********************
; Die unten stehende Einstellung ist sehr einfach, die bunte steht in comm.cfg
/set_var comm_matrix 0

/deprecated comm_echo_colors v Stattdessen gibt's jetzt %comm_(sag|tm|frufe|stm)colors.

/set_var comm_sag_colors n n
/set_var comm_tm_colors Cgreen Cgreen
/set_var comm_frufe_colors Cbggreen Cbggreen
/set_var comm_stm_colors Cblue Cblue
/set_var comm_femote_colors Cbggreen Cbggreen
/set_var comm_remote_colors n n


/set_var comm_default_tm_an @{%comm_color}An @{B}%comm_name@{x%comm_color}:
/set_var comm_default_tm_von @{%comm_color}Von @{B}%comm_name@{x%comm_color}:

/cfg_info mud comm colors texte Mitteilungsformatierung
/cfg_info mud comm colors texte TM_AN tm_an:comm_tm_an
/cfg_info mud comm colors texte TM_VON tm_von:comm_tm_von
/cfg_info mud comm colors texte STM_AN Special-TM_an:comm_stm_an
/cfg_info mud comm colors texte STM_VON Special-TM_von:comm_stm_von
/cfg_info mud comm colors texte FRUFE_AN frufe_an:comm_frufe_an
/cfg_info mud comm colors texte FRUFE_VON frufe_von:comm_frufe_von

/set_var comm_beep_teilemit 0

/set_var comm_color_lines 0

; Logging der Kommunikation ein.
/set_var comm_window 1
; Logging der Ebenen aus.
/set_var comm_ebenen_window 0


; kopieren einiger Makros, in comm.cfg
;/rename_mac p* comm_p* comm
;/rename_mac tm* comm_tm* comm
;/rename_mac sag* comm_sag* comm

; Farben fuer die Ebenen, minimale Einstellungen
/ifdo (isList("comm_ebenen_list")=~error) \
    /loadlist -c comm_ebenen_list

/if (isEmptyList(comm_ebenen_list)) \
    /echo Erzeuge Liste comm_ebenen_list.%;\
    /createnewlist comm_ebenen_list%;\
; /comm_add_ebene ist hier noch nicht definiert, also Handarbeit
    /addtolist comm_ebenen_list DEFAULT n B%;\
    /addtolist comm_ebenen_list tf Cgreen Cgreen%;\
    /addtolist comm_ebenen_list tod BCred BCred%;\
;    /addtolist comm_ebenen_list allgemein n r%;\
; Teamnamen
    /addtolist comm_ebenen_list team Cblue Cblue%;\
; MPA
    /addtolist comm_ebenen_list bezug n n%;\
    /addtolist comm_ebenen_list autor n n%;\
    /savelist -c comm_ebenen_list%;\
/endif

; /ifdef (!isMacro("bs_teilemit_von")) bs_teilemit_von = \
; 	/set bs_size=78%;\
; 	/set bs_attr=$(/last %comm_stm_colors)%;\
; 	/set bs_cmd=/comm_write 1%;\
; 	/test set("bs_indent=@{%bs_attr}STM von @{B}%1@{x%bs_attr}: ")%;\
; 	/set bs_attr=-pa%bs_attr%;\
; 	/break_string %-1%; \

/addh info Ausgabe der gesendeten Mitteilungen
/addh bs_teilemit_an cfg

; /ifdef (!isMacro("bs_teilemit_an")) bs_teilemit_an = \
; 	/set bs_size=78%;\
; 	/set bs_attr=$(/first %comm_stm_colors)%;\
; 	/set bs_cmd=/comm_write 1%;\
; 	/test set("bs_indent=@{%bs_attr}STM an @{B}%1@{x%bs_attr}: ")%;\
; 	/set bs_attr=-pa%bs_attr%;\
; 	/break_string %-1

/def bs_teilemit_an = \
	/set bs_size=78%;\
	/set bs_cmd=/trigger%;\
	/set bs_indent=%;\
	/test bs_indent:='Du teilst %1 mit; '%;\
	/break_string %-1


/def bs_teilemit_von = \
	/set bs_size=78%;\
	/set bs_cmd=/trigger%;\
	/set bs_indent=%;\
	/test bs_indent:='%1 teilt Dir mit; '%;\
	/break_string %-1

; ********************* END CONFIG **********************

; Filename           -> verwendete Makros
;help.tf             -> /addh
;util.windows.tf     -> /write_to_window
;util.trigger.tf     -> /trig_grab
;util.sfunc.tf       -> /tokenize
;util.tf(1.18)       -> /rename_mac, /remove_packet, dir_exists
;lists.tf            -> /addtolist, /iskey, /getvalueof ...
;loading.tf          -> comm.cfg, /custom laden
;util.completion.def -> %mud_short_who
;util.echo.tf        -> /remove_attributes
;config.tf           -> /cfg_info

/cfg_info mud comm colors Mitteilungsfarben

/addh info \
Farben fuer Mitteilungen per "sage", "frage", "fluestere". Die Variable hat zwei Eintraege: Eine Farbe fuer eigene Aeusserungen und eine fuer andere. Es werden der Gespraechspartner und die Kommunikationsart eingefaerbt, wobei der Name des Gespraechspartners zusaetzlich noch das Attribut fett erhaelt.
/addh ex /set comm_sag_colors=Ccyan uCcyan@{N}\
fuehrt zu Ausgaben wie@{N}\
@{BCcyan}Du@{xCcyan} sagst:@{x} Hier ist ein Fehler.@{N}\
@{BuCcyan}Mesirii@{xuCcyan} fragt @{B}Dich@{xuCcyan}:@{x} Wo?@{N}\
@{BCcyan}Du@{xCcyan} fluesterst @{B}dem Sandtiger@{xCcyan} zu:@{x} Lusche
/addh see /comm_t_sagt, /commm_t_fragt, /comm_t_fluestert, %comm_tm_colors, %comm_frufe_colors, %comm_stm_colors
/addh dtype text
/addh comm_sag_colors var
/cfg_info mud comm COLORS SAGE sage:comm_sag_colors


/addh info \
Farben fuer Mitteilungen per "teile mit". Die Variable hat zwei Eintraege: Eine Farbe fuer eigene Aeusserungen und eine fuer andere. Es werden der Gespraechspartner und die Kommunikationsart eingefaerbt, wobei der Name des Gespraechspartners zusaetzlich noch das Attribut fett erhaelt.
/addh ex /set comm_frufe_colors=Cgreen uCgreen@{N}\
fuehrt zu Ausgaben wie@{N}\
@{Cgreen}An @{B}Jof@{xCgreen}:@{x} Du idelst ja.@{N}\
@{uCgreen}Von @{B}Dotz@{xuCgreen}:@{x} Wo ist die Ewige Schokolade?@{N}\
/addh see /comm_t_teilemit, /comm_t_teilemit2, %comm_sag_colors, %comm_frufe_colors, %comm_stm_colors
/addh dtype text
/addh comm_tm_colors var
/cfg_info mud comm colors TEILE_MIT teile_mit:comm_tm_colors


/addh info \
Farben fuer Mitteilungen per "frufe". Die Variable hat zwei Eintraege: Eine Farbe fuer eigene Aeusserungen und eine fuer andere. Es werden der Gespraechspartner und die Kommunikationsart eingefaerbt, wobei der Name des Gespraechspartners zusaetzlich noch das Attribut fett erhaelt.
/addh ex /set comm_frufe_colors=Cbggreen uCbggreen@{N}\
fuehrt zu Ausgaben wie@{N}\
@{Cbggreen}An @{B}Freunde@{xCbggreen}: Huhu.@{N}\
@{uCbggreen}Von Freund @{B}Elberet@{xuCbggreen}:@{x} Muh!@{N}\
/addh see /comm_t_frufe, %comm_sag_colors, %comm_tm_colors, %comm_stm_colors
/addh dtype text
/addh comm_frufe_colors var
/cfg_info mud comm colors FRUFE frufe:comm_frufe_colors


/addh info \
Farben fuer "femote". Die Variable hat zwei Eintraege: Eine Farbe fuer eigene femotes und eine fuer andere. Der Name erhaelt zusaetzlich noch das Attribut fett.@{N}\
Durch "-" werden die entsprechenden Trigger deaktiviert und nichts eingefaerbt.
/addh ex /set comm_femote_colors=Cbggreen uCbggreen@{N}\
fuehrt zu Ausgaben wie@{N}\
@{BCbggreen}Dein Freund Dotz@{xCbggreen} steckt Dir aus der Ferne ein Stueck Schokolade zu.@{N}\
@{BuCbggreen}Du@{xuCbggreen} knuddelst Deine Freunde aus der Ferne.@{N}\
Falls ?%comm_color_lines auf 0 gesetzt wurde, wird nur der Name eingefaerbt:@{N}\
@{BCbggreen}Dein Freund Dotz@{x} steckt Dir aus der Ferne ein Stueck Schokolade zu.@{N}\
@{BuCbggreen}Du@{x} knuddelst Deine Freunde aus der Ferne.
/addh see /comm_t_femote1, /comm_t_femote2, %comm_remote_colors
/addh dtype text
/addh comm_femote_colors var
/cfg_info mud comm colors FEMOTE femote:comm_femote_colors


/addh info \
Farben fuer "remote". Die Variable hat zwei Eintraege: Eine Farbe fuer eigene remotes und eine fuer andere. Der Name erhaelt zusaetzlich noch das Attribut fett.@{N}\
Durch "-" werden die entsprechenden Trigger deaktiviert und nichts eingefaerbt.
/addh ex /set comm_remote_colors=Cgreen uCgreen@{N}\
fuehrt zu Ausgaben wie@{N}\
@{BCgreen}Dotz->Mesirii@{xCgreen} dotzt in der Ferne um Dich herum.@{N}\
@{BuCgreen}Dotz@{xuCgreen} dotzt in der Ferne um Dich herum.@{N}\
Falls ?%comm_color_lines auf 0 gesetzt wurde, wird nur der Name eingefaerbt:@{N}\
@{BCgreen}Dotz->Mesirii@{x} dotzt in der Ferne um Dich herum.@{N}\
@{BuCgreen}Dotz@{x} dotzt in der Ferne um Dich herum.
/addh see /comm_t_remote1, /comm_t_remote2, %comm_remote_colors
/addh dtype text
/addh comm_remote_colors var
/cfg_info mud comm colors REMOTE remote:comm_remote_colors


/addh info \
Farben fuer Mitteilungen per special-"teile mit". Special-tm's sind z. B. gecryptete tm's (?crypt.tf). Die Variable hat zwei Eintraege: Eine Farbe fuer eigene Aeusserungen und eine fuer andere. Es werden der Gespraechspartner und die Kommunikationsart eingefaerbt, wobei der Name des Gespraechspartners zusaetzlich noch das Attribut fett erhaelt.
/addh ex /set comm_stm_colors=uCred uCred@{N}\
fuehrt zu Ausgaben wie@{N}\
@{Cred}STM an @{B}Dotz@{xuCred}:@{x} Wo gab's Schokolade?@{N}\
@{uCred}STM von @{B}Mesirii@{xuCred}:@{x} Huhu Chaosmacher!
/addh see /comm_t_teilemit, /comm_t_teilemit2, %comm_sag_colors, %comm_tm_colors, %comm_frufe_colors, crypt.tf
/addh dtype text
/addh comm_stm_colors var
/cfg_info mud comm colors SPECIAL-TM Special-tm:comm_stm_colors


/addh info \
Enthaelt die Farben fuer die Ebenen (Spezialitaet des MorgenGrauen mg.mud.de). Jeder Listeneintrag hat drei Teile:@{N}\
1. Ebenenname (muss kleingeschrieben sein)@{N}\
2. Farbe fuer die eckigen Klammern '[' und ']'@{N}\
3. Farbe fuer den Namen der Ebene (incl. ':')@{N}\
4. Farbe fuer den Namen des Sagenden@{N}\
Ausser den normalen Ebenennamen gibt es noch einige Sonderfaelle:@{N}\
- DEFAULT: Falls kein passender Ebenenname in der Liste steht, werden die Farben des DEFAULT-Eintrags genommen.@{N}\
- team: Etliche Spieler setzen sich als Presay "[Team: ...]". Dies kann hiermit eingefaerbt werden, ebenso die Kommunikation innerhalb eines Teams.@{N}\
- bezug, autor: Artikelheader der MPA.@{N}\
Diese Liste kann (und sollte) jederzeit nach persoenlichen Vorlieben geaendert bzw. ergaenzt werden.@{N}\
Falls ?%comm_color_lines auf 1 gesetzt ist, wird der eigentliche Text in Farbe 1 (also wie die Klammern) gefaerbt.)
/addh ex \
Das Kommando@{N}\
@{}  /comm_add_ebene beileid BCgreen Ccyan Cyellow@{N}\
fuehrt zu Ausgaben wie@{N}\
@{BCgreen}[@{xCcyan}Beileid:@{Cyellow}Dotz@{x} isst vor Kummer ein Stueck Schokolade.@{xBCgreen}]@{x}@{N}\
(Mit ?%comm_color_lines kann man auch die ganze Zeile einfaerben lassen.)
/addh see /comm_add_ebene, /comm_t_ebene, %comm_color_lines
/addh comm_ebenen_list list
/cfg_info mud comm EBENEN +Ebenenfarben:comm_ebenen_list

/set_var comm_ebenen 1
/cfg_info mud comm EBENEN_EIN Ebenen_einfaerben:comm_ebenen


/addh info \
Fuegt zur Liste ?comm_ebenen_list einen Eintrag hinzu. Falls die Liste noch nicht vorhanden war, wird sie erzeugt.
/addh syn /comm_add_ebene ebenenname Farbe1 Farbe1
/addh see comm_ebene_list
/addh list comm_ebenen_list
/addh comm_add_ebene comm

/defh comm_add_ebene = \
    /createnewlist comm_ebenen_list%;\
    /uaddtolist comm_ebenen_list %*


/addh info \
Legt fest, ob die Kommunikation im Logfenster und Logfile erscheinen soll. Die Bedeutung entspricht dem ersten Parameter von ?/comm_write:@{N}\
0: Text erscheint weder im Logfenster noch im Logfile;@{N}\
1: Text erscheint im Logfenster und Logfile;@{N}\
2: wie 1, jedoch werden vorher Attributdefinitionen entfernt.
/addh see /comm_write
/addh dtype number
/addh comm_window cfg
/cfg_info mud comm KOMMUNIKATIONSLOG Kommunikationslog:comm_window


/addh info \
Legt fest, ob das Geschehen auf den Ebenen im Logfenster und Logfile erscheinen soll. Die Bedeutung entspricht dem ersten Parameter von ?/comm_write:@{N}\
0: Text erscheint weder im Logfenster noch im Logfile;@{N}\
1: Text erscheint im Logfenster und Logfile;@{N}\
2: wie 1, jedoch werden vorher Attributdefinitionen entfernt.
/addh see /comm_t_ebene, /comm_write
/addh dtype number
/addh comm_ebenen_window cfg
/cfg_info mud comm EBENENLOG Ebenenlog:comm_ebenen_window


/addh info \
Legt fest, ob die ganze Zeile (1) oder nur der Sprecher bzw. der Ebenenname (0) eingefaerbt werden soll.
/addh ex \
Mit Einstellung 0 sieht das z.B. so aus:@{N}\
@{Ccyan}Von @{B}Dotz@{xCcyan}:@{x} Forschen :^)@{N}\
@{Cgreen}[@{u}Tod:@{x}Lars@{Cgreen}]@{x} Eine Schokoladenvergiftung hat gerade Dotz umgebracht.@{N}\
Das gleiche mit Wert 1:@{N}\
@{Ccyan}Von @{B}Dotz@{xCcyan}: Forschen :^)@{N}\
@{Cgreen}[@{u}Tod:@{xCgreen}Lars] Eine Schokoladenvergiftung hat gerade Dotz umgebracht.
/addh dtype flag
/addh comm_color_lines var
/cfg_info mud comm ZEILEN_KOMPLETT_EINFAERBEN Zeilen_komplett_einfaerben:comm_color_lines


/addh info \
Hier koennen bei Bedarf Optionen eingetragen werden, die das Aussehen (z.B. Vorder- und Hintergrundfarbe) des Log-Fensters beeinflussen. Genaueres bitte der Man-Page fuer "xterm" (Linux) bzw. der Hilfe zu "cmd" (Windows) entnehmen.
/addh ex -fg black -bg white
/addh dtype var
/addh comm_window_options var
/cfg_info mud comm FENSTEROPTIONEN Fensteroptionen:comm_window_options

/set_var comm_window_options=

/addh info \
Setzt ?%comm_window_name auf den richtigen Wert: Existiert im MUD-Verzeichnis ein Player-Verzeichnis (z.B. mg.mud.de/Dotz), so wird <mud-name>/<player-name>/comm.log (also z.B. mg.mud.de/Dotz/comm.log) als Logfile verwendet, andernfalls <mud-name>/comm.log.@{N}\
(Der erste Fall entspricht also den Optionen "-c -p" von ?/custom, der zweite Fall "-c".)
/addh var %comm_window_name, %load_dir
/addh func dir_exists
/addh mak /custom
/addh see /comm_write, /custom
/addh set_comm_name mak

/def set_comm_name = \
    /custom -a -c -p%;\
    /test %?%;\
;/echo [set_comm_name] %load_dir%;\
    /if (dir_exists(load_dir)) \
       /set comm_window_name=${world_character}/comm%;\
       /set comm_ebene_window_name=${world_character}/ebenen%;\
    /else \
       /set comm_window_name=comm%;\
       /set comm_ebene_window_name=ebenen%;\
    /endif%;

/set_comm_name

/addh info \
Gibt den als zweiten Parameter uebergebenen Text aus und loggt ihn mit, falls \
der erste Parameter nicht 0 und ?%comm_window nicht 0 ist.@{N}\
Ist der erste Parameter 1, so werden die Attributdefinitionen des Textes nicht ins Logfile %comm_window_name uebernommen.
/addh syn /comm_write 0|1|2 text
/addh see /comm_t_sagt, /comm_t_fragt, /comm_t_fluestert, /comm_t_teilemit, /comm_t_teilemit2, /remove_attributes, /write_to_window, /set_comm_window
/addh var %comm_window, %comm_window_name
/addh mak /remove_attributes, /write_to_window
/addh comm_write mak

/def comm_write = \
    /echo -p %-1%;\
    /if (comm_window !~ "0") \
        /set window_options=%comm_window_options%;\
	/if ({1}=~"1") \
	    /test write_to_window(comm_window_name,remove_attributes({-1}))%;\
	/elseif ({1}!~"0") \
	    /test write_to_window(comm_window_name,{-1})%;\
	/endif%;\
    /endif


/addh info \
Wie ?/comm_write, jedoch fuer %comm_ebene_window_name.
/addh var comm_ebene_window_name
/addh mak /comm_write_to_window, /remove_attributes
/addh comm_write_ebene mak

/def comm_write_ebene = \
    /test echo({-1},"",1)%;\
    /if ({1}=~"1") \
	/test write_to_window(comm_ebene_window_name,\
	    remove_attributes({-1}))%;\
    /elseif ({1}!~"0") \
	/test write_to_window(comm_ebene_window_name,{-1})%;\
    /endif%;


/addh info \
Trigger, der das "frage" abfaengt, es einfaerbt und an ?/comm_write uebergibt.@{N}\
Wird nicht ausgefuehrt, falls das Wegesystem den aktuellen Standort herausfinden will.
/addh see /comm_write, %comm_sag_colors
/addh func trig_is_active()
/addh mak /comm_write
/addh var %comm_echo_colors, %getpoint_trig
/addh comm_t_fragt trig

/def -E(!trig_is_active(getpoint_trig)&!comm_mpa_mail) -p3 -ag -mregexp \
    -t"^((Der|Die|Das|Eine?) )?([^ ]+)( frags?t)( )?([^:]*): " comm_t_fragt = \
    /let comm_speaker=$[strcat({P1},{P3})]%;\
    /let comm_echo=@{B%;\
    /let comm_is_living=1%;\
    /if ({P3}=~"Du") \
	/let comm_color=$[substr(comm_sag_colors, 0, \
	    strchr(comm_sag_colors," "))]%;\
    /else \
	/let comm_color=$[substr(comm_sag_colors, \
	    strrchr(comm_sag_colors," ")+1)]%;\
	/if (!comm_check_living(comm_speaker)) \
	    /let comm_is_living=0%;\
;           /test comm_echo:=strcat("@{",comm_color,"}NPC @{B")%;\
	/else \
	    /set comm_last_partner=$[tolower(comm_speaker)]%;\
	/endif%;\
    /endif%;\
    /test comm_echo:=strcat(comm_echo,comm_color,"}",comm_speaker,\
			    "@{x",comm_color,"}",{P4})%;\
    /if ({P6}!~"") \
	/test comm_echo:=strcat(comm_echo," @{B}",{P6})%;\
    /endif%;\
    /test comm_echo:=strcat(comm_echo,"@{x",comm_color,"}: ",\
			    (comm_color_lines?"":"@{x}"),\
			    replace("@","@@",{PR}))%;\
;/echo is_living=%comm_is_living, speaker=%comm_speaker, echo=%comm_echo%;\
    /comm_write %comm_is_living %comm_echo%;


/addh info \
Trigger, der das "sage" abfaengt, es einfaerbt und an ?/comm_write uebergibt.@{N}\
Wird nicht ausgefuehrt, falls das Wegesystem den aktuellen Standort herausfinden will.
/addh see /comm_write, %comm_sag_colors
/addh mak /comm_write
/addh func trig_is_active()
/addh var %comm_echo_colors, %getpoint_trig
/addh comm_t_sagt trig

/def -E(!trig_is_active(getpoint_trig)&!comm_mpa_mail) -p3 -ag -mregexp \
    -t"^((Der|Die|Das|Eine?) )?([^ ]+)( sags?t)(: )" comm_t_sagt = \
    /let comm_speaker=$[strcat({P1},{P3})]%;\
    /let comm_echo=@{B%;\
    /let comm_is_living=1%;\
    /if ({P3}=~"Du") \
	/let comm_color=$[substr(comm_sag_colors, 0, \
	    strchr(comm_sag_colors," "))]%;\
    /else \
	/let comm_color=$[substr(comm_sag_colors, \
	    strrchr(comm_sag_colors," ")+1)]%;\
	/if (!comm_check_living(comm_speaker)) \
	    /let comm_is_living=0%;\
;           /test comm_echo:=strcat("@{",comm_color,"}NPC @{B")%;\
	/else \
	    /set comm_last_partner=$[tolower(comm_speaker)]%;\
	/endif%;\
    /endif%;\
    /test comm_echo:=strcat(comm_echo,comm_color,"}",comm_speaker,\
			    "@{x",comm_color,"}",{P4},\
			    (comm_color_lines?": ":":@{x} "),\
			    replace("@","@@",{PR}))%;\
;/echo is_living=%comm_is_living, speaker=%comm_speaker, echo=%comm_echo%;\
    /comm_write %comm_is_living %comm_echo%;


/addh info \
Trigger, der das "fluester" abfaengt, es einfaerbt und an ?/comm_write uebergibt.@{N}\
Wird nicht ausgefuehrt, falls das Wegesystem den aktuellen Standort herausfinden will.
/addh see /comm_write, %comm_sag_colors
/addh mak /comm_write
/addh func trig_is_active()
/addh var %comm_echo_colors, %getpoint_trig
/addh comm_t_fluestert trig

/def -E(!trig_is_active(getpoint_trig)&!comm_mpa_mail) -p3 -ag -mregexp \
    -t"^((Der|Die|Das|Eine?) )?([^ ]+)( fluesters?t) (.+) zu: " \
    comm_t_fluestert = \
    /let comm_speaker=$[strcat({P1}, {P3})]%;\
    /let comm_echo=@{B%;\
    /let comm_is_living=1%;\
    /if ({P3}=~"Du") \
	/let comm_color=$[substr(comm_sag_colors, 0, \
	    strchr(comm_sag_colors," "))]%;\
    /else \
	/let comm_color=$[substr(comm_sag_colors, \
	    strrchr(comm_sag_colors," ")+1)]%;\
	/if (!comm_check_living(comm_speaker)) \
	    /let comm_is_living=0%;\
;           /test comm_echo:=strcat("@{",comm_color,"}NPC @{B")%;\
	/else \
	    /set comm_last_partner=$[tolower(comm_speaker)]%;\
	/endif%;\
    /endif%;\
    /test comm_echo:=strcat(comm_echo,comm_color,"}",comm_speaker,\
			    "@{x",comm_color,"}",{P4}," @{B}",{P5},\
			    "@{x",comm_color,"} zu:",\
			    (comm_color_lines?" ":"@{x} "),\
			    replace("@","@@",{PR}))%;\
;/echo is_living=%comm_is_living, speaker=%comm_speaker, echo=%comm_echo%;\
    /comm_write %comm_is_living %comm_echo%;


/addh info \
Variable, die den Zeitpunkt des letzten "teile mit" oder "frufe" an Dich enthaelt.
/addh see /comm_t_teilemit, %comm_beep_teilemit
/addh comm_last_teilemit var

/eval /set comm_last_teilemit=$[time()]


/addh info \
Falls einem zum ersten Mal nach %beep_teilemit Sekunden wieder etwas per "teile mit" oder "frufe" mitgeteilt wird, wird ein "/beep 1" ausgefuehrt. Ein Wert von 0 bedeutet, dass kein Pieps ausgegeben werden soll.
/addh see /comm_t_teilemit, %comm_last_teilemit
/addh dtype flag
/addh comm_beep_teilemit cfg
/cfg_info mud comm IDLE-BEEP Idle-Beep:comm_beep_teilemit


/addh info \
Trigger, der das "teile mit", "frufe" und "feindrufe" an Dich abfaengt, einfaerbt und an ?/comm_format_tm uebergibt. Wenn der Zeitpunkt des letzten "teile mit" bzw. "frufe" laenger als %beep_teilemit Sekunden her ist, wird ein "/beep 1" ausgefuehrt, sofern %beep_teilemit nicht 0 ist.@{N}\
Behandelt auch special tm's d.h. Trenner ungleich ":".@{N}\
/addh see /comm_format_tm, /comm_write, %comm_tm_colors, %comm_frufe_colors, %comm_last_teilemit, %comm_beep_teilemit
/addh var %comm_tm_colors, %comm_frufe_colors, %comm_last_teilemit, %comm_beep_teilemit, %getpoint_trig
/addh func trig_is_active()
/addh mak /comm_write
/addh comm_t_teilemit trig

/set comm_dest_von=2
/set comm_dest_an=1

/def -p5  -E(!comm_mpa_mail) -ag -mregexp -t"^(Deine? \
    (Freund(in)?|Feind(in)?) )?\
    \\(?([A-Za-z0-9 ]+(@[A-Za-z0-9'._:@& -]+)?)\\)? teilt Dir mit([:;]) " \
    comm_t_teilemit = \
    /let comm_special=$[{P7}!~":"]%;\
    /let comm_friends=$[{P1}!~""]%;\
    /if (comm_friends) \
       /let comm_friends=$[{P3}!~"" ? 2 : 1]%;\
       /let comm_name=%P2 %P5%;\
    /else \
       /let comm_name=%P5%;\
    /endif%;\
    /let comm_dest=%comm_dest_von%;\
    /let comm_text=%PR%;\
    /comm_format_tm

/addh info \
Trigger, der das eigene "teile mit", "frufe" und "feindrufe" abfaengt, eingefaerbt und an ?/comm_format_tm uebergibt.@{N}\
Behandelt auch special tm's d.h. Trenner ungleich ":".@{N}\
/addh see /comm_format_tm, /comm_write, %comm_tm_colors, %comm_frufe_colors
/addh var %comm_tm_colors, %comm_frufe_colors, %getpoint_trig
/addh mak /comm_write
/addh func trig_is_active()
/addh comm_t_teilemit2 trig

/def -p5 -E(!comm_mpa_mail) -ag -mregexp \
    -t"^Du teilst( [Dd]einen)? ([A-Za-z0-9 ]+(@[A-Za-z0-9'._:@& -]+)?) \
    mit([:;]) " comm_t_teilemit2 = \
    /let comm_name=%P2%;\
    /let comm_special=$[{P4}!~":"]%;\
    /let comm_friends=$[{P1}!~""]%;\
    /let comm_text=%PR%;\
    /if (comm_friends) \
       /let comm_name=$[substr({P2},0,-1)]%;\
    /endif%;\
    /let comm_dest=%comm_dest_an%;\
    /comm_format_tm


/addh info \
Formatmakro das ausgehend von folgenden Variablen ein und ausgehende TM's einfaerbt: comm_name, comm_dest, comm_special, comm_friends, comm_text. Dabei wird die Farbe abhaengig vom Typ (tm, special tm, frufe) aus der Variablen comm_%typ_colors oder alternativ der gesamte Praefixtext aus der Variablen comm_%typ_(an|von) mit Formatierung genutzt.
/addh mak reval, comm_check_living
/addh var erwartete Variablen:@{N}\
comm_name Name des Partners@{N}\
comm_special Spezial TM wie z.B. ctm@{N}\
comm_friends Frufe@{N}\
comm_text Text des Teilemit@{N}\
comm_dest Richtung des TM entweder %comm_dest_an (1) oder %comm_dest_von (2)@{N}\
gesetzte Variablen:@{N}\
comm_last_teilemit: Zeit des letzten TM@{N}\
comm_last_partner_living: war der letzte Partner ein Spieler@{N}\

/addh cfg comm_tm_colors, comm_stm_colors, comm_frufe_colors,@{N}\
comm_default_tm_an, comm_default_tm_von@{N}\
comm_tm_an, comm_tm_von, comm_stm_an, comm_stm_von, comm_frufe_an, comm_frufe_von

/addh comm_format_tm mak

/def comm_format_tm = \
    /let comm_echo=%;\
    /if (comm_beep_teilemit & comm_dest == comm_dest_von & \
	 (time()-comm_last_teilemit > comm_beep_teilemit)) \
	/beep 1%;\
    /endif%;\
    /if ({#}) /let comm_text=%*%; /endif%;\
    /set comm_last_teilemit=$[time()]%;\
    /let comm_suffix=$[comm_dest==comm_dest_an ? "an" : "von" ]%;\
;    /set comm_last_partner=$[tolower(comm_name)]%;\
;    /set comm_last_partner_living=1%;\
    /let comm_lives=1%;\
    /if (comm_friends) \
       /let comm_type=frufe%;\
    /elseif (comm_special) \
       /let comm_type=stm%;\
    /else \
       /let comm_type=tm%;\
       /if (!comm_check_living(comm_name)) \
          /let comm_name=NPC %comm_name%;\
	  /let comm_lives=0%;\
       /endif%;\
    /endif%;\
    /if (isVar(strcat("comm_",comm_type,"_",comm_suffix))) \
       /test comm_echo:=reval(comm_%{comm_type}_%{comm_suffix})%;\
    /else \
	/eval /get_param %comm_dest \%comm_%{comm_type}_colors%;\
	/let comm_color=%?%;\
	/test comm_echo:=reval(comm_default_tm_%{comm_suffix})%;\
    /endif%;\
    /test comm_echo:=strcat(comm_echo,(comm_color_lines?" ":"@{x} "),\
			    replace("@","@@",comm_text))%;\
    /comm_write %comm_lives %comm_echo%;



/addh info \
Trigger, der eigene femotes einfaerbt. Leider funktioniert dies bei mehrzeiligen Meldungen nicht immmer (naemlich nur dann, wenn "aus/in der Ferne" in der ersten Zeile steht).
/addh see /comm_t_femote2, %comm_femote_colors, %comm_color_lines
/addh var %comm_femote_colors, %comm_color_lines
/addh comm_t_femote1 trig

/def -p3 -E(comm_femote_colors!~"-"&!comm_mpa_mail) -ag -mglob \
    -t"Dummy * {aus|in} der {Ferne|Ferne.}*" comm_t_femote1 = \
    /let comm_col=$(/last %comm_femote_colors)%;\
    /echo -p @{B%comm_col}%1@{x$[comm_color_lines?comm_col:""]} %{-1}%;\
; Hoert Text nicht mit '.' auf -> mehrzeilig
    /if (comm_color_lines & (substr({*},-1) !~ ".")) \
        /def -p10 -a%comm_col -mglob -t"*" comm_t_femote_help = \
	    /if (substr({*},-1) =~ ".") \
	        /purge comm_t_femote_help%%;\
	    /endif%;\
    /endif


/if (p_name !~ "") \
    /eval /edit -mglob -t"%p_name * der Ferne." comm_t_femote1%;\
/endif
/add_to_hook connect \
    /edit -mglob -t"%p_name * der Ferne." comm_t_femote1%;

/add_to_hook connect /comm_update_living

/addh info \
Trigger, der femotes von den Freunden einfaerbt.
/addh see /comm_t_femote1, %comm_femote_colors, %comm_color_lines
/addh var %comm_femote_colors, %comm_color_lines
/addh comm_t_femote2 trig

/def -p3 -E(comm_femote_colors!~"-"&!comm_mpa_mail) -ag -mglob \
    -t"{Dein|Deine} {Freund|Freundin} *" comm_t_femote2 = \
    /let comm_col=$(/first %comm_femote_colors)%;\
    /let comm_tmp=@{B%comm_col}%1 %2 %3@{x$[comm_color_lines?comm_col:""]}%;\
    /shift 3%;\
    /echo -p %comm_tmp %*%;\
; Hoert Text nicht mit Satzzeichen auf -> mehrzeilig
    /if (comm_color_lines & !comm_satzende({*})) \
        /def -p10 -a%comm_col -mglob -t"*" comm_t_femote_help = \
	    /if (comm_satzende({*})) \
	        /purge comm_t_femote_help%%;\
	    /endif%;\
    /endif


/addh info \
Trigger, der eigene remotes einfaerbt.
/addh see /comm_t_remote2, %comm_remote_colors, %comm_color_lines
/addh var %comm_remote_colors, %comm_color_lines
/addh comm_t_remote1 trig

/def -p5 -E(comm_remote_colors!~"-"&!comm_mpa_mail) -ag -mregexp \
    -t"^([A-Z][A-Za-z ]+)->([A-Z][A-Za-z]+\\'?) " comm_t_remote1 = \
    /let comm_col=$(/last %comm_remote_colors)%;\
    /echo -p @{B%comm_col}%P1@{x$[comm_color_lines?comm_col:""]}->%P2 %PR%;\
; Text hoert nicht mit '.' auf oder "Ferne" fehlt -> mehrzeilig
    /set comm_remote_ferne=$[strstr({PR},"Ferne") + 1]%;\
    /if (comm_color_lines & !comm_remote_ferne | !comm_satzende({*})) \
        /def -p10 -a%comm_col -mglob -t"*" comm_t_remote_help = \
	    /if (!comm_remote_ferne & (strstr({*},"Ferne") != -1)) \
	        /set comm_remote_ferne=1%%;\
	    /endif%%;\
	    /if (comm_remote_ferne & comm_satzende({*})) \
	        /purge -mglob comm_{h|t}_remote_help%%;\
	    /endif%;\
	/def -1 -F -p9999 -hPROMPT comm_h_remote_help = \
	    /purge comm_t_remote_help%;\
    /endif

; Klappt nicht, falls %p_name nicht genau den Spielernamen enthaelt, also raus.
;/if (p_name !~ "") \
;    /eval /edit -mregexp -t"^([A-Za-z]+)->%p_name(s|')? " comm_t_remote1%;\
;/endif
;
;/add_to_hook connect \
;    /edit -mregexp -t"^([A-Za-z]+)->%p_name(s|')? " comm_t_remote1%;


/addh info \
Trigger, der remotes von anderen einfaerbt.
/addh see /comm_t_remote1, %comm_remote_colors, %comm_color_lines
/addh var %comm_remote_colors, %comm_color_lines
/addh comm_t_remote2 trig

/def -p1 -E(comm_remote_colors!~"-"&!comm_mpa_mail) -ag -mglob \
    -t"[A-Z]* {aus|in} der Ferne*" comm_t_remote2 = \
; Falls Zeile mit Kleinbuchstaben anfaengt -> kein remote
    /if (tolower(substr({1},0,1)) =~ substr({1},0,1)) \
        /test echo({*})%;\
        /return%;\
    /endif%;\
; Verwende nur iskey(), um %comm_non_living nicht mit allem
; moeglichen Mist vollzustopfen. Genitiv und Magierpresays
; erschweren die ganze Sache leider ziemlich.
    /let liv=$[{1}=~"Du" | iskey("comm_living",tolower({1}))!=error]%;\
    /let pre=0%;\
; Zweites comm_check_living() fuer Magier mit Presay.
    /if (!liv & iskey("comm_living",tolower({2}))!=error) \
        /let liv=1%;\
	/let pre=1%;\
    /endif%;\
    /if (!liv) \
;; Mit dem Genitiv muessen wir auch noch fertig werden.
        /if (substr({1},-1) =/ "{\\'|s}") \
	    /let liv=$[iskey("comm_living", tolower(substr({1},0,-1))) \
	        != error]%;\
	/endif%;\
        /if (!liv & substr({2},-1) =/ "{\\'|s}") \
	    /let liv=$[iskey("comm_living", tolower(substr({2},0,-1))) \
	        != error]%;\
	    /let pre=1%;\
        /endif%;\
    /endif%;\
    /if (liv) \
        /let comm_col=$(/last %comm_remote_colors)%;\
	/if (pre) \
	    /echo -p @{B%comm_col}%1 %2@{x$[comm_color_lines?comm_col:""]} %-2%;\
	/else \
            /echo -p @{B%comm_col}%1@{x$[comm_color_lines?comm_col:""]} %-1%;\
	/endif%;\
; kein '.' am Ende -> mehrzeilig
        /if (comm_color_lines & !comm_satzende({*})) \
            /def -p10 -a%comm_col -mglob -t"*" comm_t_remote_help = \
	        /if (comm_satzende({*})) \
	            /purge comm_t_remote_help%%;\
	        /endif%;\
	/endif%;\
    /else \
	/test echo({*})%;\
    /endif


/addh info \
Trigger zum Abfangen der Matrixmitteleilungen von Dir.@{N}\
Ist nur aktiv, falls ?%comm_matrix nicht 0 ist.
/addh mak /comm_format_ebene, /comm_write_ebene
/addh var %comm_matrix
/addh comm_an_matrix trig

/def -p7 -ag -E(comm_matrix&!comm_mpa_mail) -mglob \
    -t"Du teilst dem Kreis mit: *" \
    comm_an_matrix = \
    /shift 5%;\
    /let comm_ebene=Matrix%;\
    /let comm_ebene_speaker=Du%;\
    /let comm_ebene_bracket=]%;\
    /let comm_ebene_text= %*%;\
    /comm_format_ebene%;\
    /comm_write 1 %?


/addh info \
Trigger zum Abfangen der Matrixmitteleilungen an Dich.@{N}\
Ist nur aktiv, falls ?%comm_matrix nicht 0 ist.
/addh mak /comm_format_ebene, /comm_write_ebene
/addh var comm_matrix
/addh comm_von_matrix trig

/def -p3 -ag -E(comm_matrix&!comm_mpa_mail) -mglob \
    -t"{[A-Z]*} denkt: *" comm_von_matrix = \
    /let comm_matrix_von=%1%;\
    /shift 2%;\
    /let comm_ebene=Matrix%;\
    /let comm_ebene_speaker=%comm_matrix_von%;\
    /let comm_ebene_bracket=]%;\
    /let comm_ebene_text= %*%;\
    /comm_format_ebene%;\
    /comm_write 1 %?


/addh info \
Um die Trigger fuer die Matrixmitteilungen zu aktivieren, muss %comm_matrix auf 1 gesetzt werden.
/addh see /comm_von_matrix, /comm_an_matrix
/addh dtype flag
/addh comm_matrix cfg
/cfg_info mud comm MATRIX Matrix:comm_matrix
/addsave comm_matrix



/addh info \
Dieser Trigger faengt die Meldungen der Ebenen ab.@{N}\
Wird nicht ausgefuehrt, falls das Wegesystem den aktuellen Standort herausfinden will.
/addh see comm_ebenen_list, /comm_add_ebene
/addh var %getpoint_trig, %comm_ebenen_window
/addh mak /comm_format_ebene, /comm_write_ebene
/addh comm_t_ebene trig

; comm_t_ebene muss eine hoehere Prioritaet als comm_t_sagt und
; comm_t_teilemithaben, damit z.B. bei "-grats:sagt: Klasse!" die Zeile
; nicht doppelt verarztet wird.
/def -p7 -agCblue  -E(!comm_mpa_mail&comm_ebenen) -mregexp \
    -t"^\\[([^]:]+):([^] ]*)(\\]| )" comm_t_ebene = \
;/echo -aCcyan %0: Ebene/Team=%P1  Spieler=%P2  ]=%P3  Nachricht=%PR%;\
    /let comm_ebene=%P1%;\
    /let comm_ebene_speaker=%P2%;\
    /let comm_ebene_bracket=%;\
    /test comm_ebene_bracket:={P3}%;\
    /let comm_ebene_text=%PR%;\
    /if (comm_ebene =/ "Team *") \
        /comm_write 1 $[comm_format_ebene()]%;\
    /else \
        /comm_write_ebene %comm_ebenen_window $[comm_format_ebene()]%;\
    /endif%;\
; mehrzeiliges emote?
    /if (strchr({*},"]") == -1) \
        /def -p10 -agCblue -mglob -t" *" comm_t_ebene_help = \
	    /let comm_ebene=%comm_ebene%%;\
	    /let comm_tmp=%%;\
; /test wegen Leerzeichen
	    /test comm_tmp:=strrep(" ",$[strlen(comm_ebene)+2])%%;\
	    /let comm_ebene_text=%%comm_tmp%%*%%;\
	    /let comm_ebene_emote=1%%;\
	    /comm_format_ebene%%;\
	    /test comm_write_ebene(comm_ebenen_window,{?})%%;\
	    /if (strchr({*},"]") != -1) \
	        /purge comm_t_ebene_help%%;\
	    /endif%;\
    /endif


/addh info \
Dieses Makro ist fuer das Einfaerben der Ebenen- und Matrixmeldungen zustaendig.  Die Farben koennen fuer jede Ebene mit dem Kommando ?/comm_add_ebene gesetzt werden. Genaures steht in der Hilfe zu ?comm_ebenen_list. Das Makro benoetigt folgende Informationen in folgenden Variablen:@{N}\
%comm_ebene: Name der Ebene bzw. Matrix@{N}\
%comm_ebene_speaker: Wer hat etwas von sich gegeben?@{N}\
%comm_ebene_bracket: ']' bzw. '' (bei emote)@{N}\
%comm_ebene_text: Die eigentliche Nachricht (incl. fuehrendem Leerzeichen).@{N}\
Es wird der entsprechend eingefaerbte String zurueckgegeben.@{N}\
Falls %comm_ebene_emote 1 ist, wird %comm_ebene_text als zweite (bzw. dritte ...) Zeile eines mehrzeiligen emotes aufgefasst und entsprechende eingefaerbt. Der Ebenenname muss auch in diesem Fall in %comm_ebene uebergebene werden, %comm__ebene_(speaker|bracket) werden nicht verwendet.
/addh see /comm_t_ebene, /comm_an_matrix, /comm_von_matrix
/addh list %comm_ebenen_list
/addh var %comm_color_lines
/addh comm_format_ebene func

/def comm_format_ebene = \
    /let tmp=$[getvalueof("comm_ebenen_list",tolower(comm_ebene))]%;\
    /if (tmp=~error) \
; Ebenenname nicht gefunden. Enthaelt er " ", so ist es ein Teamname.
	/if (strchr(comm_ebene," ")!=-1) \
	    /let tmp=$[getvalueof("comm_ebenen_list","team")]%;\
	/else \
	    /let tmp=$[getvalueof("comm_ebenen_list","DEFAULT")]%;\
	/endif%;\
    /endif%;\
    /let comm_color_bracket=x$(/first %tmp)%;\
    /let comm_color_body=x$(/nth 2 %tmp)%;\
    /let comm_color_name=x$(/nth 3 %tmp)%;\
    /if (comm_ebene_emote=~"1") \
; Fortsetzung eines mehrzeiligen emotes.
        /if (comm_color_lines) \
	    /let comm_txt=$[strcat("@{",comm_color_bracket,"}",\
	        comm_ebene_text)]%;\
	/else \
	    /if (substr(comm_ebene_text,-1) =~ "]") \
	        /let comm_txt=$[strcat(substr(comm_ebene_text,0,-1),\
		    "@{",comm_color_bracket,"}]")]%;\
	    /else \
	        /let comm_txt=%comm_ebene_text%;\
	    /endif%;\
	/endif%;\
	/return comm_txt%;\
    /endif%;\
;    /if (comm_color_lines) \
;        /let comm_ebene_speaker=$[strcat("@{",comm_color_bracket,"}",\
;	    comm_ebene_speaker)]%;\
;    /endif%;\
; Da die Sprecher auf "Moerder" "Geist eine[sr]? ..." sind, also Leerzeichen
; im Namen haben, braucht diese Ebene eine Extrabehandlung.
    /if (comm_ebene =~ "Moerder" & comm_ebene_speaker =~ "Geist") \
	/let comm_pos=$[strchr(comm_ebene_text,"]")]%;\
; Extrabehandlung fuer Spieler Geist (grummel)
	/if (comm_pos != -1) \
	    /let comm_ebene_speaker=$[strcat(\
	        comm_ebene_speaker," ",substr(comm_ebene_text,0,comm_pos))]%;\
  	    /let comm_ebene_text=$[substr(comm_ebene_text,comm_pos+1)]%;\
	/endif%;\
	/let comm_ebene_bracket=]%;\
    /endif%;\
    /let comm_txt=$[strcat(\
	"@{",comm_color_bracket,"}[@{",\
	comm_color_body,"}",comm_ebene,\
	":@{",(comm_color_lines?comm_color_bracket:comm_color_name),"}",\
	comm_ebene_speaker,"@{")]%;\
; Wurde auf der Ebene emotet?
    /if (comm_ebene_bracket=~" ") \
	/let tmp=$[strcat("} ",comm_ebene_text)]%;\
	/let comm_pos=$[strrchr(tmp,"]")]%;\
; wenn nach "]" nichts oder Uhrzeit kommt: einfaerben.
	/if (comm_pos!=-1 & \
	    regmatch("^]( <[0-2][0-9]:[0-5][0-9]:[0-5][0-9]>)?$",\
	    substr(tmp,comm_pos))) \
	    /let comm_txt=$[strcat(\
		comm_txt,\
	        (comm_color_lines?"":"x"),\
		substr(tmp,0,comm_pos),\
		"@{",comm_color_bracket,"}]",\
		(comm_color_lines?"":"@{x}"),\
		substr(tmp,comm_pos+1))]%;\
	/else \
	    /let comm_txt=$[strcat(comm_txt,replace("@","@@",tmp))]%;\
	/endif%;\
    /else \
; kein emote
	/let comm_txt=$[strcat(\
	    comm_txt,\
	    comm_color_bracket,"}]",\
	    (comm_color_lines?"":"@{x}"),\
	    replace("@","@@",comm_ebene_text))]%;\
    /endif%;\
    /return comm_txt


/addh info \
Enthaelt die Namen der NPCs, die einem bisher etwas mitgeteilt haben.
/addh see /comm_check_living, /comm_update_living, %comm_living
/addh comm_non_living list

/loadlist -c comm_non_living
; In jedem Fall abspeichern, auch wenn Liste noch nicht existierte.
/if (isEmptyList(comm_non_living)) \
    /addtolist comm_non_living du%;\
    /addlisttosave comm_non_living -c comm_non_living%;\
/endif



/addh info \
Enthaelt die Name der Spieler, die anwesend waren, waehrend einem etwas mitgeteilt wurde.
/addh see /comm_check_living, /comm_update_living, comm_non_living
/addh comm_living list

/loadlist -c comm_living
; In jedem Fall abspeichern, auch wenn Liste noch nicht existierte.
/if (isEmptyList(comm_living)) \
    /addlisttosave comm_living -c comm_living%;\
/endif


/addh info \
Ueberprueft durch Scan der Listen ?comm_living und ?comm_non_living, ob der als Parameter uebergebene Name Spieler oder NPC ist und gibt entsprechend 1 oder 0 zurueck. Faengt der Name mit "der ", "die ", "das ", "ein " oder "eine " an, wird ebenfalls 0 fuer NPC zurueckgegeben. Konnte auf diese Weise nicht entschieden werden, ob sich um einen Spieler oder NPC handelt, wird 2 zurueckgegeben und die Liste ?comm_living der aktiven Spieler mittels ?/comm_update_living mit comm_living verschmolzen. Ein etwas verzoegerter zweiter Aufruf (das Ergebnis von %mud_short_who muss abgefangen und verarbeitet werden) von /comm_check_living mit dem gleichen Parameter sollte dann entweder 0 oder 1 zurueckgeben. Gross- und Kleinschreibung ist dabei egal, weil das MG dies leider inkonsequent handhabt.
/addh see /comm_update_living
/addh ex /let lives=$[comm_check_living("Dotz")]
/addh var %comm_last_partner, %comm_last_partner_living
/addh list comm_living, comm_non_living
/addh mak /comm_update_living, /comm_check_living2
/addh comm_check_living func

/def comm_check_living = \
    /if ({*} =/ "{der|die|das|ein|eine} *") \
        /return {*}=~"Ein Frosch"%;\
    /endif%;\
    /if (strstr({*},"@")!=-1 | {*}=~"Jemand") \
        /set comm_last_partner_living=1%;\
        /return 1%;\
    /endif%;\
    /if (comm_last_partner!~tolower({*}) | comm_last_partner_living==2) \
        /set comm_last_partner_living=$[comm_check_living2({*})]%;\
	/if (comm_last_partner_living == 2) \
; Fall "Magier mit Presay" beruecksichtigen
	    /let comm_pos=$[strstr({*}," ")]%;\
	    /set comm_last_partner_living=$[comm_check_living2(\
	        tolower(substr({*},comm_pos+1)))]%;\
;	    /if (comm_last_partner_living > 1) \
;	        /repeat -0 1 /comm_update_living%;\
;	    /endif%;\
	/endif%;\
    /endif%;\
    /set comm_last_partner=$[tolower({*})]%;\
    /return comm_last_partner_living


/def comm_check_living2 = \
;/echo >>%0: params=%*%;\
    /if (iskey("comm_living",{*}) != error) \
	/return 1%;\
    /elseif (iskey("comm_non_living",{*}) != error) \
	/return 0%;\
    /else \
	/return 2%;\
    /endif


/addh info \
Startet das %mud_short_who Kommando im Mud und grabbt dessen Ergebnis. Dieses wird dann in ?comm_living integriert. Es wird aufgerufen, wenn der Kommunikationspartner weder in ?comm_living noch in ?comm_non_living auftaucht und nicht mit "Der ", "Die ", "Das ", "Ein " oder "Eine " anfaengt.@{N}\
Damit das %mud_short_who Kommando nicht stoert, waehrend man sich im Editor befindet, sollte man ein '!' davorsetzen. Falls %mud_short_who nicht gesetzt wurde, wird "!\\kkwer" verwendet.
/addh var %fulldetail, %nextmakro, %comm_trig_number
/addh list comm_living, comm_non_living,
/addh see /comm_check_living, %mud_short_who
/addh mak /trig_grab, /tokenize, /update_living2
/addh func trig_is_active
/addh comm_update_living mak

/def comm_update_living = \
    /if (trig_is_active(comm_trig_number)) \
	/return%;\
    /endif%;\
    /trig_grab -y"r#^([A-Z][A-Za-z]+[A-Za-z0-9], ?)+\$" -e"r#^([A-Z][A-Za-z]+[A-Za-z0-9](, | und ))*([A-Z][A-Za-z]+[A-Za-z0-9][.])\$" -d" " -cye -M/comm_update_living2 -C%{mud_short_who-!\\kkwer} -F0 -ag%;\
    /set comm_trig_number=%?%;\
;/list -i trig_grab_*_%comm_trig_number


/def comm_update_living2 = \
;/echo -aCcyan >>%0: param=%*  fulldetdail=%fulldetail%;\
; Punkt am Ende loeschen und Kleinschreibung
    /set fulldetail=$[tolower(substr(fulldetail,0,strlen(fulldetail)-2))]%;\
    /if ((strstr(strcat(" ",fulldetail,","),strcat(" ",comm_last_partner,","))==-1) & (comm_last_partner!~""))\
; comm_non_living erweitern
	/xaddtolist comm_non_living&%comm_last_partner&%;\
    /else \
; comm_living erweitern
	/test tokenize(", ",fulldetail)%;\
	/let comm_tcount=$[T0+1]%;\
	/let comm_res=%;\
	/while (--comm_tcount>=1) \
	    /test comm_res:=\{T%comm_tcount\}%;\
	    /if (iskey("comm_living",comm_res) == error) \
		/addtolist comm_living %comm_res%;\
	    /endif%;\
	    /deletekeyandvalue comm_non_living %comm_res%;\
	/done%;\
    /endif

 
/addh info \
Damit bei laengeren Mitteilungen nicht fuer jede Zeile ein %mud_short_who ans Mud gesendet und die Ausgabe gegrabbt wird, steht in %comm_trig_number die Nummer des letzten Grab-Triggers. Damit kann getestet werden, ob das Grabben bereits beendet wurde oder nicht.
/addh see /comm_update_living, /trig_is_active, /trig_grab
/addh comm_trig_number var

/set comm_trig_number=


/addh info \
Enthaelt den Namen des letzten Kommunikationspartners.
/addh comm_last_partner var

/set comm_last_partner=


/addh info \
Ist 0, falls ?%comm_last_partner ein NPC ist, sonst 1. Falls dies nicht festgestellt werden konnte, ist der Wert 2.
/addh see %comm_last_partner
/addh comm_last_partner_living var

/set comm_last_partner_living=2


/addh info \
Listet die Mitteilungen des als Parameter angegebenen Spielers (wenn keiner angegeben, dann alle) der letzten halben Stunde oder der angegebenen Zeit auf.
/addh syn /comm_tm* [spieler [zeit]]
/addh ex /comm_tm* mesirii 1:00
/addh comm_tm* comm

/defh comm_tm* = \
    /recall -t -ag -mglob %{2-0:30} {%1* teilt Dir mit:|Du teilst %1* mit:}*


/addh info \
Listet die "sag" des als Parameter angegebenen Spieler (wenn keiner angegeben, dann alle) der letzten halben Stunde oder der angegebenen Zeit auf.
/addh syn /comm_sag* [Spieler [zeit]]
/addh ex /comm_sag* mesirii 1:00
/addh comm_sag* comm

/defh comm_sag* = \
    /recall -t -ag -mglob %{2-0:30} {%1* sagt:|Du sagst:}*


/addh info \
Listet jede Zeile, in der der als Parameter angegebene Spieler (wenn keiner angegeben, dann alle) auftaucht, der letzten halben Stunde oder der angegebenen Zeit auf.
/addh syn /comm_p* [Spieler [zeit]]
/addh ex /comm_p* mesirii 1:00
/addh comm_p* comm

/defh comm_p* = \
    /recall -t -g -mglob %{2-0:30} *%1*


/addh info \
Ersetzt im uebergebenen String alle '@' durch '@@@@'. Dies hat zur Folge, dass der String mit "/echo -p" ausgegeben werden kann, ohne dass evtl. vorkommende Attribute interpretiert werden.
/addh ex Die Zeile@{N}\
/echo -p @@{Ccyan}$[comm_printable_attributes("nicht @@{Cred}rot")]@{N}\
erzeugt als Ausgabe@{N}\
@{Ccyan}nicht @@{Cred}rot@{x}
/addh return String, in dem die Attribute durch "/echo -p" ausgegeben statt interpretiert werden
/addh see /remove_attributes
/addh comm_printable_attributes func

/def comm_printable_attributes = \
    /return replace("@","@@",{*})

/addh info \
Dieses Flag ist 1, falls man gerade einen Artikel in der MPA liest, 2, falls man eine Mail liest, und 0 sonst.
/addh see /comm_t_mpa, /comm_t_mail
/addh comm_mpa_mail var

/set_var comm_mpa_mail 0


/addh info \
Dieser Trigger sorgt dafuer, dass Zeilen wie@{N}\
XXX teilt Dir mit: blabla@{N}\
YYY sagt: FidKG@{N}\
und aehnliche in MPA-Artikeln weder eingefaerbt noch mitgeloggt werden.
/addh mak /comm_mpa_mail
/addh see /comm_t_mail
/addh var %comm_mpa_mail
/addh comm_t_mpa trig

/def -F -p5 -mregexp -t"^Rubrik [0-9]+: [^,]+, Artikel: [0-9]+ von [0-9]+$" \
    comm_t_mpa = \
; Diese Zeilen soll nicht ins Ebenenlog.
    /def -1 -p8 -mglob -t"\\\\[Autor: * verlegt von *" comm_t_mpa1%;\
    /def -1 -p8 -mglob -t"\\\\[Bezug: Artikel in * von * vom *" comm_t_mpa2%;\
    /def -1 -msimple -t"" comm_t_mpa3 = \
        /purge -mglob comm_t_mpa[1-3]%;\
    /comm_mpa_mail 1


/addh info \
Dieser Trigger sorgt dafuer, dass Zeilen wie@{N}\
XXX teilt Dir mit: blabla@{N}\
YYY sagt: FidKG@{N}\
und aehnliche in Mails weder eingefaerbt noch mitgeloggt werden.
/addh mak /comm_mpa_mail
/addh see /comm_t_mpa
/addh var %comm_mpa_mail
/addh comm_t_mail trig

/def -F -p5 -mglob -t"Absender: *" comm_t_mail = \
    /def -1 -F -p5 -mglob -t"An: *" comm_t_mail1 = \
        /def -1 -F -p5 -mglob -t"Datum: *" comm_t_mail2 = \
	    /def -1 -F -p5 -mglob -t"Titel:*" comm_t_mail3 = \
	        /comm_mpa_mail 2%;\
    /repeat -1 1 /purge -mglob comm_t_mail[1-3]


/addh info \
Dieses Makro definiert zwei Hooks, die das Flag ?%comm_mpa_mail ein- und ausschalten. (Beim Erscheinen des More-Prompts wird z.B. %comm_mpa_mail auf 0 gesetzt.)
/addh see /comm_t_mpa, /comm_t_mail
/addh var %comm_mpa_mail
/addh comm_mpa_mail mak

/def comm_mpa_mail = \
    /set comm_mpa_mail=%1%;\
    /def -F -E(comm_mpa_mail) -p9999 -mglob -q -hPROMPT comm_h_mpa_mail1 = \
        /set comm_mpa_mail=0%%;\
        /if ({*} =~ ">" | regmatch("^\\\\(.+:[0-9]+/[0-9]+\\\\) \
	    \\\\[Hilfe mit h\\\\] =>$$",{*})) \
	    /purge -mglob comm_h_mpa_mail[1-2]%%;\
	/endif%;\
    /def -F -E(!comm_mpa_mail) -p9999 -msimple -h"SEND " -q \
        comm_h_mpa_mail2 = \
        /set comm_mpa_mail=%1


/addh info \
Gibt 1 zurueck, falls der uebergebene Text mit '.', '!' oder '?' aufhoert.
/addh comm_satzende func

/def comm_satzende = \
    /return $[substr({*},-1) =/ "{.|!|\\?}"]

/addh info \
Dieser Befehl entfernt saemtliche Trigger, Makros und Variablen, die von comm.tf genutzt werden.
/addh mak /remove_packet, /remove_window
/addh comm_remove comm

/def comm_remove = \
    /remove_window %comm_window_name%;\
    /remove_packet comm set_comm_window



/addh info \
Enthaelt Befehle, die die Kommunikation mitloggen bzw. vergangene Kommunikation anzeigen. Dabei wird herausgefunden, ob die Kommunikationspartner NPC's sind. In diesem Fall wird die Kommunikation nicht geloggt.@{N}\
Konfiguration der Farben mittels der Variablen ?%comm_(sag|tm|frufe|stm)_colors, %comm_color_lines, der Liste ?comm_ebenen_list und ggf. %comm_matrix in comm.cfg (siehe jeweilige Hilfe).
/addh var %comm_sag_colors, %comm_tm_colors, %comm_frufe_colors, %comm_stm_colors, %comm_femote_colors, %comm_remote_colors, %comm_color_lines, %comm_beep_teilemit, %comm_last_partner, %comm_last_partner_living, %comm_window, %comm_ebenen_window, %comm_matrix
/addh list comm_living, comm_non_living, comm_ebenen_list
/addh comm /comm_p*, /comm_tm*, /comm_sag*, /comm_remove, /comm_add_ebene
/addh trig /comm_t_sagt, /comm_t_fragt, /comm_t_fluestert, /comm_t_teilemit, /comm_t_teilemit2, /comm_t_ebene, /comm_an_matrix, /comm_von_matrix, /comm_t_femote1, /comm_t_femote2, /comm_t_remote1, /comm_t_remote2
/addh mak /comm_write, /comm_write_ebene, /check_living, /update_living, /comm_format_ebene
/eval /addh req %comm_tf_requires
/addh changes  1.43: %comm_echo_colors in die vier Variablen %comm_(sag|tm|frufe|stm)_colors aufgespalten. An neues Config-System angepasst.@{N}\
1.54: femotes und remotes koennen jetzt auch eingefaerbt werden.
/addh_fileinfo

