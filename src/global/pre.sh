#!/usr/bin/env sh

SCRIPT_PATH=$(realpath "$0")
GLOBAL_DIR_PATH=$(dirname "${SCRIPT_PATH}")
SRC_DIR_PATH=$(dirname "${GLOBAL_DIR_PATH}")
HOOKS_DIR_PATH="${SRC_DIR_PATH}/hooks"
LIB_DIR_PATH="${SRC_DIR_PATH}/lib"

. "${LIB_DIR_PATH}/logging.sh"

setup_environment() {
  log_info "[pre] Setting up environment started"
  bin_dir_path="${RUNNER_TEMP}/bin"
  mkdir -p "${bin_dir_path}"
  echo "BIN_DIR_PATH=${bin_dir_path}" >> "${GITHUB_ENV}"
  echo "${bin_dir_path}" >> "${GITHUB_PATH}"

  cache_dir_path="${RUNNER_TEMP}/.cache"
  mkdir -p "${cache_dir_path}"
  echo "CACHE_DIR_PATH=${cache_dir_path}" >> "${GITHUB_ENV}"

  changed_repos_file_path="${cache_dir_path}/changed_repos.txt"
  touch "${changed_repos_file_path}"
  echo "CHANGED_REPOS_FILE_PATH=${changed_repos_file_path}" >> "${GITHUB_ENV}"
  log_info "[pre] Setting up environment completed"
}

running_hooks() {
  log_info "[pre] Running hooks started"
  for dir in "${HOOKS_DIR_PATH}"/*; do
    if [ -d "${dir}" ] && [ -f "${dir}/pre.sh" ]; then
      "${dir}"/pre.sh
    fi
  done
  log_info "[pre] Running hooks completed"
}

main() {
  setup_environment
  running_hooks
}

main "$@"
