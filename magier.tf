; $Log: magier.tf,v $
; Revision 1.6  2002/10/04 19:33:53  mh14
; kosmetik
;
; Revision 1.5  2002/09/15 23:38:32  mh14
; * -> {bla} jetzt auch weg
; * bei objekten wird jetzt nur der objektname mit dem input verglichen
; frueher hat er auch teile des pfades als gueltig genommen (sagt mal ob das
; sinnvoll ist)
; * war noch nen bug drin, dass er den zuletzt gesuchten input nich
; geloescht hat wenn neuer input da war
;
; Revision 1.4  2002/09/15 13:16:02  mh14
; * Ersetzungsanzeige wird rausgefiltert (z.b. [ls] {ls doc/} )
; * Schusselfehler beim More-Prompt
; * ^- als zusaetzliche Zeichen fuer Worterkennung
;
; Revision 1.3  2002/09/15 02:00:58  mh14
; * tf wollte #./ nicht als Wortbestandteile erkennen
; * hatte vergessen die Liste auf unique Eintraege zu filtern
;
; Revision 1.2  2002/09/15 00:34:03  mh14
; * Dummer basisbug is raus der den Cursor falsch gesetzt hat
; * funzt nun auch bei more (mit zeilen 3) getestet
; * funzt mit relativem/absolutem Prompt
; * xmore als filecommando dazu
; * einelementige Ergebnislisten werden nimmer angezeigt
; * leere eingabezeile wird nicht completed
; * Nutzung von \ls um Aliase zu umgehen
; * beliebige Prompts aus mind 1 Zeichen zur Endeerkennung
; * gleich mit eingebaut dass man mit TAB auch Mud-More weiterschalten kann
;
; Revision 1.1  2002/09/14 19:54:18  mh14
; hilfmakros fuer xtool, filename und objektnamen completion per tab
;

/set magier_tf_version $Id$
/set magier_tf_author=Mesirii@mg.mud.de
/set magier_tf_requires=
/set magier_tf_desc=Magierhilfsmittel vor allem Completion fuer Filenamen und Objekte

; ********************* BEGIN CONFIG ********************
/set ls_cmd_dir={cd|dir|rmdir|mkdir}
/set ls_cmd_other={ls|less|mv|cp|rm|cat|head|tail|more|ed|grep|upd|xmore|clone}
/set ls_header_line="*files/directories*" 
; ********************* END CONFIG **********************

/def xc = \
  /if (xcecho) /echo -aCyellow xcall %{1}->%{-1}%; /endif%;xcall %{1}->%{-1}

/def xce = /toggle xcecho%;

/def me = /xc me %*

/def sp = /xc %1 SetProp(P_%2,%-2)
/def qp = /xc %1 QueryProp(P_%2)

/def b_completion = \
     /if (moresize()>0) /dokey PAGE%; /return%; /endif%;\
     /if (more_prompt) /toggle more_prompt%;/send f%; /return%; /endif%;\
     /let kb_point=$[kbpoint()]%;\
     /let kb_line=$[kbgoto(0),kbtail()]%;\
     /test kbgoto(kb_point)%;\
     /if (kb_line=~"") \
	/echo -aCred No Completion for emtpy input! %;\
        /return%;\
     /endif%;\
     /is_ls_completion %kb_line%;\
     /if ({?}) \
        /completion_ls%;\
     /else \
        /completion_object%;\
     /endif%;

/def -mglob -q -aCyellow -p10 -h"PROMPT --mehr--*(*)*" ls_more_prompt = \
;     /echo ls_more_prompt ls: %trig_grab_active%;\
     /if (trig_grab_active) \
        /send f%;\
     /else \
        /set more_prompt=1%;\
        /def -q -1 -mglob -h"PROMPT *>*" -Fp1 t_more_done = \
          /set more_prompt=0%; \
     /endif

/def completion_object = \
     /let wordpunct_save=%wordpunct%;\
     /set wordpunct=%{wordpunct}#/.-^%;\
     /let input=$[kbgoto(kbwordleft()),substr(kbtail(),0,kbwordright()-kbpoint())]%;\
	/let reg=%;\
	/test reg:=strcat('/(players|obj|d|room|std|sys)[^ #]*',recall_input,'[^/ #]*#[0-9]+')%;\
;/let reg%;\
	/if (recall_input=~"" | last_recalled=~"" | last_recalled!~input) \
	   /set recall_input=%input%;\
	   /test reg:=strcat('/(gilden|players|obj|d|room|std|sys)[^ #]*',recall_input,'[^/ #]*#[0-9]+')%;\
