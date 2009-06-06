;
; $Log: mg_properties_status.tf,v $
; Revision 1.2  2003/12/19 16:04:43  thufhnik
; Farben fuer LP in der statuszeile auch konfigurierbar
;
; Revision 1.1  2002/11/27 10:58:39  mh14
; trennung von mg_properties.tf von den statuszeilensettings
;
;

/set mg_properties_status_tf_version $Id$
/set mg_properties_status_tf_author=Mesirii@mg.mud.de
/set mg_properties_status_tf_requires=lists.tf util.tf util.hooks.tf util.trigger.tf util.sfunc.tf status.tf(1.19) mg_properties.tf(1.46)
/set mg_properties_status_tf_desc Statuszeilendefinitionen für Morgengrauen Properties

; ********************* BEGIN CONFIG ********************
; properties.tf

/cfg_info status mg all (COLOR|TEXT)_LP	Lebenspunkte:2:3
/cfg_info status mg all (COLOR|TEXT)_MP	Magiepunkte:2:3
/cfg_info status mg all (COLOR|TEXT)_ALIGN	Alignment:2:3
/cfg_info status mg all (COLOR|TEXT)_BLIND Blindheit:2:3
/cfg_info status mg all (COLOR|TEXT)_DEAF Taubheit:2:3
/cfg_info status mg all (COLOR|TEXT)_FROG Verfroschung:2:3
/cfg_info status mg all (COLOR|TEXT)_POISON Gift:2:3
/cfg_info status mg all (COLOR|TEXT)_BLOCK Block:2:3


; Elfenbeinblock

/set sl_block_doc=Blockanzeige: geladen $[status_doc_attr("BLOCK_1")], leer: $[status_doc_attr("BLOCK")]

/set_var CFG_STATUS_COLOR_BLOCK_1=Cyellow
/set_var CFG_STATUS_TEXT_BLOCK_1=+
/set_var CFG_STATUS_COLOR_BLOCK=n
/set_var CFG_STATUS_TEXT_BLOCK=
/set_status_var_flag p_block p_block 1

; Gift

/set_var CFG_STATUS_COLOR_POISON_1=Cred
/set_var CFG_STATUS_TEXT_POISON_1=g
/set_var CFG_STATUS_COLOR_POISON_2=BCred
/set_var CFG_STATUS_TEXT_POISON_2=G
/set_var CFG_STATUS_COLOR_POISON_3=BCbgred
/set_var CFG_STATUS_TEXT_POISON_3=G

/set sl_poison_doc=Giftanzeige: leicht: $[status_doc_attr("POISON_1")] schwer $[status_doc_attr("POISON_2")], gefaehrlich $[status_doc_attr("POISON_3")]

/set_status_var_string p_poison p_poison 1 leicht schwer gefaehrlich

; Lebenspunkte

/set_var CFG_STATUS_COLOR_LP_1=Cred
/set_var CFG_STATUS_COLOR_LP_2=Cyellow
/set_var CFG_STATUS_COLOR_LP=Cgreen

/set sl_lp_doc=Lebenspunkte, $[status_doc_attr("LP_1","<1/3%","LP_2","<2/3%", "LP","sonst")]
/eval /set_status_var_num p_lp p_lp 3 p_maxlp/3 %{CFG_STATUS_COLOR_LP_1} p_maxlp*2/3 %{CFG_STATUS_COLOR_LP_2} %{CFG_STATUS_COLOR_LP}

; Magiepunkte (+ Elfenbeinblock)

/set_var CFG_STATUS_COLOR_MP_1=Cred
/set_var CFG_STATUS_COLOR_MP_2=Cyellow
/set_var CFG_STATUS_COLOR_MP=Cgreen
; Wenn eingeschaltet werden die MP hinterlegt wenn der Block leer/voll ist, je nach Farbwahl

/addh info MP-Hinterlegung wenn Block voll/leer ist
/addh dtype flag
/addh CFG_STATUS_COLOR_MP_BLOCK_FLAG cfg

/set_var CFG_STATUS_COLOR_MP_BLOCK_FLAG=0
/set_var CFG_STATUS_COLOR_MP_BLOCK_VOLL=n
/set_var CFG_STATUS_COLOR_MP_BLOCK_LEER=Cbgwhite

/set sl_mp_doc=Magie-,Konzentrationspunkte, $[status_doc_attr("MP_33","<1/3%","MP_66","<2/3%", "MP","sonst")] $[CFG_STATUS_COLOR_MP_BLOCK_FLAG ? strcat("Blockanzeige:",status_doc_attr("MP_BLOCK_VOLL","voll","MP_BLOCK_LEER","leer")) : ""]

/def sl_mp = \
  /init_var p_maxmp p_mp%;\
  /set status_attr_p_mp=$[attr_ordered("p_mp","(p_maxmp/3)",CFG_STATUS_COLOR_MP_1,"(p_maxmp*2/3)",CFG_STATUS_COLOR_MP_2,CFG_STATUS_COLOR_MP)]%;\
  /if (CFG_STATUS_COLOR_MP_BLOCK_FLAG) \
    /test status_attr_p_mp:=strcat("strcat(",status_attr_p_mp,",','",", p_block>0 ? CFG_STATUS_COLOR_MP_BLOCK_VOLL : ( p_block!~'' ? CFG_STATUS_COLOR_MP_BLOCK_LEER : '') )")%;\
  /endif%;\
  /return status_var("p_mp",3)
