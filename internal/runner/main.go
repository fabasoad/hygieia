package runner

import (
	"log/slog"
	"os/exec"

	"github.com/samber/do/v2"

	"github.com/fabasoad/hygieia/internal/exec_cmd"
)

type Main struct {
	Injector do.Injector
}

func (r *Main) Run(args ...string) error {
	slog.Info("running main hooks started")
	defer slog.Info("running main hooks completed")
	shPath, err := exec.LookPath("sh")
	if err != nil {
		return err
	}
	inputRegex := args[0]
	err = exec_cmd.Run(
		"gh",
		"foreach",
		"run",
		"--cleanup",
		"--no-confirm",
		"--shell", shPath,
		"--visibility", "public",
		"--affiliations", "owner",
		"--regex", inputRegex,
		"${AUTOMATION_DIR_PATH}/run.sh",
	)
	if err != nil {
		return err
	}
	return nil
}
