FROM maven:3.6.0-jdk-11-slim AS build
COPY src ../apijavasenac/src
COPY pom.xml ../apijavasenac/
RUN mvn clean install -DskipTests
RUN mvn -f ../apijavasenac/pom.xml clean package

FROM adoptopenjdk/openjdk11:alpine-jre
EXPOSE 8080
COPY src/main/resources/application.properties /app/src/main/resources/application.properties
ADD target/api-springboot-0.0.1.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]