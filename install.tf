
; Benutzt Umgebungsvariable HTTP_PROXY um einen evtl. benoetigten
; HTTP-Proxy zu ermitteln. Enthaelt diese Variable keinen Port, so wird
; 3129 (Squid-Default) benutzt

/def set_install_world = \
	/if (HTTP_PROXY !~ '') \
		/let proxy=%HTTP_PROXY%; \
		/if (proxy =/ 'http://*') \
			/test proxy:=substr(proxy, 7)%; \
		/endif%; \
		/let split=$[strchr(proxy, ':')]%; \
		/if (split > -1) \
			/let host=$[substr(proxy, 0, split)]%; \
			/let port=$[substr(proxy, split + 1)]%; \
		/else \
			/let host=%proxy%; \
			/let port=3129%; \
		/endif%; \
		/test addworld("sourceforge","telnet", host, port)%; \
	/else \
		/test addworld("sourceforge","telnet",\
			"tf-macros.sourceforge.net",80)%; \
	/endif

/set_install_world
		

/set SOURCE_URL=http://tf-macros.sourceforge.net/cvs/Version/

/def ext_read = \
   /echo -p Input %1%;\
   /dokey DLINE%;\
   /if ({#}>0) /test prompt({1})%; /endif%;\
     /test input({2})%;\
     /let input_text=%;\
     /test tfread(input_text)%;\
   /if ({#}>0) /test prompt("> ")%; /endif%;\
   /return input_text%;\

/def file_exists = \
	/sys [ -f %* ]%;\
	/return !{?}

/def dir_exists = \
	/sys [ -d %* ]%;\
	/return !{?}

/def make_dos_path = \
	/let param=$[replace("/","\\",{*})]%;\
	/if (regmatch("^[\\][\\]([A-Za-z])",param)) \
	   /let param=%P1:%PR%;\
	/endif%;\
	/result param%;

/def mkdir = \
     /let param=%*%;\
     /let dir=%;\
     /while (param!~"") \
       /let off=$[strchr(param,"/")]%;\
       /let off=$[off>-1 ? off : strlen(param)]%;\
       /let dir=$[strcat(dir,substr(param,0,off))]%;\
       /let param=$[substr(param,off)]%;\
       /if (!dir_exists(dir)) \
	 /if (OS=~"win") \
	   /sys cmd /c md "$[make_dos_path({*})]"%;\
	 /else /sys mkdir "%dir"%;\
	 /endif%;\
       /endif%;\
       /let dir=$[strcat(dir,substr(param,0,1))]%;\
       /let param=$[substr(param,1)]%;\
     /done%;

/def tf_install = \
     /echo -aCgreen Welcome to the Installation of TinyMacros %tm_version%;\
     /set tf_install_dir=$[ext_read("Install Directory: ",strcat(HOME,"/tftest"))]%;\
     /set tf_install_mode=$[ext_read("(I)nstall or [U]pdate: ","U")=/"i*"? "INSTALL" : "UPDATE"]%;\
     /if (!dir_exists(tf_install_dir)) \
        /echo Directory %tf_install_dir does not exist%;\
        /if (ext_read("Create ([y]/n)","y")=/"y") \
	   /mkdir %tf_install_dir%;\
	/endif%;\
	/if ({?} | !dir_exists(tf_install_dir)) \
	   /echo -aCred Error, Directory %tf_install_dir couldn't be created, Aborting installation!%;\
	   /break%;\
	/endif%;\
     /endif%;\
     /echo Changing Directory to: %tf_install_dir%;\
     /cd %tf_install_dir%;\
     /visual off%;\
     /echo -aCyellow Now Fetching Files%;\
     /dokey REDRAW%;\
     /tf_fetch_file -C"/tf_install_parse_file_list" build_%{tf_install_mode}.list%;\

/def tf_install_parse_file_list = \
     /let handle=%;\
     /test handle:=tfopen("build_%{tf_install_mode}.list","r")%;\
     /set tf_install_files=%;\
     /let tmp_line=%;\
     /let start_files=0%;\
     /if (handle>-1) \
         /while (tfread(handle,tmp_line)>-1) \
	    /if (start_files) \
	       /let off=$[strstr(tmp_line,"  ")]%;\
	       /if (off>-1) \
		   /set tf_install_files=%tf_install_files $[substr(tmp_line,off+2)]%;\
	       /else \
		   /set tf_install_files=%tf_install_files %tmp_line%;\
	       /endif%;\
	    /elseif (tmp_line=/"---------------------------*") \
	       /let start_files=1%; \
	    /endif%;\
	 /done%;\
     /endif%;\
     /tf_install_fetch_all_files %tf_install_files%;\
   
/def tf_install_fetch_all_files = \
     /if ({#}) \
       /tf_fetch_file -C"/tf_install_fetch_all_files %-1" %1%;\
     /else \
       /echo -aCyellow Done Fetching Files.%;\
       /tf_install_tfrc%;\
     /endif%;

/def tf_install_tfrc = \
     /visual on%;\
     /let tfrc=$[strcat(HOME,"/",".tfrc")]%;\
     /echo Looking for TF Startup File: %tfrc%;\
     /let tfrc_line=/require %tf_install_dir/base_init.tf%;\
     /if (file_exists(tfrc)) \
       /echo -aCyellow %tfrc exists%;\
       /echo The line '%tfrc_line' will be needed%;\
       /let tfrc_in=$[tfopen(tfrc,"r")]%;\
       /let tfrc_queue=$[tfopen("tfrc","q")]%;\
       /let tmp=%;\
       /let replaced=0%;\
       /while (tfread(tfrc_in,tmp)>-1) \
          /if (tmp=/"*base_init.tf*") \
	     /let replaced=1%;\
	     /echo Replacing '%tmp' with %;\
	     /echo '%tfrc_line'%;\
	     /let tmp=%tfrc_line%;\
	  /endif%;\
	  /test tfwrite(tfrc_queue,tmp)%;\
       /done%;\
       /if (!replaced) \
          /echo Added %tfrc_line at the end of %tfrc%;\
	  /test tfwrite(tfrc_queue,tfrc_line)%;\
       /endif%;\
       /test tfclose(tfrc_in)%;\
       /let tfrc_out=$[tfopen(strcat(tfrc,".test"),"w")]%;\
       /while (tfread(tfrc_queue,tmp)>-1) \
	  /test tfwrite(tfrc_out,tmp)%;\
       /done%;\
       /test tfclose(tfrc_queue),tfclose(tfrc_out)%;\
     /else \
       /echo -aCyellow %tfrc does NOT exist%;\
       /echo It will be created with the line %tfrc_line%;\
       /test fwrite(tfrc,tfrc_line)%;\
     /endif%;\
     /echo -aCgreen Now loading TinyMacros! Press <Return> to continue!%;\
     /input /tf_install_load_tm

/def tf_install_load_tm = \
     /load $[strcat(HOME,"/",".tfrc",".test")]%;\
       /if (tf_install_mode=~"INSTALL") \
       /echo -aCgreen Now adding player if neccessary. Press <Return> to continue!%;\
       /input /tf_install_add_player%;\
     /else /echo -aCgreen Done Updating!%;\
     /endif%;

/def tf_install_add_player = \
     /let tmp=$(/listworlds)%;\
     /if (strlen(tmp)==0) \
       /if (ext_read("Do you wan't to add a player? (y/n)","y")=/"y") \
          /echo Now adding first player%;\
	  /addplayer%;\
       /endif%;\
     /else \
        /echo Existing Worlds found, you may add more players with /addplayer%;\
     /endif%;

; TODO Verzeichnistest per dir_exists!
; pro file wenn strrchr(bla,"/")>-1

/def tf_fetch_file = \
     /test getopts("C:")%;\
;     /def -F -ag -q -1 -hWORLD t_world1 = /test 0%;\
     /def -F -ag -1 -hCONNECT t_connect1 = /test 0%;\
     /def -F -ag -1 -hLOG t_log1 = /test 0%;\
     /def -F -ag -1 -hREDEF t_log1 = /test 0%;\
     /echo Fetching: %*%;\
     /set emulation=raw%;\
     /let old_connect=%connect%;\
     /set connect=blocking%;\
     /connect sourceforge%;\
     /send GET %{SOURCE_URL}%{*} HTTP/1.0%;\
     /send Pragma: no-cache%;\
     /send%;\
     /set connect=%old_connect%;\
     /let off=$[strrchr({1},"/")]%;\
     /if (off>-1) \
        /let dir=$[substr({1},0,off)]%; \
	/if (!dir_exists(dir)) \
	   /echo -aCyellow Making Directory %dir%;\
	   /mkdir %dir%; \
	/endif%;\
	/tf_install_clean_file %*%;\
     /endif%;\
;     /set fetch_handle=%;\
;      /test fetch_handle:=tfopen({*},"w")%;\
;      /if (fetch_handle==-1) \
;         /let off=$[strrchr({*},"/")]%;\
; 	/if (off>-1) \
; 	  /mkdir $[substr({*},0,off)]%; \
;           /test fetch_handle:=tfopen({*},"w")%;\
;         /endif%;\
;      /endif%;\
;      /if (fetch_handle==-1) \
;         /echo -aCred Error Fetching %*%;\
; 	/eval -s0 %opt_C%;\
;      /else \
;        /test tfclose(fetch_handle)%;\
       /set tf_fetch_missing=0%;\
       /def -mglob -ag -t"*{*}*" t_fetch1 = /test 0%;\
       /def -mglob -ag -p5 -1 -t"*404 Not Found*" t_fetch_404 = \
          /set tf_fetch_missing=1%;\
       /def -1 -p3 -t"{}" -ag t_fetch2 = \
       /def -t"*{*}*" -ag -p2 -1 -F t_fetch4 = \
           /log -w %*%;\
       /def -ag -1 -hDISCONNECT t_fetch3 = \
       /purge t_fetch*\%;\
       /log off\%;\
       /set emulation=ansi_attr\%;\
       /if (tf_fetch_missing) /tf_install_clean_file %*\%; /endif\%;\
       /eval -s0 %opt_C%;\


/def tf_install_clean_file = \
	/let fetch_handle=%;\
        /test fetch_handle:=tfopen({*},"w")%;\
	/test tfclose(fetch_handle)%;\

/input /tf_install
;/cd release
;/input /tf_fetch_file way.tf



