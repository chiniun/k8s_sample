package main

import (
	"fmt"
	"net/http"
)

type X struct{}

func (X) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("ret"))
}

func main() {
	fmt.Println("start")
	http.HandleFunc("/ret",X{}.ServeHTTP)
	http.ListenAndServe(":9999", nil)
}
