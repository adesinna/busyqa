# Use the official Maven image to build the application
FROM maven:3.8.5-openjdk-17 AS build

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean install -DskipTests

# Debugging step: List files in the working directory to ensure JAR is present
RUN ls -l /app/target

# Use the official OpenJDK image to run the application
FROM openjdk:17-jdk-alpine

WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/movieist-0.0.1-SNAPSHOT.jar /app/movieist-0.0.1-SNAPSHOT.jar

# Expose port 8080
EXPOSE 8080

ENTRYPOINT ["java", "-jar", "movieist-0.0.1-SNAPSHOT.jar"]
