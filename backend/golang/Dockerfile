# Development stage
FROM golang:1.24-alpine AS dev
WORKDIR /app

RUN apk add --no-cache git && go install github.com/air-verse/air@latest

ENV GOPATH=/go
ENV GOMODCACHE=/app/.cache/go-mod
ENV GOCACHE=/app/.cache/go-build

RUN mkdir -p /app/.cache/go-build /app/.cache/go-mod && chmod -R 777 /app/.cache

COPY go.mod go.sum ./
RUN go mod download

COPY . .

EXPOSE 8080
CMD ["air"]


# Production stage
# FROM golang:1.24-alpine AS prod
# WORKDIR /app
# # Install shadow for adduser/addgroup if needed
# RUN apk add --no-cache shadow
# COPY go.mod go.sum ./golang/
# COPY . .
# RUN go build -o main .
# # Add user and group (using Alpine-compatible commands)
# RUN adduser --disabled-password --gecos "" vscode \
#     && addgroup docker \
#     && addgroup vscode docker
# EXPOSE 8080
# CMD ["./main"]
# USER vscode