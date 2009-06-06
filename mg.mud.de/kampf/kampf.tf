; $Log: kampf.tf,v $
; Revision 1.9  2002/05/16 16:42:45  nieten
; keine Fehlermeldung mehr beim Teamangriff
;
; Revision 1.8  2002/04/28 02:06:29  mh14
; kampfschalter auch in fremden trefferrunden aktualisiert
;
; Revision 1.7  2002/02/10 22:36:40  mh14
; Statuszeilendoku
;
; Revision 1.6  2001/11/27 13:59:26  mh14
;  kampfrunde_time wird schon von kampf abgedeckt, sl_* angepasst an status.tf
;
; Revision 1.5  2001/10/19 14:37:46  mh14
; Aenderungen an der Statuszeile, diese ist jetzt Schneller, hoffentlich Problematik der parallelen threads (globale Variable (value) behoben
;
; Revision 1.4  2001/10/08 17:57:17  mh14
; Status Modul Spellwaffe
;
; Revision 1.3  2001/10/07 18:38:20  mh14
; Status Modul kampf, Anpassungen an neue spell.tf und ari.tf
;
; Revision 1.2  2001/10/05 00:21:24  nieten
; Log eingefuegt
;

/set kampf_tf_version $Id$
/set kampf_tf_author=Mesirii@mg.mud.de
/set kampf_tf_requires=lists.tf spells.tf weapon.tf mg_properties.tf ari.tf
/set kampf_tf_desc Kampfrunden, Arinutzung, Spellwaffenspells, Kampf-Hooks

/def kampf_runde = \
    /if (time()-kampf<2) /return%; /endif%;\
;    /set kampf_runde_time=$[time()]%;\
    /kampf_start%;\
    /if (ari_use) \
       /ari_throw%;\
    /endif%;\
    /if (kampf_spell!~"") \
       /if (kampf_spellwaffe_spell) \
	 /kampf_spellwaffe_spell_kampfwaffe%;\
       /else \
         /spell_set_and_cast %kampf_spell%;\
       /endif%;\
    /endif%;\
    /eval_hook kampf_runde

/def kampf_start = \
     /if (kampf>-1) \
	/set kampf=$[time()] %; \
	/set do_beat_5=1%;\
     /endif%;

/def kampf_check= \
  /if (kampf>0 & (time()-kampf)>4) /kampf_stop%; \
  /endif%;

/def -mglob -p100 -F \
	-t"  Du greifst * mit * an." \
	t_kampfrunde_angriffsmeldung = \
	/kampf_runde%;

/def -mglob -p100 -F \
	-t"  * greift Dich mit * an." \
	t_kampfrunde_angriffsmeldung2 = \
	/kampf_start%;

/def -F -aCblue -mglob -t"Du siehst * Angriffsmeldungen von Dir." t_test_angriffsmeldung = \
     /set kampf_angriffsmeldung=$[({3}=~"saemtliche")]%;

/def -E(!kampf_angriffsmeldung) -mglob -p100 -F \
	-t"  Du {triffst|kitzelst|verfehlst|kratzt} *" \
	t_kampfrunde_treffer = \
	/kampf_runde%;

/def kampf_stop = \
	/set kampf=0%;\
	/createlist zqueue%;\
	/ari_init 0%;\
	/set kampf_spell=%; \
;/set do_beat_5=0%; /set do_beat_30=0%;\
	/eval_hook kampf_stopped%;

/def kampf_start_spell_ari = /ari_init 1%;/set kampf_spell=%*%;/kampf_runde
/def kampf_start_spell_only = /ari_init 0%;/set kampf_spell=%*%;/kampf_runde
/def kampf_start_ari_only = /ari_init 1%;/set kampf_spell=%;/kampf_runde

/def -t"*startet den Angriff*" -mglob kampf_t_team_angriff = \
    /if (ismacro("kampf_team_angriff")) \
        /kampf_team_angriff%;\
    /endif

/def kampf_spellwaffe = \
	/set kampf_spellwaffe=%*%; \
	/getvalueof weapons %kampf_spellwaffe%;\
	/if (value!~error) \
	  /echo Spellwaffe: %value%;\
	/else /echo keine spezielle Spellwaffe!%;/set kampf_spellwaffe=%;\
	/endif%;\
	

/def kampf_spellwaffe_spell_kampfwaffe = \
 /spell_set %kampf_spell%;\
 /if (p_mp>=zmp) \
; & sperrzeit == 0 ) \
 /if (kampf_spellwaffe=~"" | kampf_spellwaffe=~weapon_short) \
   /spell_cast%;\
 /else \
   /let kampf_spellwaffe_save=%weapon_short%;\
   /sw %kampf_spellwaffe%;\
   /spell_cast%;\
   /sw %kampf_spellwaffe_save%;\
 /endif%;\
 /endif

/set sl_spellwaffe_doc=Waffe, die speziell fuer Spell gezueckt wird
/def sl_spellwaffe = \
     /init_var kampf_spellwaffe%;\
     /set status_func_kampf_spellwaffe=status_get_schaden_attr(kampf_spellwaffe,weapon_get_damage(kampf_spellwaffe),"status_spellwaffe")%;\
     /test status_var("kampf_spellwaffe",3)%;\
     /return strcat("\$[weapon_drawn?status_spellwaffe : ':3']")

/set sl_kampf_doc=Wenn im Kampf rotes +, wenn Kampfrunde weniger als 1 Sekunde alt fett-rotes #
/def sl_kampf = \
  /init_var kampf%;\
  /set status_func_kampf=(kampf>0)? ((time()-kampf<1)?"#" : "+") : ""%;\
  /set status_attr_kampf=(kampf>0)? ((time()-kampf<1)?"BCred" : "Cred") : "n"%;\
  /return status_var("kampf",1)

/addh_fileinfo



