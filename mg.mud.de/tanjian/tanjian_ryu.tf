/set tanjian_ryu_tf_version $Id$
/set tanjian_ryu_tf_author=asuka@mg.mud.de
/set tanjian_ryu_tf_requires=
/set tanjian_ryu_tf_desc=Tanjian Clanerweiterung

; kasai

/def -agCblue -F -q -msimple -t'Du formst mit Deinen beiden Haenden einen \
		Hohlraum und konzentrierst Dich auf' tanjian_kasai_prep = \
		/purge tanjian_ryu_pregag%;\
		/def -1 -agCblue -msimple -t'diesen. Du sammelst die \
			Energie, um eine Feuersbrunst zu \
			erzeugen.' tanjian_ryu_pregag%;\
		/echo -aCgreen Tanjian Konzentration: Kasai%;\
		/set TANJIAN_BUSY=kasai

/def -agCblue -F -q -msimple -t'Du schleuderst das Feuer auf Deine \
	Gegner.' tanjian_ryu = \
	/set TANJIAN_BUSY=%; \
	/if (!weapon_drawn & (!tanjian_akshara | tanjian_akshara > 3)) \
		/if /ismacro weapon_draw%;/then \
			/set weapon_quiet 1%; \
			/weapon_draw%;\
		/endif%;\
		/if /ismacro shield_wear%;/then \
			/set shield_quiet 1%; \
			/shield_wear%; \
		/endif%;\
	/endif%;\
	/echo -aCgreen Tanjian: Kasai

/def -agCblue -F -q -msimple -t'Deine Konzentration hat wohl nicht \
		ausgereicht.' tanjian_ryu_fehlschlag = \
	/set TANJIAN_BUSY=%; \
	/if (!weapon_drawn & (!tanjian_akshara | tanjian_akshara > 3)) \
		/if /ismacro weapon_draw%;/then \
			/set weapon_quiet 1%; \
			/weapon_draw%;\
		/endif%;\
		/if /ismacro shield_wear%;/then \
			/set shield_quiet 1%; \
			/shield_wear%; \
		/endif%;\
	/endif%;\
	/echo -aCgreen Tanjian: Kasai (Fehlschlag)

/def tanjian_do_kasai = \
	/if (TANJIAN_BUSY=~'') \
		/if /ismacro shield_unwear%;/then \
			/set shield_quiet 1%;\
			/shield_unwear%;\
		/endif%;\
		/if /ismacro weapon_unwear%;/then \
			/set weapon_quiet 1%;\
			/weapon_unwear%;\
		/endif%;\
		/send !\\kasai%;\
	/endif

/def kas = \
    	/if (TANJIAN_BUSY=~'') \
		/if /ismacro shield_unwear%;/then \
			/set shield_quiet 1%;\
			/shield_unwear%;\
		/endif%;\
		/if /ismacro weapon_unwear%;/then \
			/set weapon_quiet 1%;\
			/weapon_unwear%;\
		/endif%;\
		/send !\\kasai %*%;\
	/endif

/def -msimple -t'Wen willst Du mit einer Feuersbrunst \
		einaeschern?' tanjian_kasai_unset = \
		/if (TANJIAN_BUSY=~'kasai')%; \
			/set TANJIAN_BUSY=%;\
		/endif%;\
		/weapon_draw%;

/def -msimple -aCgreen -t'Uii ist das heiss!' tanjian_kasai_erfolg
