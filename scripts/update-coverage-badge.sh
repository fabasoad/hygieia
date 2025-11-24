#!/usr/bin/env sh

SCRIPT_PATH=$(realpath "$0")
SCRIPTS_DIR_PATH=$(dirname "${SCRIPT_PATH}")
ROOT_PATH=$(dirname "${SCRIPTS_DIR_PATH}")

main() {
  cov=$(go tool cover -func=coverage.out | grep total | awk '{print $3}')
  cov_int="${cov%%.*}"
  if [ "${cov_int}" -lt 40 ]; then
    color="red"
  elif [ "${cov_int}" -lt 80 ]; then
    color="yellow"
  else
    color="green"
  fi
  new_line="![tests-coverage](https://img.shields.io/badge/coverage-${cov}25-${color})"
  sed "s|^!\[tests-coverage](https://img.shields.io/badge/coverage-[^)]*)$|${new_line}|" "${ROOT_PATH}/README.md" > "${ROOT_PATH}/README.tmp" \
    && mv "${ROOT_PATH}/README.tmp" "${ROOT_PATH}/README.md"
}

main "$@"
