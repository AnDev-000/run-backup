# ==============================
# 🚀 RunBackupV2 - Auto Backup Script
# ==============================

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

. "$PSScriptRoot\lang\languages.ps1"
# Selecciona: "spanish", "english", "japanese" o "german"
$language = "english"
$msg = $languages[$language]

# ==============================
# 🔧 Configuración de rutas
# ==============================
$SourcePath = "REEMPLAZA_CON_TU_RUTA_DE_ORIGEN"

$DestinationPaths = @(
    "REEMPLAZA_CON_TU_RUTA_DE_DESTINO1",
    "REEMPLAZA_CON_TU_RUTA_DE_DESTINO2",
    "REEMPLAZA_CON_TU_RUTA_DE_DESTINO3"
)

# ----------------------------------------------------
# Funciones de validación y formateo básico
# ----------------------------------------------------
function Validar-Ruta ($ruta) {
    return ($ruta -match '^[A-Za-z]:[\\/].+') -and (Test-Path $ruta)
}

function Get-DestinationColor ($Destino) {
    if ($Destino -match "OneDrive") { return "Blue" }
    elseif ($Destino -match "iCloudDrive") { return "Cyan" }
    else {
        $colors = @("Yellow", "Magenta", "DarkYellow", "Green", "White")
        return $colors[(Get-Random -Maximum $colors.Count)]
    }
}

function Center-TextLines {
    param([string]$text)
    $width = [Console]::WindowWidth
    $lines = $text -split "`n"
    $centeredLines = foreach ($line in $lines) {
        $trim = $line.TrimEnd()
        $pad = [Math]::Floor(($width - $trim.Length) / 2)
        if ($pad -lt 0) { $pad = 0 }
        (" " * $pad) + $trim
    }
    return $centeredLines -join "`n"
}

# ----------------------------------------------------
# Funciones para formateo centralizado de íconos y mensajes
# ----------------------------------------------------
<#
    Format-IconText:
    Une un ícono y un texto usando composite formatting.
    El placeholder "{0,-2}" imprime el ícono en un campo de 2 caracteres (alineado a la izquierda)
    y deja un espacio fijo entre el ícono y el texto.
#>
function Format-IconText {
    param(
        [string]$Icon,
        [string]$Text
    )
    return "{0,-2} {1}" -f $Icon, $Text
}

function Write-IconMessage {
    param (
        [string]$Icon,
        [string]$Message,
        [string]$Color = "White",
        [switch]$NoNewline
    )
    $formatted = Format-IconText $Icon $Message
    if ($NoNewline) {
        Write-Host $formatted -ForegroundColor $Color -NoNewline
    }
    else {
        Write-Host $formatted -ForegroundColor $Color
    }
}

function Format-Message {
    param (
        [string]$Prefix,
        [string]$Message
    )
    return "{0} {1}" -f $Prefix, $Message
}

function Write-ErrorMessage {
    param(
        [string]$Message
    )
    Write-Host ("- {0}" -f $Message) -ForegroundColor Red
}

# ----------------------------------------------------
# Funciones de soporte gráfico
# ----------------------------------------------------
function Print-Separator {
    param(
        [string]$Char = "=",
        [int]$Width = [Console]::WindowWidth,
        [string]$Color = "Cyan"
    )
    $sep = $Char * $Width
    Write-Host $sep -ForegroundColor $Color
}

function Get-DisplayNameForDestination {
    param ([string]$Destination)
    if ($Destination -match "OneDrive") {
        return @{ Icon = "☁"; Name = "OneDrive"; Color = "Blue" }
    }
    elseif ($Destination -match "iCloudDrive") {
        return @{ Icon = "☁"; Name = "iCloudDrive"; Color = "Cyan" }
    }
    else {
        $name = Split-Path -Path $Destination -Leaf
        return @{ Icon = "📂"; Name = $name; Color = (Get-DestinationColor $Destination) }
    }
}

