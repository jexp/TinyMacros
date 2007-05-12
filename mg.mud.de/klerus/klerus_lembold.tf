/set klerus_lembold_tf_version $Id: klerus_lembold.tf,v 1.2 2002/11/05 14:38:11 thufhnik Exp $
/set klerus_lembold_tf_author=Deepblue@mg.mud.de
/set klerus_lembold_tf_requires=util.repeat.tf config.tf
/set klerus_lembold_tf_desc=Statuserweiterung der Lembold-Erleuchteten

;;; Variablen initialisieren

/set klerus_engel 0
/set klerus_engel_time 0
/set klerus_inquisitor 0
/set klerus_inquisitor_time 0
/set klerus_phoenix 0
/set klerus_phoenix_time 0

;;; Konfigurierbares

; Beistand Engel
/set_var CFG_STATUS_TEXT_KLERUS_ENGEL_4 E
/set_var CFG_STATUS_COLOR_KLERUS_ENGEL_4 Cbggreen
/set_var CFG_STATUS_TEXT_KLERUS_ENGEL_3 E
/set_var CFG_STATUS_COLOR_KLERUS_ENGEL_3 Cbgyellow
/set_var CFG_STATUS_TEXT_KLERUS_ENGEL_2 E
/set_var CFG_STATUS_COLOR_KLERUS_ENGEL_2 Cbgred
/set_var CFG_STATUS_TEXT_KLERUS_ENGEL_1 ~
/set_var CFG_STATUS_COLOR_KLERUS_ENGEL_1 Cred
/set_var CFG_MG_KLERUS_ENGEL_ECHO_TEXT Beistand Engel 
/set_var CFG_MG_KLERUS_ENGEL_ECHO_ATTR Cgreen
/set_var CFG_MG_KLERUS_ENGEL_AUS_ECHO_TEXT Beistand Engel weg
/set_var CFG_MG_KLERUS_ENGEL_AUS_ECHO_ATTR Cyellow

;;; Beistand Phoenix
/set_var CFG_STATUS_TEXT_KLERUS_PHOENIX_4 P
/set_var CFG_STATUS_COLOR_KLERUS_PHOENIX_4 Cbggreen
/set_var CFG_STATUS_TEXT_KLERUS_PHOENIX_3 P
/set_var CFG_STATUS_COLOR_KLERUS_PHOENIX_3 Cbgyellow
/set_var CFG_STATUS_TEXT_KLERUS_PHOENIX_2 P
/set_var CFG_STATUS_COLOR_KLERUS_PHOENIX_2 Cbgred
/set_var CFG_STATUS_TEXT_KLERUS_PHOENIX_1 ~
/set_var CFG_STATUS_COLOR_KLERUS_PHOENIX_1 Cred
/set_var CFG_MG_KLERUS_PHOENIX_ECHO_TEXT Beistand Phoenix
/set_var CFG_MG_KLERUS_PHOENIX_ECHO_ATTR Cgreen
/set_var CFG_MG_KLERUS_PHOENIX_AUS_ECHO_TEXT Beistand Phoenix weg
/set_var CFG_MG_KLERUS_PHOENIX_AUS_ECHO_ATTR Cyellow

;;; Beistand Inquisitor
/set_var CFG_STATUS_TEXT_KLERUS_INQUISITOR_2 I
/set_var CFG_STATUS_COLOR_KLERUS_INQUISITOR_2 Cbggreen
/set_var CFG_STATUS_TEXT_KLERUS_INQUISITOR_1 ~
/set_var CFG_STATUS_COLOR_KLERUS_INQUISITOR_1 Cred
/set_var CFG_MG_KLERUS_INQUISITOR_ECHO_TEXT Beistand Inquisitor
/set_var CFG_MG_KLERUS_INQUISITOR_ECHO_ATTR Cgreen
/set_var CFG_MG_KLERUS_INQUISITOR_AUS_ECHO_TEXT Beistand Inquisitor weg
/set_var CFG_MG_KLERUS_INQUISITOR_AUS_ECHO_ATTR Cyellow

;;; Statusmodule

