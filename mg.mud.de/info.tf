; $Log: info.tf,v $
; Revision 1.10  2003/10/16 19:26:11  thufhnik
; Info_kurz -> InfoKurz da es sonst Kollisionen mit den /purges gibt
;
; Revision 1.9  2003/10/10 19:54:52  thufhnik
; neues Macro: Info_kurz
;
; Revision 1.8  2003/04/13 15:41:16  thufhnik
; kleiner Bugfix in ep-diffs
;
; Revision 1.7  2002/11/20 08:43:20  thufhnik
; Anpassung an die neuen Farben
;
; Revision 1.6  2002/06/24 10:03:57  thufhnik
; p_maxlp und p_maxmp errechnen, irgendwas schein noch in mg_properties.tf
; faul zu sein, kann es aber leider nicht lokalisieren.
;
; Revision 1.5  2002/04/24 09:47:33  thufhnik
; kleiner bugfix in den config-lines
;
; Revision 1.4  2002/04/23 08:47:34  thufhnik
; grausamer Code, aber konfigurierbare Ausgabe
;
; Revision 1.3  2002/04/03 13:50:58  thufhnik
; fuer p_poison die Zeit setzen
;
; Revision 1.2  2002/04/03 13:33:07  thufhnik
; -mglob fuer /purge Info* hinzugefuegt
;
; Revision 1.1  2002/04/03 13:30:22  thufhnik
; Scratch
;

/set info_tf_version=$Id$
/set info_tf_author=Thufhir@mg.mud.de
/set info_tf_requires=mg_properties.tf util.vfunc.tf
/set info_tf_desc=Info schoener anzeigen

/set_var CFG_INFO_COLOR_TEXT xCcyan
/set_var CFG_INFO_COLOR_NO_ESCAPE Cred
/set_var CFG_INFO_COLOR_WHIMPIE_ONLY Cmagenta
/set_var CFG_INFO_COLOR_ESCAPE_COMPLETE Cgreen

/set_var CFG_INFO_LINE_1 @{x}
/set_var CFG_INFO_LINE_2 Titel: %p_full_name
/set_var CFG_INFO_LINE_3 Stufe: %p_level/%p_new_level/%p_guild_level,  \
	AP: %p_ap/%p_seher_ap,  %INFO_MEP,%INFO_kEP MEP (%INFO_kEPJ k/\
	%INFO_kEPH k),  @{x%INFO_FFarbe}Groesse: %p_size cm
/set_var CFG_INFO_LINE_4 Ausdauer: %p_base_const (%p_mod_const)  \
	Intelligenz: %p_base_int (%p_mod_int)  Kraft: %p_base_str \
	(%p_mod_str)  Geschick: %p_base_dex (%p_mod_dex)
/set_var CFG_INFO_LINE_5 Todesfolgen: %INFO_Tode  Gesinnung: \
	%p_align  @{x%INFO_GFarbe}Gift: %p_poison@{x%CFG_INFO_COLOR_TEXT}  \
	Ende moeglich: %INFO_Ende
/set_var CFG_INFO_LINE_6 Vorsicht: %INFO_VS, Fluchtrichtung: %INFO_FR

;;; vorhandene Trigger aus dem Speicher loeschen:

/purge InfoTrigger
/purge InfoOut
/purge InfoKurz
/purge -mglob Info_*
/purge remove_info

;;; Alle Macros und Trigger koennen per Befehl wieder entfernt werden:

/def remove_info=\
	/echo -paCred >>> Entferne Paket: @{Cyellow}info.tf%;\
	/echo%;\
	/purge InfoTrigger%;\
	/purge InfoTriggerStart%;\
	/purge InfoTriggerCh%;\
	/purge InfoOut%;\
	/purge InfoKurz%;\
	/purge -mglob Info_*%;\
	/purge_vars INFO_*%;\
	/purge remove_info

;;; Ab hier gehts eigentlich los

/def -p10 -q -ag -mregexp -t'^- (\\(?.+(\\.|\\) ))( -+|)' InfoTrigger=\
     /if ({*}=/"*[.-]") \
     	  /def -1 -F -p21 -t"*" InfoTriggerCheck = \
	       /if ({*}!/"*........*") \
     	           /echo -- %*%%;\
	           /purge -mglob Info_*%%;\
                /endif%;\
          /InfoTriggerStart%;\
     /else \
	   /substitute -ax -- %*%;\
     /endif

