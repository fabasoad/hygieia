#!/usr/bin/env sh

# Printing log to the console.
# Parameters:
# 1. (Required) Log level. Options: debug, info, warning, error.
# 2. (Required) Message.
log() {
  header="hygieia"
  printf "[%s] [%s] %s %s\n" "${1}" "${header}" "$(date +'%Y-%m-%d %T')" "${2}" 1>&2
}

log_debug() {
  log "debug" "${1}"
}

log_info() {
  log "info" "${1}"
}

log_warn() {
  log "warn" "${1}"
}

log_error() {
  log "error" "${1}"
}

log_debug_hook() {
  log_debug "[${1}::${2}] ${3}"
}

log_info_hook() {
  log_info "[${1}::${2}] ${3}"
}

log_warn_hook() {
  log_warn "[${1}::${2}] ${3}"
}

log_error_hook() {
  log_error "[${1}::${2}] ${3}"
}
