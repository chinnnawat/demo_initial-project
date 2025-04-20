FROM golang:1.24 AS dev

WORKDIR /app

RUN go install github.com/air-verse/air@latest

ENV GOPATH=/go
ENV GOMODCACHE=/app/.cache/go-mod
ENV GOCACHE=/app/.cache/go-build
ENV GOSUMDB=off

RUN mkdir -p /app/.cache/go-build /app/.cache/go-mod && chmod -R 777 /app/.cache

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN groupadd -r docker && useradd -m -s /bin/bash -g docker vscode

# RUN chown -R vscode:docker /app

USER vscode

EXPOSE 8080

CMD ["air"]
