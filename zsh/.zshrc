DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"
ZSH_THEME="dst"

export LANGUAGE='en_US.UTF-8 git'

LOCALRC="~/.localrc"
test -f $LOCALRC && source $LOCALRC

export ZSH="$HOME/.oh-my-zsh"
export EDITOR="nvim"

plugins=(git docker docker-compose)

source $ZSH/oh-my-zsh.sh
source ~/.aliases
source ~/.scripts/git

bindkey -s ^f '~/.scripts/tmux-sessionizer\n'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -x "$(command -v zoxide)" ] && eval "$(zoxide init zsh)"
[ -x "$(command -v bat)" ] && alias cat="bat"


# Yandex Cloud CLI
# The next line updates PATH for Yandex Cloud CLI.
#if [ -f '/Users/user/yandex-cloud/path.bash.inc' ]; then source '/Users/user/yandex-cloud/path.bash.inc'; fi

# The next line enables shell command completion for yc.
#if [ -f '/Users/user/yandex-cloud/completion.zsh.inc' ]; then source '/Users/user/yandex-cloud/completion.zsh.inc'; fi

# PATH
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export PATH=$PATH:$(go env GOPATH)/bin
export PATH="/Applications/IntelliJ IDEA CE.app/Contents/MacOS:$PATH"
export PATH="/usr/local/opt/libpq/bin:$PATH"
export PATH="/usr/local/opt/openvpn/sbin/openvpn:$PATH"

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/user/.docker/completions $fpath)
autoload -Uz compinit
if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
    compinit
else
    compinit -C
fi
# End of Docker CLI completions

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
#export SDKMAN_DIR="$HOME/.sdkman"
#[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
