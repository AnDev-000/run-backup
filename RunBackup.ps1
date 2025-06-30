# ===================== SCRIPT PRINCIPAL DE RUNBACKUP =====================

param(
    [switch]$AutoMode
)

# ------------------ RUTAS DE ORIGEN Y DESTINO ------------------
# Ajusta estas rutas antes de ejecutar.
# Ruta de origen
$sourcePath = "REEMPLAZA_CON_TU_RUTA_DE_ORIGEN"

# Ruta(s) de destino(s)
$destinationPaths = @(

    "REEMPLAZA_CON_TU_RUTA_DE_DESTINO",
    "REEMPLAZA_CON_TU_RUTA_DE_DESTINO",
    "REEMPLAZA_CON_TU_RUTA_DE_DESTINO"


)

# ------------------ CARGA DE TEXTOS ------------------
. "$PSScriptRoot\Lang\Languages.ps1"
$currentLanguage = "spanish"  # Optiones: "spanish", "english", japanese, german, chinese...
$msg = $languages[$currentLanguage]

# ------------------ IMPORTACIÓN DE MÓDULOS: NOTIFICATIONS Y LOGGING ------------------
$routeWarnings = @()       # Advertencias de rutas
$moduleWarnings = @()       # Advertencias de módulos
$notificationQueue = @()       # Cola de notificaciones (Windows Toast)
$logWarningEnqueued = $false    # Para evitar duplicar notificaciones de logs

$NotificationsModuleAvailable = $true
$notifManifest = Join-Path $PSScriptRoot "Modules\Notifications\Notifications.psm1"
if (Test-Path $notifManifest) {
    Import-Module $notifManifest -DisableNameChecking -Force -ErrorAction Stop
    # Verificar existencia de Installer\Setup.ps1:
    $installerSetup = Join-Path $PSScriptRoot "Installer\Setup.ps1"
    if (-not (Test-Path $installerSetup)) {
        if (-not (Get-Module -ListAvailable -Name BurntToast)) {
            $NotificationsModuleAvailable = $false
            $moduleWarnings += ($globalSymbols.dash + " " + $msg.notificationsLabel + $globalSymbols.colon + " " + $msg.notificationInstallerMissing)
        }
    }
}
else {
    $NotificationsModuleAvailable = $false
    $moduleWarnings += ($globalSymbols.dash + " " + $msg.notificationsLabel + $globalSymbols.colon + " " + $msg.notificationModuleMissing)
}

$LogsModuleAvailable = $true
$logManifest = Join-Path $PSScriptRoot "Modules\Logging\Logging.psd1"
if (Test-Path $logManifest) {
    Import-Module $logManifest -DisableNameChecking -Force -ErrorAction Stop
}
else {
    $LogsModuleAvailable = $true
    $moduleWarnings += ($globalSymbols.dash + " " + $msg.logLabel + $globalSymbols.colon + " " + $msg.logModuleMissing)
    if ($NotificationsModuleAvailable -and -not $logWarningEnqueued) {
        $notificationQueue += { Show-WarningNotification -TitleKey ($msg.notificationLogErrorTitle) -MessageKey $msg.logModuleMissing }
        $logWarningEnqueued = $true
    }
}

# ------------------ WRAPPERS DE NOTIFICACIONES ------------------
if ($NotificationsModuleAvailable) {
    if (-not (Get-Command Show-ErrorNotification -ErrorAction SilentlyContinue)) {
        function Show-ErrorNotification {
            param(
                [string]$TitleKey,
                [string]$MessageKey
            )
            Send-ErrorNotification -TitleKey $TitleKey -MessageKey $MessageKey
        }
    }
    if (-not (Get-Command Show-WarningNotification -ErrorAction SilentlyContinue)) {
        function Show-WarningNotification {
            param(
                [string]$TitleKey,
                [string]$MessageKey
            )
            Send-WarningNotification -TitleKey $TitleKey -MessageKey $MessageKey
        }
    }
    if (-not (Get-Command Show-SuccessNotification -ErrorAction SilentlyContinue)) {
        function Show-SuccessNotification {
            param(
                [string]$TitleKey,
                [string]$MessageKey
            )
            Send-SuccessNotification -TitleKey $TitleKey -MessageKey $MessageKey
        }
    }
}
else {
    function Show-ErrorNotification { }
    function Show-WarningNotification { }
    function Show-SuccessNotification { }
}

