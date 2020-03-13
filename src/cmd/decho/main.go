package main

import (
	"decho/internal/handlers"
	"decho/internal/openapi"
	"fmt"
	"os"

	"github.com/deepmap/oapi-codegen/pkg/middleware"
	echo "github.com/labstack/echo/v4"
	echomiddleware "github.com/labstack/echo/v4/middleware"
)

func main() {

	swagger, err := openapi.GetSwagger()
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error loading swagger spec\n: %s", err)
		os.Exit(1)
	}

	// Clear out the servers array in the swagger spec, that skips validating
	// that server names match. We don't know how this thing will be run.
	swagger.Servers = nil

	e := echo.New()

	e.Use(echomiddleware.Logger())
	e.Use(echomiddleware.Recover())
	// Use our validation middleware to check all requests against the
	// OpenAPI schema.
	e.Use(middleware.OapiRequestValidator(swagger))

	petStore := handlers.NewPetStore()

	// We now register our petStore above as the handler for the interface
	openapi.RegisterHandlers(e, petStore)

	port := 3000
	e.Logger.Fatal(e.Start(fmt.Sprintf("0.0.0.0:%d", port)))

}
