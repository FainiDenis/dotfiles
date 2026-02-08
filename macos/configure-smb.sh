#!/bin/zsh

set -euo pipefail

CONFIG_FILE="$HOME/.smb-autoconnect.conf"
FORCE_PROMPT=0
KEYCHAIN_SERVICE="dotfiles-smb-autoconnect-crypto"

if [[ "${1:-}" == "--force" ]]; then
  FORCE_PROMPT=1
fi

if [[ -f "$CONFIG_FILE" ]]; then
  # shellcheck disable=SC1090
  source "$CONFIG_FILE"
fi

if [[ "$FORCE_PROMPT" -ne 1 ]] && [[ -n "${SMB_SERVER:-}" && -n "${SMB_SHARE:-}" && -n "${SMB_USER:-}" && -n "${SMB_PASSWORD_ENC:-}" ]]; then
  exit 0
fi

if [[ ! -t 0 ]]; then
  echo "  SMB auto-connect is not configured and no TTY is available; skipping prompt."
  exit 0
fi

echo "  Configure SMB auto-connect"
read -r "SERVER_INPUT?  Enter SMB server address (example: 192.168.1.123): "
read -r "USERNAME_INPUT?  Enter SMB username: "
echo -n "  Enter SMB password: "
read -rs PASSWORD_INPUT
echo
read -r "SHARE_INPUT?  Enter shared folder name (example: media): "

if [[ -z "$SERVER_INPUT" || -z "$USERNAME_INPUT" || -z "$PASSWORD_INPUT" || -z "$SHARE_INPUT" ]]; then
  echo "  Error: all SMB fields are required."
  exit 1
fi

if ! command -v openssl >/dev/null 2>&1 || ! command -v security >/dev/null 2>&1; then
  echo "  Error: openssl and security are required for encrypted SMB password storage."
  exit 1
fi

KEY_VALUE="$(security find-generic-password -a "$USER" -s "$KEYCHAIN_SERVICE" -w 2>/dev/null || true)"
if [[ -z "$KEY_VALUE" ]]; then
  # Avoid pipefail issues from short-read pipelines under strict mode.
  KEY_VALUE="$(openssl rand -hex 32)"
  security add-generic-password -a "$USER" -s "$KEYCHAIN_SERVICE" -w "$KEY_VALUE" -U >/dev/null
fi

PASSWORD_ENC="$(print -rn -- "$PASSWORD_INPUT" | OPENSSL_PW="$KEY_VALUE" openssl enc -aes-256-cbc -pbkdf2 -a -A -salt -pass env:OPENSSL_PW)"

{
  printf "SMB_SERVER=%q\n" "$SERVER_INPUT"
  printf "SMB_USER=%q\n" "$USERNAME_INPUT"
  printf "SMB_PASSWORD_ENC=%q\n" "$PASSWORD_ENC"
  printf "SMB_SHARE=%q\n" "$SHARE_INPUT"
} > "$CONFIG_FILE"

chmod 600 "$CONFIG_FILE"
echo "  SMB credentials saved to $CONFIG_FILE"
