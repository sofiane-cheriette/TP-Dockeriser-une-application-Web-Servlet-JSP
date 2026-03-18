# TP Dockerfile - BoutiqueWeb

Ce projet est une application web Java (Servlet/JSP) empaquetee en WAR.
Le but du TP est de construire, containeriser et executer l'application avec Docker.

## 1. Objectifs du TP

- Comprendre la structure d'une application Java web Maven.
- Generer le fichier WAR de l'application.
- Construire une image Docker pour deployer le WAR.
- Lancer le conteneur et verifier le fonctionnement de l'application.
- Maitriser les commandes utiles de build, run, test et debug Docker.

## 2. Contexte du projet

Nom du projet: `boutique-web`

Technos:
- Java 17
- Maven
- Jakarta Servlet/JSP (JSTL)
- Packaging WAR

Points importants du `pom.xml`:
- `packaging`: `war`
- `finalName`: `boutique`

Consequence:
- Le WAR genere est `target/boutique.war`

## 3. Fonctionnalites de l'application

- Authentification simple (`/login`)
- Catalogue d'articles (`/catalogue`)
- Panier session utilisateur (`/panier`)
- Deconnexion (`/logout`)

Comptes de test:
- `alice / alice123`
- `bob / bob456`
- `admin / admin`

## 4. Prerequis

Installer:
- JDK 17+
- Maven 3.8+
- Docker Desktop

Verifier:

```powershell
java -version
mvn -version
docker version
```

## 5. Build Maven (sans Docker)

Depuis la racine du projet:

```powershell
mvn clean package
```

Resultat attendu:
- fichier `target/boutique.war`

## 6. Dockerisation de l'application

### 6.1 Dockerfile conseille (Tomcat + WAR)

Creer un fichier `Dockerfile` a la racine du projet avec le contenu suivant:

```dockerfile
FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn -B -DskipTests clean package

FROM tomcat:10.1-jdk17-temurin

# Supprime les applis par defaut de Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# finalName du pom.xml = boutique => boutique.war
COPY --from=build /app/target/boutique.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
```

Pourquoi `ROOT.war`:
- l'application est servie directement a la racine (`/`) au lieu de `/boutique`.

### 6.2 Build de l'image

```powershell
docker build -t boutique-web:tp .
```

### 6.3 Lancement du conteneur

```powershell
docker run -d --name boutique-web -p 8080:8080 boutique-web:tp
```

### 6.4 Verification

Ouvrir dans le navigateur:
- `http://localhost:8080/`

Attendu:
- redirection vers la page de login
- connexion possible
- acces catalogue et panier

## 7. Commandes Docker utiles

Lister les images:

```powershell
docker images
```

Lister les conteneurs:

```powershell
docker ps -a
```

Voir les logs:

```powershell
docker logs -f boutique-web
```

Arreter/supprimer le conteneur:

```powershell
docker stop boutique-web
docker rm boutique-web
```

Supprimer l'image:

```powershell
docker rmi boutique-web:tp
```

## 8. Tests a realiser pour valider le TP

- Build Maven reussi (`mvn clean package`).
- Build Docker reussi (`docker build`).
- Conteneur demarre sans erreur (`docker ps`).
- Application accessible sur `localhost:8080`.
- Parcours complet: login -> catalogue -> ajout panier -> suppression/vidage -> logout.

## 9. Problemes frequents et solutions

### Erreur COPY pendant le build Docker

Symptome:
- `COPY pom.xml` echoue

Cause probable:
- mauvaise racine de contexte Docker

Solution:
- lancer `docker build` depuis le dossier qui contient `pom.xml`

### Erreur sur le nom du WAR

Symptome:
- WAR introuvable dans `target`

Cause probable:
- mauvais nom copie dans le Dockerfile

Solution:
- utiliser `boutique.war` (car `finalName` vaut `boutique`)

### Port deja utilise

Symptome:
- echec de `docker run -p 8080:8080`

Solution:
- liberer le port 8080 ou mapper un autre port:

```powershell
docker run -d --name boutique-web -p 8081:8080 boutique-web:tp
```

Puis ouvrir:
- `http://localhost:8081/`

## 10. Livrables attendus

- Code source du projet
- `Dockerfile`
- `README.md` (ce document)
- Captures d'ecran recommandees:
  - build Maven reussi
  - build Docker reussi
  - application en fonctionnement (login/catalogue/panier)
  - `docker ps` + `docker logs`

## 11. Arborescence utile

```text
boutique_web_students/
|- pom.xml
|- Dockerfile
|- README.md
|- src/
|  |- main/
|     |- java/fr/boutique/servlet/
|     |- webapp/
|        |- css/style.css
|        |- WEB-INF/
|           |- web.xml
|           |- jsp/
|- target/
```

## 12. Resume rapide (checklist)

1. `mvn clean package`
2. Verifier `target/boutique.war`
3. Creer le `Dockerfile`
4. `docker build -t boutique-web:tp .`
5. `docker run -d --name boutique-web -p 8080:8080 boutique-web:tp`
6. Tester `http://localhost:8080/`

TP termine si toutes les validations de la section 8 sont OK.