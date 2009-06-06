; $Log: untroom.tf,v $
; Revision 1.21  2004/04/17 15:24:58  chbr
; diverse Listen werden jetzt (hoffentlich) an der richtigen Stelle erzeugt
;
; Revision 1.20  2002/09/17 09:03:51  mh14
; mkdir_all bei saveroom
;
; Revision 1.19  2002/09/15 19:41:35  thufhnik
; add -> addh
;
; Revision 1.18  2002/09/15 13:59:29  mh14
; Saveroom portabel gemacht, Regionsweise Standarddetails pflegbar, temporaer einzelne Standarddetails, zu ignorierende Details setzbar
;
; Revision 1.17  2002/06/05 11:45:38  mh14
; typo in sort_most
;
; Revision 1.16  2002/04/24 13:25:40  nieten
; - /get_dp, /scan_most, /scan_detlist, /scan_akt_detlist, /scan_done_detlist geben return-Werte zurueck
; - deklinierte Woerter koennen zum Untersuchen in Nominativ gewandelt werden
; - kleinere Codeaenderungen hier und da
; - Korrekturen in der Doku
;
; Revision 1.15  2002/04/16 12:18:22  mh14
;  Gedankenstrich mit Leerzeichen davor sollte nicht mehr als Trennstrich angesehen werden
;
; Revision 1.14  2002/03/27 01:44:36  mh14
; dinge fuer mapper und saveroom ausgelagert in hook
;
; Revision 1.13  2001/11/28 11:01:46  mh14
; * todo macht jetzt reunt
; * input_todo hinzugefuegt (fuer keys)
; * saveroom checkt jetzt selbst die p_short fuer den Raumnamen zum Speichern
;
; Revision 1.12  2001/11/27 23:32:26  mh14
;  todo hilfe, todos fuer mehrere details, man beachte unt_action cvstf update -d fuer saveroom praktisch
;
; Revision 1.11  2001/11/27 21:40:44  mh14
; * saveroom erlaubt es die Detaillisten der Raeume nach
; Gebieten/Raeumen(p_short wenn kein Raumname) zu speichern
; * bei save_room=1 wird das 1x automatisch angeboten
; * wiederholte aktionen (mapper,save_room,send_idea) beim beenden des
; Raumuntersuchens nur noch einmal
; * NEU /todo fuer details die man spaeter noch untersuchen will, sie werden
; automatisch in der detailliste mitgefuehrt und zum Schluss mit angeboten
; * /catch_p_short nutzt /def_trig_grab, kschau um die p_short eines
; Gegenstandes/Raumes herauszubekommen, und kann diese an das uebergebene (-m)
; Makro weitergeben
; * xroom auf p_long geaendert
;
; Revision 1.10  2001/10/22 11:44:51  mh14
; highlighting debuggt, input_idee debuggt
;
; Revision 1.9  2001/10/10 22:10:21  mh14
; Default-Konfiguration in .tf Files verschoben
;
; Revision 1.8  2001/09/16 22:15:39  mh14
; hervorheben interessanter worte (z.b. fuer aktionen)
;
; Revision 1.7  2001/09/16 21:20:00  mh14
;  unterdrueckung der mudausgabe eingebaut
;
; Revision 1.6  2001/09/16 12:38:53  mh14
;  default_details (z.b. himmel, boden, wand, decke) hinzugefuegt
;
; Revision 1.5  2001/09/09 22:21:22  mh14
; Bug in Doku
;
; Revision 1.4  2001/09/06 21:11:44  mh14
;  Log eingefuegt
;

/set untroom_tf_version $Id$
/set untroom_tf_author=Mesirii@mg.mud.de
/set untroom_tf_requires=!lists.tf
/set untroom_tf_desc Hilfsprogramm zum manuellen Untersuchen von Raeumen, Ausfragen von Npcs usw.

; ********************* BEGIN CONFIG ********************
/add_to_hook connect /load_config -c untroom

/add_to_hook quit /save_most

/addh info \
Wenn gesetzt, wird die Ausgabe des Mud fuer den untersuche Befehl nicht mehr ausgegeben.
/addh untroom_hide_mud_output cfg

/set untroom_hide_mud_output=0


/addh info \
Wenn gesetzt, wird vom TF die Herkunft des gerade angezeigten Details angezeigt (als Hervorhebung im Originaltext).
/addh untroom_hide_mud_output cfg

/set show_origin=1


/addh info \
Setzt das Displayattribut der Herkunftsanzeige.
/addh see attributes, herkunftsanzeige, untroom.tf
/addh syn /set_style attribut
/addh set_style comm

/defh set_style = /set so_style=%{1-B}
/set_style Cgreen
/addsave so_style

/addh info \
Einschalten des Hervorhebens besonderer Worte (Aktionen) aus %highlight_untroom_actions im Ausgabetext.
/addh see do_highlight_untroom_actions, untroom_highlight_action_attr
/addh do_highlight_untroom_actions cfg

/set do_highlight_untroom_actions=1


/addh info \
Attribute fuer das Hervorheben besonderer Worte (Aktionen).
/addh untroom_highlight_action_attr cfg
/addh see highlight_untroom_actions, do_highlight_untroom_actions

/set untroom_highlight_action_attr=Cyellow


/addh info \
Liste der Aktionsworte zur Hervorhebung im Ausgabetext
/addh see untroom_highlight_action_attr, do_highlight_untroom_actions
/addh highlight_untroom_actions cfg

/addh info \
Enthaelt alle Details, die standardmaessig mit untersucht werden sollen. Sie werden als Details der P_LONG des Raumes betrachtet.
/addh see untroom
/addh default_details cfg

