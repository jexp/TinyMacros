; $Log: tanjian_nekekami.tf,v $
; Revision 1.2  2002/09/04 17:47:16  thufhnik
; Log als Kommentar
;
; Revision 1.1  2002/09/04 17:25:29  chbr
; Clan Nekekami (kiri)

/set tanjian_nekekami_tf_version=$Id$
/set tanjian_nekekami_tf_author=Asuka@mg.mud.de
/set tanjian_nekekami_tf_requires=
/set tanjian_nekekami_tf_desc=Tanjian Clanerweiterung


/set CFG_STATUS_COLOR_TANJIAN_CLAN_1=Cyellow
/set CFG_STATUS_TEXT_TANJIAN_CLAN_1=K

/set sl_tanjian_clan_doc=Kiri ($[status_doc_attr("TANJIAN_CLAN_1")])

; Kiri

/def tanjian_do_kiri = \
	/if (TANJIAN_BUSY=~'') \
		/if /ismacro shield_unwear%;/then \
			/set shield_quit 1%;\
			/shield_unwear%;\
		/endif%;\
		/if /ismacro weapon_unwear%;/then \
			/set weapon_quiet 1%;\
			/weapon_unwear%;\
		/endif%;\
		/send !\\kiri%;\
	/endif

/def -agCblue -F -q -msimple -t'Du breitest die Arme aus und konzentrierst Dich.' tanjian_kiri_konz = \
	/echo -aCgreen Tanjian Konzentration: Kiri%;\
	/set TANJIAN_BUSY=kiri

/def -agCblue -F -q -msimple -t'Du huellst Dich in einen schuetzenden Nebel.' tanjian_kiri = \
	/set tanjian_clan 1%;\
	/set TANJIAN_BUSY=%;\
	/if (!weapon_drawn & (!tanjian_akshara | tanjian_akshara > 3)) \
		/if /ismacro weapon_draw%;/then \
			/set weapon_quit 1%;\
			/weapon_draw%;\
		/endif%;\
		/if /ismacro shield_wear%;/then \
			/set shield_quit 1%;\
			/shield_wear%;\
		/endif%;\
	/endif%;\
	/echo -aCgreen Tanjian: Kiri

/def -aCred -F -q -msimple -t'Der Nebel loest sich auf.' tanjian_kiri_out = \
	/set tanjian_clan=0%;\

/def -aCgreen -F -q -msimple -t'Du bist noch in einen Nebel gehuellt.' tanjian_kiri_already = \
	/if (!weapon_drawn & (!tanjian_akshara | tanjian_akshara > 3 )) \
		/if /ismacro weapon_draw%;/then /weapon_draw%;/endif%;\
		/if /ismacro shield_wear%;/then /shield_wear%;/endif%;\
	/endif

