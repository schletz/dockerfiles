# Docker Container mit OpenLDAP

Bei machen Projekten muss auf ein Active Directory über LDAP zugegriffen werden. Um die Software
zu testen, kann mit OpenLDAP ein eigener Verzeichnisdienst in einem Container gestartet werden.

## Bauen des Containers:

In der Datei [users.ldif](users.ldif) befinden sich User, die beim Bauen des Images angelegt werden.
Ändere *mycompany* durch den Namen deiner Firma. Danach kannst du das Image erstellen:

- Gehe in das Verzeichnis des Dockerfiles
- Starte Docker Desktop
- Führe `docker build -t openldap . --build-arg basedn=mycompany.local --build-arg root_password=LdapPassword`
  im Verzeichnis des Dockerfiles aus. Ersetze *mycompany* durch einen geeigneten Wert, den du auch in
  [users.ldif](users.ldif) verwendet hast.
- Lege mit `docker create -p 1389:1389 --name openldap openldap` den Container an.
- Starte in Docker Desktop den Container.
- Im Ldap Browser kannst du dich mit mit *localhost* auf Port *1389* zu OpenLDAP verbinden. 

> Hinweis: Das *docker run* Kommando verwendet Port 1389 (non privileged port). Der Standardport für 
> LDAP ist 389, du musst also den Port beim Zugriff anpassen.

Zum Ansehen des Direcories kannst du z. B. den
[Softerra LDAP Browser](https://www.ldapadministrator.com/download.htm#browser)
laden. Verbinde dich anonym mit *localhost* (Port 1389).
