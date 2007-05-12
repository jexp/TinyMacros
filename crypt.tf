; $Log: crypt.tf,v $
; Revision 1.15  2003/01/09 16:38:39  lje
;
; OK, auf Wunsch eines einzelnen Thufhirs ctm_timestamp wieder raus, dafür exakte Abweichung in ctm_timediff verfügbar
;
; Revision 1.14  2003/01/09 16:35:58  lje
;
; Zeitstempelgültigkeit nun automatisch auswertbar. ctm_timestamp==1 -> gültig, ctm_timestamp==0 -> starke abweichung.
;
; Revision 1.13  2002/11/04 22:21:50  lje
;
; regcomp fuer die Regexp zum Erfassen von TMs. Damit ist auch gleich das Punkt-Problem (huhu Thufhir ;-)) geloest
;
; Revision 1.12  2002/11/01 13:31:56  lje
;
; logischen Fehler behoben (hatte zum Glueck momentan keine Auswirkungen)
;
; Revision 1.11  2002/11/01 11:32:53  lje
;
; angepasst an break_string in remote, codeumstellungen
;
; Revision 1.10  2002/07/18 11:25:11  mh14
; liste in worldhook geladen
;
; Revision 1.9  2002/04/18 22:35:38  mh14
; list_location per /set_var
;
; Revision 1.8  2002/03/27 01:43:26  mh14
; ctm_load_list beim first_connect
;
; Revision 1.7  2001/12/17 23:32:19  mh14
; reverted to 1.5
;
; Revision 1.5  2001/12/13 09:45:30  dhammer10
;
; /delkey Konflikt mit keys.tf durch Umbennenung in /del_key geloest
;
; Revision 1.4  2001/12/12 10:21:26  lje
; "tm . <text>" tut jetzt mit ctm das, was man erwartet :-)
;
; Revision 1.3  2001/12/10 13:17:34  lje
; CTM hat nun kein problem mehr, falls world_character Grossbuchstaben enhaelt
;
; Revision 1.2  2001/12/08 22:45:02  mh14
; fileinfo,log,mudspezifische dinge konfigurierbar,listenfunktionen vorgezogen
;

/set crypt_tf_version $Id$
/set crypt_tf_author=Vardion@mg.mud.de
/set crypt_tf_requires=lists.tf break_string.tf functions.tf
/set crypt_tf_desc=verschluesselte Kommunikation uebers Mud

;;; 'crypt.tf' - verschluesselte Kommunikation uebers Mud

;;; (c) Vardion@MorgenGrauen

;;; $Id$

;;; Bitte tragt in bs_teilemit_von und bs_teilemit_an ein, wenn Ihr da was
;;; loggen wollt. Als Beispiel logge ich in bs_teilemit_von den Text.

;;; Dank an Mesirii fuer zahlreiche Verbesserungen :-)

;;; DEPEND: functions.tf, break_string.tf, mesis lists.tf

; ********************* BEGIN CONFIG ********************
; Attribute fuer empfangene TMs
/set ctm_attr=-aBCblue

; Attribute fuer gesendete TMs
/set cstm_attr=

/def mud_tell_command = !\\teile %1 mit %-1 
/def mud_remote_command = !\\r: %1 CTM #: %-1

/set mud_tell_trigger=
/test mud_tell_trigger:='teilt Dir mit:'

/def mud_you_tell_trigger=/return 'Du teilst %1 mit:'

/set mud_remote_trigger=
/test mud_remote_trigger:='CTM aus der Ferne:'


/addh info Ausgabe der empfangenen Mitteilungen
/addh bs_teilemit_von cfg

/def bs_teilemit_von = \
	/set bs_size=78%; \
	/set bs_attr=%ctm_attr%; \
	/if (log_comm) \
		/set bs_cmd=/comm_log%;\
		/test set('bs_indent=<%1> an $[cap(world_info('name'))]: ')%; \
		/break_string %-1%; \
	/endif%; \
	/set bs_cmd=%;\
	/test set('bs_indent=<%1> teilt Dir mit: ')%;\
	/break_string %-1

/addh info Ausgabe der gesendeten Mitteilungen
/addh bs_teilemit_an cfg

/def bs_teilemit_an = \
	/set bs_size=78%; \
	/set bs_attr=%cstm_attr%; \
	/test set('bs_indent=Du teilst <%1> mit: ')%;\
	/set bs_cmd=%;\
	/break_string %-1

/set_var ctm_keys_list_location=
/set_var ctm_keys_list_name=ctm_keys
; ********************* END CONFIG **********************

