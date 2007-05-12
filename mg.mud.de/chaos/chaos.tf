; $Log: chaos.tf,v $
; Revision 1.6  2002/09/28 12:53:13  mh14
; Reportart Chaos
;
; Revision 1.5  2002/09/15 20:59:06  mh14
; statuszeile
;
; Revision 1.4  2002/04/18 22:39:20  mh14
; chaos schutz debuggt
;
; Revision 1.3  2002/02/10 22:43:08  mh14
; debuggt, Statuszeilendoku
;
; Revision 1.2  2001/11/28 11:38:00  mh14
; loginfo
;

/set chaos_tf_version $Id: chaos.tf,v 1.6 2002/09/28 12:53:13 mh14 Exp $
/set chaos_tf_author=Mesirii@mg.mud.de
/set chaos_tf_requires lists.tf 
/set chaos_tf_desc=Diverse Hilfsmakros fuer die Chaosgilde

/add_to_hook first_connect reportart chaos

/remove_from_hook points /set_points %1 %2

/def -agCblue -mregexp -t"^Du verfuegst ueber ([0-9]+)/([0-9]+) LP \\(\\+?([0-9-]+)\\) und ([0-9]+)/([0-9]+) KP \\(\\+?([0-9-]+)\\)\\.$" t_chaos_report = \
     /set p_update_time=$[time()]%;\
     /set p_last_lp=%p_lp%; /set p_last_mp=%p_mp%;\
     /set p_maxlp=%P2%; /set p_maxmp=%P5%;\
     /set p_m_lp=%P3%; /set p_m_mp=%P6%;\
     /set p_lp=%P1%; /set p_mp=%P4%;\
     /eval_hook points %p_lp %p_mp

/addh info \
fuegt einen Eintrag zur Liste %demon_list_name hinzu (abspeichern nicht vergessen)
/addh syn /add kuerzel Daemonenname (wie in sprueche)
/addh see zauber, b, chaos_get_demon, vd, ld, sd, d, sp, udd, stop, folge, binde, bdt, bd
/addh var demon
/addh chaos_add_demon comm

/defh chaos_add_demon = /addtolist %demon_list_name %* %;

/addh info \
liefert einen Eintrag aus der Liste %demon_list_name zurueck
/addh syn /chaos_get_demon kuerzel
/addh return in value der Daemonenname
/addh var demon
/addh see zauber, b, chaos_get_demon, vd, ld, sd, d, sp, udd, stop, folge, binde, bdt, bd
/addh chaos_get_demon mak

/def chaos_get_demon = /getvalueof %demon_list_name %* %;

/set sl_finsternis_doc=Finsternissperre: <60sek n, <90sek rot, <120sek gelb, fertig gruen
/def sl_finsternis = \
   /init_var finsternis%;\
   /set status_func_finsternis="f"%;\
   /set status_attr_finsternis=$[attr_ordered("time()-finsternis",60,"n",90,"Cred",120,"Cyellow","BCgreen")]%;\
   /return status_var("finsternis",1)

/def sl_demon_doc=Abkuerzung des Daemons mit dessen Status als Farbe, blau bis weiss
/def sl_demon  = \
   /init_var demon_state demon_short%;\
   /set status_func_demon_short=capitalize(demon_short)%;\
   /set status_attr_demon_short=(demon_short=~"")?"n":state_color(demon_state)%;\
   /return status_var("demon_short",2)

/def sl_chaosball_doc=Anzahl der Chaosbaelle und eingestellte Schadensart als Abkuerzung und Farbe (siehe weapon)
/def sl_chaosball = \
	/init_var p_num_chaosball status_chaosball%;\
	/return strcat(status_var("p_num_chaosball",-3)," '-' \$[status_chaosball]")

/def -ag -t"Die naechsten ([0-9]+) Chaosbaelle sind: " -mregexp t_rep_chaosball = /set p_num_chaosball=%P1%;\
    /set p_schaden_chaosball=%{PR}%;\
    /status_get_schaden_string %{PR} 2%;\
    /set status_chaosball=%status_schaden_attr%;\

/set sl_chaos_schutz_doc=Schutzanzeige: schwach s, start S in Chaoshautschutzfarbe (siehe chaosball)
/def sl_chaos_schutz = \
   /init_var chaos_schutz chaos_schutz_haut chaos_schutz_haut_attr%;\
   /set status_attr_chaos_schutz=(chaos_schutz!~"" ? chaos_schutz_attr : "")%;\
   /return status_var("chaos_schutz",1)

/def -ag -F -t"Die Chaosruestung schuetzt zusaetzlich vor * Schaden." -mglob t_schutz_haut = \
	/set chaos_schutz_haut=%6%;\
	/status_get_schaden_attr . %6%;\
	/set chaos_schutz_attr=%status_schaden_attr_only%;\
	/echo -aCred -p %-L2 @{%chaos_schutz_attr}%6@{x} %-6

