#!/usr/bin/env sh

SCRIPT_PATH=$(realpath "$0")
SCRIPT_DIR_PATH=$(dirname "${SCRIPT_PATH}")
HOOKS_DIR_PATH=$(dirname "${SCRIPT_DIR_PATH}")
SRC_DIR_PATH=$(dirname "${HOOKS_DIR_PATH}")
LIB_DIR_PATH="${SRC_DIR_PATH}/lib"

. "${LIB_DIR_PATH}/logging.sh"

main() {
  log_info_hook "post" "ncu" "Started"
  if command -v ncu >/dev/null 2>&1; then
    npm uninstall -g npm-check-updates
  fi
  log_info_hook "post" "ncu" "Completed"
}

main "$@"