/def ctm_get_key = /getvalueof %ctm_keys_list_name %*
/def ctm_set_key = /uaddtolist %ctm_keys_list_name %*
/def ctm_del_key = /deletekeyandvalue %ctm_keys_list_name %*
/def ctm_get_del_key = /getdvalueof %ctm_keys_list_name %*
/def ctm_load_list = /loadnamedlist -q ctm_keys
/def ctm_save_list = /savenamedlist -q ctm_keys

/add_to_hook first_connect /ctm_world %*

/set ctm_regexp_tm=^([a-z0-9]+)<&&&([A-Za-z0-9+/=_]+)&&&>
/set ctm_regexp_remote=^([a-z0-9]+)<&&&([A-Za-z0-9+/=_]+)&&&>.

/eval /if /ismacro compile_regexp%; /then \
	/compile_regexp ctm_regexp_*%; \
/endif

/set ctm_regexp=

/def rc4encrypt = \
	/setenv CTM_KEY=%cryptkey%; \
	/let rc4encrypt_res=$[shellpipe('openssl enc -e -base64 -rc4 -salt \
		-pass env:CTM_KEY|tr \\\\n _', {*})]%; \
	/setenv CTM_KEY=%; \
	/result rc4encrypt_res

/def rc4decrypt = \
	/setenv CTM_KEY=%cryptkey%; \
	/let rc4decrypt_res=$[shellpipe('tr _ \\\\n|openssl enc -d \
		-base64 -rc4 -salt -pass env:CTM_KEY', {*})]%; \
	/unset CTM_KEY%; \
	/result rc4decrypt_res

/if (!have_ext('MD5')) /def md5 = \
	/return shellpipe('openssl md5', {*})%; \
/endif

