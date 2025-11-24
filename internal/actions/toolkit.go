package actions

import (
	"fmt"
	"log"
	"os"
)

func set(env, text string) error {
	f, err := os.OpenFile(os.Getenv(env), os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		log.Fatal(err)
	}
	if _, err := f.WriteString(fmt.Sprintf("%s\n", text)); err != nil {
		log.Fatal(err)
	}
	return f.Close()
}

func setPair(env, name, value string) error {
	return set(env, fmt.Sprintf("%s=%s", name, value))
}

func SetOutput(name, value string) error {
	return setPair(os.Getenv("GITHUB_OUTPUT"), name, value)
}

func SetEnv(name, value string) error {
	return setPair(os.Getenv("GITHUB_ENV"), name, value)
}

func SetPath(value string) error {
	return set(os.Getenv("GITHUB_PATH"), value)
}
