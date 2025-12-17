#!/usr/bin/env sh
set -e

SCRIPT_PATH=$(realpath "$0")
INTERNAL_DIR_PATH=$(dirname "${SCRIPT_PATH}")
SRC_DIR_PATH=$(dirname "${INTERNAL_DIR_PATH}")
LIB_DIR_PATH="${SRC_DIR_PATH}/lib"

. "${LIB_DIR_PATH}/logging.sh"

validate_repo() {
  json=$(gh repo view --json "isArchived,isFork")

  log_info "[pre] Checking whether current repo is a fork or not"
  if [ "$(echo "${json}" | jq -r '.isFork')" = "true" ]; then
    log_info "[pre] Current repo is a fork. Skipping."
    exit 1
  else
    log_info "[pre] Current repo is not a fork. Continuing."
  fi

  log_info "[pre] Checking whether current repo is archived or not"
  if [ "$(echo "${json}" | jq -r '.isArchived')" = "true" ]; then
    log_info "[pre] Current repo is archived. Skipping."
    exit 1
  else
    log_info "[pre] Current repo is not archived. Continuing."
  fi
}

setup_git_config() {
  log_info "[pre] Setting up git config started"
  git config user.email "fabasoad@gmail.com"
  git config user.name "fabasoad"
  git config url."https://${GH_TOKEN}@github.com/".insteadOf "https://github.com/"
  log_info "[pre] Setting up git config completed"
}

main() {
  validate_repo
  setup_git_config
}

main "$@"
