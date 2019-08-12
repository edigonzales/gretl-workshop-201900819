# Exercise 4 - Jenkins als Gretl-Job-Orchestrierer

```
docker run -p 8080:8080 jenkinsci/blueocean
```

```
*************************************************************
*************************************************************
*************************************************************

Jenkins initial setup is required. An admin user has been created and a password generated.
Please use the following password to proceed to installation:

b6e9defcc02747f9992f5d50321d5a1a

This may also be found at: /var/jenkins_home/secrets/initialAdminPassword

*************************************************************
*************************************************************
*************************************************************
```

```
Create First Admin User
```

* New Item
* Freestyle project "my_first_gradle_job"
* Git: "https://github.com/edigonzales/gretl-workshop-201900819.git"
* Build - Add build step - Invoke Gradle script
  * Use Gradle Wrapper
  * Wrapper location: "exercise01/"
  * Tasks: "foo" 
  * (Advanced) Root Build script: "exercise01/"

Job alle 5 Minuten ausführen:
* Build Triggers - Build periodically:
  * "*/5 * * * *" entspricht Crontab syntax.
