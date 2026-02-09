if [[ ! -o interactive ]]; then
  return
fi

if command -v brew >/dev/null 2>&1; then
  autosuggestions_path="$(command brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  if [[ -f "$autosuggestions_path" ]]; then
    source "$autosuggestions_path"
  fi
fi