function Update-ProgressBar {
    param(
        [string]$Icon,
        [int]$Counter,
        [int]$TotalFiles,
        [int]$BarLength
    )
    $ProgressBar = "█" * [Math]::Round(($Counter * $BarLength) / $TotalFiles)
    $Spaces = " " * ($BarLength - $ProgressBar.Length)
    $percentage = [Math]::Round(($Counter * 100) / $TotalFiles)
    return ("{0,-2} [{1}{2}] {3,3}% " -f $Icon, $ProgressBar, $Spaces, $percentage) + $msg.progressCompleted
}

# ----------------------------------------------------
# Agrupación de secciones
# ----------------------------------------------------
# Variables para la validación de rutas de origen/destino
$sourceError = $false
if ($SourcePath -is [array]) {
    $sourceError = $true
    $sourceErrorMsg = $msg.errorMultipleSource
    $origenPresentation = ($SourcePath -join " ")
}
elseif (-not (Validar-Ruta $SourcePath)) {
    $sourceError = $true
    $sourceErrorMsg = $msg.errorNoSource
    $origenPresentation = $SourcePath
}
else {
    $origenPresentation = $SourcePath
}

$DestinosValidos = @()
$destWarnings = @()
$contador = 1
foreach ($dest in $DestinationPaths) {
    if (Validar-Ruta $dest) {
        $DestinosValidos += $dest
    }
    else {
        # Se arma el mensaje de advertencia usando las claves definidas en language.ps1
        $warnMsg = ("{0} {1}: {2}" -f $msg.destination, $contador, $msg.warningInvalidDestination)
        $destWarnings += $warnMsg
    }
    $contador++
}

# Para mantener la coherencia, se determina el color asignado
$DestinoColores = @{}
foreach ($dest in $DestinosValidos) {
    $DestinoColores[$dest] = Get-DestinationColor $dest
}

# ----------------------------------------------------
# Sección 1: Presentación inicial (cabeceras, origen y lista de destinos)
# ----------------------------------------------------
function Show-InitialPresentation {
    Write-Host ""
    Print-Separator "=" ([Console]::WindowWidth) "Cyan"
    Write-IconMessage "🔹" $msg.titleAutoBackup "Cyan"
    Print-Separator "=" ([Console]::WindowWidth) "Cyan"

    # Origen
    if ($sourceError) { $origenColor = "Red" } else { $origenColor = "White" }
    Write-Host ""
    Write-IconMessage "📂" $msg.labelSource "Gray"
    Write-Host ""
    Write-Host ("   └── {0}" -f $origenPresentation) -ForegroundColor $origenColor

    # Destinos: Mostrar TODAS las rutas en el orden original con numeración
    Write-Host ""
    Write-IconMessage "💾" $msg.labelDestination "Gray"
    Write-Host ""
    for ($i = 0; $i -lt $DestinationPaths.Count; $i++) {
        $dest = $DestinationPaths[$i]
        $index = $i + 1
        if (Validar-Ruta $dest) {
            $display = Get-DisplayNameForDestination $dest
            # Se usa el color asignado de forma central
            $destColor = $DestinoColores[$dest]
            $line = "{0,2} : {1,-2} {2}" -f $index, $display.Icon, $dest
            Write-Host $line -ForegroundColor $destColor
        }
        else {
            $line = "{0,2} : '{1}'" -f $index, $dest
            Write-Host $line -ForegroundColor "Red"
        }
    }
    # Separador entre la lista de destinos y las barras de progreso, con un único salto de línea justo después.
    Write-Host ""
    Print-Separator "-" ([Console]::WindowWidth) "Yellow"
    Write-Host ""
}

