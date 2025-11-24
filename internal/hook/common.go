package hook

import (
	"errors"

	"github.com/samber/do/v2"
)

type Hook interface {
	Pre() error
	Main() error
	Post() error
}

type Invoker func(h Hook) error

func InvokeAll(i do.Injector, invoker Invoker) error {
	var aggregatedErrors error
	for _, h := range do.MustInvoke[[]Hook](i) {
		err := invoker(h)
		if err != nil {
			if aggregatedErrors == nil {
				aggregatedErrors = err
			} else {
				aggregatedErrors = errors.Join(aggregatedErrors, err)
			}
		}
	}
	return aggregatedErrors
}
