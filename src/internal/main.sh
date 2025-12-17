#!/usr/bin/env sh

SCRIPT_PATH=$(realpath "$0")
INTERNAL_DIR_PATH=$(dirname "${SCRIPT_PATH}")
SRC_DIR_PATH=$(dirname "${INTERNAL_DIR_PATH}")
HOOKS_DIR_PATH="${SRC_DIR_PATH}/hooks"
LIB_DIR_PATH="${SRC_DIR_PATH}/lib"

. "${LIB_DIR_PATH}/logging.sh"

main() {
  log_info "[main] Running automation started."
  for dir in "${HOOKS_DIR_PATH}"/*; do
    if [ -d "${dir}" ] && [ -f "${dir}/main.sh" ]; then
      "${dir}"/main.sh
    fi
  done
  log_info "[main] Running automation completed."
}

main "$@"
