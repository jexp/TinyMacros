; $Log: util.prompts.tf,v $
; Revision 1.10  2001/10/10 22:10:21  mh14
; Default-Konfiguration in .tf Files verschoben
;
; Revision 1.9  2001/10/07 17:01:43  mh14
; connect hook in util.prompts.def
;
; Revision 1.8  2001/09/11 20:53:29  mh14
; Versuch einer Zusatzfunktion von /prompt
;
; Revision 1.7  2001/09/10 19:48:59  mh14
; h_action_prompt generalisiert
;
; Revision 1.6  2001/09/09 19:16:59  mh14
; requires bereinigt
;
; Revision 1.5  2001/09/09 19:09:42  mh14
; help_de.list
;
; Revision 1.4  2001/09/06 21:11:44  mh14
;  Log eingefuegt
;

/set util_prompts_tf_version $Id: util.prompts.tf,v 1.10 2001/10/10 22:10:21 mh14 Exp $
/set util_prompts_tf_author=Mesirii@mg.mud.de
/set util_prompts_tf_requires lists.tf util.hooks.tf
/set util_prompts_tf_desc Makros zum Nutzen der Prompts, des Muds um Makros auszufuehren

; ********************* BEGIN CONFIG ********************
/add_to_hook connect /init_action_count
; ********************* END CONFIG **********************

/addh info \
Initialisiert das Zaehlen von Befehlen und Prompts in den Variablen '_${world_name}(action|prompt)_count'. Dazu wird die Liste 'prompt_action' erzeugt und /def_prompt_hook aufgerufen.
/addh see def_prompt_hook
/addh init_action_count mak

/def init_action_count = \
	     /set _${world_name}action_count=0%;\
	     /set _${world_name}prompt_count=0%;\
	     /createlist prompt_action%;\
	     /def_prompt_hook%;\


/addh info \
Erhoeht den Zaehler fuer die ans Mud geschickten Befehle. Ist vor allem fuer SEND-Hooks notwendig, die die Daten per /send ans Mud schicken, und ueberall sonst, wo /send benutzt wird.
/addh syn /add_catchup_action Zahl der Kommandos
/addh add_action_count mak

/def add_action_count = \
;	/echo add_action_count+%*%;\
	/test _${world_name}action_count:=_${world_name}action_count+(0+{1-1})%;\
;	/let res=%;\
;	/test res:=_${world_name}action_count%;\
;	/let res2=%;\
;	/test res2:=${world_name}prompt_count%;\
;	/echo action: action %res prompt %res2 %-1%;\
;	/add_catchup_action /echo prompt: action %res prompt %%res %-1%;\

/addh info \
Da es immer wieder mal passiert, dass die Zaehlung durcheinanderkommt, werden hiermit die Liste 'prompt_action' geloescht und die Variablen auf denselben Wert (action_count) gesetzt.
/addh clear_actions mak

/def clear_actions = \
	/createlist prompt_action%;\
	/let res=%;\
	/test res:=_${world_name}prompt_count%;\
	/set _${world_name}action_count=%res%;

/addh info \
Fuehrt nach dem erfolgreichen Ausfuehren der x naechsten Befehle, die ans Mud geschickt werden, den angegebenen Code aus. Dieser wird in einer Liste gespeichert und vom Hook 'h_action_prompt' ausgefuehrt. Es wird auf die Zahl der bisher gesendeten Befehle der Parameter (Standard 1) aufaddiert, und nach dieser Zahl Prompts wird der Code ausgefuehrt.
/addh ex \
n%;n%;o%;@{N}\
/promt_action 5 /echo fertig%;@{N}\
o%;n%;ob%;s%;w%; (wenn diese Befehle vom Mud fertig ausgefuehrt wurden, kommt das '/echo fertig')
/addh syn /add_prompt_action (Zahl der abzuwartetende Befehle) Code
/addh see def_prompt_hook
/addh lists promt_action
/addh add_prompt_action mak

/def add_prompt_action = \
	/let res=%;\
	/test res:=_${world_name}prompt_count%;\
	/addtolist prompt_action $[0+res+{1}] %{-1}%;

/addh info \


/def add_catchup_action = \
	/let res=%;\
	/test res:=_${world_name}action_count-_${world_name}prompt_count%;\
;/let res%;\
	/if (res>0) \
	/add_prompt_action %res %*%;\
	/else \
	  /eval %*%;\
	/endif%;

/def get_action_diff = /result _${world_name}action_count-_${world_name}prompt_count%;

/def check_prompt_action = /let res=%;\
	/test res:=_${world_name}prompt_count+{1}%;\
	/iskey prompt_action %res%;\
	/result (value!~error)%;

/addh info \
Hook der den letzten Zeitpunkt speichert, an dem etwas ans Mud geschickt wurde. Wird von /check_idle genutzt.
/addh h_action hook

/def def_prompt_hook = \
  /def -w -p999 -F -q -hPROMPT h_action_prompt = \
	/if (show_prompt==1) /echo \%*\%; /endif\%;\
	/test ++_${world_name}prompt_count\%;\
	/let res=\%;\
	/test res:=_${world_name}prompt_count\%;\
;/echo prompt_count \%res param: \%* \%;\
	/getdvalueof prompt_action \%res\%;\
	/while (value!~error) \
	   /eval \%value\%;\
	   /getdvalueof prompt_action \%res\%;\
	/done%;\
	/def -w -h"SEND" -p0 -F -q h_action = /send_hook \%*%;\

/def send_hook = \
    /eval_hook send %*%;\
    /set last_action_time=$[time()]%;\
    /add_action_count 1%;\

/def msend =\
	/send_hook %*%;\
	/send %*%;

;/def prompt = \
;	/test prompt:={*}%;\
;	/@prompt %{*}%;

/addh_fileinfo
