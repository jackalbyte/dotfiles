#!/bin/sh
# Set every tab label to "N:name", where N is the tab position in its workspace.
# Tab list order is the display order. The "number" field is the tab id suffix,
# not the position, so it is not used.
# Labels that are only digits (herdr default names) become just "N".
#
# Our own renames fire tab.renamed, so many runs can start at once. Only one
# run works at a time: others set a rerun flag and exit, and the running one
# loops until the flag is gone.
set -eu

herdr="${HERDR_BIN_PATH:-herdr}"
state="${HERDR_PLUGIN_STATE_DIR:-${TMPDIR:-/tmp}/herdr-tab-index}"
lock="$state/lock"
rerun="$state/rerun"
tab="$(printf '\t')"

renames() {
  "$herdr" tab list | jq -r '
    reduce .result.tabs[] as $tab ({}; .[$tab.workspace_id] += [$tab])
    | .[]
    | to_entries[]
    | (.key + 1) as $n
    | .value
    | (.label | sub("^[0-9]+:"; "")) as $name
    | (if ($name | test("^[0-9]*$")) then "\($n)" else "\($n):\($name)" end) as $want
    | select(.label != $want)
    | [.tab_id, $want]
    | @tsv
  '
}

# Renames run in parallel: the server handles concurrent requests.
renumber() {
  renames | {
    while IFS="$tab" read -r tab_id label; do
      "$herdr" tab rename "$tab_id" "$label" >/dev/null &
    done
    wait
  }
}

mkdir -p "$state"
touch "$rerun"
mkdir "$lock" 2>/dev/null || exit 0
trap 'rmdir "$lock" 2>/dev/null || true' EXIT

while [ -e "$rerun" ]; do
  rm -f "$rerun"
  renumber
done

# A run may set the flag after the last check but before the lock is released.
rmdir "$lock"
if [ -e "$rerun" ]; then
  exec /bin/sh "$0"
fi
