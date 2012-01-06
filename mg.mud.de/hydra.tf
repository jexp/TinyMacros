; $Log: hydra.tf,v $
; Revision 1.8  2003/03/27 12:47:56  thufhnik
; tm-text konfigurierbar
;
; Revision 1.7  2002/09/10 09:37:59  thufhnik
; Countdown added
;
; Revision 1.6  2002/08/27 13:13:24  thufhnik
; weiterer hook
;
; Revision 1.5  2002/08/27 12:54:45  thufhnik
; hook beim toeten eines kopfes ausfuehren
;
; Revision 1.4  2002/05/12 09:20:04  thufhnik
; wenn die Tante wirklich anwesend ist, wird ein Hook ausgefuehrt
; /time2str ausgelagert nach util.conv.tf
; requires angepasst
; optische Aenderungen in den defs
;
; Revision 1.3  2002/03/31 10:44:19  thufhnik
; wenn Hydra verschwindet wird angezeigt wie lang sie da gewesen ist (huhu Asuka!)
;
; Revision 1.2  2002/03/05 10:53:02  thufhnik
; Doku zum Statuszeilenmodul
;
; Revision 1.1  2002/02/10 14:27:17  thufhnik
; Scratch
;

/set hydra_tf_version $Id$
/set hydra_tf_author=Thufhir@mg.mud.de
/set hydra_tf_requires=util.hooks.tf util.conv.tf
/set hydra_tf_desc=Utilities rund um die Hydra

/purge -mglob hydra_*

; Konfigurierbares

/set_var HYDRA_COUNTDOWN 1
/set_var HYDRA_TM_TXT muhhh

; Variablen initialisieren

/set hydra_time 0
/set hydra_sink 0
/set hydra_present 0

; Trigger

/set sl_hydra_present_doc=Tante Hydra anwesend (H)
/def sl_hydra_present = \
	/init_var hydra_present%;\
	/set status_func_hydra_present=(hydra_present)?"H":""%;\
	/set status_attr_hydra_present=hydra_present?"Cred":"n"%;\
	/return status_var("hydra_present",1)

/def -Fp1 -abCbgred -msimple -q -t'Die Hydra sinkt langsam in das Tal der \
	Lupinen nieder.' hydra_lands = \
	/set hydra_sink 1%;\
	/hydra_check_presence

/def -E(hydra_present) -Fp1 -abCbggreen -msimple -q -t'Die Hydra erhebt sich \
	aus dem Tal der Lupinen.' hydra_flies = /hydra_leaves

/def -E(hydra_present) -Fp1 -abCbggreen -msimple -q -t'Die Hydra stirbt in \
	einem Meer von Blut.' hydra_killed = /hydra_leaves

/def -E(hydra_present) -Fp1 -abCbggreen -msimple -q -t'Die Hydra zerfaellt zu \
	einem gigantischen Berg Gebein.' hydra_down = /hydra_leaves

/def -E(hydra_present) -Fp1 -aCbgred -msimple -q -t'Da ist im Moment gar \
	nichts auszubrennen!' hydra_kopf_fail

/def -E(hydra_present) -Fp1 -aCbggreen -msimple -q -t'Die Hydra stoesst einen \
	unmenschlichen Schrei aus.' hydra_kopf_burned

/def -E(hydra_present) -Fp1000 -aCbgmagenta -q -msimple -t'Der Hydrakopf \
	faellt tot zu Boden.' hydra_kopf_killed = \
	/eval_hook hydra_kopf_killed

/def -E(hydra_present) -Fp1 -msimple -q -t'Aus dem Leichnam erscheint \
	die Lichtgestalt Pumas und ueberreicht Dir' hydra_got_rue = \
	/def -1 -agCblue -mregexp -p1000 -F -q -t'Neues Alias\\\\: \
		hy_date_and_time += sag [0-9]+' hydra_killed_gag = \
		/echo -aCbggreen Hydrakill registriert!%;\
	/set hydra_time $[time()]%;\
	/send !\\alias hy_date_and_time sag $[time()]

/def -E(hydra_present) -Fp1 -msimple -q -t'Da Du nur eine Hydraruestung \
	haben sollst, loest sich Deine alte' hydra_got_rue1 = \
	/def -1 -agCblue -mregexp -p1000 -F -q -t'Neues Alias\\\\: \
		hy_date_and_time += sag [0-9]+' hydra_killed_gag = \
		/echo -aCbggreen Hydrakill registriert!%;\
	/set hydra_time $[time()]%;\
	/send !\\alias hy_date_and_time sag $[time()]

