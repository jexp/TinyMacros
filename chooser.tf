;/chooser 1 2 3 4 5 6 7
;or 
;/chooser item_1 item_2 item_3
/def chooser = \
        /if (!{#}) /return%;/endif%;\
        /let index=$[rand({#})+1]%;\
	/eval \$[replace("_"," ",{%index})]%;\
        /eval /chooser \%-L$[{#}-index+1] \%-%index%; \

; /iterator -c"druecke knopf" 1 2 3 2 1
/def iterator = \
        /if (!{#}) /return%;/endif%;\
	/test getopts("c:")%;\
	/while ({#}) \
	   %opt_c %1%;\
	   /shift%;\
	/done%;


