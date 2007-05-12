; $Log: inventory2.tf,v $
; Revision 1.1  2002/10/18 12:22:22  mh14
; Inventar begutachten
;

/set inventory2_tf_version=$Id: inventory2.tf,v 1.1 2002/10/18 12:22:22 mh14 Exp $
/set inventory2_tf_author=Mesirii@morgengrauen
/set inventory2_tf_requires=util.hooks.tf util.trigger.tf
/set inventory2_tf_desc=Pruefen ob gewisse Gegenstaende im Inv vorhanden sind

; Idee, Konfiguration: id, String, ggf. Kategorie(n) (z.B. Tanke), Makro zum ausfuehren, attribute
/def inv_trigger = \
     /foreach inv_items kv /inv_item_trigger


/def add_inv_item = \
     /createnewlist inv_items%;\
     /uaddlisttolist inv_items %*

/def inv_get_count = \
     /if ({*}=/"*(geoeffnet)*") /let inv_open=1%; \
     /elseif ({*}=/"*(geschlossen)*") /let inv_open=0%; \
     /else /let inv_open=-1%;\
     /endif%;\
     /if ({*}=/"*(angezogen)*" | {*}=/"*(gezueckt)*") /let inv_worn=1%; \
     /else /let inv_worn=-1%;\
     /endif%;\
;     /echo %* : open: %inv_open getragen: %inv_worn%;\
     /let inv_akt_count=1%;\
     /if ({1}=/"{Ein|Eine}") /test inv_akt_count:=1%; \
     /elseif ({1}=/"[0-9]*") /test inv_akt_count:={1}%;\
     /endif%;\
     /if ({L}=/"([0-9]*)") /test inv_akt_count:=inv_akt_count*substr({L},1,-1)%; \
     /endif%;\
     /return ret_vars('inv_akt_count','inv_open','inv_worn')
     

/def inv_item_trigger = \
     /purge_vars inv_tmp_*%;\
     /test tokenize("|",{-1},"inv_tmp_")%;\
     /def -E(inv_get) -t" %inv_tmp_1" %inv_tmp_2 t_inv_%1 = \
          /let inv_item=%1\%;\
	  /inv_get_count \%*\%;\
	  /test \%?\%;\
	  /set inv_item_%1=\$[inv_item_%1+inv_akt_count]\%;\
          /inv_cat %1 $[replace(","," ",inv_tmp_3)]\%;\
	  %inv_tmp_4

/def inv_cat = \
     /let inv_item=%1%;/shift%;\
     /while ({#}) \
	/inv_add_cat %1%;\
        /shift%;\
     /done%;\
     /inv_add_cat %{inv_akt_cat}

/def inv_add_cat = \
        /init_var inv_cat_%1 inv_count_%1%;\
	/if /test inv_cat_%1!/strcat("*{",inv_item,"}*")%; /then \
           /test inv_cat_%1:=strcat(inv_cat_%1," ",inv_item)%;\
	/endif%;\
	/test inv_count_%1:=inv_count_%1+inv_akt_count%;\
     
/def inv_clear = \
     /purge_vars inv_cat_*%;\
     /purge_vars inv_count_*%;\
     /purge_vars inv_item_*%;

/def -t"Waffen:" -msimple t_inv_waffen = \
     /inv_clear%;\
     /set inv_akt_cat=waffen%;\
     /inv_catch

/def -t"Kleidung & Ruestungen:" -msimple t_inv_ruestung = \
     /set inv_akt_cat=ruestung%;\
     /inv_catch

/def -t"Verschiedenes:" -msimple t_inv_other = \
     /set inv_akt_cat=sonstiges%;\
     /inv_catch

/def inv_catch = \
     /set inv_get=1%;\
     /def -t"*" -p2 -F t_end_inv = /if ({*}!/"*." & {*}!/"*. ([0-9]*)") /purge t_end_inv\%; /set inv_get=0\%; /endif
; Konfigurierbares

;/def -p3 -F -t"  +" -mregexp t_split_line = \
;     /test substitute(strcat({PL},char(13),{PR}))%;\

/add_inv_item matrix Der Matrixkristall von *.|-aCblue|matrix
/add_inv_item seil Ein Seil.|-ag
/add_inv_item schaufel Eine Schaufel.|-ag
/add_inv_item gladi_pass Ein Passierschein.|-ag
/add_inv_item zoll_pass Eine Einreisegenehmigung.|-ag
/add_inv_item drops Ein *drops.*|-aCgreen|tanke
/add_inv_item waffe *(gezueckt).|-aCred|waffe
/add_inv_item ausruestung *(angezogen).|-aCred|ausruestung
/add_inv_item paket *Postpaket*|-aCyellow|paket|/inv_open
/add_inv_item pfirsich Ein Pfirsich (leuchtend).|-aBCyellow|licht
/add_inv_item steine * Stein*.|-aCcyan|ari
/add_inv_item sterne * Wurfstern*.|-aCcyan|ari
/add_inv_item bpfeile * Bolzenpfeil*.|-aCcyan|ari,bolzen

/def inv_open = \
     /if (inv_open==0) oeffne %inv_item%; /endif

/def inv_cats = \
     /echo Kategorien:%;\
     /quote -S /inv_cats2 `/listvar -s inv_cat_*%;

/def inv_cats2 = \
     /echo $[substr({1},8)] ($[inner_var(replace("_cat_","_count_",{1}))]): $[inner_var({1})]

/add_to_hook first_connect /inv_trigger
