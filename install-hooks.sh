#!/usr/bin/env bash
# Run once after cloning to install the pre-commit hook.
set -euo pipefail
ROOT="$(git rev-parse --show-toplevel)"
cp "$ROOT/.githooks/pre-commit" "$ROOT/.git/hooks/pre-commit"
chmod +x "$ROOT/.git/hooks/pre-commit"
echo "pre-commit hook installed."
