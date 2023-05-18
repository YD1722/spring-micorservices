FROM openjdk:17-alpine
MAINTAINER yashodha.dev.space
COPY target/image-processing-service.jar app.jar
EXPOSE 8400
ENTRYPOINT ["java","-jar","/app.jar"]