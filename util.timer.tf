; $Log: util.timer.tf,v $
; Revision 1.7  2002/03/29 22:28:03  mh14
; Profiling Makros die Zeitmessungen im Millisekundenbereich fuer bestimmten Code oder beliebige Makros ausfuehren
;
; Revision 1.6  2001/09/12 08:05:51  mh14
; /timer bereinigt
;
; Revision 1.5  2001/09/09 19:09:42  mh14
; help_de.list
;
; Revision 1.4  2001/09/06 21:11:44  mh14
;  Log eingefuegt
;

/set util_timer_tf_version $Id: util.timer.tf,v 1.7 2002/03/29 22:28:03 mh14 Exp $
/set util_timer_tf_author=Mesirii@mg.mud.de
/set util_timer_tf_requires=
/set util_timer_tf_desc Timer in Sekunden und Millisekunden (patched tf)

/addh info \
Enthaelt den Makrobody, der vom ?timer beim Ausfuehren des Triggers aufgerufen wird. In %1 steht die vergangene Zeit.
/addh see timer
/addh timer_makro var
/set timer_makro=

/addh info \
Ein Timer, der im Sekundenbereich misst, also eher fuer Mud-Probleme gedacht ist. Beim Anlegen des Timers kann ein Trigger definiert werden, der dann den Makro-Body in ?timer_makro ausfuehrt.
/addh syn /timer count triggertext : Es wird /def -n%count %triggertext t_timer = /timer trigger erzeugt.@{N}\
	/timer remove : Loescht den Timer.@{N}\
	/timer reset : Setzt den Timer zurueck (geht auch fuer Initalisierung ohne trigger).@{N}\
	/timer get : Liefert in %? die vergangene Zeit.@{N}\
	/timer trigger : Fuehrt den Makro-Body in 'timer_makro' aus, wobei %1 die vergangene Zeit enthaelt.@{N}\
	/timer : Reinitialisiert den Timer und liefert die vergangene Zeit in %? oder als Funktionswert zurueck.
/addh ex '/timer 2 -t"*faellt zu Boden*" -mglob' wird zu '/def -n2 -t"*faellt zu Boden*" -mglob t_timer = /timer trigger`
/addh var timer, timer_makro
/addh see timer_makro
/addh trig t_timer
/addh timer mak
/def timer = \
	/if (regmatch("^[0-9]+$",{1})==1) \
	  /set timer=$[time()]%;\
	  /def %-1 -n%1 t_timer = /timer trigger\%; %;\
	/elseif ({1}=~"remove") \
	  /undef t_timer%;\
	/elseif ({1}=~"reset") \
	  /set timer=$[time()]%;\
	/elseif ({1}=~"get") \
	  /return time()-timer%;\
	/elseif ({1}=~"trigger") \
	  /let res=$[time()-timer]%;\
	  /set timer=$[time()]%;\
	  /def -1 timer_makro = %timer_makro%;\
	  /timer_makro %res%;\
	/else \
	  /let res=$[time()-timer]%;\
	  /set timer=$[time()]%;\
	  /return res%;\
	/endif %;

/addh info \
Ein Timer, der im Millisekundenbereich misst, der nur nach einem Patch des TF funktioniert. Beim Anlegen des Mstimers kann ein Trigger definiert werden, der dann den Makro-Body in ?mstimer_makro ausfuehrt.
/addh syn /mstimer count triggertext : Es wird /def -n%count %triggertext t_mstimer = /mstimer trigger erzeugt.@{N}\
	/mstimer remove : Loescht den Mstimer.@{N}\
	/mstimer reset : Setzt den Mstimer zurueck (geht auch fuer Initalisierung ohne Trigger).@{N}\
	/mstimer get : Liefert in %? die vergangene Zeit.@{N}\
	/mstimer trigger : Fuehrt den Makro-Body in 'mstimer_makro' aus, wobei %1 die vergangene Zeit enthaelt.@{N}\
	/mstimer : Reinitialisiert den Mstimer und liefert die vergangene Zeit in %? oder als Funktionswert zurueck.
/addh ex '/mstimer 2 -t"*faellt zu Boden*" -mglob' wird zu '/def -n2 -t"*faellt zu Boden*" -mglob t_mstimer = /mstimer trigger'
/addh var mstimer, mstimer_makro
/addh see mstimer_makro
/addh trig t_mstimer
/addh mstimer mak

