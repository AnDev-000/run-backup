# ==============================
# 🚀 RunBackupV2 - Auto Backup Script
# ==============================
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

. "$PSScriptRoot\lang\languages.ps1"
$currentLanguage = "spanish"              # Comentario: se mantiene el idioma en español (solo los mensajes se traducen)
$msg = $languages[$currentLanguage]
# Se asume que $globalSymbols (con keys "bold", "colon", "ellipsis", "folder", "cloud", "warning", "success", "error", "sidekick", "reload", "storage") ya está definido en languages.ps1

# ==============================
# Configuration of Paths (Configuración de rutas)
# ==============================
$sourcePath = "REEMPLAZA_CON_TU_RUTA_DE_ORIGEN"
$destinationPaths = @(
    "REEMPLAZA_CON_TU_RUTA_DE_DESTINO1",
    "REEMPLAZA_CON_TU_RUTA_DE_DESTINO2",
    "REEMPLAZA_CON_TU_RUTA_DE_DESTINO3"
)

$global:logEntries = @()
$global:backupFailures = @()

# ------------------------------------
# Validation and Formatting Functions (Funciones de validación y formateo)
# ------------------------------------
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
    param(
        [datetime]$date,
        [string]$state
    )
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

# Esta función retorna un objeto con Icon y Name para el destino. Se agrega explícitamente dos espacios para los iconos de nube.
function Get-DisplayNameForDestination {
    param(
        [string]$dest,
        [string]$Color = (Get-DestinationColor $dest)
    )
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
    return "{0,-2} {1}" -f $Icon, $Text
}

function Write-IconMessage {
    param(
        [string]$Icon,
        [string]$Text,
        [string]$Color = "White",
        [switch]$NoNewline
    )
    $formatted = Format-IconText $Icon $Text
    if ($NoNewline) { Write-Host $formatted -ForegroundColor $Color -NoNewline } else { Write-Host $formatted -ForegroundColor $Color }
}

function Print-Separator {
    param(
        [string]$Char = "=",
        [int]$Width = [Console]::WindowWidth,
        [string]$Color = "Cyan"
    )
    Write-Host ($Char * $Width) -ForegroundColor $Color
}

function Update-ProgressBar {
    param(
        [string]$Icon,
        [int]$Counter,
        [int]$TotalFiles,
        [int]$BarLength
    )
    $filled = "█" * [Math]::Round(($Counter * $BarLength) / $TotalFiles)
    $empty = " " * ($BarLength - $filled.Length)
    $percent = [Math]::Round(($Counter * 100) / $TotalFiles)
    return ("[{0}{1}] {2,3}% " -f $filled, $empty, $percent) + $msg.progressCompleted
}

# ------------------------------------
# Initial Validations (Validaciones iniciales)
# ------------------------------------
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
        $obj = [PSCustomObject]@{
            Index       = $idx
            Destination = $d
            Color       = $color
        }
        $validDestinations += $obj
    }
    else {
        $destinationWarnings += ($msg.errorInvalidDestination + " '" + $d + "'")
    }
    $idx++
}

