; lpc.tf - Faerbetrigger fuer LPC-Code
;          Colorful lpc code

;
; $Log: lpc.tf,v $
; Revision 1.2  2003/10/21 12:07:54  nieten
; - /cat nach /ccat umbenannte
; - mit %lpc_mode kann das Einfaerbung von LPC-Code dauerhaft ein- oder
;   ausgeschaltet werden
;
; Revision 1.1  2003/10/09 12:13:14  nieten
; Startversion
;
;

/set lpc_tf_version $Id: lpc.tf,v 1.2 2003/10/21 12:07:54 nieten Exp $
/set lpc_tf_author Dotz@mg.mud.de
/set lpc_tf_requires=util.vfunc.tf(1.22) util.tf(1.18)
/set lpc_tf_desc=Faerbetrigger fuer LPC


/add info \
Farbe fuer Kommentare. Da die richtige Erkennung von geschachtelten \
Kommentaren nicht immer korrekt funktioniert, kann das Einfaerben von \
Kommentaren im Notfall abgestellt werden, indem man %lpc_comments auf 0 setzt.
/addh en info \
Color for comments. Since it is somewhat tricky to recognize nested comments \
correctly, colorizing comments can be turned off by setting %lpc_comments \
to 0.
/addh see %lpc_comments
/addh dtype color
/addh lpc_color_comment var

/addh info \
Ist die Variable auf 0 gesetzt, so werden Kommentare nicht mehr eingefaerbt. \
Durch Setzen auf 1 kann man das Einfaerben wieder einschalten.
/addh en info \
Turns colorizing of comments on (1) or off (0).
/addh dtype flag
/addh lpc_comments var

/add info \
Farbe fuer Strings. Da die richtige Erkennung von Strings nicht immer \
korrekt funktioniert, kann das Einfaerben von Strings im Notfall abgestellt \
werden, indem man %lpc_strings auf 0 setzt.
/addh en info \
Color for strings. Since it is somewhat tricky to recognize strings \
correctly, colorizing strings can be turned off by setting %lpc_strings to 0.
/addh see %lpc_strings
/addh dtype color
/addh lpc_color_string var

/addh info \
Ist die Variable auf 0 gesetzt, so werden Strings nicht mehr eingefaerbt. \
Durch Setzen auf 1 kann man das Einfaerben wieder einschalten.
/addh en info \
Turns colorizing of comments on (1) or off (0).
/addh dtype flag
/addh lpc_strings var

/add info \
Farbe fuer Variablentypen (int, string, ...).
/addh en info \
Color for types (int, string, ...)
/addh dtype color
/addh lpc_color_type var

/add info \
Farbe fuer Funktionen.
/addh en info \
Color for functions.
/addh dtype color
/addh lpc_color_function var

