if ! command -v qs &>/dev/null; then
  echo "Error: Quickshell (qs) is required for the GUI." >&2
  echo "Install quickshell, or use 'msnap shot' / 'msnap cast' for CLI-only operation." >&2
  exit 1
fi

INJECTED_GUI_PATH="@GUI_PATH@"
USER_GUI_PATH="${XDG_DATA_HOME:-$HOME/.local/share}/msnap/gui"
SYS_GUI_PATH="/usr/share/msnap/gui"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
LOCAL_GUI_PATH="$REPO_ROOT/gui"

if [[ -d "$INJECTED_GUI_PATH" ]]; then
  GUI_DIR="$INJECTED_GUI_PATH"
elif [[ -d "$USER_GUI_PATH" ]]; then
  GUI_DIR="$USER_GUI_PATH"
elif [[ -d "$SYS_GUI_PATH" ]]; then
  GUI_DIR="$SYS_GUI_PATH"
elif [[ -d "$LOCAL_GUI_PATH" ]]; then
  GUI_DIR="$LOCAL_GUI_PATH"
else
  echo "Error: Cannot find msnap GUI assets." >&2
  echo "Expected at $USER_GUI_PATH or $SYS_GUI_PATH" >&2
  exit 1
fi

exec qs -p "$GUI_DIR"
