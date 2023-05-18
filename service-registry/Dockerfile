FROM openjdk:17-alpine
MAINTAINER yashodha.dev.space
COPY target/service-registry.jar app.jar
EXPOSE 8761
ENTRYPOINT ["java","-jar","/app.jar"]