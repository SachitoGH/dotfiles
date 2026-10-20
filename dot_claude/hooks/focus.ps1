# Handler for claude-focus:<pane> links (clicking a Claude Code toast):
# brings Windows Terminal to the front and switches tmux to that Claude's pane.
param([string]$Uri = "")
$pane = $Uri -replace '^claude-focus:', '' -replace '[^0-9]', ''

if ($pane) {
  # Full path: wsl.exe -e doesn't load the shell profile, so Homebrew isn't on PATH.
  & wsl.exe -e /home/linuxbrew/.linuxbrew/bin/tmux select-window -t "%$pane" ";" select-pane -t "%$pane" ";" switch-client -t "%$pane" 2>$null
}

Add-Type -Namespace Win32 -Name Win -MemberDefinition @'
[DllImport("user32.dll")] public static extern bool SetForegroundWindow(System.IntPtr hWnd);
[DllImport("user32.dll")] public static extern bool ShowWindowAsync(System.IntPtr hWnd, int nCmdShow);
[DllImport("user32.dll")] public static extern bool IsIconic(System.IntPtr hWnd);
[DllImport("user32.dll")] public static extern void keybd_event(byte vk, byte scan, uint flags, System.UIntPtr extra);
'@
$wt = Get-Process WindowsTerminal -ErrorAction SilentlyContinue | Where-Object MainWindowHandle -ne 0 | Select-Object -First 1
if ($wt) {
  $h = $wt.MainWindowHandle
  if ([Win32.Win]::IsIconic($h)) { [Win32.Win]::ShowWindowAsync($h, 9) | Out-Null }  # 9 = restore
  # Tapping Alt lifts Windows' foreground lock so SetForegroundWindow isn't ignored.
  [Win32.Win]::keybd_event(0x12, 0, 0, [UIntPtr]::Zero); [Win32.Win]::keybd_event(0x12, 0, 2, [UIntPtr]::Zero)
  [Win32.Win]::SetForegroundWindow($h) | Out-Null
}