# ------------------ VARIABLES GLOBALES ------------------
# Variable para almacenar entradas de registro.
$global:logEntries = @()
# Variable para almacenar archivos que fallaron al respaldar.
$global:backupFailures = @()
# Variable para almacenar índices de destinos inválidos.
$invalidDestIndexes = @()
# Variable para almacenar destinos que fallaron al escribir.
$global:destinationFailures = @()

# ------------------ FUNCIONES DE UTILIDAD ------------------

function Get-DestinationColor {
    param([string]$dest)
    # Para destinos de nube se asignan colores fijos
    if ($dest -imatch "OneDrive") { 
        return "Blue" 
    }
    elseif ($dest -imatch "iCloudDrive") { 
        return "Cyan" 
    }
    else {
        # Para destinos no nube se escoge un color aleatorio sin incluir rojo
        $cols = @("Yellow", "Magenta", "DarkYellow", "White", "Blue", "Green")
        return $cols[(Get-Random -Maximum $cols.Count)]
    }
}

function Print-Separator {
    param(
        [string]$Char = "=",
        [int]$Width = [Console]::WindowWidth,
        [string]$Color = "Cyan"
    )
    Write-Host ($Char * $Width) -ForegroundColor $Color
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
    param(
        [string]$Icon,
        [string]$Text,
        [string]$Color = "White",
        [switch]$NoNewline
    )
    if ($Icon -eq $globalSymbols.warning) { $Icon = $Icon + " " }
    $formatted = Format-IconText $Icon $Text
    if ($NoNewline) { Write-Host $formatted -ForegroundColor $Color -NoNewline }
    else { Write-Host $formatted -ForegroundColor $Color }
}

function Update-ProgressBar {
    param(
        [string]$Icon,
        [int]$Counter,
        [int]$TotalFiles,
        [int]$BarLen
    )
    $filled = "█" * [math]::Round(($Counter * $BarLen) / $TotalFiles)
    $empty = " " * ($BarLen - $filled.Length)
    $pct = [math]::Round(($Counter * 100) / $TotalFiles)
    return ("[" + $filled + $empty + "] " + $pct + "% " + $msg.progressCompleted)
}

function Truncate-Text {
    param(
        [Parameter(Mandatory = $true)][string]$text,
        [Parameter(Mandatory = $true)][int]$maxLength
    )
    if ($text.Length -gt $maxLength) { return $text.Substring(0, $maxLength - 3) + "..." }
    else { return $text }
}

# ------------------ VALIDACIONES INICIALES ------------------
$sourceError = $false
if (($sourcePath -eq $null) -or ([string]::IsNullOrWhiteSpace($sourcePath))) {
    $sourceError = $true
    $sourcePresentation = $msg.errorNoSource
}
elseif ($sourcePath -is [array]) {
    if ($sourcePath.Count -gt 1) {
        $sourceError = $true
        $sourcePresentation = $msg.errorMultipleSource
    }
    elseif ([string]::IsNullOrWhiteSpace($sourcePath[0])) {
        $sourceError = $true
        $sourcePresentation = $msg.errorNoSource
    }
    else {
        $sourcePresentation = $sourcePath[0]
    }
}
elseif (-not (Test-Path $sourcePath)) {
    $sourceError = $true
    $sourcePresentation = $msg.errorNoSource
}
else {
    $sourcePresentation = $sourcePath
}

$destinationWarnings = @()
$validDestinations = @()
$idx = 1
foreach ($d in $destinationPaths) {
    if ($d -match '^[A-Za-z]:[\\/].+') {
        $color = Get-DestinationColor $d
        $obj = [PSCustomObject]@{ Index = $idx; Destination = $d; Color = $color }
        $validDestinations += $obj
    }
    else {
        $destinationWarnings += ($globalSymbols.dash + " " + $msg.destination.label.singular + " " + $idx.ToString() + $globalSymbols.colon + " " + $msg.errorInvalidDestination)
        $invalidDestIndexes += $idx
    }
    $idx++
}