/def mstimer = \
	/if (regmatch("^[0-9]+$",{1})==1) \
	  /set mstimer=$[mstime()] %;\
	  /def %-1 -n%1 t_mstimer = /mstimer trigger\%; %;\
	/elseif ({1}=~"remove") \
	  /undef t_mstimer%;\
	/elseif ({1}=~"reset") \
	  /set mstimer=$[mstime()] %;\
	/elseif ({1}=~"get") \
	  /return mstime()-mstimer%;\
	/elseif ({1}=~"trigger") \
	  /let res=$[mstime()-mstimer]%;\
	  /set mstimer=$[mstime()] %;\
	  /def -1 mstimer_makro = %mstimer_makro%;\
	  /mstimer_makro %res%;\
	/else \
	  /let res=$[mstime()-mstimer]%;\
	  /set mstimer=$[mstime()] %;\
	  /return res%;\
	/endif %;

/addh info \
Fuehrt ein Makro bzw. ein Stueck Code so oft aus wie angegeben und bestimmt die Zeit in Millisekunden, die dafuer notwendig war
/addh syn /profile count makro or code piece
/addh ex /profile 1000 /addtolist test_list testkey testvalue@{N}\
/profile 100 /x@{N}\
/profile 1000 /test strcat("abc","def")
/addh see profile_wrap
/addh profile mak

/def profile = \
     /let profile_count=%1%;\
     /let profile_action=%-1%;\
     /let profile_time=$[mstime()]%;\
     /while (--profile_count>=0) \
        /eval -s0 %profile_action%;\
     /done%;\
     /let profile_time=$[mstime()-profile_time]%;\
     /let profile_count=%1%;\
     /let profile_time2=$[mstime()]%;\
     /while (--profile_count>=0) \
     /done%;\
     /let profile_time2=$[mstime()-profile_time2]%;\
     /let profile_time=$[profile_time-profile_time2]%;\
     /echo %1 Runs of %profile_action took %profile_time ms; Average: $[profile_time/{1}] ms.

/addh info \
Kapselt den Body des angegebenen Makros in Zeitmesscode, mit /profile_info kann das Ergebnis abgefragt werten, 
/addh syn /profile_wrap makroname
/addh see profile_info, profile_unwrap
/addh profile_wrap mak
/def profile_wrap = \
     /unset mstimer_avg_%{*}%;\
     /unset mstimer_num_%{*}%;\
     /def profile_wrap_%{*} = ${%{*}}%;\
     /set value=${%{*}}%;\
     /let result=$[replace("%{*}",{*},profile_wrap_result)]%;\
     /test value:=replace("/return",strcat(result,"/return"),value)%;\
     /test value:=replace("/result",strcat(result,"/result"),value)%;\
     /def %{*} = /let mstimer_%{*}=\$[mstime()]\%;\
         %value\
	 $[(value!/"*%;")?"%;":""]\
         %result%;

/set profile_wrap_result=\
         /let mstimer_%{*}=$[mstime()-mstimer_%{*}]%;\
         /set mstimer_avg_%{*}=$[mstimer_avg_%{*}+mstimer_%{*}]%;\
         /set mstimer_num_%{*}=$[mstimer_num_%{*}+1]%;\
;         /test echo(strcat("mstimer %{*}: ",mstimer_%{*}," msek avg ",mstimer_avg_%{*}/mstimer_num_%{*}," msek"))%;

/addh info \
Stellt das Makro wieder her, dass in den Zeitmesscode eingebettet war, gibt ausserdem die gemessenen Zeiten aus
/addh syn /profile_unwrap makroname 
/addh see profile_info, profile_wrap
/addh profile_unwrap mak

/def profile_unwrap = \
     /def %{*}=${profile_wrap_%{*}}%;\
     /profile_info %{*}%;%;\
     /unset mstimer_avg_%{*}%;\
     /unset mstimer_num_%{*}

/addh info \
Gibt die gemessenen Zeiten fuer das angegebene, in Zeitmesscode eingebettete Makro aus.
/addh see profile_unwrap, profile_wrap
/addh syn /profile_info makroname 
/addh profile_info mak

/def profile_info = \
     /eval /echo Profiling for: %* abs: \%mstimer_avg_%{*} msek; count: \%mstimer_num_%{*}; avg: %{*}: \$[mstimer_avg_%{*}/mstimer_num_%{*}] msek%;

/addh_fileinfo
