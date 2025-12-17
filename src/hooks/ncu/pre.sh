#!/usr/bin/env sh

SCRIPT_PATH=$(realpath "$0")
SCRIPT_DIR_PATH=$(dirname "${SCRIPT_PATH}")
HOOKS_DIR_PATH=$(dirname "${SCRIPT_DIR_PATH}")
SRC_DIR_PATH=$(dirname "${HOOKS_DIR_PATH}")
LIB_DIR_PATH="${SRC_DIR_PATH}/lib"

. "${LIB_DIR_PATH}/logging.sh"

setup_ncu() {
  if command -v ncu >/dev/null 2>&1; then
    log_info_hook "pre" "ncu" "ncu is found at $(which ncu). Installation skipped."
  else
    npm install -g npm-check-updates
  fi
}

setup_pnpm() {
  if command -v pnpm >/dev/null 2>&1; then
    log_info_hook "pre" "ncu" "pnpm is found at $(which pnpm). Installation skipped."
  else
    npm install -g pnpm
  fi
}

main() {
  log_info_hook "pre" "ncu" "Started"
  setup_ncu
  setup_pnpm
  log_info_hook "pre" "ncu" "Completed"
}

main "$@"