/def -t"Der magische Schutz Deiner Chaoshaut wird gleich verschwinden!" -aBCyellow -msimple t_schutz_warnung = /nop

/def -p1 -msimple -t'Wie wild schmeisst Du alles von Dir!' t_haut_weg = \
nimm alles%;trage alles

/def -p1 -msimple -t'Dir wird einfach zu heiss! Du reisst Dir die Kleidung vom Leibe.' t_haut_aus = trage alles

/def -t"Cool. Du hast eine leichte Vergiftung." -ag -msimple t_chaos_light_poison = /t_light_poison

	
	
/addh info \
ruft verbannen mit dem aktuellen Daemoen auf
/addh var demon
/addh vd comm

/defh vd = verbanne %demon %;

/addh info zeigt den aktuellen Daemon an
/addh var demon
/addh ld comm

/defh ld = /echo -aB Daemon: %demon %;

/addh info setzt den aktuellen Daemon
/addh var demon, value
/addh syn /sd kuerzel|daemon
/addh list %demon_list_name
/addh sd comm
/defh sd = /let param=%* %;\
	  /chaos_get_demon %param %;\
	  /if (value=~error) \
	     /echo -aCred Daemon: %param nicht gefunden!%;\
	     /return error%;\
	  /else /set demon=%value %; /set demon_short=%*%; \
	  /ld%;\
	  /endif%;\


/addh info beschwoert den angegebenen Daemonen, und setzt diesen als aktuellen Daemonen (natuerlich nur wenn Bedingungen stimmen (?zauber))
/addh var demon
/addh list %demon_list_name
/addh see zauber, sd, spell_set_and_cast
/addh d comm
/defh d = /sd %* %; /spell_set_and_cast %d %;

/addsave demon
/addh info spendiert dem aktuellen Daemonen die angegeben Sachen
/addh syn /sp Speise|Getraenk Anzahl
/addh var demon
/addh mak repeat
/addh sp comm
/defh sp = /if ({1}=/"[0-9]*") \
	     /repeat -1 %{1} spendiere %demon %-1 %;\
	   /else \
	     spendiere %demon %* %;\
	   /endif%;

/addh info untersucht den aktuellen Daemon
/addh var demon
/addh udd comm
/defh udd = unt %demon %;

/addh info stop mit dem aktuellen Daemon
/addh comm bd
/addh stop comm

/defh stp = /bd stop %;

/addh info folge mit dem aktuellen Daemon
/addh comm bd
/addh folge comm
/defh folge = /bd folge%;

/addh info zaubert binde mit aktuellem Daemon
/addh see zauber
/addh binde comm
/defh binde = /spell_set_and_cast b %;

/addh info beschwoert den angegebenen Daemon, und macht sofort /bd folge leise
/addh syn /b kuerzel
/addh list %demon_list_name
/addh see zauber
/addh comm sd, spell_set_and_cast, bd
/addh b comm

/defh b = /sd %* %;/if ({?}!~error) /spell_set_and_cast %* %; /bd folge leise%;/endif %;

