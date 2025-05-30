# ==============================
# 🚀 Script de respaldo automático - RunBackupV2
# ==============================

# Configurar la consola para manejar caracteres Unicode correctamente
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Cargar el archivo de idiomas (se espera que esté en la carpeta "lang")
. "$PSScriptRoot\lang\languages.ps1"
# Seleccionar el idioma deseado: "spanish" o "english"
$language = "english"  # Cambia a "english" si lo prefieres
$msg = $languages[$language]

# ==============================
# 🔧 Configuración de rutas
# ==============================

# 📂 Ruta de origen - Especifica aquí la carpeta que deseas respaldar
$SourcePath = "REEMPLAZA_CON_TU_RUTA_DE_ORIGEN"

# 📌 Rutas de destino - Especifica aquí las carpetas donde se guardará el respaldo
$DestinationPaths = @(
    "REEMPLAZA_CON_TU_RUTA_DE_DESTINO1",
    "REEMPLAZA_CON_TU_RUTA_DE_DESTINO2",
    "REEMPLAZA_CON_TU_RUTA_DE_DESTINO3"
)

# ----------------------------------------------------
# DEFINICIÓN DE FUNCIONES DE VALIDACIÓN Y COLOR
# ----------------------------------------------------
function Validar-Ruta ($ruta) {
    return ($ruta -match '^[A-Za-z]:[\\/].+')
}

function Get-DestinationColor ($Destino) {
    if ($Destino -match "OneDrive") {
        return "Blue"
    } elseif ($Destino -match "iCloudDrive") {
        return "Cyan"
    } else {
        $nonCloudColors = @("Yellow", "Magenta", "DarkYellow", "Green", "White")
        return $nonCloudColors[(Get-Random -Maximum $nonCloudColors.Count)]
    }
}

# ----------------------------------------------------
# VALIDACIÓN DE RUTAS
# ----------------------------------------------------
$errorFound = $false

if (-not (Validar-Ruta $SourcePath)) {
    $origenMsg = $msg.errorNoSource
    $errorFound = $true
} else {
    $origenMsg = $SourcePath
}

$DestinosValidos = @()
$DestinosInvalidos = @()
foreach ($dest in $DestinationPaths) {
    if (Validar-Ruta $dest) {
        $DestinosValidos += $dest
    } else {
        $DestinosInvalidos += $dest
        $errorFound = $true
    }
}

$DestinoColores = @{}
foreach ($dest in $DestinosValidos) {
    $DestinoColores[$dest] = Get-DestinationColor $dest
}

# ----------------------------------------------------
# PRESENTACIÓN INICIAL
# ----------------------------------------------------
Write-Host "`n==================================================" -ForegroundColor Cyan
Write-Host ("🔹 " + $msg.titleAutoBackup) -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan

Write-Host "`n📂 " + $msg.labelSource -ForegroundColor Gray
if ($origenMsg -like "Falta*") {
    $origenColor = "Red"
} else {
    $origenColor = "White"
}
Write-Host "   $origenMsg" -ForegroundColor $origenColor

Write-Host "`n💾 " + $msg.labelDestination -ForegroundColor Gray
if ($DestinosValidos.Count -eq 0) {
    Write-Host "   " + $msg.errorNoDestination -ForegroundColor Red
    $errorFound = $true
} else {
    foreach ($dest in $DestinosValidos) {
        $IconoDestino = if ($dest -match "OneDrive" -or $dest -match "iCloudDrive") { "☁" } else { "📂" }
        $formattedIcon = "{0,-2}" -f $IconoDestino
        Write-Host "   $formattedIcon $dest" -ForegroundColor $DestinoColores[$dest]
    }
}

if ($DestinosInvalidos.Count -gt 0) {
    foreach ($dest in $DestinosInvalidos) {
        if ($dest -eq "") {
            Write-Host "   " + $msg.errorNoDestination -ForegroundColor Red
        } else {
            Write-Host ("   " + ($msg.errorInvalidDestination -f $dest)) -ForegroundColor Red
        }
    }
}

