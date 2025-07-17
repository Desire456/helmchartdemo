FROM gradle:8.14.3 AS builder
# Copy the source code of the application.
COPY . /src
WORKDIR /src
# Run Maven to build the project.
RUN gradle build -x check --no-daemon --warning-mode none

# The image to deploy to the cluster.
FROM eclipse-temurin:21-jdk
WORKDIR /app
# Copy the project executable from the build image.
COPY --from=builder /src/build/libs/helmchartdemo-0.0.1-SNAPSHOT.jar ./app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","./app.jar"]
