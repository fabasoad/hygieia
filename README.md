# hygieia

![linting](https://github.com/fabasoad/hygieia/actions/workflows/linting.yml/badge.svg)
![security](https://github.com/fabasoad/hygieia/actions/workflows/security.yml/badge.svg)

Hygieia is a goddess of health (Greek: ὑγίεια), cleanliness and hygiene..... of
my repos 🧹

## Hooks

Hooks is a set of scripts that automate various tasks across multiple repositories.
This automation uses "fabasoad-contents-crud" GitHub App and runs every Friday
at 07:00 JST.

### asdf

This script is used to bump asdf dependencies versions in the `.tool-versions` file
within all `fabasoad` repositories.

### ncu

This script is used to bump npm dependencies versions in the `package.json` file
within all `fabasoad` repositories.

### pre-commit

This script is used to bump the pre-commit hooks version in the `.pre-commit-config.yaml`
file within all `fabasoad` repositories.

### pre-commit prettier

This script is used to bump prettier hook version in the `.pre-commit-config.yaml`
file within all `fabasoad` repositories.

## Contributions

![Alt](https://repobeats.axiom.co/api/embed/06431e53b6ddc618cf0458490849e3597c39411e.svg "Repobeats analytics image")
