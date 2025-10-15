# Stage 1: Build the app
FROM eclipse-temurin:21-jdk AS builder

WORKDIR /app

# Copy Maven wrapper and pom.xml
COPY .mvn/ .mvn
COPY mvnw pom.xml ./

# Copy your actual source folder
COPY AIRLINEMANAGMENT/src ./src
COPY AIRLINEMANAGMENT/pom.xml ./  # if there’s a pom.xml inside AIRLINEMANAGMENT

# Build the app
RUN ./mvnw clean package -DskipTests

# Stage 2: Run the app
FROM eclipse-temurin:21-jdk

WORKDIR /app

COPY --from=builder /app/target/*.jar app.jar

EXPOSE 2004

ENTRYPOINT ["java", "-jar", "app.jar"]
