# Exercise 3

Ziele: 
- Nutzungsplanungsdaten im kantonalen Modell in eine PostgreSQL/PostGIS-Datenbank importieren
- Daten in das Bundesmodell umbauen
- Daten im Bundesmodell in die Aggregationsinfrastruktur importieren

Datenbank in vagrant hochfahren:
```
cd ..
vagrant up
```
Erstellt eine "edit" und "pub" Datenbank.

Datenbankverbindungsparameter:
```
jdbc:postgresql://192.168.50.8:5432/edit 
jdbc:postgresql://192.168.50.8:5432/pub

ddluser / ddluser
dmluser / dmluser
```

Alle Tasks anzeigen:
```
./gradlew tasks --all
```
Die Forschleife erzeugt zwei Tasks. Spezialität _Gradle_: Zu diesem Zeitpunkt müssen viele Dinge bereits klar sein. D.h. man kann nicht eine unbekannte Anzahl Dateien von einem FTP-Server herunterladen und dann im gleichen Job eine erst dann bekannte (nach dem Herunterladen) Anzahl Tasks erstellen lassen. Konkret: `landUsePlansDataSets`-Liste kann nicht während der Laufzeit verändert werden resp. die Änderung hat keine Auswirkungen. -> Man muss sich daran gewöhnen.

Daten herunterladen:
```
./gradlew replaceLandUsePlansData
```

Diskussion: Daten sind nicht gezippt. In diesem Fall muss ich micht nicht darum kümmen, ob die Daten in einem Unterverzeichnis sind oder nur gezippt? Man müsste klare Vorgaben machen, damit der Code beim "Enzipper" nicht unnötig komplex und aufwändig wird.

**Wie kommen jetzt die Daten in die Datenbank?** GRETL to the rescue!

GRETL ist ein Gradle-Plugin mit speziellen Geo-Tasks. So wie z.B. der Download-Task. Stand heute gibt es folgende Tasks:

- ili2pg (Import, Export, Replace)
- CSV-Import und -Export
- Shapefile-Import und -Export
- ilivalidator (Shp, Csv, Interlis)
- Oereb-Iconizer (Geknorze, needs refactoring...)
- Db2Db: kopiert Daten von einer Datenbank in eine andere
- SqlExecutor: führt SQL auf einer Datenbank aus
- IliRepositorizer: erstellt aus einem Haufen INTERLIS-Modellen eine INTERLIS-Modellablage
- PostGIS-Raster-Export: exportiert eine PostGIS-Raster-Tabelle in eine Datei (proof of concept)

Mit diesen Tasks kommen wir bereit sehr weit.

Datenbankschemen vorbeiten, d.h. mit ili2pg Schema mit den leeren Tabellen für die Nutzungsplanungsdaten erstellen. Seit ili2pg-4.x kann man das DDL vorgängig (ohne Datenbank) erzeugen lassen.

```
java -jar /Users/stefan/apps/ili2pg-4.1.0/ili2pg-4.1.0.jar \
--dbschema arp_npl --models SO_Nutzungsplanung_20171118 \
--defaultSrsCode 2056 --createGeomIdx --createFk --createFkIdx --createEnumTabs \
--beautifyEnumDispName --createMetaInfo --createNumChecks --nameByTopic \
--createBasketCol --createDatasetCol --createImportTabs --createscript arp_npl.sql
```

`arp_npl.sql` kann jetzt ebenfalls wie Code behandelt werden (github...).

Daten nochmals herunterladen und jetzt importieren:
```
./gradlew replaceLandUsePlansData
```

Unterschied `ili2pgReplace` vs. `ili2pgImport`?

Datenbankschema für Bundesmodell vorbereiten:
```
java -jar /Users/stefan/apps/ili2pg-4.1.0/ili2pg-4.1.0.jar \
--dbschema arp_npl_ch --models "Nutzungsplanung_Hauptnutzung_V1_1;Nutzungsplanung_LV95_V1_1" \
--defaultSrsCode 2056 --createGeomIdx --createFk --createFkIdx --createEnumTabs \
--beautifyEnumDispName --createMetaInfo --createNumChecks --nameByTopic \
--createImportTabs --createscript arp_npl_ch.sql
```
Achtung: Hier keine BasketCol und DatasetCol erzeugen, da nicht notwendig.


Import der Hauptnutzungen:
```
./gradlew importHauptnutzung
```

Umbau vom kantonalen Modell ins Bundesmodell. "SQL is your friend" -> `SqlExecutor`-Task. Achtung: SQL-Query ist wahrscheinlich komplizierte als nötig, da in ili2pg-4.1 einige Verbesserungen im Umgang mit Primary Keys / Foreign Keys eingeflossen sind.

```
./gradlew transferNplso2Nplch
```

Export nach XTF:
```
./gradlew exportNplch
```

XTF-Datei mit config.toml validieren:
```
./gradlew validateNplch
```
-> Validierung ohne toml zeigen.

XTF-Datei mit config.toml zippen:
```
./gradlew zipNplch
```

Hochladen in AI nur zeigen. Hier fehlt noch ein "schöner" HTTP-POST-Task. Momentan verwenden wir 'curl'-Befehle.