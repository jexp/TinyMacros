; $Log: vorsicht.tf,v $
; Revision 1.20  2003/12/09 16:24:07  thufhnik
; Fix in check_vorsicht, siehe auch kommentar unten, danke madness.
;
; Revision 1.19  2002/09/04 12:00:32  mh14
; mist vorsicht war immer noch nich wieder richtig, ein %; zuviel escaped
;
; Revision 1.18  2002/09/02 22:19:27  mh14
; kleiner Bugfix
;
; Revision 1.17  2002/09/02 10:02:35  mh14
; Beim Fliehen umgesetzte Vorsicht bleibt jetzt erhalten
;
; Revision 1.16  2002/06/13 08:28:56  mh14
; Fluchtrichtung fuer Nichtseher debuggt, evtl. Bug bei Umsetzten der Fluchtrichtung durch npcs ausgebaut
;
; Revision 1.15  2002/06/05 07:28:30  mh14
; vorsicht und fluchtrichtung jetzt wieder im playerfile gespeichert
;
; Revision 1.14  2002/04/28 01:43:23  mh14
; vorsicht an mapper
;
; Revision 1.13  2002/04/03 12:16:14  mh14
;  bug bei sl_flucht
;
; Revision 1.12  2002/02/10 22:36:38  mh14
; Statuszeilendoku
;
; Revision 1.11  2002/01/29 13:58:16  thufhnik
; check_vorsicht hat bisher nur {2} ausgewertet, jetzt {-1} als FR
;
; Revision 1.10  2002/01/28 18:01:59  olm
; Bugfix beim Aufruf von check_vorsicht, sorry.
;
; Revision 1.9  2002/01/26 02:57:20  olm
; Funktionalitaet, die die Werte bei Bedarf zuruecksetzt, vom Teddy-Trigger
; entkoppelt, um einen Aufruf z.B. aus dem Zauberer-Stabreport heraus zu
; ermoeglichen => neue Funktion /check_vorsicht
;
; Revision 1.8  2001/12/05 13:10:28  mh14
; tf_min_vorsicht als Fluchtvorsicht (ping-pong)
;
; Revision 1.7  2001/11/27 21:10:19  mh14
; sl_* angepasst an status.tf
;
; Revision 1.6  2001/10/19 14:37:46  mh14
; Aenderungen an der Statuszeile, diese ist jetzt Schneller, hoffentlich Problematik der parallelen threads (globale Variable (value) behoben
;
; Revision 1.5  2001/10/08 18:00:05  mh14
; Status Modul fluchtrichtung debuggt
;
; Revision 1.4  2001/10/07 20:00:13  mh14
; backslashes
;
; Revision 1.3  2001/10/07 19:11:23  mh14
; Statusmodule fuer vorsicht,fluchtrichtung,show_escape debuggt
;
; Revision 1.2  2001/10/05 15:05:25  nieten
; Log eingefuegt, Hilfetexte korrigiert
;

/set vorsicht_tf_version $Id: vorsicht.tf,v 1.20 2003/12/09 16:24:07 thufhnik Exp $
/set vorsicht_tf_author Dotz@mg.mud.de, Mesirii@mg.mud.de
/set vorsicht_tf_requires=lists.tf
/set vorsicht_tf_desc=beliebige Fluchtrichtung und Festsetzen der Vorsicht

/set sl_vorsicht_doc=Vorsicht/Fluchtvorsicht, ! wenn TF gesteuerte Vorsicht, Farben prozentuale Lebenspunkte
/def sl_vorsicht = \
  /init_var p_whimpie%;\
  /addsave p_whimpie%;\
  /set status_func_p_whimpie=(tf_vorsicht==1)?strcat(p_whimpie,"!",tf_min_vorsicht):strcat(p_whimpie,vorsicht_null?strcat("/",tf_min_vorsicht):"")%;\
  /set status_attr_p_whimpie=test(attr_ordered("p_whimpie",p_maxlp/3,"Cred",p_maxlp*2/3,"Cyellow","Cgreen"))%;\
  /set status_size_p_whimpie=(tf_vorsicht==1)?6 :3+(vorsicht_null?3 : 0)%;\
  /return status_var("p_whimpie","\$[%status_size_p_whimpie]")

/set sl_flucht_doc=Fluchtrichtung, blau: Mud und TF zusammengefasst,ggf. komprimiert, rot wenn keine
/def sl_flucht = \
  /init_var p_escape p_escape_tf%;\
  /addsave p_escape%;\
  /addsave p_escape_tf%;\
  /set status_func_p_escape=show_escape()%;\
  /set status_attr_p_escape=(strlen(p_escape)+strlen(p_escape_tf)>0)?"Cblue":"Cred"%;\
  /return status_var("p_escape",10)


/addh info \
Trigger, der die Vorsicht und Fluchtrichtung vom Teddy abfaengt und auf Uebereinstimmung mit den im TF gespeicherten Werten ueberprueft. Falls Sie nicht uebereinstimmen, werden sie auf die gespeicherten Werte zurueckgesetzt. (Es soll ja NPCs geben, die sowas tun.)
/addh var p_whimpie, p_escape
/addh t_whimpie trig

/def check_vorsicht = \
    /if (tf_vorsicht==1) /return%;/endif%;\
        /if ({1}=~"keine") \
	    /let temp_whimpie=0%;\
	/else \
	    /let temp_whimpie=%{1}%;\
	/endif%;\
	/if (temp_whimpie!~p_whimpie) \
	    /if (tf_vorsicht!=1 | (tf_vorsicht==1 & temp_whimpie!~tf_min_vorsicht)) \
	        /echo -p @{Cred}Vorsicht geaendert auf: %temp_whimpie @{n}, zuruecksetzen auf %p_whimpie%;\
;	        /echo vorsicht $[(tf_vorsicht==1)?tf_min_vorsicht:p_whimpie]%;\
	        /v %p_whimpie%;\
	    /endif%;\
	/endif%;\
	/let temp_escape=$[({2}=~"keine")?"":{-1}]%;\
	/if (temp_escape!~p_escape) \
	    /echo -p @{Cred}Fluchtrichtung geaendert auf: %temp_escape @{n}, zuruecksetzen auf %p_escape%;\
; 08.12.2003 madness
; ein %%; hinzugefueg, da sonst der erste + zweite befehl als ein befehl erkannt wird
	    /fl %p_escape%%;%p_escape_tf%;\
	/endif%;

/def -F -t"Vorsicht: ([0-9]+|keine)[.] Fluchtrichtung: (.+) $" -mregexp -agCyellow -p110 t_whimpie = \
        /test check_vorsicht({P1},{P2})

/addh info \
Trigger, der auf die Reaktion der Vorsicht im Mud anspringt und neben einer Ausgabe das Makro /testvorsicht ausfuehrt.
/addh t_vorsicht trig

/def -E(!tf_vorsicht) -F -t"Die Angst ist staerker als Du ... Du willst nur noch weg hier." -msimple -agCred t_vorsicht = \
    /testvorsicht%; 

/addh info \
Makro, das beim Anspringen der Vorsicht im Mud ausgefuehrt wird. Es testet, ob man grad im Kampf ist (%kampf>0) und ob die aktuellen LP kleiner als die gesetzte Vorsicht sind (%p_lp<=%p_whimpie). Dann wird der Kampfmodus deaktiviert (%kampf=-1) und die Vorsicht im Mud fuer 10 Sekunden auf 0 gesetzt, damit man dem PingPong-Effekt aus dem Weg geht. Anschliessend wird die in %p_escape_tf gespeicherte Fluchtrichtung ausgefuehrt, da die in %p_escape gespeicherte Flucht schon vom Mud ausgefuehrt wurde. (Alles von TF machen zu lassen kann bei LAG toedlich sein.)
/addh testvorsicht mak

/def testvorsicht2 = \
    /if (tf_vorsicht==1 & kampf>0 & p_lp<=p_whimpie) \
        /exec_vorsicht all%;\
    /endif%;

/add_to_hook points /testvorsicht2

/def testvorsicht = \
    /if (tf_vorsicht!=1 & kampf>0 & p_lp<=p_whimpie) \
        /exec_vorsicht%;\
    /endif%;

/def exec_vorsicht = \
    /if (vorsicht_null) \
        /set kampf=-1%;\
	/echo -aCred FLUCHT (%p_lp < %p_whimpie), Vorsicht auf %tf_min_vorsicht, in 10 Sek. wieder auf %p_whimpie.%;\
	/repeat -10 1 /if (p_whimpie==tf_min_vorsicht) /v %p_whimpie\%;/endif\%;/set kampf=0%; \
	/v %tf_min_vorsicht%;\
    /else \
	/set kampf=0%;\
	/echo -aCred VORSICHT (%p_lp < %p_whimpie)%;\
    /endif%;\
    /echo -aCred Flucht: $[show_escape()]%;\
    /if ({1}=~"all") /eval %p_escape%; \
    /elseif (mapper) \
       /map %p_escape%;\
    /endif%;\
    /eval %p_escape_tf%;


/addh info \
setzt die Variable %p_whimpie auf den angegebenen Parameter und setzt die Vorsicht im MUD. Falls die Vorsicht groesser als Null ist, wird sofort ein Test durchgefuehrt.
/addh v comm

/defh v = \
    /set p_whimpie=%{*-0}%;\
    /if (tf_vorsicht!=1) \
        vorsicht %p_whimpie%;\
    /else \
	vorsicht %tf_min_vorsicht%;\
	fluchtrichtung %tf_not_flucht%;\
    /endif%;\
    /if (p_whimpie>0) /testvorsicht%; /endif%;


/addh info \
Damit wird die Fluchtrichtung gesetzt. Der erste Befehl vor dem %; wird als Fluchtrichtung im Mud (%p_escape) benutzt, der Rest fuer die Fluchtrichtung im TF (%p_escape_tf). Dieser zweite Teil kann auch beliebige TF-Befehle enthalten sowie die speedwalk-Syntax (/walk) ,5o,2so nutzen.
/addh ex /fl o%;no%;ob%;/go haus%;,o,6sw
/addh see walk
/addh fl comm

/defh fl = \
        /if (tf_vorsicht==1 | p_state=~"spieler") \
	   /set p_escape=%;\
	   /set p_escape_tf=%*%;\
	   /echo -aCblue Fluchtrichtung: $[show_escape()]%;\
	   /return%;\
	/endif%;\
	/let off=$[strstr({*},"%;")]%;\
	/if (off==-1) \
	   /set p_escape_tf=%; \
	   /set p_escape=%*%; \
	   /if (fr_vorsicht_null) \
	       /set vorsicht_null=1%;\
	   /endif%;\
	/else \
	  /set p_escape=$[substr({*},0,off)]%;\
	  /set p_escape_tf=$[substr({*},off+2)]%;\
	   /if (fr_vorsicht_null) \
	       /set vorsicht_null=0%;\
	   /endif%;\
	/endif%;\
	fluchtrichtung %p_escape %;\
	/echo -aCblue Fluchtrichtung: $[show_escape()]%;

/def show_escape = \
	/set show_escape=%;\
	/test show_escape:=p_escape%;\
	/if (p_escape!~"" & show_escape!/"*%%;") \
	    /test show_escape:=strcat(show_escape,"%%;")%;\
	/endif%;\
	/test show_escape:=strcat(show_escape,p_escape_tf)%;\
	/if (p_escape_tf!~"" & show_escape!/"*%%;") \
	    /test show_escape:=strcat(show_escape,"%%;")%;\
	/endif%;\
	/test show_escape:=replace(",,",",",substr(shorten2(show_escape),1))%;\
	/if (show_escape=/"*,") /test show_escape:=substr(show_escape,0,-1)%;/endif%;\
	/result show_escape!~""?show_escape:"keine"%;

	
/addh info \
Enthaelt Befehle, Hooks und Trigger, die es erlauben, erstens dem Pingpongeffekt bei der Vorsicht aus dem Weg zu gehen und zweitens die Fluchtrichung beliebig komplex (TF-Befehle und speedwalk (siehe /walk)) zu machen.
/addh var p_escape, p_escape_tf, p_whimpie
/addh_fileinfo
