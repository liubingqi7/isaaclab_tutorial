#!/usr/bin/env bash
set -euo pipefail

WATCHES="${WATCHES:-1048576}"
INSTANCES="${INSTANCES:-1024}"
QUEUED_EVENTS="${QUEUED_EVENTS:-32768}"
CONF="/etc/sysctl.d/99-isaaclab-inotify.conf"

print_commands() {
  printf 'sudo tee %s >/dev/null <<EOF\n' "${CONF}"
  printf 'fs.inotify.max_user_watches=%s\n' "${WATCHES}"
  printf 'fs.inotify.max_user_instances=%s\n' "${INSTANCES}"
  printf 'fs.inotify.max_queued_events=%s\n' "${QUEUED_EVENTS}"
  printf 'EOF\n'
  printf 'sudo sysctl --system\n'
}

case "${1:-}" in
  --print-only)
    print_commands
    exit 0
    ;;
  -h|--help)
    printf 'Usage: %s [--print-only]\n' "$0"
    printf 'Environment overrides: WATCHES, INSTANCES, QUEUED_EVENTS\n'
    exit 0
    ;;
  "")
    ;;
  *)
    printf 'unknown argument: %s\n' "$1" >&2
    exit 2
    ;;
esac

tmp="$(mktemp)"
trap 'rm -f "${tmp}"' EXIT

{
  printf 'fs.inotify.max_user_watches=%s\n' "${WATCHES}"
  printf 'fs.inotify.max_user_instances=%s\n' "${INSTANCES}"
  printf 'fs.inotify.max_queued_events=%s\n' "${QUEUED_EVENTS}"
} > "${tmp}"

sudo install -m 0644 "${tmp}" "${CONF}"
sudo sysctl --system

printf '\nUpdated inotify limits:\n'
printf 'max_user_watches: '
cat /proc/sys/fs/inotify/max_user_watches
printf 'max_user_instances: '
cat /proc/sys/fs/inotify/max_user_instances
printf 'max_queued_events: '
cat /proc/sys/fs/inotify/max_queued_events
