#!/usr/bin/env bash
# YM Camp 2026 - encrypt local source files and push GitHub Pages output.
# Edit HTML in ./src/ (gitignored), then run:
#   YM_CAMP_PASSWORD='your-password' ./deploy.sh "Commit message"
set -euo pipefail

cd "$(dirname "$0")"

SOURCE_DIR="${SOURCE_DIR:-src}"
COMMIT_MSG="${1:-Update encrypted site}"
PASSWORD="${YM_CAMP_PASSWORD:-}"

HTML_FILES=(
  index.html
  agenda.html
  camp.html
  pack.html
  safety.html
  logistics.html
  menu.html
  leaders.html
  swag.html
  rsvp.html
  map.html
)

if [ ! -d "$SOURCE_DIR" ]; then
  echo "Missing $SOURCE_DIR/."
  echo "This repo keeps unencrypted source local-only so GitHub Pages cannot serve it."
  echo "Restore source from the last clean commit or decrypt with the site password, then rerun."
  exit 1
fi

if [ -z "$PASSWORD" ]; then
  read -r -s -p "Staticrypt password: " PASSWORD
  echo ""
fi

if [ -z "$PASSWORD" ]; then
  echo "No password provided."
  exit 1
fi

if ! command -v staticrypt >/dev/null 2>&1; then
  echo "Installing staticrypt..."
  npm install -g staticrypt
fi

for file in "${HTML_FILES[@]}"; do
  if [ ! -f "$SOURCE_DIR/$file" ]; then
    echo "Missing source file: $SOURCE_DIR/$file"
    exit 1
  fi
  cp "$SOURCE_DIR/$file" "$file"
done

if [ ! -f "$SOURCE_DIR/assets/route_map_widget.html" ]; then
  echo "Missing source file: $SOURCE_DIR/assets/route_map_widget.html"
  exit 1
fi
mkdir -p assets
cp "$SOURCE_DIR/assets/route_map_widget.html" assets/route_map_widget.html
touch .nojekyll

echo "Encrypting top-level pages..."
staticrypt "${HTML_FILES[@]}" \
  -p "$PASSWORD" \
  --short \
  -d . \
  --template-title "YM Camp 2026" \
  --template-button "Open Camp Site" \
  --template-instructions "Vineyard Ward parents: ask Jared, Zach, Andrew, or Tim for the password."

echo "Encrypting route map widget..."
(
  cd assets
  staticrypt route_map_widget.html \
    -p "$PASSWORD" \
    --short \
    -d . \
    -c ../.staticrypt.json \
    --template-title "YM Camp 2026 Map" \
    --template-button "Open Camp Site" \
    --template-instructions "Vineyard Ward parents: ask Jared, Zach, Andrew, or Tim for the password."
)

for file in "${HTML_FILES[@]}" assets/route_map_widget.html; do
  if ! grep -q "staticrypt-html" "$file"; then
    echo "Encryption check failed for $file"
    exit 1
  fi
done

git add .gitignore .nojekyll .staticrypt.json README.md deploy.sh "${HTML_FILES[@]}" assets/route_map_widget.html
git commit -m "$COMMIT_MSG" || echo "(nothing to commit)"
git push origin "$(git branch --show-current)"

echo ""
echo "Encrypted site deployed. GitHub Pages should refresh shortly."