if (-not (Validar-Ruta $SourcePath) -or $DestinosValidos.Count -eq 0) {
    Write-Host "`n==================================================" -ForegroundColor Magenta
    Write-Host ("🔹 " + $msg.exitPrompt) -ForegroundColor Magenta
    Read-Host | Out-Null
    exit
}

# ----------------------------------------------------
# PROCESO DE RESPALDO CON BARRA DE PROGRESO
# ----------------------------------------------------
$ArchivosModificados = @{}
$Errores = @()
$RespaldoFallido = @()

function Copy-WithProgress($DestinationPath) {
    $Color = $DestinoColores[$DestinationPath]
    $IconoDestino = if ($DestinationPath -match "OneDrive" -or $DestinationPath -match "iCloudDrive") { "☁" } else { "📂" }
    $CloudName = if ($DestinationPath -match "OneDrive") { "OneDrive" }
                 elseif ($DestinationPath -match "iCloudDrive") { "iCloud" }
                 else { Split-Path -Path $DestinationPath -Leaf }

    $Files = Get-ChildItem -Path $SourcePath -Recurse
    $TotalFiles = $Files.Count
    if ($TotalFiles -eq 0) {
        Write-Host "No files found for backup." -ForegroundColor Red
        return
    }
    $Counter = 0
    $BarLength = 40

    try {
        foreach ($File in $Files) {
            $DestinoCompleto = $File.FullName.Replace($SourcePath, $DestinationPath)
            $DestinoCarpeta = Split-Path -Path $DestinoCompleto -Parent

            if (-not (Test-Path $DestinoCarpeta)) {
                try {
                    New-Item -Path $DestinoCarpeta -ItemType Directory -Force | Out-Null
                } catch {
                    continue
                }
            }

            $FechaAnterior = if (Test-Path $DestinoCompleto) { (Get-Item $DestinoCompleto).LastWriteTime } else { "No available" }
            Copy-Item -Path $File.FullName -Destination $DestinoCompleto -Force
            $FechaNueva = (Get-Item $DestinoCompleto).LastWriteTime

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
            $ProgressBar = "█" * [math]::Round(($Counter * $BarLength) / $TotalFiles)
            $Espacios = " " * ($BarLength - $ProgressBar.Length)
            $formattedIcon = "{0,-2}" -f $IconoDestino
            $progressText = "$formattedIcon " + "[$ProgressBar$Espacios] " + "$([math]::Round(($Counter * 100) / $TotalFiles))% completed"

            if ($Counter -eq 1) {
                Write-Host $progressText -ForegroundColor $Color
            } else {
                $cursorLine = [Console]::CursorTop - 1
                [Console]::SetCursorPosition(0, $cursorLine)
                Write-Host $progressText -ForegroundColor $Color
            }
            Start-Sleep -Milliseconds 20
        }
        Write-Host ""
    } catch {
        Write-Host ("`n⚠ Error backing up " + $CloudName + ": " + $_) -ForegroundColor Red
        $RespaldoFallido += $DestinationPath
    }
}

# ----------------------------------------------------
# EJECUCIÓN DEL RESPALDO EN TODAS LAS UBICACIONES
# ----------------------------------------------------
Write-Host "`n--------------------------------------------------" -ForegroundColor Yellow
Write-Host ("🔄 " + $msg.labelBackingUp) -ForegroundColor Yellow
Write-Host "--------------------------------------------------" -ForegroundColor Yellow
Write-Host ""  # Extra line for spacing.

foreach ($Destino in $DestinosValidos) {
    Copy-WithProgress $Destino
}

Write-Host "`n--------------------------------------------------" -ForegroundColor Yellow
Write-Host ("✅ " + $msg.labelBackupCompleted) -ForegroundColor Green
foreach ($Destino in $DestinoColores.Keys) {
    $CloudName = if ($Destino -match "OneDrive") { "OneDrive" }
                 elseif ($Destino -match "iCloudDrive") { "iCloud" }
                 else { Split-Path -Path $Destino -Leaf }
    $IconoDestino = if ($Destino -match "OneDrive" -or $Destino -match "iCloudDrive") { "☁" } else { "📂" }
    $formattedIcon = "{0,-2}" -f $IconoDestino
    Write-Host "- $formattedIcon $CloudName" -ForegroundColor $DestinoColores[$Destino]
}

