if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting

zoxide init fish | source

# uv
fish_add_path "$HOME/.local/bin"


# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

set -gx GOOGLE_CLOUD_LOCATION "europe-west1"
set -gx GOOGLE_CLOUD_PROJECT "metro-markets-gemini-cli"

set -gx EDITOR "nvim"
