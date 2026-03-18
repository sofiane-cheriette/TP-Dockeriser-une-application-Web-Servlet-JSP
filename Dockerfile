# -- STAGE 1 : build ---------------------------------
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /src
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn package -DskipTests -B

# -- STAGE 2 : production ----------------------------
FROM tomcat:10.1-jre17-temurin-jammy
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /src/target/boutique.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]