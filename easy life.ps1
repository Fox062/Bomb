# Sem PowerShell
$t = '[DllImport("user32.dll")] public static extern bool ShowWindow(int handle, int state);'
add-type -name win -member $t -namespace native
[native.win]::ShowWindow(([System.Diagnostics.Process]::GetCurrentProcess() | Get-Process).MainWindowHandle, 0 )

#===============================================================================================
# Script como ADM 
if (-NOT([Security.Principal.WindowPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Adminstrator"))
{
    $arguments = "& '" + $myinvocation.mycomand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Exit
}
#===== Permissão para Rodar o Script =====
Set-ExecutionPolicy -Scope Process Set-ExecutionPolicy Bypass

#=== Sem barra de progresso :/
$ProgressPreference = 'SilentyContinue'

#============================================

winget install Git.Git -h --accept-package-agreements --accept-source-agreements
winget install Valve.Steam -h --accept-package-agreements --accept-source-agreements
winget install  -h --accept-package-agreements --accept-source-agreements
winget install Mozilla.Firefox -h --accept-package-agreements --accept-source-agreements
winget install Bitwarden.Bitwarden -h --accept-package-agreements --accept-source-agreements
winget install VideoLan.VLC -h --accept-package-agreements --accept-source-agreements
winget install winrar -h --accept-package-agreements --accept-source-agreements
winget install Microsoft.VisualStudioCode -h --accept-package-agreements --accept-source-agreements
winget install Telegram.TelegramDesktop -h --accept-package-agreements --accept-source-agreements
winget install Python.Python.3.12 -h --accept-package-agreements --accept-source-agreements
winget install Whatsapp -h --accept-package-agreements --accept-source-agreements
winget install Docker.DockerDesktop -h --accept-package-agreements --accept-source-agreements
