FROM openjdk:21-jdk-slim

# Set working directory
WORKDIR /app

COPY core/pom.xml ./

RUN apt-get update && apt-get install -y maven \
    && mvn dependency:go-offline

COPY core/src /app/src

RUN mvn clean

RUN groupadd docker && useradd -m -s /bin/bash -G docker vscode

RUN chown -R vscode:vscode /app

USER vscode

EXPOSE 8080
