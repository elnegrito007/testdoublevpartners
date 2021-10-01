package main

import (
	"fmt"
	"github.com/go-chi/chi"
	"github.com/go-chi/cors"
	"github.com/joho/godotenv"
	"net/http"
	"os"
	"strings"
)

func main() {
	_ = godotenv.Load(".env")
	_ = http.ListenAndServe(":"+os.Getenv("PORT_READALL_TICKET"), routerReadAll())
}

func routerReadAll() http.Handler {
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
		r.Post("/readall", func(w http.ResponseWriter, r *http.Request) {
			list, _ := conect1.Keys("user_*").Result()
			result, _ := conect1.MGet(list...).Result()
			stringedIDs := fmt.Sprintf("%v", result)
			stringedIDs = stringedIDs[1 : len(stringedIDs)-1]
			stringedIDs = strings.ReplaceAll(stringedIDs, " ", ",")
			_,_ = w.Write([]byte(`{"error":0,"message":"Lista de usuarios","data":[`+stringedIDs+`]}`))
		})
	})
	return r
}
