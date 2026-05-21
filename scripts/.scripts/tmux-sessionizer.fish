#!/usr/bin/env fish

set selected $argv[1]

if test -z "$selected"
    set selected (find ~/Projects ~/ -mindepth 1 -maxdepth 2 -type d | fzf)
end

if test -z "$selected"
    exit 0
end

set selected_name (basename "$selected" | string replace -a . _)
set tmux_running (pgrep tmux)

if test -z "$TMUX" && test -z "$tmux_running"
    tmux new-session -s $selected_name -c $selected
    exit 0
end

if not tmux has-session -t=$selected_name 2>/dev/null
    tmux new-session -ds $selected_name -c $selected
end

tmux switch-client -t $selected_name