/def InfoTriggerStart = \
	/set p_full_name %P1%;\
	/set INFO_Ende ja%;\
	/set INFO_WMeldung keine%;\
	/set INFO_VMeldung keine%;\
	/def -p20 -1 -q -ag -mregexp -t'^Rasse \\\\.\\\\.\\\\.\\\\.\\\\.\
		\\\\.\\\\.\\\\.\\\\.\\\\.\\\\.\\\\. ([A-Z][a-z]+) +\
		Abenteuer \\\\.\\\\.\\\\.\\\\.\\\\.\\\\.\\\\.\\\\. +\
		([0-9]+) (\\\\(([0-9]+)\\\\))?$$' Info_1=\
		/setprop race $$[tolower({P1})]%%;\
		/setprop ap %%P2%%;\
		/if ({P4} !~ '') \
			/setprop seher_ap %%P4%%;\
		/else \
			/setprop seher_ap %%p_ap%%;\
		/endif%;\
	/def -p19 -n2 -q -ag -mregexp -t'^$$' Info_2%;\
	/def -p20 -1 -q -ag -mregexp -t'^Geschlecht \\\\.\\\\.\\\\.\\\\.\
		\\\\.\\\\.\\\\. ([a-z]+) +Groesse \\\\.\\\\.\\\\.\
		\\\\.\\\\.\\\\.\\\\.\\\\.\\\\.\\\\. +([0-9]+) +cm$$' Info_3=\
		/setprop gender %%P1%%;\
		/setprop size %%P2%;\
	/def -p20 -1 -q -ag -mregexp -t'^Stufe \\\\.\\\\.\\\\.\\\\.\\\\.\
		\\\\.\\\\.\\\\.\\\\.\\\\.\\\\.\\\\. +([0-9]+) +\
		\\\\(?([0-9]+)?\\\\)? +Gewicht \\\\.\\\\.\\\\.\\\\.\
		\\\\.\\\\.\\\\.\\\\.\\\\.\\\\. +([0-9]+) +kg$$' Info_4=\
		/setprop level %%P1%%;\
		/if ({P2} !~ "") \
			/setprop new_level %%P2%%;\
		/else \
			/setprop new_level %%p_level%%;\
		/endif%%;\
		/setprop weight %%P3%;\
	/def -p20 -1 -q -ag -mregexp -t'^Gilde \\\\.\\\\.\\\\.\\\\.\\\\.\
		\\\\.\\\\.\\\\.\\\\.\\\\.\\\\.\\\\. ([A-Z][a-z]+) +\
		Gildenstufe \\\\.\\\\.\\\\.\\\\.\\\\.\\\\. +([0-9]+)$$' Info_5=\
		/setprop guild $$[tolower({P1})]%%;\
		/setprop guild_level %%P2%;\
	/def -p20 -1 -q -ag -mregexp -t'^Erfahrung \\\\.\\\\.\\\\.\\\\.\\\\.\
		\\\\.\\\\.\\\\. +([0-9]+) Punkte +(Charakter|Gesinnung) \\\\.\\\\.\\\\.\
       		\\\\.\\\\.\\\\.\\\\.\\\\. ([a-z]+)$$' Info_6=\
		/if (!INFO_EP_BASE) /set INFO_EP_BASE %%P1%%; /endif%%;\
		/if (!p_ep) /setprop ep %%P1%%; /endif%%;\
		/set INFO_EP_DIFF_SHORT $$[{P1} - p_ep]%%;\
		/set INFO_EP_DIFF_LONG $$[{P1} - INFO_EP_BASE]%%;\
		/if (abs(INFO_EP_DIFF_SHORT) > abs(INFO_EP_DIFF_LONG)) \
			/set INFO_EP_DIFF_SHORT %%INFO_EP_DIFF_LONG%%;\
		/endif%%;\
		/setprop ep %%P1%%;\
		/setprop align %%P3%;\
	/def -Fp24 -1 -q -ag -mregexp -t'Geschicklichkeit \\\\. +([0-9]+)\
		( +\\\\(([-+0-9]+)\\\\))?' Info_7=\
		/setprop base_dex %%P1%%;\
		/if ({P3}) \
			/setprop mod_dex %%P3%%;\
		/else \
			/setprop mod_dex +0%%;\
		/endif%;\
	/def -Fp23 -1 -q -ag -mregexp -t'Ausdauer \\\\.\\\\.\\\\.\\\\.\\\\.\
		\\\\.\\\\.\\\\.\\\\. +([0-9]+)( +\\\\(([-+0-9]+)\\\\))?' \
		Info_8=\
		/setprop base_const %%P1%%;\
		/if ({P3}) \
			/setprop mod_const %%P3%%;\
		/else \
			/setprop mod_const +0%%;\
		/endif%%;\
		/setprop const $$[p_base_const+p_mod_const]%;\
	/def -Fp22 -1 -q -ag -mregexp -t'Kraft \\\\.\\\\.\\\\.\\\\.\\\\.\\\\.\
		\\\\.\\\\.\\\\.\\\\.\\\\.\\\\. +([0-9]+)( +\\\\(([-+0-9]+)\
		\\\\))?' Info_9=\
		/setprop base_str %%P1%%;\
		/if ({P3}) \
			/setprop mod_str %%P3%%;\
		/else \
			/setprop mod_str +0%%;\
		/endif%;\
	/def -Fp21 -1 -q -ag -mregexp -t'Intelligenz \\\\.\\\\.\\\\.\\\\.\\\\.\
		\\\\. +([0-9]+)( +\\\\(([-+0-9]+)\\\\))?' Info_10=\
		/setprop base_int %%P1%%;\
		/if ({P3}) \
			/setprop mod_int %%P3%%;\
		/else \
			/setprop mod_int +0%%;\
		/endif%%;\
		/setprop int $$[p_base_int+p_mod_int]%;\
	/def -p20 -1 -q -ag -mregexp -t'^Gesundheit \\\\.\\\\.\\\\.\\\\.\\\\.\
		\\\\.\\\\. +([0-9]+) +(\\\\([0-9]+\\\\))? +Gift \\\\.\\\\.\
		\\\\.\\\\.\\\\.\\\\.\\\\.\\\\.\\\\.\\\\.\\\\.\\\\.\\\\. +\
		(.*)$$' Info_11=\
		/set p_lp %%P1%%;\
		/set p_poison %%P3%;\
	/def -p20 -1 -q -ag -mregexp -t'^Konzentration \\\\.\\\\.\\\\.\\\\. \
		+([0-9]+) +(\\\\([0-9]+\\\\))? + Vorsicht \\\\.\\\\.\
		\\\\.\\\\.\\\\.\\\\.\\\\.\\\\.\\\\. +(.*)$$' Info_12=\
		/set p_mp %%P1%%;\
		/set INFO_VS %%P3%%;\
		/if (INFO_VS =~ 'mutig') \
			/set INFO_VS 0%%;\
		/endif%;\
	/def -p20 -1 -q -ag -F -mregexp -t'^Todesfolgen\\\\.\
		\\\\.\\\\.\\\\.\\\\.\\\\.\\\\. ([0-9]+|kein Malus) +($$|\
		Fluchtrichtung \\\\.\\\\.\\\\. \\\\"(.*)\\\\")' Info_13=\
		/set INFO_Tode %%P1%%;\
		/if (INFO_Tode =~ 'kein Malus') \
			/set INFO_Tode 0%%;\
		/endif%%;\
		/set INFO_FR=%%P3%;\
	/def -p19 -q -ag -mglob -t'*' Info_14%;\
	/def -p20 -1 -ag -q -mregexp -t'^Spiel verlassen \\\\.\\\\. nicht \
		moeglich$$' Info_15=\
		/set INFO_Ende NEIN!%;\
	/def -p20 -1 -ag -q -mregexp -t'^Du bist nicht ansprechbar:' Info_16=\
		/set INFO_WMeldung %%P0%%PR%;\
	/def -p20 -1 -ag -q -mregexp -t'^Du verfolgst (.*[^ ])' Info_17=\
		/set INFO_VMeldung %%P0%%;\
		/if (INFO_VMeldung !/ '*.') \
			/def -p22 -q -ag -mglob -t'*' Info_17a=\\
				/set INFO_VMeldung %%%INFO_VMeldung %%%{*}%%%;\
				/if (INFO_VMeldung =/ '*.') \
					/purge Info_17a%%%;\
				/endif%%;\
		/endif%;\
	/def -p23 -1 -ag -q -mregexp -t'^---------+$$' Info_18=\
        	/purge Info_17a%%;\
		/InfoOut

