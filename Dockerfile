FROM golang:latest

WORKDIR /app

COPY go.mod go.sum ./

RUN apt-get update && apt-get install -y --no-install-recommends \
    tree \
    unzip \
    wget && \
    rm -rf /var/lib/apt/lists/*
    
RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v29.1/protoc-29.1-linux-x86_64.zip && \
    unzip protoc-29.1-linux-x86_64.zip -d /usr/local && \
    rm protoc-29.1-linux-x86_64.zip
    
RUN go mod tidy 

COPY ./src/ ./src/

COPY .git/ .git/

ENV PATH="/root/go/bin:$PATH"

CMD ["bash"]
