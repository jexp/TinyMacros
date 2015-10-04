Kurze Einfuehrung:

### Install:

Das Repo mittels 

```
git clone https://git.benares.de/chrib/TinyMacros.git
```

bzw.

```
git clone https://github.com/chrib/TinyMacros.git
```

clonen. Damit wird das Verzeichnis TinyMacros erstellt.  
Die `.tfrc` daraus nach `$HOME` kopieren oder verlinken.
Wenn das Verzeichnis irgendwoanders hin kopiert wurde, muss der Pfad in der `.tfrc` angepasst werden.

-------------------------------------------------------

### Basiseinrichtung

Wenn Welten definiert wurden, Start von TF mit `tf <weltname>`, sonst nur mit `tf`.

Welten koennen nach dem Starten von TF mit dem `/addplayer` Kommando definiert werden. Solche Welten sind jedoch nur in der aktuellen Sitzung gueltig.

Damit Welten immer zur Verfuegung stehen, legt man eine
entsprechende Definition unter `~/TinyMacros/world.tf` ab.

```
/test addworld("welt1", "lp.lpp", "mud", "port", "char", "password");
```

Fuer das MorgenGrauen saehe dies z.B. wie folgt aus:

```
/test addworld("mg", "lp.lpp", "mg.mud.de", "4711", "Merlin", "merlinpwd")
```

WICHTIG! Da sich die Pakete Informationen ueber Mud-Host und Spieler aus der Weltdefinition holen, sollte diese auch definiert werden.
Mud-Host und Spieler sind die Verzeichnisse unter 
TinyMacros/Host/Spieler, z.B: 

```
~/TinyMacros/mg.mud.de/merlin
```

Daher aufpassen wenn der Host als IP gesetzt
ist, dann bitte einen Link auf das Hostname-Verzeichnis machen.

-------------------------------------------------------

### Verzeichnisstruktur:

| Verzeichnis                     | Funktion                 | 
|---------------------------------|--------------------------|
| TinyMacros/*                    | Basisfiles               | 
| TinyMacros/mg.mud.de/*          | Mudspezifische Files     |
| TinyMacros/mg.mud.de/merlin/*   | Spielerspezifische Files |
| TinyMacros/mg.mud.de/zauberer/* | Gildenspezifische Fiels  |                     
  
`mg.mud.de`, `merlin` und 'zauberer` sind nur Beispiele

-------------------------------------------------------

### Konfiguration:

Die meisten Sachen kann man mittlerweile mit dem Befehl `/configure`
einstellen. Die Konfiguration ist menuegesteuert und erklaert sich
(hoffentlich) von selbst.

Die Paketauswahl stellt die zu ladenden Files ein, meist ist zur Zeit noch ein Neustart erforderlich ausser bei `/remove_info`, `/remove_reduce`.

Fuer die etwas Erfahreneren:

Die Standardkonfiguration steht am Anfang der einzelnen `*.tf`-Dateien, oder in der gleichbenannten `*.def`-Datei. Diese sollten nicht modifiziert werden, da sie bei einem Update ueberschrieben werden.

In die `*.cfg`-Dateien koennen eigene Einstellungen reingeschrieben werden. Wenn noch keine entsprechende `.cfg` existiert kann sie einfach erzeugt werden, sie wird dann automatisch beim naechsten TF-Start mitgeladen.

**Vorsicht**: Viele `cfg`-Dateien sind ebenfalls im Repo vorhanden und ueberschreiben bei einem `git pull` die eigenen Einstellungen bzw. sorgen fuer einen Konflikt.

Zum Teil gibt es auch mudspezifische Configdateien (dann stehen die zusaetzlich in `TinyMacros/world_host/.{def,cfg}`

-------------------------------------------------------

### vorsicht.tf (Fluchtsystem)

Das Paket vorsicht.tf sichert Vorsicht und Fluchtrichtung. Wenn es erkennt, dass daran manipuliert wurde, setzt es beides automatisch wieder um.
Wenn also eine neue VS oder eine neue FR eingestellt werden sollen, muessen die von tf verwendeten Variablen mit umgesetzt werden. Dies kann zB. mit
einem TF-Alias gemacht werden:

```
/alias vs /v %*
/alias fl /fl %*
```
-------------------------------------------------------

### way.tf (Wegesystem)

An einem ersten Startknoten `/addnode <knotenname>` ausfuehren, dabei bitte auch das Gebiet und Info eingeben.

Dann `/wo`, um zu schauen, ob der Knoten richtig erkannt wird.
Nun den Weg zum Ziel laufen.

Dort `/end <knotenname>` ausfuehren und das Speichern des Hin- und Rueckwegs bestaetigen. Gebiet und Info nicht vergessen.

Gebiet und Info muessen nur bei neu erzeugten Knoten eingegeben werden.
`/end` kann auch selber Knoten erkennen, die schon vorhanden sind.

`/showways [knotenname]` zeigt Wege des Knotens an.

`/shownode [knotenname|*]` zeigt Knoten an, zu denen Wege fuehren.

`/add_portal <knotenname> <nummer>` fuegt Portale hinzu.

-------------------------------------------------------

### untroom.tf (Untersuchehilfe)

`/untroom` startet das Untersuchen eines Raumes. Es wird immer das naechste zu untersuchende Detail markiert und in die Eingabezeile gelegt

`/unt <detail>` untersucht das jeweilige Detail im Raum und analysiert desssen Beschreibung.

Es gibt diverse Makros zum Eingeben von Typos, Ideen, wiederholtes Untersuchen, Zeile loeschen usw. Diese werden standardmaessig auf die Funktionstasten (siehe world_host/keys.cfg - Mode 3 Untroom) gebunden.

Zum Untersuchen von Objekten und zum Ausfragen von NPCs stehen die Makros `/untitem `und `/ask_npc` zur Verfuegung.

-------------------------------------------------------

### keys.tf (Mehrere Funktionstastenbelegungen)

`ESC-0` Zeigt aktuelle Belegung und andere vorhandene Modi an.
`ESC-1..9` Schaltet Modi um.
`F1-F12` Ausfuehren der Belegung.

`Alt-D` Displaymodus, zeigt Belegung bei Tastendruck an.
`Alt-E` Editiermodus, direkte Eingabe von Befehl und Beschreibung bei Tasten-
druck, macht das folgende ueberfluessig.


in world_host/keys.def, keys.cfg gibt es Beispiele fuer Tastenbelegungen.

```
/setdesc <modus> <Bezeichner>%;\
/setdesc 1 Kampf%;\

/setkey <modus> <F-Taste> <mudbefehl,makro>&<Kurzbeschreibung>%;\
/setkey 1 2 feuerball %gegner&Feuerball%;\
```

Die Keycodes fuer Funktionstasten, Ebenen und Keypad werden in einer Liste
gehalten, die per `/configure` editiert werden kann. 

-------------------------------------------------------

### crypt.tf (verschluesselte Kommunikation)

```
/set_key <partner> <key>
/set_key vardion 329847927mj34hk2j34k32j4nk
```

Schluessel fuer Partnerzweities

```
/set_key <zweitie> !<erstie>!
/set_key zweitie !vardion!

/tm <partner> Text
```

Besser:

```
/alias tm /tm %*
```

```
usage: tm vardion ctm funzt super 
```
 
oder pro Partner

```
/alias tmv /tm vardion %*
```
