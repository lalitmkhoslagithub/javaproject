# Multi-stage build setup (https://docs.docker.com/develop/develop-images/multistage-build/)


# Stage 1 (to create a "build" image, ~140MB)
FROM openjdk:8-jdk-alpine3.8
RUN java -version

COPY . /usr/src/myapp/
WORKDIR /usr/src/myapp/
RUN apk --no-cache add maven && mvn --version
RUN mvn package

# Stage 2 (to create a downsized "container executable", ~87MB)
#FROM openjdk:8-jre-alpine3.8
#WORKDIR /root/
#COPY --from=builder /usr/src/myapp/target/app.jar .
#ADD /usr/src/myapp/target/app.jar /root/
#WORKDIR /root/

EXPOSE 8123
ENTRYPOINT ["java", "-jar", "/usr/src/myapp/target/app.jar"]
