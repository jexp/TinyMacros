; $Log: user.tf,v $
; Revision 1.6  2001/12/20 22:38:33  mh14
; bindings in keys.def
;
; Revision 1.5  2001/09/30 00:37:14  mh14
; *** empty log message ***
;
; Revision 1.4  2001/09/09 19:16:59  mh14
; requires bereinigt
;
; Revision 1.3  2001/09/06 21:11:44  mh14
;  Log eingefuegt
;

/set user_tf_version $Id: user.tf,v 1.6 2001/12/20 22:38:33 mh14 Exp $
/set user_tf_author=Mesirii@mg.mud.de
/set user_tf_requires=lists.tf customize.tf
/set user_tf_desc Beispieldatei fuer Spieler "user" mit Einstellungen wie Keybindings

;Key bindings
;untroom.tf
;^x wie examine :)

;mapper
/def -b^o b_mapexits = /mapexits

/def -b^y^k b_zuecke = /zuecke%;
/def -b^y^u b_untmonster= /set state_dest=p_aktmonster_state%;/untmonster %{monster-%aktmonster}%;
/def -b^y^[u b_untaktmonster = /untmonster %akt_monster%;
/def -b^y^j b_zaubere = /zaubere%;

; way.tf
; Numpad bindings

/def nsp = nimm %* %; stecke %* in paket%;

/def paket = kaufe paket%; oeffne paket%; adressiere paket an ${world_character}%;

/def bh = schliesse haus auf%;oeffne haus%;betrete haus%;schliesse haus ab%;

/addh info \
enthaelt private Einstellungen, Makros, Trigger u.a.
/addh_fileinfo







