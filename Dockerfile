#Fat Jar
#FROM adoptopenjdk/openjdk11:alpine
#EXPOSE 8080
#ARG JAR_FILE=build/libs/readinessandliveness-0.0.1-SNAPSHOT.jar
#ADD ${JAR_FILE} app.jar
#ENTRYPOINT ["java","-jar","/app.jar"]

FROM gradle:7.4.1-jdk11 as builder
COPY . /home/gradle/project
WORKDIR /home/gradle/project 
RUN gradle clean build -x test

FROM adoptopenjdk/openjdk11:alpine as extractor
WORKDIR application
ARG JAR_FILE=/home/gradle/project/build/libs/readinessandliveness-0.0.1-SNAPSHOT.jar
COPY --from=builder ${JAR_FILE} application.jar
RUN java -Djarmode=layertools -jar application.jar extract

FROM adoptopenjdk/openjdk11:alpine
WORKDIR application
COPY --from=extractor application/dependencies/ ./
COPY --from=extractor application/spring-boot-loader/ ./
COPY --from=extractor application/snapshot-dependencies/ ./
COPY --from=extractor application/application/ ./
ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]