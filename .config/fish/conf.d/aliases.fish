alias cat='bat --paging=always --style=plain --color=always'
alias l='ls -la'

alias v='nvim'

alias claude="/Users/user/.claude/local/claude"

alias gemini-flash='GOOGLE_CLOUD_PROJECT="metro-markets-gemini-cli" GOOGLE_CLOUD_LOCATION="europe-west1" GEMINI_MODEL="gemini-2.5-flash" gemini'
alias gemini-pro='GOOGLE_CLOUD_PROJECT="metro-markets-gemini-cli" GOOGLE_CLOUD_LOCATION="europe-west1" GEMINI_MODEL="gemini-2.5-pro" gemini'

alias dbl='docker build'
alias dcin='docker container inspect'
alias dcls='docker container ls'
alias dclsa='docker container ls -a'
alias dib='docker image build'
alias dii='docker image inspect'
alias dils='docker image ls'
alias dipu='docker image push'
alias dipru='docker image prune -a'
alias dirm='docker image rm'
alias dit='docker image tag'
alias dlo='docker container logs'
alias dnc='docker network create'
alias dncn='docker network connect'
alias dndcn='docker network disconnect'
alias dni='docker network inspect'
alias dnls='docker network ls'
alias dnrm='docker network rm'
alias dpo='docker container port'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dpu='docker pull'
alias dr='docker container run'
alias drit='docker container run -it'
alias drm='docker container rm'
alias drm!='docker container rm -f'
alias dst='docker container start'
alias drs='docker container restart'
alias dsta='docker stop $(docker ps -q)'
alias dstp='docker container stop'
alias dsts='docker stats'
alias dtop='docker top'
alias dvi='docker volume inspect'
alias dvls='docker volume ls'
alias dvprune='docker volume prune'
alias dxc='docker container exec'
alias dxcit='docker container exec -it'

alias dco='docker compose'
alias dcb='docker compose build'
alias dce='docker compose exec'
alias dcps='docker compose ps'
alias dcrestart='docker compose restart'
alias dcrm='docker compose rm'
alias dcr='docker compose run'
alias dcstop='docker compose stop'
alias dcup='docker compose up'
alias dcupb='docker compose up --build'
alias dcupd='docker compose up -d'
alias dcupdb='docker compose up -d --build'
alias dcdn='docker compose down'
alias dcl='docker compose logs'
alias dclf='docker compose logs -f'
alias dclF='docker compose logs -f --tail 0'
alias dcpull='docker compose pull'
alias dcstart='docker compose start'
alias dck='docker compose kill'

alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'
alias gau='git add --update'
alias gav='git add --verbose'
alias gap='git apply'
alias gapt='git apply --3way'
alias gbl='git blame -w'
alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch --delete'
alias gbD='git branch --delete --force'

alias gcam='git commit --all --message'
alias gc='git commit --verbose'
alias gca='git commit --verbose --all'
alias gcn='git commit --verbose --no-edit'
alias gcane='git commit --amend --no-edit'
alias gcf='git config --list'
alias gcfu='git commit --fixup'
alias gco='git checkout'
alias gd='git diff'
alias gst='git status'

alias glo='git log --oneline --decorate'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'

alias glola="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all"
alias glols="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat"
alias glol="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"

alias ggpush='git push origin (git rev-parse --abbrev-ref HEAD)'
alias ggpull='git pull origin (git rev-parse --abbrev-ref HEAD)'

function git_main_branch
    command git rev-parse --git-dir &>/dev/null; or return
    for ref in refs/heads/{main,trunk,mainline,default,stable,master} refs/remotes/{origin,upstream}/{main,trunk,mainline,default,stable,master}
        if command git show-ref -q --verify $ref
            echo (basename $ref)
            return 0
        end
    end

    echo master
    return 1
end

function gcm
    git checkout (git_main_branch)
end

function gcof
    set branch (git branch --all | sed 's/^[* ] //' | fzf)
    if test -n "$branch"
        git checkout (string replace -r 'remotes/origin/' '' $branch)
    end
end
  

function gri
    set commit (git log --oneline | fzf | awk '{print $1}')
    if test -n "$commit"
        set parent (git rev-parse $commit^ 2>/dev/null)
        if test $status -eq 0
            git rebase -i $parent
        else
            echo "Selected commit has no parent, cannot rebase interactively."
        end
    end
end

# Run claude code and rename tmux window
function claude 
    tmux rename-window "claude"
    command claude $argv
    tmux rename-window (basename $SHELL)
end
