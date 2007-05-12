; $Log: mapper.tf,v $
; Revision 1.5  2002/05/03 14:09:25  mh14
; \ raus
;
; Revision 1.4  2002/04/23 22:38:59  mh14
; problem bei mapper_prefix und promptzaehlung behoben
;
; Revision 1.3  2002/04/16 12:17:11  mh14
; bug mit mapper-prefix raus
;
; Revision 1.2  2002/04/11 13:09:55  mh14
; verjuengt und hoffentlich debuggt, ausserdem jetzt auch hostangabe bei init_mapper moeglich und config-vars in config-sektion vorgezogen
;
;

/set mapper_tf_version $Id: mapper.tf,v 1.5 2002/05/03 14:09:25 mh14 Exp $
/set mapper_tf_author=Mesirii@mg.mud.de
/set mapper_tf_requires=!lists.tf way.tf util.trigger.tf(1.22)
/set mapper_tf_desc=Makros fuer das Zusammenspiel mit dem Mapper



; ********************* BEGIN CONFIG ********************

/addh info Liste der Attribute die aus dem Mud an den Mapper geschickt werden sollen
/addh ex mi_list=long npc author short
/addh mi_list cfg

/set mi_list=long npc
/addsave mi_list

/set mud_get_author=rohrhoere %*

/rename_mac mi mapinfo 

/addh info \
Port auf dem der Mapper laeuft (default 2000)
/addh mapper_port cfg

/set mapper_port=2000

/addh info \
Host auf dem der Mapper laeuft (default localhost)
/addh mapper_host cfg

/set mapper_host=localhost

/addh info \
Praefix der Eingaben markiert, die auch an den Mapper geschickt werden sollen
/addh mapper_prefix cfg

/set mapper_prefix=;


/addh info wenn auf 1 werden alle Bewegungen im Mud zum Erzeugen neuer Ausgaenge im Mapper benutzt. Da das aber leicht zu Fehlern fuehrt ist es standardmaessig ausgeschaltet.
/addh see walk
/addh automapper cfg

/set automapper=0
/addsave automapper

/addh info \
Liste von NPC-Namen, die nicht an den Mapper geschickt werden sollen, wenn sie sich im Raum befinden
/addh CFG_MAP_IGNORE_NPCS cfg

/set CFG_MAP_IGNORE_NPCS=Kruftur Intarbir Dschinn

/add_to_hook first_connect /def_mapper_send

/addh info \
Die Art, wie Ausgaenge der Raeume angegeben werden (als regexp), so dass in P2 alle Ausgaenge stehen
/addh mud_exits_output var
/set mud_exits_output=(keine sichtbaren Ausgaenge|sichtbare Ausgaenge: |sichtbaren Ausgang: |sicheren Ausgang: )([^\.]*\.)

/addh info eine Regexp um die Himmelsrichtungen aus %P2 zu holen
/addh mud_exits_regexp var
/set mud_exits_regexp=([a-z_]+)(, ?| und |\.?$)

; ********************* END CONFIG **********************

/addh info \
Makro dass den Send Hook fuer den Mapper Praefix definiert
/addh def_mapper_send hook

/def def_mapper_send = \
     /if (mapper_prefix!~"") \
       /def -F -w -p1000 -h"SEND %{mapper_prefix}*" -mglob h_mapper_send = \
	    /let param=\$[substr({*},1)]\%;\
	    /add_action_count -1\%;\
	    /map \%param\%;\
	    \%param%;\
     /endif%;

/addh info \
initialisiert eine Verbindung zur Mapper Application. Es wird eine World namens mapper angelegt und verbunden. Ausserdem wird die Variable mapper auf 1 gesetzt. Der Standardport ist 2000, Standardhost ist localhost
/addh var mapper, automapper
/addh syn /init_mapper [port [host]]
/addh ex /init_mapper 4711
/addh func addworld, connect, fg
/addh see mapper_host, mapper_port
/addh init_mapper comm

/defh init_mapper = \
     /addworld -Ttelnet mapper %{2-%{mapper_host}} %{1-%{mapper_port}}%;\
     /connect mapper%;\
     /fg -q -<%;\
     /def -q -t"*" -mglob -E(mapper) -wmapper t_grab_mapper = ${body_grab_mapper}%;\
     /set mapper=1%;\

