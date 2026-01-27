#!/usr/bin/env bash

set -eufo pipefail

echo "==> 📜 Before install - Setup 1"

if ! command -v brew >/dev/null 2>&1; then
  echo "==> 🍺 Install Homebrew"

  (/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)")

  defaults delete com.apple.dock persistent-apps
  killall Dock
fi
