#!/bin/bash
set -euo pipefail

export PATH="/opt/homebrew/bin:/usr/local/bin:$HOME/Library/pnpm:$HOME/.local/share/pnpm:$PATH"
project_root="$(cd "$SRCROOT/../../../.." && pwd)"
cd "$project_root"

if ! command -v pnpm >/dev/null 2>&1 || ! command -v node >/dev/null 2>&1; then
  echo "EraLens iOS resources require Node.js 22 and pnpm 9. Install them and reopen Xcode." >&2
  exit 1
fi

resource_path="$TARGET_BUILD_DIR/$UNLOCALIZED_RESOURCES_FOLDER_PATH/NativeResources"
pnpm run apple:resources -- --platform=ios --output="$resource_path"
