package main

import (
	"fmt"
	"log/slog"
	"os"

	"github.com/samber/do/v2"

	"github.com/fabasoad/hygieia/internal/hook"
	"github.com/fabasoad/hygieia/internal/runner"
)

func main() {
	if len(os.Args) != 2 {
		slog.Error(fmt.Sprintf("Usage: %s <pre|main|post>", os.Args[0]))
		os.Exit(1)
	}
	injector := do.New()
	register(injector)

	stage, err := runner.ConvertStringToRunStage(os.Args[1])
	if err != nil {
		slog.Error(err.Error())
		os.Exit(1)
	}
	r := do.MustInvokeNamed[runner.Runner](injector, string(stage))
	if err = r.Run(); err != nil {
		slog.Error(err.Error())
		os.Exit(1)
	}
}

func register(i do.Injector) {
	// register runners
	do.ProvideNamedValue(i, "pre", &runner.Pre{
		Injector: i,
	})
	do.ProvideNamedValue(i, "main", &runner.Main{
		Injector: i,
	})
	do.ProvideNamedValue(i, "post", &runner.Post{
		Injector: i,
	})
	// register hooks
	do.ProvideValue[[]hook.Hook](i, []hook.Hook{
		&hook.Ncu{
			Injector: i,
		},
		&hook.PreCommit{
			Injector: i,
		},
		&hook.PreCommitPrettier{
			Injector: i,
		},
	})
	// register consts
	do.ProvideNamedValue(i, "bin-dir-path", fmt.Sprintf("%s/bin", os.Getenv("RUNNER_TEMP")))
	do.ProvideNamedValue(i, "cache-dir-path", fmt.Sprintf("%s/.cache", os.Getenv("RUNNER_TEMP")))
	do.ProvideNamedValue(i, "changed-repos-file-path", fmt.Sprintf("%s/.cache/changed_repos.txt", os.Getenv("RUNNER_TEMP")))
}
