/set klerus_kandri_tf_version $Id: klerus_kandri.tf,v 1.5 2002/09/04 11:40:36 thufhnik Exp $
/set klerus_kandri_tf_author=Thufhir@mg.mud.de
/set klerus_kandri_tf_requires=weapon2.tf
/set klerus_kandri_tf_desc=Alles fuer Kandri-Geweihte

; Variablen initialisieren

/set klerus_sh 0


; Statusmodule

/set sl_klerus_sh_doc=Schutzhand (H)
/def sl_klerus_sh = \
	/init_var klerus_sh%;\
	/set status_func_klerus_sh=klerus_sh?"H":""%;\
	/return status_var("klerus_sh",1,%KLERUS_SH_F)

; Schutzhand

/def klerus_do_sh = /weapon_action 2 !\\schutzhand

/def -Fp20 -agCblue -msimple -t'Du stellst mental eine Verbindung zu Kandri \
	her. Nun ruhen ihre schuetzenden' klerus_sh = \
	/purge klerus_sh_g%;\
	/def -F -1 -p20 -agCblue -mregexp -t'Haende ueber (.+)\\\\.$$' \
		klerus_sh_g = \
		/if ({P1} =~ "Dir" ) \
			/set klerus_sh 1%%;\
			/echo -aCgreen Schutzhand%%;\
		/else \
			/echo -aCgreen Schutzhand %%P1%%;\
		/endif

/def -Fp20 -agCblue -msimple -t'Kandris schuetzende Haende verlassen Dich \
	wieder.' klerus_sh_out = \
	/set klerus_sh 0%;\
	/echo -aCred Schutzhand AUS%;\
	/if /ismacro autokampf_update%; /then \
		/autokampf_update /klerus_do_sh%;\
	/endif

/def -Fp20 -aCgreen -msimple -t'Du wirst schon geschuetzt.' \
	klerus_sh_already = /set klerus_sh 1
