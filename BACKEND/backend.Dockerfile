# Stage 1: Build the app
FROM eclipse-temurin:21-jdk AS builder

WORKDIR /BACKEND

COPY .mvn/ .mvn
COPY mvnw pom.xml ./
COPY src ./src

RUN ./mvnw clean package -DskipTests

# Stage 2: Run the app
FROM eclipse-temurin:21-jdk

WORKDIR /BACKEND
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 2004

ENTRYPOINT ["java", "-jar", "app.jar"]
