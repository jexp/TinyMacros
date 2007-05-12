; $Log: sshload.tf,v $
; Revision 1.3  2001/10/02 13:55:37  lje
; sshload kommt nun mit kommentaren klar
;
; Revision 1.2  2001/10/01 22:35:16  mh14
; Doku
;
;

/set sshload_tf_version $Id: sshload.tf,v 1.3 2001/10/02 13:55:37 lje Exp $
/set sshload_tf_author=Vardion@mg.mud.de
/set sshload_tf_requires=
/set sshload_tf_desc remote load per ssh

/addh info laedt ein file ueber eine ssh verbindung, dabei werden innerhalb des Files die Kommandos /cd, /load und /exit beruecksichtigt. Alles andere wird ausgefuehrt (Makrodefinitionen, Code im File)
/addh syn /sshload host path/file
/addh ex /sshload server.home.net TinyMacros/private.tf
/addh sshload comm

/def sshload = \
	/set sshload_host=%1%; \
	/set sshload_dir=.%; \
	/def sshload_exec = \
		/if (!sshload_parse) /break%%; /endif%%; \
		/if ({L} =/ '*\\\\') \
			/set sshload_buffer=%%sshload_buffer$$[substr({*}, 0, \
				-1)]%%; \
		/else \
			/eval -s0 -- %%sshload_buffer%%*%%; \
			/set sshload_buffer=%%; \
		/endif%; \
	/def exit = /set sshload_parse=0%; \
	/def cd = \
		/if ({#}) /set sshload_dir=%%sshload_dir/%%*%%; /endif%%; \
		/lcd %%{*-%%HOME}%; \
	/def load = \
		/set sshload_parse=1%%; \
		/set sshload_buffer=%%; \
		/quote -S /sshload_exec !ssh %%sshload_host \
			'cd %%sshload_dir;grep -v "^;" %%*'%%; \
		/set sshload_parse=1%; \
	/load %-1%; \
	/def -i cd = /lcd %{*-%HOME}%; \
	/undef load%; \
	/undef exit%; \
	/undef sshload_exec%; \
	/quote -S /unset `'/listvar -mglob -s sshload_*'





/addh fileinfo
