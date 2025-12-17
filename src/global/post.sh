#!/usr/bin/env sh

SCRIPT_PATH=$(realpath "$0")
GLOBAL_DIR_PATH=$(dirname "${SCRIPT_PATH}")
SRC_DIR_PATH=$(dirname "${GLOBAL_DIR_PATH}")
HOOKS_DIR_PATH="${SRC_DIR_PATH}/hooks"
LIB_DIR_PATH="${SRC_DIR_PATH}/lib"

. "${LIB_DIR_PATH}/logging.sh"

cleanup_environment() {
  log_info "[post] Cleaning up environment started"
  rm -rf "${BIN_DIR_PATH}"
  rm -rf "${CACHE_DIR_PATH}"
  log_info "[post] Cleaning up environment completed"
}

running_hooks() {
  log_info "[post] Running hooks started"
  for dir in "${HOOKS_DIR_PATH}"/*; do
    if [ -d "${dir}" ] && [ -f "${dir}/post.sh" ]; then
      "${dir}"/post.sh
    fi
  done
  log_info "[post] Running hooks completed"
}

main() {
  cleanup_environment
  running_hooks
}

main "$@"
