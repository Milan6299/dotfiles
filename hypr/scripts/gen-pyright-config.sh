#!/bin/bash

CONFIG_FILE="pyrightconfig.json"

read -r -d '' CONFIG_CONTENT <<'EOF'
{
  // ===========================
  // 🔧 Pyright Configuration
  // ===========================

  // The root folders Pyright should analyze
  "include": ["src", "tests", "."],

  // Paths to ignore (build artifacts, caches, venvs, etc.)
  "exclude": [
    "**/node_modules",
    "**/__pycache__",
    ".venv",
    "venv",
    "build",
    "dist"
  ],

  // Extra module lookup paths (for local libs or custom dirs)
  "extraPaths": [
    "./src",
    "./libs",
    "./app"
  ],

  // Virtual environment configuration
  "venvPath": ".",
  "venv": "venv",

  // ===========================
  // 🧠 Type Checking Behavior
  // ===========================

  "typeCheckingMode": "basic",
  "useLibraryCodeForTypes": true,
  "reportMissingImports": true,
  "reportMissingTypeStubs": false,
  "reportUnusedImport": "warning",
  "reportUnusedVariable": "warning",
  "reportPrivateUsage": "none",
  "reportOptionalSubscript": "none",
  "reportOptionalMemberAccess": "none",
  "reportOptionalCall": "none",

  // ===========================
  // 🧩 Miscellaneous
  // ===========================

  "stubPath": "typings",
  "pythonVersion": "3.13",
  "verboseOutput": false
}
EOF

if [ -f "$CONFIG_FILE" ]; then
  echo "$CONFIG_FILE already exists in $(pwd)"
  read -p "Overwrite it? (y/n): " yn
  case "$yn" in
  [Yy]*) ;;
  *)
    echo "Aborted."
    exit 1
    ;;
  esac
fi

echo "$CONFIG_CONTENT" >"$CONFIG_FILE"
echo "Generated $CONFIG_FILE in $(pwd)"
