#!/usr/bin/env fish

set selected $argv[1]

if test -z "$selected"
    set selected (find ~/Projects ~/ -mindepth 1 -maxdepth 3 -type d | fzf)
end

if test -z "$selected"
    exit 0
end

set herdr_bin $HERDR_BIN_PATH
if test -z "$herdr_bin"
    set herdr_bin herdr
end

set selected_name (basename "$selected")

set existing_id ($herdr_bin workspace list \
    | jq -r --arg name "$selected_name" \
        '.result.workspaces[] | select(.label == $name) | .workspace_id' \
    | head -n 1)

if test -n "$existing_id"
    $herdr_bin workspace focus $existing_id
else
    $herdr_bin workspace create --cwd "$selected" --label "$selected_name" --focus
end
