# Shortcuts
alias copyssh="pbcopy < $HOME/.ssh/id_ed25519.pub"
alias reloadshell="omz reload"
alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias ll="/opt/homebrew/opt/coreutils/libexec/gnubin/ls -AhlFo --color --group-directories-first"
alias phpstorm='open -a /Applications/PhpStorm.app "`pwd`"'
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias compile="commit 'compile'"
alias timestamp="date +%s"
alias version="commit 'version'"

# Directories
alias dotfiles="cd $DOTFILES"
alias library="cd $HOME/Library"
alias projects="cd $HOME/Documents/Projects"

# Docker - Fixed and enhanced
alias d='docker'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dr='docker run'
alias dexec='docker exec -it'
alias dstop='docker stop'
alias drm='docker rm'
alias dprune='docker system prune -f'
alias dlogs='docker logs'
alias dnetwork='docker network ls'
alias dvolume='docker volume ls'

# Docker Compose
alias dc='docker-compose'
alias dcu='docker-compose up -d'
alias dcd='docker-compose down'
alias dcs='docker-compose ps'
alias dcp='docker-compose pull'
alias dcl='docker-compose logs -f'

# Git
alias gs="git status"
alias gb="git branch"
alias gc="git checkout"
alias gl="git log --oneline --decorate --color"
alias amend="git add . && git commit --amend --no-edit"
alias commit="git add . && git commit -m"
alias diff="git diff"
alias force="git push --force-with-lease"
alias nuke="git clean -df && git reset --hard"
alias pop="git stash pop"
alias prune="git fetch --prune"
alias pull="git pull"
alias push="git push"
alias resolve="git add . && git commit --no-edit"
alias stash="git stash -u"
alias unstage="git restore --staged ."
alias wip="commit 'wip'"

# Network
alias testping="ping -c 5 8.8.8.8"
alias ip_add="ipconfig getifaddr en0"
alias whatmyip="curl -s ifconfig.me/ip"
alias flushdns="dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias ports="lsof -i -P | grep LISTEN"
alias gitclone="cd $HOME/Documents/Projects && git clone"