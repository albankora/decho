package main

import (
	"decho/internal/app"

	echo "github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func main() {

	e := echo.New()

	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	e.GET("/", app.Index)
	e.GET("/health-check", app.HealthCheck)

	e.Logger.Fatal(e.Start(":3000"))
}
