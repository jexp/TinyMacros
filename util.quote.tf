; $Log: util.quote.tf,v $
; Revision 1.7  2003/10/29 23:31:04  nieten
; Wiederherstellung der Tab-Belegung in /quote_multiline verbessert
;
; Revision 1.6  2003/10/21 20:00:50  nieten
; - Hook quote_multiline fuer mehrzeilige Makros per Copy&Paste
; - Doku ueberarbeitet/geschrieben
;
; Revision 1.5  2001/09/09 19:09:42  mh14
; help_de.list
;
; Revision 1.4  2001/09/06 21:11:44  mh14
;  Log eingefuegt
;

/set util_quote_tf_version $Id$
/set util_quote_tf_author=Mesirii@mg.mud.de
/set util_quote_tf_requires=util.trigger.tf util.echo.tf
/set util_quote_tf_desc Pasten in tf Fenster, Quoten von Mud-Ausgaben ans Mud


/set_var quote_multiline_start :

/addh info \
Erlaubt es, mehrzeiligen Text mit Zeilenumbruechen ins tf zu pasten, so dass \
jede Zeile mit dem Praefix ans Mud gesendet wird. Beenden mit ESC-q.
/addh en info \
With /my_quote you can paste several lines into the tf window and send them \
line by line with a prefix to the mud. Quit with ESP-q.
/addh ex \
/my_quote sage <Enter druecken>, dann Text pasten und mit Escape-q beenden
/addh en ex \
/my_quote say <ENTER>, paste text and quit with ESC-q.
/addh syn /my_quote [<prefix>] (ESC-q)
/addh see /spare_linefeeds, /quote_multiline
/addh my_quote comm

/defh my_quote = \
    /def -b"^j" b_j = /dokey newline\%;/input %* :\%;/dokey BSPC%;\
    /def -b"^m" b_m = /dokey newline\%;/input %* :\%;/dokey BSPC%;\
    /def -b"^[q" b_esc_q = \
    /def -b"^j" -i b_j = /dokey newline\%;\
    /def -b"^m" -i b_m = /dokey newline\%;/undef b_esc_q\%;/dokey DLINE%;\
    /input %* :%;\
    /dokey BSPC


/addh info \
Erlaubt es, mehrzeiligen Text mit Zeilenumbruechen ins tf zu pasten, ohne dass die Zeilenumbrueche als Returns gewertet werden, und diesen Text insgesamt mit einem Prefix versehen ans Mud zu schicken bzw. ihn im TF zu verwenden. Die Zeilenumbrueche werden mit einem SPACE ersetzt.@{N}\
Bei mehrzeiligen TF-Makros funktioniert das Ganze nicht, da '\' am Zeilenende \
und Leerzeichen am Zeilenanfang nicht so beruecksichtig werden, wie das \
eigentlich erwarten wuerde. Stattdessen den Hook ?/quote_multiline verwenden.
/addh en info \
With /spare_linefeeds you can concatenate several lines together (return key \
is temporarily changed to space) and send them with a prefix as one line to \
the mud.@{N}\
Don't use it to paste tf-macros from a file, since trailing '\' and leadind \
blanks are not erased. Use ?/quote_multiline for this purpose.
/addh ex \
/spare_linefeeds sage <Enter druecken>, dann Text pasten und mit \
Escape-q beenden
/addh en ex \
/spare_linefeeds say <ENTER>, paste text and quit with ESC-q.
/addh syn /spare_linefeeds [<prefix>] (ESC-q)
/addh see /my_quote, /quote_multiline
/addh spare_linefeeds comm

/defh spare_linefeeds = \
    /def -b"^j" b_j = /test input(" ")%;\
    /def -b"^m" b_m = /test input(" ")%;\
    /def -b"^[q" b_esc_q = \
        /def -b"^j" -i b_j = /dokey newline\%;\
	/def -b"^m" -i b_m = /dokey newline\%;/undef b_esc_q\%;/dokey newline%;\
    /input %* :%;\
    /dokey BSPC %;


/addh info \
Schickt die Ausgabe des angegeben Mud-Kommandos mit dem angegebenen \
Praefix wieder ans Mud.
/addh en info \
Sends the output of a give mud command with a given prefix back to the mud.
/addh syn /mud_quote <Praefix> '<Mud-Befehl>
/addh en syn /mud_quote <prefix> '<mud command>
/addh ex /mud_quote sage 'inventar@{N}\
Der erste Parameter ist das Prefixkommando, und das nach dem ' das Kommando, \
dessen Ausgabe genutzt werden soll.
/addh en ex /mud_quote say 'inv@{N}\
would tell anybody the output of the command 'inv'.
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