/addh info befiehlt aktuellem Daemon das gesetzte oder das angegebene Monster zu toeten
/addh var demon
/addh syn /bdt [monster]
/addh bdt comm
/defh bdt = befehle %demon toete $[(!{#})?{*}:%opfer] 

/def ngdd = nimm %*%;gib %demon %*

/def gd = gib %demon %*

/addh info befiehlt dem aktuellem Daemon den uebergebenen Befehl
/addh syn /bd Text
/addh var demon
/addh bd comm
/defh bd = befehle %demon %* %;

;/addz du 0 5 2 dunkelheit
;/addz st 2 25 2 schutz stark
;/addz sw 2 25 2 schutz schwach
;/addz bz 1 10 4 bannzauber
;/addz b 1 40 12 binde %demon
;/addz fi 0 100 6 finsternis %opfer
;/addz nsi 0 10 2 nachtsicht
;/addz ch 2 95 52 chaosruestung
;/addz k 2 20 22 kontrolle
;/addz cm 0 20 2 chaosball %opfer
;/addz c 0 20 2 chaosball
;/addz vm 0 30 2 verbanne %opfer
;/addz v 0 30 2 verbanne
;/addz ib 1 5 6 intarbir
;/addz kr 1 10 6 kruftur
;/addz f 2 120 20 flaxtri
;/addz g 2 90 15 graiop
;/addz o 2 80 12 ombatis
;/addz t 2 140 30 tutszt
;/addz h 2 60 10 harkuhu
;/addz i 2 40 7 irkitis

/addh info Liste der Zaubersprueche (auch fuer andere Gilden moeglich)
/addh syn Listeneintrag zum Kuerzel: haende magiepunkte sperrzeit spruch (mit %variable moeglich)
/addh see zauber
/addh sprueche list
;/createlist sprueche
;/loadlist -c -dchaos sprueche

/addh info Trigger fuer Kontrolle
/addh var konrun
/addh mak run_kon
/addh daemon trig
/def -aB -msimple  -p200 \
 -t"DER DAEMON IN DEINER HAUT WIRD GLEICH VERSUCHEN SICH ZU BEFREIEN!!!" \
    daemon =\
 /run_kon%;

/def -msimple -aB  -p200 \
 -t"DER DAEMON IN DEINER HAUT FAENGT GLEICH AN ZU TOBEN!!" \
    daemon2 =\
 /run_kon%; 

/addh info Laufmakro fuer Kontrolle
/addh var konrun, kon
/addh mak kontrolle
/addh run_kon mak
/def run_kon =  /if (konrun==0) /set kon=0%;/set konrun=1%; /kontrolle%; %; /endif %;

/addh info zaubert Kontrolle, bei Missgluecken nochmal
/addh var kon, sperrzeit
/addh kontrolle mak
/def kontrolle = \
	/if (kon==0) \
	   /spell_set_and_cast k%; \
	   /repeat -%spell_busy 1 /kontrolle%; \
	/endif%;

/addh info Zeigt an, dass Kontrolle ausgeuebt wird
/addh kon var
/set kon=1

/addh info Zeigt an, dass das Zaubern von Kontrolle am Laufen ist
/addh konrun var
/set konrun=0
/addh info Kontrolle war erfolgreich
/addh var konrun, kon
/addh test_kon trig
/def -msimple -E(konrun) \
     -t"Du erlangst die Kontrolle ueber die Chaos-Ruestung zurueck." \
     test_kon = \
	/set kon=1%;/set konrun=0%;

/addh info Markierung von Verschwinden des Schutzes
/addh schutzweg trig
/def -msimple  -aBCred \
     -t"Der magische Schutz der Chaoshaut verschwindet." \
     t_schutz_aus = \
	/if (kampf>0 & keepschutz) \
	   /spell_set_and_cast %schutz%; \
	/endif%; \
	/set chaos_schutz=

/def -msimple -aCgreen \
	-t"Deine Chaoshaut schuetzt Dich jetzt etwas besser." \
	t_schutz_schwach = /set chaos_schutz=s

/def -msimple -aBCgreen \
	-t"Deine Chaoshaut schuetzt Dich jetzt wesentlich besser." \
	t_schutz_stark = /set chaos_schutz=S



/set keepschutz=0
/def ks = /toggle keepschutz%;/set keepschutz%;

/addh info nimmt etwas und gibt es dem aktuellen Daemonen
/addh var demon
/addh syn /ng Sache
/addh ng comm
/defh ng = nimm %* %; gib %demon %* %;

/addh info \
enthaelt Einstellungen, Listen mit Abkuerzungen, Hilfsmakros fuer die Chaosgilde im MG
/addh_fileinfo


/createlist chaosschaeden
/addtolist chaosschaeden m messer
/addtolist chaosschaeden F feuer
/addtolist chaosschaeden E eis
/addtolist chaosschaeden L sturm
/addtolist chaosschaeden K krach
/addtolist chaosschaeden B blitz
/addtolist chaosschaeden s pfeil
/addtolist chaosschaeden M magie
/addtolist chaosschaeden k felsen
/addtolist chaosschaeden T terror
/addtolist chaosschaeden S saeure
/addtolist chaosschaeden G gift
/addtolist chaosschaeden q quetschen
/addtolist chaosschaeden x explosion
/addtolist chaosschaeden W wasser
/addtolist chaosschaeden r widerhaken
/addtolist chaosschaeden p peitsche
/addtolist chaosschaeden D boese

/def get_schaden = \
    /getvalueof chaosschaeden %1%;\
    /let tmp=%?%;\
    /if (tmp!~error) \
	/return tmp%;\
    /endif%;\
    /info ERROR Keinen Schaden für %1%;\
    /return error%;

/def ck = \
    /let tmp=$[get_schaden(substr({1},0,1))]%;\
    /if (tmp!~error) \
	/set chaosschaden=%tmp%;\
       /if (strlen({1})==2) \
	   /let tmp=$[get_schaden(substr({1},1,1))]%;\
	   /if (tmp!~"") \
	     /set chaosschaden=%chaosschaden %tmp%;\
	     /z ck%;\
	   /endif%;\
	/else \
	   /z sd%;\
       /endif%;\
    /endif%;\
    /info INFO Chaosschaden: %chaosschaden

/config_status