# ------------------ PRESENTACIÓN INICIAL ------------------
function Show-InitialPresentation {
    Write-Host ""
    Print-Separator "=" ([Console]::WindowWidth) "Cyan"
    Write-Host ($globalSymbols.bold + $msg.titleAutoBackup + $globalSymbols.bold) -ForegroundColor Cyan
    Print-Separator "=" ([Console]::WindowWidth) "Cyan"
    Write-Host ""
    
    Write-IconMessage $globalSymbols.folder ($msg.labelSource + $globalSymbols.colon) "Gray"
    Write-Host ""
    if ($sourceError) { $originColor = "Red" } else { $originColor = "White" }
    Write-Host ("   └─" + $globalSymbols.folder + " " + $sourcePresentation) -ForegroundColor $originColor
    Write-Host ""
    
    Write-IconMessage $globalSymbols.storage ($msg.destination.label.plural + $globalSymbols.colon) "Gray"
    Write-Host ""
    for ($j = 0; $j -lt $destinationPaths.Count; $j++) {
        if ($destinationPaths[$j] -match '^[A-Za-z]:[\\/].+') {
            $destObj = $validDestinations | Where-Object { $_.Destination -eq $destinationPaths[$j] }
            $display = Get-DisplayNameForDestination $destinationPaths[$j] -Color $destObj.Color
            Write-Host ((($j + 1).ToString() + $globalSymbols.colon + " " + $display.Icon + " " + $destinationPaths[$j])) -ForegroundColor $destObj.Color
        }
        else {
            Write-Host ((($j + 1).ToString() + $globalSymbols.colon + " " + $globalSymbols.error + " '" + $destinationPaths[$j] + "'")) -ForegroundColor Red
        }
    }
    Write-Host ""
    Print-Separator "-" ([Console]::WindowWidth) "Yellow"
    Write-Host ""
}

