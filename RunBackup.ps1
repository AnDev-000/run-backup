﻿param(
    [switch]$AutoMode
)

# -------------------------------------------------------------------
# SCRIPT PRINCIPAL DE RUNBACKUP
# -------------------------------------------------------------------

if (-not (Get-Module -ListAvailable -Name BurntToast)) {
    $spinner = "|/-\"
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = "powershell.exe"
    $psi.Arguments = "-NoProfile -ExecutionPolicy Bypass -Command `"Install-Module -Name BurntToast -Scope CurrentUser -Force -AllowClobber`""
    $psi.CreateNoWindow = $true
    $psi.UseShellExecute = $false

    $process = [System.Diagnostics.Process]::Start($psi)
    while (-not $process.HasExited) {
        for ($i = 0; $i -lt $spinner.Length; $i++) {
            Write-Host -NoNewline ("`r{0}" -f $spinner[$i])
            Start-Sleep -Milliseconds 150
        }
    }
    Write-Host "`r" -NoNewline
    Import-Module BurntToast -ErrorAction Stop
}

. "$PSScriptRoot\lang\languages.ps1"
$currentLanguage = "spanish"              # Opciones: "spanish","english", japanese, german.
$msg = $languages[$currentLanguage]

$sourcePath = "REEMPLAZA_CON_TU_RUTA_DE_ORIGEN"
$destinationPaths = @(
    "REEMPLAZA_CON_TU_RUTA_DE_DESTINO",
    "REEMPLAZA_CON_TU_RUTA_DE_DESTINO",
    "REEMPLAZA_CON_TU_RUTA_DE_DESTINO"
)

$global:logEntries = @()
$global:backupFailures = @()

# ------------------ FUNCIONES DE UTILIDAD ------------------

function Validate-PathCustom {
    param([string]$path)
    return ($path -match '^[A-Za-z]:[\\/].+') -and (Test-Path $path)
}

function Center-Text {
    param(
        [Parameter(Mandatory = $true)][string]$Text,
        [Parameter(Mandatory = $true)][int]$Width
    )
    if ($Text.Length -ge $Width) { return $Text }
    $padding = $Width - $Text.Length
    $padLeft = [math]::Floor($padding / 2)
    $padRight = $padding - $padLeft
    return (" " * $padLeft) + $Text + (" " * $padRight)
}

function Get-ReplacementDateDisplay {
    param([datetime]$date, [string]$state)
    if ($state -eq $msg.state_exists) {
        return Center-Text -Text "┄┄┄┄┄┄┄┄┄" -Width 20
    }
    else {
        return $date.ToString("dd-MM-yy HH:mm:ss")
    }
}

function Get-DestinationColor {
    param([string]$dest)
    if ($dest -match "OneDrive") { return "Blue" }
    elseif ($dest -match "iCloudDrive") { return "Cyan" }
    else {
        $cols = @("Yellow", "Magenta", "DarkYellow", "Green", "White")
        return $cols[(Get-Random -Maximum $cols.Count)]
    }
}

function Get-DisplayNameForDestination {
    param([string]$dest, [string]$Color = (Get-DestinationColor $dest))
    if ($dest -imatch "OneDrive") {
        return @{ Icon = $globalSymbols.cloud + " "; Name = $msg.cloud_OneDrive; Color = $Color }
    }
    elseif ($dest -imatch "iCloudDrive") {
        return @{ Icon = $globalSymbols.cloud + " "; Name = $msg.cloud_iCloudDrive; Color = $Color }
    }
    else {
        $leaf = Split-Path -Path $dest -Leaf
        return @{ Icon = $globalSymbols.folder; Name = $leaf; Color = $Color }
    }
}

function Format-IconText {
    param([string]$Icon, [string]$Text)
    return $Icon + " " + $Text
}

function Write-IconMessage {
    param([string]$Icon, [string]$Text, [string]$Color = "White", [switch]$NoNewline)
    if ($Icon -eq $globalSymbols.warning) { $Icon = $Icon + " " }
    $formatted = Format-IconText $Icon $Text
    if ($NoNewline) { Write-Host $formatted -ForegroundColor $Color -NoNewline }
    else { Write-Host $formatted -ForegroundColor $Color }
}

