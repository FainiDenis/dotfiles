alias reload!='. ~/.zshrc'

alias cls='clear' # Good 'ol Clear Screen command
alias myip='ipconfig getifaddr en0 || ipconfig getifaddr en1'
alias publicip='curl -s https://ifconfig.me'
alias pingg='ping -c4 google.com'

ping() { command ping -c4 "$@"; }   # Default to 4 pings instead of infinite

alias dfh='df -h'
alias ports='lsof -nP -iTCP -sTCP:LISTEN'
alias brewupdate='command brew update && command brew upgrade && command brew cleanup'

alias myipall='ifconfig | grep "inet "'
alias gateway='route -n get default | grep gateway'
alias dnsservers='scutil --dns | grep "nameserver\\[[0-9]*\\]"'
alias arpall='arp -a'
alias netlisten='netstat -anv | grep LISTEN'
alias netest='netstat -anv | grep ESTABLISHED'
alias tracer='traceroute'
alias ns='nslookup'

diga() { dig +short A "$1"; }   # Get the A record for a domain

# List all aliases in a sorted manner
aliases() {
  if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    echo "Usage: aliases [-h|--help]"
    echo "Display all currently available aliases."
  fi
  alias | sort
}
