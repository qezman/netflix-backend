# FROM ubuntu

# # install dependencies
# RUN apt-get update && apt-get install -y \
#     openjdk-17-jre-headless \
#     maven

# # Setting the working directory
# WORKDIR /app

# # Copy the source file and pom.xml
# COPY ./src /app
# COPY ./pom.xml /app

# # Build the application
# RUN mvn -f /app/pom.xml clean package -DskipTests
# RUN ls -la /app/target

# # Copy the jar file
# COPY ./target/*.jar /app/app.jar

# # Expose the port
# EXPOSE 8080

# # Run the application
# CMD ["java", "-jar", "app.jar"]

# ======================================

FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY ./pom.xml .
COPY ./src ./src
COPY .env /src/main/resources/.env
RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
