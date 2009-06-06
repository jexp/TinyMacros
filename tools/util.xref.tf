; $Log: util.xref.tf,v $
; Revision 1.6  2001/10/18 18:18:21  nieten
; Fehlerquelle erkannt, aber nicht eliminiert (siehe Hilfetext zu /xref
;
; Revision 1.5  2001/10/11 20:17:46  nieten
; sollte durch umsetzen von %max_iter jetzt auch fuer lange files klappen
;
; Revision 1.4  2001/10/11 16:37:02  nieten
; Option -v fuer /xref
;
; Revision 1.3  2001/10/10 22:10:22  mh14
; Default-Konfiguration in .tf Files verschoben
;
; Revision 1.2  2001/10/10 15:41:25  nieten
; einige typos raus
;
; Revision 1.1  2001/10/10 15:31:44  nieten
; erste Version
;

/set util_xref_tf_version=$Id$
/set util_xref_tf_author=Dotz@mg.mud.de
/set util_xref_tf_requires=util.tf(1.10)
/set util_xref_tf_desc=Erstellt zu einer TF-Datei eine Liste aller benoetigten Makros incl. Files

; Benoetigte Files und Makros:
; util.tf(1.10): /remove_packet

; ********************* BEGIN CONFIG ********************

; Defaultname des Tagsfile
/set xref_v_tagfile=TAGS

; ********************* END CONFIG **********************



/addh info \
Erzeugt zu einem File eine Liste aller Makros, die dort verwendet werden, sowie die Dateien, in denen diese Makros definiert sind. Dazu muss ein aktuelles Tagfile vorhanden sein, dessen Name als Paramter uebergeben werden kann; ansonsten wird der Defaultwert aus ?%xref_v_tagfile genommen.@{N}\
Bei Angabe der Option "-v" werden auch alle Makros, die im zu untersuchenden File selber definiert sind, ausgegeben.@{N}\
/xref ist langsam, speicherhungrig und kann keine Versionsinformationen erstellen. (Da es aber nicht fuer den alltaeglichen Gebrauch beim Mudden gedacht ist, ist das vielleicht nicht ganz so schlimm.) Ist im Moment mehr eine Unterstuetzung, der man nicht blind vertrauen sollte. :^)@{N}\
Da ich leider nicht weiss, wie man in TF z. B. mit ASCII-Wert 177 arbeiten kann, werden einige Zeilen des Tagfiles nicht richtig interpretiert und koennen zu Fehlern fuehren.
/addh syn /xref [-v] [tagfile] [tf-file]
/addh ex /xref ~/tf-lib/TAGS ways.tf, /xref -v mg.mud.de/comm.tf
/addh see xref_v_tagfile
/addh xref comm

/defh xref = \
; Parameter auswerten
    /let xref_tagname=%xref_v_tagfile%;\
    /let xref_verbose=0%;\
    /if ({#} == 1) \
	/let xref_tfname=%1%;\
    /elseif ({#} == 3) \
        /let xref_verbose=1%;\
        /let xref_tagname=%2%;\
	/let xref_tfname=%3%;\
    /elseif ({#} == 2) \
	/if ({1} =~ "-v") \
	    /let xref_verbose=1%;\
        /else \
	    /let xref_tagname=%1%;\
	/endif%;\
        /let xref_tfname=%2%;\
    /else \
        /echo Fehler: Kein TF-File angegeben!%;\
	/return%;\
    /endif%;\
; Sind TF-File und Tagfile vorhanden?
    /let xref_tfstream=$[tfopen(xref_tfname,"r")]%;\
    /if (xref_tfstream == -1) \
	/return%;\
    /endif%;\
    /let xref_tagstream=$[tfopen(xref_tagname,"r")]%;\
    /if (xref_tagstream == -1) \
        /test tfclose(xref_tfstream)%;\
	/return%;\
    /endif%;\
; Fuer lange Files besser %max_iter erhoehen.
    /let xref_max_iter=%max_iter%;\
    /set max_iter=0%;\
; xref_tfname in einen riesigen String einlesen (*wuerg*)
    /echo reading "%xref_tfname" ...%;\
    /let xref_tffile=%;\
    /let xref_tmp=%;\
    /let xref_comment=$[ascii(";")]%;\
    /while (tfread(xref_tfstream,xref_tmp) != -1) \
; Kommentare ueberlesen
	/if (ascii(xref_tmp) != xref_comment) \
            /test xref_tffile:=strcat(xref_tffile," ",xref_tmp)%;\
	/endif%;\
    /done%;\
    /test tfclose(xref_tfstream)%;\
    /if (xref_verbose) \
        /let xref_tfname=%;\
    /endif%;\
; Tagfile lesen und fuer jede Zeile testen, ob das dort aufgefuehrte Makro
; in %xref_tffile vorkommt.
; Zuerst das Trennzeichen lesen, welches im Tagfile ein neues File ankuendigt.
    /let xref_trenner=%;\
    /test xref_tmp:=tfread(xref_tagstream,xref_trenner)%;\
    /let xref_aktfile=%;\
    /test xref_tmp:=tfread(xref_tagstream,xref_aktfile)%;\
    /test xref_aktfile:=substr(xref_aktfile,0,strchr(xref_aktfile,","))%;\
;/echo processing %xref_aktfile%;\
    /while (tfread(xref_tagstream,xref_tmp) != -1) \
	/if (xref_tmp =~ xref_trenner) \
	    /test xref_tmp:=tfread(xref_tagstream,xref_aktfile)%;\
	    /test xref_aktfile:=substr(xref_aktfile,0,strchr(xref_aktfile,","))%;\
;/echo processing %xref_aktfile%;\
        /endif%;\
	/if ((xref_tfname !~ xref_aktfile) & \
	     (regmatch("^/defh? ([^ -]+) .*",xref_tmp) == 1)) \
	    /let xref_tmp=%P1%;\
	    /if (regmatch(strcat("[/(]",{P1},"[ %()]"),xref_tffile) == 1) \
	        /echo %xref_aktfile: %xref_tmp%;\
	    /endif%;\
	/endif%;\
    /done%;\
    /test tfclose(xref_tagstream)%;\
    /set max_iter=%xref_max_iter


/addh info \
Defaultname des Tagfiles fuer ?/xref.
/addh see xref
/addh xref_v_tagfile var


/addh info \
Entfernt alles, was in util.xref.tf definiert wurde.
/addh xref_remove mak

/def xref_remove = \
     /remove_packet xref

/addh info \
Paket zum Erzeugen einer cross reference.
/addh see xref
/addh mak xref, xref_remove
/addh var xref_v_tagfile

/addh_fileinfo
