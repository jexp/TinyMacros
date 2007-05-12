; $Log: fehlschlaege.tf,v $
; Revision 1.2  2002/06/16 09:04:29  thufhnik
; Warum sagt mir keiner, dass ich nen uraltes File als Vorlage hatte? ;)
;
; Revision 1.1  2002/06/12 12:52:42  thufhnik
; Ueberarbeitetes File von Ringor
;

/set fehlschlaege_tf_version $Id: fehlschlaege.tf,v 1.2 2002/06/16 09:04:29 thufhnik Exp $
/set fehlschlaege_tf_author=Thufhir@mg.mud.de
/set fehlschlaege_tf_requires=
/set fehlschlaege_tf_desc Fehlschlaege mitzaehlen fuer Trves


;;; Eventuell noch vorhandene Versionen der Trigger aus dem Speicher loeschen:

/purge FehlschlagZaehler*
/purge fehlschlaege
/purge remove_fehlschlaege


;;; Konfigurierbares

/set_var CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Ccyan
/set_var CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Cred


;;; Alle Macros und Trigger koennen per Befehl wieder entfernt werden:

/def remove_fehlschlaege = \
	/purge FehlschlagZaehler*%;\
	/purge fehlschlaege%;\
	/quote -S /unset `"/listvar -mglob -s fs_*%;\
	/purge remove_fehlschlaege


;;; Die Variablen initialisieren:

/set fs_kopfst_z 0
/set fs_wt_z 0
/set fs_ellbogen_z 0
/set fs_wb_z 0
/set fs_rd_z 0
/set fs_ko_z 0
/set fs_bl_z 0
/set fs_stz_z 0
/set fs_dra_z 0
/set fs_kw_z 0
/set fs_kniest_z 0
/set fs_fi_z 0
/set fs_ts_z 0
/set fs_ras_z 0
/set fs_ws_z 0
/set fs_kt_z 0
/set fs_un_z 0
/set fs_was_z 0
/set fs_ww_z 0
/set fs_bs_z 0
/set fs_schst_z 0
/set fs_sch_z 0
/set fs_ident_z 0
/set fs_tak_z 0
/set fs_ksp_z 0
/set fs_schm_z 0
/set fs_sk_z 0
/set fs_par_z 0
/set fs_spar_z 0
/set fs_sna_z 0
/set fs_fo_z 0
/set fs_pat_z 0


;;; Die einzelnen Fehlschlags-Trigger

/def -p1 -q -msimple -ag -t'Der Kopfstoss ging daneben.' FehlschlagZaehler1 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Fehlschlaege \
	bei Kopfstoss heute: $[++fs_kopfst_z]

/def -p2 -q -msimple -ag -t'Der Kopfstoss geht so daneben, dass Du stolperst \
	und nur den' FehlschlagZaehler1 = \
	/if /!ismacro FehlschlagZaehler1b%; /then \
	/def -1 -p50 -q -msimple -ag -t'Boden triffst.' FehlschlagZaehler1b = \
		/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
			Fehlschlaege bei Kopfstoss heute: $$[++fs_kopfst_z] \
			(LP-Abzug!)%;\
	/endif

/def -p1 -q -mglob -ag -t'Der Waffentrick gegen * klappt nicht so recht.' \
	FehlschlagZaehler2 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Fehlschlaege \
		bei Waffentrick heute: $[++fs_wt_z]

/def -p1 -q -msimple -ag -t'Der Schlag mit dem Ellbogen ging daneben.' \
	FehlschlagZaehler3 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Fehlschlaege \
		bei Ellbogenschlag heute: $[++fs_ellbogen_z]

/def -p2 -q -mglob -ag -t'Du schwingst * kraeftig gegen die Waffe *' \
	FehlschlagZaehler4 = \
	/if /!ismacro FehlschlagZaehler4b%; /then \
		/def -1 -p50 -q -mglob -ag -t'*leider verfehlst Du * \
			voellig.' FehlschlagZaehler4b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Fehlschlaege bei Waffenbruch heute: \
				$$[++fs_wb_z]%;\
	/endif

/def -q -mglob -ag -p2 -t'Du versuchst * Rueckendeckung zu geben, doch Dir *' \
	FehlschlagZaehler5 = \
	/if /!ismacro FehlschlagZaehler5b%; /then \
		/def -1 -p50 -q -mglob -ag -t'*nicht.' FehlschlagZaehler5b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Fehlschlaege bei Rueckendeckung heute: \
				$$[++fs_rd_z]%;\
	/endif

/def -p1 -q -msimple -ag -t'Der KO-Schlag geht ins Leere.' \
	FehlschlagZaehler6 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Fehlschlaege \
		bei KO-Schlag heute: $[++fs_ko_z]

/def -p1 -q -msimple -ag -t'Der Block ging voellig daneben.' \
	FehlschlagZaehler7 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Fehlschlaege \
		bei Block heute: $[++fs_bl_z]

/def -p1 -q -msimple -ag -t'Dir gelingt es nicht, in die Kampftechnik der \
	Schildkroete ueberzugehen.' FehlschlagZaehler8 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Fehlschlaege \
		bei Schildkroete heute: $[++fs_sch_z]

/def -p1 -q -msimple -ag -t'Dir gelingt es nicht, Dich in die Kampftechnik des \
	Drachens zu versetzen.' FehlschlagZaehler9 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Fehlschlaege \
		bei Drache heute: $[++fs_dra_z]

/def -p3 -q -mglob -ag -t'Der Waffenwurf ist misslungen. Du laesst *' \
	FehlschlagZaehler10 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Fehlschlaege \
		bei Waffenwurf heute: $[++fs_ww_z]

/def -p1 -q -msimple -ag -t'Der Kniestoss ging daneben.' FehlschlagZaehler11 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Fehlschlaege \
		bei Kniestoss heute: $[++fs_kniest_z]

/def -p1 -q -msimple -ag -t'Deine Finte geht ins Leere.' FehlschlagZaehler12 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Fehlschlaege \
		bei Finte heute: $[++fs_fi_z]

/def -p1 -q -mglob -ag -t'Der Todesstoss verfehlt * voellig.' \
	FehlschlagZaehler13 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Fehlschlaege \
		bei Todesstoss heute: $[++fs_ts_z]

/def -p1 -q -msimple -ag -t'Du schaffst es nicht, Dich in eine Raserei zu \
	versetzen.' FehlschlagZaehler14 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Fehlschlaege \
		bei Raserei heute: $[++fs_ras_z]

/def -p1 -q -mglob -ag -t'Der Waffenschlag verfehlt * voellig.' \
	FehlschlagZaehler15 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Fehlschlaege \
		bei Waffenschlag heute: $[++fs_ws_z]

/def -p2 -q -msimple -ag -t'Du versuchst krampfhaft, gegen Deine \
	Kampfbeeintraechtigung anzukaempfen,' FehlschlagZaehler16 = \
	/if /!ismacro FehlschlagZaehler16b%; /then \
		/def -1 -p50 -q -msimple -ag -t'doch dies gelingt Dir leider \
			nicht.' FehlschlagZaehler16b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Fehlschlaege bei Kampfwille heute: \
				$$[++fs_kw_z]%;\
	/endif

/def -p1 -q -msimple -ag -t'Der Kampftritt ging daneben.' \
	FehlschlagZaehler17 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Fehlschlaege \
		bei Kampftritt heute: $[++fs_kt_z]

/def -p1 -q -mglob -ag -t'Dir gelingt es nicht, * zu unterlaufen.' \
	FehlschlagZaehler18 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Fehlschlaege \
		bei Unterlaufen heute: $[++fs_un_z]

/def -p2 -q -mglob -ag -t'Du versuchst * zu schaerfen, doch*' \
	FehlschlagZaehler19 = \
	/if /!ismacro FehlschlagZaehler19b%; /then \
		/def -1 -p50 -q -mglob -ag -t'*gelingen.' \
			FehlschlagZaehler19b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Fehlschlaege bei Waffenschaerfen heute: \
				$$[++fs_was_z]%;\
	/endif

/def -p1 -q -msimple -ag -t'Dir faellt doch tatsaechlich nichts Boesartiges \
	ein.' FehlschlagZaehler20 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Fehlschlaege \
		bei Beschimpfen heute: $[++fs_bs_z]

/def -p1 -q -mglob -ag -t'Der Schildstoss gegen * ging daneben.' \
	FehlschlagZaehler21 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Fehlschlaege \
		bei Schildstoss heute: $[++fs_schst_z]

/def -p1 -q -msimple -ag -t'Du bist irgendwie zu unkonzentriert.' \
	FehlschlagZaehler22 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Fehlschlaege \
		bei Schaetzen heute: $[++fs_stz_z]

/def -p2 -q -mglob -ag -t'Du streichst mit Deinem Yrdstein ueber *, \
	schaffst*' FehlschlagZaehler23 = \
	/if /!ismacro FehlschlagZaehler23b%; /then \
		/def -1 -p50 -q -mglob -ag -t'*eine Information zu erhalten.' \
			FehlschlagZaehler23b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Fehlschlaege bei Identifizieren heute: \
				$$[++fs_ident_z]%;\
	/endif

/def -p1 -q -msimple -ag -t'Dir gelingt es nicht, Dich auf die neue Taktik \
	einzustellen.' FehlschlagZaehler24 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Fehlschlaege \
		bei Taktik heute: $[++fs_tak_z]

/def -p2 -q -mglob -ag -t'Du stolperst! Die Landung klappt nicht so richtig, \
	aber*' FehlschlagZaehler25 = \
	/if /!ismacro FehlschlagZaehler25b%; /then \
		/def -1 -p50 -q -mglob -ag -t'*faellst Du wenigstens nicht \
			hin!' FehlschlagZaehler25b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Fehlschlaege bei Kampfsprung heute: \
				$$[++fs_ksp_z]%;\
	/endif

/def -p1 -q -msimple -ag -t'Dir gelingt es nicht, Deine Schmerzen zu \
	ueberwinden.' FehlschlagZaehler26 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Fehlschlaege \
		bei Schmerz heute: $[++fs_schm_z]

/def -p1 -q -msimple -ag -t'Du schaffst es nicht, schneller zu kaempfen.' \
	FehlschlagZaehler27 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Fehlschlaege \
		bei Schnellkampf heute: $[++fs_sk_z]

/def -p1 -q -msimple -ag -t'Die Parade ging leider voellig daneben.' \
	FehlschlagZaehler28 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Fehlschlaege \
		bei Parade heute: $[++fs_par_z]

/def -p1 -q -msimple -ag -t'Die Schildparade ging leider voellig daneben.' \
	FehlschlagZaehler29 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Fehlschlaege \
		bei Schildparade heute: $[++fs_spar_z]

/def -p1 -q -msimple -ag -t'Dir gelingen die komplizierten Bewegungen dieser \
	Kampftechnik einfach nicht.' FehlschlagZaehler30 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Fehlschlaege \
		bei Schlangentaktik heute: $[++fs_sna_z]

/def -p1 -q -msimple -ag -t'Der Fokus will einfach nicht gelingen.' \
	FehlschlagZaehler31 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Fehlschlaege \
		bei Fokus heute: $[++fs_fo_z]


;;; Patzer

/def -p2 -q -msimple -ag -t'Du schlaegst Dir mit dem Ellbogen den Schaedel \
	ein!  Wie immer dies auch' FehlschlagZaehler32 = \
	/if /!ismacro FehlschlagZaehler32b%; /then \
		/def -1 -p50 -q -msimple -ag -t'gehen soll :)' \
			FehlschlagZaehler32b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Fehlschlaege bei Ellbogenschlag heute: \
				$$[++fs_ellbogen_z] (Patzer!)%;\
	/endif

/def -p2 -q -msimple -ag -t'Du versuchst schneller zu kaempfen, haust Dir \
	dabei aber nur die' FehlschlagZaehler34 = \
	/if /!ismacro FehlschlagZaehler34b%; /then \
		/def -1 -p50 -q -msimple -ag -t'Waffe gegen das Bein!' \
			FehlschlagZaehler34b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Fehlschlaege bei Schnellkampf heute: \
				$$[++fs_sk_z] (Patzer!)%;\
	/endif

/def -p2 -q -msimple -ag -t'Du kommst ins Gruebeln: Wie macht man nochmal \
	einen Kampftritt?' FehlschlagZaehler35a

/def -p2 -q -mglob -ag -t'Hatte es irgendwas mit den Beinen zu tun? Um dieses \
	zu klaeren, legst *' FehlschlagZaehler35b = \
	/if /!ismacro FehlschlagZaehler35c%; /then \
		/def -1 -p50 -q -mglob -ag -t'*kurze Kampfpause ein.' \
			FehlschlagZaehler35c = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Fehlschlaege bei Kampftritt heute: \
				$$[++fs_kt_z] (Patzer mit Paralyse!)%;\
	/endif

/def -p2 -q -mglob -ag -t'Du blockierst Dir nur selber die Waffe! Wie kann \
	man sich *' FehlschlagZaehler36 = \
	/if /!ismacro FehlschlagZaehler36b%; /then \
		/def -1 -p50 -q -mglob -ag -t'*anstellen?' \
			FehlschlagZaehler36b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Fehlschlaege bei Block heute: \
				$$[++fs_bl_z] (Patzer - eigene Waffe \
				blockiert!)%;\
	/endif

/def -p2 -q -mglob -ag -t'Dir gelingt es ueberhaupt nicht, eine Taktik zu \
	waehlen. Du*' FehlschlagZaehler37 = \
	/if /!ismacro FehlschlagZaehler37b%; /then \
		/def -1 -p50 -q -mglob -ag -t'*nur Deinen Geist!' \
			FehlschlagZaehler37b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Fehlschlaege bei Taktik heute: \
				$$[++fs_tak_z] (Patzer mit Paralyse!)%;\
	/endif

/def -p2 -q -msimple -ag -t'Du steigerst Dich zwar nicht in Raserei, aber Du \
	fuehlst ploetzlich' FehlschlagZaehler38 = \
	/if /!ismacro FehlschlagZaehler38b%; /then \
		/def -1 -p50 -q -msimple -ag -t'UNGLAUBLICH mutig und laesst \
			alle Vorsicht fahren.' FehlschlagZaehler38b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Fehlschlaege bei Raserei heute: \
				$$[++fs_ras_z] (Patzer - VORSICHT NULL!)%;\
	/endif

/def -p2 -q -msimple -ag -t'Der Versuch, Deine Schmerzen zu ueberwinden, \
	misslingt voellig. Du' FehlschlagZaehler39 = \
	/if /!ismacro FehlschlagZaehler39b%; /then \
		/def -1 -p50 -q -msimple -ag -t'bist kurzeitig wie gelaehmt.' \
			FehlschlagZaehler39b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Fehlschlaege bei Schmerz heute: \
				$$[++fs_schm_z] (Patzer mit Paralyse!)%;\
	/endif

/def -p2 -q -msimple -ag -t'Du versuchst schneller zu kaempfen und verlierst \
    im Eifer des' FehlschlagZaehler40 = \
	/if /!ismacro FehlschlagZaehler40b%; /then \
		/def -1 -p50 -q -msimple -ag -t'Gefechts Deine Waffe!' \
			FehlschlagZaehler40b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Fehlschlaege bei Schnellkampf heute: \
				$$[++fs_sk_z] (Patzer - Waffe hingefallen!)%;\
	/endif

/def -p2 -q -mglob -ag -t'Du verknotest nur Deine Arme beim Versuch, eine \
	Finte gegen *' FehlschlagZaehler41 = \
	/if /!ismacro FehlschlagZaehler41b%; /then \
		/def -1 -p50 -q -mglob -ag -t'*machen.' \
			FehlschlagZaehler41b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Fehlschlaege bei Finte heute: \
				$$[++fs_fi_z] (Patzer!)%;\
	/endif

/def -p2 -q -msimple -ag -t'Oh oh! Du machst eine falsche Bewegung und spuerst \
	ploetzlich ein heftiges' FehlschlagZaehler42 = \
	/if /!ismacro FehlschlagZaehler42b%; /then \
		/def -1 -p50 -q -msimple -ag -t'Ziehen in der Schulter. Das \
			tut ziemlich weh!' FehlschlagZaehler42b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Patzer ohne Zuordnung! Heute schon: \
				$$[++fs_pat_z] davon!%;\
	/endif

/def -p1 -q -mglob -ag -t'Du haust Dir * {gegen|auf} den Kopf!' \
	FehlschlagZaehler43 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Patzer ohne \
		Zuordnung! Heute schon: $[++fs_pat_z] davon!

/def -p2 -q -msimple -ag -t'Oh Oh! Statt Deine Kampfbeeintraechtigung los zu \
	werden, erzielst' FehlschlagZaehler44 = \
	/if /!ismacro FehlschlagZaehler44b%; /then \
		/def -1 -p50 -q -msimple -ag -t'Du genau das Gegenteil! Du \
			stehst wie paralysiert da!' FehlschlagZaehler44b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Fehlschlaege bei Kampfwille heute: \
				$$[++fs_kw_z] (Patzer mit Paralyse!)%;\
	/endif

/def -p2 -q -mglob -ag -t'Der Schildstoss ging voellig daneben! Du haust Dir \
	*' FehlschlagZaehler45 = \
	/if /!ismacro FehlschlagZaehler45b%; /then \
		/def -1 -p50 -q -mglob -ag -t'*Aua!' FehlschlagZaehler45b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Fehlschlaege bei Schildstoss heute: \
				$$[++fs_schst_z] (Patzer!)%;\
	/endif

/def -p1 -q -msimple -ag -t'Statt Dich in Raserei zu versetzen, fliehst Du \
	feige!' FehlschlagZaehler46 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Fehlschlaege \
		bei Raserei heute: $[++fs_ras_z] (Patzer - Flucht!)

/def -p1 -q -mglob -ag -t'Du rammst Dir Dein Knie gegen {die|Deine} Nase! \
	Aua!' FehlschlagZaehler47 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Patzer ohne \
		Zuordnung! Heute schon: $[++fs_pat_z] davon!

/def -p2 -q -mglob -ag -t'Du verknotest nur Deine Arme beim Versuch, einen \
	Waffentrick gegen *' FehlschlagZaehler48 = \
	/if /!ismacro FehlschlagZaehler48b%; /then \
		/def -1 -p50 -q -mglob -ag -t'*zu machen.' \
			FehlschlagZaehler48b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Fehlschlaege bei Waffentrick heute: \
				$$[++fs_wt_z] (Patzer!)%;\
	/endif

/def -p2 -q -msimple -ag -t'Du stellst Dich beim Versuch, die Kampftechnik zu \
	wechseln, so' FehlschlagZaehler49 = \
	/if /!ismacro FehlschlagZaehler49b%; /then \
		/def -1 -p50 -q -msimple -ag -t'ungeschickt an, dass Du Dir \
			Dein Knie in den Magen rammst.' FehlschlagZaehler49b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Patzer ohne Zuordnung! Heute schon: \
				$$[++fs_pat_z] davon!%;\
	/endif

/def -p2 -q -msimple -ag -t'Wieso rammst Du Dir gerade jetzt das Knie gegens \
	Kinn? Das macht doch' FehlschlagZaehler50 = \
	/if /!ismacro FehlschlagZaehler50b%; /then \
		/def -1 -p50 -q -msimple -ag -t'ueberhaupt keinen Sinn!' \
			FehlschlagZaehler50b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Patzer ohne Zuordnung! Heute schon: \
				$$[++fs_pat_z] davon!%;\
	/endif

/def -p1 -q -msimple -ag -t'Der Fokus misslingt voellig. Du bist kurzzeitig \
    wie gelaehmt.' FehlschlagZaehler51 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Fehlschlaege \
		bei Fokus heute: $[++fs_fo_z] (Patzer mit Paralyse!)

/def -p2 -q -mglob -ag -t'Du stellst Dich beim Schaerfen *' \
	FehlschlagZaehler52 = \
	/if /!ismacro FehlschlagZaehler52b%; /then \
		/def -1 -p50 -q -mglob -ag -t'*quetschst. Aua!' \
			FehlschlagZaehler52b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Fehlschlaege bei Waffenschaerfen heute: \
				$$[++fs_was_z] (Patzer!)%;\
	/endif

/def -p2 -q -msimple -ag -t'Oh weia! Du wolltest mal wieder besonders cool \
    sein und eine gewagte Finte' FehlschlagZaehler53 = \
	/if /!ismacro FehlschlagZaehler53b%; /then \
		/def -1 -p50 -q -msimple -ag -t'machen, doch alles was Du \
			erreichst, ist, dass Deine Waffe im hohen Bogen' \
			FehlschlagZaehler53b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Fehlschlaege bei Finte heute: \
				$$[++fs_fi_z] (Patzer! Waffe hingefallen!)%;\
		/def -1 -p50 -q -msimple -ag -t'durch die Luft fliegt. Klasse \
			gemacht!' FehlschlagZaehler53c%;\
	/endif

/def -p2 -q -mglob -ag -t'Du versuchst ziemlich ungeschickt * zu \
	unterlaufen*' FehlschlagZaehler54 = \
	/if /!ismacro FehlschlagZaehler54b%; /then \
		/def -1 -p50 -q -mglob -ag -t'*dabei.' FehlschlagZaehler54b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Fehlschlaege bei Unterlaufen heute: \
				$$[++fs_un_z] (Patzer!)%;\
	/endif

/def -p2 -q -mglob -ag -t'Argl! Du machst eine weitausholende Bewegung, um \
	die Waffe *' FehlschlagZaehler55 = \
	/if /!ismacro FehlschlagZaehler55b%; /then \
		/def -1 -p50 -q -mglob -ag -t'*zu beschaedigen, doch dabei \
			stellst Du Dich*' FehlschlagZaehler55b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Fehlschlaege bei Waffenbruch heute: \
				$$[++fs_wb_z] (Patzer! Waffe hingefallen!)%;\
		/def -1 -p50 -q -mglob -ag -t'*Hand gleitet.' \
			FehlschlagZaehler55c%;\
	/endif

/def -p2 -q -mglob -ag -t'Oh weia! Bei dem Versuch die Waffe *' \
	FehlschlagZaehler56 = \
	/if /!ismacro FehlschlagZaehler56b%; /then \
		/def -1 -p50 -q -mglob -ag -t'*Deine eigene Waffe \
			genau auf die Nase!' FehlschlagZaehler56b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Fehlschlaege bei Waffenbruch heute: \
				$$[++fs_wb_z] (Patzer!)%;\
	/endif

/def -p2 -q -msimple -ag -t'Mist! Jetzt hast Du Dir doch tatsaechlich einen \
	Fingernagel abgebrochen! Aua!' FehlschlagZaehler57 = \
	/if /!ismacro FehlschlagZaehler57b%; /then \
		/def -1 -p50 -q -msimple -ag -t'Das tut wirklich weh!' \
			FehlschlagZaehler57b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Patzer ohne Zuordnung! Heute schon: \
				$$[++fs_pat_z] davon!%;\
	/endif

/def -p2 -q -msimple -ag -t'Du bist mal wieder viel zu unbeherrscht und \
	schneidest Dir im Eifer des' FehlschlagZaehler58 = \
	/if /!ismacro FehlschlagZaehler58b%; /then \
		/def -1 -p50 -q -msimple -ag -t'Gefechts ein paar \
			Haarbueschel ab!' FehlschlagZaehler58b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Patzer ohne Zuordnung! Heute schon: \
				$$[++fs_pat_z] davon!%;\
	/endif

/def -p1 -q -mglob -ag -t'Oh weh! Du triffst Dich mit * selber und verletzt \
	Dich etwas!' FehlschlagZaehler59 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Patzer ohne \
		Zuordnung! Heute schon: $[++fs_pat_z] davon!

/def -p2 -q -msimple -ag -t'Deine Haende scheinen urploetzlich zu ermueden! Du \
	kaempfst irgendwie viel' FehlschlagZaehler60 = \
	/if /!ismacro FehlschlagZaehler60b%; /then \
		/def -1 -p50 -q -msimple -ag -t'langsamer!' \
			FehlschlagZaehler60b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Patzer ohne Zuordnung! Heute schon: \
				$$[++fs_pat_z] davon! (Langsameres Kaempfen!)%;\
	/endif

/def -p2 -q -mglob -ag -t'Du versuchst * Rueckendeckung zu geben, doch dies \
	gelingt*' FehlschlagZaehler61 = \
	/if /!ismacro FehlschlagZaehler61b%; /then \
		/def -1 -p50 -q -mglob -ag -t'*Dich so ungeschickt an, dass \
			Du*' FehlschlagZaehler61b%;\
	/endif%;\
	/if /!ismacro FehlschlagZaehler61c%; /then \
		/def -1 -p51 -F -q -mglob -ag -t'*hinfaellst.' \
			FehlschlagZaehler61c = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Fehlschlaege bei Rueckendeckung heute: \
				$$[++fs_rd_z] (Patzer!)%;\
	/endif

/def -p2 -q -msimple -ag -t'Im Eifer des Gefechts faellt Dir einfach so Deine \
	Waffe aus der Hand. Dumm' FehlschlagZaehler62 = \
	/if /!ismacro FehlschlagZaehler62b%; /then \
		/def -1 -p50 -q -msimple -ag -t'gelaufen!' \
			FehlschlagZaehler62b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Patzer ohne Zuordnung! Heute schon: \
				$$[++fs_pat_z] davon! (Waffe hingefallen!)%;\
	/endif

/def -p2 -q -msimple -ag -t'Du bist ploetzlich sehr verwirrt! Was wolltest Du \
	nochmal gerade machen? Warum' FehlschlagZaehler63 = \
	/if /!ismacro FehlschlagZaehler63b%; /then \
		/def -1 -p50 -q -msimple -ag -t'geht das im Kampf aber auch \
			immer so schnell?' FehlschlagZaehler63b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Patzer ohne Zuordnung! Heute schon: \
				$$[++fs_pat_z] davon!%;\
	/endif

/def -p1 -q -msimple -ag -t'Dir faellt ueberhaupt nichts ein! Du bekommst \
	grosse Angst!' FehlschlagZaehler64 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Fehlschlaege \
		bei Beschimpfen heute: $[++fs_bs_z] (Patzer!)%;\
	/purge FehlschlagZaehler64b%;\
	/def -p2 -1 -q -msimple -ag -t'Hoppla, Du stolperst und taumelst \
		durch die Gegend.' FehlschlagZaehler64b = \
		/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Du \
			taumelst durch die Gegend!%%;\
		/set fs_taumeln_zeit $[time()]

/def -p1 -q -msimple -ag -t'Du haust Dich selber KO!' FehlschlagZaehler65 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Fehlschlaege \
		bei KO-Schlag heute: $[++fs_ko_z] (Selbst KO gehauen!)

/def -p2 -q -mglob -ag -t'Du stolperst, als Du den Todesstoss gegen *' \
	FehlschlagZaehler66 = \
	/if /!ismacro FehlschlagZaehler66b%; /then \
		/def -1 -p50 -q -mglob -ag -t'*haust Dich selber!' \
			FehlschlagZaehler66b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Fehlschlaege bei Todesstoss heute: \
				$$[++fs_ts_z] (Patzer!)%;\
	/endif

/def -p1 -q -msimple -ag -t'A R G L !!! Du haust Dir fast selber den Schaedel \
	ein!!!' FehlschlagZaehler67 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Patzer ohne \
		Zuordnung! Heute schon: $[++fs_pat_z] davon!

/def -p2 -q -msimple -ag -t'Oh weia! Du haust Dich so dolle, dass Dir fuer \
	einige Sekunden schwarz vor' FehlschlagZaehler68 = \
	/if /!ismacro FehlschlagZaehler68b%; /then \
		/def -1 -p50 -q -msimple -ag -t'Augen wird. Wie gelaehmt \
			stehst Du da.' FehlschlagZaehler68b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Patzer ohne Zuordnung! Heute schon: \
				$$[++fs_pat_z] davon! (Paralyse!)%;\
	/endif

/def -p2 -q -msimple -ag -t'Du schlaegst Dir mit der Faust selber eins aufs \
	Auge und bist erstmal richtig' FehlschlagZaehler69 = \
	/if /!ismacro FehlschlagZaehler69b%; /then \
		/def -1 -p50 -q -msimple -ag -t'ausgeschaltet. Alles ist so \
			dunkel hier...' FehlschlagZaehler69b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Patzer ohne Zuordnung! Heute schon: \
				$$[++fs_pat_z] davon! (Paralyse!)%;\
	/endif

/def -p2 -q -msimple -ag -t'Du verdrehst Dir ungeschickter Weise Dein \
	Handgelenk und kannst nur noch' FehlschlagZaehler70 = \
	/if /!ismacro FehlschlagZaehler70b%; /then \
		/def -1 -p50 -q -msimple -ag -t'langsamer kaempfen.' \
			FehlschlagZaehler70b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Patzer ohne Zuordnung! Heute schon: \
				$$[++fs_pat_z] davon! (Langsameres Kaempfen!)%;\
	/endif

/def -p1 -q -msimple -ag -t'Du stolperst! Die Landung ging voll daneben! \
	Du fliegst tierisch auf die Fresse.' FehlschlagZaehler71 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Fehlschlaege \
		bei Kampfsprung heute: $[++fs_ksp_z]

/def -p2 -q -msimple -ag -t'Hilfe! Du rutschst aus und machst einen sauberen \
	Spagat! Das zieht ganz' FehlschlagZaehler72 = \
	/if /!ismacro FehlschlagZaehler72b%; /then \
		/def -1 -p50 -q -msimple -ag -t'schoen...' \
			FehlschlagZaehler72b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Patzer ohne Zuordnung! Heute schon: \
				$$[++fs_pat_z] davon!%;\
	/endif

/def -p2 -q -mglob -ag -t'Du schleifst an * herum, doch leider stellst *' \
	FehlschlagZaehler73 = \
	/if /!ismacro FehlschlagZaehler73b%; /then \
		/def -1 -p50 -q -mglob -ag -t'* Klinge beschaedigst!' \
			FehlschlagZaehler73b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Fehlschlaege bei Waffenschaerfen heute: \
				$$[++fs_was_z] (Patzer!)%;\
	/endif

/def -p2 -q -msimple -ag -t'Argl! Du stellst Dich so ungeschickt an, dass Du \
	den Schleifstein zerbrichst!' FehlschlagZaehler74 = \
	/if /!ismacro FehlschlagZaehler74b%; /then \
		/def -1 -p50 -q -msimple -ag -t'Einfach unglaublich!' \
			FehlschlagZaehler74b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Fehlschlaege bei Waffenschaerfen heute: \
				$$[++fs_was_z] (Schleifstein zerbrochen!)%;\
	/endif

/def -p2 -q -msimple -ag -t'Du wunderst Dich sehr, aber irgendwie hast Du es \
	geschafft, Dich' FehlschlagZaehler75 = \
	/if /!ismacro FehlschlagZaehler75b%; /then \
		/def -1 -p50 -q -msimple -ag -t'selbst zu treten!' \
			FehlschlagZaehler75b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Patzer ohne Zuordnung! Heute schon: \
				$$[++fs_pat_z] davon!%;\
	/endif

/def -p1 -q -msimple -ag -t'Oh weh! Du haust Dir selbst den Schaedel ein!' \
	FehlschlagZaehler76 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Patzer ohne \
		Zuordnung! Heute schon: $[++fs_pat_z] davon!

/def -p2 -q -mglob -ag -t'Du stolperst ueber Deine eigenen Fuesse und \
	legst *' FehlschlagZaehler77 = \
	/if /!ismacro FehlschlagZaehler77b%; /then \
		/def -1 -p50 -q -mglob -ag -t'*genauso schnell wieder \
			aufstehen.' FehlschlagZaehler77b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Patzer ohne Zuordnung! Heute schon: \
				$$[++fs_pat_z] davon!%;\
	/endif

/def -p2 -q -msimple -ag -t'Wie auch immer Du es geschafft hast, es ist \
	passiert! Du hast Dir eine Hand' FehlschlagZaehler78 = \
	/if /!ismacro FehlschlagZaehler78b%; /then \
		/def -1 -p50 -q -msimple -ag -t'abgeschnitten!!! Aua!!! Vor \
			Schmerzen laesst Du erstmal Deine Waffe fallen.' \
			FehlschlagZaehler78b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Patzer ohne Zuordnung! Heute schon: \
				$$[++fs_pat_z] davon! (Hand ab!)%;\
	/endif

/def -p1 -q -msimple -ag -t'Du stolperst! Dabei verlierst Du sehr unschicklich \
	Deine ganze Kleidung!' FehlschlagZaehler79 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Patzer ohne \
		Zuordnung! Heute schon: $[++fs_pat_z] davon! (Kleidung \
		verloren!)

/def -p2 -q -mglob -ag -t'So ein Mist! Bei dem Versuch, die Waffe *' \
	FehlschlagZaehler80 = \
	/if /!ismacro FehlschlagZaehler80b%; /then \
		/def -1 -p50 -q -mglob -ag -t'*zerbricht *' \
			FehlschlagZaehler80b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Fehlschlaege bei Waffenbruch heute: \
				$$[++fs_wb_z] (Patzer! Waffe zerbrochen!)%;\
	/endif

/def -p1 -q -msimple -ag -t'Du stellst Dich so ungeschickt an, dass Du Dich \
	fast selber umbringst!'  FehlschlagZaehler81a

/def -p2 -q -msimple -ag -t'Ausserdem laesst Du bei dieser voellig \
	laecherlichen Aktion auch noch *' FehlschlagZaehler81b = \
	/if /!ismacro FehlschlagZaehler81c%; /then \
		/def -1 -p50 -q -mglob -ag -t'*fallen!' \
			FehlschlagZaehler81c = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Patzer ohne Zuordnung! Heute schon: \
				$$[++fs_pat_z] davon! (Waffe hingefallen!)%;\
	/endif

/def -p2 -q -mglob -ag -t'Du schwingst * in hohem Bogen, laesst *' \
	FehlschlagZaehler82 = \
	/if /!ismacro FehlschlagZaehler82b%; /then \
		/def -1 -p50 -q -mglob -ag -t'{Es|Sie|Er} fliegt foermlich \
			davon.' FehlschlagZaehler82b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Patzer ohne Zuordnung! Heute schon: \
				$$[++fs_pat_z] davon! (Waffe im Nebenraum!)%;\
	/endif

/def -p1 -q -msimple -ag -t'Ne ne, wie kann man sich nur so dumm anstellen!' \
	 FehlschlagZaehler83 = \

/def -p1 -q -msimple -ag -t'Hoppla, Du stolperst und taumelst durch die \
	Gegend.' FehlschlagZaehler83b = \
	/if ((time() - fs_taumeln_zeit) > 6) \
		/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Patzer \
			ohne Zuordnung! Heute schon: $[++fs_pat_z] davon! \
			(Taumeln!)%;\
	/else \
		/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Du \
			taumelst schon wieder!%;\
	/endif%;\
	/set fs_taumeln_zeit $[time()]

/def -p1 -q -msimple -ag -t'Du bist sehr verwirrt.. was wolltest Du nochmal \
	gerade machen?' FehlschlagZaehler84 = \
	/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR Patzer ohne \
		Zuordnung! Heute schon: $[++fs_pat_z] davon! (Patzer mit \
		Paralyse!)

/def -p1 -q -msimple -ag -t'Du rutschst wirklich GANZ ungluecklich aus, \
	machst einige Verrenkungen und' FehlschlagZaehler85 = \
	/if /!ismacro FehlschlagZaehler85b%; /then \
		/def -1 -p50 -q -msimple -ag -t'stichst Dir dabei mit den \
			Fingern so ungluecklich in die Augen, dass Du' \
			FehlschlagZaehler85b%;\
	/endif%;\
	/if /!ismacro FehlschlagZaehler85c%; /then \
		/def -1 -p50 -q -msimple -ag -t'erblindest!!!' \
			FehlschlagZaehler85c = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Patzer ohne Zuordnung! Heute schon: \
				$$[++fs_pat_z] davon! (Erblindet!)%;\
	/endif

/def -p2 -q -msimple -ag -t'Du willst Dich in Raserei versetzen, doch Du \
	bekommst es mit der Angst zu' FehlschlagZaehler86 = \
	/if /!ismacro FehlschlagZaehler86b%; /then \
		/def -1 -p50 -q -msimple -ag -t'tun und stehst wie \
			paralysiert da!' FehlschlagZaehler86b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Fehlschlaege bei Raserei heute: \
				$$[++fs_ras_z] (Patzer mit Paralyse!)%;\
	/endif

/def -p2 -q -mglob -ag -t'Mist! Bei dem Versuch die Waffe *' \
	FehlschlagZaehler87 = \
	/if /!ismacro FehlschlagZaehler87b%; /then \
		/def -1 -p50 -q -mglob -ag -t'*beschaedigst Du nur*' \
			FehlschlagZaehler87b = \
			/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_FEHLSCHLAG_ATTR \
				Fehlschlaege bei Waffenbruch heute: \
				$$[++fs_wb_z] (Patzer! Waffe beschaedigt!)%;\
	/endif


;;; Wieviel hab ich heute wieder geuebt?

/def fehlschlaege = \
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Fehlschlaege heute:%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR ========================================================%;\
/echo%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Besondere Angriffe:%;\
/echo%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Fehlschlaege bei Kampftritt heute......: %fs_kt_z%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Fehlschlaege bei Kniestoss heute.......: %fs_kniest_z%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Fehlschlaege bei Ellbogenschlag heute..: %fs_ellbogen_z%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Fehlschlaege bei Kopfstoss heute.......: %fs_kopfst_z%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Fehlschlaege bei Schildstoss heute.....: %fs_schst_z%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Fehlschlaege bei Waffenwurf heute......: %fs_ww_z%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Fehlschlaege bei Waffenschlag heute....: %fs_ws_z%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Fehlschlaege bei Todesstoss heute......: %fs_ts_z%;\
/echo%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Besondere Waffen- und Schildtechniken:%;\
/echo %;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Fehlschlaege bei Schildparade heute....: %fs_spar_z%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Fehlschlaege bei Parade heute..........: %fs_par_z%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Fehlschlaege bei Finte heute...........: %fs_fi_z%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Fehlschlaege bei Waffentrick heute.....: %fs_wt_z%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Fehlschlaege bei Block heute...........: %fs_bl_z%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Fehlschlaege bei KO-Schlag heute.......: %fs_ko_z%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Fehlschlaege bei Waffenbruch heute.....: %fs_wb_z%;\
/echo%;\
 /echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Besondere Kampftaktiken und Techniken:%;\
/echo %;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Fehlschlaege bei Fokus heute...........: %fs_fo_z%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Fehlschlaege bei Taktik heute..........: %fs_tak_z%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Fehlschlaege bei Beschimpfen heute.....: %fs_bs_z%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Fehlschlaege bei Raserei heute.........: %fs_ras_z%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Fehlschlaege bei Schnellkampf heute....: %fs_sk_z%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Fehlschlaege bei Unterlaufen heute.....: %fs_un_z%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Fehlschlaege bei Schildkroete heute....: %fs_sch_z%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Fehlschlaege bei Drache heute..........: %fs_dra_z%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Fehlschlaege bei Schlangentaktik heute.: %fs_sna_z%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Fehlschlaege bei Rueckendeckung heute..: %fs_rd_z%;\
/echo%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Sonstiges:%;\
/echo%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Fehlschlaege bei Schaetzen heute.......: %fs_stz_z%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Fehlschlaege bei Identifizieren heute..: %fs_ident_z%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Fehlschlaege bei Schmerz heute.........: %fs_schm_z%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Fehlschlaege bei Waffenschaerfen heute.: %fs_was_z%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Fehlschlaege bei Kampfwille heute......: %fs_kw_z%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Fehlschlaege bei Kampfsprung heute.....: %fs_ksp_z%;\
/echo %;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Nicht zugeordnete Patzer...............: %fs_pat_z%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR ========================================================%;\
/echo -a%CFG_MG_KAEMPFER_FEHLSCHLAEGE_STATUS_ATTR Gesamtzahl Fehlschlaege heute: $[fs_kopfst_z+fs_wt_z+fs_ellbogen_z+fs_wb_z+fs_rd_z+fs_ko_z+fs_bl_z+fs_stz_z+fs_dra_z+fs_ww_z+fs_kniest_z+fs_fi_z+fs_ts_z+fs_ras_z+fs_ws_z+fs_kw_z+fs_kt_z+fs_un_z+fs_was_z+fs_bs_z+fs_schst_z+fs_sch_z+fs_ident_z+fs_tak_z+fs_ksp_z+fs_schm_z+fs_sk_z+fs_par_z+fs_spar_z+fs_sna_z+fs_fo_z+fs_pat_z]