# ----------------------------------------------------
# Función para realizar el respaldo en cada destino
# ----------------------------------------------------
function Copy-WithProgress {
    param(
        [string]$DestinationPath
    )
    $Color = $DestinoColores[$DestinationPath]
    $IconoDestino = if ($DestinationPath -match "OneDrive" -or $DestinationPath -match "iCloudDrive") { "☁" } else { "📂" }
    $CloudName = if ($DestinationPath -match "OneDrive") { "OneDrive" }
    elseif ($DestinationPath -match "iCloudDrive") { "iCloudDrive" }
    else { Split-Path -Path $DestinationPath -Leaf }
    
    $Files = Get-ChildItem -Path $SourcePath -Recurse
    $TotalFiles = $Files.Count
    if ($TotalFiles -eq 0) {
        Write-Host $msg.noFilesFound -ForegroundColor Red
        return
    }
    $Counter = 0
    $BarLength = 40

    try {
        foreach ($File in $Files) {
            $DestinoCompleto = $File.FullName.Replace($SourcePath, $DestinationPath)
            $DestinoCarpeta = Split-Path -Path $DestinoCompleto -Parent
            if (-not (Test-Path $DestinoCarpeta)) {
                try { New-Item -Path $DestinoCarpeta -ItemType Directory -Force | Out-Null }
                catch { continue }
            }
            $FechaAnterior = if (Test-Path $DestinoCompleto) { (Get-Item $DestinoCompleto).LastWriteTime } else { "No available" }
            Copy-Item -Path $File.FullName -Destination $DestinoCompleto -Force
            $FechaNueva = (Get-Item $DestinoCompleto).LastWriteTime

            # Registro de archivo modificado
            if (-not $ArchivosModificados.ContainsKey($CloudName)) {
                $ArchivosModificados[$CloudName] = @{}
            }
            if (-not $ArchivosModificados[$CloudName].ContainsKey($DestinoCarpeta)) {
                $ArchivosModificados[$CloudName][$DestinoCarpeta] = @()
            }
            $entry = @{
                Archivo    = $File.Name;
                FechaAntes = if ($FechaAnterior -is [string]) { $FechaAnterior } else { $FechaAnterior.ToString("dd-MM-yy HH:mm:ss") };
                FechaAhora = if ($FechaNueva -is [string]) { $FechaNueva } else { $FechaNueva.ToString("dd-MM-yy HH:mm:ss") }
            }
            $ArchivosModificados[$CloudName][$DestinoCarpeta] += $entry

            $Counter++
            $progressText = Update-ProgressBar $IconoDestino $Counter $TotalFiles $BarLength
            if ($Counter -eq 1) {
                # Imprime la primera barra para el destino sin salto adicional
                Write-Host $progressText -ForegroundColor $Color
            }
            else {
                $cursorLine = [Console]::CursorTop - 1
                [Console]::SetCursorPosition(0, $cursorLine)
                Write-Host $progressText -ForegroundColor $Color
            }
            Start-Sleep -Milliseconds 20
        }
        # No se imprime salto extra aquí.
    }
    catch {
        Write-Host ""
        Write-IconMessage "⚠" ($msg.errorDuringBackup + " $($CloudName): $($_.Exception.Message)") Red
        $RespaldoFallido += $DestinationPath
    }
}

function Process-Backup {
    foreach ($Destino in $DestinosValidos) {
        Copy-WithProgress $Destino
        # Agregar un único salto de línea después de cada destino
        Write-Host ""
    }
}

