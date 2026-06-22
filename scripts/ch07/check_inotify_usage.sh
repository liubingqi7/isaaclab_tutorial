#!/usr/bin/env bash
set -euo pipefail

printf '== inotify limits ==\n'
printf 'max_user_watches: '
cat /proc/sys/fs/inotify/max_user_watches
printf 'max_user_instances: '
cat /proc/sys/fs/inotify/max_user_instances
printf 'max_queued_events: '
cat /proc/sys/fs/inotify/max_queued_events

printf '\n== current watch descriptors ==\n'
python3 - <<'PY'
import glob
import os

rows = []
total = 0

for proc in glob.glob("/proc/[0-9]*"):
    pid = os.path.basename(proc)
    watches = 0
    fds = 0

    for fdinfo in glob.glob(os.path.join(proc, "fdinfo", "*")):
        try:
            with open(fdinfo, "r", errors="ignore") as f:
                data = f.read()
        except OSError:
            continue

        count = sum(1 for line in data.splitlines() if line.startswith("inotify "))
        if count:
            watches += count
            fds += 1

    if not watches:
        continue

    total += watches
    try:
        with open(os.path.join(proc, "cmdline"), "rb") as f:
            cmd = f.read().replace(b"\0", b" ").decode(errors="ignore")[:120]
    except OSError:
        cmd = ""
    rows.append((watches, fds, pid, cmd))

print(f"total: {total}")
print("top users:")
for watches, fds, pid, cmd in sorted(rows, reverse=True)[:12]:
    print(f"{watches:8d} watches  {fds:3d} fds  pid={pid}  {cmd}")
PY
