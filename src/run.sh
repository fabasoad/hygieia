#!/usr/bin/env sh
set +e

SCRIPT_PATH=$(realpath "$0")
SRC_DIR_PATH=$(dirname "${SCRIPT_PATH}")
INTERNAL_DIR_PATH="${SRC_DIR_PATH}/internal"

main() {
  "${INTERNAL_DIR_PATH}"/pre.sh "$@"
  pre_exit_code=$?
  if [ ${pre_exit_code} -eq 0 ]; then
    "${INTERNAL_DIR_PATH}"/main.sh "$@"
    "${INTERNAL_DIR_PATH}"/post.sh "$@"
  fi
}

main "$@"
