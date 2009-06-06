; $Log: tanjian_kagekitsune.tf,v $
; Revision 1.5  2002/05/31 08:24:52  thufhnik
; Anpassung an neue weapon2.tf
;
; Revision 1.4  2002/04/01 19:17:03  thufhnik
; noch nen paar kleine Anpassungen
;
; Revision 1.3  2002/03/31 12:51:06  thufhnik
; alle Flags in der Statuszeile sind jetzt voll konfigurierbar
;
; Revision 1.2  2002/03/03 19:28:01  thufhnik
; tanjian_do_kageodori fuer autokampf angepasst
;
; Revision 1.1  2002/01/26 11:18:03  thufhnik
; Scratch
;

/set tanjian_kagekitsune_tf_version $Id$
/set tanjian_kagekitsune_tf_author=Thufhir@mg.mud.de
/set tanjian_kagekitsune_tf_requires=
/set tanjian_kagekitsune_tf_desc=Tanjian Clanerweiterung

/set CFG_STATUS_COLOR_TANJIAN_CLAN_1=Cred
/set CFG_STATUS_TEXT_TANJIAN_CLAN_1=k
/set CFG_STATUS_COLOR_TANJIAN_CLAN_2=Ccyan
/set CFG_STATUS_TEXT_TANJIAN_CLAN_2=K
/set CFG_STATUS_COLOR_TANJIAN_CLAN_3=Cyellow,h
/set CFG_STATUS_TEXT_TANJIAN_CLAN_3=K

/set sl_tanjian_clan_doc=Kageodori ($[status_doc_attr("TANJIAN_CLAN_1")], $[status_doc_attr("TANJIAN_CLAN_2")], $[status_doc_attr("TANJIAN_CLAN_3")])

; kageodori

/def tanjian_do_kageodori = \
	/if (TANJIAN_BUSY=~'') \
		/if /ismacro shield_unwear%;/then \
			/set shield_quiet 1%;\
			/shield_unwear%;\
		/endif%;\
		/if /ismacro weapon_unwear%;/then \
			/set weapon_quiet 1%;\
			/weapon_unwear%;\
		/endif%;\
		/send !\\kageodori%;\
	/endif

/def -agCblue -F -q -msimple -t'Du kreuzt die Arme vor der Brust und \
	konzentrierst Dich.' tanjian_kageodori_konz = \
	/echo -aCgreen Tanjian Konzentration: Kageodori%;\
	/set TANJIAN_BUSY=kageodori

/def -agCblue -F -q -mregexp -t'Du gibst Dich (etwas \
	unbeholfen|ganz|vollstaendig) dem Schattentanz hin\\.' \
	tanjian_kageodori = \
	/repeat -1 1 /purge tanjian_kageodori_erf%;\
	/if ({P1} =~ "etwas unbeholfen") \
		/let TANJIAN_KAGEODORI=(-)%;\
		/set tanjian_clan 1%;\
	/elseif ({P1} =~ "ganz") \
		/let TANJIAN_KAGEODORI=%;\
		/set tanjian_clan 2%;\
	/elseif ({P1} =~ "vollstaendig") \
		/let TANJIAN_KAGEODORI=(+)%;\
		/set tanjian_clan 3%;\
	/endif%;\
	/def -1 -F -aCbggreen -q -msimple -t'Du fuehlst Dich fast \
		wie ein Schatten.' tanjian_kageodori_succ%;\
	/set TANJIAN_BUSY=%;\
	/if (!weapon_drawn & (!tanjian_akshara | tanjian_akshara > 3)) \
		/if /ismacro weapon_draw%;/then \
			/set weapon_quiet 1%;\
			/weapon_draw%;\
		/endif%;\
		/if /ismacro shield_wear%;/then \
			/set shield_quiet 1%;\
			/shield_wear%;\
		/endif%;\
	/endif%;\
	/echo -aCgreen Tanjian: Kageodori %TANJIAN_KAGEODORI

/def -aCred -F -q -msimple -t'Dein Schattentanz naehert sich seinem Ende.' \
	tanjian_kageodori_out = \
	/set tanjian_clan=0%;\
	/if /ismacro autokampf_update%; /then \
		/autokampf_update /tanjian_do_kageodori%;\
	/endif

/def -agCblue -F -q -msimple -t'Du stolperst ueber Deine eigenen \
	Fuesse.' tanjian_kageodori_error = \
	/echo -aCred Tanjian Fehlschlag: Kageodori%;\
	/if (!weapon_drawn & (!tanjian_akshara | tanjian_akshara > 3)) \
		/if /ismacro weapon_draw%;/then /weapon_draw%;/endif%;\
		/if /ismacro shield_wear%;/then /shield_wear%;/endif%;\
	/endif

/def -aCgreen -F -q -msimple -t'Du tanzt doch noch den Schattentanz.' \
	tanjian_kageodori_already = \
	/if (!weapon_drawn & (!tanjian_akshara | tanjian_akshara > 3)) \
		/if /ismacro weapon_draw%;/then /weapon_draw%;/endif%;\
		/if /ismacro shield_wear%;/then /shield_wear%;/endif%;\
	/endif%;\
	/if /ismacro autokampf_update%; /then \
		/autokampf_update /tanjian_do_kageodori%;\
	/endif
