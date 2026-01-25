#!/usr/bin/env sh

SCRIPT_PATH=$(realpath "$0")
SCRIPT_DIR_PATH=$(dirname "${SCRIPT_PATH}")
HOOKS_DIR_PATH=$(dirname "${SCRIPT_DIR_PATH}")
SRC_DIR_PATH=$(dirname "${HOOKS_DIR_PATH}")
LIB_DIR_PATH="${SRC_DIR_PATH}/lib"

. "${LIB_DIR_PATH}/logging.sh"

main() {
  log_info_hook "pre" "asdf" "Started"
  if command -v asdf >/dev/null 2>&1; then
    log_info_hook "pre" "asdf" "asdf is found at $(which asdf). Installation skipped."
  else
    if command -v brew >/dev/null 2>&1; then
      brew install asdf
    elif command -v zypper >/dev/null 2>&1; then
      zypper install asdf
    elif command -v go >/dev/null 2>&1; then
      sudo apt install -y git bash
      go install github.com/asdf-vm/asdf/cmd/asdf@latest
    else
      log_warn_hook "pre" "asdf" "cannot be installed"
    fi
  fi
  log_info_hook "pre" "asdf" "Completed"
}

main "$@"
