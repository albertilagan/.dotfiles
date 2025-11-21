#!/usr/bin/env bash
#
# Usage:
#   ./download_repo_zip.sh <app_id> <installation_id> <private_key.pem> <owner> <repo> [ref]
#
# Example:
#   ./download_repo_zip.sh 123456 654321 ./private-key.pem my-org my-repo main
#
# Requirements:
#   - openssl
#   - jq
#   - curl
#

set -euo pipefail

APP_ID="$1"
INSTALLATION_ID="$2"
PRIVATE_KEY_FILE="$3"
OWNER="$4"
REPO="$5"
REF="${6:-main}" # default branch if not provided

now=$(date +%s)
iat=$((now - 60))
exp=$((now + 600))

# JWT header and payload
header='{"alg":"RS256","typ":"JWT"}'
payload=$(jq -nc --arg iat "$iat" --arg exp "$exp" --arg iss "$APP_ID" \
    '{iat: ($iat|tonumber), exp: ($exp|tonumber), iss: ($iss|tonumber)}')

# base64-url encode function
b64url() {
    openssl base64 -A | tr '+/' '-_' | tr -d '='
}

# create JWT
header_b64=$(printf '%s' "$header" | b64url)
payload_b64=$(printf '%s' "$payload" | b64url)
signature=$(printf '%s.%s' "$header_b64" "$payload_b64" |
    openssl dgst -sha256 -sign "$PRIVATE_KEY_FILE" | b64url)
jwt="${header_b64}.${payload_b64}.${signature}"

echo "[*] Generated JWT."

# Get installation access token
INSTALL_TOKEN=$(
    curl -s -X POST \
        -H "Authorization: Bearer $jwt" \
        -H "Accept: application/vnd.github+json" \
        "https://api.github.com/app/installations/${INSTALLATION_ID}/access_tokens" |
        jq -r .token
)

if [[ "$INSTALL_TOKEN" == "null" ]]; then
    echo "[-] Failed to get installation token" >&2
    exit 1
fi

echo "[*] Got installation token."

# Download ZIP archive
OUTFILE="${REPO}-${REF}.zip"
curl -L \
    -H "Authorization: Bearer $INSTALL_TOKEN" \
    -H "Accept: application/vnd.github+json" \
    "https://api.github.com/repos/${OWNER}/${REPO}/zipball/${REF}" \
    -o "$OUTFILE"

echo "[+] Repo downloaded as $OUTFILE"