if ($RespaldoFallido.Count -gt 0) {
    Write-Host "`n❌ Backup failed in:" -ForegroundColor Red
    foreach ($Destino in $RespaldoFallido) {
        $CloudName = if ($Destino -match "OneDrive") { "OneDrive" }
                     elseif ($Destino -match "iCloudDrive") { "iCloud" }
                     else { Split-Path -Path $Destino -Leaf }
        $IconoDestino = if ($Destino -match "OneDrive" -or $Destino -match "iCloudDrive") { "☁" } else { "📂" }
        $formattedIcon = "{0,-2}" -f $IconoDestino
        Write-Host "- $formattedIcon $CloudName" -ForegroundColor Red
    }
}

# ----------------------------------------------------
# MOSTRAR ARCHIVOS RESPALDADOS AGRUPADOS POR DESTINO
# ----------------------------------------------------
Write-Host "`n--------------------------------------------------" -ForegroundColor Yellow
Write-Host ("🔹 " + $msg.modifiedFilesSection) -ForegroundColor Yellow
Write-Host "--------------------------------------------------" -ForegroundColor Yellow

foreach ($CloudName in $ArchivosModificados.Keys) {
    if ($CloudName -eq "OneDrive") {
        $modColor = "Blue"
        $icon = "☁"
    } elseif ($CloudName -eq "iCloud") {
        $modColor = "Cyan"
        $icon = "☁"
    } else {
        $modColor = $null
        foreach ($dest in $DestinationPaths) {
            if ((Split-Path -Leaf $dest) -eq $CloudName) {
                $modColor = $DestinoColores[$dest]
                break
            }
        }
        if (-not $modColor) { $modColor = "Green" }
        $icon = "📂"
    }
    $formattedIcon = "{0,-2}" -f $icon
    Write-Host "`n$formattedIcon  " + ($msg.labelModifiedFiles -f $CloudName) -ForegroundColor $modColor
    Write-Host "--------------------------------------------------" -ForegroundColor $modColor

    foreach ($Carpeta in $ArchivosModificados[$CloudName].Keys) {
        $folderName = Split-Path -Leaf $Carpeta
        if ($CloudName -eq "OneDrive" -or $CloudName -eq "iCloud") {
            $folderIcon = "☁"
        } else {
            $folderIcon = "📂"
        }
        $formattedFolderIcon = "{0,-2}" -f $folderIcon
        Write-Host "`n$formattedFolderIcon  " + ($msg.folderLabel + " " + $folderName) -ForegroundColor $modColor
        Write-Host "--------------------------------------------------" -ForegroundColor $modColor
        Write-Host $msg.tableHeader -ForegroundColor "White"
        Write-Host "--------------------------------------------------" -ForegroundColor $modColor

        foreach ($entry in $ArchivosModificados[$CloudName][$Carpeta]) {
            "{0,-40} {1,-25} {2,-25}" -f $entry.Archivo, $entry.FechaAntes, $entry.FechaAhora | Write-Host -ForegroundColor $modColor
        }
    }
}

Write-Host "`n==================================================" -ForegroundColor Magenta
Write-Host "==================================================" -ForegroundColor Magenta
Write-Host "==================================================" -ForegroundColor Magenta
Write-Host ("`n⚠ " + ($msg.errorSummary -f ($Errores.Count + $DestinosInvalidos.Count))) -ForegroundColor Red
if (($Errores.Count + $DestinosInvalidos.Count) -eq 0) {
    Write-Host ("`n✅ " + $msg.successMessage) -ForegroundColor Green
} else {
    Write-Host ("`n⚠ " + $msg.generalError) -ForegroundColor Red
}
Write-Host "`n==================================================" -ForegroundColor Magenta
Write-Host ("🔹 " + $msg.exitPrompt) -ForegroundColor Magenta
Read-Host | Out-Null
