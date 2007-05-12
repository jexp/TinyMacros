; $Log: tanjian.tf,v $
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
 
/set tanjian_tf_version $Id: tanjian.tf,v 1.6 2002/10/07 05:44:18 thufhnik Exp $
/set tanjian_tf_author=Thufhir@mg.mud.de
/set tanjian_tf_requires=
/set tanjian_tf_desc=Loader der Tanjiangilde

/mload -c -dtanjian status_tanjian.tf

/if (p_sub_guild =~ 'kagekitsune') \
	/mload -c -dtanjian tanjian_kagekitsune.tf%;\
/elseif (p_sub_guild =~ 'okami') \
	/mload -c -dtanjian tanjian_okami.tf%;\
/elseif (p_sub_guild =~ 'nekekami') \
	/mload -c -dtanjian tanjian_nekekami.tf%;\
/endif

/remove_from_hook points /echo_hit_points

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

