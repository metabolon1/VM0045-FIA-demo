#!/usr/bin/env bash
set -e

# Work from the project directory (qmd/)
proj_dir="${QUARTO_PROJECT_DIR:-$(pwd)}"
cd "$proj_dir"

# If Quarto provided explicit output files, use them
if [ -n "${QUARTO_PROJECT_OUTPUT_FILES:-}" ]; then
  while IFS= read -r out; do
    [ -z "$out" ] && continue   # skip empty lines

    # out is like "../docs/module_01_filtering_demo_RI.html"
    fname="$(basename "$out")"  # module_01_filtering_demo_RI.html
    stem="${fname%.*}"          # module_01_filtering_demo_RI

    rm -rf "${stem}_cache" "${stem}_files"
  done <<< "${QUARTO_PROJECT_OUTPUT_FILES}"
else
  # Fallback: allow manual testing with arguments
  for out in "$@"; do
    fname="$(basename "$out")"
    stem="${fname%.*}"
    rm -rf "${stem}_cache" "${stem}_files"
  done
fi