/def InfoOut = \
   	/let INFO_MEP $[p_ep / 1000000]%;\
   	/let INFO_kEP $[(p_ep - INFO_MEP * 1000000) / 100000]%;\
   	/let INFO_kEPJ $[INFO_EP_DIFF_SHORT / 1000]%;\
   	/let INFO_kEPH $[INFO_EP_DIFF_LONG / 1000]%;\
   	/if (INFO_kEPJ > 0) /let INFO_kEPJ +%INFO_kEPJ%; /endif%;\
  	/if (INFO_kEPH > 0) /let INFO_kEPH +%INFO_kEPH%; /endif%;\
	/if (p_size == 20) \
		/set_flag p_frog%;\
	/else \
		/set p_frog 0%;\
	/endif%;\
	/let INFO_FFarbe=%;\
	/test INFO_FFarbe:=%status_attr_p_frog%;\
	/let INFO_GFarbe=%;\
	/test INFO_GFarbe:=%status_attr_p_poison%;\
	/if (INFO_VS == 0) \
		/let SH_VSFarbe %CFG_INFO_COLOR_NO_ESCAPE%;\
	/else \
		/let SH_VSFarbe %CFG_INFO_COLOR_WHIMPIE_ONLY%;\
	/endif%;\
	/if (INFO_FR !~ "") \
		/let SH_VSFarbe %CFG_INFO_COLOR_ESCAPE_COMPLETE%;\
	/endif%;\
	/let count=0%;\
	/while /test (++count < 10)%; /do \
		/if /test (CFG_INFO_LINE_%count!~"")%; /then \
			/eval /eval /echo -pa%CFG_INFO_COLOR_TEXT -- \
				\%CFG_INFO_LINE_%count%;\
		/endif%;\
	/done%;\
	/if (INFO_WMeldung !~ "keine") \
		/echo %INFO_WMeldung%;\
	/endif%;\
	/if (INFO_VMeldung !~ "keine") \
		/echo %INFO_VMeldung%;\
	/endif%;\
	/if (p_poison =~ 'gesund') \
		/set p_poison=%;\
	/else \
		/set p_poison_time=$[time()]%;\
	/endif%;\
	/setprop maxlp $[42+8*p_const]%;\
	/setprop maxmp $[42+8*p_int]%;\
	/if (p_lp > p_maxlp) /setprop maxlp %p_lp%;/endif%;\
	/if (p_mp > p_maxmp) /setprop maxmp %p_mp%;/endif%;\
	/purge -mglob Info_*%;\
	/check_vorsicht %INFO_VS %INFO_FR%;\
	/eval_hook property_update

; Abfrage der LP und KP ueber "kurzinfo"

/def InfoKurz = \
	/def -1 -mregexp -p1 -w -q -agCblue -t'^Gesundheit: +0 \\\\|#*[. ]*\
		\\\\| +([1-9][0-9]*)( \\\\(([1-9][0-9]*)\\\\))?$$' \
		Info_kurz_lp = \
		/set p_lp %%P1%%;\
		/if ({P2}!~'') \
			/set p_maxlp %%P3%%;\
		/else \
			/set p_maxlp %%P1%%;\
		/endif%;\
	/def -1 -mregexp -p1 -w -q -agCblue -t'^Konzentration: +0 \\\\|#*[. ]*\
		\\\\| +([1-9][0-9]*)( \\\\(([1-9][0-9]*)\\\\))?$$' \
		Info_kurz_kp = \
		/let Info_cont=%*%%;\
		/set p_mp %%P1%%;\
		/if ({P2}!~'') \
			/set p_maxmp %%P3%%;\
		/else \
			/set p_maxmp %%P1%%;\
		/endif%%;\
		/if (Info_cont!~'') \
			/eval %%Info_cont%%;\
		/endif%;\
	/send !\\kurzinfo
