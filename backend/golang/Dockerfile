# Development stage
FROM golang:1.24 AS dev

WORKDIR /app

RUN go install github.com/air-verse/air@latest

ENV GOPATH=/go
ENV GOMODCACHE=/app/.cache/go-mod
ENV GOCACHE=/app/.cache/go-build

RUN mkdir -p /app/.cache/go-build /app/.cache/go-mod && chmod -R 777 /app/.cache

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN groupadd docker && useradd -m -s /bin/bash -G docker vscode

RUN chown -R vscode:vscode /app

USER vscode

EXPOSE 8080

CMD ["air"]
