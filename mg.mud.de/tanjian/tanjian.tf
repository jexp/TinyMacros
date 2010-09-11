; $Log: tanjian.tf,v $
; Revision 1.7  2004/03/14 09:22:15  thufhnik
; Stufenkosten
;
; Revision 1.6  2002/10/07 05:44:18  thufhnik
; loeschen unnoetiger files
;
; Revision 1.5  2002/09/04 17:26:55  chbr
; Clan Nekekami
;
; Revision 1.4  2002/01/26 19:04:04  thufhnik
; Clan Okami
;
; Revision 1.3  2002/01/26 11:19:07  thufhnik
; Clanfile Kagekitsune nachladen
;
; Revision 1.2  2002/01/23 15:18:49  nieten
; Anfaelligkeiten/Resistenzen werden eingefaerbt
;
; Revision 1.1  2001/12/12 16:14:58  thufhnik
; Scratch
;

/set tanjian_tf_version $Id: tanjian.tf,v 1.7 2004/03/14 09:22:15 thufhnik Exp $
/set tanjian_tf_author=Thufhir@mg.mud.de
/set tanjian_tf_requires=
/set tanjian_tf_desc=Loader der Tanjiangilde

; Konfigurierbares

/set_var CFG_MG_STUFENKOSTEN 1
/set_var CFG_MG_STUFENKOSTEN_ECHO_ATTR Cyellow
/set_var CFG_MG_STUFENKOSTEN_ECHO_TEXT Du hast #1% der naechsten Stufe erreicht.

; Laden der Files

/mload -c -dtanjian status_tanjian.tf

/if (p_sub_guild =~ 'kagekitsune') \
	/mload -c -dtanjian tanjian_kagekitsune.tf%;\
/elseif (p_sub_guild =~ 'okami') \
	/mload -c -dtanjian tanjian_okami.tf%;\
/elseif (p_sub_guild =~ 'nekekami') \
	/mload -c -dtanjian tanjian_nekekami.tf%;\
/elseif (p_sub_guild =~ 'ryu') \
	/mload -c -dtanjian tanjian_ryu.tf%;\
/endif

; Stufenkosten

/ifdef CFG_MG_STUFENKOSTEN tanjian_kosten = \
        /echo -a%CFG_MG_STUFENKOSTEN_ECHO_ATTR -- \
                $[sprintf(CFG_MG_STUFENKOSTEN_ECHO_TEXT,{1})]

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -Fp99 -t'Jetzt schrei nicht \
	gleich nach Siamil. Du musst noch eine Menge leisten bis' \
	tanjian_kosten1 = \
	/def -agCblue -msimple -Fp99 -1 -t'zur naechsten Stufe!' \
		tanjian_kosten1a = /tanjian_kosten 0-19

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -Fp99 -t'Du hast noch ne Menge \
	zu tun bis zur naechsten Stufe. Sterb nicht so oft, aber' \
	tanjian_kosten2 = \
	/def -agCblue -msimple -Fp99 -1 -t'sowas tun Tanjian ja eh nicht!' \
		tanjian_kosten2a = /tanjian_kosten 20-39

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -Fp99 -t'Man kann den Wert \
	zwischen den beiden Stufen durchaus als ausgewogen' \
	tanjian_kosten3 = \
	/def -agCblue -msimple -Fp99 -1 -t'bezeichnen. Trotzdem hast Du noch \
		ein Stueck des Weges vor Dir!' tanjian_kosten3a = \
		/tanjian_kosten 40-59

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -Fp99 -t'Eine Quest hier, ein \
	paar Monster da. Aber immer schoen ausgeglichen bleiben,' \
	tanjian_kosten4 = \
	/def -agCblue -msimple -Fp99 -1 -t'dann klappts auch weiterhin!' \
		tanjian_kosten4a = /tanjian_kosten 60-79

/ifdef CFG_MG_STUFENKOSTEN -agCblue -msimple -Fp99 -t'Siamil wird stolz auf \
	Dich sein. Du hast Dich gegen Gut und Boese' \
	tanjian_kosten5 = \
	/def -agCblue -msimple -Fp99 -1 -t'durchgesetzt und das Ziel fast \
		erreicht!' tanjian_kosten5a = /tanjian_kosten 80-99

; gehoert eigentlich ins cfg, ist aber wohl schon tradition:

/remove_from_hook points /echo_hit_points

/mload -c -dtanjian koryoku.tf

;;; Anfaelligkeiten/Resistenzen bei Koryoku einfaerben

; (Trigger in der vierten Ebene sehen zwar pervers aus, aber dafuer
; sind so wenige Trigger wie moeglich gleichzeit aktiv (normalerweise
; nur einer).)
; Der Kram wird hoffentlich bald ueberfluessig. (Huhu, Patryn!)

/def -F -msimple -t"Du bereitest Dich mental auf 'koryoku' vor." \
    t_koryoku_col = \
; Fehlschlag
    /def -1 -F -msimple -t"Die Kraft der Erleuchtung bleibt aus." \
	t_koryoku_col1 = \
	/purge -mglob t_koryoku_col?%;\
; Fehlschlag
    /def -1 -F -msimple -t"Die Erleuchtung bleibt Dir versagt." \
	t_koryoku_col2 = \
	/purge -mglob t_koryoku_col?%;\
; guter Erfolg
   /def -1 -F -aCgreen -msimple -t"Das ist Dir offenbar so richtig gut \
       gelungen." t_koryoku_col3%;\
; Erfolg -> Faerbetrigger definieren
    /def -1 -F -mglob -t"Du konzentrierst Dich intensiv auf *" \
	t_koryoku_col4 = \
	/purge -mglob t_koryoku_col?%%;\
; Resistenzen
	/def -F -aCred -mregexp -t"^(Er|Sie|Es|Du) b?ist .*resistent gegen: " \
	    t_koryoku_col5 = \
	    /if (substr({L1},strlen({L1})-1) !~ ".") \
; Trigger in der 4. Ebene sehen pervers aus. :^)
		/def -F -aCred -mregexp -t"^[^:.]+(\\\\\\\\\\\\\\\\.)?$$$$" \
		    t_koryoku_col6 = \
		    /if ({P1} =~ ".") \
			/purge t_koryoku_col6%%%%;\
		    /endif%%%;\
	    /endif%%;\
; Anfaelligkeiten
	/def -F -aCgreen -mregexp -t"^(Er|Sie|Es|Du) b?ist .*anfaellig \
	    gegen: " t_koryoku_col7 = \
	    /purge -mglob t_koryoku_col[4-6]%%%;\
	    /if (substr({L1},strlen({L1})-1) !~ ".") \
		/def -F -aCgreen -mregexp -t"^[^:.]+(\\\\\\\\\\\\\\\\.)?$$$$" \
		    t_koryoku_col8 = \
		    /if ({P1} =~ ".") \
			/purge t_koryoku_col8%%%%;\
		    /endif%%%;\
	    /endif%%;\
; weder noch
	/def -F -aCyellow -msimple -t"Er hat weder besonders verwundbaren \
	    Stellen noch besondere Resistenzen." t_koryoku_col9%%;\
; Trigger wieder loeschen
	/repeat -2 1 /purge -mglob t_koryoku_col?

