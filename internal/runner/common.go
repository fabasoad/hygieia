package runner

import (
	"fmt"
)

type Runner interface {
	Run(args ...string) error
}

type Stage string

const (
	StagePre  Stage = "pre"
	StageMain Stage = "main"
	StagePost Stage = "post"
)

func ConvertStringToRunStage(s string) (Stage, error) {
	switch s {
	case "pre":
		return StagePre, nil
	case "main":
		return StageMain, nil
	case "post":
		return StagePost, nil
	default:
		return "", fmt.Errorf("unexpected run stage value: %s", s)
	}
}
