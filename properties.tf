; $Log: properties.tf,v $
; Revision 1.14  2002/12/02 11:56:48  mh14
; bug beim laden behoben
;
; Revision 1.13  2002/11/27 11:44:32  mh14
; aktualisierung der spielerproperties aller 24h bei tf-neustart
;
; Revision 1.12  2002/04/23 22:44:58  mh14
; mit parameter -n speichern setprop und delprop die propertyliste nicht mehr, sollte die sache etwas beschleunigen
;
; Revision 1.11  2001/11/27 21:35:21  mh14
; anpassung an first_connect hook, solange noch keine playerverzeichnisse garantiert existieren, wieder nur -c
;
; Revision 1.10  2001/11/06 19:29:41  nieten
; args, Leerzeichen war an falscher Stelle
;
; Revision 1.9  2001/11/06 19:22:51  nieten
; neues Makro /loadprops
; Properties werden im Spielerverzeichnis gespeichert
;
; Revision 1.8  2001/10/10 22:10:21  mh14
; Default-Konfiguration in .tf Files verschoben
;
; Revision 1.7  2001/10/04 23:07:00  olm
; /delprop hinzugefuegt
;
; Revision 1.6  2001/09/30 01:11:04  mh14
; bug behoben+ zeitspanne fuer /updateplayer verlaengert
;
; Revision 1.5  2001/09/15 19:47:27  mh14
; updateplayer per default verzoegtert
;
; Revision 1.4  2001/09/06 21:11:44  mh14
;  Log eingefuegt
;

/set properties_tf_version $Id$
/set properties_tf_author=Mesirii@mg.mud.de
/set properties_tf_requires=!lists.tf util.sfunc.tf util.trigger.tf
/set properties_tf_desc Makros fuer das Verwalten von Spielereigenschaften

; ********************* BEGIN CONFIG ********************
/add_to_hook first_connect /initplayer
; ********************* END CONFIG **********************

/def setprops= \
	/forEach ${world_character} kv /setprops2%;

/def setprops2=\
	/set p_%1=%-1%;

/addh info \
Die Properties enthalten alle moeglichen Werte des Spielers. Man kann sie sich am besten mit /who[ami] oder /who is name anzeigen lassen.@{N}\
Sie werden bei den Einschraenkungen der Wege verwandt und um spieler- bzw. gildenspezifische Makrodateien zu laden.
/addh see wege, dateisystem, mud_properties
/addh comm whoami, who
/addh properties see

/addh info \
Zeigt die eigenen Properties an.
/addh see properties
/addh comm who
/addh whoami comm

/defh whoami = /who am i %;
/addh info \
Zeigt entsprechend der Parameter die Properties an.@{N}\
'/who am i' zeigt die eigenen Properties an.@{N}\
'/who is name' zeigt die Properties des Spielers an.
/addh syn /who [am i|is name]
/addh who comm
/defh who = \
    /if ({*}=~"am i") \
        /let who=${world_character}%;\
    /elseif ({1}=~"is") \
	/let who=%2%;\
    /endif%;\
    /loadprops %who%;\
    /forEach %who kv /show_props


/def loadprops = \
; solange noch kein playerverz. garantiert da ist
;    /loadlist -q -c -p %1%;\
    /loadlist -q -c %1%;\
    /let tmp=%1%;\
    /test tmp:=%tmp%;\
    /if (isEmptyList(tmp)) \
        /loadlist -q -c %1%;\
    /endif


/def saveprops = \
   /if ("${world_character}"!~"") \
; solange noch kein playerverz. garantiert da ist
;	/savelist -q -c -p ${world_character}%;\
	/uaddtolist ${world_character} props_update_time $[time()]%;\
	/savelist -q -c ${world_character}%;\
    /endif%;

/def show_props = \
	/echo p_%1:%-1%;

/def setprop = \
;/echo Setting Property p_%1 to %-1 %;\
        /test getopts("n")%;\
	/set p_%1=%-1%;\
	/deletekeyandvalue ${world_character} %1%;\
	/addtolist ${world_character} %*%;\
	/if (!opt_n) \
	    /saveprops%;\
	/endif%;

/def getprop = \
	/getvalueof ${world_character} %1%;\
	/return value%;\

/defh initplayer = \
	/loadprops ${world_character}%;\
	/getvalueof ${world_character} props_update_time%;\
	/let props_update_time=%?%;\
	/setprops%;\
	/if (props_update_time=~error | time()- props_update_time>24*3600) \
	   /echo -aCcyan Aktualisiere Spielerproperties!%;\
	   /repeat -3 1 /updatePlayer%;\
	/endif%;\


/def delprop = \
        /test getopts("n")%;\
	/unset p_%1%;\
	/deletekeyandvalue ${world_character} %1%;\
	/if (!opt_n) \
		/saveprops%;\
	/endif%;

/addh info \
Enthaelt die mudunabhaengigen Makros die Properties betreffend.
/addh req lists.tf, loading.tf, util.tf
/addh changes Die Properties werden nun im Spielerverzeichnis gesichert. Aus Kompatibilitaetsgruenden wird beim Laden aber auch (noch) im Mud-Verzeichnis gesucht.
/addh see mud_properties, properties
/addh_fileinfo