# ------------------------------------
# INITIAL PRESENTATION (Presentación inicial)
# ------------------------------------
function Show-InitialPresentation {
    Write-Host ""
    Print-Separator "=" ([Console]::WindowWidth) "Cyan"
    Write-Host ($globalSymbols.bold + $msg.titleAutoBackup + $globalSymbols.bold) -ForegroundColor Cyan
    Print-Separator "=" ([Console]::WindowWidth) "Cyan"
    Write-Host ""
    
    # Mostrar etiqueta "Source:" con colon y el espacio agregado explícitamente
    Write-IconMessage $globalSymbols.folder ($msg.labelSource + $globalSymbols.colon) "Gray"
    Write-Host ""
    if ($sourceError) { $originColor = "Red" } else { $originColor = "White" }
    Write-Host ("   └── " + $sourcePresentation) -ForegroundColor $originColor
    Write-Host ""
    
    # Mostrar etiqueta "Destination(s):" con colon y el espacio agregado explícitamente
    Write-IconMessage $globalSymbols.storage ($msg.destPlural + $globalSymbols.colon) "Gray"
    Write-Host ""
    $i = 1
    foreach ($dest in $destinationPaths) {
        if ($dest -match '^[A-Za-z]:[\\/].+') {
            $obj = $validDestinations | Where-Object { $_.Index -eq $i }
            if ($obj) { $color = $obj.Color } else { $color = Get-DestinationColor $dest }
            $display = Get-DisplayNameForDestination $dest -Color $color
            Write-Host ("{0,2} : {1,-2} {2}" -f $i, $display.Icon, $dest) -ForegroundColor $color
        }
        else {
            Write-Host ("{0,2} : '{1}'" -f $i, $dest) -ForegroundColor "Red"
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
# Fin Show-InitialPresentation

# ------------------------------------
# PROCESSES AND FINAL OUTPUT (Procesos y salida final)
# ------------------------------------
function Copy-WithProgress {
    param(
        [string]$DestinationPath,
        [int]$DestIndex,
        [string]$Color
    )
    if (-not $Color) { $Color = Get-DestinationColor $DestinationPath }
    # Para destinos en la nube, concatenamos 2 espacios al icono (ya que se requiere visualmente)
    $IconForDest = if ($DestinationPath -imatch "OneDrive" -or $DestinationPath -imatch "iCloudDrive") { $globalSymbols.cloud + "  " } else { $globalSymbols.folder }
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
            if (-not (Test-Path $destFolder)) {
                New-Item -Path $destFolder -ItemType Directory -Force | Out-Null
            }
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
            if ($File.DirectoryName.StartsWith($normalizedSource)) {
                $relativeFolder = $File.DirectoryName.Substring($normalizedSource.Length)
            }
            else {
                $relativeFolder = $File.DirectoryName
            }
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
            # Se usa el índice del destino concatenado con dos espacios "  " (ya que eso es lo que se desea) en el progressText
            $progressText = $DestIndex.ToString() + $globalSymbols.colon + " " + $progressBar
            if ($Counter -eq 1) {
                Write-Host $progressText -ForegroundColor $Color
            }
            else {
                $cursorLine = [Console]::CursorTop - 1
                [Console]::SetCursorPosition(0, $cursorLine)
                Write-Host $progressText -ForegroundColor $Color
            }
            Start-Sleep -Milliseconds 20
        }
    }
    catch {
        Write-IconMessage $globalSymbols.warning ("  " + $msg.errorDuringBackup + " " + $DestinationPath + $globalSymbols.colon + " " + $_.Exception.Message) Red
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
        foreach ($warn in $destinationWarnings) {
            Write-Host $warn -ForegroundColor Yellow
        }
        Print-Separator "-" ([Console]::WindowWidth) "Yellow"
    }
}

function Show-BackupCompleted {
    $completedDestinations = @()
    foreach ($obj in $validDestinations) {
        if (-not ($global:backupFailures -contains $obj.Destination)) {
            $completedDestinations += $obj
        }
    }
    if ($completedDestinations.Count -gt 0) {
        if ($destinationWarnings.Count -eq 0) { Print-Separator "-" ([Console]::WindowWidth) "Yellow" }
        Write-Host ($globalSymbols.success + " " + $msg.backupCompletedHeader + $globalSymbols.colon) -ForegroundColor Green
        foreach ($item in $completedDestinations) {
            $display = Get-DisplayNameForDestination $item.Destination -Color $item.Color
            $line = "- " + $msg.destSingular + " " + $item.Index + $globalSymbols.colon + " " + $display.Icon + " " + $display.Name
            Write-Host $line -ForegroundColor $item.Color
        }
        Print-Separator "-" ([Console]::WindowWidth) "Yellow"
    }
}

function Show-ConsolidatedTable {
    param(
        [string]$DestinationPath,
        [array]$Entries
    )
    $obj = $validDestinations | Where-Object { $_.Destination -eq $DestinationPath }
    if ($obj) { $color = $obj.Color } else { $color = Get-DestinationColor $DestinationPath }
    $display = Get-DisplayNameForDestination $DestinationPath -Color $color
    Print-Separator "=" ([Console]::WindowWidth) $display.Color
    Write-Host (Format-IconText $display.Icon ("Destino" + $globalSymbols.colon + " " + $DestinationPath)) -ForegroundColor $display.Color
    Print-Separator "=" ([Console]::WindowWidth) $display.Color
    Write-Host ""
    $headerDateOriginal = $msg.date + " " + $msg.originalLabel
    $headerDateReplacement = $msg.date + " " + $msg.replacementLabel
    $hdr = "{0,-15} {1,-20} {2,-20} {3,-20} {4,-10}" -f $msg.tableHeader1, $msg.tableHeader2, $headerDateOriginal, $headerDateReplacement, $msg.tableHeader5
    Write-Host $hdr -ForegroundColor White
    Print-Separator "-" ([Console]::WindowWidth) $display.Color
    $group = $Entries | Where-Object { $_.Destination -eq $DestinationPath } | Sort-Object Subfolder, FileName
    foreach ($e in $group) {
        $subfolder = if ($e.Subfolder.Length -gt 15) { $e.Subfolder.Substring(0, 12) + $globalSymbols.ellipsis } else { $e.Subfolder }
        $line = "{0,-15} {1,-20} {2,-20} {3,-20} {4,-10}" -f $subfolder, $e.FileName, $e.OriginalDate, $e.ReplacementDate, $e.State
        Write-Host $line -ForegroundColor $display.Color
    }
    Write-Host ""
}

# ----------------------------------------------------
# MAIN FLOW (Flujo principal)
# ----------------------------------------------------
Show-InitialPresentation

if ($sourceError -or ($validDestinations.Count -eq 0)) {
    Print-Separator "=" ([Console]::WindowWidth) "Magenta"
    if ($sourceError) {
        Write-Host ("- " + $msg.labelSource + $globalSymbols.colon + " " + $msg.errorNoSource) -ForegroundColor Red
    }
    if ($validDestinations.Count -eq 0) {
        Write-Host ("- " + $msg.destSingular + $globalSymbols.colon + " " + $msg.errorNoDestination) -ForegroundColor Red
    }
    Print-Separator "=" ([Console]::WindowWidth) "Magenta"
    Write-IconMessage $globalSymbols.sidekick $msg.exitPrompt "Magenta"
    Read-Host | Out-Null
    exit
}

Process-Backup

Show-Warnings
Show-BackupCompleted

foreach ($destObj in $validDestinations) {
    Show-ConsolidatedTable -DestinationPath $destObj.Destination -Entries $global:logEntries
}

$timestamp = (Get-Date).ToString("yyyyMMdd_HHmm")
$logFolder = Join-Path $PSScriptRoot "logs_RunBackupV2"
if (-not (Test-Path $logFolder)) { New-Item $logFolder -ItemType Directory | Out-Null }
$csvFile = Join-Path $logFolder ("runbackup_" + $timestamp + ".csv")
$global:logEntries | Export-Csv -Path $csvFile -NoTypeInformation
$jsonFile = Join-Path $logFolder ("runbackup_" + $timestamp + ".json")
$global:logEntries | ConvertTo-Json -Depth 3 | Out-File $jsonFile -Encoding UTF8

$existingCount = ($global:logEntries | Where-Object { $_.State -eq $msg.state_exists }).Count
$copiedCount = ($global:logEntries | Where-Object { $_.State -eq $msg.state_copied }).Count
$errorCount = $global:backupFailures.Count

Write-Host ""
Print-Separator "=" ([Console]::WindowWidth) "Magenta"
Write-Host ($msg.backupSummary + $globalSymbols.colon) -ForegroundColor White
Write-Host ("  - " + $msg.summaryLine1 + $globalSymbols.colon + " " + $existingCount) -ForegroundColor Yellow
Write-Host ("  - " + $msg.summaryLine2 + $globalSymbols.colon + " " + $copiedCount) -ForegroundColor Green
if ($errorCount -eq 1) { 
    $errText = $msg.errorSingular 
}
else { 
    $errText = $msg.errorPlural 
}
Write-Host ("  - " + $msg.summaryLine3 + $globalSymbols.colon + " " + $errorCount + " " + $errText) -ForegroundColor Red
Print-Separator "=" ([Console]::WindowWidth) "Magenta"
Write-Host ""

Print-Separator "=" ([Console]::WindowWidth) "Magenta"
Write-IconMessage $globalSymbols.sidekick $msg.exitPrompt "Magenta"
Read-Host | Out-Null
