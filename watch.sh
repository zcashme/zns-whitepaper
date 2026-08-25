#!/bin/bash
# Auto-recompile the ZNS whitepaper on save.
# Usage: cd paper && ./watch.sh
# Open main.pdf in Skim. Save any .tex file -> PDF auto-refreshes.
# Press Ctrl-C to stop.

cd "$(dirname "$0")"

echo "Watching main.tex and sections/..."
echo "Open main.pdf in Skim now."
echo "Skim > Preferences > Sync > Reload when file changes"
echo ""

fswatch -o main.tex sections/ | while read; do
  echo -n "$(date +%H:%M:%S) rebuilding... "
  output=$(tectonic main.tex 2>&1)
  if echo "$output" | grep -q "Writing"; then
    echo "done"
  else
    echo "ERROR"
    echo "$output" | grep -i "error" | head -5
  fi
done