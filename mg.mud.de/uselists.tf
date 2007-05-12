; $Log: uselists.tf,v $
; Revision 1.5  2001/10/07 18:29:53  mh14
; teile extrahiert nach spell.tf ari.tf weapon.tf
;
; Revision 1.4  2001/09/06 21:11:44  mh14
;  Log eingefuegt
;

/set uselists_tf_version $Id: uselists.tf,v 1.5 2001/10/07 18:29:53 mh14 Exp $
/set uselists_tf_author=Mesirii@mg.mud.de
/set uselists_tf_requires=lists.tf util.tf
/set uselists_tf_desc Anwendungen der Listen z.b. Tanken, Spells, Waffen

;variablen
; hands - freie haende
; value - ergebnis von deref
; whands - haende fuer waffe
; weapons - liste der waffen
; weapon - eingestellte waffe
; gezueckt - ja/nein
; shields - liste der schilde
; shield - eingestelltes schild
; getragen - schild getragen (ja/nein)
; armors - Liste der Ruestungen
; armor - eingestellte Ruestung
; monsters - Liste der Monster
; monster - eingestelltes Monster
; demons - Liste der Daemonen
; demon - eingestellter Daemon
; sprueche - Liste der Zaubersprueche
; zauber - eingestellter Spruch, dafuer:
; zmp - benoetigte Magiepunkte
; zsek - gesperrte Zeit
; zhands - benoetigte Haende
; kampf - im Kampf !=0 ansonsten ==0
; waffenwechsel !!
; kills - liste fuer kills

/loadlist -c tanken
/def addtank = /addtolist tanken %* %;
;/createlist tanken
;/addtolist tanken kmoron 50 campari


; /settank lpmp speise/getraenk|aktion
/def settank2 = /set anz=%1 %;/set tanke %{-1} %; 

/def tank = /if ({*}!~"") \
	        /if ({*}=/"[0-9]*") \
	          /settank2 %*%;\
	        /else  /set tanke=%*%;\
	        /endif%;\
	    /else \
	      /getvalueof tanken %lastpoint%; \
	      /if (value=~error) /echo nichts zum Tanken gefunden! %; /break%;\
	      /else /settank2 %value %; /endif%;\
	   /endif%;\
	      /if (substr(lastpoint,0,1)=~"K" | {*}=/"[0-9]*") \
		 /let diff=$(/max $[p_maxlp-p_lp] $[p_maxmp-p_mp])%;\
		 /let diff=$[diff+20] %;\
		 /let diff=$[diff/anz] %;\
		 /repeat -0 %diff kaufe %tanke %;\
	      /else /eval %tanke%; /endif %;

;/createlist pubs
/loadlist -c pubs
/def deltank = \
	/loadlist -c pubs%;\
	/getnode %1%;\
	/let pub_node=%value%;\
	/getdlistvalueof pubs %pub_node%;\
	/if (value=~error) /echo keine Tanke an Knoten %1 gefunden.%;\
	/else \
	   /set pub_temp=%value%;\
	   /getdvalueof pub_temp %2%;\
	   /if (value=~error) /echo Tanke %2 nicht an Knoten %1 gefunden.%;\
	   /else /echo  Tanke %2 von Knoten %1 geloescht.%; /endif%;\
	   /addlisttolist pubs %pub_node %pub_temp%;\
	/endif%;
; Subliste Kneipe:
; lp mp kosten anzahl bringezeit tankzeit art alc drink eat name
;                                         g getraenk a alk s speise
; 					      fuellung
; wenn name mit _beginnt, dann ist das ein zu evaluierendes codestueck
/addh info \
Dieses Makro dient zum Hinzufuegen und Editieren einer Tanke zu einem Knoten. Es wird ohne Parameter aufgerufen, alle Groessen werden abgefragt.@{N}\
1. Zuerst wird der Knoten eingegeben. Wenn dieser in der Liste %pubs noch nicht vorhanden ist, wird er hinzugefuegt.@{N}\
2. Danach wird ein Bezeichner fuer die Tanke abgefragt. Wenn dieser noch nicht vorhanden ist, wird er neu erzeugt, ansonsten editiert@.{N}\
3. Im folgenden werden die Groessen, die die Tanke bestimmten abgefragt, Lebenspunkte, Magiepunkte, Kosten (Muenzen), Anzahl (bei Kneipe 0), Zeit bis zum Erhalt der Tanke, Zeit bis zum kompletten Auftanken, Art der Tanke (g Getraenk, ag alkoholisches Getraenk, s Speise), Fuellung in % Getraenk, Alk, Speise.@{N}\
4. Als letztes wird entweder der Name der Tanke (Kneipe) eingegeben oder eine durch vorangestellten _ (Unterstrich) markierte Anzahl von TF- bzw. Mudbefehlen, die zum Tanken ausgefuehrt wird.
/addh list pubs
/addh settank comm

