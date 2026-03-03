#!/usr/bin/env bash

set -euo pipefail

# ANSI Color Codes
GREEN='\033[32m'
RED='\033[31m'
NC='\033[0m' # No Color

DIST_DIR="dist"

log_error() {
    local msg="$1"
    local headers="$2"
    local body="$3"
    echo -e "${RED}${msg}${NC}"
    [[ -f "$headers" ]] && echo -e "${RED}Headers:$(cat "$headers")${NC}"
    echo -e "${RED}Body: ${body}${NC}"
    exit 1
}

upload_file() {
    local file_name="$1"
    local tmp_headers
    tmp_headers=$(mktemp)

    if [ -f "$file_name" ]; then
        echo -e "${GREEN}Processing file: $file_name${NC}"
        pkg_file_name="${file_name#"${DIST_DIR}/"}"

        # Get signed URL for uploading artifact file
        signed_url_response=$(curl -X POST -G "$URL" \
            -sS --retry 5 \
            -D "$tmp_headers" \
            --data-urlencode "filename=$pkg_file_name" \
            -H "Authorization: Bearer $AUTH" \
            -H "Content-Type: application/json")

        # Validate JSON and extract URL
        if ! signed_url=$(echo "$signed_url_response" | jq -e -r '.url' 2>/dev/null) || [[ "$signed_url" == "null" ]]; then
            log_error "Failed to get valid signed URL" "$tmp_headers" "$signed_url_response"
        fi

        # Set content-type based on file extension
        local extension="${file_name##*.}"
        local content_type
        case "$extension" in
            gem)  content_type="application/octet-stream" ;;
            gz)   content_type="application/gzip" ;;
            rz)   content_type="application/octet-stream" ;;
            html) content_type="text/html" ;;
            *)    content_type="application/octet-stream" ;;
        esac

        # Upload file
        upload_response=$(curl -v -X PUT \
            --retry 5 \
            --retry-all-errors \
            -D "$tmp_headers" \
            -H "Content-Type: $content_type" \
            --data-binary "@${file_name}" "$signed_url" 2>&1)

        if ! echo "$upload_response" | grep -q "HTTP/[0-9.]* 200"; then
            log_error "Failed to upload artifact file" "$tmp_headers" "$upload_response"
        fi

        # Insert small throttle to reduce rate limiting risk
        sleep 0.1
    fi
}

walk_tree() {
    local current_dir="$1"

    for entry in "$current_dir"/*; do
        # Check that entry is valid
        [ -e "$entry" ] || [ -h "$entry" ] || continue

        if [ -d "$entry" ]; then
            walk_tree "$entry"
        else
            upload_file "$entry"
        fi
    done
}

cd "$(dirname "$0")/../.."

echo "::group::Building gem"
VERSION_FILE="lib/${PACKAGE_NAME}/version.rb"
if [[ ! -f "$VERSION_FILE" ]]; then
    echo -e "${RED}Version file not found: ${VERSION_FILE}${NC}"
    exit 1
fi
SHORT_SHA="${SHA:0:7}"
sed -i.bak -E "s/(VERSION = \"[^\"]+)\"/\1.beta.${SHORT_SHA}\"/" "$VERSION_FILE"
rm -f "${VERSION_FILE}.bak"

gem build
mkdir -p "${DIST_DIR}/gems"
mv ./*.gem "${DIST_DIR}/gems/"
echo "::endgroup::"

echo "::group::Generating gem index"
gem generate_index --directory "$DIST_DIR"
echo "::endgroup::"

echo "::group::Uploading to pkg.stainless.com"
walk_tree "$DIST_DIR"
echo "::endgroup::"

echo -e "${GREEN}Gem artifacts uploaded to Stainless storage.${NC}"
echo -e "\033[32mInstallation: bundle remove openai && bundle add openai --source 'https://pkg.stainless.com/s/openai-ruby/$SHA'\033[0m"
