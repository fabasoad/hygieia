#!/usr/bin/env sh

SCRIPT_PATH=$(realpath "$0")
SCRIPT_DIR_PATH=$(dirname "${SCRIPT_PATH}")
HOOKS_DIR_PATH=$(dirname "${SCRIPT_DIR_PATH}")
SRC_DIR_PATH=$(dirname "${HOOKS_DIR_PATH}")
LIB_DIR_PATH="${SRC_DIR_PATH}/lib"

. "${LIB_DIR_PATH}/logging.sh"

main() {
  log_info_hook "main" "pre-commit" "Started"
  if [ -f ".pre-commit-config.yaml" ]; then
    pre-commit autoupdate
    git add .pre-commit-config.yaml
  else
    log_info_hook "main" "pre-commit" ".pre-commit-config.yaml file is not found"
  fi
  log_info_hook "main" "pre-commit" "Completed"
}

main "$@"
