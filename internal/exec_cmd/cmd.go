package exec_cmd

import (
	"log"
	"os/exec"
)

func Run(name string, args ...string) error {
	cmd := exec.Command(name, args...)
	cmd.Stdout = log.Writer()
	cmd.Stderr = log.Writer()
	return cmd.Run()
}
