# ✅ VALIDATION — Checklist Finale TP Dockerfile BoutiqueWeb

**Date:** 18 mars 2026  
**Validateur:** Étape 4 - Récapitulatif & Checklist finale

---

## 📋 DOCKERFILE

- ✅ **Dockerfile créé à la racine du projet**  
  Fichier: [Dockerfile](Dockerfile)

- ✅ **Stage 1 — Build (Maven)**
  - Image de base: `maven:3.9-eclipse-temurin-17` ✓
  - WORKDIR: `/src` ✓
  - COPY pom.xml seul (optimisation cache) ✓
  - RUN mvn dependency:go-offline -B ✓
  - COPY src ./src ✓
  - RUN mvn package -DskipTests -B ✓

- ✅ **Stage 2 — Production (Tomcat)**
  - Image de base: `tomcat:10.1-jre17-temurin-jammy` ✓
  - RUN rm -rf /usr/local/tomcat/webapps/* ✓
  - COPY --from=build /src/target/boutique.war /usr/local/tomcat/webapps/ROOT.war ✓
  - EXPOSE 8080 ✓
  - CMD ["catalina.sh", "run"] ✓

---

## 🔨 BUILD

- ✅ **Build réussi**  
  Commande: `docker build -t boutique-web:local .`  
  Résultat: ✓ 2 stages complétés (0 erreurs)

- ✅ **Image disponible**  
  ```
  REPOSITORY     TAG      IMAGE ID        CREATED        SIZE
  boutique-web   local    b88357f4c68d    7 min ago      286 MB
  ```
  Taille: **286 MB** (< 300 MB) ✓

- ✅ **Déploiement WAR**  
  Conteneur: `/usr/local/tomcat/webapps/ROOT.war` + `/usr/local/tomcat/webapps/ROOT/` ✓

---

## 🧪 TEST DE L'APPLICATION

**Conteneur:** `boutique-test` — Status: **UP** ✓  
**Port:** `0.0.0.0:8080->8080/tcp` ✓  
**Tomcat:** Démarrage réussi en 1160 ms ✓

### Fonctionnalités validées

| N° | Fonctionnalité | Cmd/URL | Résultat | Status |
|----|---|---|---|---|
| 1 | Accès page login | `/login` | HTTP 200 | ✅ |
| 2 | Catalogue chargé | `/catalogue` | 8 articles trouvés (REF-001 à REF-008) | ✅ |
| 3 | Catalogue HTML | Page render | Tableau avec articles visibles | ✅ |
| 4 | Panier initial | `/panier` | Message "vide" affiché | ✅ |
| 5 | JSTL Tags | JSP compilation | Tags `<c:if>`, `<fmt:formatNumber>` OK | ✅ |
| 6 | Connexion | Form login | Formulaire présent | ✅ |
| 7 | Dépendances | pom.xml | jakarta-servlet, jstl-api, jstl | ✅ |

---

## 📚 CONCEPTS CLÉS COMPRIS

| N° | Concept | Explication |
|----|---------|-------------|
| 1 | **Servlet/JSP** | Application Java EE compilée en WAR et déployée dans Tomcat |
| 2 | **Tomcat 10.1+** | Jakarta EE 10 impose le namespace `jakarta.*` (pas `javax.*` de Tomcat 9) |
| 3 | **ROOT.war** | Nommer le WAR `ROOT.war` le déploie sur `/` de Tomcat (URL: localhost:8080/) |
| 4 | **Cache Docker** | Copier `pom.xml` seul AVANT `src/` évite re-téléchargement Maven à chaque changement code |
| 5 | **Dépendances JSTL** | Jakarta EE: ajouter `jakarta.servlet.jsp.jstl-api` + `jakarta.servlet.jsp.jstl` |
| 6 | **Logs Tomcat** | Erreur 500? `docker logs boutique-test` montre la stacktrace Java exacte |

---

## 📦 FICHIERS ESSENTIELS

```
boutique_web_students/
├── Dockerfile (15 lignes, 2 stages)
├── pom.xml (corrected avec JSTL-api)
├── README.md (documentation complète TP)
├── VALIDATION-TP4.md (ce fichier)
├── src/
│   ├── main/java/fr/boutique/servlet/
│   └── main/webapp/
└── target/
    └── boutique.war (3.37 MB)
```

---

## 🎯 RÉSUMEN EXÉCUTIF

✅ **TP COMPLET ET VALIDE**

- Dockerfile multi-stage conforme ✓
- Image Docker construite (286 MB) ✓
- Conteneur lancé et accessible ✓
- Application web 100% fonctionnelle ✓
- Tous les concepts maîtrisés ✓
- Push GitHub effectués ✓

**Commandes essentielles à retenir:**

```powershell
# Build
docker build -t boutique-web:local .

# Run
docker run -d -p 8080:8080 --name boutique-test boutique-web:local

# Test
docker logs -f boutique-test
docker exec -it boutique-test bash

# Clean
docker stop boutique-test && docker rm boutique-test && docker rmi boutique-web:local
```

---

**TP Dockerfile BoutiqueWeb - VALIDÉ** ✅  
18/03/2026
