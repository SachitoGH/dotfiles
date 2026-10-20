param([string]$Title = "Claude Code", [string]$Body = "", [switch]$Sound, [switch]$SkipIfTerminalFocused, [string]$Launch = "")
if ($SkipIfTerminalFocused) {
  Add-Type -Namespace Win32 -Name Fg -MemberDefinition @'
[DllImport("user32.dll")] public static extern System.IntPtr GetForegroundWindow();
[DllImport("user32.dll")] public static extern uint GetWindowThreadProcessId(System.IntPtr hWnd, out uint pid);
'@
  $fgPid = 0; [Win32.Fg]::GetWindowThreadProcessId([Win32.Fg]::GetForegroundWindow(), [ref]$fgPid) | Out-Null
  if ((Get-Process -Id $fgPid -ErrorAction SilentlyContinue).ProcessName -eq 'WindowsTerminal') { exit }
}
[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
[Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] | Out-Null
$audio = if ($Sound) { '<audio src="ms-winsoundevent:Notification.Default"/>' } else { '<audio silent="true"/>' }
$t = [Security.SecurityElement]::Escape($Title); $b = [Security.SecurityElement]::Escape($Body)
$xml = New-Object Windows.Data.Xml.Dom.XmlDocument
# With -Launch (a claude-focus: link), clicking the toast refocuses the terminal via focus.ps1.
$activation = if ($Launch) { " activationType=`"protocol`" launch=`"$([Security.SecurityElement]::Escape($Launch))`"" } else { "" }
$xml.LoadXml("<toast$activation><visual><binding template=`"ToastGeneric`"><text>$t</text><text>$b</text></binding></visual>$audio</toast>")
$app = '{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe'
[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($app).Show([Windows.UI.Notifications.ToastNotification]::new($xml))
