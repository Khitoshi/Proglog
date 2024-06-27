# Stage 1: Build the Go application
FROM golang:1.20 AS builder

# Install the necessary package
RUN apt-get update && apt-get install -y --no-install-recommends file

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy go.mod and go.sum files
COPY go.mod go.sum ./

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
RUN go mod download

# Copy the source from the current directory to the Working Directory inside the container
COPY . .

# Build the Go app with static linking
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main ./cmd/server

# 確認のためにlsコマンドを追加
RUN ls -la /app
RUN file /app/main || true

# Stage 2: Create a lightweight container for running the Go app
FROM alpine:latest

# インストールに必要なパッケージを追加
RUN apk --no-cache add ca-certificates file
RUN apk --no-cache add ca-certificates curl

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy the Pre-built binary file from the builder stage
COPY --from=builder /app/main .

# 確認のためにlsコマンドを追加
RUN ls -la /app
RUN file /app/main || true

# Expose port 8080 to the outside world
EXPOSE 8080

# Command to run the executable
CMD ["./main"]
