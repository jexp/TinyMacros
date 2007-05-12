; $Log: status_kaempfer.tf,v $
; Revision 1.2  2004/03/14 08:49:06  thufhnik
; Neue Statuszeile fuer Kaempfer, Danke Madness!
;

/set status_kaempfer_tf_version $Id: status_kaempfer.tf,v 1.2 2004/03/14 08:49:06 thufhnik Exp $
/set status_kaempfer_tf_author=Madness@mg.mud.de
/set status_kaempfer_tf_requires=status_ext.tf hydra.tf
/set status_kaempfer_tf_desc=Statuszeile fuer die Kaempfergilde

;;; Konfiguration

/set_var CFG_ECHO_GAG_LEVEL 2

; Automatisches ausfuehren von Kampfwille bei Paralyse?
/set_var KAEMPFER_AUTO_KAMPFWILLE 1

;;; Texte und Farben fuer die Skills

; Fokus
/set_var CFG_MG_KAEMPFER_FOKUS_ECHO_TEXT Fokus: %-1
/set_var CFG_MG_KAEMPFER_FOKUS_ECHO_ATTR Cgreen
/set_var CFG_MG_KAEMPFER_FOKUS_ALR_ECHO_TEXT Fokus: %-1
/set_var CFG_MG_KAEMPFER_FOKUS_ALR_ECHO_ATTR Cyellow

; Parade
/set_var CFG_STATUS_TEXT_KAEMPFER_PARADE_1 P
/set_var CFG_STATUS_COLOR_KAEMPFER_PARADE_1 Cblue
/set_var CFG_MG_KAEMPFER_PARADE_ALR_ECHO_TEXT Parade: %-1
/set_var CFG_MG_KAEMPFER_PARADE_ALR_ECHO_ATTR Cyellow
/set_var CFG_MG_KAEMPFER_PARADE_ECHO_TEXT Parade: %-1
/set_var CFG_MG_KAEMPFER_PARADE_ECHO_ATTR Cgreen
/set_var CFG_MG_KAEMPFER_PARADE_AUS_ECHO_TEXT Parade aus
/set_var CFG_MG_KAEMPFER_PARADE_AUS_ECHO_ATTR Cred

; Schildparade
/set_var CFG_STATUS_TEXT_KAEMPFER_SCHILDPARADE_1 S
/set_var CFG_STATUS_COLOR_KAEMPFER_SCHILDPARADE_1 Cbgblue,Cred
/set_var CFG_MG_KAEMPFER_SCHILDPARADE_ALR_ECHO_TEXT Schildparade: %-1
/set_var CFG_MG_KAEMPFER_SCHILDPARADE_ALR_ECHO_ATTR Cyellow
/set_var CFG_MG_KAEMPFER_SCHILDPARADE_ECHO_TEXT Schildparade: %-1
/set_var CFG_MG_KAEMPFER_SCHILDPARADE_ECHO_ATTR Cgreen
/set_var CFG_MG_KAEMPFER_SCHILDPARADE_AUS_ECHO_TEXT Schildparade aus
/set_var CFG_MG_KAEMPFER_SCHILDPARADE_AUS_ECHO_ATTR Cred

; Allgemeine Taktik
/set_var CFG_STATUS_COLOR_KAEMPFER_TAKTIK Cwhite
/set_var CFG_MG_KAEMPFER_TAKTIK_ECHO_TEXT Taktik: %-1
/set_var CFG_MG_KAEMPFER_TAKTIK_ECHO_ATTR Cgreen
/set_var CFG_MG_KAEMPFER_TAKTIK_ALR_ECHO_TEXT Taktik: %-1
/set_var CFG_MG_KAEMPFER_TAKTIK_ALR_ECHO_ATTR Cyellow

; Schnell
/set_var CFG_MG_KAEMPFER_SCHNELL_ECHO_TEXT Schnell
/set_var CFG_MG_KAEMPFER_SCHNELL_ECHO_ATTR Cgreen
/set_var CFG_MG_KAEMPFER_SCHNELL_ERSCHOEPFUNG_ECHO_TEXT Schnell Erschoepfung
/set_var CFG_MG_KAEMPFER_SCHNELL_ERSCHOEPFUNG_ECHO_ATTR Cred

; Unterlaufen
/set_var CFG_MG_KAEMPFER_UNTERLAUFEN_ECHO_TEXT Unterlaufen: %-1
/set_var CFG_MG_KAEMPFER_UNTERLAUFEN_ECHO_ATTR Cgreen
/set_var CFG_MG_KAEMPFER_UNTERLAUFEN_ALR_ECHO_TEXT Unterlaufen: %-1
/set_var CFG_MG_KAEMPFER_UNTERLAUFEN_ALR_ECHO_ATTR Cyellow
/set_var CFG_MG_KAEMPFER_UNTERLAUFEN_AUS_ECHO_TEXT Unterlaufen: %-1
/set_var CFG_MG_KAEMPFER_UNTERLAUFEN_AUS_ECHO_ATTR Cred
/set_var CFG_MG_KAEMPFER_UNTERLAUFEN_NICHT_ECHO_TEXT Unterlaufen unmoeglich: %-1
/set_var CFG_MG_KAEMPFER_UNTERLAUFEN_NICHT_ECHO_ATTR Cred

