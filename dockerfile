# ========================
# Stage 1: Build the application
# ========================
FROM maven:3.9.4-eclipse-temurin-17 AS build

# Set working directory
WORKDIR /app

# Copy Maven configuration and source code
COPY pom.xml .
COPY src ./src

# Build the Spring Boot JAR (skip tests for faster builds)
RUN mvn clean package -DskipTests

# ========================
# Stage 2: Create lightweight runtime image
# ========================
FROM eclipse-temurin:17-jdk-alpine

# Set working directory
WORKDIR /app

# Copy the JAR from the build stage
COPY --from=build /app/target/app.jar app.jar

# Ensure the JAR is readable (fixes Jenkins permission issues)
RUN chmod +r app.jar

# Optional: create non-root user for better security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# Expose the default Spring Boot port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
