FROM openjdk:21-jdk-slim

WORKDIR /app
COPY core/pom.xml ./
COPY core/src ./src

RUN apt-get update && apt-get install -y maven

# Create user and group
RUN groupadd docker && useradd -m -s /bin/bash -G docker vscode

# Ensure proper ownership and permissions
RUN chown -R vscode:vscode /app
RUN mkdir -p /app/target && chown -R vscode:vscode /app/target && chmod -R 777 /app/target

# Set user AFTER ensuring it exists
USER vscode

# Run Maven as vscode user
RUN mvn clean package -DskipTests && ls -lah target/

COPY core/target/*.jar app.jar

EXPOSE 8080
