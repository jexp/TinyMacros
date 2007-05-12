; usage: /afolge npc|player
/def afolge = \
  /if ({#}==0) /undef t_folge%; \
  /else \
  /def -t\"*{%1}*\" -mglob t_folge = \
	/set folge=\$[tolower({*})]\%;\
	/forEach comm_abbr kv /check_folge%;\
  /endif%;

/def check_folge = \
	/if (regmatch(strcat(" ",{-1},"[ .!,]"),folge)) /echo folge %-1%; %1%; /break%; /endif%; 
