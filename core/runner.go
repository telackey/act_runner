package core

const UUIDHeader = "x-runner-uuid"

// Runner struct
type Runner struct {
	ID    int64  `json:"id"`
	UUID  string `json:"uuid"`
	Name  string `json:"name"`
	Token string `json:"token"`
}