; Finte
/set_var CFG_MG_KAEMPFER_FINTE_ECHO_TEXT Finte: %-1
/set_var CFG_MG_KAEMPFER_FINTE_ECHO_ATTR Cgreen
/set_var CFG_MG_KAEMPFER_FINTE_NICHT_ECHO_TEXT Finte: %-1
/set_var CFG_MG_KAEMPFER_FINTE_NICHT_ECHO_ATTR Cred

; Finte
/set_var CFG_MG_KAEMPFER_WAFFENTRICK_ECHO_TEXT Waffentrick: %-1
/set_var CFG_MG_KAEMPFER_WAFFENTRICK_ECHO_ATTR Cgreen
/set_var CFG_MG_KAEMPFER_WAFFENTRICK_NICHT_ECHO_TEXT Waffentrick: %-1
/set_var CFG_MG_KAEMPFER_WAFFENTRICK_NICHT_ECHO_ATTR Cred

; Kampftaktiken (Schildkroete)
/set_var CFG_STATUS_TEXT_KAEMPFER_KAMPFTAKTIK_1 K
/set_var CFG_STATUS_COLOR_KAEMPFER_KAMPFTAKTIK_1 Cblue
/set_var CFG_MG_KAEMPFER_KAMPFTAKTIK_SK_ECHO_TEXT Schildkroete
/set_var CFG_MG_KAEMPFER_KAMPFTAKTIK_SK_ECHO_ATTR Cgreen
/set_var CFG_MG_KAEMPFER_KAMPFTAKTIK_SK_AUS_ECHO_TEXT Schildkroete aus
/set_var CFG_MG_KAEMPFER_KAMPFTAKTIK_SK_AUS_ECHO_ATTR Cred
/set_var CFG_MG_KAEMPFER_KAMPFTAKTIK_SK_ALR_ECHO_TEXT Schildkroete schon an
/set_var CFG_MG_KAEMPFER_KAMPFTAKTIK_SK_ALR_ECHO_ATTR Cyellow

; Kampftaktiken (Drache)
/set_var CFG_STATUS_TEXT_KAEMPFER_KAMPFTAKTIK_2 D
/set_var CFG_STATUS_COLOR_KAEMPFER_KAMPFTAKTIK_2 Cred
/set_var CFG_MG_KAEMPFER_KAMPFTAKTIK_DR_ECHO_TEXT Drache
/set_var CFG_MG_KAEMPFER_KAMPFTAKTIK_DR_ECHO_ATTR Cgreen
/set_var CFG_MG_KAEMPFER_KAMPFTAKTIK_DR_AUS_ECHO_TEXT Drache aus
/set_var CFG_MG_KAEMPFER_KAMPFTAKTIK_DR_AUS_ECHO_ATTR Cred
/set_var CFG_MG_KAEMPFER_KAMPFTAKTIK_DR_ALR_ECHO_TEXT Drache schon an
/set_var CFG_MG_KAEMPFER_KAMPFTAKTIK_DR_ALR_ECHO_ATTR Cyellow

; Kampftaktiken (Schlange)
/set_var CFG_STATUS_TEXT_KAEMPFER_KAMPFTAKTIK_3 S
/set_var CFG_STATUS_COLOR_KAEMPFER_KAMPFTAKTIK_3 Cyellow
/set_var CFG_MG_KAEMPFER_KAMPFTAKTIK_SL_ECHO_TEXT Schlange
/set_var CFG_MG_KAEMPFER_KAMPFTAKTIK_SL_ECHO_ATTR Cgreen
/set_var CFG_MG_KAEMPFER_KAMPFTAKTIK_SL_AUS_ECHO_TEXT Schlange aus
/set_var CFG_MG_KAEMPFER_KAMPFTAKTIK_SL_AUS_ECHO_ATTR Cred
/set_var CFG_MG_KAEMPFER_KAMPFTAKTIK_SL_ALR_ECHO_TEXT Schlange schon an
/set_var CFG_MG_KAEMPFER_KAMPFTAKTIK_SL_ALR_ECHO_ATTR Cyellow

; Schmerzen
/set_var CFG_STATUS_TEXT_KAEMPFER_SCHMERZEN_1 L:
/set_var CFG_STATUS_COLOR_KAEMPFER_SCHMERZEN_1 n
/set_var CFG_STATUS_TEXT_KAEMPFER_SCHMERZEN_2 L:
/set_var CFG_STATUS_COLOR_KAEMPFER_SCHMERZEN_2 Cbgred,Cwhite
/set_var CFG_STATUS_TEXT_KAEMPFER_SCHMERZEN_3 L:
/set_var CFG_STATUS_COLOR_KAEMPFER_SCHMERZEN_3 Cwhite
/set_var CFG_MG_KAEMPFER_SCHMERZEN_UNTERDRUECKT_ECHO_TEXT Schmerzen unterdrueckt
/set_var CFG_MG_KAEMPFER_SCHMERZEN_UNTERDRUECKT_ECHO_ATTR Cgreen
/set_var CFG_MG_KAEMPFER_SCHMERZEN_UNTERDRUECKT_AUS_ECHO_TEXT Schmerzen unterdrueckt
/set_var CFG_MG_KAEMPFER_SCHMERZEN_UNTERDRUECKT_AUS_ECHO_ATTR Cred
/set_var CFG_MG_KAEMPFER_SCHMERZEN_UNNOETIG_ECHO_TEXT Noch keine beeinflussung
/set_var CFG_MG_KAEMPFER_SCHMERZEN_UNNOETIG_ECHO_ATTR Cgreen