# ------------------ PROCESO DE RESPALDO (BARRA DE PROGRESO) ------------------
function Copy-WithProgress {
    param(
        [string]$DestinationPath,
        [int]$DestIndex,
        [string]$Color
    )
    if ($DestinationPath -imatch "OneDrive" -or $DestinationPath -imatch "iCloudDrive") {
        $IconForDest = $globalSymbols.cloud + " "
    }
    else {
        $IconForDest = $globalSymbols.folder
    }
    $Files = Get-ChildItem -Path $sourcePath -Recurse -File
    $TotalFiles = $Files.Count
    if ($TotalFiles -eq 0) {
        Write-Host $msg.noFilesFound -ForegroundColor Red
        return
    }
    
    try {
        $tempTestDir = Join-Path $DestinationPath "temp_test_dir"
        New-Item -Path $tempTestDir -ItemType Directory -Force -ErrorAction Stop | Out-Null
        Remove-Item -Path $tempTestDir -Force -Recurse -ErrorAction SilentlyContinue
    }
    catch {
        foreach ($File in $Files) {
            $sourceTime = $File.LastWriteTime
            if ($File.DirectoryName.StartsWith($sourcePath.TrimEnd('\', '/') + "\")) {
                $relativeFolder = $File.DirectoryName.Substring(($sourcePath.TrimEnd('\', '/') + "\").Length)
            }
            else {
                $relativeFolder = $File.DirectoryName
            }
            $logEntry = [PSCustomObject]@{
                Destination     = $DestinationPath
                Subfolder       = $relativeFolder
                FileName        = $File.Name
                OriginalDate    = $sourceTime.ToString("dd-MM-yy HH:mm:ss")
                ReplacementDate = $msg.noExecuted
                State           = $msg.state_not_copied
            }
            $global:logEntries += $logEntry
            $global:backupFailures += $File.FullName
        }
        $global:destinationFailures += $DestinationPath
        return
    }
    
    $Counter = 0
    $BarLength = 40
    $normalizedSource = $sourcePath.TrimEnd('\', '/') + "\"
    
    foreach ($File in $Files) {
        try {
            $sourceTime = $File.LastWriteTime
            $fullDestPath = $File.FullName.Replace($sourcePath, $DestinationPath)
            $destFolder = Split-Path -Path $fullDestPath -Parent
            if (-not (Test-Path $destFolder)) {
                New-Item -Path $destFolder -ItemType Directory -Force -ErrorAction Stop | Out-Null
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
        }
        catch {
            Write-IconMessage $globalSymbols.warning (" " + $msg.errorDuringBackup + " " + $DestinationPath + $globalSymbols.colon + " " + $_.Exception.Message) Red
            $global:backupFailures += $File.FullName
        }
        $Counter++
        $progressBar = Update-ProgressBar $IconForDest $Counter $TotalFiles $BarLength
        $progressText = $DestIndex.ToString() + $globalSymbols.colon + " " + $IconForDest + " " + $progressBar
        if ($Counter -eq 1) {
            Write-Host $progressText -ForegroundColor $Color
        }
        else {
            [Console]::SetCursorPosition(0, [Console]::CursorTop - 1)
            Write-Host $progressText -ForegroundColor $Color
        }
        Start-Sleep -Milliseconds 20
    }
}

function Process-Backup {
    foreach ($obj in $validDestinations) {
        Copy-WithProgress -DestinationPath $obj.Destination -DestIndex $obj.Index -Color $obj.Color
        Write-Host ""
    }
}

# ------------------ MOSTRAR ADVERTENCIAS ------------------
function Show-Warnings {
    if ($destinationWarnings.Count -gt 0) {
        Print-Separator "-" ([Console]::WindowWidth) "Yellow"
        Write-Host ($globalSymbols.warning + "  " + $msg.warningText + $globalSymbols.colon) -ForegroundColor Yellow
        foreach ($warn in $destinationWarnings) {
            Write-Host $warn -ForegroundColor Red
        }
        Print-Separator "-" ([Console]::WindowWidth) "Yellow"
    }
}

# ------------------ MOSTRAR RESUMEN Y TABLA CONSOLIDADA ------------------
function Show-BackupCompleted {
    $completedDestinations = @()
    foreach ($obj in $validDestinations) {
        if (-not ($global:backupFailures -contains $obj.Destination)) {
            if (-not ($global:destinationFailures -contains $obj.Destination)) {
                $completedDestinations += $obj
            }
        }
    }
    if ($completedDestinations.Count -gt 0) {
        if (($destinationWarnings.Count + $global:destinationFailures.Count) -eq 0) {
            Print-Separator "-" ([Console]::WindowWidth) "Yellow"
        }
        Write-Host ($msg.labelBackupCompleted + $globalSymbols.colon) -ForegroundColor Green
        foreach ($item in $completedDestinations) {
            $display = Get-DisplayNameForDestination $item.Destination -Color $item.Color
            Write-Host ($globalSymbols.dash + " " + $msg.destination.label.singular + " " +
                $item.Index.ToString() + $globalSymbols.colon + " " +
                $display.Icon + " " + $display.Name) -ForegroundColor $item.Color
        }
        Print-Separator "-" ([Console]::WindowWidth) "Yellow"
    }
}

function Show-ConsolidatedTable {
    param(
        [string]$DestinationPath,
        [array]$Entries
    )
    $destObj = $validDestinations | Where-Object { $_.Destination -eq $DestinationPath } | Select-Object -First 1
    if ($destObj) {
        $color = $destObj.Color  # Usamos el color asignado al destino
        $headerDestino = $msg.destination.label.singular + " " + $destObj.Index.ToString() +
        $globalSymbols.colon + " " + $DestinationPath
    }
    else {
        $color = "White"
        $headerDestino = $msg.destination.label.singular + $globalSymbols.colon + " " + $DestinationPath
    }
    Print-Separator "=" ([Console]::WindowWidth) $color
    $display = Get-DisplayNameForDestination $DestinationPath -Color $color
    Write-Host (Format-IconText $display.Icon $headerDestino) -ForegroundColor $color
    Print-Separator "=" ([Console]::WindowWidth) $color
    Write-Host ""
    
    $destEntries = $Entries | Where-Object { $_.Destination -eq $DestinationPath }
    if ($destEntries.Count -eq 0) { return }
    
    $col1Width = 15; $col2Width = 20; $col3Width = 20; $col4Width = 20; $col5Width = 10
    $col1 = $msg.tableHeader1.PadRight($col1Width)
    $col2 = $msg.tableHeader2.PadRight($col2Width)
    $col3 = ($msg.date + " " + $msg.originalLabel).PadRight($col3Width)
    $col4 = ($msg.date + " " + $msg.replacementLabel).PadRight($col4Width)
    $col5 = $msg.tableHeader5.PadRight($col5Width)
    $hdr = "$col1 $col2 $col3 $col4 $col5"
    Write-Host $hdr -ForegroundColor $color
    Print-Separator "-" ([Console]::WindowWidth) $color
    foreach ($e in ($destEntries | Sort-Object Subfolder, FileName)) {
        $c1 = (Truncate-Text -text $e.Subfolder -maxLength $col1Width).PadRight($col1Width)
        $c2 = (Truncate-Text -text $e.FileName -maxLength $col2Width).PadRight($col2Width)
        $c3 = $e.OriginalDate.PadRight($col3Width)
        $c4 = $e.ReplacementDate.PadRight($col4Width)
        $linePart = "$c1 $c2 $c3 $c4"
        if ($e.State -eq $msg.state_not_copied) {
            Write-Host "$linePart " -NoNewline -ForegroundColor $color
            Write-Host ($e.State.PadRight($col5Width)) -ForegroundColor Red
        }
        else {
            $c5 = $e.State.PadRight($col5Width)
            Write-Host "$linePart $c5" -ForegroundColor $color
        }
    }
    Write-Host ""
}

# ------------------ WAIT-FOR-KEYPRESS ------------------
function Wait-ForKeyPress {
    Write-Host $msg.exitPrompt -ForegroundColor White
    [void][System.Console]::ReadKey($true)
}

# ------------------ BLOQUE PRINCIPAL ------------------
try {
    Show-InitialPresentation
    
    $TestFiles = Get-ChildItem -Path $sourcePath -Recurse -File -ErrorAction SilentlyContinue
    if ($TestFiles.Count -eq 0) {
        $destinationWarnings += ($globalSymbols.dash + " " + "Origen" + $globalSymbols.colon + " " + $msg.notificationNoFilesMessage)
        if ($NotificationsModuleAvailable) {
            $notificationQueue += { Show-WarningNotification -TitleKey "notificationNoFilesTitle" -MessageKey $msg.notificationNoFilesMessage }
        }
        $proceed = $false
    }
    else {
        $proceed = $true
    }
    
    if ($sourceError -or ($validDestinations.Count -eq 0)) {
        Print-Separator "=" ([Console]::WindowWidth) "Magenta"
        if ($sourceError) {
            Write-Host ($globalSymbols.dash + " " + $msg.labelSource + $globalSymbols.colon + " " + $msg.errorNoSource) -ForegroundColor Red
        }
        if ($validDestinations.Count -eq 0) {
            Write-Host ($globalSymbols.dash + " " + $msg.destination.label.singular + "1" + $globalSymbols.colon + " " + $msg.errorNoDestination) -ForegroundColor Red
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
        if ($proceed -eq $true) { Process-Backup }
        
        if ($global:destinationFailures.Count -gt 0) {
            foreach ($dest in $global:destinationFailures) {
                $obj = $validDestinations | Where-Object { $_.Destination -eq $dest }
                if ($obj) {
                    $destinationWarnings += ($globalSymbols.dash + " " + $msg.destination.label.singular + " " +
                        $obj.Index.ToString() + $globalSymbols.colon + " " + $msg.notificationDestinationNotWritableMessage)
                }
            }
        }
        
        if (-not (Test-Path (Join-Path $PSScriptRoot "Modules\Logging\Logging.psd1"))) {
            if ($NotificationsModuleAvailable -and -not $logWarningEnqueued) {
                $notificationQueue += { Show-WarningNotification -TitleKey "notificationLogErrorTitle" -MessageKey $msg.logModuleMissing }
                $logWarningEnqueued = $true
            }
        }
        
        foreach ($w in $moduleWarnings) {
            $destinationWarnings += $w
        }
        
        Show-Warnings
        
        if ($proceed -eq $true) {
            Show-BackupCompleted
            foreach ($destObj in $validDestinations) {
                Show-ConsolidatedTable -DestinationPath $destObj.Destination -Entries $global:logEntries
            }
            
            $existingCount = ($global:logEntries | Where-Object { $_.State -eq $msg.state_exists }).Count
            $copiedCount = ($global:logEntries | Where-Object { $_.State -eq $msg.state_copied }).Count
            $failureCount = $global:backupFailures.Count
            $errText = if ($failureCount -eq 1) { $msg.error.singular } else { $msg.error.plural }
            
            Write-Host ""
            Print-Separator "=" ([Console]::WindowWidth) "Magenta"
            Write-Host ($msg.backupSummary + $globalSymbols.colon) -ForegroundColor White
            Write-Host ($globalSymbols.dash + " " + $msg.summaryLine1 + $globalSymbols.colon + " " + $existingCount) -ForegroundColor Yellow
            Write-Host ($globalSymbols.dash + " " + $msg.summaryLine2 + $globalSymbols.colon + " " + $copiedCount) -ForegroundColor Green
            Write-Host ($globalSymbols.dash + " " + $msg.summaryLine3 + $globalSymbols.colon + " " + $failureCount + " " + $errText) -ForegroundColor Red
            Print-Separator "=" ([Console]::WindowWidth) "Magenta"
            Write-Host ""
        }
    }
    
    try {
        if ($sourceError) {
            if ($sourcePath -is [array]) {
                $notificationQueue += { Show-ErrorNotification -TitleKey "notificationInvalidSourceTitle" -MessageKey $msg.notificationInvalidSourceMessage }
            }
            else {
                $notificationQueue += { Show-ErrorNotification -TitleKey "notificationNoSourceTitle" -MessageKey $msg.notificationNoSourceMessage }
            }
        }
        elseif (($validDestinations.Count) -eq 0) {
            $notificationQueue += { Show-ErrorNotification -TitleKey "notificationNoDestinationTitle" -MessageKey $msg.notificationNoDestinationMessage }
        }
        
        if ($invalidDestIndexes.Count -gt 0 -and $NotificationsModuleAvailable) {
            $indicesStr = $invalidDestIndexes -join ", "
            if ($invalidDestIndexes.Count -eq 1) {
                $message = $msg.destination.label.singular + $globalSymbols.colon + " " + $indicesStr + $msg.notificationInvalidDestination.message.singular
            }
            else {
                $message = $msg.destination.label.plural + $globalSymbols.colon + " " + $indicesStr + $msg.notificationInvalidDestination.message.plural
            }
            $notificationQueue += { Show-WarningNotification -TitleKey ($msg.notificationInvalidDestination.title) -MessageKey $message }
        }
        
        if (($proceed -eq $true) -and ($global:backupFailures.Count -gt 0)) {
            $notificationQueue += { Show-WarningNotification -TitleKey "notificationPartialSuccessTitle" -MessageKey $msg.notificationPartialSuccessMessage }
        }
        if (($proceed -eq $true) -and ($global:backupFailures.Count -eq 0)) {
            $summaryText = "`n- " + $msg.summaryLine1 + $globalSymbols.colon + " " + $existingCount + "`n" +
            "- " + $msg.summaryLine2 + $globalSymbols.colon + " " + $copiedCount + "`n" +
            "- " + $msg.summaryLine3 + $globalSymbols.colon + " " + $failureCount
            $notificationQueue += { Show-SuccessNotification -TitleKey "notificationSuccessTitle" -MessageKey ($msg.notificationSuccessMessage + $summaryText) }
        }
    }
    catch {
        Write-Host ($msg.errorNotification + $_.Exception.Message) -ForegroundColor Red
    }
    
    if ($notificationQueue.Count -gt 0) {
        foreach ($n in $notificationQueue) {
            & $n
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
    $tempLogModule2 = Join-Path $PSScriptRoot "Modules\Logging\Logging.psd1"
    if ((Test-Path $tempLogModule2) -and ($global:logEntries.Count -gt 0)) {
        Export-Logs -LogEntries $global:logEntries
    }
    Wait-ForKeyPress
}
