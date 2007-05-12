/def -b^i b_completion = \
   /completion_ls


/def completion_ls = \
   /set ls_text=%;\
   /def -1 -ag -p2 -t"*files/directories*" -p1 t_ls1 = /test 0%;\
   /def -t"*" -ag t_ls = /set ls_text=\%ls_text \%*%;\
   /def -q -1 -hPROMPT t_ls_done = /undef t_ls\%;/ls_complete \%ls_text%; \
   /test kbgoto(0)%;\
   /ls_input $[kbtail()]%;\

/def ls_input = \
   /if ({#}>1) \
      /set ls_param=%L%;\
      /set ls_cmd=%-L%;\
   /else \
      /set ls_param=%;\
      /set ls_cmd=%*%;\
   /endif%;\
   /dokey DLINE%;\
   /input %ls_cmd%;\
   /if (ls_cmd!~"") /test input(" ")%; /endif%;\
   /let off=$[strrchr(ls_param,"/")]%;\
   /set ls_basedir=%;\
   /if (off>-1) \
     /set ls_basedir=$[substr(ls_param,0,off+1)]%;\
     /test input(substr(ls_param,0,off+1))%;\
     /send ls %ls_basedir%;\
     /test ls_param:=substr(ls_param,off+1)%;\
   /else \
     /send ls%;\
   /endif%;\
   /set ls_dir=$[(ls_cmd=/"{cd|dir|rmdir|mkdir}")]%;\

/def ls_complete = \
     /let ls_list=%;\
     /let ls_done=0%;\
     /let ls_base=-1%;\
     /while ({#}) \
        /if (strstr({1},ls_param)==0 & (!ls_dir | (ls_dir & strchr({1},".")==-1))) \
	   /test ++ls_done%;\
	   /let ls_list=%ls_list %1%;\
	   /if (ls_base=~"-1") \
	      /let ls_base=%1%;\
	   /else \
	     /let ls_max=$[strlen(ls_base)<strlen({1})? strlen({1}): strlen(ls_base)]%;\
	     /let ls_idx=0%;\
	     /while (ls_idx<=ls_max & \
		    (substr(ls_base,ls_idx,1)=~"" | \
		    substr(ls_base,ls_idx,1)=~substr({1},ls_idx,1)))%;\
	     /test ++ls_idx%;\
	     /done%;\
	     /test ls_base:=substr(ls_base,0,ls_idx)%;\
	   /endif%;\
	   /endif%;\
	/shift%;\
     /done%;\
     /echo -aCblue [%ls_list ]%;\
     /input %ls_base%;\
     /if (ls_done==1) \
       /test input(strchr(ls_base,".")==-1 ? "/" : " ")%;\
     /endif%;


