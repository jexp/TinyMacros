; $Log: status_zauberer.tf,v $
; Revision 1.33  2004/01/10 15:24:16  thufhnik
; Missing & in extrahand
;
; Revision 1.32  2003/10/19 11:10:39  thufhnik
; Trigger fuer Schmerzen
;
; Revision 1.31  2003/07/12 12:17:29  thufhnik
; p_sub_guil muss "verwandlung" und nicht "wandlung" heissen
;
; Revision 1.30  2003/07/10 09:36:40  thufhnik
; Typo im zrufe-trigger (wenn kein comm.tf benutzt wird)
; Meldung wenn im Kampf zu dunkel (-> Hook: too_dark)
;
; Revision 1.29  2003/06/24 11:40:00  thufhnik
; Gefaehrte
; Magisterspruchtrigger werden nur noch geladen wenn p_sub_guild entspricht
;
; Revision 1.28  2003/06/12 13:58:22  thufhnik
; hngl, bug in den schutzzaubern in der letzten version eingebaut gehabt
;
; Revision 1.27  2003/06/10 14:25:38  thufhnik
; Feuerwalze
;
; Revision 1.26  2003/01/10 16:56:49  olm
; Ruestetrigger, macht daraus auch nur eine Zeile.
;
; Revision 1.25  2003/01/09 20:27:44  olm
; zrufe wird nur noch an comm.tf uebergeben. wenn diese auch geladen ist,
; ansonsten wird der alte Trigger verwendet. Danke an Asuka :)
;
; Revision 1.24  2003/01/05 01:21:46  olm
; zrufe an die Ebenen-Darstellung der comm.tf angepasst (analog Matrixkreis)
; (an- und abzuschalten per comm_zrufe)
;
; Revision 1.23  2002/11/20 12:42:36  thufhnik
; Neue Meldung fuer fehlende Kompos.
;
; Revision 1.22  2002/09/16 11:29:22  thufhnik
; kein gescrolle mehr beim einstellen des stabreports
;
; Revision 1.21  2002/09/11 12:01:51  thufhnik
; Triggerkosmetik
;
; Revision 1.20  2002/09/11 11:32:55  thufhnik
; Stabschaden Saeure
;
; Revision 1.19  2002/09/10 11:19:21  thufhnik
; Kosmetische Aenderung im Statusmodul zauberer_stabschaden
;
; Revision 1.18  2002/09/10 11:07:10  thufhnik
; Statusmodul zauberer_stabschaden, in der status_zauberer.cfg das W durch
; {zauberer_stabschaden} ersetzen und es zeigt farbig den stabschaden mit an
;
; Revision 1.17  2002/08/01 08:09:05  thufhnik
; Typ in Verzoegerung
;
; Revision 1.16  2002/05/30 21:05:40  thufhnik
; sauberere behandlung von p_free_hands in extrahand
;
; Revision 1.15  2002/05/30 08:31:33  thufhnik
; Bugfix in abklingendem Zauberschild
;
; Revision 1.14  2002/05/29 13:45:36  thufhnik
; Alle Ausgaben und Flags konfigurierbar
;
; Revision 1.13  2002/05/12 11:48:35  thufhnik
; nach jedem Spell wird jetzt der Hook spell ausgewertet
;
; Revision 1.12  2002/04/20 15:41:32  thufhnik
; 1. Anpassung an /configure
;
; Revision 1.11  2002/04/12 14:28:57  thufhnik
; bug in saeureghand. ;(
;
; Revision 1.10  2002/04/12 13:58:02  thufhnik
; Farben fuer Elemente eingebaut
;
; Revision 1.9  2002/04/12 12:42:40  thufhnik
; diverse Ergaenzungen zu Magisterspruechen
;
; Revision 1.8  2002/04/12 10:10:16  thufhnik
; p_smp und p_maxsmp sind im hook points jetzt schon gesetzt
;
; Revision 1.7  2002/04/11 17:58:42  mh14
; Stabmagiepunkte als 3-stellige Anzeige auch bei grossen Zahlen per {zauberer_stabmagie3}
;
; Revision 1.6  2002/03/21 12:20:11  thufhnik
; Stabmagiepunkte > 999 werden jetzt mit +++ angezeigt
;
; Revision 1.5  2002/03/13 16:07:03  thufhnik
; diverse Erweiterungen
;
; Revision 1.4  2002/03/04 07:22:13  thufhnik
; autokampf fuer: extrahand, schutz, schutzhuelle, wille
;
; Revision 1.3  2002/02/15 12:39:30  thufhnik
; Doku zu den Status-Modulen
;
; Revision 1.2  2002/02/10 20:17:21  thufhnik
; diverse Erweiterungen
;
; Revision 1.1  2002/02/10 14:34:51  thufhnik
; Scratch
;

/set status_zauberer_tf_version $Id$
/set status_zauberer_tf_author=Thufhir@mg.mud.de
/set status_zauberer_tf_requires=util.hooks.tf config.tf(1.16)
/set status_zauberer_tf_desc=Statuszeile und Report fuer die Zauberergilde

; Konfiguration

/set_var CFG_ECHO_GAG_LEVEL 2

; Texte und Farben fuer die Spells

; Schutzzauber
/set_var CFG_MG_ZAUBERER_SCHUTZ_ALR_ECHO_ATTR Cyellow
/set_var CFG_MG_ZAUBERER_SCHUTZ_ALR_ECHO_TEXT Schutzzauber bereits vorhanden

; Schutz
/set_var CFG_MG_ZAUBERER_SCHUTZ_ECHO_ATTR Cgreen
/set_var CFG_STATUS_TEXT_ZAUBERER_SCHUTZ_1 s
/set_var CFG_STATUS_COLOR_ZAUBERER_SCHUTZ_1 Cgreen
/set_var CFG_MG_ZAUBERER_SCHUTZ_1_ECHO_TEXT Schutz (-)
/set_var CFG_MG_ZAUBERER_SCHUTZ_1_ECHO_ATTR Cbggreen,Cwhite
/set_var CFG_MG_ZAUBERER_SCHUTZ_2_ECHO_TEXT Schutz
/set_var CFG_MG_ZAUBERER_SCHUTZ_2_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_SCHUTZ_3_ECHO_TEXT Schutz (+)
/set_var CFG_MG_ZAUBERER_SCHUTZ_3_ECHO_ATTR Cgreen,h
/set_var CFG_MG_ZAUBERER_SCHUTZ_4_ECHO_TEXT Schutz (++)
/set_var CFG_MG_ZAUBERER_SCHUTZ_4_ECHO_ATTR Cgreen,h
/set_var CFG_MG_ZAUBERER_SCHUTZ_AUS_ECHO_TEXT Schutz aus
/set_var CFG_MG_ZAUBERER_SCHUTZ_AUS_ECHO_ATTR Cred

; Schutzhuelle
/set_var CFG_MG_ZAUBERER_SCHUTZHUELLE_ECHO_ATTR Cgreen
/set_var CFG_STATUS_TEXT_ZAUBERER_SCHUTZ_2 S
/set_var CFG_STATUS_COLOR_ZAUBERER_SCHUTZ_2 Cgreen
/set_var CFG_MG_ZAUBERER_SCHUTZHUELLE_0_ECHO_TEXT Schutzhuelle (--)
/set_var CFG_MG_ZAUBERER_SCHUTZHUELLE_0_ECHO_ATTR Cbgblack,Cred
/set_var CFG_MG_ZAUBERER_SCHUTZHUELLE_1_ECHO_TEXT Schutzhuelle (-)
/set_var CFG_MG_ZAUBERER_SCHUTZHUELLE_1_ECHO_ATTR Cbggreen,Cwhite
/set_var CFG_MG_ZAUBERER_SCHUTZHUELLE_2_ECHO_TEXT Schutzhuelle
/set_var CFG_MG_ZAUBERER_SCHUTZHUELLE_2_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_SCHUTZHUELLE_3_ECHO_TEXT Schutzhuelle (+)
/set_var CFG_MG_ZAUBERER_SCHUTZHUELLE_3_ECHO_ATTR Cgreen,h
/set_var CFG_MG_ZAUBERER_SCHUTZHUELLE_4_ECHO_TEXT Schutzhuelle (++)
/set_var CFG_MG_ZAUBERER_SCHUTZHUELLE_4_ECHO_ATTR Cgreen,h
/set_var CFG_MG_ZAUBERER_SCHUTZHUELLE_AUS_ECHO_TEXT Schutzhuelle aus
/set_var CFG_MG_ZAUBERER_SCHUTZHUELLE_AUS_ECHO_ATTR Cred

; Extrahand
/set_var CFG_STATUS_COLOR_ZAUBERER_EXTRAHAND_1 Cgreen
/set_var CFG_STATUS_TEXT_ZAUBERER_EXTRAHAND_1 X
/set_var CFG_MG_ZAUBERER_EXTRAHAND_ECHO_TEXT Extrahand
/set_var CFG_MG_ZAUBERER_EXTRAHAND_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_EXTRAHAND_AUS_ECHO_TEXT Extrahand aus
/set_var CFG_MG_ZAUBERER_EXTRAHAND_AUS_ECHO_ATTR Cred
/set_var CFG_MG_ZAUBERER_EXTRAHAND_ALR_ECHO_TEXT Extrahand schon vorhanden
/set_var CFG_MG_ZAUBERER_EXTRAHAND_ALR_ECHO_ATTR Cyellow

; Wille
/set_var CFG_STATUS_COLOR_ZAUBERER_WILLE_1 Cyellow
/set_var CFG_STATUS_TEXT_ZAUBERER_WILLE_1 W
/set_var CFG_MG_ZAUBERER_WILLE_ECHO_TEXT Wille
/set_var CFG_MG_ZAUBERER_WILLE_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_WILLE_AUS_ECHO_TEXT Wille aus
/set_var CFG_MG_ZAUBERER_WILLE_AUS_ECHO_ATTR Cred
/set_var CFG_MG_ZAUBERER_WILLE_ALR_ECHO_TEXT Wille schon an
/set_var CFG_MG_ZAUBERER_WILLE_ALR_ECHO_ATTR Cyellow

; Schnell
/set_var CFG_STATUS_COLOR_ZAUBERER_SCHNELL_1 Cmagenta
/set_var CFG_STATUS_TEXT_ZAUBERER_SCHNELL_1 S
/set_var CFG_MG_ZAUBERER_SCHNELL_ECHO_TEXT Schnell
/set_var CFG_MG_ZAUBERER_SCHNELL_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_SCHNELL_AUS_ECHO_TEXT Schnell aus
/set_var CFG_MG_ZAUBERER_SCHNELL_AUS_ECHO_ATTR Cred
/set_var CFG_MG_ZAUBERER_SCHNELL_ALR_ECHO_TEXT Schnell schon an
/set_var CFG_MG_ZAUBERER_SCHNELL_ALR_ECHO_ATTR Cyellow

; Schattenkaempfer
/set_var CFG_MG_ZAUBERER_SCHATTEN_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_SCHATTEN_1_ECHO_TEXT Schattenkaempfer schwach
/set_var CFG_MG_ZAUBERER_SCHATTEN_1_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_SCHATTEN_2_ECHO_TEXT Schattenkaempfer kraeftig
/set_var CFG_MG_ZAUBERER_SCHATTEN_2_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_SCHATTEN_3_ECHO_TEXT Schattenkaempfer stark 
/set_var CFG_MG_ZAUBERER_SCHATTEN_3_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_SCHATTEN_ALR_ECHO_TEXT Schattenkaempfer schon vorhanden
/set_var CFG_MG_ZAUBERER_SCHATTEN_ALR_ECHO_ATTR Cyellow

; Zauberschild
/set_var CFG_MG_ZAUBERER_ZSCHILD_ECHO_ATTR Cgreen
/set_var CFG_STATUS_TEXT_ZAUBERER_SCHUTZ_3 Z
/set_var CFG_STATUS_COLOR_ZAUBERER_SCHUTZ_3 Cgreen
/set_var CFG_MG_ZAUBERER_ZSCHILD_1_ECHO_TEXT Zauberschild (-)
/set_var CFG_MG_ZAUBERER_ZSCHILD_1_ECHO_ATTR Cbggreen,Cwhite
/set_var CFG_MG_ZAUBERER_ZSCHILD_2_ECHO_TEXT Zauberschild
/set_var CFG_MG_ZAUBERER_ZSCHILD_2_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_ZSCHILD_3_ECHO_TEXT Zauberschild (+)
/set_var CFG_MG_ZAUBERER_ZSCHILD_3_ECHO_ATTR Cgreen,h
/set_var CFG_MG_ZAUBERER_ZSCHILD_4_ECHO_TEXT Zauberschild (++)
/set_var CFG_MG_ZAUBERER_ZSCHILD_4_ECHO_ATTR Cgreen,h
/set_var CFG_MG_ZAUBERER_ZSCHILD_AUS_ECHO_TEXT Zauberschild aus
/set_var CFG_MG_ZAUBERER_ZSCHILD_AUS_ECHO_ATTR Cred

; Feuerwalze (#1 wird durch die Richtung ersetzt)
/set_var CFG_MG_ZAUBERER_FEUERWALZE_ECHO_TEXT Feuerwalze #1
/set_var CFG_MG_ZAUBERER_FEUERWALZE_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_FEUERWALZE_MOVE_ECHO_ATTR Cbgred,Cwhite

; Farben fuer die Elemente
/set_var CFG_STATUS_COLOR_ZAUBERER_ICE Cblue,h
/set_var CFG_STATUS_COLOR_ZAUBERER_FIRE Cred
/set_var CFG_STATUS_COLOR_ZAUBERER_EARTH Cyellow
/set_var CFG_STATUS_COLOR_ZAUBERER_ACID Cgreen
/set_var CFG_STATUS_COLOR_ZAUBERER_AIR Cwhite
/set_var CFG_STATUS_COLOR_ZAUBERER_LIGHTNING Cyellow,h
/set_var CFG_STATUS_COLOR_ZAUBERER_NOISE Cmagenta,h
/set_var CFG_STATUS_COLOR_ZAUBERER_MAGIC Cmagenta
/set_var CFG_STATUS_COLOR_ZAUBERER_WATER Cblue
/set_var CFG_STATUS_COLOR_ZAUBERER_POISON Cgreen,h

; Hand
/set_var CFG_MG_ZAUBERER_HAND_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_HAND_ECHO_TEXT Hand
/set_var CFG_MG_ZAUBERER_HAND_AUS_ECHO_ATTR Cred
/set_var CFG_MG_ZAUBERER_HAND_AUS_ECHO_TEXT Hand aus
/set_var CFG_MG_ZAUBERER_HAND_ALR_ECHO_ATTR Cyellow
/set_var CFG_MG_ZAUBERER_HAND_ALR_ECHO_TEXT Haende schon verzaubert
/set_var CFG_MG_ZAUBERER_HAND_ZU_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_HAND_ZU_ECHO_TEXT Handzustand: @{B}

; Hand Feuer
/eval /set_var CFG_STATUS_COLOR_ZAUBERER_HAND_1 %CFG_STATUS_COLOR_ZAUBERER_FIRE
/set_var CFG_STATUS_TEXT_ZAUBERER_HAND_1 F
/set_var CFG_MG_ZAUBERER_HAND_FEUER_1_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_HAND_FEUER_1_ECHO_TEXT Hand @{%CFG_STATUS_COLOR_ZAUBERER_FIRE}Feuer@{n} (-3)
/set_var CFG_MG_ZAUBERER_HAND_FEUER_2_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_HAND_FEUER_2_ECHO_TEXT Hand @{%CFG_STATUS_COLOR_ZAUBERER_FIRE}Feuer@{n} (-2)
/set_var CFG_MG_ZAUBERER_HAND_FEUER_3_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_HAND_FEUER_3_ECHO_TEXT Hand @{%CFG_STATUS_COLOR_ZAUBERER_FIRE}Feuer@{n} (-1)
/set_var CFG_MG_ZAUBERER_HAND_FEUER_4_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_HAND_FEUER_4_ECHO_TEXT Hand @{%CFG_STATUS_COLOR_ZAUBERER_FIRE}Feuer@{n}
/set_var CFG_MG_ZAUBERER_HAND_FEUER_5_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_HAND_FEUER_5_ECHO_TEXT Hand @{%CFG_STATUS_COLOR_ZAUBERER_FIRE}Feuer@{n} (1)
/set_var CFG_MG_ZAUBERER_HAND_FEUER_6_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_HAND_FEUER_6_ECHO_TEXT Hand @{%CFG_STATUS_COLOR_ZAUBERER_FIRE}Feuer@{n} (2)
/set_var CFG_MG_ZAUBERER_HAND_FEUER_7_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_HAND_FEUER_7_ECHO_TEXT Hand @{%CFG_STATUS_COLOR_ZAUBERER_FIRE}Feuer@{n} (3)
/set_var CFG_MG_ZAUBERER_HAND_FEUER_8_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_HAND_FEUER_8_ECHO_TEXT Hand @{%CFG_STATUS_COLOR_ZAUBERER_FIRE}Feuer@{n} (4)
/set_var CFG_MG_ZAUBERER_HAND_FEUER_9_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_HAND_FEUER_9_ECHO_TEXT Hand @{%CFG_STATUS_COLOR_ZAUBERER_FIRE}Feuer@{n} (5)
/set_var CFG_MG_ZAUBERER_HAND_FEUER_10_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_HAND_FEUER_10_ECHO_TEXT Hand @{%CFG_STATUS_COLOR_ZAUBERER_FIRE}Feuer@{n} (6)

; Hand Eis
/eval /set_var CFG_STATUS_COLOR_ZAUBERER_HAND_2 %CFG_STATUS_COLOR_ZAUBERER_ICE
/set_var CFG_STATUS_TEXT_ZAUBERER_HAND_2 E
/set_var CFG_MG_ZAUBERER_HAND_EIS_1_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_HAND_EIS_1_ECHO_TEXT Hand @{%CFG_STATUS_COLOR_ZAUBERER_ICE}Eis@{n} (-3)
/set_var CFG_MG_ZAUBERER_HAND_EIS_2_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_HAND_EIS_2_ECHO_TEXT Hand @{%CFG_STATUS_COLOR_ZAUBERER_ICE}Eis@{n} (-2)
/set_var CFG_MG_ZAUBERER_HAND_EIS_3_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_HAND_EIS_3_ECHO_TEXT Hand @{%CFG_STATUS_COLOR_ZAUBERER_ICE}Eis@{n} (-1)
/set_var CFG_MG_ZAUBERER_HAND_EIS_4_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_HAND_EIS_4_ECHO_TEXT Hand @{%CFG_STATUS_COLOR_ZAUBERER_ICE}Eis@{n}
/set_var CFG_MG_ZAUBERER_HAND_EIS_5_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_HAND_EIS_5_ECHO_TEXT Hand @{%CFG_STATUS_COLOR_ZAUBERER_ICE}Eis@{n} (1)
/set_var CFG_MG_ZAUBERER_HAND_EIS_6_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_HAND_EIS_6_ECHO_TEXT Hand @{%CFG_STATUS_COLOR_ZAUBERER_ICE}Eis@{n} (2)
/set_var CFG_MG_ZAUBERER_HAND_EIS_7_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_HAND_EIS_7_ECHO_TEXT Hand @{%CFG_STATUS_COLOR_ZAUBERER_ICE}Eis@{n} (3)
/set_var CFG_MG_ZAUBERER_HAND_EIS_8_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_HAND_EIS_8_ECHO_TEXT Hand @{%CFG_STATUS_COLOR_ZAUBERER_ICE}Eis@{n} (4)
/set_var CFG_MG_ZAUBERER_HAND_EIS_9_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_HAND_EIS_9_ECHO_TEXT Hand @{%CFG_STATUS_COLOR_ZAUBERER_ICE}Eis@{n} (5)
/set_var CFG_MG_ZAUBERER_HAND_EIS_10_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_HAND_EIS_10_ECHO_TEXT Hand @{%CFG_STATUS_COLOR_ZAUBERER_ICE}Eis@{n} (6)

; Hand Saeure
/eval /set_var CFG_STATUS_COLOR_ZAUBERER_HAND_3 %CFG_STATUS_COLOR_ZAUBERER_ACID
/set_var CFG_STATUS_TEXT_ZAUBERER_HAND_3 S
/set_var CFG_MG_ZAUBERER_HAND_SAEURE_1_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_HAND_SAEURE_1_ECHO_TEXT Hand @{%CFG_STATUS_COLOR_ZAUBERER_ACID}Saeure@{n} (-3)
/set_var CFG_MG_ZAUBERER_HAND_SAEURE_2_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_HAND_SAEURE_2_ECHO_TEXT Hand @{%CFG_STATUS_COLOR_ZAUBERER_ACID}Saeure@{n} (-2)
/set_var CFG_MG_ZAUBERER_HAND_SAEURE_3_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_HAND_SAEURE_3_ECHO_TEXT Hand @{%CFG_STATUS_COLOR_ZAUBERER_ACID}Saeure@{n} (-1)
/set_var CFG_MG_ZAUBERER_HAND_SAEURE_4_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_HAND_SAEURE_4_ECHO_TEXT Hand @{%CFG_STATUS_COLOR_ZAUBERER_ACID}Saeure@{n}
/set_var CFG_MG_ZAUBERER_HAND_SAEURE_5_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_HAND_SAEURE_5_ECHO_TEXT Hand @{%CFG_STATUS_COLOR_ZAUBERER_ACID}Saeure@{n} (1)
/set_var CFG_MG_ZAUBERER_HAND_SAEURE_6_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_HAND_SAEURE_6_ECHO_TEXT Hand @{%CFG_STATUS_COLOR_ZAUBERER_ACID}Saeure@{n} (2)
/set_var CFG_MG_ZAUBERER_HAND_SAEURE_7_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_HAND_SAEURE_7_ECHO_TEXT Hand @{%CFG_STATUS_COLOR_ZAUBERER_ACID}Saeure@{n} (3)
/set_var CFG_MG_ZAUBERER_HAND_SAEURE_8_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_HAND_SAEURE_8_ECHO_TEXT Hand @{%CFG_STATUS_COLOR_ZAUBERER_ACID}Saeure@{n} (4)
/set_var CFG_MG_ZAUBERER_HAND_SAEURE_9_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_HAND_SAEURE_9_ECHO_TEXT Hand @{%CFG_STATUS_COLOR_ZAUBERER_ACID}Saeure@{n} (5)
/set_var CFG_MG_ZAUBERER_HAND_SAEURE_10_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_HAND_SAEURE_10_ECHO_TEXT Hand @{%CFG_STATUS_COLOR_ZAUBERER_ACID}Saeure@{n} (6)

; Licht
/set_var CFG_MG_ZAUBERER_LICHT_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_LICHT_ECHO_TEXT Licht

; Illusion 
/set_var CFG_MG_ZAUBERER_ILLUSION_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_ILLUSION_ECHO_TEXT Illusion

; Stabschaden
/set_var CFG_MG_ZAUBERER_SSCHADEN_LAERM_ECHO_TEXT Stabschaden @{%CFG_STATUS_COLOR_ZAUBERER_NOISE}Laerm@{n}
/set_var CFG_MG_ZAUBERER_SSCHADEN_LAERM_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_SSCHADEN_BLITZ_ECHO_TEXT Stabschaden @{%CFG_STATUS_COLOR_ZAUBERER_LIGHTNING}Blitz@{n}
/set_var CFG_MG_ZAUBERER_SSCHADEN_BLITZ_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_SSCHADEN_WIND_ECHO_TEXT Stabschaden @{%CFG_STATUS_COLOR_ZAUBERER_AIR}Luft@{n}
/set_var CFG_MG_ZAUBERER_SSCHADEN_WIND_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_SSCHADEN_EIS_ECHO_TEXT Stabschaden @{%CFG_STATUS_COLOR_ZAUBERER_ICE}Eis@{n}
/set_var CFG_MG_ZAUBERER_SSCHADEN_EIS_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_SSCHADEN_FEUER_ECHO_TEXT Stabschaden @{%CFG_STATUS_COLOR_ZAUBERER_FIRE}Feuer@{n}
/set_var CFG_MG_ZAUBERER_SSCHADEN_FEUER_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_SSCHADEN_WASSER_ECHO_TEXT Stabschaden @{%CFG_STATUS_COLOR_ZAUBERER_WATER}Wasser@{n}
/set_var CFG_MG_ZAUBERER_SSCHADEN_WASSER_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_SSCHADEN_MAGIE_ECHO_TEXT Stabschaden @{%CFG_STATUS_COLOR_ZAUBERER_MAGIC}Magie@{n}
/set_var CFG_MG_ZAUBERER_SSCHADEN_MAGIE_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_SSCHADEN_GIFT_ECHO_TEXT Stabschaden @{%CFG_STATUS_COLOR_ZAUBERER_POISON}Gift@{n}
/set_var CFG_MG_ZAUBERER_SSCHADEN_GIFT_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_SSCHADEN_SAEURE_ECHO_TEXT Stabschaden @{%CFG_STATUS_COLOR_ZAUBERER_ACID}Saeure@{n}
/set_var CFG_MG_ZAUBERER_SSCHADEN_SAEURE_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_SSCHADEN_AUS_ECHO_TEXT Stabschaden aus
/set_var CFG_MG_ZAUBERER_SSCHADEN_AUS_ECHO_ATTR Cred
/set_var CFG_MG_ZAUBERER_SSCHADEN_ALR_ECHO_TEXT Stabschaden schon eingestellt
/set_var CFG_MG_ZAUBERER_SSCHADEN_ALR_ECHO_ATTR Cyellow

; Schmerzen
/set_var CFG_MG_ZAUBERER_SCHMERZEN_ECHO_TEXT Schmerzen: #1
/set_var CFG_MG_ZAUBERER_SCHMERZEN_ECHO_ATTR Cgreen

; Vorahnung
/set_var CFG_STATUS_TEXT_ZAUBERER_SCHUTZ_4 V
/set_var CFG_STATUS_COLOR_ZAUBERER_SCHUTZ_4 Cgreen

; Irritiere
/set_var CFG_MG_ZAUBERER_IRRITIERE_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_IRRITIERE_ECHO_TEXT Irritiere

; Gefaehrte
/set_var CFG_MG_ZAUBERER_GEFAEHRTE_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_GEFAEHRTE_ECHO_TEXT Gefaehrte

; Schutzzone
/set_var CFG_MG_ZAUBERER_SCHUTZZONE_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_SCHUTZZONE_ECHO_TEXT Schutzzone
/set_var CFG_MG_ZAUBERER_SCHUTZZONE_AUS_ECHO_ATTR Cred
/set_var CFG_MG_ZAUBERER_SCHUTZZONE_AUS_ECHO_TEXT Schutzzone aus

; Wandlung
/set_var CFG_MG_ZAUBERER_WANDLUNG_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_WANDLUNG_BLITZ_ECHO_TEXT Wandlung @{%CFG_STATUS_COLOR_ZAUBERER_LIGHTNING}Blitz@{n}
/set_var CFG_MG_ZAUBERER_WANDLUNG_BLITZ_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_WANDLUNG_FEUER_ECHO_TEXT Wandlung @{%CFG_STATUS_COLOR_ZAUBERER_FIRE}Feuer@{n}
/set_var CFG_MG_ZAUBERER_WANDLUNG_FEUER_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_WANDLUNG_LUFT_ECHO_TEXT Wandlung @{%CFG_STATUS_COLOR_ZAUBERER_AIR}Luft@{n}
/set_var CFG_MG_ZAUBERER_WANDLUNG_LUFT_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_WANDLUNG_EIS_ECHO_TEXT Wandlung @{%CFG_STATUS_COLOR_ZAUBERER_ICE}Eis@{n}
/set_var CFG_MG_ZAUBERER_WANDLUNG_EIS_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_WANDLUNG_ERDE_ECHO_TEXT Wandlung @{%CFG_STATUS_COLOR_ZAUBERER_EARTH}Erde@{n}
/set_var CFG_MG_ZAUBERER_WANDLUNG_ERDE_ECHO_ATTR Cgreen
/set_var CFG_MG_ZAUBERER_WANDLUNG_WASSER_ECHO_TEXT Wandlung @{%CFG_STATUS_COLOR_ZAUBERER_WATER}Wasser@{n}
/set_var CFG_MG_ZAUBERER_WANDLUNG_WASSER_ECHO_ATTR Cgreen

; Lernen
/set_var CFG_MG_ZAUBERER_LEARN_ECHO_ATTR Cbggreen,Cwhite

; Fehlende Kompos
/set_var CFG_MG_ZAUBERER_MISSING_KOMPO_ECHO_ATTR Cred
/set_var CFG_MG_ZAUBERER_MISSING_KOMPO_ECHO_TEXT Fehlende Komponenten

; Nicht standesgemaesse Waffen / Ruestung
/set_var CFG_MG_ZAUBERER_WRONG_ARMOR_ECHO_ATTR Cbgred,Cwhite
/set_var CFG_MG_ZAUBERER_WRONG_ARMOR_ECHO_TEXT Nicht standesgemaesse Waffen / Ruestungen!

; Abgeschwaechter Angriff durch Dunkelheit
/set_var CFG_MG_ZAUBERER_TOO_DARK_ECHO_ATTR Cbgred,Cwhite
/set_var CFG_MG_ZAUBERER_TOO_DARK_ECHO_TEXT Abgeschwaechter Angriff durch Dunkelheit!

; zemotes und zrufe
/set_var CFG_MG_ZAUBERER_ZEMOTE_ECHO_ATTR Ccyan
/set_var comm_zrufe 1

; Rueste
/set_var CFG_MG_ZAUBERER_RUESTE_ECHO_ATTR Cgreen

; Erschoepfung
/set_var CFG_MG_ZAUBERER_ERSCHOEPFUNG_1_ECHO_ATTR Cred
/set_var CFG_MG_ZAUBERER_ERSCHOEPFUNG_1_ECHO_TEXT Erschoepfung (+++++)
/set_var CFG_MG_ZAUBERER_ERSCHOEPFUNG_2_ECHO_ATTR Cred
/set_var CFG_MG_ZAUBERER_ERSCHOEPFUNG_2_ECHO_TEXT Erschoepfung (++++)
/set_var CFG_MG_ZAUBERER_ERSCHOEPFUNG_3_ECHO_ATTR Cred
/set_var CFG_MG_ZAUBERER_ERSCHOEPFUNG_3_ECHO_TEXT Erschoepfung (+++)
/set_var CFG_MG_ZAUBERER_ERSCHOEPFUNG_4_ECHO_ATTR Cred
/set_var CFG_MG_ZAUBERER_ERSCHOEPFUNG_4_ECHO_TEXT Erschoepfung (++)
/set_var CFG_MG_ZAUBERER_ERSCHOEPFUNG_5_ECHO_ATTR Cred
/set_var CFG_MG_ZAUBERER_ERSCHOEPFUNG_5_ECHO_TEXT Erschoepfung (+)
/set_var CFG_MG_ZAUBERER_ERSCHOEPFUNG_6_ECHO_ATTR Cred
/set_var CFG_MG_ZAUBERER_ERSCHOEPFUNG_6_ECHO_TEXT Erschoepfung
/set_var CFG_MG_ZAUBERER_ERSCHOEPFUNG_7_ECHO_ATTR Cred
/set_var CFG_MG_ZAUBERER_ERSCHOEPFUNG_7_ECHO_TEXT Erschoepfung (-)
/set_var CFG_MG_ZAUBERER_ERSCHOEPFUNG_8_ECHO_ATTR Cred
/set_var CFG_MG_ZAUBERER_ERSCHOEPFUNG_8_ECHO_TEXT Erschoepfung (--)

; Konzentration
/set_var CFG_MG_ZAUBERER_KONZENTRATION_ECHO_ATTR Cred
/set_var CFG_MG_ZAUBERER_KONZENTRATION_ECHO_TEXT @{B}Vorbereitung:@{n}

; Abbruch
/set_var CFG_MG_ZAUBERER_ABBRUCH_ECHO_ATTR Cred
/set_var CFG_MG_ZAUBERER_ABBRUCH_ECHO_TEXT @{B}Abbruch:@{n}

; Verzoegrung
/set_var CFG_MG_ZAUBERER_VERZOEGERUNG_ECHO_ATTR Cyellow
/set_var CFG_MG_ZAUBERER_VERZOEGERUNG_ECHO_TEXT @{B}Verzoegerung:@{n}

; Parawelt im Fluchtest
/set_var CFG_MG_ZAUBERER_PARA_ECHO_ATTR Cbgred,Cwhite

; Unterstuetzender Zauberstab
/set_var CFG_MG_ZAUBERER_STAB_ECHO_ATTR g

; String fuer Statusmodul Stabschaden
/set_var CFG_STATUS_TEXT_ZAUBERER_STABSCHADEN W

;;; Variablen initialisieren

/set zauberer_schutz 0
/set zauberer_hand 0
/set zauberer_extrahand 0
/set zauberer_erschoepfung 0
/set zauberer_schnell 0
/eval /set zauberer_stabschaden=%CFG_STATUS_TEXT_ZAUBERER_STABSCHADEN
/set p_smp 0
/set p_maxsmp 0

; Statusmodule

/set sl_zauberer_schutz_doc=Aktiver Schutzzauber Schutz: $[status_doc_attr("ZAUBERER_SCHUTZ_1")] Schutzhuelle: $[status_doc_attr("ZAUBERER_SCHUTZ_2")] Zauberschild: $[status_doc_attr("ZAUBERER_SCHUTZ_3")] Vorahnung: $[status_doc_attr("ZAUBERER_SCHUTZ_4")]
/def sl_zauberer_schutz = \
	/set_status_var_count zauberer_schutz zauberer_schutz 1 4

/set sl_zauberer_extrahand_doc=Extrahand $[status_doc_attr("ZAUBERER_EXTRAHAND_1")] 
/def sl_zauberer_extrahand = \
	/set_status_var_flag zauberer_extrahand zauberer_extrahand 1

/set sl_zauberer_schnell_doc=Schnellzauber $[status_doc_attr("ZAUBERER_SCHNELL_1")]
/def sl_zauberer_schnell = \
	/set_status_var_flag zauberer_schnell zauberer_schnell 1

/set sl_zauberer_hand_doc=Handzauber Feuer: $[status_doc_attr("ZAUBERER_HAND_1")] Eis: $[status_doc_attr("ZAUBERER_HAND_2")] Saeure: $[status_doc_attr("ZAUBERER_HAND_3")]
/def sl_zauberer_hand = \
	/set_status_var_count zauberer_hand zauberer_hand 1 3

/set sl_zauberer_wille_doc=Wille $[status_doc_attr("ZAUBERER_WILLE_1")] 
/def sl_zauberer_wille = \
	/set_status_var_flag zauberer_wille zauberer_wille 1

/set sl_zauberer_stabmagie_doc=Stabmagiepunkte (grau hinterlegt bei Magistersperre)
/def sl_zauberer_stabmagie = \
	/init_var p_smp%;\
	/set status_func_p_smp=p_smp>999?"+++":p_smp%;\
	/set status_attr_p_smp=zauberer_erschoepfung?"Cbgwhite,Cblack":\
		"Cgreen"%;\
	/return status_var("p_smp",3)

/set sl_zauberer_stabmagie3_doc=Stabmagiepunkte (grau hinterlegt bei Magistersperre)
/def sl_zauberer_stabmagie3 = \
	/init_var p_smp%;\
	/set status_func_p_smp=format_number3(p_smp)%;\
	/set status_attr_p_smp=zauberer_erschoepfung?"Cbgwhite,Cblack":\
		"Cgreen"%;\
	/return status_var("p_smp",3)

/def sl_zauberer_stabschaden = \
	/set status_attr_zauberer_stabschaden="n"%;\
	/return status_var("zauberer_stabschaden",1)

; Stabreport auf die Trigger einstellen

/def zauberer_set_report = \
	/def -1 -p100 -q -w -agCblue -msimple -t'OK. Stabreportzeile neu \
		eingestellt.' zauberer_set_report_gag%;\
	/def -1 -p100 -q -w -agCblue -msimple -t'OK, Stabreport \
		eingeschaltet.' zauberer_set_report_gag2 = \
		/purge zauberer_set_report_gag3%;\
	/def -1 -p100 -q -w -agCblue -msimple -t'Stabreport war schon \
		eingeschaltet.' zauberer_set_report_gag3 = \
		/purge zauberer_set_report_gag2%;\
	/send !\\zmessage LP: \%la (\%lm) MP: \%ma (\%mm) SMP: \%sa \
		(\%sm) GI: (\%gi) FRO: (\%fr) ER: \%er\%lf\
		Ha: (\%Fh) Wi: \%wi XH: \%xh SZ: (\%Sz) BL: \%bl \
		TA: \%ta AL: \%AL VS: \%vo FR: \%fl\%lf%;\
	/send !\\stabinfo%;\
	/send !\\stabreport ein

; Stabreport triggern

/def -p10 -q -w -agCgreen -mregexp -t'^LP\\: ([0-9]+) \\(([0-9]+)\\) \
	MP\\: ([0-9]+) \\((.*)\\) SMP: (-?[0-9]+) \\(([0-9]+)\\) \
	GI\\: \\((J|N)\\) FRO\\: \\((J|N)\\) ER\\: (J|N)$' \
	zauberer_reptrig1 = \
	/set p_smp %P5%;\
	/set p_maxsmp %P6%;\
	/eval_hook points %P1 %P3%;\
	/set p_maxlp %P2%;\
	/set p_maxmp %P4%;\
	/if ({P9} =~ 'J') \
		/set zauberer_erschoepfung 1%;\
	/else \
		/set zauberer_erschoepfung 0%;\
	/endif%;\
	/if ({P7} =~ 'J') \
		/set p_poison=schwer%;\
		/set p_poison_time=$[time()]%;\
	/else \
		/set p_poison=%;\
	/endif%;\
	/if ({P8} =~ 'J') \
		/set p_frog 1%;\
	/else \
		/set p_frog 0%;\
	/endif

/def -p10 -q -w -agCgreen -mregexp -t'^Ha\\: \\(( |F|S|E)\\) Wi\\: \
	(ein|aus) XH\\: (ein|aus) SZ\\: \\(( |s|S|Z|V)\\) \
	BL\\: (J|N) TA\\: (J|N) AL\\: ([a-z]+) VS\\: \
	([0-9]+) FR\\: (.+)$' \
	zauberer_reptrig2 = \
	/if ({P1} =~ "F") \
		/set zauberer_hand 1%;\
	/elseif ({P1} =~ "E") \
		/set zauberer_hand 2%;\
	/elseif ({P1} =~ "S") \
		/set zauberer_hand 3%;\
	/else \
		/set zauberer_hand 0%;\
	/endif%;\
	/if ({P2} =~ 'ein') \
		/set zauberer_wille 1%;\
	/else \
		/set zauberer_wille 0%;\
	/endif%;\
	/if ({P3} =~ 'ein') \
		/set zauberer_extrahand 1%;\
	/else \
		/set zauberer_extrahand 0%;\
	/endif%;\
	/if ({P4} =~ "s") \
		/set zauberer_schutz 1%;\
	/elseif ({P4} =~ "S") \
		/set zauberer_schutz 2%;\
	/elseif ({P4} =~ "Z") \
		/set zauberer_schutz 3%;\
	/elseif ({P4} =~ "V") \
		/set zauberer_schutz 4%;\
	/else \
		/set zauberer_schutz 0%;\
	/endif%;\
	/if ({P5} =~ 'J') \
		/set p_blind 1%;\
	/else \
		/set p_blind 0%;\
	/endif%;\
	/if ({P6} =~ 'J') \
		/set p_deaf 1%;\
	/else \
		/set p_deaf 0%;\
	/endif%;\
	/set p_align=%P7%;\
	/if ({P9} =~ '0') \
		/check_vorsicht %P8 keine%;\
	/else \
		/check_vorsicht %P8 %P9%;\
	/endif

; Schutz

/def -Fp8 -q -agCblue -msimple -t'Auf Deine Verteidigung wirkt bereits eine \
	andere Art von Magie.' zauberer_schutz_already = \
	/cfg_echo MG_ZAUBERER_SCHUTZ_ALR %*

/def -Fp8 -w -q -agCblue -msimple -t'Du breitest Deine Haende aus und sagst: \
	SCHUTZ!' zauberer_schutz = \
	/cfg_echogag MG_ZAUBERER_SCHUTZ %*%;\
	/purge zauberer_schutz_g%;\
	/def -1 -Fp8 -w -q -agCblue -mregexp -t'^Eine (fahlblaue|blaeulich \
		schimmernde|blau leuchtende|gleissend blaue) Schutzaura \
		umgibt Dich\\\\.$$' zauberer_schutz_g = \
		/if ({P1} =~ "fahlblaue") \
			/let ZAUBERER_SCHUTZ_QUAL 1%%;\
		/elseif ({P1} =~ "blaeulich schimmernde") \
			/let ZAUBERER_SCHUTZ_QUAL 2%%;\
		/elseif ({P1} =~ "blau leuchtende") \
			/let ZAUBERER_SCHUTZ_QUAL 3%%;\
		/elseif ({P1} =~ "gleissend blaue") \
			/let ZAUBERER_SCHUTZ_QUAL 4%%;\
		/endif%%;\
		/let ZAUBERER_SCHUTZ_COLOR=%%;\
		/test ZAUBERER_SCHUTZ_COLOR:=$$[strcat(\
			"CFG_MG_ZAUBERER_SCHUTZ_",ZAUBERER_SCHUTZ_QUAL,\
			"_ECHO_ATTR")]%%;\
		/set status_attr_zauberer_schutz=$$[strcat('"',\
			ZAUBERER_SCHUTZ_COLOR,'"')]%%;\
		/cfg_echo $$[strcat("MG_ZAUBERER_SCHUTZ_",\
			ZAUBERER_SCHUTZ_QUAL)] %%*%%;\
		/eval_hook spell

/def -Fp8 -q -w -agCblue -mregexp -t'^Die (fahlblaue|blaeulich schimmernde|\
	blau leuchtende|gleissend blaue) Schutzaura um Dich loest sich \
	langsam auf\\.$' zauberer_schutz_aus = \
	/cfg_echo MG_ZAUBERER_SCHUTZ_AUS %*%;\
	/set zauberer_schutz 0%;\
	/if /ismacro autokampf_update%; /then \
		/autokampf_update schutz%;\
	/endif

; Schutzhuelle

/def -Fp8 -q -w -agCblue -msimple -t'Du konzentrierst Dich auf Deinen \
	Schutz.' zauberer_schutzhuelle = \
	/cfg_echogag MG_ZAUBERER_SCHUTZHUELLE %*%;\
	/purge zauberer_schutzhuelle_g%;\
	/def -1 -Fp8 -q -w -agCblue -mregexp -t'^Eine (schwarze A|\
		(fahlgueldene|guelden schimmernde|golden leuchtende|\
		gleissend goldene) Schutza)ura umgibt Dich\\\\.$$' \
		zauberer_schutzhuelle_g = \
		/if ({P1} =/ "schwarze *") \
			/let ZAUBERER_SCHUTZ_QUAL 0%%;\
		/elseif ({P2} =~ "fahlgueldene") \
			/let ZAUBERER_SCHUTZ_QUAL 1%%;\
		/elseif ({P2} =~ "guelden schimmernde") \
			/let ZAUBERER_SCHUTZ_QUAL 2%%;\
		/elseif ({P2} =~ "golden leuchtende") \
			/let ZAUBERER_SCHUTZ_QUAL 3%%;\
		/elseif ({P2} =~ "gleissend goldene") \
			/let ZAUBERER_SCHUTZ_QUAL 4%%;\
		/endif%%;\
		/let ZAUBERER_SCHUTZ_COLOR=%%;\
		/test ZAUBERER_SCHUTZ_COLOR:=$$[strcat(\
			"CFG_MG_ZAUBERER_SCHUTZHUELLE_",ZAUBERER_SCHUTZ_QUAL,\
			"_ECHO_ATTR")]%%;\
		/set status_attr_zauberer_schutz=$$[strcat('"',\
			ZAUBERER_SCHUTZ_COLOR,'"')]%%;\
		/cfg_echo $$[strcat("MG_ZAUBERER_SCHUTZHUELLE_",\
			ZAUBERER_SCHUTZ_QUAL)] %%*%%;\
		/eval_hook spell

/def -Fp8 -q -w -agCblue -mregexp -t'^Die (schwarze A|(fahlgueldene|guelden \
	schimmernde|golden leuchtende|gleissend goldene) Schutza)ura \
	um Dich loest sich langsam auf\\.$' zauberer_schutzhuelle_aus = \
	/cfg_echo MG_ZAUBERER_SCHUTZHUELLE_AUS %*%;\
	/set zauberer_schutz 0%;\
	/if /ismacro autokampf_update%; /then \
		/autokampf_update schutzhuelle%;\
	/endif

; Extrahand

/def -Fp8 -q -w -agCblue -msimple -t'Du schuettelst Deine Haende - na, das \
	muss doch... - Ah, ja. So ging das!' zauberer_extrahand = \
	/cfg_echogag MG_ZAUBERER_EXTRAHAND %*%;\
	/purge zauberer_extrahand_g%;\
	/def -Fp8 -1 -q -w -agCblue -msimple -t'Du hast jetzt eine \
		zusaetzliche Hand zur Verfuegung.' zauberer_extrahand_g = \
		/set p_free_hands=$[min(3,++p_free_hands)]%%;\
		/cfg_echo MG_ZAUBERER_EXTRAHAND %%*%%;\
		/eval_hook spell

/def -Fp8 -q -w -agCblue -msimple -t'Deine Extrahand loest sich auf.' \
	zauberer_extrahand_aus = \
	/set p_free_hands=$[max(0,--p_free_hands)]%;\
	/set zauberer_extrahand 0%;\
	/cfg_echo MG_ZAUBERER_EXTRAHAND_AUS %*%;\
	/if /ismacro autokampf_update%; /then \
		/autokampf_update extrahand%;\
	/endif

/def -Fp8 -q -w -agCblue -msimple -t'Mehr als eine zusaetzliche Hand kannst Du \
	leider nicht kontrollieren.' zauberer_extrahand_already = \
	/cfg_echo MG_ZAUBERER_EXTRAHAND_ALR %*%;\
	/set zauberer_extrahand 1

; Wille

/def -Fp8 -q -w -agCblue -msimple -t'Du konzentrierst Deinen Willen auf \
	Deinen Schutz.' zauberer_wille = \
	/cfg_echo MG_ZAUBERER_WILLE %*%;\
	/eval_hook spell

/def -Fp8 -q -w -agCblue -msimple -t'Dein Wille laesst nach.' \
	zauberer_wille_aus = \
	/set zauberer_wille 0%;\
	/cfg_echo MG_ZAUBERER_WILLE_AUS %*%;\
	/if /ismacro autokampf_update%; /then \
		/autokampf_update wille%;\
	/endif

/def -Fp8 -q -w -agCblue -msimple -t'Du konzentrierst Deinen Willen doch schon \
	auf Deinen Schutz.' zauberer_wille_already = \
	/cfg_echo MG_ZAUBERER_WILLE_ALR %*

; Schnell

/def -Fp8 -q -w -agCblue -msimple -t'Immer schneller singend tanzt Du zu \
	einem magischen Liedchen.' zauberer_schnell = \
	/cfg_echogag MG_ZAUBERER_SCHNELL %*%;\
	/purge zauberer_schnell_g%;\
	/def -Fp8 -1 -q -w -agCblue -msimple -t'Du bewegst Dich nun deutlich \
		schneller.' zauberer_schnell_g = \
		/set zauberer_schnell 1%%;\
		/cfg_echo MG_ZAUBERER_SCHNELL %%*%%;\
		/eval_hook spell

/def -Fp8 -q -w -agCblue -msimple -t'Du wirst allmaehlich wieder \
	langsamer.' zauberer_schnell_aus = \
	/cfg_echo MG_ZAUBERER_SCHNELL_AUS %*%;\
	/set zauberer_schnell 0

/def -Fp8 -q -w -agCblue -msimple -t'Auf Dich wirkt noch ein Schnell-Zauber.' \
	zauberer_schnell_already = \
	/cfg_echo MG_ZAUBERER_SCHNELL_ALR %*%;\
	/set zauberer_schnell 1

; Hand

/def -Fp8 -mglob -q -w -agCblue -t'Du oeffnest das Flaeschchen und giesst den \
	Inhalt vorsichtig ueber *' zauberer_kompohand = \
	/cfg_echogag MG_ZAUBERER_HAND %*%;\
	/purge zauberer_kompohand_g%;\
	/if ({12} !~ '') \
		/def -Fp8 -mregexp -q -w -agCblue -1 -t'Haende.$$' \
			zauberer_kompohand_g = \
			/if (CFG_ECHO_GAG_LEVEL > 1) \
				/echo -pa%%CFG_MG_ZAUBERER_HAND_ZU_ECHO_ATTR \
					%%{CFG_MG_ZAUBERER_HAND_ZU_ECHO_TEXT}\
					%-11 $$[substr({PL}, 0, -3)]@{n}%%;\
			/else \
				/cfg_echogag MG_ZAUBERER_HAND %%*%%;\
			/endif%;\
	/else \
		/def -Fp8 -mregexp -q -w -agCblue -1 -t'Haende.$$' \
			zauberer_kompohand_g = \
			/if (CFG_ECHO_GAG_LEVEL > 1) \
				/echo -pa%%CFG_MG_ZAUBERER_HAND_ZU_ECHO_ATTR \
					%%CFG_MG_ZAUBERER_HAND_ZU_ECHO_TEXT\
					$$[substr({PL}, 0,-3)]@{n}%%;\
			/else \
				/cfg_echogag MG_ZAUBERER_HAND %%*%%;\
			/endif%;\
	/endif

/def -Fp8 -q -w -agCblue -mregexp -t'^Du fixierst Deine Haende mit den Augen \
	und fluesterst: (brennt|aetzt|gefriert)!$' zauberer_hand = \
	/cfg_echogag MG_ZAUBERER_HAND %*%;\
	/purge zauberer_hand_g1%;\
	/purge zauberer_hand_g2%;\
	/def -Fp8 -1 -q -w -agCblue -mregexp -t'^Deine Haende beginnen \
		(kaum wahrnehmbar |minimal |schwach |deutlich |heftig |\
		sehr heftig |aeusserst heftig |eindrucksvoll |gigantisch |)\
		zu (brennen|aetzen|gefrieren)!$$' \
		zauberer_hand_g1 = \
		/if ({P1} =~ "gigantisch ") \
			/let ZAUBERER_HAND_QUAL 10%%;\
		/elseif ({P1} =~ "aeusserst heftig ") \
			/let ZAUBERER_HAND_QUAL 9%%;\
		/elseif ({P1} =~ "sehr heftig ") \
			/let ZAUBERER_HAND_QUAL 8%%;\
		/elseif ({P1} =~ "heftig ") \
			/let ZAUBERER_HAND_QUAL 7%%;\
		/elseif ({P1} =~ "eindrucksvoll ") \
			/let ZAUBERER_HAND_QUAL 6%%;\
		/elseif ({P1} =~ "deutlich ") \
			/let ZAUBERER_HAND_QUAL 5%%;\
		/elseif ({P1} =~ "schwach ") \
			/let ZAUBERER_HAND_QUAL 3%%;\
		/elseif ({P1} =~ "minimal ") \
			/let ZAUBERER_HAND_QUAL 2%%;\
		/elseif ({P1} =~ "kaum wahrnehmbar ") \
			/let ZAUBERER_HAND_QUAL 1%%;\
		/else \
			/let ZAUBERER_HAND_QUAL 4%%;\
		/endif%%;\
		/if ({P2} =~ "aetzen") \
			/let ZAUBERER_HAND_TYPE=SAEURE%%;\
		/elseif ({P2} =~ "gefrieren") \
			/let ZAUBERER_HAND_TYPE=EIS%%;\
		/else \
			/let ZAUBERER_HAND_TYPE=FEUER%%;\
		/endif%%;\
		/cfg_echo $$[strcat("MG_ZAUBERER_HAND_",ZAUBERER_HAND_TYPE,\
			"_",ZAUBERER_HAND_QUAL)] %%*%%;\
		/eval_hook spell%;\
	/def -Fp8 -1 -q -w -agCblue -msimple -t'Du spuerst jedoch keinen \
		Schmerz.' zauberer_hand_g2 = \
		/cfg_echogag MG_ZAUBERER_HAND %%*

/def -Fp8 -q -w -agCblue -msimple -t'Die Verzauberung Deiner Haende laesst \
	langsam nach.' zauberer_hand_aus = \
	/cfg_echo MG_ZAUBERER_HAND_AUS %*%;\
	/set zauberer_hand 0

/def -Fp8 -q -w -agCblue -msimple -t'Deine Haende sind bereits irgendwie \
	verzaubert.' zauberer_hand_already = \
	/cfg_echo MG_ZAUBERER_HAND_ALR %*

; Schattenkaempfer

/def -Fp8 -q -w -agCblue -msimple -t'Du versuchst Deinen Schatten \
	abzuschuetteln.' zauberer_schatten = \
	/cfg_echogag MG_ZAUBERER_SCHATTEN %*%;\
	/purge -mglob zauberer_schatten_g*%;\
	/def -Fp8 -1 -q -w -agCblue -msimple -t'Ploetzlich loest sich Dein \
		Schatten von Dir.' zauberer_schatten_g1 = \
		/cfg_echogag MG_ZAUBERER_SCHATTEN %%*%;\
	/def -Fp8 -1 -q -w -agCblue -mregexp -t'^Der Schatten ist \
                (ziemlich (schwach|kraeftig)|sehr stark)\\\\.$$' \
		zauberer_schatten_g2 = \
		/if ({P1} =~ "ziemlich schwach") \
			/let ZAUBERER_SCHATTEN_QUAL 1%%;\
		/elseif ({P1} =~ "ziemlich kraeftig") \
			/let ZAUBERER_SCHATTEN_QUAL 2%%;\
		/elseif ({P1} =~ "sehr stark") \
			/let ZAUBERER_SCHATTEN_QUAL 3%%;\
		/endif%%;\
		/cfg_echo $$[strcat("MG_ZAUBERER_SCHATTEN_",\
			ZAUBERER_SCHATTEN_QUAL)] %%*%%;\
		/eval_hook spell

/def -Fp8 -q -w -agCblue -msimple -t'Dein Schatten hat sich doch schon von \
	Dir geloest.' zauberer_schatten_already = \
	/cfg_echo MG_ZAUBERER_SCHATTEN_ALR %*

; Illusion

/def -Fp8 -q -w -agCgreen -msimple -t'Im Verborgenen machst Du eine magische \
	Handbewegung.' zauberer_illusion = \
	/cfg_echo MG_ZAUBERER_ILLUSION %*%;\
	/eval_hook spell

; Licht

/def -Fp8 -q -w -agCgreen -msimple -t'Du konzentrierst Dich.' zauberer_licht = \
	/cfg_echogag MG_ZAUBERER_LICHT %*%;\
	/purge zauberer_licht_g1%;\
	/def -Fp8 -1 -q -w -agCgreen -msimple -t'Eine strahlend helle Kugel \
		erscheint aus dem Nichts.' zauberer_licht_g1 = \
		/cfg_echo MG_ZAUBERER_LICHT %%*%%;\
		/eval_hook spell

; Zauberschild

/ifdef p_sub_guild=~"abwehr" -p0 -msimple -q -w -agCblue -t'Du drehst \
	Pirouetten in der festgelegten Schrittfolge und murmelst die' \
	zauberer_zschild = \
	/cfg_echogag MG_ZAUBERER_ZSCHILD %*%;\
	/purge -mglob zauberer_zschild_g*%;\
	/def -Fp8 -1 -msimple -q -w -agCblue -t'vorgeschriebenen Worte.' \
		zauberer_zschild_g1 = /cfg_echogag MG_ZAUBERER_ZSCHILD %%*%;\
	/def -Fp8 -1 -mregexp -q -w -agCblue -t'^Eine (fahlroetliche|roetlich \
		schimmernde|rot leuchtende|gleissend rote) Schutzaura umgibt \
		Dich\\\\.$$' zauberer_zschild_g2 = \
		/if ({P1} =~ "fahlroetliche") \
			/let ZAUBERER_SCHUTZ_QUAL 1%%;\
		/elseif ({P1} =~ "roetlich schimmernde") \
			/let ZAUBERER_SCHUTZ_QUAL 2%%;\
		/elseif ({P1} =~ "rot leuchtende") \
			/let ZAUBERER_SCHUTZ_QUAL 3%%;\
		/elseif ({P1} =~ "gleissend rote") \
			/let ZAUBERER_SCHUTZ_QUAL 4%%;\
		/endif%%;\
		/let ZAUBERER_SCHUTZ_COLOR=%%;\
		/test ZAUBERER_SCHUTZ_COLOR:=$$[strcat(\
			"CFG_MG_ZAUBERER_ZSCHILD_",ZAUBERER_SCHUTZ_QUAL,\
			"_ECHO_ATTR")]%%;\
		/set status_attr_zauberer_schutz=$$[strcat('"',\
			ZAUBERER_SCHUTZ_COLOR,'"')]%%;\
		/cfg_echo $$[strcat("MG_ZAUBERER_ZSCHILD_",\
			ZAUBERER_SCHUTZ_QUAL)] %%*%%;\
		/eval_hook spell

/ifdef p_sub_guild=~"abwehr" -p0 -mregexp -q -w -agCblue -t'^Die (gleissend \
	rote|rot leuchtende|roetlich schimmernde|fahlroetliche) Schutzaura \
	um Dich loest sich langsam auf\\.$' zauberer_zauberschild_aus = \
	/cfg_echo MG_ZAUBERER_ZSCHILD_AUS %*%;\
	/if /ismacro autokampf_update%; /then \
		/autokampf_update zauberschild%;\
	/endif

; Feuerwalze

/ifdef p_sub_guild=~"angriff" -p0 -msimple -q -w -agCblue -t'Vorsichtig \
	oeffnest Du das Flaeschchen und giesst Dir unter Rezitation der' \
	zauberer_feuerwalze = \
	/cfg_echogag MG_ZAUBERER_FEUERWALZE %*%;\
	/def -p0 -1 -msimple -q -w -agCblue -t'vorgeschriebenen Worte die \
		Loesung mit dem Phosphor ueber die Haende. Na,' \
		zauberer_feuerwalze_1 = \
		/cfg_echogag MG_ZAUBERER_FEUERWALZE %%*%;\
	/def -p0 -1 -msimple -q -w -agCblue -t'hoffentlich klappt das...' \
		zauberer_feuerwalze_2 = \
		/cfg_echogag MG_ZAUBERER_FEUERWALZE %%*%;\
	/def -p0 -1 -msimple -q -w -agCblue -t'Eine gewaltige Feuerwalze \
		entsteht aus Deinen Haenden, die auch sofort in die' \
		zauberer_feuerwalze_3 = \
		/cfg_echogag MG_ZAUBERER_FEUERWALZE %%*%;\
	/def -p0 -1 -msimple -q -w -agCblue -t'gewuenschte Richtung \
		davonrollt.' zauberer_feuerwalze_4 = \
		/eval_hook spell%%;\
		/cfg_echogag MG_ZAUBERER_FEUERWALZE %%*%;\
	/def -p0 -1 -mregexp -q -w -agCblue -t'^Die Feuerwalze rollt nach \
		(.+)\\\\.$$' zauberer_feuerwalze_5 = \
		/if (!CFG_ECHO_GAG_LEVEL) \
			/echo -- %%*%%;\
		/elseif (CFG_ECHO_GAG_LEVEL==1) \
			/echo -a%%CFG_MG_ZAUBERER_FEUERWALZE_ECHO_ATTR -- \
				%%*%%;\
		/else \
			/echo -a%%CFG_MG_ZAUBERER_FEUERWALZE_ECHO_ATTR -- $$\
				[sprintf(CFG_MG_ZAUBERER_FEUERWALZE_ECHO_TEXT,\
				{P1})]%%;\
		/endif%;\
	/def -Fp1 -1 -msimple -q -w -agCblue -t'Ein unglaublicher Luftsog \
		saugt Dich an.' zauberer_feuerwalze_move = \
		/cfg_echocolor MG_ZAUBERER_FEUERWALZE_MOVE %%*%;\
	/repeat -5 1 /purge zauberer_feuerwalze_move

; Irritiere

/ifdef p_sub_guild=~"beherrschung" -p0 -mglob -q -w -agCblue -t'Voellig \
	ueberraschend drueckst Du * einen*' zauberer_irritiere = \
	/cfg_echogag MG_ZAUBERER_IRRITIERE %*%;\
	/purge zauberer_irritiere_g*%;\
	/def -p0 -1 -mregexp -q -w -agCblue -t'Lotusstaub in die Nase\\\\.$$' \
		zauberer_irritiere_g1 = \
		/cfg_echogag MG_ZAUBERER_IRRITIERE %%*%;\
	/def -p0 -1 -mregexp -q -w -agCblue -t'(Der |Die |Das |Eine? |)(.+) \
		schaut ziemlich verdutzt aus\\\\.$$' zauberer_irritiere_g2 = \
		/if (CFG_ECHO_GAG_LEVEL > 1) \
			/echo -pa%%CFG_MG_ZAUBERER_IRRITIERE_ECHO_ATTR \
                                %%CFG_MG_ZAUBERER_IRRITIERE_ECHO_TEXT \
                                %%P2%%;\
		/else \
			/cfg_echocolor MG_ZAUBERER_IRRITIERE %%*%%;\
		/endif%%;\
		/eval_hook spell

; Gefaehrte

/ifdef p_sub_guild=~"illusion" -p0 -msimple -q -w -agCblue -t'Du beginnst \
	einen kleinen Hexentanz um den Punkt, an dem Dein Gefaehrte' \
	zauberer_gefaehrte = \
	/purge -mglob zauberer_gefaehrte_g*%;\
	/cfg_echogag MG_ZAUBERER_GEFAEHRTE %*%;\
	/def -p0 -1 -msimple -q -w -agCblue -t'entstehen soll.' \
		zauberer_gefaehrte_g1 = \
		/cfg_echogag MG_ZAUBERER_GEFAEHRTE %%*%;\
	/def -p0 -1 -msimple -q -w -agCblue -t'Eine klare, etwas salzig \
		riechende Wolke entsteht und aus ihrer Mitte' \
		zauberer_gefaehrte_g2 = \
		/cfg_echogag MG_ZAUBERER_GEFAEHRTE %%*%;\
	/def -p0 -1 -msimple -q -w -agCblue -t'entsteigt eine Gestalt.' \
		zauberer_gefaehrte_g3 = \
		/cfg_echo MG_ZAUBERER_GEFAEHRTE %%*%;\
		/eval_hook spell

; Schutzzone

/ifdef p_sub_guild=~"abwehr" -p0 -msimple -q -w -agCblue -t'Du drehst Dich \
	mit ausgestreckten Armen um Deine Achse.' zauberer_schutzzone = \
	/cfg_echogag MG_ZAUBERER_SCHUTZZONE %*%;\
	/purge zauberer_schutzzone_g*%;\
	/def -p0 -1 -mregexp -q -w -agCblue -t'^Du deutest nach (.+)\\\\.$$' \
		zauberer_schutzzone_g1 = \
		/if (CFG_ECHO_GAG_LEVEL > 1) \
			/echo -pa%%CFG_MG_ZAUBERER_SCHUTZZONE_ECHO_ATTR \
				%%CFG_MG_ZAUBERER_SCHUTZZONE_ECHO_TEXT %%P1%%;\
		/else \
			/cfg_echocolor MG_ZAUBERER_SCHUTZZONE %%*%%;\
		/endif%%;\
		/eval_hook spell%%;\
		/purge zauberer_schutzzone_g*%;\
	/def -p0 -1 -msimple -q -w -agCblue -t'Eine Zone rotgluehender, \
		durcheinanderwirbelnder Funken erfuellt den Raum.' \
		zauberer_schutzzone_g2 = \
		/cfg_echo MG_ZAUBERER_SCHUTZZONE %%*%%;\
		/eval_hook spell%%;\
		/purge zauberer_schutzzone_g*

/def -Fp8 -msimple -q -w -agCblue -t'Die Funken verschwinden ploetzlich.' \
	zauberer_schutzzone_aus = /cfg_echo MG_ZAUBERER_SCHUTZZONE_AUS %*

/def -Fp8 -msimple -q -agCblue -t'Eine Zone rotgluehender, wirbelnder \
	Funken erfuellt den Raum.' zauberer_schutzzone_here = \
	/cfg_echocolor MG_ZAUBERER_SCHUTZZONE %*

; Wandlung

/ifdef p_sub_guild=~"verwandlung" -p0 -msimple -q -w -agCblue -t'Du oeffnest \
	eine kleine Phiole und uebergiesst Dich mit deren Inhalt.' \
	zauberer_wandlung = \
	/cfg_echogag MG_ZAUBERER_WANDLUNG %*%;\
	/purge zauberer_wandlung_g1%;\
	/def -p0 -mglob -q -w -1 -agCblue -t'Fuer einen Moment fuehlst Du \
		Dich wie in {Blitz|Feuer|Luft|Eis|Erde|Wasser} eingehuellt.' \
		zauberer_wandlung_g1 = \
		/cfg_echo $$[strcat("MG_ZAUBERER_WANDLUNG_",\
			toupper({9}))] %%*%%;\
		/eval_hook spell

; Schmerzen

; CFG_MG_ZAUBERER_SCHMERZEN_ECHO_TEXT

/def -p1 -w -q -msimple -agCblue -t'Eine silberne Nadel erscheint in Deiner \
	Hand.' zauberer_schmerzen = \
	/cfg_echogag MG_ZAUBERER_SCHMERZEN %*%;\
	/purge -mglob zauberer_schmerzen_g*%;\
	/def -p0 -mglob -q -w -1 -agCblue -t'Du wirfst sie auf *.' \
		zauberer_schmerzen_g1 = \
		/cfg_echogag MG_ZAUBERER_SCHMERZEN %%*%;\
	/def -p0 -mregexp -q -w -1 -agCblue -t'^(D(er|ie|as) |Eine? )?.*\
		([A-Z][^ ]+).* kruemmt sich vor Schmerzen\\\\.$$' \
		zauberer_schmerzen_g2 = \
		/if (!CFG_ECHO_GAG_LEVEL) \
			/echo -- %%*%%;\
		/elseif (CFG_ECHO_GAG_LEVEL==1) \
			/echo -a%%CFG_MG_ZAUBERER_SCHMERZEN_ECHO_ATTR -- %%*%%;\
		/else \
			/echo -a%%CFG_MG_ZAUBERER_SCHMERZEN_ECHO_ATTR -- $$\
				[sprintf(CFG_MG_ZAUBERER_SCHMERZEN_ECHO_TEXT,\
				{P3})]%%;\
		/endif

; Stabschaden

/def -Fp8 -q -w -agCblue -mregexp -t'^Deine? [A-Z][a-z]+ ist nun von einer \
	(durchscheinend|funkelnd|eisig|feurig|magisch|giftgruen|\
	flimmernd|verschwommen|roetlich)en Aura eingehuellt\\.$' \
	zauberer_stabschaden = \
	/if ({P1} =~ "flimmernd") \
		/let stabschaden_txt=LAERM%;\
		/let zauberer_color=%CFG_STATUS_COLOR_ZAUBERER_NOISE%;\
	/elseif ({P1} =~ "durchscheinend") \
		/let stabschaden_txt=WIND%;\
		/let zauberer_color=%CFG_STATUS_COLOR_ZAUBERER_AIR%;\
	/elseif ({P1} =~ "funkelnd") \
		/let stabschaden_txt=BLITZ%;\
		/let zauberer_color=%CFG_STATUS_COLOR_ZAUBERER_LIGHTNING%;\
	/elseif ({P1} =~ "eisig") \
		/let stabschaden_txt=EIS%;\
		/let zauberer_color=%CFG_STATUS_COLOR_ZAUBERER_ICE%;\
	/elseif ({P1} =~ "feurig") \
		/let stabschaden_txt=FEUER%;\
		/let zauberer_color=%CFG_STATUS_COLOR_ZAUBERER_FIRE%;\
	/elseif ({P1} =~ "magisch") \
		/let stabschaden_txt=MAGIE%;\
		/let zauberer_color=%CFG_STATUS_COLOR_ZAUBERER_MAGIC%;\
	/elseif ({P1} =~ "giftgruen") \
		/let stabschaden_txt=GIFT%;\
		/let zauberer_color=%CFG_STATUS_COLOR_ZAUBERER_POISON%;\
	/elseif ({P1} =~ "verschwommen") \
		/let stabschaden_txt=WASSER%;\
		/let zauberer_color=%CFG_STATUS_COLOR_ZAUBERER_WATER%;\
	/elseif ({P1} =~ "roetlich") \
		/let stabschaden_txt=SAEURE%;\
		/let zauberer_color=%CFG_STATUS_COLOR_ZAUBERER_ACID%;\
	/endif%;\
	/test status_attr_zauberer_stabschaden:=\
		strcat('\"',zauberer_color,'\"')%;\
	/self_update zauberer_stabschaden%;\
	/cfg_echo $[strcat("MG_ZAUBERER_SSCHADEN_",stabschaden_txt)] %*%;\
	/eval_hook spell

/def -Fp8 -q -w -agCblue -mregexp -t'^Die Aura um Dein(en?)? [A-Z][a-z]+ \
	schwindet\\.$' zauberer_stabschaden_aus = \
	/set status_attr_zauberer_stabschaden="n"%;\
	/self_update zauberer_stabschaden%;\
	/cfg_echo MG_ZAUBERER_SSCHADEN_AUS %*

/def -Fp8 -q -w -agCblue -mregexp -t'^(D(er|ie|as)|Eine?) [A-Z][a-z]+ ist \
	noch verzaubert\\.$' zauberer_stabschaden_already = \
	/cfg_echo MG_ZAUBERER_SSCHADEN_ALR %*

; unterstuetzender Zauberstab

/def -Fp8 -q -w -agCblue -msimple -t'Dein Zauberstab unterstuetzt Dich bei dem \
	Spruch.' zauberer_stabunterstuetzung = \
	/cfg_echocolor MG_ZAUBERER_STAB %*%;\
	/eval_hook zauberer_stab

; Abbruch / Verzoegerungen

/def -Fp1 -msimple -q -w -agCblue -t'Du machst Deine Gedanken frei von allen \
	weltlichen Dingen und konzentrierst' zauberer_konzentration = \
	/cfg_echogag MG_ZAUBERER_KONZENTRATION %*%;\
	/purge zauberer_konzentration_g1%;\
	/def -Fp1 -1 -mregexp -agCblue -q -w -t'^Dich auf die Ausfuehrung des \
		Spruchs \\'(.*)\\'\\\\.$$' zauberer_konzentration_g1 = \
		/set zauberer_vorb_spruch=$$[tolower({P1})]%%;\
		/if (CFG_ECHO_GAG_LEVEL > 1) \
			/echo -pa%%CFG_MG_ZAUBERER_KONZENTRATION_ECHO_ATTR \
				%%CFG_MG_ZAUBERER_KONZENTRATION_ECHO_TEXT \
				%%zauberer_vorb_spruch%%;\
		/else \
			/cfg_echocolor MG_ZAUBERER_KONZENTRATION %%*%%;\
		/endif

/def -Fp1 -msimple -q -w -agCblue -t'Die Ausfuehrung Deines vorbereiteten \
	Spruches wird verzoegert.' zauberer_verzoegerung = \
	/if (CFG_ECHO_GAG_LEVEL > 1) \
		/echo -pa%CFG_MG_ZAUBERER_VERZOEGERUNG_ECHO_ATTR \
			%CFG_MG_ZAUBERER_VERZOEGERUNG_ECHO_TEXT \
			%zauberer_vorb_spruch%;\
	/else \
		/cfg_echocolor MG_ZAUBERER_VERZOEGERUNG %*%;\
	/endif

/def -Fp1 -mglob -q -w -agCblue -t'Du brichst die Spruchvorbereitung fuer {*} \
	ab.' zauberer_abbruch = \
	/set zauberer_vorb_spruch=$[substr({6}, 1, -2)]%;\
	/if (CFG_ECHO_GAG_LEVEL > 1) \
		/echo -pa%CFG_MG_ZAUBERER_ABBRUCH_ECHO_ATTR \
			%CFG_MG_ZAUBERER_ABBRUCH_ECHO_TEXT \
			%zauberer_vorb_spruch%;\
	/else \
		/cfg_echocolor MG_ZAUBERER_ABBRUCH %*%;\
	/endif

; Erschoepfung

/def -Fp8 -q -w -agCblue -mregexp -t'^Du bist noch (aeusserst lange |sehr \
	lange |lange |laenger |viel |etwas |geringfuegig |)zu erschoepft fuer \
	einen (Magisterspruch|Zauberspruch)\\.$' zauberer_erschoepfung = \
	/if ({P1} =~ "aeusserst lange ") \
		/let zauberer_erschoepf=1%;\
	/elseif ({P1} =~ "sehr lange ") \
		/let zauberer_erschoepf=2%;\
	/elseif ({P1} =~ "lange ") \
		/let zauberer_erschoepf=3%;\
	/elseif ({P1} =~ "laenger ") \
		/let zauberer_erschoepf=4%;\
	/elseif ({P1} =~ "viel ") \
		/let zauberer_erschoepf=5%;\
	/elseif ({P1} =~ "") \
		/let zauberer_erschoepf=6%;\
	/elseif ({P1} =~ "etwas ") \
		/let zauberer_erschoepf=7%;\
	/elseif ({P1} =~ "geringfuegig ") \
		/let zauberer_erschoepf=8%;\
	/endif%;\
	/cfg_echo $[strcat("MG_ZAUBERER_ERSCHOEPFUNG_",zauberer_erschoepf)] %*

; Unangepasste Ruestung / Waffen

/def -Fp8 -q -w -agCblue -msimple -t'Du verwendest Deiner Stellung nicht \
	angemessene Waffen oder Ruestungen.' zauberer_wrong_armor = \
	/cfg_echo MG_ZAUBERER_WRONG_ARMOR %*

; Abgeschwaechte Angriffe durch Dunkelheit

/def -p0 -q -w -agCblue -msimple -t'Du siehst nichts und schlaegst \
	orientierungslos um Dich.' zauberer_too_dark = \
	/cfg_echo MG_ZAUBERER_TOO_DARK %*%;\
	/eval_hook too_dark

; fehlende Kompos

/def -Fp8 -q -w -agCblue -msimple -t'Dir fehlen die noetigen Materialien!' \
	zauberer_kompos = /cfg_echo MG_ZAUBERER_MISSING_KOMPO %*

/def -Fp8 -q -w -agCblue -msimple -t'Deine Materialien reichen nicht aus!' \
	zauberer_kompos2 = /cfg_echo MG_ZAUBERER_MISSING_KOMPO %*

; Lernen

/def -Fp8 -q -w -agCblue -msimple -t'Du lernst etwas aus Deinem Erfolg.' \
	zauberer_lernen_erfolg = /cfg_echocolor MG_ZAUBERER_LEARN %*

/def -Fp8 -q -w -agCblue -mregexp -t'^Du lernst (etwas )?aus Deinen \
	Fehlern\\.$' zauberer_lernen_fehler = \
	/cfg_echocolor MG_ZAUBERER_LEARN %*

/def -Fp8 -q -w -agCblue -msimple -t'Du lernst etwas besonderes aus Deinem \
	Fehler.' zauberer_lernen_fehler2 = /cfg_echocolor MG_ZAUBERER_LEARN %*

/def -Fp8 -q -w -agCblue -mregexp -t'^Dir faellt (noch |)eine (fatale |)\
	Schwaeche in Dein(em|er) .+ auf[!.]$' zauberer_lernen_schwaeche = \
	/cfg_echocolor MG_ZAUBERER_LEARN %*

/def -Fp8 -q -w -agCblue -mregexp -t'^Du entdeckst eine Moeglichkeit, \
	(Deinen?|d(ie|en)) .+ zu verbessern\\.$' zauberer_lernen_verbessern = \
	/cfg_echocolor MG_ZAUBERER_LEARN %*

/def -Fp8 -q -w -agCblue -msimple -t'Du hast Dich gerade im Umgang mit dem \
	Zauberstab verbessert.' zauberer_lernen_stab = \
	/cfg_echocolor MG_ZAUBERER_LEARN %*

; Fluchtest Parawelt

/def -Fp8 -q -agCblue -mregexp -t'^Du befindest Dich in (der )?Parallelwelt\
	( [0-9])?\\.$' zauberer_parawelt = \
	/cfg_echocolor MG_ZAUBERER_PARA %*%;\
	/if ({P2} !~ "") \
		/wpara %P2%;\
	/else \
		/wpara 1%;\
	/endif

; zrufe
/def status_zauberer_zrufe = \
        /if (!is_file_loaded('comm.tf')) \
                /def -Fp8 -q -agCblue -mregexp -t' alle( Zauberer|n Zauberern)[:. ]' \
                        zauberer_zemote = /cfg_echocolor MG_ZAUBERER_ZEMOTE %%*%;\
        /else \
                /def -p7 -ag -E(comm_zrufe&!comm_mpa_mail) -mregexp \
                    -t" an alle( Zauberer|n Zauberern): " \
                    comm_zrufe = \
                    /let comm_ebene=zRufe%%;\
                    /let comm_ebene_speaker=%%PL%%;\
                    /let comm_ebene_bracket=]%%;\
                    /let comm_ebene_text= %%PR%%;\
                    /comm_format_ebene%%;\
                    /comm_write 1 %%?%;\
                /def -p7 -ag -E(comm_zrufe&!comm_mpa_mail) -mregexp \
                    -t" an alle( Zauberer|n Zauberern)[.]" \
                    comm_zemote = \
                    /let comm_ebene=zRufe%%;\
                    /let comm_ebene_speaker=%%PL.%%;\
                    /let comm_ebene_text=%%PR%%;\
                    /comm_format_ebene%%;\
                    /comm_write 1 %%?%;\
        /endif

; Rueste

/def -Fp1 -ag -mregexp -q -t' machs?t ein paar beschwoerende Gesten ueber \
	(der|dem|die) ([^.]+)[.]' zauberer_rueste = \
        /set zauberer_rueste_name=%PL%;\
        /def -mregexp -1 -F -ag -q -t' blitzt kurz gruenlich auf[.]$$' \
		zauberer_rueste_1 = \
		/if (zauberer_rueste_name!~"Du") \
	                /cfg_echocolor MG_ZAUBERER_RUESTE Rueste \
				(%%zauberer_rueste_name): %%PL%%;\
		/else \
			/cfg_echocolor MG_ZAUBERER_RUESTE Rueste: %%PL%%;\
		/endif

; Sachen beim Laden starten

/status_zauberer_zrufe
/zauberer_set_report
/config_status
