package main

import (
	"log"

	"github.com/Khitoshi/Proglog/src/server"
)

func main() {
	srv := server.NewHTTPServer(":50051")
	log.Fatal(srv.ListenAndServe())
}
