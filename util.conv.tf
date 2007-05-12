; $Log: util.conv.tf,v $
; Revision 1.1  2002/05/12 09:11:07  thufhnik
; Scratch
;

/set util_conv_tf_version $Id: util.conv.tf,v 1.1 2002/05/12 09:11:07 thufhnik Exp $
/set util_conv_tf_author=Thufhir@mg.mud.de
/set util_conv_tf_requires=
/set util_conv_tf_desc Verschiedene Konvertierungen


/addh info \
Gibt einen String aus, der die uebergebene Zeit minutengenau im Klartext enthaelt. Soll die Zeit sekundengenau ausgegeben werden muss sek_flag gesetzt werden.
/addh syn /time2str zeit [sek_flag]
/addh ex /time2str 1000000 1
/addh time2str mak
/def time2str = \
	/let T2SMINS=$[{1} / 60]%;\
	/let T2SSECS=$[mod({1}, 60)]%;\
	/let T2SHOURS=$[T2SMINS / 60]%;\
	/let T2SDAYS=$[T2SHOURS / 24]%;\
	/let T2SWEEKS=$[T2SDAYS / 7]%;\
	/let T2SDAYS=$[mod(T2SDAYS,7)]%;\
	/let T2SHOURS=$[mod(T2SHOURS,24)]%;\
	/let T2SMINS=$[mod(T2SMINS,60)]%;\
	/if (T2SWEEKS) \
		/if (T2SWEEKS == 1) \
			/let T2SSTR=eine Woche, @{n}%;\
		/else \
			/let T2SSTR=%T2SWEEKS Wochen, @{n}%;\
		/endif%;\
	/else \
		/let T2SSTR=%;\
	/endif%;\
	/if (T2SWEEKS | T2SDAYS) \
		/if (T2SDAYS == 1) \
			/let T2SSTR=$[strcat(T2SSTR, "einen Tag, @{n}")]%;\
		/else \
			/let T2SSTR=%T2SSTR%T2SDAYS Tage, @{n}%;\
		/endif%;\
	/endif%;\
	/if (T2SWEEKS | T2SDAYS | T2SHOURS) \
		/if (T2SHOURS == 1) \
			/let T2SSTR=$[strcat(T2SSTR, "eine Stunde, @{n}")]%;\
		/else \
			/let T2SSTR=%T2SSTR%T2SHOURS Stunden, @{n}%;\
		/endif%;\
	/endif%;\
	/if (T2SMINS == 1) \
		/let T2SSTR=$[strcat(T2SSTR, "eine Minute")]%;\
	/else \
		/let T2SSTR=%T2SSTR%T2SMINS Minuten%;\
	/endif%;\
	/if ({2}) \
		/if (T2SSECS == 1) \
			/test T2SSTR := strcat(T2SSTR, " und eine Sekunde")%;\
                /else \
			/test T2SSTR := strcat(T2SSTR, " und ", T2SSECS, \
				" Sekunden")%;\
		/endif%;\
	/endif%;\
	/echo -p -- %T2SSTR


/addh info \
Entfernt aus dem uebergebenen String den fuehrenden Artikel.
/addh syn /remove_article text
/addh ex /remove_article Das Auto
/addh remove_article mak
/def remove_article = \
	/if (regmatch(articles, {*})) \
		/echo -- %PR%;\
	/else \
		/echo -- %*%;\
	/endif


/set articles=
/if (mud_lang=~'en') \
	/test articles:="^[Tt]h(e|is) "%;\
/else \
	/test articles:="^[Dd]e[rsmn] |[Dd]ie |[Dd]as |[Dd]ein(e[srnm]?)? |\
		[Ee]in(e[srmn]?)? "%;\
/endif

/if /ismacro compile_regexp%; /then \
	/compile_regexp articles%;\
/endif