function Print-Separator {
    param([string]$Char = "=", [int]$Width = [Console]::WindowWidth, [string]$Color = "Cyan")
    Write-Host ($Char * $Width) -ForegroundColor $Color
}

function Update-ProgressBar {
    param([string]$Icon, [int]$Counter, [int]$TotalFiles, [int]$BarLength)
    $filled = "█" * [Math]::Round(($Counter * $BarLength) / $TotalFiles)
    $empty = " " * ($BarLength - $filled.Length)
    $percent = [Math]::Round(($Counter * 100) / $TotalFiles)
    return ("[" + $filled + $empty + "] " + $percent + "% " + $msg.progressCompleted)
}

function Truncate-Text {
    param([Parameter(Mandatory = $true)][string]$text, [Parameter(Mandatory = $true)][int]$maxLength)
    if ($text.Length -gt $maxLength) { return $text.Substring(0, $maxLength - 3) + "..." } else { return $text }
}

# ------------------ VALIDACIONES INICIALES ------------------

$sourceError = $false
if ($sourcePath -is [array]) {
    $sourceError = $true
    $sourcePresentation = $msg.errorMultipleSource
}
elseif (-not (Validate-PathCustom $sourcePath)) {
    $sourceError = $true
    $sourcePresentation = $msg.errorNoSource
}
else {
    $sourcePresentation = $sourcePath
}

$validDestinations = @()
$destinationWarnings = @()
$idx = 1
foreach ($d in $destinationPaths) {
    if ($d -match '^[A-Za-z]:[\\/].+') {
        $color = Get-DestinationColor $d
        $obj = [PSCustomObject]@{ Index = $idx; Destination = $d; Color = $color }
        $validDestinations += $obj
    }
    else {
        $destinationWarnings += ($globalSymbols.dash + " " + $msg.destSingular + " " + $idx.ToString() + $globalSymbols.colon + " " + $msg.errorInvalidDestination + " '" + $d + "'")
    }
    $idx++
}

function Show-InitialPresentation {
    Write-Host ""
    Print-Separator "=" ([Console]::WindowWidth) "Cyan"
    Write-Host ($globalSymbols.bold + $msg.titleAutoBackup + $globalSymbols.bold) -ForegroundColor Cyan
    Print-Separator "=" ([Console]::WindowWidth) "Cyan"
    Write-Host ""
    
    Write-IconMessage $globalSymbols.folder ($msg.labelSource + $globalSymbols.colon) "Gray"
    Write-Host ""
    if ($sourceError) { $originColor = "Red" } else { $originColor = "White" }
    Write-Host ("   └── " + $sourcePresentation) -ForegroundColor $originColor
    Write-Host ""
    
    Write-IconMessage $globalSymbols.storage ($msg.destPlural + $globalSymbols.colon) "Gray"
    Write-Host ""
    $i = 1
    foreach ($dest in $destinationPaths) {
        if ($dest -match '^[A-Za-z]:[\\/].+') {
            $obj = $validDestinations | Where-Object { $_.Index -eq $i }
            if ($obj) { $color = $obj.Color; $icon = (Get-DisplayNameForDestination $dest -Color $color).Icon }
            else { $color = Get-DestinationColor $dest; $icon = (Get-DisplayNameForDestination $dest -Color $color).Icon }
            Write-Host ($i.ToString() + " " + $globalSymbols.colon + " " + $icon + " " + $dest) -ForegroundColor $color
        }
        else {
            Write-Host ($i.ToString() + " " + $globalSymbols.colon + " " + $globalSymbols.error + " '" + $dest + "'") -ForegroundColor Red
        }
        $i++
    }
    
    if ($validDestinations.Count -eq 0) {
        Write-Host ("   " + $msg.errorNoDestination) -ForegroundColor Red
    }
    
    if (-not $sourceError -and $validDestinations.Count -gt 0) {
        Write-Host ""
        Print-Separator "-" ([Console]::WindowWidth) "Yellow"
        Write-Host ""
    }
}

