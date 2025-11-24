package hook

import (
	"log/slog"

	"github.com/samber/do/v2"

	"github.com/fabasoad/hygieia/internal/npm"
)

type Ncu struct {
	Injector do.Injector
}

func (n *Ncu) Pre() error {
	slog.Info("running ncu pre-automation script...")
	err := npm.Install("ncu", "npm-check-updates")
	if err != nil {
		return err
	}
	err = npm.Install("pnpm", "pnpm")
	if err != nil {
		return err
	}
	return nil
}

func (n *Ncu) Main() error {
	// TODO: implement ncu main hook
	return nil
}

func (n *Ncu) Post() error {
	slog.Info("running ncu post-automation script...")
	return npm.Uninstall("ncu", "npm-check-updates")
}
