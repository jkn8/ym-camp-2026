#!/usr/bin/env bash
# YM Camp 2026 — encrypt site and push to GitHub Pages
# Run from the site/ folder: ./deploy.sh
set -e

# ----- EDIT ME -----
PASSWORD="changeme"            # The shared password for parents/leaders
COMMIT_MSG="Update site"       # Optional: customize per push
# -------------------

if [ "$PASSWORD" = "changeme" ]; then
  echo "❌ Edit deploy.sh and set PASSWORD before running."
  exit 1
fi

if ! command -v staticrypt >/dev/null 2>&1; then
  echo "Installing staticrypt..."
  npm install -g staticrypt
fi

# Stash the originals (so re-running doesn't double-encrypt)
mkdir -p .source
cp -f *.html .source/ 2>/dev/null || true

# Restore from .source before encrypting (so we always start from clean HTML)
cp -f .source/*.html . 2>/dev/null || true

# Encrypt all top-level HTML pages
echo "🔒 Encrypting pages with staticrypt..."
staticrypt index.html agenda.html camp.html pack.html safety.html \
           logistics.html menu.html leaders.html swag.html rsvp.html map.html \
           -p "$PASSWORD" \
           --short \
           -d . \
           --template-title "YM Camp 2026" \
           --template-instructions "Vineyard Ward parents: enter the password shared by your YM leaders." \
           --template-button "Enter"

# Commit + push
git add -A
git commit -m "$COMMIT_MSG" || echo "(nothing to commit)"
git push

echo ""
echo "✅ Site deployed. Pages will refresh within ~60 seconds."
echo "   URL: check repo Settings → Pages for the live URL."
