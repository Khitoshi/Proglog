FROM golang:latest

WORKDIR /app

COPY go.mod go.sum ./

#RUN go mod download
RUN go mod tidy

COPY ./src/ ./src/

COPY .git/ .git/

CMD ["bash"]