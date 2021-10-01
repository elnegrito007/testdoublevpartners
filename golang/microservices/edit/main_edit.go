package main

import (
	"github.com/buger/jsonparser"
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
	_ = http.ListenAndServe(":"+os.Getenv("PORT_EDIT_TICKET"), routerEdit())
}

func routerEdit() http.Handler {
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
		r.Post("/edit", func(w http.ResponseWriter, r *http.Request) {
			id := r.FormValue("id")
			if id == "" || regexp.MustCompile(`^[0-9]+`).MatchString(id) == false {
				_,_ = w.Write([]byte(`{"error":1,"message":"Faltan datos","data":[]}`))
			}else{
				request, _ := conect1.Get("user_"+id).Result()
				status, _, _, _ := jsonparser.Get([]byte(request), "estatus")
				times := time.Now().Unix()
				fecha_actualizacion, _ := jsonparser.Set([]byte(request),[]byte(strconv.FormatInt(times, 10)), "fecha_actualizacion")
				if string(status) == "abierto" {
					status, _ := jsonparser.Set(fecha_actualizacion,[]byte(`"cerrado"`), "estatus")
					_ = conect1.Set("user_"+id, string(status), 0).Err()
					_,_ = w.Write([]byte(`{"error":0,"message":"Usuario editado","data":[]}`))
				}else{
					status, _ := jsonparser.Set(fecha_actualizacion,[]byte(`"abierto"`), "estatus")
					_ = conect1.Set("user_"+id, string(status), 0).Err()
					_,_ = w.Write([]byte(`{"error":0,"message":"Usuario editado","data":[]}`))
				}
			}
		})
	})
	return r
}
