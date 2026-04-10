FROM ubuntu

# install dependencies
RUN apt apt-get update && apt-get install -y
RUN apt install openjdk-17-jre-headless -y
RUN apt install maven -y

# Setting the working directory
WORKDIR /app

# Copy the source file and pom.xml
COPY ./src /app
COPY ./pom.xml /app

# Build the application
RUN mvn -f /app/pom.xml clean package -DskipTests

# Copy the jar file
COPY ./target/*.jar /app/app.jar

# Expose the port
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]

# ======================================

# FROM eclipse-temurin:25
# RUN mkdir /opt/app
# COPY japp.jar /opt/app
# CMD ["java", "-jar", "japp.jar"]