; Rueckendeckung
/set_var CFG_STATUS_TEXT_KAEMPFER_RUECKENDECKUNG_1 R
/set_var CFG_STATUS_COLOR_KAEMPFER_RUECKENDECKUNG_1 Cblue
/set_var CFG_STATUS_TEXT_KAEMPFER_RUECKENDECKUNG_2 R
/set_var CFG_STATUS_COLOR_KAEMPFER_RUECKENDECKUNG_2 Cbgyellow,Cyellow
/set_var CFG_STATUS_TEXT_KAEMPFER_RUECKENDECKUNG_3 R
/set_var CFG_STATUS_COLOR_KAEMPFER_RUECKENDECKUNG_3 Cbgyellow,Cblue
/set_var CFG_MG_KAEMPFER_RUECKENDECKUNG_AUF_ECHO_TEXT Rueckendeckung an: %-1
/set_var CFG_MG_KAEMPFER_RUECKENDECKUNG_AUF_ECHO_ATTR Cgreen
/set_var CFG_MG_KAEMPFER_RUECKENDECKUNG_AUF_AUS_ECHO_TEXT Rueckendeckung an: %-1
/set_var CFG_MG_KAEMPFER_RUECKENDECKUNG_AUF_AUS_ECHO_ATTR Cred
/set_var CFG_MG_KAEMPFER_RUECKENDECKUNG_VON_ECHO_TEXT Rueckendeckung von: %-1
/set_var CFG_MG_KAEMPFER_RUECKENDECKUNG_VON_ECHO_ATTR Cgreen
/set_var CFG_MG_KAEMPFER_RUECKENDECKUNG_VON_AUS_ECHO_TEXT Rueckendeckung von: %-1
/set_var CFG_MG_KAEMPFER_RUECKENDECKUNG_VON_AUS_ECHO_ATTR Cred
/set_var CFG_MG_KAEMPFER_RUECKENDECKUNG_MISSLUNGEN_ECHO_TEXT Rueckendeckung misslungen
/set_var CFG_MG_KAEMPFER_RUECKENDECKUNG_MISSLUNGEN_ECHO_ATTR Cred

; Raserei
/set_var CFG_MG_KAEMPFER_RASEREI_ECHO_TEXT Raserei
/set_var CFG_MG_KAEMPFER_RASEREI_ECHO_ATTR Cgreen
/set_var CFG_MG_KAEMPFER_RASEREI_ALR_ECHO_TEXT Raserei schon an
/set_var CFG_MG_KAEMPFER_RASEREI_ALR_ECHO_ATTR Cyellow
/set_var CFG_MG_KAEMPFER_RASEREI_AUS_ECHO_TEXT Raserei
/set_var CFG_MG_KAEMPFER_RASEREI_AUS_ECHO_ATTR Cred
/set_var CFG_MG_KAEMPFER_RASEREI_ANGST_ECHO_TEXT Raserei unoeglich (Vorsicht zu hoch)
/set_var CFG_MG_KAEMPFER_RASEREI_ANGST_ECHO_ATTR Cred
/set_var CFG_MG_KAEMPFER_RASEREI_ANGST_AUS_ECHO_TEXT Raserei (Vorsicht zu hoch)
/set_var CFG_MG_KAEMPFER_RASEREI_ANGST_AUS_ECHO_ATTR Cred

; Kampfwille
/set_var CFG_MG_KAEMPFER_KAMPFWILLE_PARALYSE_ECHO_TEXT Paralyse
/set_var CFG_MG_KAEMPFER_KAMPFWILLE_PARALYSE_ECHO_ATTR Cred
/set_var CFG_MG_KAEMPFER_KAMPFWILLE_VOLLST_ECHO_TEXT Kamfpwille (vollstaendig)
/set_var CFG_MG_KAEMPFER_KAMPFWILLE_VOLLST_ECHO_ATTR Cgreen
/set_var CFG_MG_KAEMPFER_KAMPFWILLE_TEILW_ECHO_TEXT Kamfpwille (teilweise)
/set_var CFG_MG_KAEMPFER_KAMPFWILLE_TEILW_ECHO_ATTR Cgreen

; KO-Schlag
/set_var CFG_MG_KAEMPFER_KO_ECHO_TEXT KO-Schlag: %-1
/set_var CFG_MG_KAEMPFER_KO_ECHO_ATTR Cgreen
/set_var CFG_MG_KAEMPFER_KO_NICHT_ECHO_TEXT KO-Schlag: %-1
/set_var CFG_MG_KAEMPFER_KO_NICHT_ECHO_ATTR Cred

; Block
/set_var CFG_MG_KAEMPFER_BLOCK_ECHO_TEXT Block: %-1
/set_var CFG_MG_KAEMPFER_BLOCK_ECHO_ATTR Cgreen
/set_var CFG_MG_KAEMPFER_BLOCK_AUS_ECHO_TEXT Block: %-1
/set_var CFG_MG_KAEMPFER_BLOCK_AUS_ECHO_ATTR Cred
/set_var CFG_MG_KAEMPFER_BLOCK_NICHT_ECHO_TEXT Block: %-1
/set_var CFG_MG_KAEMPFER_BLOCK_NICHT_ECHO_ATTR Cred
/set_var CFG_MG_KAEMPFER_BLOCK_WAFFE_ECHO_TEXT %-1
/set_var CFG_MG_KAEMPFER_BLOCK_WAFFE_ECHO_ATTR Cred