/createnewlist default_details

/createlist highlight_untroom_actions
/def add_action_word = /addtolist highlight_untroom_actions %*

/createlist highlight_untroom_actions


/addh info \
Speichert, ob nach Beenden des Untersuchens der aktuelle Raum gespeichert werden soll.
/addh save_room var

/set save_room=0


/add_to_hook first_connect /set_delay 2 5

/def done_mapper = \
    /if (mapper) \
        /map ai exa ja%;\
        /map ai exa_${world_character} 1%;\
        /map save%;\
    /endif

/def done_saveroom = \
    /input /saveroom

;/add_to_hook done_room /done_mapper
;/add_to_hook done_room /done_saveroom

; ********************* END CONFIG **********************

/def add_dp = /xaddtolist detail_parent&%*

/def get_dp = /return getvalueof("detail_parent", {*})


; startet das Untersuchen
/addh info \
Mit diesem Befehl wird das Untersuchen eines Raumes (neu) gestartet. Die vorhandenen Listen werden resettet. Es beginnt mit '%mud_look_command'.
/addh syn /untroom
/addh see %mud_look_command
/addh untroom comm

/defh untroom = \
    /echo In einigen MUDs ist automatisches Untersuchen per Skript \
      nicht erwuenscht, bitte darauf achten!%;\
    /createlist detail_parent%;\
    /createlist save_room_list%;\
    /set ideas=%;\
    /set mud_ideas_command=%mud_examine_in_room_idea%;\
    /set mud_typo_command=%mud_examine_in_room_typo%;\
    /set detail=%;\
    /set fulldetail=%;\
    /set last=p_long%;\
    /set unt_command=%mud_examine_in_room_command%;\
    /createlist detlist%;\
    /createlist akt_detlist%;\
    /createlist keep_detlist%;\
    /createlist done_detlist%;\
    /createlist origin%;\
    /forEach default_details k /do_add_default_detail%;\
    /createnewlist ignore_details%;\
    /forEach ignore_details k /do_add_ignore_detail%;\
    /if (do_highlight_untroom_actions) \
	/build_highlight_string%;\
    /endif%;\
    /set first_done=1%;\
    /set det_not_found=0%;\
    /del_schaue

/def add_default_detail = \
     /uaddtolist default_details %*

/def delete_default_detail = \
     /deletekeyandvalue default_details %*

/def add_ignore_detail = \
     /uaddtolist ignore_details %*

/def delete_ignore_detail = \
     /deletekeyandvalue ignore_details %*

/def clear_ignored = \
     /createlist ignore_details

/addh info \
Fuegt die in der Liste %default_details enthaltenen Details denen der P_LONG des Raumes hinzu.
/addh cfg default_details
/addh list default_details, detlist
/addh add_default_details mak

/def do_add_default_detail = \
    /test uaddtolist("detlist", {*}, "p_long")

/def do_add_ignore_detail = \
    /test uaddtolist("done_detlist", {*})

/addh info Fuegt fuer eine Region hinzu. Bei Details aus mehreren Worten Leerzeichen durch "_" ersetzen.
/addh syn /add_region_details region detail1 detail2 ...
/addh see remove_region_details
/addh ex /add_region_details ark nordwand ostwand suedwand westwand sonne wolken
/addh add_region_details comm

