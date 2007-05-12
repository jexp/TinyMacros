; $Log: util.abbrev.tf,v $
; Revision 1.8  2001/11/27 21:34:06  mh14
; anpassung an first_connect hook
;
; Revision 1.7  2001/10/10 22:10:21  mh14
; Default-Konfiguration in .tf Files verschoben
;
; Revision 1.6  2001/09/09 19:16:59  mh14
; requires bereinigt
;
; Revision 1.5  2001/09/09 19:09:41  mh14
; help_de.list
;
; Revision 1.4  2001/09/06 21:11:44  mh14
;  Log eingefuegt
;

/set util_abbrev_tf_version $Id: util.abbrev.tf,v 1.8 2001/11/27 21:34:06 mh14 Exp $
/set util_abbrev_tf_author=Mesirii@mg.mud.de
/set util_abbrev_tf_requires lists.tf util.sfuncs.tf
/set util_abbrev_tf_desc Abkuerzungen, die in multiple Mud-Kommandos expandiert werden

; ********************* BEGIN CONFIG ********************
/addh info \
Diese Liste enthaelt die definierten Abkuerzungen und deren Liste von Inhalten.
/addh abbreviations list

/set abbrev_list_name=abbreviations
/set abbrev_list_location=-c

/add_to_hook first_connect /loadnamedlist abbrev
; ********************* END CONFIG **********************


/addh info \
Definiert eine Abkuerzung, indem sie sie in die Liste ?abbreviations eintraegt. Danach wird jeder Text, der ^abkuerzung enthaelt und ans Mud geschickt werden soll, vervielfaeltigt und jeweils ein Eintrag der Abkuerzung eingetragen.
/addh ex /def_abbrev freunde mesirii strohalm@{N}\
	 Damit wird aus 'teile ^freunde mit test'@{N}\
	-> 'teile mesirii mit test' und@{N}\
	-> 'teile strohalm mit test'@{N}\
Pausen koennen mit '/def_abbrev zauber *3 schutz hand' eingestellt werden (3 Sekunden) oder mit 'zaubere ^3zauber' beim Ausfuehren angegeben werden. Dabei sind die Pausen beim Ausfuehren vorrangig. Dank Strohalm sind jetzt durch _ statt Leerzeichen getrennte Worte in den Abkuerzungen moeglich; diese werden bei der Umsetzung wieder durch Leerzeichen ersetzt.
/addh def_abbrev comm

/defh def_abbrev = \
	/let key=%1%;\
	/let val=%-1%;\
	/uaddtolist abbreviations %*%;


/addh info Loescht eine Abkuerzung
/addh ex /undef_abbrev freunde
/addh undef_abbrev comm
/defh undef_abbrev = \
	/deletekeyandvalue abbreviations %*%;\
;	/undef h_abbrev_%*%;	

/addh info \
Dieser Send-Hook faengt die Abkuerzungen ab und ersetzt sie wie bei /def_abbrev beschrieben.
/addh list abbreviations
/addh mak tokenize
/addh h_abbrev hook

/def -h"SEND (^| )\\^[0-9]*[^ ]+($| )" -mregexp -p20 h_abbrev = \
	/if (regmatch("(^| )[-^]([^ ]+)( |$)",{*}))\
	/let abbrev=^%P2%;\
	/let key=%P2%;\
	/let abbrev_pause=0%;\
	/if (regmatch("([0-9]+)(.+)",key)) \
	  /let abbrev_pause=$[+{P1}]%;\
	  /let key=%P2%;\
	/endif%;\
	/getvalueof abbreviations %key%;\
	/if (value=~error) \
	  /msend -w %*%;\
	/else \
	  /test tokenize(" ",value)%;\
	  /let tcount=$[T0+1]%;\
	  /let tcountmin=1%;\
	  /if (regmatch("\\*([0-9]+)",T1)) \
	     /let tcountmin=2%;\
	     /if (abbrev_pause==0) \
	     /let abbrev_pause=$[+{P1}]%;\
	     /endif%;\
	  /endif%;\
	  /let res=%;\
	  /let repeat_abbrev=0%;\
	  /while (--tcount>=tcountmin) \
	     /test res:=\{T%{tcount}\}%;\
	     /repeat -%repeat_abbrev 1 $[replace(abbrev,replace("_"," ",res),{*})]%;\
	     /let repeat_abbrev=$[repeat_abbrev+abbrev_pause]%;\
	  /done%;\
	/endif%;\
	/endif%;

/addh_fileinfo