/addh info \
Dieser Hook ermoeglicht auch mehrzeilige Makros (vor allem wohl /def) mittels \
Cut&Paste in einem laufenden TF. Dazu muss die erste Zeile mit ":/" \
anfangen und mit "\" aufhoeren. Danach werden diese und alle weiteren Zeilen \
solange in einem Puffer aneinandergehaengt, bis eine Zeile nicht mehr mit \
"\" aufhoert. Anschliessend wird der im Puffer stehende Code ausgefuehrt.@{N}\
Das Verfahren sieht dann in den meisten Faellen so aus:@{N}\
- Makrodefinition (mit Maus) markieren@{N}\
- Ins TF-Fenster wechseln.@{N}\
- ':' tippen, dann pasten (ueblicherweise mittlere Maustaste)@{N}\
Anmerkung: Beginnt eine Folgezeile mit "/", so wird sie als TF-Makro \
aufgefasst und direkt ausgefuehrt; sie landet also nicht im \
Zwischenpuffer.@{N}\
Wer fuer den Beginn eines mehrzeiligen Makros ein anderes Zeichen als ':' \
bevorzugt, kann dies vor dem Laden von 'util.quote.tf' (ggf. neu laden) in \
%quote_multiline_start schreiben.
/addh en info \
This hook allows you to define multiline macros (especially macro \
definitions) by copy&paste. To do this, the first line of the macro must \
begin with ":/" and end with "\". This line (without the ":", of course) \
and all following lines are concatenated and writte into a buffer. A line \
without trailing "\" stops this process, and the buffer is evaluated.@{N}\
In most cases you probably do this:@{N}\
- Mark a macro with the mouse.@{N}\
- Focus on the tf window.@{N}\
- Press ':' and paste the marked text (using middle mouse button).@{N}\
Remark: Lines beginning with "/" are considered a tf-macro and executed \
immediately; they ared not stored in the buffer. (So use indentation.)@{N}\
If you don't want to denote the beginning of a multiline macro with ':' you \
can chane %quote_multiline_start. This must be done before loading \
'util.quote.tf' or you have to reload it.
/addh var %quote_multiline_start
/addh quote_multiline hook

; Ermoeglicht das Pasten von mehrzeiligen Makros direkt in die Kommandozeile
; von TF. Dazu muss die erste Zeile mit ":/" beginnen. Alle weiteren Zeilen,
; die mit '\' aufhoeren, werden als zum Makro gehoerig betrachtet. Dieses
; wird erst dann ausgefuehrt, sobald eine Zeile nicht mit '\' abgeschlossen
; wird.
; (Zeilen, die mit '/' beginnen, werden als TF-Makros aufgefasst und sofort
; ausgefuehrt.).
/def -p5 -mglob -h"SEND :/*\\\\" quote_multiline = \
; We don't want any substitution, so we use /test set().
    /test set(strcat("multiline_buffer=", multiline_buffer, \
	substr({*},1,-1)))%;\
; For now we must change tabs to spaces.
; Save old keybinding of tab-key (if any).
    /let tmp=$(/list -s -ib'^i')%;\
    /if (tmp !~ "") \
	/let tmp=$[substr($(/nth 2 %tmp), 0, -1)]%;\
        /edit -b #%tmp%;\
        /let tmp=%?%;\
    /endif%;\
    /def -b^i k_multiline_tab_to_spaces = \
	/test grab("        ")%;\
; Catch following lines.
    /def -p10 -hSEND quote_multiline1 = \
	/if (substr({*},-1) =~ "\\\\") \
	    /test set(strcat("multiline_buffer=", multiline_buffer, \
	        substr({*},0,-1)))%%;\
	/else \
; Last line: Evaluate buffer
	    /test set(strcat("multiline_buffer=", multiline_buffer, {*}))%%;\
	    /eval -s0 %%multiline_buffer%%;\
	    /unset multiline_buffer%%;\
	    /purge k_multiline_tab_to_spaces%%;\
; Restore old keybinding.
	    /if ("%tmp" !~ "") \
		/edit -b^i #%tmp%%;\
	    /endif%%;\
	    /purge quote_multiline1%%;\
	/endif
/test edit(strcat('-h"SEND ', quote_multiline_start, '/*\\\\\\\\" \
    quote_multiline'))


/addh info \
Makros und Hooks zur Unterstuetzung von Copy&Paste.
/addh en info \
Macros and hooks for copy&paste.
/addh comm /my_quote, /mud_quote, /spare_linefeeds
/addh hook /quote_multiline
/addh var %quote_multiline_start
/addh_fileinfo
