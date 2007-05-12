; $Log: functions.tf,v $
; Revision 1.2  2001/12/08 22:38:13  mh14
; fileinfo,log,escape_macro_name
;

/set functions_tf_version $Id: functions.tf,v 1.2 2001/12/08 22:38:13 mh14 Exp $
/set functions_tf_author=Vardion@mg.mud.de
/set functions_tf_requires=
/set functions_tf_desc=kleine Funktionssammlung

;;; kleine Funktionssammlung

;;; (c) Vardion@MorgenGrauen

;;; $Id: functions.tf,v 1.2 2001/12/08 22:38:13 mh14 Exp $

/def cap = /result strcat(toupper(substr({1}, 0, 1)), substr({*}, 1))

/def capl = /result cap(tolower({*}))

/def conv_umlauts = /result replace('ä', 'ae', replace('ö', 'oe', \
	replace('ü', 'ue', replace('Ä', 'Ae', replace('Ö', 'Oe', \
	replace('Ü', 'Ue', replace('ß', 'ss', {*})))))))

/def esc_special = /result replace('\\\'', '\\\\\\\'', \
	replace('\\\\', '\\\\\\\\', {*}))

/def baseword = /test regmatch('[A-Z].*$$', {*})%; /result {P0}

/def tmpname = \
	/result strcat(HOME, '/tftmp.', replace(' ', '0', pad(rand(1000000), \
		6, rand(1000000), 6, rand(1000000), 6, rand(1000000), 6, \
		rand(1000000), 6, rand(1000000), 6, rand(1000000), 6, \
		rand(1000000), 6, rand(1000000), 6, rand(1000000), 6)))


/def shellpipe = \
	/if ({#} < 2) /result ''%; /endif%; \
	/let shellpipe_result=%; \
	/if (strlen({2}) < 100000) \
		/test setenv(strcat('shellpipe_data=', {2}))%; \
		/quote -S -decho -- !echo -n "$$shellpipe_data"|%1 %| \
			/test tfread(shellpipe_result)%; \
		/unset shellpipe_data%; \
	/else \
		/let shellpipe_in=$[tmpname()]%; \
		/let shellpipe_handle=%; \
		/if ((shellpipe_handle:=tfopen(shellpipe_in, 'w'))==-1) \
			/result ''%; \
		/endif%; \
		/test tfwrite(shellpipe_handle, {2})%; \
		/test tfclose(shellpipe_handle)%; \
		/quote -S -decho -- !tr -d '\\n' < %shellpipe_in|%1 %| \
			/test tfread(shellpipe_result)%; \
		/quote -S -decho -- !rm -f %shellpipe_in 2> /dev/null%; \
	/endif%; \
	/result shellpipe_result

/def squeeze = \
	/let res=%*%; \
	/while (regmatch('  +', res)) \
		/let res=%PL %PR%; \
	/done%; \
	/result res


/def escape_macro_name = \
	/let param=%;\
	/test param:={*}%;\
	/let result=%;\
	/while (regmatch("[^a-zA-Z0-9_]",param)) \
	   /test result:=strcat(result,{PL},"_",ascii({P0}),"_")%;\
	   /test param:={PR}%;\
	/done%;\
	/return strcat(result,param)%;
