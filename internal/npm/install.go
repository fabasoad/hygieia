package npm

import (
	"fmt"
	"log/slog"
	"os/exec"

	"github.com/fabasoad/hygieia/internal/exec_cmd"
)

func Install(executable, packageName string) error {
	if _, err := exec.LookPath(executable); err == nil {
		path, err := exec.Command("which", executable).Output()
		if err != nil {
			return err
		}
		slog.Info(fmt.Sprintf("%s is found at %s. Installation skipped", executable, string(path)))
	} else {
		err = exec_cmd.Run("npm", "install", "-g", packageName)
		if err != nil {
			return err
		}
		slog.Info(fmt.Sprintf("%s successfully installed", packageName))
	}
	return nil
}

func Uninstall(executable, packageName string) error {
	if _, err := exec.LookPath(executable); err == nil {
		err = exec_cmd.Run("npm", "uninstall", "-g", packageName)
		if err != nil {
			return err
		}
		slog.Info(fmt.Sprintf("%s successfully uninstalled", packageName))
	}
	return nil
}
