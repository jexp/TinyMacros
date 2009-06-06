; $Log: mesg_repeat.tf,v $
; Revision 1.1  2002/04/23 10:49:26  lje
; Erste Version
;

/set mesg_repeat_tf_version $Id$
/set mesg_repeat_tf_author=Vardion@mg.mud.de
/set mesg_repeat_tf_requires=
/set mesg_repeat_tf_desc=Zusammenfassen identischer Ausgaben vom Mud

; Diese File fasst gleiche, aufeinanderfolgende Ausgaben des Muds zusammen,
; so wie das auch der Syslogd auf Unix-Systemen tut.
; Das gaggen erfolgt jedoch als Fallthrouh, so dass andere Trigger die Zeilen
; trotzdem noch zu Gesicht bekommen

/set msg_repeat_count=0
/set msg_repeat_pid=0

/def -p10000 -mglob -q -F -t'*' msg_repeat = \
	/if ({*} =~ msg_repeat_saved) \
		/test ++msg_repeat_count%; \
		/test substitute({*}, 'g')%; \
		/if (msg_repeat_pid & strstr($(/ps -s), msg_repeat_pid)) \
			/kill msg_repeat_pid%; \
		/endif%; \
		/repeat -2 1 /msg_repeat_out%; \
		/set msg_repeat_pid=%?%; \
	/else \
		/if (msg_repeat_count > 1) \
			/_echo %% last message repeated %msg_repeat_count \
				times%; \
			/if (msg_repeat_pid & strstr($(/ps -s), \
				msg_repeat_pid)) \
				/kill msg_repeat_pid%; \
			/endif%; \
		/endif%; \
		/set msg_repeat_count=1%; \
		/test set(strcat('msg_repeat_saved=', {*}))%; \
	/endif

/def msg_repeat_out = \
	/if (msg_repeat_count > 1) \
		/_echo %% last message repeated %msg_repeat_count times%; \
	/endif%; \
	/set msg_repeat_count=0%; \
	/set msg_repeat_saved=%; \
	/set msg_repeat_pid=0

