FROM openjdk:21-alpine
MAINTAINER yashodha.dev.space
COPY target/image-service.jar app.jar
EXPOSE 8200
ENTRYPOINT ["java","-jar","/app.jar"]
