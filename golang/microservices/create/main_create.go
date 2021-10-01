package main

import (
	"github.com/go-chi/chi"
	"github.com/go-chi/cors"
	"github.com/joho/godotenv"
	"net/http"
	"os"
	"regexp"
	"strconv"
	"time"
)

func main() {
	_ = godotenv.Load(".env")
	_ = http.ListenAndServe(":"+os.Getenv("PORT_CREATE_TICKET"), routerCreate())
}


func routerCreate() http.Handler {
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
		r.Post("/create", func(w http.ResponseWriter, r *http.Request) {
			user := r.FormValue("usuario")
			if user == "" || regexp.MustCompile(`^[a-zA-Z0-9ÁÉÍÓÚÜÑáéíóúüñ]+`).MatchString(user) == false {
				_,_ = w.Write([]byte(`{"error":1,"message":"Faltan datos","data":[]}`))
			}else{
				times := time.Now().Unix()
				count, _ := conect1.Keys("user_*").Result()
				_ = conect1.Set("user_"+strconv.Itoa(len(count)+1), `{"id":`+strconv.Itoa(len(count)+1)+`,"usuario":"`+user+`","fecha_creacion":`+strconv.FormatInt(times, 10)+`,"fecha_actualizacion":0,"estatus":"abierto"}`, 0).Err()
				_,_ = w.Write([]byte(`{"error":0,"message":"Usuario creado","data":[]}`))
			}
		})
	})
	return r
}
