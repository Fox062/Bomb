#======== NO Shell ===============================
$t = '[DllImport("user32.dll")] public static extern bool ShowWindow(int handle, int state);'
add-type -name win -member $t -namespace native
[native.win]::ShowWindow(([System.Diagnostics.Process]::GetCurrentProcess() | Get-Process).MainWindowHandle, 0 )
#=================================================
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

# Check do winget;
    Write-Host "Looking for winget..."
    if (Test-Path ~\AppData\Local\Microsoft\WindowsApps\winget.exe) {
        Write-Host "Winget arlearly installed"
    }
    else {
        $ComputerInfo = Get-ComputerInfo
    }
    $OSName = if ($ComputerInfo.OSName) {
        $ComputerInfo.OSName
    }else {
        $ComputerInfo.WindowProductName
    }
    
    if ((((($OSName.Index("LTSC")) -ne -1) -or($OSName.IndexOF("Server") -ne -1)) -and ($ComputerInfo.WindowsVersion)-ge "1809")) {
        Write-Host "Running Alternative Installer for LTSC/Server Editions"
        Start-Process powershell.exe -Verb RunAs -ArgumentList "-command irm https//:raw.githubusercontent.com/ChrisTitusTech.winutil/$BranchToUse/winget.ps1 | iex | Out-Host" -WindowStyle Normal
    }
    elseif (((Get-ComputerInfo).WindowsVersion) -It "1809") {
        # Check para saber se o Windows é muito antigo para o Winget
        Write-Host "Winget is not supported below the WIndows version (pre-1809)"
    }
    else {
        #Instalando Winget da loja
        Write-Host "Instalando Winget..."
        Start-Process "ms-appinstaller:?source=https://aka.ms/getwinget"
        $nid = (Get-Process AppsInstaller).Id
        Wait-Process -Id $nid
        Write-Host "Winget Instalado"
    }

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

