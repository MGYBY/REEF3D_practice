#!/usr/bin/env bash
# set -euo pipefail

out="solid.stl"
tmp="${out}.tmp"

# Check that pier.stl exists
if [[ ! -f "pier.stl" ]]; then
    echo "Error: pier.stl not found in the current folder."
    exit 1
fi

# Collect all cube*.stl files, sorted naturally, then append pier.stl
{
    echo "solid merged"

    find . -maxdepth 1 -type f -name 'cube*.stl' -print0 \
    | sort -zV \
    | while IFS= read -r -d '' f; do
        awk '
            /^[[:space:]]*solid([[:space:]]|$)/    { next }
            /^[[:space:]]*endsolid([[:space:]]|$)/ { next }
            { print }
        ' "$f"
    done

    awk '
        /^[[:space:]]*solid([[:space:]]|$)/    { next }
        /^[[:space:]]*endsolid([[:space:]]|$)/ { next }
        { print }
    ' "pier.stl"

    echo "endsolid merged"
} > "$tmp"

mv "$tmp" "$out"

echo "Merged STL written to: $out"
ls -lh "$out"