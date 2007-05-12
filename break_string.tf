; $Log: break_string.tf,v $
; Revision 1.4  2001/12/09 17:52:07  lje
; typofix
;
; Revision 1.3  2001/12/09 17:46:47  lje
; Neue Behandlung von Inline-Attributen in gebrochenem Text. Siehe Beschreibung zu bs_ignore_inline
;
; Revision 1.2  2001/12/08 22:42:10  mh14
; fileinfo,log,config sektion
;

/set break_string_tf_version $Id: break_string.tf,v 1.4 2001/12/09 17:52:07 lje Exp $
/set break_string_tf_author=Vardion@mg.mud.de
/set break_string_tf_requires=
/set break_string_tf_desc=break_string, stretch_string zum Formatieren von Texten

;;; 'break_string.tf'
;;;
;;; (c) Vardion@MorgenGrauen
;;;
;;; $Id: break_string.tf,v 1.4 2001/12/09 17:52:07 lje Exp $
;;;
;;; break_string ist an die efun break_string() angelehnt und arbeitet auch
;;; fast so
;;; break_string(string, size, indent) in LPC wird zu
;;; 	/set bs_size=%size
;;; 	/set bs_indent=%indent
;;;	/set bs_cmd=/ausgabemacro
;;; 	/break_string %string
;;; in TF.
;;; Leider koennen Strings in TF offenbar keine Newlines enthalten, deshalb
;;; wird der gebrochende Text direkt ausgegeben
;;; Displayattribute des ausgegebenen Textes koennen in bs_attr gesetzt werden
;;;
;;; /block_string arbeitet aequivalent, der Ausgabetext (ohne Indent) wird
;;; aber in Blocktext umgewandelt
;;;
;;; Ein weiteres Feature ist bs_ignore_inline. Wird diese Variable auf 1
;;; gesetzt, so werden in allen Laengenberechnungen Inline-Attribute fuer
;;; /echo -p etc ignoriert. Damit kann auf diese Art mehrfarbig gemachter
;;; Text korrekt behandelt werden. Bei einem Zeilenumbruch werden jedoch alle
;;; Attribute ausgeschaltet, so dass es hier zu falschen Farben kommen kann.
;;; Also aufpassen!
;;;

; ********************* BEGIN CONFIG ********************
/set bs_size=78
/set bs_ignore_inline=0
; ********************* END CONFIG **********************

/def break_string = \
	/let bs_out=%1%; \
	/shift%; \
	/let bs_csize=$[bs_size - bs_strlen(bs_indent)]%; \
	/if (bs_cmd =~ '') \
		/def bs_cmd=/echo %bs_attr -- %bs_indent$$(/stretch_string \
			%bs_csize %%*)%; \
	/else \
		/def bs_cmd=%bs_cmd %bs_indent$$(/stretch_string \
			%bs_csize %%*)%; \
	/endif%;\
	/while ({#} | bs_out !~ '') \
		/if (bs_strlen(bs_out) > bs_csize) \
			/test bs_cmd(substr(bs_out, 0, bs_csize))%; \
			/test bs_out:=substr(bs_out, bs_csize)%; \
		/else \
			/if (bs_strlen(bs_out) + bs_strlen({1}) + 1 > \
				bs_csize) \
				/if (bs_out !~ '') \
					/test bs_cmd(bs_out)%; \
				/endif%; \
				/test bs_out:={1}%; \
				/shift%; \
			/else \
				/test bs_out:=strcat(bs_out,' ',{1})%; \
				/shift%; \
				/if (!{#}) \
					/set bs_block=0%; \
					/test bs_cmd(bs_out)%; \
					/let bs_out=%; \
				/endif%; \
			/endif%; \
		/endif%; \
	/done%;\
	/undef bs_cmd

;;; Lueckenzerrung per Bresenham Algorithmus
/def stretch_string = \
	/if (!bs_block) /_echo %-1%; /break%; /endif%; \
	/let bs_len=%1%; \
	/shift%; \
	/let bs_dx=$[bs_len - 1 - bs_strlen({*}) + {#}]%; \
	/let bs_dy=$[{#} - 1]%; \
	/let bs_pad=0%; \
	/let bs_eps=0%; \
	/let stretch_start=%1%; \
	/let stretch_out=%; \
	/shift%; \
	/let bs_x=0%; \
	/while (bs_x <= bs_dx) \
		/let bs_eps=$[bs_eps + bs_dy]%; \
		/test ++bs_pad%; \
		/if (bs_eps * 2 >= bs_dx) \
			/let stretch_out=%stretch_out$[pad('', bs_pad)]%1%; \
			/shift%; \
			/let bs_pad=0%; \
			/let bs_eps=$[bs_eps - bs_dx]%; \
		/endif%; \
		/test ++bs_x%; \
	/done%; \
	/let stretch_out=%stretch_start$[pad('', bs_len - \
		bs_strlen(stretch_start) - bs_strlen(stretch_out))]\
			%stretch_out%; \
	/_echo %stretch_out

/def block_string = \
	/set bs_block=1%; \
	/break_string %*

;;; strlen, dass bei der Laengenberechnung inline-Attribute uebergehen kann
/def bs_strlen = \
	/if (!bs_ignore_inline) /return strlen({*})%; /endif%; \
	/let bs_sl=%*%; \
	/let bs_sl_left=%; \
	/let bs_sl_right=%; \
	/let bs_sl_pos=%; \
	/while ((bs_sl_pos:=strstr(bs_sl, '@{')) > -1 ) \
		/test bs_sl_left:=substr(bs_sl, 0, bs_sl_pos), \
			bs_sl_right:=substr(bs_sl, bs_sl_pos + 2), \
			bs_sl_right:=substr(bs_sl_right, strstr(bs_sl_right, \
				'}') + 1), \
			bs_sl:=strcat(bs_sl_left, bs_sl_right)%; \
	/done%; \
	/return strlen(bs_sl)