/def body_grab_mapper = \
;	/echo ${world_name}%;\
	/if ({1}=~"0") \
	  /if (substr({-1},0,1)!~"/") \
	    /send -w%main_world %{-1}%; \
	  /else /eval -s0 %{-1}%;\
	  /endif%;\
	/endif%;\
	/echo From Mapper: %*%;

/addh info \
extrahiert aus den Anzeige der Ausgaenge die einzelnen Ausgaenge und erzeugt die Kommandos um im Mapper am aktuellen Punkt die Ausgaenge hinzuzufuegen. Es ist sinnvoll dieses Kommando an eine Tastenkombination zu binden.
/addh var mud_show_exits_command
/addh mak getroom2
/addh req customize.tf

/def mapexits = \
     /if (mapper) \
      /trig_grab -ag -d" " -E -B -C"%mud_show_exits_command" -M"/getroom2 %*"%;\
     /endif%;


/addh info \
Hilfsmakro fuer mapexits. Hier werden die einzelen Ausgaenge extrahiert und an den Mapper geschickt. Zur Ueberpruefung, ob es ein normaler Ausgang ist, wird die Liste ?comm_abbr benutzt.
/addh var mapper, fulldetail
/addh getroom2 mak

/def getroom2 = \
    /if (regmatch(mud_exits_output,fulldetail)) \
         /let map_exits=%{P2}%;\
	 /while (regmatch(mud_exits_regexp,map_exits)) \
	      /let map_exit_text=%P1%;\
; Abkuerzungen herausfinden
	      /getkeyofvalue comm_abbr %map_exit_text%;\
	      /let map_exit=%?%;\
	      /if (map_exit=~error) \
; Automatikrichtung (betrete/verlasse) suchen
	         /getvalueof xtramoves %map_exit_text%;\
		 /let map_exit=%?%;\
	         /if (map_exit!~error) \
		   /if (substr(map_exit,0,1)=~"0")) \
		     /let map_exit=%map_exit_text%;\
		   /else \
/echo		     /send -wmapper ar %map_exit_text%;\
		     /set map_exit=sent%;\
	           /endif%;\
		 /else \
		   /let map_exit=%error%;\
	         /endif%;\
	      /endif%;\
	      /if (map_exit!~error & map_exit!~"sent") \
;	          /echo %map_exit%;\
	          /send -wmapper ae %map_exit%;\
	      /else \
	          /input /send -wmapper asp -d0 -m? -p? %map_exit_text%;\
	      /endif%;\
	      /let map_exits=%PR%;\
	 /done%;\
    /endif%;\
    /if (mi_list!~"") /mapinfo%; /endif%;


/defh findroom = \
       /set fulldetail=%;\
       /def_psave_trig %;\
       /def_psave3_trig%;\
       /set nextmakro=/getexits2 %*%;\
       %mud_show_exits_command %;\

/def getexits2 = \
    /restricttoexit %;\
    /let getexits=findroom%;\
    /if (regmatch(mud_exits_output,fulldetail)==1) \
         /let p_long=$[replace("@{N}"," ",{P2})]%;\
;	/let p_long%;\
	 /while (regmatch(mud_exits_regexp,p_long)==1) \
	    /let getexits=%getexits %P1%;\
	    /let p_long=%PR%;\
	 /done%;\
    /endif%;\
    /let getexits%;\
    /send -wmapper %getexits

/addh info Die Liste mapinfo enthaelt die mudspezifischen kommandos, fuer das Extrahieren der gewuenschten Informatioenen
/addh mapinfo list

/createlist mapinfo
/addtolist mapinfo short mud_short_look
/addtolist mapinfo long mud_look_command
/addtolist mapinfo author mud_get_author
/addtolist mapinfo npc knuddel alle

