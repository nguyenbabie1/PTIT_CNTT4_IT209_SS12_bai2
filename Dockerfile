FROM eclipse-temurin:17-jdk AS builder
WORKDIR /app
COPY . .
RUN chmod +x gradlew && ./gradlew bootJar --no-daemon
RUN find build/libs -maxdepth 1 -name "*.jar" ! -name "*-plain.jar" -exec cp {} /app/app.jar \;

FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=builder /app/app.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
