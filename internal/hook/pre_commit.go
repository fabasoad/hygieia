package hook

import "github.com/samber/do/v2"

type PreCommit struct {
	Injector do.Injector
}

func (n *PreCommit) Pre() error {
	// TODO: implement pre-commit pre hook
	return nil
}

func (n *PreCommit) Main() error {
	// TODO: implement pre-commit main hook
	return nil
}

func (n *PreCommit) Post() error {
	// TODO: implement pre-commit post hook
	return nil
}
