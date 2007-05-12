; $Log: ari.tf,v $
; Revision 1.6  2002/02/10 22:36:40  mh14
; Statuszeilendoku
;
; Revision 1.5  2001/11/27 20:42:48  mh14
; sl_* angepasst an status.tf
;
; Revision 1.4  2001/10/19 14:37:46  mh14
; Aenderungen an der Statuszeile, diese ist jetzt Schneller, hoffentlich Problematik der parallelen threads (globale Variable (value) behoben
;
; Revision 1.3  2001/10/07 18:36:17  mh14
; Status Module fuer ari,ari_list, ariliste ueber Variable ari_list bezeichnet
;
; Revision 1.2  2001/10/05 00:21:49  nieten
; Log eingefuegt
;

/set ari_tf_version $Id: ari.tf,v 1.6 2002/02/10 22:36:40 mh14 Exp $
/set ari_tf_author=Mesirii@mg.mud.de
/set ari_tf_requires=lists.tf
/set ari_tf_desc Makros fuer Ari (Fernwaffen)

; /ari_add st wirf stein
; /ari_add stm wirf stein nach %monster
; durch attack_busy nur 5x pro runde moeglich
; /ari_add qu 5 schleuder qualle 
/def ari_add = \
	/createnewlist %aris_list%;\
	/uaddtolist %aris_list %* %;

/def ari_get = /getvalueof %aris_list %* %;

; ari_set 5stm - 5 Steine auf Monster geworfen
/def ari_set = /let param=%* %;\
	  /if (regmatch("^([0-9]+)",param)) \
	     /set ari_count=$[0+{P1}]%;\
	     /let param=%PR%;\
	  /else \
	     /set ari_count=1%;\
	  /endif%;\
	  /set ari_name=%param%; \
	  /ari_get %param %;\
	  /if (value=~error) /ari_set_single %param %;\
	  /else /ari_set_single %value %; \
	  /endif %;

; ari_init [0|1]
/def ari_init = \
	/set ari_use=%{1-1}%;\
	/if (!ari_use) /return%; /endif%;\
	/set ari_ws=0%; /set ari_steine=0%;\
	/set ari_attack_count=0%;\
	/ari_list%;

; automatisches werfen
/def ari_throw = \
	/if (kampf>0 & (ari_list!~""|ari_count>0)) \
	   /set ari_attack_count=0%;\
	   /repeat -S 10 /ari_use%;\
	/endif%;

; /ari_set_single [max_count] actions
; genutzt von ari_set (aus Liste aris)
/def ari_set_single = \
          /if ({1}=/"[0-9]") \
             /set ari_max_attack_count=$[0+{1}]%;\
             /shift%;\
          /else /set ari_max_attack_count=6%;\
          /endif%;\
          /set ari=%* %;\
	  /ari_list %;

; /ari_set_list 5st 10ws 100est
/def ari_set_list = /set ari_list=%*%;/ari_list

; Anzeige
/def ari_list = \
   /echo -p Ari: @{B}%ari_name@{n} Stueck %ari_count [%ari_max_attack_count] (%ari_list)
; Kommando: %ari

; einzelne Ausfuehrung
/def ari_use = /if (ari_list!~"" & ari_count==0) \
		 /let off=$[strchr(ari_list," ")]%;\
	 	 /if (off>-1) /ari_set $[substr(ari_list,0,off)]%;\
		   /set ari_list=$[substr(ari_list,off+1)]%;\
	         /else \
		    /ari_set %ari_list%; /set ari_list=%;\
		 /endif%;\
	      /endif%;\
	      /if (ari_count!=0) \
              /if (ari_attack_count<ari_max_attack_count) \
	        /test --ari_count%;\
	        /test ++ari_attack_count%;\
	        /eval %ari %;\
              /endif%;\
	      /endif%;
/set sl_ari_doc=Naechste Ari, die benutzt wird Anzahl und Abkuerzung
/def sl_ari = \
   /init_var ari_count ari_name%;\
   /set status_attr_ari_count=(ari_count>0?"Cgreen":"n")%;\
   /set status_attr_ari_name=(ari_count>0?"Cgreen":"n")%;\
   /return strcat(status_var("ari_count",-2)," ",status_var("ari_name",2))

/set sl_ari_list_doc=Ariliste, die benutzt wird, jeweils Anzahl und Abkuerzung
/def sl_ari_list = \
   /init_var ari_list%;\
   /set status_size_ari_list=max(1,min(7,strlen(ari_list)))%;\
   /return strcat(sl_ari()," '[' ",status_var("ari_list","\$[%status_size_ari_list]","n")," ']'")

/addh_fileinfo
