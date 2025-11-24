package hook

import "github.com/samber/do/v2"

type PreCommitPrettier struct {
	Injector do.Injector
}

func (n *PreCommitPrettier) Pre() error {
	// TODO: implement pre-commit-prettier pre hook
	return nil
}

func (n *PreCommitPrettier) Main() error {
	// TODO: implement pre-commit-prettier main hook
	return nil
}

func (n *PreCommitPrettier) Post() error {
	// TODO: implement pre-commit-prettier post hook
	return nil
}