/def send_packet = \
	/if ({#} < 3 | cryptkey =~ error | cryptkey =~ '') /break%; /endif%; \
	/if (world_info('character') =~ '') \
		/echo Kein Charakter-Name bekannt.%; \
		/break%; \
	/endif%; \
	/set crypt_receiver=%1%; \
	/let ctime=$[time()]%; \
	/let ctext=$[strcat(substr(strcat('0', strlen(ctime)), -2, 2), ctime, \
		replace(' ', '0', pad({2}, 2)), conv_umlauts({-2}))]%; \
	/let sendtext=%; \
	/test sendtext:=strcat(tolower(world_info('character')), '<&&&', \
		rc4encrypt(strcat(md5(ctext), ctext)), '&&&>')%; \
	/if (ctm_use_remote & strlen(sendtext) < 950) \
		/mud_remote_command %1 %sendtext%;\
	/else \
		/mud_tell_command %1 %sendtext%;\
	/endif

/def collect_and_decrypt = \
	/set crypttext=%crypttext%PR%; \
	/if (regmatch(ctm_regexp, crypttext)) \
		/if (decrypt_pid !~ '') \
			/kill %decrypt_pid%; \
			/set decrypt_pid=%; \
		/endif%; \
		/purge -msimple collect_and_decrypt_trig%; \
		/unset crypttext%; \
		/if (ctm_partner =~ '') \
			/set ctm_partner=%P1%; \
		/endif%; \
		/let ctm_partner_cap=$[cap(ctm_partner)]%; \
		/let ctm_message=%P2%; \
		/ctm_get_key %ctm_partner%; \
		/if (regmatch('^!([a-z]+)!$', tolower(value))) \
			/ctm_get_key %P1%; \
		/endif%; \
		/if (value =~ error) \
			/echo -aB Nicht entschluesselbares CTM \
				$[(ctm_direction =~ 'in') ? strcat('von ', \
				ctm_partner_cap, ' erhalten!') : \
				strcat('an ', ctm_partner_cap, \
				' geschickt!')]%; \
			/beep%; \
		/else \
			/set cryptkey=%value%; \
			/show_msg_%ctm_direction %ctm_partner_cap \
				$[rc4decrypt(ctm_message)]%; \
		/endif%; \
		/unset ctm_partner%; \
	/endif

/def ctm_create_deleter = \
	/set decrypt_pid=$[repeat('-1 1 /purge -msimple \
		collect_and_decrypt_trig%;/set decrypt_pid=')]

/def -p100000 -mregexp -q -ag -t' teilt Dir mit: ([a-z]+)<&&&' decrypt_tm = \
	/set crypttext=%P1<&&&%PR%; \
	/let dtm_tm_sender=$[replace('(', '\\\\(', replace(')', '\\\\)', \
		{PL}))]%; \
	/def -p9999 -mregexp -q -ag -t'^%dtm_tm_sender %mud_tell_trigger ' \
		collect_and_decrypt_trig = /collect_and_decrypt%; \
	/ctm_create_deleter%; \
	/set ctm_direction=in%; \
	/set ctm_partner=%; \
	/test regmatch('', '')%; \
	/test ctm_regexp:=ctm_regexp_tm%; \
	/collect_and_decrypt

/eval /edit -p100000 -mregexp -q -ag -t' %mud_tell_trigger ([a-z]+)<&&&' decrypt_tm

/def -p100000 -mregexp -q -ag -t'^Du teilst [A-Za-z]+ mit: [a-z]+<&&&' \
	decrypt_sendtm = \
	/set crypttext=%-4%; \
	/set ctm_partner=$[tolower({3})]%; \
	/def -p9999 -mregexp -q -ag -t'^$[mud_you_tell_trigger({3})] ' \
		collect_and_decrypt_trig = /collect_and_decrypt%; \
	/ctm_create_deleter%; \
	/set ctm_direction=out%; \
	/test regmatch('', '')%; \
	/test ctm_regexp:=ctm_regexp_tm%; \
	/collect_and_decrypt

/eval /edit -p100000 -mregexp -q -ag -t'^$[mud_you_tell_trigger("[A-Za-z]+")] [a-z]+<&&&' decrypt_sendtm

/def -p100000 -mregexp -q -ag -t' CTM aus der Ferne: ?' \
	decrypt_remote = \
	/let rem_pos=%; \
	/set crypttext=%PR%; \
	/if ((rem_pos:=strstr({PL}, '->')) > -1) \
		/set ctm_partner=$[tolower(substr({PL}, 0, rem_pos))]%; \
		/if (!regmatch('^[A-Za-z]+$$', ctm_partner)) \
			/set ctm_partner=$[tolower(crypt_receiver)]%; \
		/endif%; \
		/set ctm_direction=out%; \
	/else \
		/set ctm_partner=%; \
		/set ctm_direction=in%; \
	/endif%; \
	/def -p9999 -mregexp -q -ag -t'^' collect_and_decrypt_trig = \
		/collect_and_decrypt%; \
	/ctm_create_deleter%; \
	/test ctm_regexp:=ctm_regexp_remote%; \
	/collect_and_decrypt

/eval /edit -p100000 -mregexp -q -ag -t' %mud_remote_trigger ?' decrypt_remote

/def show_msg_in = \
	/let cmd5=$[substr({-1}, 0, 32)]%; \
	/let ctext=$[substr({-1}, 32)]%; \
	/if (md5(ctext) !~ cmd5) \
		/echo -aB Fehlerhaftes CTM von %1 erhalten!%; \
		/echo DEBUG: %*%; \
		/beep%; \
		/break%; \
	/endif%; \
	/let ctmtlen=$[substr(ctext, 0, 2)]%; \
	/set ctm_timediff=$[abs(time() - substr(ctext, 2, ctmtlen))]%; \
	/if (ctm_timediff > 300) \
		/echo -aB WARNUNG: Starke Zeitstempelabweichung - \
			Moegliche Replay-Attacke!%; \
	/endif%; \
	/let ctmtype=$[substr(ctext, ctmtlen + 2, 2)]%; \
	/let ctext=$[substr(ctext, ctmtlen + 4)]%; \
	/if     (ctmtype == 0) \
		/bs_teilemit_von $[cap({1})] %ctext%; \
	/else \
		/echo -aB Unbekannten Pakettyp von $[cap({1})] erhalten!%; \
		/beep%; \
	/endif

/def show_msg_out = \
	/let cmd5=$[substr({-1}, 0, 32)]%; \
	/let ctext=$[substr({-1}, 32)]%; \
	/if (md5(ctext) !~ cmd5) \
		/echo -aB Fehlerhaftes CTM an %1 gesendet!%; \
		/beep%; \
		/break%; \
	/endif%; \
	/let ctmtlen=$[substr(ctext, 0, 2)]%; \
	/let ctmtype=$[substr(ctext, ctmtlen + 2, 2)]%; \
	/let ctext=$[substr(ctext, ctmtlen + 4)]%; \
	/if     (ctmtype == 0) \
		/bs_teilemit_an $[cap({1})] %ctext%; \
	/else \
		/echo -aB Unbekannten Pakettyp an $[cap({1})] gesendet!%; \
		/beep%; \
	/endif

     
/def tm = \
	/if ({#} < 2) /break%; /endif%; \
	/let ctm_rcpt=%1%; \
	/if (ctm_rcpt =~ '.') \
		/let ctm_rcpt=%ctm_last_rcpt%; \
	/endif%; \
	/set ctm_last_rcpt=%ctm_rcpt%; \
	/ctm_get_key $[conv_umlauts(tolower(ctm_rcpt))]%; \
	/if (regmatch('^!([a-z]+)!$', tolower(value))) \
		/ctm_get_key %P1%; \
	/endif%; \
	/if (value !~ error) \
		/set cryptkey=%value%; \
		/send_packet %ctm_rcpt 0 %-1%; \
	/else \
		/mud_tell_command %ctm_rcpt %-1%;\
	/endif

/def set_key = \
	/if ({#} < 2) /echo Syntax: /setkey <partner> <key>%;/break%;/endif%; \
	/ctm_load_list%; \
	/if (regmatch('^!([A-Za-z]+)!$', {2})) \
		/ctm_set_key $[conv_umlauts(tolower({1}))] \
			$[conv_umlauts(tolower({2}))]%; \
	/else \
		/ctm_set_key $[conv_umlauts(tolower({1}))] %2%; \
	/endif%; \
	/ctm_save_list%; \
	/echo Ok, Schluessel fuer $[conv_umlauts(cap({1}))] wurde gesetzt.

;;; Historischer Name
/def addkey = \
	/echo Warnung: Addkey ist veraltet, benutze bitte /set_key%; \
	/set_key %*

/def del_key = \
	/if (!{#}) /echo Syntax: /delkey <partner>%;/break%;/endif%; \
	/ctm_load_list%; \
	/ctm_get_del_key $[conv_umlauts(tolower({1}))]%; \
	/if (value !~ error) \
		/ctm_save_list%; \
		/echo Ok, Schluessel fuer $[conv_umlauts(cap({1}))] wurde \
			geloescht.%; \
	/else \
		/echo Fuer $[conv_umlauts(cap({1}))] existiert kein \
			Schluessel!%; \
	/endif

/def showkeys = \
	/if (!{#}) \
		/echo Syntax: /showkeys <regexp>%;/break%; \
	/endif%; \
	/set showkeys_matches=0%; \
	/ctm_load_list%; \
	/def showkeys_show = \
		/if (regmatch('^$[conv_umlauts(tolower({1}))]$$', {1}) & \
			{1} !/ 'use_remote_*') \
			/test ++showkeys_matches%%; \
			/if (regmatch('^!([a-z]+)!$$', {-1})) \
				/echo -- $$[strcat(cap({1}), ' -> Alias auf ',\
					cap({P1}))]%%; \
			/else \
				/echo -- $$[cap({1})] -> KEY%%; \
			/endif%%; \
		/endif%; \
	/foreach %ctm_keys_list_name kv /showkeys_show%; \
	/undef showkeys_show%; \
	/if (!showkeys_matches) \
		/echo Kein passender Schluessel gefunden.%; \
	/endif%; \
	/unset showkeys_matches

/def showkey = \
	/if (!{#}) \
		/echo Syntax: /showkey <keyname>%;/break%; \
	/endif%; \
	/ctm_load_list%; \
	/ctm_get_key $[conv_umlauts(tolower({1}))]%; \
	/if (value !~ error & {1} !/ 'use_remote_*') \
		/echo -- %1 -> %value%; \
	/else \
		/echo Dieser Schluessel existiert nicht.%; \
	/endif

/def ctm_remote = \
	/if (!{#}) \
		/echo Syntax: /ctm_remote <0|1>%; \
		/echo Momentan ist die Verwendung von remote fuer \
			$[cap(world_info('name'))] $[ctm_use_remote ? 'ein' : \
			'aus']geschaltet.%; \
	/else \
		/ctm_load_list%; \
		/if ({1} =~ '1') \
			/ctm_set_key use_remote_${world_name} 1%; \
			/echo Ok, Verwendung von remote fuer \
				$[cap(world_info('name'))] aktiviert.%; \
			/set ctm_use_remote=1%; \
		/else \
			/ctm_del_key use_remote_${world_name}%;\
			/echo Ok, Verwendung von remote fuer \
				$[cap(world_info('name'))] deaktiviert.%; \
			/set ctm_use_remote=0%; \
		/endif%; \
		/ctm_save_list%; \
	/endif

/def -p1 -F -hWORLD ctm_world = \
	/if ({*} !~ '' & world_info('character') !~ '') \
		/ctm_load_list%;\
		/ctm_get_key use_remote_${world_name}%; \
		/set ctm_use_remote=$[value !~ error]%; \
	/endif

/if (world_info('character') !~ '') \
	/ctm_world 1%; \
/endif