/def hydra_check_presence = \
	/repeat -5 1 /purge -mregexp hydra_check_trig[1-3]%;\
	/purge -mregexp hydra_check_trig[1-3]%;\
	/def -1 -p100 -msimple -q -agCblue -t'Du teilst Hydra mit: \
		%{HYDRA_TM_TXT}' hydra_check_trig1 = \
		/set hydra_present=$$[time()]%%;\
		/echo -aCbgred Hydra ist da!%%;\
		/hydra_countdown%%;\
		/eval_hook hydra_present%;\
	/def -1 -p100 -msimple -q -agCblue -t'Das war nicht eindeutig!' \
		hydra_check_trig2 = \
		/set hydra_present 0%%;\
		/set hydra_sink 0%;\
	/def -1 -p100 -msimple -q -agCblue -t'Du teilst Hydrakopf mit: \
		%{HYDRA_TM_TXT}' hydra_check_trig3 = \
		/set hydra_present 0%%;\
		/set hydra_sink 0%;\
	/send !\\teile hydra mit %{HYDRA_TM_TXT}

/def hydra_ruestung = \
	/if (hydra_time) \
		/hydra_ruestung_out%;\
	/else \
		/hydra_query_ruestung%;\
	/endif

/def hydra_leaves = \
	/if (hydra_present) \
		/let HYDRA_TMP_TIME=$[time()-hydra_present]%;\
		/let HYTRA_TMP_STR=$(/time2str %HYDRA_TMP_TIME 1)%;\
		/echo -aCgreen Die Hydra war %HYTRA_TMP_STR anwesend.%;\
		/set hydra_present 0%;\
		/eval_hook hydra_leaves%;\
	/endif

/def hydra_query_ruestung = \
	/purge hydra_query_trig1%;\
	/purge hydra_query_trig2%;\
	/repeat -5 1 /purge hydra_query_trig1%%;/purge hydra_query_trig2%;\
	/def -1 -agCblue -mregexp -q -Fp100 -t' hy_date_and_time += sag \
		([0-9]+)' hydra_query_trig1 = \
		/set hydra_time %%P1%%;\
		/hydra_ruestung_out%;\
	/def -1 -agCblue -mregexp -q -Fp100 -t'Du hast kein Alias \
		\\\\"hy_date_and_time\\\\" definiert\\\\.' hydra_query_trig2 = \
		/set hydra_time -1%%;\
		/hydra_ruestung_out%;\
	/send !\\alias hy_date_and_time

/def hydra_ruestung_out = \
	/if (hydra_time == -1) \
		/echo -aCred Keine Daten zur Hydraruestung vorhanden!%;\
	/else \
		/let HYDRA_TMP_TIME=$[hydra_time+3628800-time()]%;\
		/if (HYDRA_TMP_TIME < 0 ) \
			/echo -aCbgred Die Hydraruestung ist abgelaufen!%;\
		/else \
			/let HYDRA_TMP_STR=$(/time2str %HYDRA_TMP_TIME)%;\
			/echo -aCgreen Die Hydraruestung haelt noch \
				%HYDRA_TMP_STR.%;\
		/endif%;\
	/endif

/def hydra_countdown = \
	/if (HYDRA_COUNTDOWN & hydra_sink & hydra_present) \
		/if (hydra_sink==2) \
			/echo -aCred Die Hydra verlaesst das Nest und kommt \
				ins Tal!%;\
		/elseif (hydra_sink>2 & mod(hydra_sink,2)) \
			/let HYDRA_TMP_TIME=$[time()-hydra_present]%;\
			/let HYDRA_STR=$(/time2str %HYDRA_TMP_TIME)%;\
			/let HYDRA_TMP_TIME=$[2160-HYDRA_TMP_TIME]%;\
			/if (HYDRA_TMP_TIME < 120) \
				/set hydra_sink -1%;\
			/endif%;\
			/let HYDRA_STR2=$(/time2str %HYDRA_TMP_TIME)%;\
			/echo -aCred Die Hydra ist schon %HYDRA_STR anwesend \
				und bleibt noch ca. %HYDRA_STR2!%;\
		/endif%;\
		/test ++hydra_sink%;\
		/repeat -90 1 /hydra_countdown%;\
	/else \
		/set hydra_sink 0%;\
	/endif

/hydra_check_presence
/hydra_ruestung
