package runner

import (
	"log/slog"
	"os"

	"github.com/samber/do/v2"

	"github.com/fabasoad/hygieia/internal/actions"
	"github.com/fabasoad/hygieia/internal/hook"
)

type Pre struct {
	Injector do.Injector
}

func (r *Pre) Run(_ ...string) error {
	err := r.setupEnvironment()
	if err != nil {
		return err
	}
	slog.Info("running pre hooks started")
	defer slog.Info("running pre hooks completed")
	return hook.InvokeAll(r.Injector, func(h hook.Hook) error {
		return h.Pre()
	})
}

func (r *Pre) setupEnvironment() error {
	slog.Info("setting up environment started")
	defer slog.Info("setting up environment completed")
	err := r.createBinDir()
	if err != nil {
		return err
	}
	err = r.createCacheDir()
	if err != nil {
		return err
	}
	return r.setChangedReposFilePath()
}

func (r *Pre) createBinDir() error {
	binDirPath := do.MustInvokeNamed[string](r.Injector, "bin-dir-path")
	err := os.MkdirAll(binDirPath, os.ModePerm)
	if err != nil {
		return err
	}
	err = actions.SetEnv("BIN_DIR_PATH", binDirPath)
	if err != nil {
		return err
	}
	return actions.SetPath(binDirPath)
}

func (r *Pre) createCacheDir() error {
	cacheDirPath := do.MustInvokeNamed[string](r.Injector, "cache-dir-path")
	err := os.MkdirAll(cacheDirPath, os.ModePerm)
	if err != nil {
		return err
	}
	return actions.SetEnv("CACHE_DIR_PATH", cacheDirPath)
}

func (r *Pre) setChangedReposFilePath() error {
	changedReposFilePath := do.MustInvokeNamed[string](r.Injector, "changed-repos-file-path")
	f, err := os.Create(changedReposFilePath)
	if err != nil {
		return err
	}
	err = actions.SetEnv("CHANGED_REPOS_FILE_PATH", changedReposFilePath)
	if err != nil {
		return err
	}
	return f.Close()
}
