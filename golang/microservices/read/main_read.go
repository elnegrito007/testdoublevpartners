package main

import (
	"fmt"
	"github.com/go-chi/chi"
	"github.com/go-chi/cors"
	"github.com/joho/godotenv"
	"net/http"
	"os"
	"regexp"
)

func main() {
	_ = godotenv.Load(".env")
	_ = http.ListenAndServe(":"+os.Getenv("PORT_READ_TICKET"), routerRead())
}

func routerRead() http.Handler {
	r := chi.NewRouter()
	cors2 := cors.New(cors.Options{
		AllowedOrigins:   []string{"*"},
		AllowedMethods:   []string{"POST"},
		AllowedHeaders:   []string{"Accept", "Authorization", "Content-Type"},
		ExposedHeaders:   []string{"Link"},
		AllowCredentials: true,
		MaxAge:           300,
	})
	r.Use(cors2.Handler)
	r.Route("/v1", func(r chi.Router) {
		r.Post("/read", func(w http.ResponseWriter, r *http.Request) {
			id := r.FormValue("id")
			if id == "" || regexp.MustCompile(`^[0-9]+`).MatchString(id) == false {
				_,_ = w.Write([]byte(`{"error":1,"message":"Faltan datos","data":[]}`))
			}else{
				request, _ := conect1.Get("user_"+id).Result()
				fmt.Println(request)
				_,_ = w.Write([]byte(`{"error":0,"message":"Usuario","data":[`+request+`]}`))
			}
		})
	})
	return r
}