; Kampfsprung
/set_var CFG_MG_KAEMPFER_KAMPFSPRUNG_ECHO_TEXT Kampfsprung
/set_var CFG_MG_KAEMPFER_KAMPFSPRUNG_ECHO_ATTR Cgreen

; Erschoepfung
/set_var CFG_MG_KAEMPFER_ERSCHOEPFUNG_ECHO_TEXT Erschoepfung %-1
/set_var CFG_MG_KAEMPFER_ERSCHOEPFUNG_ECHO_ATTR Cred

; Erschoepfung
/set_var CFG_MG_KAEMPFER_KPS_ALLE_ECHO_TEXT Zu wenig KPs!
/set_var CFG_MG_KAEMPFER_KPS_ALLE_ECHO_ATTR Cred

;;; Variablen initilisieren

/set kaempfer_parade 0
/set kaempfer_schildparade 0
/set kaempfer_kampftaktik 0
/set kaempfer_schmerzen 1
/set kaempfer_schmerzen_unterdrueckt 0
/set kaempfer_rueckendeckung 0
/set kaempfer_rueckendeckung_auf 0
/set kaempfer_rueckendeckung_von 0

/set p_taktik 0

;;; Statusmodule

/set sl_kaempfer_parade_doc=Parade aktiv ($[status_doc_attr("KAEMPFER_PARADE")])
/def sl_kaempfer_parade = \
	/set_status_var_flag kaempfer_parade kaempfer_parade 1

/set sl_kaempfer_schildparade_doc=Schildparade aktiv ($[status_doc_attr("KAEMPFER_SCHILDPARADE")])
/def sl_kaempfer_schildparade = \
	/set_status_var_flag kaempfer_schildparade kaempfer_schildparade 1

/set sl_kaempfer_taktik_doc=Allgemeine Taktik
/def sl_kaempfer_taktik = \
        /init_var p_taktik%;\
        /return status_var("p_taktik",3)

/set sl_kaempfer_kampftaktik_doc=Kampftaktiken: Schildkroete ($[status_doc_attr("KAEMPFER_KAMPFTAKTIK_1")]), Drachen ($[status_doc_attr("KAEMPFER_KAMPFTAKTIK_2")]) und Schlange $[status_doc_attr("KAEMPFER_KAMPFTAKTIK_3")]
/def sl_kaempfer_kampftaktik = \
	/set_status_var_count kaempfer_kampftaktik kaempfer_kampftaktik 1 3

/set sl_kaempfer_lp_text_doc=LP Text:Keine Schmerzen ($[status_doc_attr("KAEMPFER_SCHMERZEN_1")]), Schmerzen ($[status_doc_attr("KAEMPFER_SCHMERZEN_2")]), Schmerzen unterdrueckt ($[status_doc_attr("KAEMPFER_SCHMERZEN_3")])
/def sl_kaempfer_lp_text = \
	/set_status_var_count kaempfer_schmerzen kaempfer_schmerzen 2 3

/set sl_kaempfer_rueckendeckung_doc=Rueckendeckung
/def sl_kaempfer_rueckendeckung = \
    	/set_status_var_count kaempfer_rueckendeckung kaempfer_rueckendeckung 1 3

;;; Trigger
; Fokus
/def -Fp8 -q -w -agCblue -mregexp -t'^Du richtest Deine ganze \
	Aufmerksamkeit auf (den |die |einen |eine |)(.+)\\.$' kaempfer_fokus_neu = \
		/cfg_echo MG_KAEMPFER_FOKUS %P2

/def -Fp8 -q -w -agCblue -mregexp -t'^Du konzentrierst Dich doch schon \
	auf (den |die |einen |eine |)(.+)!$' kaempfer_fokus = \
	/cfg_echo MG_KAEMPFER_FOKUS_ALR %P2

; Allgemeine Taktik
/def kaempfer_get_taktik = \
	/def -1 -p9 -q -w -agCblue -mregexp -q -t'^Du kaempfst mit (.*)\\\\% Defensive\
	\\\\.$$' kaempfer_taktik_test = \
		/set p_taktik %%P1%;\
	!taktik

/def -Fp8 -q -w -agCblue -mregexp -q -t'^Du kaempfst mit (.*)\\% Defensive\
    \\.$' kaempfer_taktik=\
	/cfg_echo MG_KAEMPFER_TAKTIK_ALR %P1%;\
	/set p_taktik %P1

/def -Fp8 -q -w -agCblue -mregexp -q -t'^Du aenderst Deine Taktik und kaempfst \
	nun mit (.*)\\% Defensive\\.$' kaempfer_taktik_neu = \
	/cfg_echo MG_KAEMPFER_TAKTIK %P1%;\
	/set p_taktik %P1

/def -Fp8 -q -w -agCblue -mregexp -q -t'^Du kaempfst doch schon mit (.*)\\% \
    Defensive!' kaempfer_taktik_neu2 = \
	/cfg_echo MG_KAEMPFER_TAKTIK %P1%;\
	/set p_taktik %P1

