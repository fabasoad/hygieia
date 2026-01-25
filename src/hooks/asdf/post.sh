#!/usr/bin/env sh

SCRIPT_PATH=$(realpath "$0")
SCRIPT_DIR_PATH=$(dirname "${SCRIPT_PATH}")
HOOKS_DIR_PATH=$(dirname "${SCRIPT_DIR_PATH}")
SRC_DIR_PATH=$(dirname "${HOOKS_DIR_PATH}")
LIB_DIR_PATH="${SRC_DIR_PATH}/lib"

. "${LIB_DIR_PATH}/logging.sh"

main() {
  log_info_hook "post" "asdf" "Started"
  if command -v asdf >/dev/null 2>&1; then
    location="$(which asdf)"
    if [ "${location}" = "/opt/homebrew/bin/asdf" ]; then
      brew uninstall asdf
    elif [ "${location}" = "/usr/bin/asdf" ]; then
      zypper remove asdf
    elif [ "${location}" = "$(go env GOPATH)/bin/asdf" ]; then
      rm -f "$(go env GOPATH)/bin/asdf"
    else
      log_warn_hook "post" "asdf" "cannot be uninstalled"
    fi
  fi
  log_info_hook "post" "asdf" "Completed"
}

main "$@"
