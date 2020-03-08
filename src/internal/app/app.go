package app

import (
	"decho/pkg/uuid"
	"fmt"
	"net/http"

	echo "github.com/labstack/echo/v4"
)

// Index Handler
func Index(c echo.Context) error {
	return c.String(http.StatusOK, fmt.Sprintf("UUID: %s", uuid.New()))
}

// HealthCheck Handler
func HealthCheck(c echo.Context) error {
	return c.String(http.StatusOK, "OK")
}