/defh settank = \
        /loadlist -c pubs%;\
	/echo Knoten:%; /input %showpoint%; /let pub_node=$[_read()]%;\
	/getnode %pub_node%; /let pub_node=%value%;\
	/getdlistvalueof pubs %pub_node%;\
	/if (value=~error) /echo Noch keine Tanken fuer Knoten vorhanden, erzeuge neue Liste%;/createlist pub_temp%; \
	  /else /echo Schon Tanken fuer Knoten vorhanden, Eintrag hinzufuegen. %; /set pub_temp=%value%; \
	/endif%;\
	/showlist pub_temp%;\
	/echo Bezeichner fuer Tanke (ein Wort)%; /set pub_name=$[_read()]%;\
	/getdvalueof pub_temp %pub_name%;\
	/if (value!~error) /echo Eintrag vorhanden, editieren%;\
	/else \
	  /echo neuer Eintrag%;\
	  /set value=226 0 1 0 0 0 ag 0 0 0 _%;\
	/endif%;\
	/test tokenize(" ",value)%;\
	/echo Lebenspunkte:%; /input %T1%;%;\
	/let pub_value=%pub_value $[_read()]%;\
	/echo Magiepunkte:%; /if (T2=~0) /input %pub_value%; /else /input %T2%; /endif%;\
	/let pub_value=%pub_value $[_read()]%;\
	/echo Kosten(Geld):%; /input %T3%;\
	/let pub_value=%pub_value $[_read()]%;\
	/echo Anzahl (Kneipe 0):%; /input %T4%;\
	/let pub_value=%pub_value $[_read()]%;\
	/echo Wartezeit:%; /input %T5%;\
	/let pub_value=%pub_value $[_read()]%;\
	/echo Volltankzeit:%; /input %T6%;\
	/let pub_value=%pub_value $[_read()]%;\
	/echo Art(g Getraenk a Alkohol s Speise):%;\
	/input %T7%;\
	/let pub_value=%pub_value $[_read()]%;\
	/echo Fuellung Speise (in \%) %;\
	/input %T8%;\
	/let pub_value=%pub_value $[_read()]%;\
	/echo Fuellung Getraenk (in \%) %;\
	/input %T9%;\
	/let pub_value=%pub_value $[_read()]%;\
	/echo Fuellung Alkohol (in \%) %;\
	/input %T10%;\
	/let pub_value=%pub_value $[_read()]%;\
	/let i=10%;\
	/set value=%;\
	/while (++i<=T0) \
	  /test value:=strcat(value," ",\{T%{i}\})%;\
	/done%;\
	/set value=%value%;\
/set value%;\
	/echo Name des Getraenks (Kneipe) oder mit _ beginnend tf code zum tanken (z.b. _ob\%;\iss beeren\%;u\%;) %;\
	/input %value%;\
	/let pub_value=%pub_value $[_read()]%;\
	/addtolist pub_temp %pub_name %pub_value%;\
	/showlist pub_temp%;\
	/addlisttolist pubs %pub_node %pub_temp%;\
	/savelist -c pubs%;\
	/echo Fertig%;

/def gotank = /gotank_back2 %1 none %-1%;