; (Schild)Parade
/def -Fp8 -q -w -agCblue -mregexp -q -t'^Du parierst die naechsten \
    Angriffe mit (.*)\\.$' kaempfer_parade_an=\
    /let womit %P1%;\
    /if ((womit =/ '*Kieferknochen')|(womit =/ '*[Ss]child*')|\
        (womit =/ '*[Ss]chuppe*')|(womit =/ '*Kampfblech')) \
                /set kaempfer_schildparade 1%;\
                /killall -q kaempfer_schildparade%;\
                /repeat -30 1 /set kaempfer_schildparade 0%;\
                /cfg_echo MG_KAEMPFER_SCHILDPARADE %womit%;\
    /else \
                /set kaempfer_parade 1%;\
                /killall -q kaempfer_parade%;\
                /repeat -30 1 /set kaempfer_parade 0%;\
                /cfg_echo MG_KAEMPFER_PARADE %womit%;\
    /endif

/def -Fp8 -q -agCblue -msimple -t'Du konzentrierst Dich auf die Bewegungen des Parierens mit dem Schild, um im' kaempfer_schparade_vorher_1 = \
    /def -1 -Fp8 -q -agCblue -msimple -t'kommenden Kampf vorbereitet zu sein.' kaempfer_schildparade_vorher_2 = \
        /set kaempfer_schildparade 1%%;\
        /killall -q kaempfer_schildparade%%;\
        /repeat -30 1 /set kaempfer_schildparade 0%%;\
        /cfg_echo MG_KAEMPFER_SCHILDPARADE konzentration

/def -Fp8 -q -agCblue -msimple -t'Du konzentrierst Dich auf die Bewegungen des Parierens, um im kommenden Kampf' kaempfer_parade_vorher1 = \
    /def -1 -Fp8 -q -agCblue -msimple -t'vorbereitet zu sein.' kaempfer_parade_vorher2 = \
        /set kaempfer_parade 1%%;\
        /killall -q kaempfer_parade%%;\
        /repeat -30 1 /set kaempfer_parade 0%%;\
        /cfg_echo MG_KAEMPFER_PARADE konzentration

/def -Fp8 -q -agCblue -msimple -t'Du parierst doch schon mit Deinem Schild!' kaempfer_schildparade_already =\
        /set kaempfer_schildparade 1%;\
        /killall -q kaempfer_schildparade%;\
        /repeat -30 1 /set kaempfer_schildparade 0%;\
	/cfg_echo MG_KAEMPFER_SCHILDPARADE_ALR noch an

/def -Fp8 -q -agCblue -msimple -t'Du parierst doch schon mit Deiner Waffe!' kaempfer_parade_already = \
        /set kaempfer_parade 1%;\
        /killall -q kaempfer_parade%;\
        /repeat -30 1 /set kaempfer_parade 0%;\
	/cfg_echo MG_KAEMPFER_PARADE_ALR noch an

/def -Fp8 -q -agCblue -msimple -t'Du beendest Deine Parade.' kaempfer_parade_aus = \
        /killall -q kaempfer_parade%;\
        /set kaempfer_parade 0%;\
	/cfg_echo MG_KAEMPFER_PARADE_AUS

/def -Fp8 -q -agCblue -msimple -t'Du beendest Deine Schildparade.' kaempfer_schildparade_aus = \
        /killall -q kaempfer_schildparade%;\
        /set kaempfer_schildparade 0%;\
	/cfg_echo MG_KAEMPFER_SCHILDPARADE_AUS

; Schnell
/def -Fp8 -q -agCblue -t'Du kaempfst jetzt schneller!' kaempfer_schnell = \
	/cfg_echo MG_KAEMPFER_SCHNELL

/def -Fp8 -q -agCblue -q -t'Deine Arme sind vom letzten schnellen Kaempfen noch zu erschoepft!' kaempfer_schnell_erschoepfung = \
	/cfg_echo MG_KAEMPFER_ERSCHOEPFUNG Schnell

; Kampftaktik (Schildkroete)

/def -Fp8 -agCblue -msimple -q -t'Du kaempfst nun mit der Kampftechnik der \
        Schildkroete.' kaempfer_schildkroete_an = \
        /set kaempfer_kampftaktik 1%;\
        /killall -q kaempfer_kampftaktik%;\
        /repeat -90 1 /set kaempfer_kampftaktik 0%;\
        /cfg_echo MG_KAEMPFER_KAMPFTAKTIK_SK

/def -Fp8 -agCblue -msimple -q -t'Du beendest die Kampftechnik Schildkroete.' \
        kaempfer_schildkroete_aus = \
        /set kaempfer_kampftaktik 0%;\
        /killall -q kaempfer_kampftaktik%;\
	/cfg_echo MG_KAEMPFER_KAMPFTAKTIK_SK_AUS

/def -Fp8 -agCblue -msimple -q -t'Du machst doch schon die Kampftechnik \
	\'Schildkroete\'.' kaempfer_schildkroete_alr = \
        /set kaempfer_kampftaktik 1%;\
        /killall -q kaempfer_kampftaktik%;\
        /repeat -90 1 /set kaempfer_kampftaktik 0%;\
        /cfg_echo MG_KAEMPFER_KAMPFTAKTIK_SK_ALR

; Kampftaktik (Drache)

/def -Fp8 -agCblue -msimple -q -t'Du kaempfst nun mit der Kampftechnik des \
        Drachen.' kaempfer_drache_an=\
        /set kaempfer_kampftaktik 2%;\
        /killall -q kaempfer_kampftaktik%;\
        /repeat -90 1 /set kaempfer_kampftaktik 0%;\
        /cfg_echo MG_KAEMPFER_KAMPFTAKTIK_DR

