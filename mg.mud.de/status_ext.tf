; $Log: status_ext.tf,v $
; Revision 1.5  2002/10/05 16:04:06  thufhnik
; kleiner bugfix in kiri
;
; Revision 1.4  2002/09/11 14:37:47  chbr
; Kiri als Modul
;
; Revision 1.3  2002/03/27 01:27:15  mh14
; require way.tf, neue dimensionsverwaltung
;
; Revision 1.2  2002/03/05 10:49:35  thufhnik
; Segen und Schutzhand als Module
;
; Revision 1.1  2002/02/10 14:30:37  thufhnik
; Scratch
;

/set status_ext_tf_version $Id$
/set status_ext_tf_author=Thufhir@mg.mud.de
/set status_ext_tf_requires=way.tf(1.28)
/set status_ext_tf_desc zusaetzliche Statusmodule

; Variablen initialisieren

/set ext_schutzhand 0
/set ext_segen 0
/set ext_kiri 0

; Statuszeilenmodule

/set sl_dim_node_doc=aktueller Wegepunkt in der Parawelt rot hinterlegt
/def sl_dim_node = \
	/set status_attr_showpoint=(dimension()==0)?"n":"Cbgred"%;\
	/set status_func_showpoint=(showpoint=~"") ? "!KEIN!" : showpoint%;\
	/return status_var("showpoint",10)

/set sl_ext_schutzhand_doc=Schutzhand von einem Kleriker aktiv (H)
/def sl_ext_schutzhand = \
	/init_var ext_schutzhand%;\
	/set status_func_ext_schutzhand=ext_schutzhand?"H":""%;\
	/return status_var("ext_schutzhand",1,"Cred")

/set sl_ext_segen_doc=Segen von einem Kleriker aktiv (S)
/def sl_ext_segen = \
	/init_var ext_segen%;\
	/set status_func_ext_segen=ext_segen?"S":""%;\
	/return status_var("ext_segen",1,"Cyellow")

/set sl_ext_kiri_doc=Kiri von einem Tanjian aktiv (K)
/def sl_ext_kiri = \
	/init_var ext_kiri%;\
	/set status_func_ext_kiri=ext_kiri?"K":""%;\
	/return status_var("ext_kiri",1,"Cyellow")

; Trigger

/def -Fp1 -agCblue -mregexp -q -t' stellt mental eine Verbindung zu Kandri \
	der Gerechten her\\.' status_ext_sh = \
	/echo -aCgreen Schutzhand von %PL%;\
	/purge status_ext_sh_g%;\
	/def -1 -Fp1 -agCblue -mglob -q -t'* Haende ueber Dir.' \
		status_ext_sh_g = /set ext_schutzhand 1

/def -Fp1 -aCred -msimple -q -t'Kandris schuetzende Haende verlassen Dich \
	wieder.' status_ext_sh_out = /set ext_schutzhand 0

/def -Fp1 -agCblue -mglob -q -t'* legt Dir die Haende auf und segnet Dich.' \
	status_ext_segen = \
	/set ext_segen 1%;\
	/echo -aCgreen Segen von %1

/def -Fp1 -aCred -msimple -q -t'Du spuerst, wie die Segnung abklingt.' \
	status_ext_segen_out = /set ext_segen 0

/def -Fp1 -agCblue -mglob -q -t'* huellt Dich in einen schuetzenden Nebel.' \
	status_ext_kiri = \
	/set ext_kiri 1%;\
	/echo -aCgreen Kiri von %1

/def -Fp1 -aCred -msimple -tq -t'Der Nebel loest sich auf.' \
	status_ext_kiri_out = /set ext_kiri 0