/add info \
Farbe fuer Praeprozessoranweisungen (#define, #pragma, ...).
/addh en info \
Color for preprocessor commands (#define, #pragma, ...).
/addh dtype color
/addh lpc_color_preprocessor var

/add info \
Farbe fuer die Modifikatoren private, public, protected, virtual, static \
und nomask.
/addh en info \
Color for the modifiers private, public, protected, virtual, static, nomask.
/addh dtype color
/addh lpc_color_modifier var

/add info \
Farbe fuer mit #define definierte Praeprozessorsymbole.
/addh en info \
Color for #define'd preprocessor symbols.
/addh dtype color
/addh lpc_color_symbol var

/add info \
Farbe fuer LPC-Schluesselwoerter (for, return, case, ...).
/addh en info \
Color for lpc keywords (for, return, case, ...).
/addh dtype color
/addh lpc_color_keyword var

/addh info \
Hier kann man einige Praeprozessorsymbole angeben, die immer in der Farbe \
?%lpc_color_symbol eingefaerbt werden sollen. Die einzelnen Symbole muessen \
durch "|" getrennt werden.
/addh en info \
Extra preprocessor symbols, that should appear in %lpc_color_symbol. \
Separated by "|".
/addh ex P_LONG|P_SHORT|P_INFO|QUESTMASTER
/addh dtype text
/addh lpc_known_symbols var

/addh info \
Gibt an, ob die LPC-Faerbetrigger staendig aktiv (1) sind oder nicht (0). \
Sollte aus Effizienzgruenden nicht staendig 1 sein.
/addh en info \
Permanently turns colorizing of lpc code on (1) or off (0).
/addh see lpc_prompt
/addh dtype flag
/addh lpc_mode var

/addh info \
Prompt-String vom Mud (inkl. Leerzeichen am Anfang und/oder Ende).
/addh en info \
Prompt string from mud (don't forget leading and/or trailing blanks).
/addh dtype string
/addh see /lpc_h_prompt
/addh lpc_prompt var

; Eintraege fuer /configure
/cfg_info gui lpc LPC
/cfg_info gui lpc KOMMENTAR Kommentar:lpc_color_comment
/cfg_info gui lpc STRING String:lpc_color_string
/cfg_info gui lpc TYPE Typ:lpc_color_type
/cfg_info gui lpc FUNCTION Funktion:lpc_color_function
/cfg_info gui lpc PREPROCESSOR Praeprozessor:lpc_color_preprocessor
/cfg_info gui lpc MODIFIER Modifier:lpc_color_modifier
/cfg_info gui lpc SYMBOL Symbol:lpc_color_symbol
/cfg_info gui lpc KEYWORD Schluesselwort:lpc_color_keyword

/set_var lpc_color_comment Cgreen
/set_var lpc_color_string Cyellow
/set_var lpc_color_type Cgreen
/set_var lpc_color_function Ccyan
/set_var lpc_color_preprocessor Cred
/set_var lpc_color_modifier Cblue
/set_var lpc_color_symbol Cmagenta
/set_var lpc_color_keyword Cmagenta

/cfg_info gui lpc MODE LPC-Modus_ein/aus:lpc_mode
/cfg_info gui lpc NOCOMMENT Kommentare_faerben:lpc_comments
/cfg_info gui lpc STRINGS Strings_faerben:lpc_strings
/cfg_info gui lpc PROMPT Prompt:lpc_prompt

/set_var lpc_mode 1
/set_var lpc_comments 1
/set_var lpc_strings 1
/if (lpc_prompt =~ "") \
    /set lpc_prompt=%;\
    /test lpc_prompt:="> "%;\
/endif


/cfg_info gui lpc KNOWN_SYMBOLS Bekannte_Symbole:lpc_known_symbols

/set_var lpc_known_symbols=
/eval /set lpc_symbols=%lpc_known_symbols
/set lpc_symbols1="(^|[^A-Za-z0-9_])(
/set lpc_symbols2=)($|[^A-Za-z0-9_])"


; Praeprozessor
/def -p5 -F -E(lpc_flag|lpc_mode) -mregexp -q  -t"^#(define |include |\
    ifn?(def)? |endif|else|elif |undef |pragma |echo )" lpc_t_preprocessor
/eval /edit -P1x%lpc_color_preprocessor lpc_t_preprocessor


; Praeprozessorsymbole
/def -p6 -F -E(lpc_flag|lpc_mode) -mregexp -q -t"^#define +([^ (]+)" \
    lpc_t_define = \
    /if (lpc_symbols =~ "") \
	/set lpc_symbols=%P1%;\
    /elseif (strstr(strcat("|",lpc_symbols,"|"), strcat("|",{P1},"|")) == -1) \
	/set lpc_symbols=$[strcat(lpc_symbols, "|", {P1})]%;\
    /else \
	/return%;\
    /endif%;\
    /purge lpc_t_symbol%;\
    /def -p5 -F -E(llpc_flag|pc_mode) -P2x%lpc_color_symbol -mregexp -q \
	-t$[strcat(lpc_symbols1, lpc_symbols, lpc_symbols2)] lpc_t_symbol%;\
;    /list lpc_t_symbol

/eval /edit -P1x%lpc_color_define lpc_t_define


; Kommentar
/def -p3 -F -E((lpc_flag|lpc_mode)&lpc_comments) -mregexp -q -t"//.*$" \
    lpc_t_comment1
/eval /edit -P0x%lpc_color_comment lpc_t_comment1

/def -p4 -F -E((lpc_flag|lpc_mode)&lpc_comments) -mregexp -q -t"/\\*.*\\*/" \
    lpc_t_comment2 = \
; Bei einzeiligem Kommentar darf /lpc_t_comment3 nicht auch loslegen.
    /edit -c0 lpc_t_comment3%;\
; /lpc_t_comment3 bei naechster Zeile wieder aktivieren.
    /def -1 -F -p99999 -mglob -q -t"*" lpc_t_comment2a = \
	/edit -c100 lpc_t_comment2
/eval /edit -P0x%lpc_color_comment lpc_t_comment2

/def -p2 -F -E((lpc_flag|lpc_mode)&lpc_comments) -mregexp -q -t"/\\*.*" \
    lpc_t_comment3 = \
; Bis zum naechsten "*/" weiterfaerben.
; Merkwuerdige regexp, aber sonst werden fuehrende Leerzeichen gefressen.
    /def -F -p10 -mregexp -q -t"^( *.*)" lpc_t_comment3a = \
	/let tmp=%%P0%%;\
	/if (regmatch("[*]/", {P0})) \
	    /test substitute(strcat("@{x", lpc_color_comment, "}", {P0}, \
		"@{x}", {PR}), "", 1)%%;\
	    /purge lpc_t_comment3a%%;\
	/else \
	    /test substitute(tmp, lpc_color_comment)%%;\
	/endif
/eval /edit -P0x%lpc_color_comment lpc_t_comment3


; Strings
; (Ohne § frisst TF das leider nicht richtig.)
/def -p5 -F -E((lpc_flag|lpc_mode)&lpc_strings) -mregexp -q \
    -t'(^|[^\\§])(["].*["])' lpc_t_string
/eval /edit -P2x%lpc_color_string lpc_t_string


; Typen
/def -p5 -F -E(lpc_flag|lpc_mode) -mregexp -q -t"(^| |\\()((int|status|\
    string|object|object|array|mapping|closure|float|mixed|void|varargs)\\*?) " \
    lpc_t_type
/eval /edit -P2x%lpc_color_type lpc_t_type


; Modifier
/def -p5 -F -E(lpc_flag|lpc_mode) -mregexp -q -t"(^| )(public|private|\
    protected|static|virtual|nomask) " lpc_t_modifier
/eval /edit -P2x%lpc_color_modifier lpc_t_modifier


; Funktionen
/def -p7 -F -E(lpc_flag|lpc_mode) -mregexp -q -t"(^|[^A-Za-z0-9_])\
    ([A-Za-z_][A-Za-z0-9_]*) *\\(" lpc_t_function
/eval /edit -P2x%lpc_color_function lpc_t_function


; Schluesselwoerter von LPC
/def -p3 -F -E(lpc_flag|lpc_mode) -mregexp -q -t"(^|[^A-Za-z0-9_#])\
    (break|case|continue|else|for|foreach|if|inherit|return|sizeof|switch|while)\
    ([ (;:{]|$)" lpc_t_keyword
/eval /edit -P2x%lpc_color_keyword lpc_t_keyword


/addh info \
Falls die LPC-Faerbetrigger aktiv und ?%lpc_mode 0 sind, werden die Trigger \
beim naechsten "echten" Prompt (More-Prompt zaehlt nicht) deaktiviert.
/addh en info \
If the color triggers are active and ?%lpc_mode is 0, the next "real" \
prompt (more-prompt does not count) will turn off lpc-triggers.
/addh var %lpc_mode, %lpc_known_symbols, %lpc_prompt
/addh lpc_h_prompt hook

; Beim naechsten Prompt (ausser More) LPC-Modus ausschalten.
/def -p99999 -F -E(lpc_flag|lpc_mode) -msimple -q -h"PROMPT > " \
    lpc_h_prompt = \
    /set lpc_flag=0%;\
    /set lpc_symbols=%lpc_known_symbols%;\
    /purge lpc_t_symbol
/eval /edit -h"PROMPT %lpc_prompt" lpc_h_prompt


/addh info \
Aktiviert fuer diesen Befehl die LPC-Faerbetrigger und ruft dann 'cat' \
mit den angegebene Argumenten auf.
/addh en info \
Activates colorizing for this command and calls 'cat' with the given \
arguments.
/addh syn /ccat <file>
/addh ex /ccat /doc/beispiele/ssp/mon/stahldrache.c
/addh see /less, /head, /tail
/addh ccat comm

/def ccat = \
    /set lpc_flag=1%;\
    /send !cat %*


/addh info \
Aktiviert fuer diesen Befehl die LPC-Faerbetrigger und ruft dann 'more' \
mit den angegebene Argumenten auf.
/addh en info \
Activates colorizing for this command and calls 'more' with the given \
arguments.
/addh syn /less <file1> [<file2> ...]
/addh ex /less /std/corpse
/addh see /ccat, /head, /tail
/addh less comm

/def less = \
    /set lpc_flag=1%;\
    /send !more %*


/addh info \
Aktiviert fuer diesen Befehl die LPC-Faerbetrigger und ruft dann 'head' \
mit den angegebene Argumenten auf.
/addh en info \
Activates colorizing for this command  and calls 'head' with the given \
arguments.
/addh syn /head <file>
/addh ex /head /p/service/tiamak/doc/fband.txt
/addh see /ccat, /less, /tail
/addh head comm

/def head = \
    /set lpc_flag=1%;\
    /send !head %*


/addh info \
Aktiviert fuer diesen Befehl die LPC-Faerbetrigger und ruft dann 'tail' \
mit den angegebene Argumenten auf.
/addh en info \
Activates colorizing for this command  and calls 'tail' with the given \
arguments.
/addh syn /tail <file>
/addh ex /tail /d/ebene/room/PortVain/po_haf1.c
/addh see /ccat, /less, /head
/addh tail comm

/def tail = \
    /set lpc_flag=1%;\
    /send !tail %*


/addh info \
Entfernt alle Trigger, Hooks, Kommandos und Variablen von lpc.tf.
/addh en info \
Removes all triggers, hooks, macros and variables of lpc.tf.
/addh syn /remove_lpc
/addh remove_lpc comm

/def remove_lpc = \
    /remove_packet lpc ccat less tail head



/addh info \
Dieses File enthaelt im Wesentlichen Faerbetrigger fuer LPC-Code. Die Farben \
fuer acht Sprachelemente koennen mit den Variablen %lpc_color_... (siehe \
Variablen) festgelegt werden. Ausserdem gibt es noch die drei Flags \
?%lpc_comments, ?%lpc_strings und ?%lpc_mode sowie ?%lpc_known_symbols.@{N}\
Defaultmaessig sind die Trigger (alles regexp-Trigger) nicht staendig \
aktiv, sondern nur bei Verwendung von ?/less, ?/ccat, ?/head und ?/tail. \
Um die Trigger dauerhaft zu aktivieren, muss ?%lpc_mode auf 1 gesetzt \
werden.@{N}\
Die Defaultfarben sind an die Emacs-Farbegebung angelehnt und koennen \
direkt (per /set ...) oder ueber /configure (Oberflaeche, LPC) gesetzt \
werden.
/addh en info \
This file contains triggers for colorful lpc code. Eight different colors \
can be set by the variables %lpc_color_... (see variables). The triggers \
(all regexp, so expensive) can be (de)activated by setting ?%lpc_mode to 0 \
or 1. Using ?/less, ?/ccat, ?/head and ?/tail instead of their counterparts \
without '/' is recommended.@{N}\
The default colors are similiar to emacs' style and can be changed directly \
(by /set ....) or via /configure (Oberflaeche, LPC).
/addh var %lpc_color_X, wobei X eins der Woerter comment, string, keyword, \
function, type, modifier, symbol, preprocessor ist, %lpc_comments, \
%lpc_strings, %lpc_known_symbols, %lpc_mode
/addh en var %lpc_color_X, where X is comment, string, keyword, function, \
type, modifier, symbol or preprocessor, %lpc_comments, %lpc_strings, \
%lpc_known_symbols, %lpc_mode
/addh comm /less, /ccat, /head, /tail, /remove_lpc
/addh hook /lpc_h_prompt
/addh_fileinfo

