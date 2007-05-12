; $Log: util.stack.tf,v $
; Revision 1.6  2001/11/30 13:44:12  mh14
; push,pop,putstack durch praefix stack_* umbenannt
;
; Revision 1.5  2001/09/09 19:09:42  mh14
; help_de.list
;
; Revision 1.4  2001/09/06 21:11:44  mh14
;  Log eingefuegt
;

/set util_stack_tf_version $Id: util.stack.tf,v 1.6 2001/11/30 13:44:12 mh14 Exp $
/set util_stack_tf_author=Mesirii@mg.mud.de
/set util_stack_tf_requires=
/set util_stack_tf_desc Diverse Stackfunktionen

/set stack=0
/addh info \
Speichert die uebergebenen (globalen) Variablen auf dem Stack.
/addh ex /stack_push t1 t2 t3
/addh see getstack, stack_put, stack_pop
/addh stack_push mak
/def stack_push = \
	/while ({#}) \
	  /set stackvar_%stack=%1%;\
	  /set stack_%stack=%;\
	  /test stack_%stack:=%1%;\
	  /set stack=$[stack+1]%;\
	  /shift%;\
	/done %;

/addh info \
Speichert die uebergebene (globale) Variable auf dem Stack in der angegebenen Position. Die Position muss innerhalb des Stackpointers liegen.
/addh ex /stack_put 1 test oder /stack_put test 1
/addh see getstack, stack_push, stack_pop
/addh stack_put mak
/def stack_put = \
	/if (regmatch("^[0-9]+$",{1})==1) /let pstack=%1%; /shift%;\
	/else /let pstack=%2%; /endif%;\
	/if (pstack<stack) \
	  /set stackvar_%pstack=%1%;\
	  /set stack_%pstack=%;\
	  /test stack_%pstack:=%1%;\
	/endif %;

/addh info \
Holt von der angegebenen Position eine Variable aus dem Stack. Wenn ein Variablenname uebergeben wird, wird der Wert in dieser Variablen gespeichert. Die Position muss innerhalb des Stackpointers liegen.
/addh ex /getstack 1 test oder /getstack test 3 oder /getstack 2
/addh return der Inhalt der Variablen 
/addh see stack_put, stack_push, stack_pop
/addh getstack mak
/def getstack = \
	/if (regmatch("^[0-9]+$",{1})==1) /let pstack=%1%; /shift%;\
	/else /let pstack=%2%; /endif%;\
	/if (pstack<stack) \
	  /if ({#}>1) /set tmp_stack=%1%;\
	  /else /test tmp_stack:=stackvar_%pstack%; /endif%;\
	  /test %tmp_stack:=stack_%pstack%;\
	  /return stack_%pstack%;\
	/endif %;

/addh info \
Holt eine/viele Variable aus dem Stack. Wenn Variablenname(n) uebergeben werden, wird der Wert in dieser Variablen gespeichert.
/addh ex /stack_pop @{N} /stack_pop test @{N} /stack_pop test test2
/addh return der Inhalt der letzten Variablen 
/addh see stack_push, getstack, stack_put
/addh stack_pop mak
/def stack_pop = \
	/let stack_poptovar=0%;\
	/if ({#}>0) \
	 /if (regmatch("^[0-9]+$",{1})==1) /let num=%1%; \
	 /else /let num=%#%; /let stack_poptovar=1%;/endif%;\
     	/else /let num=1%;/endif%;\
;	/_echo %num %stack_poptovar %;\
	/while (num>0) \
	/let num=$[--num]%;\
	/if (stack>0) \
	/set stack=$[stack-1]%;\
	/if (!stack_poptovar) /test tmp_stack:=stackvar_%stack%;\
	/else /set tmp_stack=%1%; /shift%; /endif%;\
	/test %tmp_stack:=stack_%stack%;\
	/unset stack_%stack%;\
	/unset stackvar_%stack%;\
	/endif%;\
	/done%;\
	/return %tmp_stack%;


/addh_fileinfo
