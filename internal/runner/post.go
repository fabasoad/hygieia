package runner

import (
	"errors"
	"fmt"
	"log/slog"
	"os"

	"github.com/samber/do/v2"

	"github.com/fabasoad/hygieia/internal/hook"
)

type Post struct {
	Injector do.Injector
}

func (r *Post) Run(_ ...string) error {
	err := r.cleanupEnvironment()
	if err != nil {
		return err
	}
	slog.Info("running post hooks started")
	defer slog.Info("running post hooks completed")
	return hook.InvokeAll(r.Injector, func(h hook.Hook) error {
		return h.Post()
	})
}

func (r *Post) cleanupEnvironment() error {
	slog.Info("cleaning up environment started")
	defer slog.Info("cleaning up environment completed")
	var aggregatedErr error
	if err := r.removeDir("bin-dir-path"); err != nil {
		aggregatedErr = err
	}
	if err := r.removeDir("cache-dir-path"); err != nil {
		if aggregatedErr == nil {
			aggregatedErr = err
		} else {
			aggregatedErr = errors.Join(aggregatedErr, err)
		}
	}
	return aggregatedErr
}

func (r *Post) removeDir(name string) error {
	dir := do.MustInvokeNamed[string](r.Injector, name)
	slog.Debug(fmt.Sprintf("removing %s dir recursively", dir))
	return os.RemoveAll(dir)
}
