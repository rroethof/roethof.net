<#
.SYNOPSIS
    Registreert een Task Scheduler-taak die Force-WindowsUpdate.ps1 draait:
    - Bij elke logon
    - Elke 4 uur zolang de laptop aan staat
    Draait als SYSTEM zodat het ook zonder ingelogde gebruiker kan draaien,
    met hoogste rechten (nodig voor Windows Update).

.NOTES
    Eenmalig als Administrator uitvoeren op de laptop van je zoon.
    Pas $ScriptPath aan naar waar je Force-WindowsUpdate.ps1 hebt neergezet.
#>

$TaskName   = "Force-WindowsUpdate"
$ScriptPath = "C:\Scripts\Force-WindowsUpdate.ps1"   # <-- pas dit pad aan indien nodig

if (-not (Test-Path $ScriptPath)) {
    Write-Warning "LET OP: $ScriptPath bestaat nog niet. Kopieer Force-WindowsUpdate.ps1 daar naartoe voordat je deze taak gebruikt."
}

$Action = New-ScheduledTaskAction -Execute "powershell.exe" `
    -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$ScriptPath`""

# Trigger 1: bij inloggen van elke gebruiker
$TriggerLogon = New-ScheduledTaskTrigger -AtLogOn

# Trigger 2: elke 4 uur, herhalend, startend vanaf nu, voor onbeperkte duur
$TriggerRepeat = New-ScheduledTaskTrigger -Once -At (Get-Date) `
    -RepetitionInterval (New-TimeSpan -Hours 4) `
    -RepetitionDuration ([TimeSpan]::MaxValue)

$Principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount -RunLevel Highest

$Settings = New-ScheduledTaskSettingsSet `
    -AllowStartIfOnBatteries `
    -DontStopIfGoingOnBatteries `
    -StartWhenAvailable `
    -RunOnlyIfNetworkAvailable `
    -ExecutionTimeLimit (New-TimeSpan -Hours 2)

Register-ScheduledTask -TaskName $TaskName `
    -Action $Action `
    -Trigger @($TriggerLogon, $TriggerRepeat) `
    -Principal $Principal `
    -Settings $Settings `
    -Description "Forceert Windows Update scan/install, bij logon en elke 4 uur." `
    -Force

Write-Host "Taak '$TaskName' geregistreerd. Test hem met: Start-ScheduledTask -TaskName '$TaskName'"
