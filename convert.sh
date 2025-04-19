#!/usr/bin/env bash
# Spencer Butler <spencer@tcos.us>
# Convert SpencerButler.md to SpencerButler.{html,pdf,txt}
# Requires: pandoc, wkhtmltopdf, texlive-latex-recommended

set -euo pipefail

# Default resume name
readonly RESUME="${resume:-SpencerButler}"

# Check if required tools are installed
for cmd in pandoc wkhtmltopdf; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Error: $cmd is required but not installed." >&2
        exit 1
    fi
done

# Check if source file exists
if [ ! -f "${RESUME}.md" ]; then
    echo "Error: ${RESUME}.md not found!" >&2
    exit 1
fi

# Convert to various formats
echo "Converting ${RESUME}.md to HTML..."
pandoc -s "${RESUME}.md" -t html5 -o "${RESUME}.html"

echo "Converting ${RESUME}.md to PDF..."
pandoc -V geometry:margin=1in -s "${RESUME}.md" -t latex -o "${RESUME}.pdf"

echo "Converting ${RESUME}.md to plain text..."
sed -e 's/^#*[[:space:]]//g' "${RESUME}.md" > "${RESUME}.txt"

echo "Creating README.md..."
cp "${RESUME}.md" README.md

echo "All conversions completed successfully!"
