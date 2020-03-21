package uuid

import (
	guuid "github.com/google/uuid"
)

func New() guuid.UUID {
	return guuid.New()
}
