# Stage 1: Build the Go application
FROM golang:1.20 AS builder

# Install the necessary packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    file \
    protobuf-compiler \
    curl

# Set the Current Working Directory inside the container
WORKDIR /app

# Install protoc-gen-go and protoc-gen-go-grpc
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.28.1
RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.1

# Copy go.mod and go.sum files
COPY go.mod go.sum ./

# Download all dependencies
RUN go mod download

# Copy the source from the current directory to the Working Directory inside the container
COPY . .

# Generate gRPC code
RUN protoc --proto_path=proto --go_out=paths=source_relative:. --go-grpc_out=paths=source_relative:. proto/log.proto

# Build the Go app with static linking
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main ./cmd/server

# Stage 2: Create a lightweight container for running the Go app
FROM ubuntu:latest

# Install necessary packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    file \
    curl

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy the Pre-built binary file from the builder stage
COPY --from=builder /app/main .

# Expose port 50051 to the outside world
EXPOSE 50051

# Command to run the executable
CMD ["./main"]
