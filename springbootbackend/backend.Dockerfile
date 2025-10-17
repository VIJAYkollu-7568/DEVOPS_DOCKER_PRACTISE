# Stage 1: Build
FROM --platform=linux/amd64 maven:3.9.5-eclipse-temurin-21 AS builder
WORKDIR /app
COPY pom.xml . 
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run
FROM --platform=linux/amd64 eclipse-temurin:21-jdk
WORKDIR /app

COPY --from=builder /app/target/*.jar app.jar

EXPOSE 2000

ENTRYPOINT ["java", "-jar", "app.jar"]
