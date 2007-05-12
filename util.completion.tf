; $Log: util.completion.tf,v $
; Revision 1.6  2001/11/27 21:33:49  mh14
; anpassung an first_connect hook
;
; Revision 1.5  2001/10/10 22:10:21  mh14
; Default-Konfiguration in .tf Files verschoben
;
; Revision 1.4  2001/09/09 19:09:41  mh14
; help_de.list
;
; Revision 1.3  2001/09/06 21:11:44  mh14
;  Log eingefuegt
;

/set util_completion_tf_version $Id: util.completion.tf,v 1.6 2001/11/27 21:33:49 mh14 Exp $
/set util_completion_tf_author=Mesirii@mg.mud.de
/set util_completion_tf_requires util.trigger.tf
/set util_completion_tf_desc Erweiterte Vervollstaendigung (Completion)

; ********************* BEGIN CONFIG ********************
/addh info \
Anzahl der Zeilen im Recall, die die ?completion zurueckgehen soll (Default 200).
/addh see completion
/addh completion_recall_count var
/set completion_recall_count=200

; util.completion.tf
; Binding von Completion auf TAB

/def -b"^i" b_completion = \
	/if (moresize()>0) /dokey PAGE%; \
	/else /completion%; /endif%;

/add_to_hook first_connect /load_config -c util.completion
; ********************* END CONFIG **********************

/addh info \
Vervollstaendigt den bisher eingegebenen Text automatisch. Dabei werden die Vorschlaege kontextsensitiv ermittelt. Wenn ein % vorher steht, werden Variablen, bei / werden Makronamen, bei ? einer der Knoten des Wegesystems, bei @ einer der anwesenden Spieler, bei & ein Item aus dem Invetory und ansonsten Text aus dem Mud (?completion_recall_count (default 200 Zeilen zurueck) verwendet. Durch mehrmaliges Druecken der Taste werden alle Moeglichkeiten durchgespielt.
;/addh info \
;Completes the input automagically. The suggestions are created context sensitive. If a % preceded the word tf variables, ? nodes of the routing system, / macro names, @ one of the players, & an item of the inventory, and otherwise text of the mud (?completion_recall_count (default 200 lines back) are used as source for the completions. if the completion key is hit multiple all possibilties are tried.
/addh var completion_list, completion_line, last_completion, completion_recall_count, mud_set_line_count, mud_invetory, mud_short_who
/addh adapt completion_recall_count, mud_set_line_count, mud_inventory, mud_short_who
/addh completion comm
/def completion = \
	/if ((completion_list=~"") | \
	     (strcat(completion_line,last_completion)!~kbhead())) \
	/set completion_list=,%;\
	/set completion_line=$[kbhead()] %;\
	/let start=$[substr(completion_line,kbwordleft())] %;\
	/let prefix=$[substr(completion_line,kbwordleft()-1,1)] %;\
;	/let prefix%;\
	/if (prefix=/"[%{]") \
	  /let res=$(/listvar -mglob -sg  $[strcat(start,"*")]) %;\
	  /let res=$[strcat(res,".")]%;\
	/elseif (prefix=/"[/]") \
	  /let res=$(/list -mglob -s -i  $[strcat(start,"*")]) %;\
	  /let res=$[strcat(res,".")]%;\
	/elseif (prefix=/"[&]") \
	  /set fulldetail=%;\
	  /set nextmakro=\/complete2 %start mud_output %;\
	  /set completion_line=$[strcat(substr(completion_line,0,kbwordleft()-1),substr(completion_line,kbwordleft()))] %;\
	  %mud_set_line_count 0%;\
	  /def_psave_trig%; /def_psave3_trig 3%; %mud_inventory%;%mud_set_line_count %{mud_line_count-20}%;\
	/elseif (prefix=/"[@]") \
	  /set fulldetail=%;\
	  /set nextmakro=\/complete2 %start mud_output %;\
	  /set completion_line=$[strcat(substr(completion_line,0,kbwordleft()-1),substr(completion_line,kbwordleft()))] %;\
	  /def_psave_trig%; /def_psave3_trig%; %mud_short_who%;\
;	  /let res=$[strcat(res,".")]%;\
	/elseif (prefix=/"[?]") \
	  /if (nodelist=~"") \
	    /let res=$(/shownode *) %;\
	  /endif%;\
	  /let res=$[strcat(nodelist,".")]%;\
	  /set completion_line=$[strcat(substr(completion_line,0,kbwordleft()-1),substr(completion_line,kbwordleft()))] %;\
	/else \
	  /let pat=$[strcat(start,"[A-Za-z0-9´-]+[^A-Za-z0-9´-]")] %;\
	  /let res=$(/recall -ag -g -q -mregexp %completion_recall_count %pat) %;\
	/endif%;\
	/if (prefix!/"[@&]") /complete2 %start %res %; /endif %;\
	/else /complete3 %;\
	/endif %;\

/def complete2=\
	/let start=%1%;\
	/let res=%-1%;\
	/if (res=~"mud_output") \
	  /let res=$[tolower(fulldetail)]%; \
	  /let start=$[tolower(start)] %;\
        /endif%;\
	/let pat2=$[strcat("[^A-Za-z0-9´_-]",start,"([A-Za-z0-9´_-]+)[^A-Za-z0-9´_-]")] %;\
;/let pat2 %;\
;	/let res %;\
	/while (res!~"") \
;	  /let off=$[strstr(res,start)] %;\
;	  /let off%;\
;	  /if (off!=-1) \
;	  /let res=$[substr(res,off)] %;\
;	  /let res%;\
	  /if (regmatch(pat2,res)) \
;	     /echo P1 %P1 %;\
	     /if (strstr(completion_list,strcat(",",{P1},","))==-1) \
	       /set completion_list=$[strcat(",",{P1},completion_list)]%;\
	     /endif%;\
	     /let res=$[substr(res,strstr(res,{P1})+strlen({P1}))] %;\
;	  /else /let res=$[substr(res,strlen(start))]%; /endif %;\
	  /else /let res=%; /endif %;\
	/done %;\
;	/set completion_list=$[substr(completion_list,1)]%;\
	/set completion_list%;\
	/complete3 %;\

/def complete3 = \
	/set completion_list=$[substr(completion_list,1)]%;\
	/let off=$[strchr(completion_list,",")] %;\
	/dokey DLINE %;\
	/input %completion_line%;\
	/if (off==-1) \
	  /set last_completion=%;\
	  /set completion_line=%;\
	  /set completion_list=%;\
	/else \
	  /set last_completion=$[substr(completion_list,0,off)] %;\
	  /set completion_list=$[substr(completion_list,off)] %;\
	  /input %last_completion %;\
	/endif%;\


/addh_fileinfo
