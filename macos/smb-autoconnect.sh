#!/bin/zsh

set -euo pipefail

CONFIG_FILE="$HOME/.smb-autoconnect.conf"
KEYCHAIN_SERVICE="dotfiles-smb-autoconnect-crypto"

if [[ -f "$CONFIG_FILE" ]]; then
  # shellcheck disable=SC1090
  source "$CONFIG_FILE"
fi

if [[ -f "$HOME/.localrc" ]]; then
  # shellcheck disable=SC1090
  source "$HOME/.localrc"
fi

SERVER="${SMB_SERVER:-}"
USERNAME="${SMB_USER:-}"
PASSWORD_ENC="${SMB_PASSWORD_ENC:-}"
SHARE="${SMB_SHARE:-}"

if [[ -z "$SERVER" || -z "$USERNAME" || -z "$PASSWORD_ENC" || -z "$SHARE" ]]; then
  echo "smb-autoconnect: missing SMB_SERVER/SMB_USER/SMB_PASSWORD_ENC/SMB_SHARE in $CONFIG_FILE"
  exit 1
fi

if ! command -v openssl >/dev/null 2>&1 || ! command -v security >/dev/null 2>&1; then
  echo "smb-autoconnect: openssl and security are required."
  exit 1
fi

KEY_VALUE="$(security find-generic-password -a "$USER" -s "$KEYCHAIN_SERVICE" -w 2>/dev/null || true)"
if [[ -z "$KEY_VALUE" ]]; then
  echo "smb-autoconnect: keychain entry '$KEYCHAIN_SERVICE' was not found."
  exit 1
fi

PASSWORD="$(print -rn -- "$PASSWORD_ENC" | OPENSSL_PW="$KEY_VALUE" openssl enc -aes-256-cbc -pbkdf2 -a -A -d -pass env:OPENSSL_PW 2>/dev/null || true)"
if [[ -z "$PASSWORD" ]]; then
  echo "smb-autoconnect: failed to decrypt SMB password. Re-run 'dot --configure-smb'."
  exit 1
fi

url_encode() {
  local input="$1"
  local output=""
  local char hex
  local i

  for ((i = 1; i <= ${#input}; i++)); do
    char="${input[i]}"
    case "$char" in
      [a-zA-Z0-9.~_-])
        output+="$char"
        ;;
      *)
        printf -v hex '%%%02X' "'$char"
        output+="$hex"
        ;;
    esac
  done

  print -r -- "$output"
}

ENCODED_USER="$(url_encode "$USERNAME")"
ENCODED_PASS="$(url_encode "$PASSWORD")"
ENCODED_SHARE="$(url_encode "$SHARE")"
SMB_URL="smb://${ENCODED_USER}:${ENCODED_PASS}@${SERVER}/${ENCODED_SHARE}"
MOUNT_POINT="/Volumes/${SHARE}"

if mount | grep -F " on $MOUNT_POINT " >/dev/null 2>&1; then
  exit 0
fi

if ! ping -c 1 "$SERVER" >/dev/null 2>&1; then
  echo "smb-autoconnect: cannot reach server at $SERVER"
  exit 1
fi

echo "smb-autoconnect: connecting to smb://${USERNAME}@${SERVER}/${SHARE}..."
open "$SMB_URL"

sleep 3
if mount | grep -F " on $MOUNT_POINT " >/dev/null 2>&1; then
  echo "smb-autoconnect: mounted ${SHARE} at ${MOUNT_POINT}"
  exit 0
fi

echo "smb-autoconnect: could not verify mount at $MOUNT_POINT"
exit 1
