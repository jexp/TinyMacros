; $Log: util.sfunc.tf,v $
; Revision 1.8  2002/09/08 17:26:37  mh14
; reval macht ein internes eval statt /eval /let
;
; Revision 1.7  2002/04/18 19:34:50  mh14
; /qsort,/qnsort von ken keys
;
; Revision 1.6  2001/11/28 11:02:55  mh14
; md5 als hash vorgesehen
;
; Revision 1.5  2001/09/09 19:09:42  mh14
; help_de.list
;
; Revision 1.4  2001/09/06 21:11:44  mh14
;  Log eingefuegt
;

/set util_sfunc_tf_version $Id$
/set util_sfunc_tf_author=Mesirii@mg.mud.de
/set util_sfunc_tf_requires=
/set util_sfunc_tf_desc Stringfunktionen, Aufspalten, Hashcode, Sprintf

/set MAX_INT=2147483647
/addh info \
Spaltet Strings entsprechend der angegebenen Begrenzer auf.
/addh syn $[tokenize("begrenzer z.b. space Komma usw.","string")]
/addh return %T0 anzahl der aufspaltungen@{N}\
	%Ti ite aufspaltung
/addh version 1.01
/addh tokenize mak
/def tokenize = \
	/let param=%{2}%;\
	/let token_praefix=%{3-T}%;\
	/let counter=1%;\
	/let off=$[strstr(param,{1})]%;\
	/let delimlen=$[strlen({1})]%;\
	/while (off!=-1) \
	  /set %{token_praefix}%counter=$[substr(param,0,off)]%;\
	  /let counter=$[counter+1]%;\
	  /let param=$[substr(param,off+delimlen)]%;\
	  /let toff=$[strstr(param,{1})]%;\
	  /while (toff==0)\
	    /let param=$[substr(param,delimlen)]%;\
	    /let toff=$[strstr(param,{1})]%;\
	  /done%;\
	  /let off=%toff%;\
	/done%;\
	/set %{token_praefix}%counter=%param%;\
	/set %{token_praefix}0=%counter%;

/def ctokenize = \
	/let param=%{2}%;\
	/let token_praefix=%{3-T}%;\
	/let counter=1%;\
	/let off=$[strchr(param,{1})]%;\
	/while (off!=-1) \
	  /set %{token_praefix}%counter=$[substr(param,0,off)]%;\
	  /let counter=$[counter+1]%;\
	  /let param=$[substr(param,off+1)]%;\
	  /let toff=$[strchr(param,{1})]%;\
	  /while (toff==0)\
	    /let param=$[substr(param,delimlen)]%;\
	    /let toff=$[strstr(param,{1})]%;\
	  /done%;\
	  /let off=%toff%;\
	/done%;\
	/set %{token_praefix}%counter=%param%;\
	/set %{token_praefix}0=%counter%;

/addh info \
Ersetzt die nummerierten #i im uebergebenen String durch die i-ten Parameter, die sprintf uebergeben wurden.
/addh ex /test sprintf("#1 Bytes von #2 gelesen",100,"test.txt")
/addh syn /test sprintf("String",parameters,...)
/addh return String mit Ersetzungen
/addh sprintf func

