#!/usr/bin/env sh

SCRIPT_PATH=$(realpath "$0")
SCRIPT_DIR_PATH=$(dirname "${SCRIPT_PATH}")
HOOKS_DIR_PATH=$(dirname "${SCRIPT_DIR_PATH}")
SRC_DIR_PATH=$(dirname "${HOOKS_DIR_PATH}")
LIB_DIR_PATH="${SRC_DIR_PATH}/lib"

. "${LIB_DIR_PATH}/logging.sh"

main() {
  log_info_hook "main" "asdf" "Started"
  if [ -f ".tool-versions" ]; then
    cut -d' ' -f1 .tool-versions | while read -r tool; do
      log_debug_hook "main" "asdf" "Running command: asdf plugin update ${tool}"
      asdf plugin update "${tool}"
      log_debug_hook "main" "asdf" "Running command: asdf set ${tool} latest"
      asdf set "${tool}" latest
    done
    git add .tool-versions
  else
    log_info_hook "main" "asdf" ".tool-versions file is not found"
  fi
  log_info_hook "main" "asdf" "Completed"
}

main "$@"
