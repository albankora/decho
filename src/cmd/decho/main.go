package main

import (
	"fmt"
	"net/http"

	guuid "github.com/google/uuid"
	echo "github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func main() {

	e := echo.New()

	// Middleware
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	e.GET("/", index)
	e.GET("/health-check", healthCheck)

	e.Logger.Fatal(e.Start(":3000"))
}

func index(c echo.Context) error {
	return c.String(http.StatusOK, fmt.Sprintf("UUID: %s", guuid.New()))
}

// Handler
func healthCheck(c echo.Context) error {
	return c.String(http.StatusOK, "OK")
}
