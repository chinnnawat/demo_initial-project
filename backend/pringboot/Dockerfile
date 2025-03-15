FROM openjdk:21-jdk-slim

# Set working directory
WORKDIR /app

# Copy only pom.xml first to leverage Docker caching
COPY core/pom.xml ./

# Install required dependencies offline to speed up builds
RUN apt-get update && apt-get install -y maven \
    && mvn dependency:go-offline

# RUN groupadd -g 1000 vscode && useradd -u 1000 -g 1000 -m -s /bin/bash vscode

# # Ensure proper ownership of the working directory
# RUN chown -R vscode:vscode /app

# Use non-root user

# Copy source code after setting correct ownership
COPY core/src /app/src

# # Switch to non-root user AFTER fixing permissions
# USER vscode

# Expose Spring Boot default port
EXPOSE 8080