/def -Fp8 -agCblue -msimple -q -t'Du beendest die Kampftechnik Drache.' \
        kaempfer_drache_aus1=\
        /set kaempfer_kampftaktik 0%;\
        /killall -q kaempfer_kampftaktik%;\
        /cfg_echo MG_KAEMPFER_KAMPFTAKTIK_DR_AUS

/def -Fp8 -ahCblue -msimple -q -t'Du beendest die Kampftechnik *Drache*.' kaempfer_drache_aus2=\
        /set kaempfer_kampftaktik 0%;\
        /killall -q kaempfer_kampftaktik%;\
        /cfg_echo MG_KAEMPFER_KAMPFTAKTIK_DR_AUS

/def -Fp8 -agCblue -msimple -q -t'Du machst doch schon die Kampftechnik \
	\'Drache\'.' kaempfer_drache_alr = \
        /set kaempfer_kampftaktik 2%;\
        /killall -q kaempfer_kampftaktik%;\
        /repeat -90 1 /set kaempfer_kampftaktik 0%;\
        /cfg_echo MG_KAEMPFER_KAMPFTAKTIK_DR_ALR

; Kampftaktik (Schlange)

/def -Fp8 -agCblue -msimple -q -t'Du kaempfst nun die Technik der Schlange und \
        machst dabei schnelle,' kaempfer_schlange_an = \
	/def -1 -Fp8 -agCblue -msimple -q -t'gefaehrliche Schlaege, die aber Deine Deckung \
    		nie oeffnen.' kaempfer_schlange_an2=\
    		/set kaempfer_kampftaktik 3%;\
    		/killall -q kaempfer_kampftaktik%;\
    		/repeat -90 1 /set kaempfer_kampftaktik 0%;\
    		/cfg_echo MG_KAEMPFER_KAMPFTAKTIK_SL

/def -Fp8 -agCblue -mglob -q -t'Du beendest die Kampftechnik *Schlange.' \
        kaempfer_schlange_aus=\
        /set kaempfer_kampftaktik 0%;\
        /killall -q kaempfer_kampftaktik%;\
        /cfg_echo MG_KAEMPFER_KAMPFTAKTIK_SL_AUS

/def -Fp8 -agCblue -msimple -q -t'Du machst doch schon die Kampftechnik \
	\'Schlange\'.' kaempfer_schlange_alr = \
        /set kaempfer_kampftaktik 3%;\
        /killall -q kaempfer_kampftaktik%;\
        /repeat -90 1 /set kaempfer_kampftaktik 0%;\
        /cfg_echo MG_KAEMPFER_KAMPFTAKTIK_SL_ALR

; Unterlaufe
/def -Fp8 -agCblue -mregexp -q -t'^Dir gelingt es, die Waffe (des |der |einer |eines |)(.+)([s]?) zu unterlaufen\\.$' kaempfer_unterlaufe = \
	/cfg_echo MG_KAEMPFER_UNTERLAUFEN %P2

/def -Fp8 -agCblue -mregexp -q -t'^(Der |Die |Das |Ein |Eine |)(.+)([s]?) besitzt keine Waffe, die Du unterlaufen koenntest\\.$' kaempfer_unterlaufe_nicht = \
	/cfg_echo MG_KAEMPFER_UNTERLAUFEN_NICHT %P2

/def -Fp8 -agCblue -mregexp -q -t'^(Der |Die |Das |Ein |Eine |)(.+)([s]?) weicht Dir geschickt aus\\.$' kaempfer_unterlaufe_nicht2 = \
	/cfg_echo MG_KAEMPFER_UNTERLAUFEN_NICHT %P2

/def -Fp8 -agCblue -mregexp -q -t'Du hast schon (den |die |einen |eine |)(.+)([s]?) unterlaufen!' kaempfer_unterlaufe_alr = \
	/cfg_echo MG_KAEMPFER_UNTERLAUFEN_ALR %P2

/def -Fp8 -agCblue -mregexp -q -t'^(Der |Die |Das |Ein |Eine |)(.+)([s]?) geht wieder auf Distanz zu Dir\\.' kaempfer_unterlaufe_aus = \
	/cfg_echo MG_KAEMPFER_UNTERLAUFEN_AUS %P2

; Finte
/def -Fp8 -agCblue -mregexp -q -t'^Du machst eine erfolgreiche Finte gegen (den |die |einen |eine |)(.+)\\.$' kaempfer_finte = \
	/cfg_echo MG_KAEMPFER_FINTE %P2

/def -Fp8 -agCblue -mregexp -q -t'^(Der |Die |Das |Ein |Eine |)(.+) faellt nicht auf die Finte herein!$' kaempfer_finte_nicht = \
	/cfg_echo MG_KAEMPFER_FINTE_NICHT %P2

/def -Fp8 -agCblue -mregexp -q -t'^(Der |Die |Das |Ein |Eine |)(.+) ist irgendwie gegen die Finte geschuetzt\\.$' kaempfer_finte_nicht2 = \
	/cfg_echo MG_KAEMPFER_FINTE_NICHT %P2

; Waffentrick
/def -Fp8 -agCblue -mregexp -q -t'^Du machst einen Waffentrick gegen (den |die |einen |eine |)(.+)\\.$' kaempfer_waffentrick = \
	/cfg_echo MG_KAEMPFER_WAFFENTRICK %P2