/def sprintf = \
	/let param=%;\
	/test param:={1}%;\
	/let count=1%;\
	/shift%;\
	/while ({#}>0) \
	   /test param:=replace(strcat("#",count),{1},param)%;\
	   /shift%;\
	   /test ++count%;\
	/done%;\
	/result param

/addh info \
Sucht den String2 ab der angegebenen Position im String1.
/addh syn strnstr(string1,off,string2) 
/addh return den Offset von String2 vom Beginn von String1 oder -1 bei Fehler
/addh strnstr mak
/def strnstr = \
	/let temp=$[strstr(substr({1},{2}),{3})] %;\
	/return (temp==-1)?{temp}:(temp+{2})%;

/addh info \
Liefert den uebergebenen Text mit Grossbuchstaben am Anfang zurueck.
/addh capitalize mak

/def capitalize = \
	/result strcat(toupper(substr({*},0,1)),substr({*},1))%;

/addh info \
Liefert einen Hashwert des uebergebenen Strings zurueck. Dieser wird gebildet, indem eine Verkettung aus Stringlaenge modulo 1000, sowie den ASCII Werten der folgenden Zeichen erzeugt wird. 1. Zeichen bei Position Stringlaenge modulo 100 (als Prozentwert dividiert durch 100) mal Stringlaenge (hier mod. 1000, ist aber nicht so wichtig). 2. Zeichen bei Stringlaenge (mod 1000) - Position1.@{N}\
Wenn der String weniger als 10 Zeichen beinhaltet, wird der Hashcode nach folgender Formel berechnet: x=0, x:=x*8+ascii(i), i=0..strlen
/addh syn /hash1 string, Returnwert per /result
/addh hash1 mak

/def hash = \
  /let param=%*%;\
  /let hash_len=$[strlen(param)]%;\
  /let tmp=%;\
  /if (hash_len>10) \
    /let hash_hcount=$[mod(hash_len,1000)]%;\
    /let hash_pcount=$[mod(hash_hcount,100)]%;\
    /let hash_pos=$[(hash_len-1)*(hash_pcount)/100]%;\
    /let hash_pos2=$[hash_len-1-hash_pos]%;\
    /result replace(" ","0",pad(hash_hcount,3,ascii(substr(param,hash_pos,1)),3,ascii(substr(param,hash_pos2,1)),3))%;\
  /else \
    /let hash_hcount=0%;\
    /while (--hash_len>-1) \
; problem overflow wird zu real zahl bei tf5
      /let tmp=$[8*hash_hcount+ascii(param)]%;\
      /if (tmp>MAX_INT) \
        /test hash_hcount:=overmult(hash_hcount,8)+ascii(param)%;\
      /else \
        /test hash_hcount:=tmp%;\
      /endif%;\
      /let param=$[substr(param,1)]%;\
    /done%;\
    /if (hash_hcount<0) \
      /let hash_hcount=$[-hash_hcount]%; \
    /endif%;\
    /result replace(".","",replace(" ","0",pad(hash_hcount,9)))%;\
  /endif%;


/def overmult = \
     /let number=%1%;\
     /let mult=%2%;\
     /let result=%number%;\
     /let over=%;\
     /while (--mult>0) \
	 /if (result+number>MAX_INT) \
	     /test over:=number-1-(MAX_INT-result)%;\
;/echo -- %mult over %over = %number -1 - ( %MAX_INT - %result [$[MAX_INT-result]])%;\
	     /test result:=-MAX_INT-1 + over %;\
;/echo -- res %result = -%MAX_INT -1 + %over%;\
	 /else \
	     /test result:=result+number%;\
         /endif%;\
     /done%;\
     /return result

/def overflow = \
     /if ({1}>MAX_INT) \
	 /let overflow=%;\
	  /test overflow:={1}-MAX_INT*trunc({1}/MAX_INT)%;\
	  /test overflow:=-MAX_INT-1+overflow%;\
	  /return overflow%;\
     /endif%;\
     /return {1}%;

;/if (have_ext("MD5")) \
;   /def hash=/return md5({*})%;\
;/else \
;   /def hash=${hash1}%;\
;/endif


/def list_idx =\
         /let tmp=%1%;\
         /shift%;\
         /let result=0%;\
         /while ({#}) \
         /test ++result%;\
         /if (tmp=~{1}) /result result%;/endif%;\
	 /shift%;\
         /done%;\
         /result 0%;


;;;; /qsort by Ken Keys
;;; usage:  /qsort comparison-function item...
;;; Echoes the sorted items.
;;; "comparison-function" is the name of a function that compares %1 and %2,
;;; and returns <0, 0, or >0.  "item..." is a series of words to be sorted.

; Using %R instead of %1 has little effect on random input, but is much
; more efficient on sorted or nearly-sorted input.

/def -i qsort = \
    /if ({#} <= 2) \
        /return {-1}%; \
    /else \
        /let compare=%{1}%;\
        /shift%;\
;       /let key=%{R}%;\
        /let key=%{1}%;\
        /let same=%;\
        /let small=%;\
        /let large=%;\
        /let diff=%;\
        /while ({#}) \
            /test diff:=%compare({1}, key)%;\
            /if (!diff) \
                /let same=%same %1%; \
            /elseif (diff < 0) \
                /let small=%small %1%; \
            /else \
                /let large=%large %1%; \
            /endif%; \
            /shift%; \
        /done%; \
	/qsort %compare %small%;\
	/let res=%? %same%;\
	/qsort %compare %large%;\
	/let res=%res %?%;\
;        /return $(/qsort %compare %small) %same $(/qsort %compare %large)%; \
	 /return res%;\
    /endif


;;;; /qnsort by Ken Keys
;;; usage:  /qnsort F comparison-function item...
;;; Echoes the first F sorted items, instead of all N, much more efficiently
;;; than /first_n $(/qsort ...).  If F < 0, it is ignored.
;;; "comparison-function" is the name of a function that compares %1 and %2,
;;; and returns <0, 0, or >0.  "item..." is a series of words to be sorted.

/def -i qnsort = \
    /if ({#} <= 2) \
        /_echo %{-1}%; \
    /else \
        /let F=%{1}%; \
        /let cmp=%{2}%;\
        /shift 2%;\
        /if (F >= {#} | F < 0) /qsort %cmp %*%; /return {?}%; /endif%; \
;       /let key=%{R}%;\
        /let key=%{1}%;\
        /let same=%;\
        /let small=%;\
        /let large=%;\
        /let nsame=0%;\
        /let nsmall=0%;\
        /let nlarge=0%;\
        /let diff=%;\
        /while ({#}) \
            /test diff:=%cmp({1}, key)%;\
            /if (!diff) \
                /let same=%same %1%; \
                /test ++nsame%; \
            /elseif (diff < 0) \
                /let small=%small %1%; \
                /test ++nsmall%; \
            /else \
                /let large=%large %1%; \
                /test ++nlarge%; \
            /endif%; \
            /shift%; \
        /done%; \
        /if (F <= nsmall) \
            /_echo $(/qnsort %F %cmp %small)%; \
        /elseif (F <= nsmall + nsame) \
            /_echo $(/qsort %cmp %small) $(/first_n $[F-nsmall] %same)%; \
        /else \
            /_echo $(/qsort %cmp %small) %same \
                $(/qnsort $[F - nsmall - nsame] %cmp %large)%; \
        /endif%; \
    /endif


;;; useful comparison functions

/def -i intcmp	   = /test {1} - {2}
/def -i strcasecmp = /test strcmp(tolower({1}), tolower({2}))

/addh info Evaluiert den uebergebenen String und gibt das Ergebnis zurueck, noetig, weil /eval /let a=b ist %b nicht funktioniert
/addh syn /reval String
/addh return Evaluierter String
/addh var lokal: tmp_eval
/addh reval mak

/def reval = /eval /let tmp_eval=%*\%;/return tmp_eval

/addh info Vergleicht Strings und liefert die Anzahl der Zeichen bis zu der die Strings gleich sind
/addh syn /strcmpn string1 string2
/addh return Anzahl gleicher Zeichen
/addh strcmpn mak

/def strcmpn = \
   /let _maxlen=0%;\
   /let _first=%;\
   /let _second=%;\
   /test _first:={1},_second:={2}%;\
   /test _maxlen:=strlen(_first) < strlen(_second) ? strlen(_first) : strlen(_second)%;\
   /let _start=0%;\
   /let _len=%_maxlen%;\
;   /let _count=0%;\
   /while (_len > 0) \
   /while (_len > 0 & strncmp(_first,_second,_start + _len)!=0) \
;         /test ++_count%;\
   	 /test _len:=_len/2%;\
   /done%;\
;   /echo -e %_count %_start %_len%;\
   /if (_len==0 | _start + _len >= _maxlen) /result _start + _len%;/endif%;\
   /test _start:=_start + _len%;\
   /test _maxlen:=_start + _len%;\
   /done%;\
   /result _start + _len%;

/addh_fileinfo
