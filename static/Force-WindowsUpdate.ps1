<#
.SYNOPSIS
    Forceert het scannen, downloaden, installeren en (indien nodig) herstarten
    voor Windows Updates. Bedoeld om via Task Scheduler te draaien (bv. bij
    opstarten/inloggen en elke X uur), zodat updates altijd draaien zodra de
    laptop aan staat -- ongeacht of hij op het thuisnetwerk of schoolnetwerk zit.

.NOTES
    - Moet als Administrator draaien (Task Scheduler taak: "Run with highest privileges")
    - Vereist internetverbinding (werkt op elk netwerk, niet afhankelijk van je thuisserver)
    - Logt naar C:\Logs\WindowsUpdate\update_<datum>.log
    - Optioneel: stuurt het logbestand naar je eigen server (zie onderaan, uitgecommentarieerd)
#>

param(
    [switch]$AutoReboot = $true,          # automatisch herstarten indien nodig
    [int]$MaxRebootWaitMinutes = 5,       # geef gebruiker X minuten waarschuwing voor reboot
    [string]$LogDir = "C:\Logs\WindowsUpdate"
)

# --- Setup logging ---------------------------------------------------------
if (-not (Test-Path $LogDir)) {
    New-Item -ItemType Directory -Path $LogDir -Force | Out-Null
}
$LogFile = Join-Path $LogDir ("update_{0}.log" -f (Get-Date -Format "yyyy-MM-dd_HHmmss"))

function Write-Log {
    param([string]$Message)
    $line = "{0} - {1}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"), $Message
    Write-Output $line
    Add-Content -Path $LogFile -Value $line
}

Write-Log "=== Windows Update run gestart ==="

# --- Zorg dat we als Administrator draaien ---------------------------------
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal ([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Log "FOUT: script draait niet als Administrator. Stoppen."
    exit 1
}

# --- Zorg dat PSWindowsUpdate geinstalleerd is ------------------------------
if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
    Write-Log "PSWindowsUpdate module niet gevonden, installeren..."
    try {
        # NuGet provider is nodig om vanaf PSGallery te installeren
        if (-not (Get-PackageProvider -Name NuGet -ErrorAction SilentlyContinue)) {
            Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force -Scope AllUsers | Out-Null
        }
        Set-PSRepository -Name PSGallery -InstallationPolicy Trusted -ErrorAction SilentlyContinue
        Install-Module -Name PSWindowsUpdate -Force -Scope AllUsers -ErrorAction Stop
        Write-Log "PSWindowsUpdate succesvol geinstalleerd."
    }
    catch {
        Write-Log "FOUT bij installeren PSWindowsUpdate: $($_.Exception.Message)"
        exit 1
    }
}

Import-Module PSWindowsUpdate -ErrorAction Stop

# --- Scan + installeer updates ----------------------------------------------
try {
    Write-Log "Scannen naar beschikbare updates..."
    $available = Get-WindowsUpdate -MicrosoftUpdate -AcceptAll -IgnoreReboot -ErrorAction Stop

    if ($available.Count -eq 0) {
        Write-Log "Geen updates gevonden. Systeem is up-to-date."
    }
    else {
        Write-Log "Gevonden updates: $($available.Count)"
        $available | ForEach-Object { Write-Log " - $($_.Title)" }

        Write-Log "Updates downloaden en installeren..."
        $result = Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -IgnoreReboot -Verbose -ErrorAction Stop 4>&1

        foreach ($line in $result) { Write-Log "  $line" }
    }
}
catch {
    Write-Log "FOUT tijdens update-run: $($_.Exception.Message)"
}

# --- Reboot afhandelen -------------------------------------------------------
$rebootRequired = Get-WURebootStatus -Silent
if ($rebootRequired) {
    Write-Log "Reboot is vereist."
    if ($AutoReboot) {
        Write-Log "Reboot wordt over $MaxRebootWaitMinutes minuut/minuten uitgevoerd."
        # Waarschuw eventueel ingelogde gebruiker
        msg * "Windows Updates zijn geinstalleerd. De computer herstart automatisch over $MaxRebootWaitMinutes minuten. Sla je werk op!" 2>$null
        shutdown.exe /r /t ($MaxRebootWaitMinutes * 60) /c "Automatische herstart na Windows Update" /f
    }
    else {
        Write-Log "AutoReboot staat uit -- reboot NIET uitgevoerd, gebruiker moet zelf herstarten."
    }
}
else {
    Write-Log "Geen reboot vereist."
}

Write-Log "=== Windows Update run voltooid ==="

# --- Optioneel: log terugsturen naar je eigen server ------------------------
# Voorbeeld: upload het logbestand naar een endpoint op je Linux server
# (bv. een klein Flask/nginx upload-endpoint, of scp met een key-only user)
#
# try {
#     Invoke-RestMethod -Uri "https://updates.jouwdomein.nl/upload" `
#         -Method Post -InFile $LogFile -ContentType "text/plain" `
#         -Headers @{ "X-Device" = $env:COMPUTERNAME }
# } catch {
#     Write-Log "Kon log niet naar server sturen: $($_.Exception.Message)"
# }