/def -Fp8 -agCblue -mregexp -q -t'^(Der |Die |Das |Ein |Eine |)(.+) ist irgendwie gegen den Waffentrick geschuetzt\\.$' kaempfer_waffentrick_nicht = \
	/cfg_echo MG_KAEMPFER_WAFFENTRICK_NICHT %P2

; Schmerzen
/add_to_hook points /kaempfer_check_schmerzen %1

/def kaempfer_check_schmerzen = \
    /let kaempfer_lp %1%;\
    /if ({kaempfer_lp}<141) \
	/if ({kaempfer_schmerzen_unterdrueckt}) \
	    /set kaempfer_schmerzen 3%;\
	/else \
	    /set kaempfer_schmerzen 2%;\
	/endif%;\
    /else \
	/set kaempfer_schmerzen_unterdrueckt 0%;\
	/set kaempfer_schmerzen 1%;\
    /endif

/def -Fp8 -agCblue -msimple -q -t'Du beisst ob der Schmerzen die Zaehne \
        zusammen.' kaempfer_schmerzen=\
        /set kaempfer_schmerzen_unterdrueckt 1%;\
        /cfg_echo MG_KAEMPFER_SCHMERZEN_UNTERDRUECKT

/def -Fp8 -agCblue -msimple -q -t'Du schaffst es nicht mehr, die Schmerzen \
        weiterhin zu ignorieren.' kaempfer_schmerzen_aus=\
        /set kaempfer_schmerzen_unterdrueckt 0%;\
        /cfg_echo MG_KAEMPFER_SCHMERZEN_UNTERDRUECKT_AUS

/def -Fp8 -agCblue -msimple -q -t'Der Verlust an Lebenspunkten beeinflusst \
	bisher noch nicht Deine Kampfkraft!' kaempfer_schmerzen_UNNOETIG = \
	/cfg_echo MG_KAEMPFER_SCHMERZEN_UNNOETIG

; Rueckendeckung
/def kaempfer_check_rueckendeckung = \
	/if ({kaempfer_rueckendeckung_auf}) \
		/if ({kaempfer_rueckendeckung_von}) \
			/set kaempfer_rueckendeckung 3%;\
		/else \
			/set kaempfer_rueckendeckung 1%;\
		/endif%;\
	/else \
		/if ({kaempfer_rueckendeckung_von}) \
			/set kaempfer_rueckendeckung 2%;\
		/else \
			/set kaempfer_rueckendeckung 0%;\
		/endif%;\
	/endif

/def -Fp8 -agCblue -mregexp -q -t'^([a-zA-Z]*) gibt Dir Rueckendeckung\\.$' kaempfer_rueckendeckung_von = \
	/set kaempfer_rueckendeckung_von 1%;\
	/kaempfer_check_rueckendeckung%;\
	/cfg_echo MG_KAEMPFER_RUECKENDECKUNG_VON %P1

/def -Fp8 -agCblue -mregexp -q -t'^([a-zA-Z]*) gibt Dir keine Rueckendeckung mehr\\.$' kaempfer_rueckendeckung_von_aus=\
	/set kaempfer_rueckendeckung_von 0%;\
	/kaempfer_check_rueckendeckung%;\
	/cfg_echo MG_KAEMPFER_RUECKENDECKUNG_VON_AUS %P1

/def -Fp8 -agCblue -mregexp -q -t'^Du gibst (.*) Rueckendeckung\\.$' kaempfer_rueckendeckung_auf = \
	/set kaempfer_rueckendeckung_auf 1%;\
	/kaempfer_check_rueckendeckung%;\
	/cfg_echo MG_KAEMPFER_RUECKENDECKUNG_AUF %P1

/def -Fp8 -agCblue -mregexp -q -t'^Du beendest die Rueckendeckung fuer (.*)\\.$' kaempfer_rueckendeckung_auf_aus = \
	/set kaempfer_rueckendeckung_auf 0%;\
	/kaempfer_check_rueckendeckung%;\
	/cfg_echo MG_KAEMPFER_RUECKENDECKUNG_AUF_AUS %P1

/def -Fp8 -agCblue -q -msimple -t'Deine Rueckendeckung scheitert klaeglich. Aua!' kaempfer_rueckendeckung_misslungen = \
	/cfg_echo MG_KAEMPFER_RUECKENDECKUNG_MISSLUNGEN

/def -Fp8 -agCblue -q -t'So oft hintereinander kannst Du keine Rueckendeckung fuer andere*' kaempfer_rueckendeckung_busy = \
    /def -1 -Fp8 -agCblue -q -msimple -t'Spieler machen!' kaempfer_rueckendeckung_busy2 = \
	/cfg_echo MG_KAEMPFER_ERSCHOEPFUNG Rueckendeckung

; Raserei
/def -Fp8 -agCblue -q -msimple -t'Du steigerst Dich in wilde Raserei!' kaempfer_raserei_an = \
	/cfg_echo MG_KAEMPFER_RASEREI

/def -Fp8 -agCblue -q -msimple -t'Du beendest Deine Raserei!' kaempfer_raserei_aus = \
	/cfg_echo MG_KAEMPFER_RASEREI_AUS

/def -Fp8 -agCblue -q -msimple -t'Du bist fuer eine richtige Raserei viel zu aengstlich.' kaempfer_raserei_angst = \
	/cfg_echo MG_KAEMPFER_RASEREI_ANGST