;/let reg%;\
           /set recalled=$(/recall -mregexp -w /30 %reg)%;\
	   /let tmp_recalled=%;\
	   /while (regmatch(reg,recalled)) \
	      /if (tmp_recalled!/strcat("*{",{P0},"}*")) \
	         /let tmp_recalled=%tmp_recalled %P0%;\
	      /endif%;\
	      /set recalled=%PR%;\
	   /done%;\
	   /set recalled=%tmp_recalled%;\
	/endif%;\
	/if (regmatch(reg,recalled)) \
	   /set last_recalled=%P0%;\
	   /set recalled=%PR%;\
	   /test kbdel(kbwordright())%;\
	   /input %last_recalled%;\
	   /test kbgoto(kbwordright())%;\
	/else /echo -aCred No other completions found!%;\
	   /unset recalled%;\
	   /unset last_recalled%;\
	   /test kbdel(kbwordright())%;\
	   /input %recall_input%;\
	   /test kbgoto(kbwordright())%;\
	   /unset recall_input%;\
	/endif%;\
     /set wordpunct=%{wordpunct_save}%;\


/def is_ls_completion = \
     /return {1}=/ ls_cmd_dir | {1}=/ ls_cmd_other

/def completion_ls = \
   /set ls_text=%;\
   /def -1 -ag -p2 -t%ls_header_line t_ls1 = /test 0%;\
   /def -1 -ag -p2 -t"*\{.+\}" t_ls2 = /test 0%;\
   /def -1 -ag -p2 -t"\[*\]" t_ls3 = /test 0%;\
   /def -t"*" -ag t_ls = /set ls_text=\%ls_text \%*%;\
   /def -q -1 -aCred -mglob -h"PROMPT *>*" -p1 t_ls_done = \
;         /echo ls_done \%*\%;\
	 /set trig_grab_active=0\%;\
	 /purge t_ls*\%;\
	 /ls_complete \%ls_text%;\
   /test kbgoto(0)%;\
   /set trig_grab_active=1%;\
   /ls_input $[kbtail()]%;\

/def ls_input = \
   /if ({#}>1) \
      /set ls_param=%L%;\
      /set ls_cmd=%-L%;\
   /else \
      /set ls_param=%;\
      /set ls_cmd=%*%;\
   /endif%;\
   /dokey DLINE%;\
   /input %ls_cmd%;\
   /if (ls_cmd!~"") /test input(" ")%; /endif%;\
   /let off=$[strrchr(ls_param,"/")]%;\
   /set ls_basedir=%;\
   /if (off>-1) \
     /set ls_basedir=$[substr(ls_param,0,off+1)]%;\
     /test input(substr(ls_param,0,off+1))%;\
     /send \ls %ls_basedir%;\
     /test ls_param:=substr(ls_param,off+1)%;\
   /else \
     /send \ls%;\
   /endif%;\
   /set ls_dir=$[(ls_cmd=/ls_cmd_dir)]%;\

/def ls_complete = \
     /let ls_list=%;\
     /let ls_done=0%;\
     /let ls_base=-1%;\
     /while ({#}) \
;        /if (strstr({1},ls_param)==0 & (!ls_dir | (ls_dir & strchr({1},".")==-1))) \
        /if (strstr({1},ls_param)==0 & (!ls_dir | (ls_dir & {1}=/"*/"))) \
	   /test ++ls_done%;\
	   /let ls_list=%ls_list %1%;\
	   /if (ls_base=~"-1") \
	      /let ls_base=%1%;\
	   /else \
	     /let ls_max=$[strlen(ls_base)<strlen({1})? strlen({1}): strlen(ls_base)]%;\
	     /let ls_idx=0%;\
	     /while (ls_idx<=ls_max & \
		    (substr(ls_base,ls_idx,1)=~"" | \
		    substr(ls_base,ls_idx,1)=~substr({1},ls_idx,1)))%;\
	     /test ++ls_idx%;\
	     /done%;\
	     /test ls_base:=substr(ls_base,0,ls_idx)%;\
	   /endif%;\
	   /endif%;\
	/shift%;\
     /done%;\
     /if (ls_list=/" * *") \
       /echo -aCblue [%ls_list ]%;\
     /endif%;\
     /if (ls_base=~"-1") \
	/let ls_base=%1%;\
     /endif%;\
     /input %ls_base%;


/eval /def $[substr(ver(),0,1)!="5" ? "-b^i" :""] key_tab = /b_completion%;

