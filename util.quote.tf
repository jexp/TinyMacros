; $Log: util.quote.tf,v $
; Revision 1.5  2001/09/09 19:09:42  mh14
; help_de.list
;
; Revision 1.4  2001/09/06 21:11:44  mh14
;  Log eingefuegt
;

/set util_quote_tf_version $Id: util.quote.tf,v 1.5 2001/09/09 19:09:42 mh14 Exp $
/set util_quote_tf_author=Mesirii@mg.mud.de
/set util_quote_tf_requires=util.trigger.tf util.echo.tf
/set util_quote_tf_desc Pasten in tf Fenster, Quoten von Mud-Ausgaben ans Mud

/addh info \
Erlaubt es mehrzeilgen Text mit Zeilenumbruechen ins tf zu pasten, so dass jede Zeile mit dem Prefix ans Mud gesendet wird
/addh ex /my_quote sage <Enter druecken>, dann Text pasten und mit Escape-q beenden
/addh my_quote comm
/defh my_quote = \
	/def -b"^j" b_j = /dokey newline\%;/input %* :\%;/dokey BSPC%;\
	/def -b"^m" b_m = /dokey newline\%;/input %* :\%;/dokey BSPC%;\
	/def -b"^[q" b_esc_q = /def -b"^j" -i b_j = /dokey newline\%;/def -b"^m" -i b_m = /dokey newline\%;/undef b_esc_q\%;/dokey DLINE%;\
	/input %* :%;\
	/dokey BSPC %;

/addh info \
Erlaubt es, mehrzeiligen Text mit Zeilenumbruechen ins tf zu pasten, ohne dass die Zeilenumbrueche als Returns gewertet werden, und diesen Text insgesamt mit einem Prefix versehen ans Mud zu schicken bzw. ihn im TF zu verwenden. Die Zeilenumbrueche werden mit einem SPACE ersetzt.
/addh ex /spare_linefeeds sage <Enter druecken>, dann Text pasten und mit Escape-q beenden@{N}\
 oder /spare_linefeeds <Enter druecken> und dann eine /def pasten und mit Escape-q beenden
/addh spare_linefeeds comm

/defh spare_linefeeds = \
	/def -b"^j" b_j = /test input(" ")%;\
	/def -b"^m" b_m = /test input(" ")%;\
	/def -b"^[q" b_esc_q = /def -b"^j" -i b_j = /dokey newline\%;/def -b"^m" -i b_m = /dokey newline\%;/undef b_esc_q\%;/dokey newline%;\
	/input %* :%;\
	/dokey BSPC %;

/addh info \
Schickt die Ausgabe des angegeben Mud-Kommandos mit dem angegebenen Prefix wieder ans Mud.
/addh ex /mud_quote sage 'inventar@{N}\
Der erste Parameter ist das Prefixkommando, und das nach dem ' das Kommando, dessen Ausgabe genutzt werden soll.

/addh mud_quote comm
/defh mud_quote = \
	/set fulldetail=%;\
	/def_psave_trig%;\
	/def_psave3_trig%;\
	/let off=$[strchr({*},"'")]%;\
	/set nextmakro=/mud_quote2 $[substr({*},0,off)]%;\
	$[substr({*},off+1)]%;

/def mud_quote2 = \
	/quote -0 %* `/echo2 -p $[substr(fulldetail,4)]%;


/addh_fileinfo
