alias reload!='. ~/.zshrc'

alias cls='clear' # Good 'ol Clear Screen command

# List all aliases in a sorted manner
aliases() {
  if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    echo "Usage: aliases [-h|--help]"
    echo "Display all currently available aliases."
  fi
  alias | sort
}

# Help / docs
alias man='tldr'

# File viewing
alias cat='bat --paging=never --style=plain'
alias less='bat'

# Listing
alias ls='eza --group-directories-first'
alias ll='eza -lah --group-directories-first'
alias la='eza -a'
alias tree='eza --tree'

# Disk usage
alias du='duf'
alias df='duf'

# Process viewing
alias ps='procs'
alias top='bpytop'
alias htop='bpytop'

# Networking
alias myip='ipconfig getifaddr en0 || ipconfig getifaddr en1'
alias publicip='curl -s https://ifconfig.me'
alias pingg='ping -c4 google.com'
alias ports='lsof -nP -iTCP -sTCP:LISTEN'
alias myipall='ifconfig | grep "inet "'
alias gateway='route -n get default | grep gateway'
alias dnsservers='scutil --dns | grep "nameserver\\[[0-9]*\\]"'
alias arpall='arp -a'
alias netlisten='netstat -anv | grep LISTEN'
alias netest='netstat -anv | grep ESTABLISHED'
alias tracer='traceroute'
alias ns='nslookup'
# alias ping='gping' # Output ping in graph
ping() { command ping -c4 "$@"; }   # Default to 4 pings instead of infinite
alias speedtest='speedtest-cli'
alias dig='doge'

# Grep (keep flags compatible)
alias grep='grep --color=auto'

# Diff
alias diff='diff-so-fancy'

# Editor
alias nano='micro'

# Smarter cd
alias z='zoxide'

# Quick jumps
alias .='cd ..'
alias ..='cd ../..'
alias ...='cd ../../..'
alias ....='cd ../../../..'

# Misc
alias wget='aria2c'
alias brewupdate='command brew update && command brew upgrade && command brew cleanup'