/set_var CFG_STATUS_COLOR_MP_1=Cred
/set_var CFG_STATUS_COLOR_MP_2=Cyellow
/set_var CFG_STATUS_COLOR_MP=Cgreen
; Wenn eingeschaltet werden die MP hinterlegt wenn der Block leer/voll ist, je nach Farbwahl

/addh info MP-Hinterlegung wenn Block voll/leer ist
/addh dtype flag
/addh CFG_STATUS_COLOR_MP_BLOCK_FLAG cfg

/set_var CFG_STATUS_COLOR_MP_BLOCK_FLAG=0
/set_var CFG_STATUS_COLOR_MP_BLOCK_VOLL=n
/set_var CFG_STATUS_COLOR_MP_BLOCK_LEER=Cbgwhite

/set sl_mp_doc=Magie-,Konzentrationspunkte, $[status_doc_attr("MP_33","<1/3%","MP_66","<2/3%", "MP","sonst")] $[CFG_STATUS_COLOR_MP_BLOCK_FLAG ? strcat("Blockanzeige:",status_doc_attr("MP_BLOCK_VOLL","voll","MP_BLOCK_LEER","leer")) : ""]

/def sl_mp = \
  /init_var p_maxmp p_mp%;\
  /set status_attr_p_mp=$[attr_ordered("p_mp","(p_maxmp/3)",CFG_STATUS_COLOR_MP_1,"(p_maxmp*2/3)",CFG_STATUS_COLOR_MP_2,CFG_STATUS_COLOR_MP)]%;\
  /if (CFG_STATUS_COLOR_MP_BLOCK_FLAG) \
    /test status_attr_p_mp:=strcat("strcat(",status_attr_p_mp,",','",", p_block>0 ? CFG_STATUS_COLOR_MP_BLOCK_VOLL : ( p_block!~'' ? CFG_STATUS_COLOR_MP_BLOCK_LEER : '') )")%;\
  /endif%;\
  /return status_var("p_mp",3)

; Erfahrungspunkte

/set_var CFG_STATUS_COLOR_EP=n
/set_var CFG_STATUS_COLOR_EP_M=Cblue
/set_var CFG_STATUS_COLOR_EP_K=Cyellow

/set sl_ep_doc=Erfahrungspunkte $[status_doc_attr("EP_M",">1 Mio: xxxM","EP_k", ">1000: xxxk", "EP", "sonst")]

/def sl_ep = \
  /init_var p_ep%;\
  /set status_func_p_ep=format_number(p_ep)%;\
  /set status_attr_p_ep=p_ep>=1000000? CFG_STATUS_COLOR_EP_M : p_ep>=1000 ? CFG_STATUS_COLOR_EP_K : CFG_STATUS_COLOR_EP%;\
  /return status_var("p_ep",4)

; Taubheit

/set_var CFG_STATUS_COLOR_DEAF_1=Cbgmagenta
/set_var CFG_STATUS_TEXT_DEAF_1=T
/set_status_var_flag p_deaf 0 1
/set sl_deaf_doc=Taubheitsanzeige, wenn taub: $[status_doc_attr("DEAF_1")]

; Frosch

/set_var CFG_STATUS_COLOR_FROG_1=Cbggreen
/set_var CFG_STATUS_TEXT_FROG_1=F
/set_status_var_flag p_frog 0 1
/set sl_frog_doc=Froschanzeige, wenn Frosch: $[status_doc_attr("FROG_1")]

; Blindheit

/set_var CFG_STATUS_COLOR_BLIND_1=Cbgmagenta 
/set_var CFG_STATUS_TEXT_BLIND_1=B
/set_status_var_flag p_blind 0 1
/set sl_blind_doc=Blindheitsanzeige, wenn blind: $[status_doc_attr("BLIND_1")]

; Arztflag

/set sl_arzt_doc=Kombination von blind,deaf,gift,frog (Blind,Taub,Gift,Frosch)

/def sl_arzt = \
;  /return strcat(sl_blind()," ",sl_deaf()," ",sl_gift()," ",sl_frog())
  /return strcat(status_line_blind," ",status_line_deaf," ",status_line_poison," ",status_line_frog)

; Alignment

/set sl_align_doc=Alignment von heilig: +++,rot bis satanisch: ---,blau
/set_var CFG_STATUS_COLOR_ALIGN=n
/set_var CFG_STATUS_COLOR_ALIGN_1=BCred
/set_var CFG_STATUS_TEXT_ALIGN_1=+++
/set_var CFG_STATUS_COLOR_ALIGN_2=BCyellow
/set_var CFG_STATUS_TEXT_ALIGN_2=++
/set_var CFG_STATUS_COLOR_ALIGN_3=Cyellow
/set_var CFG_STATUS_TEXT_ALIGN_3=+
/set_var CFG_STATUS_COLOR_ALIGN_4=BCgreen
/set_var CFG_STATUS_TEXT_ALIGN_4=*
/set_var CFG_STATUS_COLOR_ALIGN_5=Cgreen
/set_var CFG_STATUS_TEXT_ALIGN_5=-
/set_var CFG_STATUS_COLOR_ALIGN_6=Cblue
/set_var CFG_STATUS_TEXT_ALIGN_6=--
/set_var CFG_STATUS_COLOR_ALIGN_7=BCblue
/set_var CFG_STATUS_TEXT_ALIGN_7=---

/set_status_var_string p_align p_align 3 heilig gut nett neutral frech boese satanisch
