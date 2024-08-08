package main

import (
	"flag"
	"fmt"
	"log"
	"math/rand/v2"
	"net/http"
	"time"
)

type handler struct {
	maxTime time.Duration
}

func (h *handler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	m := rand.IntN(10_000)
	res := 0
	for i := 0; i < 100_000; i++ {
		for j := 0; j < m; j++ {
			res += i * j
		}
	}
	_, _ = w.Write([]byte(fmt.Sprintf("%v -> %v", m, res)))
}

func main() {
	endpoint := flag.String("endpoint", "localhost:8888", "http service endpoint")
	maxTime := flag.Duration("max-time", time.Second, "maximum request time")
	flag.Parse()

	h := handler{
		maxTime: *maxTime,
	}
	s := &http.Server{
		Addr:    *endpoint,
		Handler: &h,
	}
	log.Printf("Listening on %s", s.Addr)
	log.Fatal(s.ListenAndServe())
}
