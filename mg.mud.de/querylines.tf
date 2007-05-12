
; $Log: querylines.tf,v $
; Revision 1.1  2002/12/13 12:00:20  lje
;
; Ermittelung der Zeileneinstellung eines Spielers
;
;

/set querylines_tf_version $Id: querylines.tf,v 1.1 2002/12/13 12:00:20 lje Exp $
/set querylines_tf_author=Vardion@mg.mud.de
/set querylines_tf_requires=
/set querylines_tf_desc=Ermittlung der Zeileneinstellung eines Spielers


/def query_termlines = \
	/def -p10000 -mglob -q -ag -n1 -t'Mit dem Befehl *' zeilen_start = \
		/def -p9999 -mglob -q -ag -t'*' zeilen_gag%%; \
		/def -p10000 -mglob -q -ag -n1 -t'Deine aktuelle Einstellung \
			ist *' zeilen_ende = /calc_termlines %%%-4%; \
	!\\zeilen

/def calc_termlines = \
	/undef zeilen_gag%; \
	/if ({2} =~ 'Zeilen') \
		/set mud_zeilen=%1%; \
	/elseif ({2} =~ '\'automatische\'') \
		/set mud_zeilen=auto -$[lines() - (visual ? isize + 1 : 0) \
			- 1 - {1}]%; \
	/endif%; \
	/if (after_querylines !~ '') /eval %after_querylines%; /endif

