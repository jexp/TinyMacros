; $Log: tanjian_okami.tf,v $
; Revision 1.2  2002/03/31 12:51:06  thufhnik
; alle Flags in der Statuszeile sind jetzt voll konfigurierbar
;
; Revision 1.1  2002/01/26 19:03:29  thufhnik
; Scratch
;

/set tanjian_okami_tf_version $Id: tanjian_okami.tf,v 1.2 2002/03/31 12:51:06 thufhnik Exp $
/set tanjian_okami_tf_author=Thufhir@mg.mud.de
/set tanjian_okami_tf_requires=
/set tanjian_okami_tf_desc=Tanjian Clanerweiterung

/set CFG_STATUS_COLOR_TANJIAN_CLAN_1=Cred
/set CFG_STATUS_TEXT_TANJIAN_CLAN_1=d
/set CFG_STATUS_COLOR_TANJIAN_CLAN_2=Ccyan
/set CFG_STATUS_TEXT_TANJIAN_CLAN_2=D
/set CFG_STATUS_COLOR_TANJIAN_CLAN_3=Cyellow,h
/set CFG_STATUS_TEXT_TANJIAN_CLAN_3=D
 
/set sl_tanjian_clan_doc=Dogo ($[status_doc_attr("TANJIAN_CLAN_1")], $[status_doc_attr("TANJIAN_CLAN_2")], $[status_doc_attr("TANJIAN_CLAN_3")])

; dogo

/def -agCblue -F -q -msimple -t'Du raeusperst Dich und formst mit Deinen \
	Haenden einen Trichter vor Deinem' tanjian_dogo_prep = \
	/purge tanjian_dogo_prepgag%;\
	/def -1 -agCblue -msimple -t'Mund.' tanjian_dogo_prepgag%;\
	/echo -aCgreen Tanjian Konzentration: Dogo%;\
	/set TANJIAN_BUSY=dogo

/def -agCblue -F -q -mregexp -t'Du stoesst ein (lautes|furchteinfloessendes|\
	wirklich furchteinfloessendes) Wolfsgeheul aus\\.' tanjian_dogo = \
	/if ({P1} =~ "lautes") \
		/let TANJIAN_DOGO=(-)%;\
		/set tanjian_clan 1%;\
	/elseif ({P1} =~ "furchteinfloessendes") \
		/let TANJIAN_DOGO=%;\
		/set tanjian_clan 2%;\
	/elseif ({P1} =~ "wirklich furchteinfloessendes") \
		/let TANJIAN_DOGO=(+)%;\
		/set tanjian_clan 3%;\
	/endif%;\
	/set TANJIAN_BUSY=%;\
	/echo -aCgreen Tanjian: Dogo %TANJIAN_DOGO

/def -aCred -F -q -msimple -t'Die Wirkung Deines Wolfsgeheuls laesst nach.' \
	tanjian_dogo_out = /set tanjian_clan=0