/addh info \
Mit /gotank kann man das Tanken etwas beschleunigen. Man gibt als Parameter einfach den Zielknoten an, fuer den in der Liste 'pubs' (siehe /pub_init bzw. /settank) ein Eintrag vorhanden ist. Wenn man schon an einem Knoten steht, der eine Tanke enthaelt, kann man auch den Parameter weglassen, um sofort zu tanken. Wenn man sich vom letzten Knoten wegbewegt hat, wird das /go zum Zielknoten nur vorgeschlagen, ansonsten wird es automatisch ausgefuehrt. Durch Nutzung der Variablen %after_go (siehe /go) wird nach dem Ablaufen des Weges das Tanken ausgefuehrt. Falls fuer den Zielknoten mehr als ein Eintrag vorhanden ist, gibt es eine Auswahlliste. Und danach geht es zurueck zum Ausgangsknoten.
/addh ex /gotank_back ziel [nach_tank_ziel|none|autmatisch akt. knoten] [auswahlnr] [(M|L)zielwert (uebertanken)]
/addh gotank_back comm
/defh gotank_back = /gotank_back2 %*%;
/def gotank_back2 = \
        /if ({#}==0 | {1}=~"none") /let tdest=%lastpoint%;\
	/else \
          /getnode %1%;\
	  /let tdest=%value%;\
	/endif%;\
;/set value%;\
	/getlistvalueof pubs %tdest%;\
;/set value%;\
	/if (value!~error) \
	   /if (lastpoint!~tdest) \
	     /if (gotank_back=~"" & {#}>=2 & {2}!~"none" & {2}!/"[ML0-9]*") \
		/getnode %2%;\
	        /set after_go=/gotank_back2 %1 %value %-2%;\
	        /set gotank_back=%value%;\
	     /else \
	      /if ({#}<2 | {#}>=2 & {2}!~"none") \
	         /set gotank_back=%lastpoint%;\
	         /set after_go=/gotank_back2 %1 %lastpoint %-1%;\
	     /else /set after_go=/gotank_back2 %*%;\
	     /endif%;\
	     /endif%;\
;	/set after_go%;\
	       /if (saved_wayto!~"") \
	          /input /_go %1%;\
               /else /repeat -1 1 /_go %1%;\
	     /endif%;\
	     /return%;\
	   /endif%;\
	   /set go=1%;\
	   /let index=0%;\
	   /set temp_pub=%value%;\
	   /getikey temp_pub %index%;\
	   /while (value!~error) \
;/set value%;\
             /let key=%value%;\
	     /getivalue temp_pub %index%;\
             /test tokenize(" ",value)%;\
	     /if (key=/"[0-9]*") \
		/let i=10%;\
		/set value=%;\
		/while (++i<=T0) \
		  /test value:=strcat(value," ",\{T%{i}\})%;\
		/done%;\
		/let key=%value%;\
;/set value%;\
	     /endif%;\
	     /let text=$[strcat(text,index,". ",key," (",T1,", ",T2,")@{N}")]%;\
	     /let index=$[index+1]%;\
	     /getikey temp_pub %index%;\
	   /done%;\
	   /let pub_choose=%index%;\
	   /let index=%;\
	   /let text=$[strcat(text,"Bitte Nummer eingeben:@{N}")]%;\
	      /if ({#}>=3 & {3}!="[0-9]*") \
		 /let index=$[0+{3}]%;\
		 /shift%;\
	      /elseif ({2}=/"[0-9]*") \
		 /let index=$[0+{2}]%;\
	      /endif%;\
	     /if (pub_choose>1 & index=~"") \
		/echo2 -p %text%;\
		/let index=$[shread()]%;\
	     /elseif (pub_choose==1) /let index=0%;\
	     /endif%;\
	   /if (index=~"" | index>=pub_choose) /echo -aCred Falsche Auswahl!%;/break%; /endif%;\
	   /getivalue temp_pub %index%;\
	   /test tokenize(" ",value)%;\
	   /let i=10%;\
	   /set value=%;\
	   /while (++i<=T0) \
	     /test value:=strcat(value," ",\{T%{i}\})%;\
	   /done%;\
;/set value%;\
	   /let dotank=$[substr(value,1)]%;\
	   /if (dotank=/"_*") \
	      /let dotank=$[substr(dotank,1)]%;\
	   /else \
	      /let dotank=bestelle %dotank%;\
	   /endif%;\
	   /let old_ped=%pedantic%;\
	   /set pedantic off%;\
	/echo -aCred Parameter: %-2%;\
	   /if ({3}=/"[ML]*") /let diff=$[0+substr({3},1)] %;\
	   /else \
             /let diff=$[max(p_maxlp-p_lp,p_maxmp-p_mp)+20]%;\
	   /endif%;\
	   /if (max(T1,T2)>0) \
	     /let diff=$[diff/max(T1,T2)] %;\
	     /if (T3>0) /let diff=$[min(diff,T3)]%; /endif%;\
	     /let diff=$[max(diff,1)]%;\
	     /let ttime=$[max(T5,1)]%;\
	     /repeat -0 1 %dotank %;\
	     /repeat -%ttime $[diff-1] %dotank %;\
/echo %gotank_back 0, %ttime < $[ttime*diff+diff/2]%;\
	     /if (gotank_back!~"" & gotank_back!~"none") \
	       /repeat -$[ttime*diff+1] 1 /_go %gotank_back%;\
	     /endif%;\
	       /repeat -$[ttime*diff+1] 1 /set go=0%;\
	     /set gotank_back=%;\
	   /endif%;\
	   /set pedantic %old_ped%;\
	/endif%;


/addh info \
Mit diesem Makro werden die in einer Kneipe verfuegbaren Speisen und Getraenke erfasst. Falls die Kneipe schon in der Liste %pubs vorhanden ist, wird sie ueberschrieben. Der Name der Kneipe wird in %pubs_name gespeichert. Sie werden temporaer zur Weiterverarbeitung in der Liste %pub_temp_list gespeichert. Nachdem das Menue ausgelesen wurde, wird /init_pub2 fuer Aufraeumungsarbeiten aufgerufen.
/addh see settank, gotank, init_pub2, pubs_name
/addh ex /pub_init Kneipenname, z.B. /pub_init Kchaos

/addh pub_init comm
/defh pub_init = \
    /set pub_count=0%;	\
    /if ({1}=~"") \
	/echo kein Kneipenname angegeben, soll "%showpoint" genutzt werden?%;\
	/echo Bitte Kneipennamen angeben:%;\
	/input %showpoint%;\
	/set pubs_name=$[shread()]%;\
	/if (pubs_name=~"") /echo Kein Name angegeben, Abbruch%; /break%; \
	/endif%;\
    /else /set pubs_name=%1%;\
    /endif%;\
    /getdlistvalueof pubs %pubs_name%;\
    /if (value=~error) \
      /createlist pub_temp_list %;\
    /else \
      /set pub_temp_list=%value%;\
    /endif%;\
\
    /set menue1=g%;\
    /set menue2=g%;\
;
  /def -ag -mregexp -t\"^(Getraenke|Speisen).+(Getraenke|Speisen)\" -1 t_catch_menue_title = ${catch_menue_title}%;\
;
  /def -ag -mregexp -t\"(([A-Za-z ():0-9-]+) +([0-9]+)  ([JN])?)?  [|] (([()A-Za-z: 0-9()-]+) +([0-9]+) ? ?([JN])?)?\" t_catch_menue_contents = \
        ${catch_menue_contents}%;\
    /set nextmakro=/init_pub2%;\
    /def_psave3_trig %;\
    menue%;


/def catch_menue_title = /echo 1 %P1 2 %P2 %;\
	 /if ({P1}=~"Speisen") /set menue1=s%; /endif %;\
	 /if ({P2}=~"Speisen") /set menue2=s%; /endif %; %;

/def  catch_menue_contents = \
	/deletekeyandvalue pub_temp_list %pub_count %;\
	/if ({P1}!~"") \
	  /addtolist pub_temp_list %pub_count 0 0 %P3 0 0 0 $[({P4}=~"J")?"a":""]%menue1 0 0 0 %P2 %; \
	  /set pub_count=$[pub_count+1] %;\
	/endif %;\
	/deletekeyandvalue pub_temp_list %pub_count %;\
	/if ({P5}!~"") \
	  /addtolist pub_temp_list %pub_count 0 0 %P7 0 0 0 $[({P8}=~"J")?"a":""]%menue2 0 0 0 %P6 %; \
	  /set pub_count=$[pub_count+1] %; \
	/endif %;


/addh info \
Loescht den Trigger zum Erfassen des Inhalts des Menues und fuegt die Liste %pub_temp_list unter dem Namen %pubs_name zur Liste %pubs_hinzu.
/addh init_pub2 mak

/def init_pub2 = \
	/undef t_catch_menue_contents %;\
	/if (pubs_name!~"") \
           /uaddlisttolist pubs %pubs_name %pub_temp_list %;\
	   /echo Menue erfasst, weiter mit /pub_test%;\
	/else /echo kein Name der Kneipe angegeben, bitte noch einmal /pub_init ausfuehren%; \
	/endif%;

/addh info \
Extrahiert aus den uebergebenen Parametern die Variablen %pub_kosten, %pub_art und %pub_name.
/addh pub_extract mak

/def pub_extract = \
	   /let tmp=%;\
	   /test tmp:=tokenize(" ",{*})%;\
	   /set pub_kosten=%T3%;\
	   /set pub_art=%T7%;\
	   /set pub_name=%;\
	   /let i=10%;\
	   /set value=%;\
	   /while (++i<=T0) \
	     /test value:=strcat(value," ",\{T%{i}\})%;\
	   /done%;\
	   /set pub_name=%value%;

/addh info \
Startet den Test eines ausgewaehlten Getraenks bzw einer ausgewaehlten Speise. Zuerst werden alle Speisen angezeigt.
/addh ex "/pub_test [Kneipenname]" Wenn nichts angegeben wird, wird die %pub_temp_list der zuletzt initialisierten Kneipe genommen.
/addh see pub_init
/addh mak pub_extract
/addh pub_test comm
/defh pub_test = \
	/if (p_mp>140 | p_lp>140) /echo LP %p_lp und MP %p_mp zu voll zum sinnvollen Test, bitte reduzieren.%; /break%;\ /endif%;\
        /if ({#}>0) \
	   /getlistvalueof pubs %1%;\
	   /if (value!~error) /set pub_temp_list=%value%;\
	      /set pubs_name=%1%;\
	   /else /echo Kneipe %1 nicht in Liste gefunden, bitte mit /pub_init Kneipenname initialisieren.%;/input /pub_init %1%;/break 2%; \
	   /endif%;\
	/endif%;\
;	/foreach pub_temp_list kv /echo %;\
	/showlist pub_temp_list%;\
	/echo Eingabe der Nummer bzw. des Bezeichners der zu testenden Speise:%;\
	/set pub_nr=$[shread()]%;\
	/getvalueof pub_temp_list %pub_nr %;\
	/if (value!~error) \
	   /pub_extract %value %;\
	   /echo ggf. korrigieren:%;\
	   /input /pub_kaufe %pub_name %;\
	/endif %;

/addh info \
Startet das Testen einer gewaehlten Speise bzw. eines Getraenks. Dabei werden die Zeit bis zum Erhalt gestoppt und die aktuellen LP und MP gesichert. Die Weiterverarbeitung erfolgt durch /pub_got nach Erhalt der Tanke.
/addh see pub_init, pub_test
/addh var pub_name, pub_lp, pub_mp
/addh mak pub_got
/addh pub_kaufe comm
/defh pub_kaufe = \
	   /set pub_name=%* %;\
	   /set timer_makro=/pub_got xxx%;\
	   /timer 1 -mglob -t"*{schmeckt|bekommst|erhaeltst|trinkst|Guten Appetit|giesst * ein|hergestellt|fuehlst*besser|scharf|koestlich|staerkt|glaubst|%pub_name|gut|erwarten|Krug|nippst}*" %;\
	   /timer start%;\
	   /add_to_hook points /pub_got%;\
	   /set pub_lp=%p_lp%;\
	   /set pub_mp=%p_mp%;\
	   bestelle %pub_name%;

/addh info \
Speichert die Zeit bis zum Erhalt der Speise in der Variablen %pub_zbringe. Der Timer wird zurueckgesetzt und es wird eine Ueberwachung der LP/MP eingerichtet (mit /add_to_hook points).@{N}\
Zur Ueberwachung wird das Makro /pub_count genutzt.@{N}\
Durch den Zaehler %pub_count wird die Anzahl der Aenderungen unter 2 gezaehlt.
/addh var pub_zbringe, pub_count
/addh see /timer, /add_to_hooks, /pub_count
/addh pub_got mak

/def pub_got = \
	/timer get%;\
	/set pub_zbringe=%?%;\
	/if ({1}=~"xxx" | pub_zbringe>20 | p_m_lp>1 | p_m_mp>1) \
	  /if (pub_zbringe>20) /set pub_zbringe=0%; /endif%;\
	/remove_from_hook points /pub_got%;\
/echo Zeit bis zum Erhalt: %pub_zbringe%;\
	/timer reset%;\
	/set pub_count=0%;\
	/add_to_hook points /pub_count%;\
;	/pub_count%;\
	/endif%;\

/addh info \
Dieses Makro ueberwacht die Veraenderung der LP/MP. Wenn die Steigerung zweimal (in %pub_count) oder oefter weniger als 2 LP/MP betraegt, wird der Test der Tanke mittels /pub_done beendet.@{N}\
Die Zeit des Volltankens werden in %pub_ztanken gespeichert und die erhaltenen LP/MP in %pub_temp_lp bzw. %pub_temp_mp.
/addh var p_m_mp, p_m_lp, pub_count, pub_ztanken, pub_temp_lp, pub_temp_mp
/addh see /pub_done, /pub_got, /pub_kaufe, /pub_test, /pub_init
/addh pub_count mak

/def pub_count = \
	/if (pub_count>=2) /break%; /endif%;\
	/if (p_m_mp<=1 & p_m_lp<=1) \
	   /echo Weniger als 2 LP/MP Steigerung%;\
	   /echo %pub_count %p_m_mp %p_m_lp%;\
;	   /getvalueof pub_temp_list 0%;\
;/set value%;\
	   /if (pub_count==0) \
	   /timer get%;\
	   /set pub_ztanken=%? %;\
	   /set pub_temp_lp=$[p_lp-pub_lp] %;\
	   /set pub_temp_mp=$[p_mp-pub_mp] %;\
;	   /set pub_zbringe%;\
;	   /set pub_ztanken%;\
;	   /set pub_temp_lp%;\
;	   /set pub_temp_mp%;\
	   /endif %;\
	   /set pub_count=$[pub_count+1]%;\
	   /if (pub_count>=2) \
		/pub_done%; /endif%;\
	/else \
	  /set pub_count=0%;\
	/endif %;

/addh info \
Die gesammelten Daten werden nach Abfrage in die Liste 'pubs' geschrieben. Das Makro /pub_count wird aus dem Hook 'points' entfernt.@{N}\
Die erhaltenen Lebenspunkte/Magiepunkte werden in %pub_lp bzw. %pub_mp gespeichert.@{N}\
Die erhaltenen Daten werden angezeigt und nach Abfrage in der Liste 'pubs' gespeichert.
/addh var pubs, pub_temp_list, pub_nr, pubs_name
/addh pub_done mak

/def pub_done = \
	/set pub_lp=%pub_temp_lp%;\
	/set pub_mp=%pub_temp_mp%;\
	/echo %pub_name hat Nummer %pub_nr, kostet  %pub_kosten, bringt %pub_lp LP und %pub_mp MP, wird in %pub_zbringe Sekunden gebracht, hat in %pub_ztanken Sekunden getankt und ist ein $[(strchr("g",pub_art)!=-1)?"Getraenk":"Essen"] $[(strchr("a",pub_art)!=-1)?"mit Alkohol":""]%;\
	/echo Korrekt? Wenn ja Return, sonst andere Taste%;\
	/if (shread()=~"") \
	  /getdlistvalueof pubs %pubs_name%;\
	  /if (value!~error) \
	    /set pub_temp_list=%value%;\
  	    /uaddtolist pub_temp_list %pub_nr %pub_lp %pub_mp %pub_kosten 0 %pub_zbringe %pub_ztanken %pub_art alc drink eat %pub_name%;\
	    /uaddlisttolist pubs %pubs_name %pub_temp_list%;\
	    /else /echo Kneipe %pubs_name nicht gefunden%;\
	  /endif%;\
	/endif%;\
        /remove_from_hook points /pub_count%;\
	/list hook_points%;\
;	/unset pub_name%;\
;	/unset pub_count%;\
;	/unset pub_nr%;\
;	/unset pub_zbringe%;\
;	/unset pub_kosten%;\
;	/unset pub_ztanken%;\
;	/unset pub_art%;\
;	/unset pub_mp%;\
;	/unset pub_lp%;\
;	/unset pub_temp_mp%;\
;	/unset pub_temp_lp%;\
;	/echo TEST6%;\
;	/timer stop%;

/def pub_lp = \
	/if (p_lp>140) \
	  /rz sd%;\
	  tm ${world_character} fore%;\
	/endif%;


/addh info Viele Anwendungsbeispiele fuer die key-value Listen ;))
/addh_fileinfo