function Copy-WithProgress {
    param(
        [string]$DestinationPath,
        [int]$DestIndex,
        [string]$Color
    )
    if (-not $Color) { $Color = Get-DestinationColor $DestinationPath }
    
    $IconForDest = if ($DestinationPath -imatch "OneDrive" -or $DestinationPath -imatch "iCloudDrive") { $globalSymbols.cloud + " " } else { $globalSymbols.folder }
    
    $Files = Get-ChildItem -Path $sourcePath -Recurse -File
    $TotalFiles = $Files.Count
    if ($TotalFiles -eq 0) {
        Write-Host $msg.noFilesFound -ForegroundColor Red
        return
    }
    $Counter = 0
    $BarLength = 40
    $normalizedSource = $sourcePath.TrimEnd('\', '/') + "\"
    try {
        foreach ($File in $Files) {
            $sourceTime = $File.LastWriteTime
            $fullDestPath = $File.FullName.Replace($sourcePath, $DestinationPath)
            $destFolder = Split-Path -Path $fullDestPath -Parent
            if (-not (Test-Path $destFolder)) { New-Item -Path $destFolder -ItemType Directory -Force | Out-Null }
            if (Test-Path $fullDestPath) {
                $destTime = (Get-Item $fullDestPath).LastWriteTime
                if ($destTime -ge $sourceTime) {
                    $State = $msg.state_exists
                    $replacementDate = Get-ReplacementDateDisplay -date $destTime -state $State
                }
                else {
                    Copy-Item -Path $File.FullName -Destination $fullDestPath -Force
                    $State = $msg.state_copied
                    $replacementDate = Get-ReplacementDateDisplay -date (Get-Item $fullDestPath).LastWriteTime -state $State
                }
            }
            else {
                Copy-Item -Path $File.FullName -Destination $fullDestPath -Force
                $State = $msg.state_copied
                $replacementDate = Get-ReplacementDateDisplay -date (Get-Item $fullDestPath).LastWriteTime -state $State
            }
            if ($File.DirectoryName.StartsWith($normalizedSource)) { $relativeFolder = $File.DirectoryName.Substring($normalizedSource.Length) }
            else { $relativeFolder = $File.DirectoryName }
            $logEntry = [PSCustomObject]@{
                Destination     = $DestinationPath
                Subfolder       = $relativeFolder
                FileName        = $File.Name
                OriginalDate    = $sourceTime.ToString("dd-MM-yy HH:mm:ss")
                ReplacementDate = $replacementDate
                State           = $State
            }
            $global:logEntries += $logEntry
            $Counter++
            $progressBar = Update-ProgressBar $IconForDest $Counter $TotalFiles $BarLength
            $progressText = $DestIndex.ToString() + $globalSymbols.colon + " " + $IconForDest + " " + $progressBar
            if ($Counter -eq 1) { Write-Host $progressText -ForegroundColor $Color }
            else {
                $cursorLine = [Console]::CursorTop - 1
                [Console]::SetCursorPosition(0, $cursorLine)
                Write-Host $progressText -ForegroundColor $Color
            }
            Start-Sleep -Milliseconds 20
        }
    }
    catch {
        Write-IconMessage $globalSymbols.warning (" " + $msg.errorDuringBackup + " " + $DestinationPath + $globalSymbols.colon + " " + $_.Exception.Message) Red
        $global:backupFailures += $DestinationPath
    }
}

function Process-Backup {
    foreach ($obj in $validDestinations) {
        Copy-WithProgress -DestinationPath $obj.Destination -DestIndex $obj.Index -Color $obj.Color
        Write-Host ""
    }
}

function Show-Warnings {
    if ($destinationWarnings.Count -gt 0) {
        Print-Separator "-" ([Console]::WindowWidth) "Yellow"
        Write-Host ($globalSymbols.warning + "  " + $msg.warningText + $globalSymbols.colon) -ForegroundColor Yellow
        foreach ($warn in $destinationWarnings) { Write-Host $warn -ForegroundColor Yellow }
        Print-Separator "-" ([Console]::WindowWidth) "Yellow"
    }
}

function Show-BackupCompleted {
    $completedDestinations = @()
    foreach ($obj in $validDestinations) {
        if (-not ($global:backupFailures -contains $obj.Destination)) { $completedDestinations += $obj }
    }
    if ($completedDestinations.Count -gt 0) {
        if ($destinationWarnings.Count -eq 0) { Print-Separator "-" ([Console]::WindowWidth) "Yellow" }
        Write-Host ($globalSymbols.success + " " + $msg.labelBackupCompleted + $globalSymbols.colon) -ForegroundColor Green
        foreach ($item in $completedDestinations) {
            $display = Get-DisplayNameForDestination $item.Destination -Color $item.Color
            $line = $globalSymbols.dash + " " + $msg.destSingular + " " + $item.Index.ToString() + $globalSymbols.colon + " " + $display.Icon + " " + $display.Name
            Write-Host $line -ForegroundColor $item.Color
        }
        Print-Separator "-" ([Console]::WindowWidth) "Yellow"
    }
}

function Show-ConsolidatedTable {
    param([string]$DestinationPath, [array]$Entries)
    $destObj = $validDestinations | Where-Object { $_.Destination -eq $DestinationPath } | Select-Object -First 1
    if ($destObj) {
        $color = $destObj.Color
        $display = Get-DisplayNameForDestination $DestinationPath -Color $color
        $headerDestino = $msg.destSingular + " " + $destObj.Index.ToString() + $globalSymbols.colon + " " + $DestinationPath
    }
    else {
        $color = Get-DestinationColor $DestinationPath
        $display = Get-DisplayNameForDestination $DestinationPath -Color $color
        $headerDestino = $msg.destSingular + $globalSymbols.colon + " " + $DestinationPath
    }
    
    Print-Separator "=" ([Console]::WindowWidth) $display.Color
    Write-Host (Format-IconText $display.Icon $headerDestino) -ForegroundColor $display.Color
    Print-Separator "=" ([Console]::WindowWidth) $display.Color
    Write-Host ""
    
    $col1Width = 15
    $col2Width = 20
    $col3Width = 20
    $col4Width = 20
    $col5Width = 10

    $col1 = $msg.tableHeader1.PadRight($col1Width)
    $col2 = $msg.tableHeader2.PadRight($col2Width)
    $col3 = ($msg.date + " " + $msg.originalLabel).PadRight($col3Width)
    $col4 = ($msg.date + " " + $msg.replacementLabel).PadRight($col4Width)
    $col5 = $msg.tableHeader5.PadRight($col5Width)
    $hdr = $col1 + " " + $col2 + " " + $col3 + " " + $col4 + " " + $col5
    Write-Host $hdr -ForegroundColor White
    Print-Separator "-" ([Console]::WindowWidth) $display.Color

    foreach ($e in ($Entries | Where-Object { $_.Destination -eq $DestinationPath } | Sort-Object Subfolder, FileName)) {
        $subs = (Truncate-Text -text $e.Subfolder -maxLength $col1Width).PadRight($col1Width)
        $file = (Truncate-Text -text $e.FileName -maxLength $col2Width).PadRight($col2Width)
        $orig = $e.OriginalDate.PadRight($col3Width)
        $repl = $e.ReplacementDate.PadRight($col4Width)
        $state = $e.State.PadRight($col5Width)
        $line = $subs + " " + $file + " " + $orig + " " + $repl + " " + $state
        Write-Host $line -ForegroundColor $display.Color
    }
    Write-Host ""
}

try {
    Show-InitialPresentation
    
    if ($sourceError -or ($validDestinations.Count -eq 0)) {
        Print-Separator "=" ([Console]::WindowWidth) "Magenta"
        if ($sourceError) {
            Write-Host ($globalSymbols.dash + " " + $msg.labelSource + $globalSymbols.colon + " " + $msg.errorNoSource) -ForegroundColor Red
        }
        if ($validDestinations.Count -eq 0) {
            Write-Host ($globalSymbols.dash + " " + $msg.destSingular + " 1" + $globalSymbols.colon + " " + $msg.errorNoDestination) -ForegroundColor Red
        }
        Print-Separator "=" ([Console]::WindowWidth) "Magenta"
        $global:logEntries += [PSCustomObject]@{
            Destination     = $msg.notApplicable
            Subfolder       = $msg.notApplicable
            FileName        = $msg.notApplicable
            OriginalDate    = (Get-Date).ToString("dd-MM-yy HH:mm:ss")
            ReplacementDate = $msg.noExecuted
            State           = $msg.errorInvalidPaths
        }
        $proceed = $false
    }
    else {
        $proceed = $true
        Process-Backup
         
        $tempLogFile = Join-Path $PSScriptRoot "extras\Logs\Generate-Logs.ps1"
        if (-not (Test-Path $tempLogFile)) {
            $destinationWarnings += ($globalSymbols.dash + " " + $msg.logLabel + $globalSymbols.colon + " " + $msg.errorMissingLogFile)
        }
         
        Show-Warnings
        Show-BackupCompleted
         
        foreach ($destObj in $validDestinations) {
            Show-ConsolidatedTable -DestinationPath $destObj.Destination -Entries $global:logEntries
        }
    }
    
    if ($proceed -eq $true) {
        $existingCount = ($global:logEntries | Where-Object { $_.State -eq $msg.state_exists }).Count
        $copiedCount = ($global:logEntries | Where-Object { $_.State -eq $msg.state_copied }).Count
        $errorCount = $global:backupFailures.Count
         
        Write-Host ""
        Print-Separator "=" ([Console]::WindowWidth) "Magenta"
        Write-Host ($msg.backupSummary + $globalSymbols.colon) -ForegroundColor White
        Write-Host ($globalSymbols.dash + " " + $msg.summaryLine1 + $globalSymbols.colon + " " + $existingCount) -ForegroundColor Yellow
        Write-Host ($globalSymbols.dash + " " + $msg.summaryLine2 + $globalSymbols.colon + " " + $copiedCount) -ForegroundColor Green
        if ($errorCount -eq 1) { $errText = $msg.errorSingular } else { $errText = $msg.errorPlural }
        Write-Host ($globalSymbols.dash + " " + $msg.summaryLine3 + $globalSymbols.colon + " " + $errorCount + " " + $errText) -ForegroundColor Red
        Print-Separator "=" ([Console]::WindowWidth) "Magenta"
        Write-Host ""
         
        try {
            Import-Module BurntToast -ErrorAction Stop
            $notifModule = Join-Path $PSScriptRoot "extras\notifications\notifications.ps1"
            if (Test-Path $notifModule) {
                Import-Module $notifModule -ErrorAction SilentlyContinue
                Show-SuccessNotification -Title $msg.notificationSuccessTitle -Message $msg.notificationSuccessMessage
            }
            else {
                Write-Host $msg.notificationModuleMissing -ForegroundColor Yellow
            }
        }
        catch {
            Write-Host ($msg.errorNotification + $_.Exception.Message) -ForegroundColor Red
        }
    }
}
catch {
    Write-Host ($msg.errorOccurred + $_.Exception.Message) -ForegroundColor Red
    $global:logEntries += [PSCustomObject]@{
        Destination     = $msg.notApplicable
        Subfolder       = $msg.notApplicable
        FileName        = $msg.notApplicable
        OriginalDate    = (Get-Date).ToString("dd-MM-yy HH:mm:ss")
        ReplacementDate = $msg.noExecuted
        State           = $msg.errorOccurred + $_.Exception.Message
    }
}
finally {
    $logModule = Join-Path $PSScriptRoot "extras\Logs\Generate-Logs.ps1"
    if (Test-Path $logModule) {
        . $logModule
        Export-Logs -LogEntries $global:logEntries
    }
    if (-not $AutoMode) {
        Pause
    }
    else {
        exit
    }
}
