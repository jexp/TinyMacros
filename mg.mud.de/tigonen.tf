; $Log: tigonen.tf,v $
; Revision 1.1  2002/05/12 10:15:58  thufhnik
; Scratch
;
;

/set tigonen_tf_version $Id$
/set tigonen_tf_author=Thufhir@mg.mud.de
/set tigonen_tf_requires=util.conv.tf
/set tigonen_tf_desc=Utility fuer das Tigonenamulett

/purge -mglob tigonen_*

/set tigonen_time 0

/def tigonen_amulett = \
	/if (tigonen_time) \
		/tigonen_amu_out%;\
	/else \
		/tigonen_query_amu%;\
	/endif

/def tigonen_query_amu = \
	/purge tigonen_query_trig1%;\
	/purge tigonen_query_trig2%;\
	/repeat -5 1 /purge tigonen_query_trig1%%;/purge tigonen_query_trig2%;\
	/def -1 -agCblue -mregexp -q -Fp100 -t' tig_date_and_time += sag \
		([0-9]+)' tigonen_query_trig1 = \
		/set tigonen_time %%P1%%;\
		/tigonen_amu_out%;\
	/def -1 -agCblue -mregexp -q -Fp100 -t'Du hast kein Alias \
		\\\\"tig_date_and_time\\\\" definiert\\\\.' \
		tigonen_query_trig2 = \
		/set tigonen_time -1%%;\
		/tigonen_amu_out%;\
	/send !\\alias tig_date_and_time

/def tigonen_amu_out = \
	/if (tigonen_time == -1) \
		/echo -aCred Keine Daten zum Tigonenamulett vorhanden!%;\
	/else \
		/let TIGTMP_TIME=$[tigonen_time+1209600-time()]%;\
		/if (TIGTMP_TIME < 0 ) \
			/echo -aCbgred Tigonenamulett ist abgelaufen!%;\
		/else \
			/let TIGTMP_STR=$(/time2str %TIGTMP_TIME)%;\
			/echo -aCgreen Das Tigonenamulett haelt noch \
				%TIGTMP_STR.%;\
		/endif%;\
	/endif

/def -Fp10000 -msimple -w -q -aCgreen -t'Hrakblak klettert aus dem Geschwuer.' \
	tigonen_hrakblak = \
	/purge -mglob tigonen_hralblak_g*%;\
	/repeat -5 1 /purge -mglob tigonen_hralblak_g*%;\
	/def -1 -Fp10000 -msimple -w -q -aCgreen -t'Hralblak vergroessert \
		Dein Tigonenamulett mit der Haut.' tigonen_hralblak_g1 = \
		/tigonen_set_time%;\
	/def -1 -Fp10000 -msimple -w -q -aCgreen -t'Hralblak fertigt aus \
		Deinem Stueck Tigonenhaut ein Amulett.' tigonen_hralblak_g2 = \
		/tigonen_set_time

/def tigonen_set_time = \
	/def -1 -agCblue -mregexp -p1000 -F -q -t'Neues Alias\\\\: \
		tig_date_and_time += sag [0-9]+' tig_ali_gag = \
		/echo -aCbggreen Zeit fuer das Tigonenamulett registriert!%;\
	/set tigonen_time $[time()]%;\
	/send !\\alias tig_date_and_time sag $[time()]

/tigonen_amulett
