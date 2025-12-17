#!/usr/bin/env sh

SCRIPT_PATH=$(realpath "$0")
SCRIPT_DIR_PATH=$(dirname "${SCRIPT_PATH}")
HOOKS_DIR_PATH=$(dirname "${SCRIPT_DIR_PATH}")
SRC_DIR_PATH=$(dirname "${HOOKS_DIR_PATH}")
LIB_DIR_PATH="${SRC_DIR_PATH}/lib"

. "${LIB_DIR_PATH}/logging.sh"

main() {
  log_info_hook "pre" "pre-commit" "Started"
  if command -v pre-commit >/dev/null 2>&1; then
    log_info_hook "pre" "pre-commit" "pre-commit is found at $(which pre-commit). Installation skipped."
  else
    pip install pre-commit
  fi
  log_info_hook "pre" "pre-commit" "Completed"
}

main "$@"