# ----------------------------------------------------
# Función para mostrar resultados y resumen final
# ----------------------------------------------------
function Show-BackupResults {
    Print-Separator "-" ([Console]::WindowWidth) "Yellow"
    
    # Mostrar advertencias (rutas inválidas) DESPUÉS de las barras de progreso
    if ($destWarnings.Count -gt 0) {
        Write-Host ""
        Write-IconMessage "⚠" $msg.warningLabel "Yellow"
        foreach ($warn in $destWarnings) {
            Write-Host $warn -ForegroundColor "Yellow"
        }
        Write-Host ""
        # Separador entre advertencias y respaldo completado
        Print-Separator "-" ([Console]::WindowWidth) "Yellow"
    }
    
    Write-Host ""
    Write-IconMessage "✅" $msg.labelBackupCompleted "Green"
    # Lista final de destinos procesados (solo válidos) en formato resumido
    for ($i = 0; $i -lt $DestinationPaths.Count; $i++) {
        $dest = $DestinationPaths[$i]
        if (Validar-Ruta $dest) {
            $display = Get-DisplayNameForDestination $dest
            $destColor = $DestinoColores[$dest]
            $linePrefix = ("- {0} {1}:" -f $msg.destination, ($i + 1)) + " "
            $lineDetail = Format-IconText $display.Icon $display.Name
            Write-Host ($linePrefix + $lineDetail) -ForegroundColor $destColor
        }
    }
    
    # Separador extra entre la sección de "Backup completed" y la tabla de archivos modificados.
    Write-Host ""
    Print-Separator "-" ([Console]::WindowWidth) "Yellow"
    Write-Host ""
    
    # Mostrar archivos respaldados agrupados por destino (tabla)
    if ($ArchivosModificados.Keys.Count -gt 0) {
        foreach ($cloudName in $ArchivosModificados.Keys) {
            if ($cloudName -eq "OneDrive") {
                $modColor = "Blue"; $icon = "☁"
            }
            elseif ($cloudName -eq "iCloudDrive") {
                $modColor = "Cyan"; $icon = "☁"
            }
            else {
                $modColor = $null
                foreach ($dest in $DestinationPaths) {
                    if ((Split-Path -Leaf $dest) -eq $cloudName) {
                        $modColor = $DestinoColores[$dest]
                        break
                    }
                }
                if (-not $modColor) { $modColor = "Green" }
                $icon = "📂"
            }
            Write-Host ""
            $headerText = Format-IconText $icon ("{0} {1}:" -f $msg.modifiedFilesLabel, $cloudName)
            Write-Host $headerText -ForegroundColor $modColor
            Print-Separator "-" 50 $modColor
            
            foreach ($folder in $ArchivosModificados[$cloudName].Keys) {
                $folderName = Split-Path -Leaf $folder
                if ($cloudName -eq "OneDrive" -or $cloudName -eq "iCloudDrive") {
                    $folderIcon = "☁"
                }
                else {
                    $folderIcon = "📂"
                }
                Write-Host ""
                $folderLine = Format-IconText $folderIcon ("{0} {1}" -f $msg.folderLabel, $folderName)
                Write-Host $folderLine -ForegroundColor $modColor
                Print-Separator "-" 50 $modColor
                Write-Host $msg.tableHeader -ForegroundColor "White"
                Print-Separator "-" 50 $modColor
                foreach ($entry in $ArchivosModificados[$cloudName][$folder]) {
                    "{0,-40} {1,-25} {2,-25}" -f $entry.Archivo, $entry.FechaAntes, $entry.FechaAhora | Write-Host -ForegroundColor $modColor
                }
            }
        }
    }
    
    Write-Host ""
    Print-Separator "=" ([Console]::WindowWidth) "Magenta"
    Print-Separator "=" ([Console]::WindowWidth) "Magenta"
    Print-Separator "=" ([Console]::WindowWidth) "Magenta"
    Write-Host ""
    Write-IconMessage "🔹" $msg.exitPrompt "Magenta"
    Read-Host | Out-Null
}

# ----------------------------------------------------
# Flujo principal: llamar a las secciones agrupadas
# ----------------------------------------------------
# Inicialización de variables para recopilar resultados
$ArchivosModificados = @{}
$Errores = @{}
$RespaldoFallido = @{}

Show-InitialPresentation

# Comprobación de errores críticos en ruta de origen/destino
if ($sourceError -or ($DestinosValidos.Count -eq 0)) {
    Write-Host ""
    Print-Separator "=" ([Console]::WindowWidth) "Magenta"
    if ($sourceError) {
        Write-Host ("- {0} {1}" -f $msg.source, $sourceErrorMsg) -ForegroundColor Red
    }
    if ($DestinosValidos.Count -eq 0) {
        Write-Host ("- {0}" -f $msg.errorNoDestination) -ForegroundColor Red
    }
    Write-Host ""
    Print-Separator "=" ([Console]::WindowWidth) "Magenta"
    Write-IconMessage "🔹" $msg.exitPrompt "Magenta"
    Read-Host | Out-Null
    exit
}

Process-Backup

Show-BackupResults