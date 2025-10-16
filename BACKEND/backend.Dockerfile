# Stage 1: Build the app
FROM eclipse-temurin:21-jdk AS builder

WORKDIR /app

# Copy Maven wrapper and pom.xml
COPY airlinemanagement/.mvn/ .mvn
COPY airlinemanagement/mvnw airlinemanagement/pom.xml ./

# ✅ Give execute permission to mvnw
RUN chmod +x mvnw

# Copy source code
COPY airlinemanagement/src ./src

# Build the app
RUN ./mvnw clean package -DskipTests

# Stage 2: Run the app
FROM eclipse-temurin:21-jdk

WORKDIR /app

# Copy built jar
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 2004

ENTRYPOINT ["java", "-jar", "app.jar"]
