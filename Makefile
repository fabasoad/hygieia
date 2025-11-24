.PHONY: build
build:
	@go build -o bin/hygieia cmd/main.go

.PHONY: install
install:
	@go install cmd/main.go

.PHONY: install-deps
install-deps:
	@go mod tidy

.PHONY: test
test:
	@go test -coverprofile=coverage.out ./...

.PHONY: test-console
test-console: test
	@go tool cover -func=coverage.out

.PHONY: test-html
test-html: test
	@go tool cover -html=coverage.out

.PHONY: run/pre
run/pre: build
	@./bin/hygieia "pre"

.PHONY: run/main
run/main: build
	@./bin/hygieia "main"

.PHONY: run/post
run/post: build
	@./bin/hygieia "post"

.PHONY: quick-run
quick-run:
	@go run -race cmd/main.go

.PHONY: update
update:
	@go get -u ./...

.PHONY: vet
vet:
	@go vet ./...

.PHONY: errcheck
errcheck:
	@go tool github.com/kisielk/errcheck ./...

.PHONY: staticcheck
staticcheck:
	@go tool honnef.co/go/tools/cmd/staticcheck ./...

.PHONY: golangci-lint
golangci-lint:
	@go tool github.com/golangci/golangci-lint/v2/cmd/golangci-lint run ./...

.PHONY: lint
lint: vet errcheck staticcheck golangci-lint

.PHONY: update-coverage-badge
update-coverage-badge:
	@./scripts/update-coverage-badge.sh