/def add_region_details = \
     /if ({#}>1) \
        /let detail_region=%1%;\
	/shift%;\
	/set details_region_%1=%*%;\
        /echo Fuege fuer Region %region Standarddetails: %* hinzu%;\
	/while ({#}) \
	   /test uaddtolist("default_details",replace("_"," ",{1}))%;\
	/done%;\
     /else \
        /info error Keine Details für Region %1 angegeben!%;\
     /endif

/addh info Entfernt Standarddetails für eine Region
/addh syn /remove_region_detail region
/addh ex /remove_region_detail ark
/addh see add_region_details
/addh remove_region_details comm
/def remove_region_details = \
     /if ({#}>1) \
        /echo Entferne Standarddetails für Region %1%;\
        /let detail_region=%1%;\
	/shift%;\
	/while ({#}) \
	   /test deletekeyandvalue("default_details",replace("_"," ",{1}))%;\
	/done%;\
     /else \
        /eval /remove_region_details %1 \%details_region_%1%;\
     /endif

/addh info \
Merkt sich Details in der Detailliste zum spaeteren Untersuchen. Praktisch wenn man mittendrin noch Details feststellt, die es lohnen, untersucht zu werden.
/addh ex /todo Ast
/addh todo comm

/defh todo = \
    /test uaddtolist("detlist", {*}, last_parent)%;\
    /reunt


/addh info \
Merkt sich Details in der Detailliste zum spaeteren Untersuchen. Praktisch wenn man mittendrin noch Details feststellt, die es lohnen, untersucht zu werden. Es koennen mehrere Details (jeweils ein Wort) zusammen uebergeben werden.
/addh ex /todos Ast Zweige Baum
/addh todos comm

/defh todos = \
    /while ({#}) \
        /test uaddtolist("detlist", {1}, last_parent)%;\
	/shift%;\
    /done

/def input_todo = \
    /if (kblen()) \
        /dokey DLINE%;\
    /endif%;\
    /test input("/todo ")

/defh untitem = \
    /echo In einigen MUDs ist automatisches Untersuchen per Skript nicht \
        erwuenscht, bitte darauf achten!%;\
    /createlist detail_parent%;\
    /set ideas=%;\
    /set mud_ideas_command=%mud_examine_item_idea%;\
    /set mud_typo_command=%mud_examine_item_typo%;\
    /set unt_item=%*%;\
    /set detail=%;\
    /set fulldetail=%;\
    /set last=%*%;\
    /createlist detlist%;\
    /createlist akt_detlist%;\
    /createlist done_detlist%;\
    /createlist origin%;\
    /set det_not_found=0%;\
    /set unt_command=%mud_examine_in_room_command%;\
    /unt %*%;\
    /set unt_command=%mud_examine_item_command

/defh ask_npc = \
    /createlist detail_parent%;\
    /set ideas=%;\
    /set mud_ideas_command=%mud_ask_npc_idea%;\
    /set mud_typo_command=%mud_ask_npc_typo%;\
    /set ask_npc=%1%;\
    /set detail=%;\
    /set fulldetail=%;\
    /set last=%*%;\
    /createlist detlist%;\
    /createlist akt_detlist%;\
    /createlist done_detlist%;\
    /createlist origin%;\
    /set det_not_found=0%;\
    /set unt_command=%mud_ask_npc_command%;\
    /unt %{-1}


;/def -E(!det_not_found) -t"*Dein Blick wendet sich der Umgebung zu.*" -mglob t_det_not_found = /set det_not_found=1%; /del_cmd unt %unt_item


/addh info \
Details koennen damit ein zweites Mal untersucht werden. Sie werden einfach aus der entsprechenden Liste geloescht.
/addh list done_detlist
/addh syn /unt2 detail
/addh see /unt, /untroom
/addh unt2 comm

/def unt2 = \
    /deletekeyandvalue done_detlist %*%;\
    /unt %*


/addh info \
Dieser Befehl untersucht das angegebene Detail und verarbeitet die Ausgaben des Muds entsprechend. Es werden alle Substantive herausgesucht und diese durch die entsprechenden Listen geschickt. Ausserdem wird das naechste Detail herausgesucht und angeboten.\
@{N}Es wird @{B}unt detail im raum@{n} benutzt!
/addh syn /unt detail
/addh see /untroom, /unt2
/addh unt comm

/def unt = \
    /if ((akt_det!~{*}) | (strlen(akt_det)!=strlen({*}))) \
	/xaddbtolist done_detlist&%akt_det%;\
    /endif%;\
    /unt3 %*

/def unt3 = \
    /if (scan_done_detlist({*})) \
	/echo -aB Detail schon untersucht!%;\
	/next_det%;\
    /else \
	/xaddbtolist done_detlist&%*%;\
	/set detail=%;\
	/set fulldetail=%;\
	/set last=%*%;\
	/set det_not_found=0%;\
	/del_unt %*%;\
    /endif

/def freeunt = \
    /unt3 %*


/addh info \
Trigger fuer Grabben des Mud-Outputs.
/addh cfg untroom_hide_mud_output
/addh def_save_trig trig

/def def_save_trig = \
    /def  -F -p100 $[(untroom_hide_mud_output)?"-ag":""] -t"*" save_trig = \
	/add_to_detail %%*

/ifdef (!isMacro("untroom_check_ignored")) untroom_check_ignored = /return 0

/def def_save3_trig = \
    /def -1 -F -p100 -mregexp -q -h"PROMPT" save3 = \
	/undef save_trig%%;\
	/find_words%%;\
	/next_det


/addh info \
Fuegt die einzelnen Zeilen der Mudausgabe zu einem String zusammen. Dabei werden Trennungsstriche am Zeilenende zusammengefuegt.
/addh var f%ulldetail, %detail
/addh add_to_detail mak

/def add_to_detail = \
    /let tmp=%*%;\
;    /if ((substr(tmp,0,1)!~"[")&(substr(tmp,strlen(tmp-1))!~"]")) \
    /set fulldetail=$[strcat(fulldetail, "@{N}", tmp)]%;\
    /if (tmp =/ "*[^ ]-") \
	/let tmp=$[substr(tmp, 0, -1)]%;\
	/set detail=$[strcat(detail, tmp)]%;\
    /else \
        /set detail=$[strcat(detail, tmp, "_")]%;\
    /endif%;\
;    /endif

/set newline=0
/set nl_time=1000


/addh info \
Sucht die Substantive aus dem String und speichert sie in den Listen. Wenn sie schon vorhanden waren, werden die alten geloescht.
/addh list akt_detlist, detlist
/addh var %fulldetail
/addh find_words mak

/def find_words = \
    /if (det_not_found==1) \
        /return%;\
    /endif%;\
    /let detail_save=%detail%;\
    /deletekeyandvalue detlist %last%;\
; Falls es doch noch in der Liste zu untersuchender Details vorhanden ist,
; wird es rausgeloescht
    /if (untroom_check_ignored()) /return%;/endif%;\
    /createlist prepended%;\
    /while (regmatch(noun_regexp, detail)) \
	/let akt=%P2%;\
	/let tmp=$[getvalueof("deklinations", tolower(akt))]%;\
	/if (tmp =~ error) \
	    /let tmp=$[tolower(akt)]%;\
	/endif%;\
; Suchen des Details in allen Detaillisten
	/if (!scan_akt_detlist(tmp)) \
	    /xaddtolist $[strcat("origin&", tmp, "&", akt)]%;\
	/endif%;\
	/let off=$[strstr(detail,akt) + strlen(akt)]%;\
	/set detail=$[substr(detail, off)]%;\
    /done%;\
    /let tmp=$[getkeyofvalue("save_room_list", fulldetail)]%;\
    /if (tmp !~ error) \
	/xaddtolist save_room_list&%tmp&!%last!%;\
    /else \
	/xaddtolist save_room_list&%last&%fulldetail%;\
    /endif%;\
    /if (!isEmptyList(akt_detlist)) \
	/add_dp %last&%fulldetail%;\
	/if (untroom_choose_nouns) \
	    /forEach akt_detlist k /choose_noun%;\
	/endif%;\
    /elseif (untroom_hide_mud_output) \
	/echo2 -p $[substr(detail_save, 0, -1)]%;\
    /endif%;\
    /set keep_detlist=$[strcat(substr(akt_detlist,0,-3), keep_detlist)]%;\
    /set detlist=$[strcat(substr(akt_detlist,0,-3), detlist)]%;\
    /createlist akt_detlist


/set untroom_choose_nouns=0
/set untroom_choose_noun_command=j

/def choose_noun = \
    /if (!untroom_choose_nouns) \
        /return%;\
    /endif%;\
    /let noun=%*%;\
    /echo choose_noun %noun%;\
    /if (isKey("prepended",noun) !~ error) \
        /deletekeyandvalue prepended %noun%;\
    /else \
	/echo %last %noun%;\
	/do_show_origin %noun %last%;\
	/echo Benutzen?%;\
	/let res=$[shread()]%;\
	/if (res =~ "q") \
	    /set untroom_choose_nouns=0%;\
	/else \
	    /if (res !~ untroom_choose_noun_command) \
	        /deletekeyandvalue akt_detlist %noun%;\
	        /if (!scan_done_detlist(noun)) \
	            /xaddbtolist done_detlist&%noun%;\
		/endif%;\
	    /endif%;\
	/endif%;\
     /endif


/addh info \
Sucht das naechste Detail aus den Listen, veranlasst die Anzeige der Herkunft des Details und gib '/unt detail' zum Bestaetigen an das tf.@{N}\
Dabei wird das /unt um eine maximale Zeit verzoegert (einstellbar, Default ist eine Sekunde).
/addh list detlist
/addh mak /do_show_origin
/addh var %akt_det, %last_parent, 
/addh see /unt, /show_origin, /set_delay
/addh next_det misc

/def next_det = \
    /let tmp=$[getfirstkey("detlist")]%;\
    /if (tmp =~ error) \
	/echo -aB Raum fertig untersucht!%;\
	/if (first_done) \
	    /toggle first_done%;\
	    /if (ideas !~ "") \
	        /input /send_idee %ideas%;\
	    /endif%;\
	    /eval_hook done_room%;\
	/endif%;\
    /else \
        /getvalueof detlist %tmp%;\
	/let ndet=%tmp%;\
	/let parent=%value%;\
	/deletekeyandvalue detlist %tmp%;\
	/set akt_det=%ndet%;\
	/set last_parent=%parent%;\
	/do_show_origin %akt_det %parent%;\
	/delay 0 /input /unt %ndet%;\
	/if (newline == 1) \
	    /delay %nl_time /dokey NEWLINE%;\
	/endif%;\
    /endif


/addh info \
Zeigt die Herkunft des Details an. Dies ist mit ?/show_origin auch ausschaltbar.
/addh var %show_origin
/addh see /show_origin
/addh mak /echo2
/addh cfg show_origin
/addh do_show_origin mak

/def do_show_origin = \
    /if (!show_origin) \
        /return%;\
    /endif%;\
    /let parent=%2%;\
    /let show_detail=$[getvalueof("origin", {1})]%;\
    /if (show_detail =~ error) \
        /let show_detail=%1%;\
    /endif%;\
    /let reg=$[strcat("(", show_detail, ")([^a-z'-]|$)")]%;\
;    /let reg=$[strcat("(",toupper(substr({1},0,1)),substr({1},1),")([^a-z'-]|$)")]%;\
    /let to_show=$[get_dp(parent)]%;\
    /if (to_show =~ error) \
        /return%;\
    /endif%;\
;/echo #%{show_detail}#%;\
    /let det_len=$[strlen(show_detail)]%;\
    /let off=$[strstr(to_show, show_detail)]%;\
    /let goff=%off%;\
; pre_show und post_show duerfen keine Wortbestandteile sein
; Sonderfaelle fuer Textanfang und -ende
    /if (off == 0) \
        /let pre_show=0%;\
    /else \
        /let pre_show=$[(substr(to_show,off-1,1) !/ "[^a-z'-]")]%;\
    /endif%;\
    /if (off+det_len >= strlen(to_show)) \
        /let post_show=0%;\
    /else \
        /let post_show=$[(substr(to_show,off+det_len,1) !/ "[^a-z'-]")]%;\
    /endif%;\
;/echo post#$[substr(to_show,off+det_len,1)]#%post_show%;\
;/echo pre#$[substr(to_show,off-1,1)]#%pre_show%;\
;/echo $[off+det_len] $[strlen(to_show)]%;\
    /while ((off>-1) & (pre_show | post_show)) \
	/let to_show=$[substr(to_show, off+det_len)]%;\
	/let off=$[strstr(to_show, show_detail)]%;\
	/let goff=$[goff + off + det_len]%;\
	/if (off == 0) \
	    /let pre_show=0%;\
	/else \
	    /let pre_show=$[(substr(to_show,off-1,1) !/ "[^a-z'-]")]%;\
	/endif%;\
	/if (off+det_len >= strlen(to_show)) \
	    /let post_show=0%;\
	/else \
	    /let post_show=$[(substr(to_show,off+det_len,1) !/ "[^a-z'-]")]%;\
	/endif%;\
;/echo post#$[substr(to_show,off+det_len,1)]#%post_show%;\
;/echo pre#$[substr(to_show,off-1,1)]#%pre_show%;\
;/echo $[off+det_len] $[strlen(to_show)]%;\
    /done%;\
    /if (off > -1) \
	/let to_show=$[strcat(\
	    substr(value,0,goff),\
	    "@{", so_style, "}",\
	    substr(value,goff,det_len),\
	    "@{n}",\
	    substr(value,goff+det_len))]%;\
    /endif%;\
    /if (do_highlight_untroom_actions) \
	/set highlight_untroom_text=%to_show%;\
;	/forEach highlight_untroom_actions k /highlight_actions%;\
	/highlight_actions%;\
	/let to_show=%highlight_untroom_text%;\
    /endif%;\
    /echo2 -p %to_show%;\
    /echo


/def highlight_actions = \
    /let result=%;\
    /if (build_highlight_string=~"") \
	/return%;\
    /endif%;\
    /while (regmatch(build_highlight_string, highlight_untroom_text)) \
	/test result:=strcat(result, {PL}, \
	    "@{", untroom_highlight_action_attr, "}", \
	    {P1}, "@{n}")%;\
	/test highlight_untroom_text:={PR}%;\
    /done%;\
    /test highlight_untroom_text:=strcat(result, highlight_untroom_text)

/def build_highlight_string = \
    /set build_highlight_string=%;\
    /forEach highlight_untroom_actions k /build_highlight_string2%;\
    /if (build_highlight_string !~ "") \
        /test build_highlight_string:=\
	    strcat("(", substr(build_highlight_string,0,-1), ")")%;\
    /endif%;\
    /return build_highlight_string

/def build_highlight_string2 = \
    /let first_char=$[substr(forEach_key, 0, 1)]%;\
    /test build_highlight_string:=strcat(build_highlight_string, \
        "[", tolower(first_char), toupper(first_char), "]",\
	substr(forEach_key,1), "|")

; Scan in der Most-Liste
/def scan_most = \
    /let tmp=$[getvalueof("most", {*})]%;\
    /if (tmp =~ error) \
        /return 0%;\
    /endif%;\
    /test ++tmp%;\
    /deletekeyandvalue most %*%;\
    /addtolist most %* %tmp%;\
    /return 1


; Version 2, vorhandene Details werden ueberschrieben.
; Scan in der detlist Liste
/def scan_detlist = \
    /if (isKey("detlist",{*}) !~ error) \
	/deletekeyandvalue detlist %*%;\
	/xaddtolist prepended&%*%;\
	/return 0%;\
    /endif%;\
    /return scan_done_detlist({*})


/addh info \
Damit werden alle Substantive, die in der zuletzt angezeigten Herkunftsanzeige auftauchen, als schon untersucht markiert. Das ist nuetzlich, wenn z.B. NPCs oder Spieler untersucht werden.@{N}\
Tip: Keybinding im Spielerfile machen.
/addh see herkunftsanzeige
/addh delete_sub_details comm 

/defh delete_sub_details = \
    /echo Entferne Subdetails.%;\
    /let tmp=$[getkeyofvalue("detlist", last_parent)]%;\
    /while (tmp !~ error) \
	/deletekeyandvalue detlist %tmp%;\
	/addbtolist done_detlist %tmp%;\
	/let tmp=$[getkeyofvalue("detlist", last_parent)]%;\
    /done%;\
    /nichts_unt

; Scan in der done_detlist Liste
/def scan_done_detlist = \
    /if (isKey("done_detlist",{*}) !~ error) \
        /return 1%;\
    /endif%;\
    /return scan_most({*})

; Scan in der akt_detlist Liste
/def scan_akt_detlist = \
    /if (isKey("akt_detlist",{*}) !~ error) \
        /return 1%;\
    /endif%;\
    /if (!scan_detlist({*})) \
        /xaddtolist akt_detlist&%*&%last%;\
	/return 0%;\
    /endif%;\
    /return 1
     

	  
/addh info \
Wenn die Most-Liste geaendert wurde, wird bei /quit dieses Makro aufgerufen, mit dem sie sortiert und abgespeichert wird.
/addh see most, /sort_most
/addh list most
/addh save_most mak

/def save_most = \
    /if (most_changed) \
        /sort_most%;\
	/savelist -c most%;\
	/set most_changed=0%;\
    /endif


/addh info \
Damit wird die Most-Liste sortiert. Die Eintraege haben einen Zaehler, wie haeufig sie in den Texten auftreten, und nach dieser Haeufigkeit werden sie sortiert.
/addh see most, /save_most
/addh list most
/addh sort_most mak

/def sort_most=\
    /createlist mostnumbers%;\
    /set smtemp_list=%;\
    /set smtemp_list2=%;\
    /forEach most kv /feSortMost%;\
    /let idx=1%;\
    /while (!isEmptyList(mostnumbers)) \
	/let mosttemp=$[strcat("mostnumber", idx)]%;\
	/if (isKey("mostnumbers",mosttemp) !~ error) \
	    /deletekeyandvalue mostnumbers %mosttemp%;\
	    /eval /set smtemp_list2=\%%mosttemp%;\
	    /set smtemp_list=$[strcat(smtemp_list2, substr(smtemp_list,3))]%;\
	/endif%;\
	/test ++idx%;\
;	/echo sort_most %idx%;\
    /done%;\
    /set most=%smtemp_list

/def feSortMost=\
    /if ({2} =/ "[0-9]*") \
        /let tmp=mostnumber%2%;\
	/if (iskey("mostnumbers",tmp) =~ error) \
	    /createlist %tmp%;\
	    /addtolist mostnumbers %tmp%;\
	/endif%;\
	/addtolist %tmp %1 %2%;\
    /endif


/addh info \
Verzoegert eine Aktion die angegebene Zeit.
/addh syn /delay zeit aktion
/addh func time()
/addh var %permit
/addh delay mak

/def delay = \
    /let plus_delay=%1%;\
    /let tdiff=$[time() - permit]%;\
;/echo if (%tdiff >= %plus_delay) /repeat -$[-tdiff+plus_delay]%;\
    /if (tdiff >= plus_delay) \
	/eval %{-1}%;\
    /else \
        /repeat -$[-tdiff+plus_delay] 1 /delay %*%;\
    /endif

/def init_msekwait = \
    /let t=$[time() + 1]%;\
    /while (time() < t) \
    /done%;\
    /let t=$[time() + 1]%;\
    /let tcount=0%;\
    /while (++tcount, time() < t) \
    /done%;\
    /echo %tcount


/def kill_del = \
    /let kill_del=$(/ps)%;\
;    /let kill_del%;\
    /if (regmatch("([0-9]+) +[0-9:]+ repeat +[0-9:]+ +1 /delay ",kill_del)) \
;	/echo %P1%;\
	/kill %P1%;\
    /endif


/addh info \
Verzoegert und fuehrt das '%mud_look_command' fuer den Raum aus. Vor der Raumbeschreibung wird durch /echo eine Leerzeile erzeugt.
/addh see %mud_look_command
/addh var %mud_look_command
/addh del_schaue mak

/def del_schaue = \
    /let tdiff=$[time() - permit]%;\
;    /echo del_schaue %tdiff%;\
    /if (tdiff >= 0) \
        /echo%;\
	/def_save_trig%;\
	/def_save3_trig%;\
	%mud_look_command%;\
	/rnd_delay%;\
;	/set permit=$[time()+pdelay]%;\
    /else \
        /repeat -$[-tdiff] 1 /del_schaue%;\
    /endif


/addh info \
Verzoegert und fuehrt das '/unt detail' fuer den Raum aus. Vor der Raumbeschreibung wird durch /echo eine Leerzeile erzeugt.
/addh del_unt mak

/def del_unt = \
    /let tdiff=$[time() - permit]%;\
;    /echo del_unt %tdiff%;\
    /if (tdiff >= 0) \
	/echo%;\
	/def_save_trig%;\
	/def_save3_trig%;\
	/eval %unt_command%;\
	/rnd_delay%;\
;	/set permit=$[time()+pdelay]%;\
    /else \
        /repeat -$[-tdiff] 1 /del_unt %*%;\
    /endif

/def unt_action = \
    /set detail=%;\
    /set fulldetail=%;\
    /set last=%*%;\
    /set det_not_found=0%;\
    /echo%;\
    /def_save_trig%;\
    /def_save3_trig%;\
    %*

/def del_cmd = \
    /let tdiff=$[time() - permit]%;\
    /if (tdiff >= 0) \
        /eval %*%;\
	/rnd_delay%;\
    /else \
	/repeat -$[-tdiff] 1 /del_cmd %*%;\
    /endif


/addh info \
Loescht das aktuelle Detail und holt das naechste zur Bearbeitung. Dafuer sollte auch ein Keybinding in der Spielerdatei existieren.
/addh see /delete_sub_details, /nichts
/addh nichts_unt

/defh nichts_unt = \
    /if (kblen()) \
        /dokey DLINE%;\
    /endif%;\
    /kill_del%;\
    /set done_detlist=$[strcat("<I>", akt_det, ">I<", done_detlist)]%;\
    /next_det


/addh info \
Loescht das aktuelle Detail. Dieser Befehl eignet sich zum Unterbrechen des Untersuchens. Mit /reunt kann das geloeschte Detail wieder geholt werden und mit dem Binding fuer /nichts_unt kann mit dem naechsten Detail fortgefahren werden.@{N}\
Dafuer sollte auch ein Keybinding in der Spielerdatei existieren.
/addh see /delete_sub_details, /nichts_unt, /reunt
/addh nichts_unt

/defh nichts = \
    /if (kblen()) \
        /dokey DLINE%;\
    /endif

/addh info \
Damit wird das letzte Detail (z.B. nach /nichts) wieder hergeholt und als /unt detail angezeigt.@{N}\
Dafuer sollte auch ein Keybinding in der Spielerdatei existieren.
/addh see /nichts, /nichts_unt, /delete_all_subdetails
/addh reunt comm

/def reunt = \
    /eval /input /unt %akt_det


/addh info \
Wechselt zwischen den zwei Zustaenden der Variablen 'show_origin', also der Herkunftsanzeige.@{N}\
Wuerde sich ggf. ein Keybinding im Spielerfile lohnen.
/addh see /do_show_origin, herkunftsanzeige
/addh var %show_origin
/addh show_origin comm

/defh show_origin = \
    /toggle show_origin%;\
    /echo Herkunftsanzeige ist $[show_origin ? "ein" : "aus"]geschaltet.


/addh info \
Fuegt das letzte nicht vorhandene Detail in eine Liste ein, die dann nach dem Untersuchen des Raumes mit /send_idee abgeschickt wird.@{N}\
Es wuerde sich lohnen, ein Keybinding auf dieses Kommando zu machen.
/addh see /send_idee, herkunftsanzeige
/addh var %ideas
/addh detail_idee comm

/defh detail_idee = \
    /set ideas=$[strcat(ideas, " ", last, ",")]%;\
    /echo '%last' an Ideenliste angehaengt.


/addh info \
Mit diesem Kommando wird ein Typo in der letzten Herkunftsanzeige gemeldet. Dazu wird der vorbereitete Text in die Kommandozeile geschrieben.@{N}\
Es wuerde sich lohnen, ein Keybinding auf dieses Kommando zu machen.
/addh see herkunftsanzeige
/addh inputtypo comm

/defh inputtypo = \
    /if (kblen()) \
        /dokey DLINE%;\
    /endif%;\
    /if (last_parent =~ "p_long") \
	/input /typo long - %;\
    /else \
	/input /typo detail %last_parent - %;\
    /endif


/addh info \
Mit diesem Kommando wird eine Idee fuer ein fehlendes Detail in der letzten Herkunftsanzeige gemeldet. Dazu wird der vorbereitete Text in die Kommandozeile geschrieben.@{N}\
Es wuerde sich lohnen, ein Keybinding auf dieses Kommando zu machen.
/addh see herkunftsanzeige
/addh input_idee comm

/defh input_idee = \
    /if (kblen()) \
        /dokey DLINE%;\
    /endif%;\
    /input /idee Detail %last (aus %last_parent) -%;\

/def typo = /eval %mud_typo_command %*%; /reunt

/def idee = /eval %mud_ideas_command %*%; /reunt


/addh info \
Schickt die Liste mit fehlenden Details ab. Immer dran denken, ich vergesse es immer.
/addh see herkunftsanzeige, /detail_idee, /show_idee
/addh send_idee comm

/defh send_idee = \
    /if ({#}) \
	/let ideen=%*%;\
    /else \
	/let ideen=$[substr(ideas, 0, -1)]%;\
    /endif%;\
    /let tmp=Folgende Details waeren noch schoen: %ideen%;\
    /echo sending: %tmp%;\
    /eval %mud_ideas_command %tmp%;\
    /set ideas=


/addh info \
Zeigt die Liste mit den fehlenden Details an. 
/addh see herkunftsanzeige, /detail_idee, /send_idee
/addh show_idee comm

/defh show_idee = \
    /let ideen=$[substr(ideas, 0, -1)]%;\
    /eval /echo %mud_ideas_command %ideen


/addh info \
Die Herkunftsanzeige zeigt an, aus welcher Detailbeschreibung das aktuell zu untersuchende Detail stammt. Dabei wird das Detail entsprechend des angegebenen Stiles hervorgehoben.@{N}\
Die Herkunftsanzeige kann mit ?/show_origin ein- und ausgeschaltet werden.
/addh see /show_origin, set_style, /typo, /detail_idee
/addh herkunftsanzeige see


/addh info \
Fuegt das aktuelle Detail zu der Liste der zu uebergehenden Worte hinzu. Das naechste Detail wird dann zum Untersuchen angeboten.@{N}\
Es wuerde sich lohnen, ein Keybinding auf dieses Kommando zu machen.
/addh see /reunt, /typo, /nichts, /nichts_unt, most
/addh list most
/addh add_most comm

/defh add_most = \
      /uaddtolist most %akt_det 1%;\
      /set most_changed=1%;\
      /echo -p @{B}%akt_det@{n} zur Most-Liste hinzugefuegt%;\
      /nichts_unt

/def del_most = \
     /deletekeyandvalue most %*%;\
     /set most_changed=1%;\
     /echo -p @{B}%*@{n} aus Most-Liste geloescht%;

/addh info \
Stellt die Zeit zwischen zwei Untersuche-Befehlen ein.
/addh syn /set_delay Zeit in Sekunden (Default 1)
/addh var %pdelay
/addh set_delay comm

/defh set_delay = \
    /set pdelay_min=%{1-1}%;\
    /set pdelay_max=%{2-%pdelay_min}%;\
    /rnd_delay

/def rnd_delay = \
;/echo Zeit: $[time()-rnd_delay]%;\
    /set rnd_delay=$[time()]%;\
    /set pdelay=$[rand(pdelay_min, pdelay_max)]%;\
;/set pdelay%;\
    /set permit=$[time() + pdelay]

/set gegend=
/set raumname=

/set mud_short_look=kschau

/def catch_p_short = \
    /test getopts("m:")%;\
    %mud_short_look %*%;\
    /trig_grab -n1 -ag -d -M"%opt_m" -vp_short

/def saveroom = \
    /if ({#} > 1) \
        /set gegend=%1%;\
	/set raumname=%{-1}%;\
    /elseif ({#}==1) \
        /set raumname=%*%;\
    /else \
        /catch_p_short -m"/saveroom %{gegend-wo?}"%;\
	/return%;\
    /endif%;\
    /test gegend:=shread("Gegend: ",gegend)%;\
    /test raumname:=shread("Raumname: ",raumname)%;\
    /echo Gegend: %gegend, Raumname: %raumname%;\
    /if (gegend!~"" & raumname!~"") \
	/savelist -q -c save_room_list%;\
	/let regiondir=%{makdir}${world_host}/rooms/%{gegend}%;\
;/let regiondir%;\
	/mkdir_all %regiondir%;\
	/let counter=%;\
	/file_exists %regiondir/%{raumname}.list%;\
	/while ({?}) \
	    /test ++counter%;\
	    /file_exists %regiondir/%{raumname}%{counter}.list%;\
	/done%;\
;/echo /sys mv %{makdir}${world_host}/save_room_list.list "%{makdir}${world_host}/rooms/%{gegend}/%{raumname}%{counter}.list"%;\
        /let orgfile=%{makdir}${world_host}/save_room_list.list%;\
	/let newfile=%regiondir/%{raumname}%{counter}.list%;\
	/test sys_mv(orgfile,newfile)%;\
;/echo debug1%;\
	/if ({?}) \
;/echo debug2%;\
	    /echo Raum "%raumname%counter" in "%gegend" gespeichert%;\
;/echo debug3%;\
	/else \
;/echo debug4%;\
	    /echo Fehler beim Speichern von Raum "%raumname%counter" in "%gegend"%;\
;/echo debug5%;\
	/endif%;\
    /else \
;/echo debug6%;\
	/echo keine Gegend (%gegend) gesetzt oder kein Raumname (%raumname) angegeben!%;\
;/echo debug7%;\
    /endif%;\
;/echo debug8%;


/def loadroom = \
    /if ({#}>1) \
        /set gegend=%1%;\
	/set raumname=%{-1}%;\
    /elseif ({#}==1) \
        /set raumname=%*%;\
    /endif%;\
    /if (gegend!~"" & raumname!~"") \
	/loadlist -c -drooms/%gegend %raumname%;\
	/echo Raum %raumname in %gegend geladen%;\
    /else \
	/echo Keine Gegend gesetzt oder kein Raumname angegeben!%;\
    /endif

;/defh set_delay = /set pdelay=%{*} %; /set permit=$[time()+pdelay] %;



/addh info \
Erweitert die Liste der bekannten Deklinationen. Falls waehrend des untersuchens eins dieser deklinierten Worte auftaucht, wird automatisch sein Nominativ untersucht.@{N}\
Eine Aenderung der Liste wird erst beim naechsten /untroom wirksam.
/addh syn /add_deklination <dekliniertes Wort> <Nominativ>
/addh ex /add_deklination waenden waende
/addh list deklinations
/addh add_deklination comm

/defh add_deklination = \
    /if ({#} != 2) \
        /help add_deklination%;\
	/return%;\
    /endif%;\
    /let tmp1=$[tolower({1})]%;\
    /let tmp2=$[tolower({2})]%;\
    /let res=$[getvalueof("deklinations", tmp1)]%;\
    /if (res =~ error) \
        /addtolist deklinations %tmp1 %tmp2%;\
    /elseif (tmp2 !~ res) \
        /echo '%tmp1' ist bereits mit dem Nominativ '%res' gespeichert.%;\
	/echo Soll '%res' durch '%tmp2' ersetzt werden? (j/[n])%;\
	/if (shread() =/ "j") \
	    /uaddtolist deklinations %tmp1 %tmp2%;\
	    /echo Ok, ersetzt.%;\
	/else \
	    /echo Ok, nicht ersetzt.%;\
	/endif%;\
    /endif



/addh info \
Das ist die Datei mit dem Untersuche-Programm in tf. Bitte die Hilfe zu /untroom, /unt, und ggf. den restlichen Kommandos lesen.
/addh changes 1.01 Fehler in /sort_most behoben.
/addh changes 1.02 Neue Liste 'origin', in der die Originalform der Details gespeichert wird, da in den englischen Muds ein Grossbuchstaben am Anfang nicht das Original wiederherstellt.@{N}\
	Ich hatte an zwei Stellen vergessen, 'schaue' durch %mud_look_command zu ersetzen, was hiermit geschehen ist.@{N}\
	1.03 /do_show_origin wurde debuggt: Der Fehler, dass Teilworte markiert wurden, tritt jetzt nicht mehr auf.@{N}\
	1.04 Beim Abschluss der Untersuchung werden die gesammelten Ideen zum Absenden vorgeschlagen.
/addh req tf4.0, loading.tf, lists.tf, util.tf(1.37), most.list.tf, help.tf customize.tf

/addh tut \
Das Untersuchen eines Raumes wird mit /untroom gestartet.@{N}\
/unt untersucht das angegebene Detail.@{N}\
/unt2 untersucht das angegebene Detail nochmal, auch wenn es schon einmal als untersucht markiert wurde.@{N}\
Wenn man beim Untersuchen ist, kann man: (meine Bindings)@{N}\
mit # (/nichts_unt) das aktuelle Detail verwerfen und zum naechsten gehen@{N}\
mit ^i (/detail_idee) das vorhergehende Detail der Ideenliste hinzufuegen@{N}\
/show_idee zeigt die bisher gesammelten Ideen@{N}\
/send_idee schickt sie ab@{N}\
mit ^a (/add_most) das aktuelle Detail zur Ignoriere-Liste hinzufuegen@{N}\
mit ^d (/delete_sub_details) koennen alle Details, die im gerade angezeigten Text vorkommen, als schon untersucht markiert werden!!@{N}\
mit /inputtypo kann ein typo fuer den aktuell angezeigten Text abgesetzt werden@{N}\
falls man die Zeile geloescht hat, mit /reunt das aktuelle Detail zurueckholen.@{N}\
Sonstiges:@{N}\
Das Attribut fuer das Einfaerben in der Herkunftsanzeige wird mit '/set_style attrib' gesetzt.@{N}\
Diese Version hat die Ignoriere-Liste (most) erweitert; in ihr steht jetzt auch, wie oft diese Details vorgekommen sind. So kann die Liste sortiert werden, so dass die haeufigsten Details vorn stehen und nicht so lange gesucht werden. Das Sortieren und _Abspeichern_ der Ignoriere-Liste erfolgt mit /save_most. Da man das meist vergisst, hab ich das /quit ueberschrieben ;)@{N}\
@{N}\
Weitere Features: Am Zeilenende getrennte Worte werden erkannt, nur nicht in der Herkunft angezeigt.@{N}\

/addh_fileinfo