/addh info \
entsprechend des uebergebenen Parameters, holt sich /mapinfo die mudspezifischen Kommandos aus der liste %mapinfo und laesst diese vom Mud ausfuehren. Der Ergebnistext wird von spezifischen Makros geparst, die dann die Werte an den Mapper senden
/addh var mapper, fulldetail, mapinfo
/addh req customize.tf, way.tf
/addh mapinfo comm
/defh mapinfo = \
    /if (mapper) \
       /if ({#})\
         /while ({#}) \
	   /getvalueof mapinfo %1%;\
	   /let mapinfo_cmd=%?%;\
	   /if (mapinfo_cmd!~error) \
	     /if (isVar(mapinfo_cmd)) \
		/test mapinfo_cmd:=%mapinfo_cmd%;\
	     /endif%;\
	     /trig_grab -agCblue -E -B -C"%mapinfo_cmd" -d" " -M/map%1%;\
	   /endif%;\
	   /shift%;\
	 /done%;\
       /elseif (mi_list!~"") \
          /mapinfo %mi_list%;\
       /endif%;\
    /endif%;

/addh info \
das Makro parst die Short, die als Ergebnis von /mapinfo erhalten wird
/addh mak restricttoexit,
/addh var mapper
/addh req way.tf
/addh mapshort mak
/def mapshort = \
    /let map_short=%fulldetail%;\
    /if (regmatch(mud_extract_short_regexp,map_short)) \
       /let map_short=%P1%;\
    /endif%;\
    /send -wmapper ai short %map_short%;\

/addh info \
das Makro parst die Long, die als Ergebnis von /mapinfo erhalten wird
/addh mak restricttoexit,
/addh var mapper
/addh req way.tf
/addh maplong mak

/def maplong = \
    /restricttoexit%;\
    /send -wmapper ai long %fulldetail%;\

/addh info \
das Makro parst die NPCS, die als Ergebnis von /mapinfo erhalten wird
/addh mak restricttoexit,
/addh var mapper
/addh req way.tf
/addh mapnpc mak

/def mapnpc = \
     /if (regmatch("Du knuddelst (.+)\\.",fulldetail)) \
	/test tokenize(", ",replace(" und ",", ",{P1}))%;\
	/let count=0%;\
	/let res=%;\
	/let map_npc=%;\
	/while (++count<=T0) \
	   /test map_npc:=artikel_entfernen(\{T%count\})%;\
	   /if (CFG_MAP_IGNORE_NPCS!/ strcat("*{",map_npc,"}*")) \
	     /if (strstr(res,map_npc)==-1) \
		/let res=%res %map_npc%;\
	     /endif%;\
	   /endif%;\
	/done%;\
     	/input /send -wmapper ai npc %res%;\
     /endif%;


/addh info \
das Makro parst den Autor, die als Ergebnis von /mapinfo erhalten wird
/addh mak restricttoexit,
/addh var mapper
/addh req way.tf
/addh mapauthor mak


/def mapauthor =\
;     /set fulldetail%;\
     /if (regmatch("Eine Stimme fluestert: Dieser Raum wurde von (.+) geschrieben",fulldetail)) \
          /send -wmapper ai author %P1%;\
     /endif%;

/addh info \
Makro dass einen Eintrag aus der NPCS Liste in den Mapper uebertraegt
/addh cmapnpc mak

/def cmapnpc = \
	/if (mapper==1) \
	/hgetlistvalueof npcs %*%;\
	/if (value!~error) \
	  /set temp_list_npc=%value%;\
	  /set cmapnpc=ci §§ NPC%;\
	  /getvalueof temp_list_npc name%;\
	  /if (value!~error) \
	    /set cmapnpc=$[strcat(cmapnpc," ",value)]%;\
	    /forEach temp_list_npc kv /cmapnpc2%;\
	    /send -wmapper %cmapnpc%;\
	  /endif%;\
	/endif%;\
	/endif%;

/def cmapnpc2 = /set cmapnpc=%{cmapnpc}§%{*}%;



/addh info wenn auf 1 wird der mapper mit Kommandos (Ausgaenge erstellen, Infos hinzufuegen, bewegen) versorgt
/addh mapper var

/addh info schickt den uebergebenen Text als Kommando an den Mapper
/addh var mapper
/addh map comm
/defh map = \
     /if (mapper) \
       /send -wmapper - %*%;\
     /endif%;

/addh info Makro das das uebergebene Attribut mit den zugehoerigen Informationen an das Kommando ai des Mappers schickt
/addh ai comm
/defh ai = /map ai %*%;

/addh info \
hier sind Befehle enthalten, die die Fernsteuerung des Mappers vom TF aus unterstuetzen. (<a href="map/Mapper.html">siehe auch dort</a>)@{N}\
Ausserdem sind auch in ?way.tf Anpassungen bei den Send Hooks vorgenommen worden, so dass Bewegung im Mud auch Bewegung auf dem Mapper hervorruft.
/addh tut Starten mit /init_mapper und dann bei bedarf /mapexits bzw. /mapinfo aufrufen.
/addh see mapper, automapper, mapinfo, mi, ai
/addh req customize.tf, way.tf
/addh version 1.01
/addh_fileinfo
