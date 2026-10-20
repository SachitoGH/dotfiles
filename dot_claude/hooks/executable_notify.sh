#!/usr/bin/env bash
# Claude Code hook: silent Windows toast + terminal bell (Windows Terminal flashes the taskbar icon).
# Usage: notify.sh ["<message>"]   (without one, builds a context-aware message from the hook JSON on stdin)
# Title + body built from the hook JSON (event type, transcript); a "$1" argument overrides the body.
{ IFS= read -r title; IFS= read -r msg; } < <(python3 -I ~/.claude/hooks/notify_msg.py 2>/dev/null)
msg="${1:-${msg:-Claude Code}}"
dir=$(basename "${CLAUDE_PROJECT_DIR:-$PWD}"); [ "${CLAUDE_PROJECT_DIR:-$PWD}" = "$HOME" ] && dir="~"

# Bell: find the tty of the claude process we run under and ring it (tmux forwards it to Windows Terminal).
pid=$$
while [ "$pid" -gt 1 ]; do
  tty=$(ps -o tty= -p "$pid" | tr -d ' ')
  if [ -n "$tty" ] && [ "$tty" != "?" ]; then printf '\a' > "/dev/$tty"; break; fi
  pid=$(ps -o ppid= -p "$pid" | tr -d ' ')
done

# Skip the toast when you're already looking at this Claude: its tmux pane is on screen
# (checked here) and Windows Terminal is the focused window (checked by toast.ps1).
focus_arg=()
if [ -z "$TMUX_PANE" ] ||
   [ "$(tmux display -p -t "$TMUX_PANE" '#{session_attached}#{window_active}#{pane_active}' 2>/dev/null)" = "111" ]; then
  focus_arg=(-SkipIfTerminalFocused)
fi

# Silent Windows toast (WSL only), detached so the hook returns immediately.
[ -n "$WSL_DISTRO_NAME" ] || exit 0
/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -NoProfile -ExecutionPolicy Bypass \
  -File "$(wslpath -w ~/.claude/hooks/toast.ps1)" -Title "${title:-Claude Code} · $dir" -Body "$msg" -Launch "claude-focus:${TMUX_PANE#%}" "${focus_arg[@]}" >/dev/null 2>&1 &
