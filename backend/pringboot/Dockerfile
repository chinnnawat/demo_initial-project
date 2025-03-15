FROM openjdk:21-jdk-slim

WORKDIR /app
COPY core/pom.xml ./
COPY core/src ./src

RUN apt-get update && apt-get install -y maven

RUN groupadd docker && useradd -m -s /bin/bash -G docker vscode
RUN chown -R vscode:vscode /app

RUN mvn clean package -DskipTests && ls -lah target/

# ✅ Fix: Ensure JAR is copied properly
COPY core/target/*.jar app.jar

EXPOSE 8080
USER vscode

ENTRYPOINT ["java", "-jar", "app.jar"]