/def -Fp8 -agCblue -q -msimple -t'Du bist zu aengstlich und beendest Deine Raserei.' kaempfer_raserei_angst_aus = \
	/cfg_echo MG_KAEMPFER_RASEREI_ANGST_AUS

/def -Fp8 -agCblue -q -msimple -t'Du bist schon in wilder Raserei!' kaempfer_raserei_alr = \
	/cfg_echo MG_KAEMPFER_RASEREI_ALR

; Kampfwille
; GL einbauen
/def -Fp8 -agCblue -q -msimple -t'Du bist irgendwie paralysiert und kannst Dich nicht richtig bewegen!' kaempfer_kampfwille_paralyse = \
    /cfg_echo MG_KAEMPFER_KAMPFWILLE_PARALYSE%;\
    /if ({KAEMPFER_AUTO_KAMPFWILLE}) \
	!kampfwille%;\
    /endif

/def -Fp8 -agCblue -q -msimple -t'Du konzentrierst Dich und versuchst Dich aus der Paralyse zu befreien.' kaempfer_kampfwille = \
	/def -1 -Fp8 -agCblue -q -msimple -t'Du schuettelst Deine Benommenheit vollstaendig ab!' kaempfer_kampfwille_vollst = \
		/cfg_echo MG_KAEMPFER_KAMPFWILLE_VOLLST%;\
	/def -1 -Fp8 -agCblue -q -msimple -t'Du schuettelst Deine Benommenheit teilweise ab.' kaempfer_kaempfwille_teilw = \
		/cfg_echo MG_KAEMPFER_KAMPFWILLE_TEILW

; KO-Schlag
/def -Fp8 -agCblue -q -msimple -t'Du kannst so kurz nach einem Waffenwechsel keinen KO-Schlag machen.' kaempfer_ko_erschoepfung = \
	/cfg_echo MG_KAEMPFER_ERSCHOEPFUNG KO-Schlag

/def -Fp8 -agCblue -q -msimple -t'Du bist gerade erst in den Raum gestuerzt und hast noch zuwenig Orientierung' kaempfer_ko_erschoepfung2 = \
	/def -1 -Fp8 -agCblue -q -msimple -t'fuer einen KO-Schlag.' kaempfer_ko_erschoepfung3 = \
		/cfg_echo MG_KAEMPFER_ERSCHOEPFUNG KO-Schlag

/def -Fp8 -agCblue -q -mregexp -t'^Du machst einen KO-Schlag gegen (den |die |einen |eine |)(.+), doch er erzielt keine Wirkung\\.$' kaempfer_ko_nicht = \
	/cfg_echo MG_KAEMPFER_KO_NICHT %P2

/def -Fp8 -agCblue -q -mregexp -t'^Du machst einen gelungenen KO-Schlag gegen (den |die |einen |eine |)(.+)\\.$' kaempfer_ko = \
	/cfg_echo MG_KAEMPFER_KO %P2

; Block
/def -Fp8 -agCblue -q -mregexp -t'^Du blockierst die Waffe (des |der |einer |eines |)(.+)([s]?) mit der' kaempfer_block = \
	/cfg_echo MG_KAEMPFER_BLOCK %P2

/def -Fp8 -agCblue -q -msimple -t'Du siehst im Moment keine Moeglichkeit fuer einen Block.' kaempfer_block_erschoepfung = \
	/cfg_echo MG_KAEMPFER_ERSCHOEPFUNG Block

/def -Fp8 -agCblue -q -msimple -t'Deine Waffe ist blockiert!' kaempfer_block_waffe = \
	/cfg_echo MG_KAEMPFER_BLOCK_WAFFE %*

/def -Fp8 -agCblue -q -mregexp -t'^(Der |Die |Das |Ein |Eine |)(.+)([s]?) befreit sich aus Deinem Block!$' kaempfer_block_aus = \
	/cfg_echo MG_KAEMPFER_BLOCK_AUS %P2

; Kampfsprung
/def -Fp8 -agCblue -q -mregexp -t'Du landest sicher auf Deinen Fuessen und bist sofort kampfbereit.' kaemper_kampfsprung = \
	/cfg_echo MG_KAEMPFER_KAMPFSPRUNG

; Erschoepfung (Allgemein)
/def -Fp8 -agCblue -q -msimple -t'Du siehst im Moment keine Moeglichkeiten fuer diese Aktion!' kaempfer_erschoepfung_1 = \
	/cfg_echo MG_KAEMPFER_ERSCHOEPFUNG

/def -Fp8 -agCblue -q -msimple -t'So schnell bist Du nicht! Willst Du Dir saemtliche Knochen brechen?' kaempfer_erschoepfung_2 = \
	/cfg_echo MG_KAEMPFER_ERSCHOEPFUNG

/def -Fp8 -agCblue -mregexp -q -t'So haeufig hintereinander kannst Du keinen (.+) machen!' kaempfer_erschoefpung_3 = \
	/cfg_echo MG_KAEMPFER_ERSCHOEPFUNG %P1

; Keine Kps
/def -Fp8 -agCblue -q -msimple -t'Deine Konzentrationsfaehigkeit reicht dafuer nicht mehr aus!' kaempfer_kp_alle = \
	/cfg_echo MG_KAEMPFER_KPS_ALLE

;;; Sachen beim Start einstellen

/kaempfer_get_taktik
/send report ein
  