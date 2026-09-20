#!/usr/bin/env bash
# Local, solo-dev sync: copies the freshly-exported spec from the sibling monitor-api checkout.
# CI does the equivalent by checking out monitor-api as a second repo (see .github/workflows).
set -euo pipefail
cd "$(dirname "$0")/.."

SRC="../monitor-api/openapi/v1.json"
if [ ! -f "$SRC" ]; then
  echo "Run monitor-api/scripts/export-openapi.sh first (looked for $SRC)" >&2
  exit 1
fi

mkdir -p openapi
cp "$SRC" openapi/v1.json
echo "Synced openapi/v1.json from monitor-api"
