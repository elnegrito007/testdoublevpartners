package main

import (
	"context"
	"github.com/go-redis/redis"
	"github.com/joho/godotenv"
	"os"
)

func DbConect() (cliente *redis.Client) {
	_ = godotenv.Load(".env")
	client := redis.NewClient(&redis.Options{
		Addr:     os.Getenv("HOST_REDIS"),
		Password: os.Getenv("PASS_REDIS"),
		DB:       0,
	})
	return client
}

var conect1 = DbConect()

var ctx = context.Background()
