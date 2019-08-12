# Exercise 6

Daten müssen im ÖREB-Kataster nachgeführt werden. Die nachgeführten Daten sollen zuerst in einer Staging-Umgebung publiziert werden. Der Datenherr verifiziert die Daten und deployed anschliessend in die Live-Umgebung.

Solothurner ÖREB-DB mit Docker hochfahren:
```
docker run --rm --name oereb-db -p 54321:5432 --hostname primary \
-e PG_DATABASE=oereb -e PG_LOCALE=de_CH.UTF-8 -e PG_PRIMARY_PORT=5432 -e PG_MODE=primary \
-e PG_USER=admin -e PG_PASSWORD=admin \
-e PG_PRIMARY_USER=repl -e PG_PRIMARY_PASSWORD=repl \
-e PG_ROOT_PASSWORD=secret \
-e PG_WRITE_USER=gretl -e PG_WRITE_PASSWORD=gretl \
-e PG_READ_USER=ogc_server -e PG_READ_PASSWORD=ogc_server \
-v /tmp:/pgdata \
sogis/oereb-db:latest
```

Es gibt ein identisches `stage`- und  `live`-Schema. Der Gretl-Job importiert die ÖREB-Daten (Nutzungsplanung) zuerst in das `stage`-Schema und der Datenherr muss das Deployment in das `live`-Schema zuerst freigeben.

Damit überhaupt importiert werden kann, müssen die Bundesgesetz und die kantonalen Gesetze importiert werden.

```
./gradlew importBundesgesetzeToStage importBundesgesetzeToLive importKantonaleGesetzeToStage importKantonaleGesetzeToLive
```
Diese Daten müssen natürlich nur einmal (zu Beginn) oder bei einer Änderung importiert werden.

In Jenkins neuer Job anlegen:

* "oereb_npl_deployment" als Pipeline
* Pipeline - Pipeline script from SCM
* SCM - Git
* Repository Url: https://github.com/edigonzales/gretl-workshop-201900819
* Script Path: exercise06/Jenkinsfile

