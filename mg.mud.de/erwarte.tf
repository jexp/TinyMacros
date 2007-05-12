;; erwarte.tf -- erweiterte Erwarte-Anzeige
;;
;; (c) 2001 olm@uni.de, Olli@mg.mud.de
;;

/set erwarte_tf_version=$Id: erwarte.tf,v 1.5 2002/10/06 22:49:31 olm Exp $
/set erwarte_tf_author=Olli@mg.mud.de
/set erwarte_tf_desc=erweiterte Erwarte-Anzeige

/addh info \
Traegt einen Grund ein, aus dem ein gewisser Spieler erwartet wird. \
Ohne Angabe von Parametern werden die anwesenden Erwarteten mit dem \
zugehoerigen Grund angezeigt. Durch Angabe von - kann ein Spieler wieder \
aus der Liste geloescht werden.
/addh syn /erwarte [<name> <grund>|-]
/addh ex /erwarte olli Der Olli halt :)
/addh ex /erwarte olli -
/addh erwarte mak
/defh erwarte = \
	/if ({*}=~"") \
		/erwarte_kkwer%;\
	/else \
		/if ({2}=~"") \
			/getvalueof erwarte $[tolower({1})]%;\
			/if (value!~error) \
			  /echo -p @{x%erwarte_color_online_name}%1@{x%erwarte_color_online_normal} - @{x%erwarte_color_online_grund}%value@{n}%;\
			  /return%;\
			/endif%;\
		/endif%;\
		/delallkeysandvalues erwarte $[tolower({1})]%;\
		/if ({2}!~"-") \
		  /addtolist erwarte $[tolower({1})] %-1%;\
		/endif%;\
		/savelist -q -c -p erwarte%;\
	/endif%;

/addh info \
Setzt die Farbe, mit der die Erwarte-Anzeige eines Spielers angezeigt wird. \
(wird offlineFarbe nicht angegeben, wird fuer beide Meldungen \
die onlineFarbe verwendet)
/addh syn /erwarte_color <Name> <onlineFarbe> <offlineFarbe>
/addh ex /erwarte_color Olli BCmagenta BCcyan
/def erwarte_color = \
	/if ({2}!~"") /addtolist erwarte_color1 $[tolower({1})] %2%;/endif%;\
	/if ({3}!~"") /addtolist erwarte_color2 $[tolower({1})] %3%;/endif%;\
	/savelist -q -c -p erwarte_color1%;\
	/savelist -q -c -p erwarte_color2%;\

/loadlist -q -c -p erwarte
/loadlist -q -c -p erwarte_color1
/loadlist -q -c -p erwarte_color2

/def -mregexp -t'^([a-zA-Z0-9]+)   I S T   J E T Z T   D A !!!' -ag -p2000 t_erwarte = \
	/getvalueof erwarte_color1 $[tolower({P1})]%;\
	/if (value=~error) \
		/let ecn=%erwarte_color_online_name%;\
	/else \
		/let ecn=%value%;\
	/endif%;\
	/getvalueof erwarte $[tolower({P1})]%;\
	/if ((value=~error)|(value=~"")) \
		/echo -p @{x%erwarte_color_online_normal}Erwartet  (@{x%erwarte_color_online}online@{x%erwarte_color_online_normal}): @{x%ecn}%P1@{n}%;\
	/else \
		/echo -p @{x%erwarte_color_online_normal}Erwartet  (@{x%erwarte_color_online}online@{x%erwarte_color_online_normal}): @{x%ecn}%P1 @{x%erwarte_color_online_normal}- @{x%erwarte_color_online_grund}%value@{n}%;\
	/endif%;\
	/if (erwarte_beep=~"on") \
		/beep%;\
	/endif%;

/def -mregexp -t'^([a-zA-Z0-9]+)   I S T   J E T Z T   N I C H T   M E H R   D A !!!' -ag -p2000 t_erwarte2 = \
	/getvalueof erwarte_color2 $[tolower({P1})]%;\
	/if (value=~error) \
		/getvalueof erwarte_color1 $[tolower({P1})]%;\
		/if (value=~error) \
			/let ecn=%erwarte_color_offline_name%;\
		/else \
			/let ecn=%value%;\
		/endif%;\
	/else \
		/let ecn=%value%;\
	/endif%;\
	/getvalueof erwarte $[tolower({P1})]%;\
	/if ((value=~error)|(value=~"")) \
		/echo -p @{x%erwarte_color_offline_normal}Erwartet (@{x%erwarte_color_offline}offline@{x%erwarte_color_offline_normal}): @{x%ecn}%P1@{n}%;\
	/else \
		/echo -p @{x%erwarte_color_offline_normal}Erwartet (@{x%erwarte_color_offline}offline@{x%erwarte_color_offline_normal}): @{x%ecn}%P1 @{x%erwarte_color_offline_normal}- @{x%erwarte_color_offline_grund}%value@{n}%;\
	/endif%;\
        /if (erwarte_beep=~"on") \
                /beep%;\
        /endif%;

/def erwarte_kkwer = \
	/set after_kkwer=/erwarte_display%;\
	/kkwer erwartete

/def erwarte_display = \
	/echo -p @{x%erwarte_color_online_normal}Anwesende erwartete Personen%;\
	/echo -p -- ----------------------------%;\
	/forEach kkwer k /erwarte_display_entry%;\

/def erwarte_display_entry = \
        /let user_erw=%1%;\
        /getvalueof erwarte %1%;\
	/if (value=~error) \
	   /set value=%;\
	/endif%;\
	/echo -p @{x%erwarte_color_online_name}$[pad(capitalize(user_erw), -14)]@{x%erwarte_color_online_normal} - @{x%erwarte_color_online_grund}%value@{n}%;\



/def nonfriends_do = \
	/set after_kkwer=/nonfriends_do2%;\
	/set nonfriends_do_command=%*%;\
	/kkwer erwartete

/def nonfriends_do2 = \
	/set after_fwer=/forEach kkwer k /nonfriends_do3%;\
	/fwer

/def nonfriends_do3 = \
	/getvalueof fwer %1%;\
	/if (value=~error) \
		/eval -s0 %nonfriends_do_command %1%;\
	/endif

/def nfknuddel = \
	/nonfriends_do rknuddel

/def nfecho = \
	/echo Erwartet und nicht auf dem fband:%;\
	/nonfriends_do /echo *

