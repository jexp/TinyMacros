; $Log: status_kaempfer.tf,v $
; Revision 1.1  2002/11/21 10:11:07  rumburuk
; Scratch
;
 
/set status_kaempfer_tf_version $Id: status_kaempfer.tf,v 1.1 2002/11/21 10:11:07 rumburuk Exp $
/set status_kaempfer_tf_author=Thufhir@mg.mud.de
/set status_kaempfer_tf_requires=status_ext.tf hydra.tf
/set status_kaempfer_tf_desc=Loader der Statuszeile der Trves

/remove_from_hook points /echo_hit_points

/config_status {ext_segen}{ext_schutzhand}{ext_kiri}_L:{lp}_K:{mp}_{arzt}{hydra_present}_FL:{vorsicht}:{flucht}_W:{weapon}_{modes}_{dim_node}_{clock}