/set sl_klerus_engel_doc=Beistand Engel: 80-100\%: $[status_doc_attr("KLERUS_ENGEL_4")] 30-70\%: $[status_doc_attr("KLERUS_ENGEL_3")] 0-30\%: $[status_doc_attr("KLERUS_ENGEL_2")] nicht moeglich: $[status_doc_attr("KLERUS_ENGEL_1")]
/def sl_klerus_engel = \
	/set_status_var_count klerus_engel klerus_engel 1 4

/set sl_klerus_phoenix_doc=Beistand Phoenix: 80-100\%: $[status_doc_attr("KLERUS_PHOENIX_4")] 30-70\%: $[status_doc_attr("KLERUS_PHOENIX_3")] 0-30\%: $[status_doc_attr("KLERUS_PHOENIX_2")] nicht moeglich: $[status_doc_attr("KLERUS_PHOENIX_1")]
/def sl_klerus_phoenix = \
	/set_status_var_count klerus_phoenix klerus_phoenix 1 4

/set sl_klerus_inquisitor_doc=Beistand Inquisitor: $[status_doc_attr("KLERUS_INQUISITOR_2")] nicht moeglich: $[status_doc_attr("KLERUS_INQUISITOR_1")]
/def sl_klerus_inquisitor = \
	/set_status_var_count klerus_inquisitor klerus_inquisitor 1 2

;;; Macros

/def klerus_bs_clear = \
	/test klerus_%1%;\
	/if ({?}==1) \
		/set klerus_%{1} 0%;\
	/endif

/def klerus_bs_out = \
	/let klerus_time_diff=%;\
	/test  klerus_time_diff:=klerus_%{1}_time%;\
	/let klerus_time_diff=$[time()-klerus_time_diff]%;\
	/if (klerus_time_diff>=600) \
		/set klerus_%{1}=0%;\
	/else \
		/let klerus_time_diff=$[600-klerus_time_diff]%;\
		/set klerus_%{1}=1%;\
		/repeat_once %klerus_time_diff /klerus_bs_clear %1%;\
	/endif

;;; Trigger

/def -p1 -agCblue -msimple -t'Du rufst Lembold an, Dir Deinen Schutzengel \
	zu schicken.' klerus_bs_schutzengel = \
	/cfg_echo MG_KLERUS_ENGEL %*%;\
	/set klerus_engel_time $[time()]%;\
	/set klerus_engel 4

/def -E(klerus_engel>1) -Fp1 -agCblue -mglob -t'* Schutzengel fliegt wieder \
	davon.' klerus_bs_schutzengel_out = \
	/let KLERUS_BS_OWNER $[tolower({1})]%;\
	/if (KLERUS_BS_OWNER=/"*s") \
		/let KLERUS_BS_OWNER=$[substr(KLERUS_BS_OWNER,0,-1)]%;\
	/endif%;\
	/if (KLERUS_BS_OWNER=~tolower(p_name)) \
		/cfg_echo MG_KLERUS_ENGEL_AUS %*%;\
		/klerus_bs_out engel%;\
	/else \
		/substitute -ax %*%;\
	/endif

/def -p1 -agCblue -msimple -t'Aus Deinen Haenden rieselt auf einmal etwas \
	Asche auf den Boden.' klerus_bs_phoenix = \
	/cfg_echo MG_KLERUS_PHOENIX %*%;\
	/set klerus_phoenix_time $[time()]%;\
	/set klerus_phoenix 4

/def -E(klerus_phoenix>1) -p1 -agCblue -msimple -t'Der Phoenix verbrennt in \
	einer hellen Flamme.' klerus_bs_phoenix_out = \
	/cfg_echo MG_KLERUS_PHOENIX_AUS %*%;\
	/klerus_bs_out phoenix

/def -p1 -agCblue -msimple -t'Du erflehst Lembolds Beistand auf der Suche \
	nach Wissen.' klerus_bs_inquisitor = \
	/cfg_echo MG_KLERUS_INQUISITOR %*%;\
	/set klerus_inquisitor_time $[time()]%;\
	/set klerus_inquisitor 2

/def -E(klerus_inquisitor>1) -p1 -agCblue -msimple -t'Der Inquisitor macht \
	sich aus dem Staub.' klerus_bs_inquisitor_out = \
	/cfg_echo MG_KLERUS_INQUISITOR_AUS %*%;\
	/klerus_bs_out inquisitor
