/set grafik_tf_version=$Id$
/set grafik_tf_author=Mesirii@mg.mud.de
/set grafik_tf_requires=
/set grafik_tf_desc=Ascii-Grafik im Mud

/set_var noascii 0

/send !\grafik
/def -t"Du moechtest 'Grafik' *sehen." -mglob t_noascii_state = \
     /test noascii:={4}=~"NICHT" ? 1 : 0 

/def -t"Zukuenftig moechtest Du 'Grafik' sehen." \
     -F -msimple t_ascii = \
     /set noascii=0%;\
     
/def -t"Zukuenftig moechtest Du KEINE 'Grafik' mehr sehen."  \
     -F -msimple t_noascii = \
     /set noascii=1%;
     
/def ascii_command = \
     /if (noascii) \
     	  /def -p2 -ag -1 -t"Zukuenftig moechtest Du 'Grafik' sehen." -msimple%;\
          /send !\\grafik ein%;\
     	  /send !\\%*%;\
	  /def -p2 -ag -1 -t"Zukuenftig moechtest Du KEINE 'Grafik' mehr sehen." -msimple%;\
	  /send !\\grafik aus%;\
     /else \
     	  /send !\\%*%;\
     /endif
     
