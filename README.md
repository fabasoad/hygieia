# hygieia

![linting](https://github.com/fabasoad/hygieia/actions/workflows/linting.yml/badge.svg)
![security](https://github.com/fabasoad/hygieia/actions/workflows/security.yml/badge.svg)

Hygieia is a goddess of health (Greek: ὑγίεια), cleanliness and hygiene..... of
my repos 🧹

## This is not a pre-commit hook repo

This repository cannot be used as a `repo:` in `.pre-commit-config.yaml`.
It has no `.pre-commit-hooks.yaml`, so adding it there will fail. It is a
standalone automation tool for maintaining `fabasoad` repositories, not a
hook repo. The "Hooks" below are its own maintenance scripts, not
pre-commit hooks. For actual pre-commit hooks, see the hook repos under
<https://github.com/fabasoad/>, for example `pre-commit-snyk`,
`pre-commit-grype` and `pre-commit-checkstyle`.

## Hooks

Hooks is a set of scripts that automate various tasks across multiple repositories.
This automation uses "fabasoad-contents-crud" GitHub App and runs every Friday
at 07:00 JST.

### asdf

This script is used to bump asdf dependencies versions in the `.tool-versions` file
within all `fabasoad` repositories.

### pre-commit prettier

This script is used to bump prettier hook version in the `.pre-commit-config.yaml`
file within all `fabasoad` repositories.

## Contributions

![Alt](https://repobeats.axiom.co/api/embed/06431e53b6ddc618cf0458490849e3597c39411e.svg "Repobeats analytics image")
