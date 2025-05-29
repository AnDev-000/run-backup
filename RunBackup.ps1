# ==============================
# 🚀 Script de respaldo automático - RunBackupV2
# ==============================

# Configurar la consola para manejar caracteres Unicode correctamente
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

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
# Función para verificar que la ruta tenga el formato correcto.
function Validar-Ruta($ruta) {
    return ($ruta -match '^[A-Za-z]:[\\/].+')
}

# Función para asignar colores según el destino.
function Get-DestinationColor ($Destino) {
    if ($Destino -match "OneDrive") { 
        return "Blue" 
    }
    elseif ($Destino -match "iCloudDrive") { 
        return "Cyan" 
    }
    else {
        $nonCloudColors = @("Yellow", "Magenta", "DarkYellow", "Green", "White")
        return $nonCloudColors[(Get-Random -Maximum $nonCloudColors.Count)]
    }
}

# ----------------------------------------------------
# VALIDACIÓN DE RUTAS
# ----------------------------------------------------
$errorFound = $false

# Validar la ruta de origen.
if (-not (Validar-Ruta $SourcePath)) {
    $origenMsg = "❌ Falta definir la ruta de Origen."
    $errorFound = $true
}
else {
    $origenMsg = $SourcePath
}

# Separar destinos en válidos e inválidos.
$DestinosValidos = @()
$DestinosInvalidos = @()
foreach ($dest in $DestinationPaths) {
    if (Validar-Ruta $dest) {
        $DestinosValidos += $dest
    }
    else {
        $DestinosInvalidos += $dest
        $errorFound = $true
    }
}

# Asignar colores a cada destino válido y guardarlos en un diccionario.
$DestinoColores = @{}
foreach ($dest in $DestinosValidos) {
    $DestinoColores[$dest] = Get-DestinationColor $dest
}

# ----------------------------------------------------
# PRESENTACIÓN INICIAL
# ----------------------------------------------------
Write-Host "`n==================================================" -ForegroundColor Cyan
Write-Host "🔹 **INICIANDO RESPALDO AUTOMÁTICO**" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan

# Mostrar Origen:
Write-Host "`n📂 Origen:" -ForegroundColor Gray
if ($origenMsg -like "❌*") {
    $origenColor = "Red"
}
else {
    $origenColor = "White"
}
Write-Host "   $origenMsg" -ForegroundColor $origenColor

# Mostrar Destinos válidos.
Write-Host "`n💾 Destinos:" -ForegroundColor Gray
if ($DestinosValidos.Count -eq 0) {
    Write-Host "   ❌ No se ha definido ninguna ruta de destino válida." -ForegroundColor Red
    $errorFound = $true
}
else {
    foreach ($dest in $DestinosValidos) {
        $IconoDestino = if ($dest -match "OneDrive" -or $dest -match "iCloudDrive") { "☁" } else { "📂" }
        $formattedIcon = "{0,-2}" -f $IconoDestino
        Write-Host "   $formattedIcon $dest" -ForegroundColor $DestinoColores[$dest]
    }
}
# Mostrar destinos inválidos (si existen):
if ($DestinosInvalidos.Count -gt 0) {
    foreach ($dest in $DestinosInvalidos) {
        if ($dest -eq "") {
            Write-Host "   ❌ Falta definir la ruta de destino." -ForegroundColor Red
        }
        else {
            Write-Host "   ❌ La ruta de destino es incorrecta: '$dest'" -ForegroundColor Red
        }
    }
}

# Si la ruta de origen no es válida o no hay ningún destino válido, se detiene.
if (-not (Validar-Ruta $SourcePath) -or $DestinosValidos.Count -eq 0) {
    Write-Host "`n==================================================" -ForegroundColor Magenta
    Write-Host "🔹 Presione Enter para salir..." -ForegroundColor Magenta
    Read-Host | Out-Null
    exit
}

# ----------------------------------------------------
# PROCESO DE RESPALDO CON BARRA DE PROGRESO (como antes)
# ----------------------------------------------------
# Variables globales para respaldar archivos y errores.
$ArchivosModificados = @{}
$Errores = @()
$RespaldoFallido = @()

function Copy-WithProgress($DestinationPath) {
    # Definir el ícono SIN espacios; se agregará con formateo en la salida.
    $Color = $DestinoColores[$DestinationPath]
    $IconoDestino = if ($DestinationPath -match "OneDrive" -or $DestinationPath -match "iCloudDrive") { "☁" } else { "📂" }
    $CloudName = if ($DestinationPath -match "OneDrive") { "OneDrive" }
    elseif ($DestinationPath -match "iCloudDrive") { "iCloud" }
    else { Split-Path -Path $DestinationPath -Leaf }

    # Obtener todos los archivos a respaldar.
    $Files = Get-ChildItem -Path $SourcePath -Recurse
    $TotalFiles = $Files.Count
    if ($TotalFiles -eq 0) {
        Write-Host "No se encontraron archivos para respaldar." -ForegroundColor Red
        return
    }
    $Counter = 0
    $BarLength = 40

    try {
        foreach ($File in $Files) {
            $DestinoCompleto = $File.FullName.Replace($SourcePath, $DestinationPath)
            $DestinoCarpeta = Split-Path -Path $DestinoCompleto -Parent

            # Crear la carpeta de destino si aún no existe.
            if (!(Test-Path $DestinoCarpeta)) {
                try {
                    New-Item -Path $DestinoCarpeta -ItemType Directory -Force | Out-Null
                }
                catch {
                    continue
                }
            }

            # Obtener la fecha anterior (si el archivo ya existía) y luego copiar.
            $FechaAnterior = if (Test-Path $DestinoCompleto) { (Get-Item $DestinoCompleto).LastWriteTime } else { "No disponible" }
            Copy-Item -Path $File.FullName -Destination $DestinoCompleto -Force
            $FechaNueva = (Get-Item $DestinoCompleto).LastWriteTime

            # Registrar el archivo respaldado con sus fechas.
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

            # --- BARRA DE PROGRESO EXACTAMENTE COMO ANTES ---
            $Counter++
            $ProgressBar = "█" * [math]::Round(($Counter * $BarLength) / $TotalFiles)
            $Espacios = " " * ($BarLength - $ProgressBar.Length)
            $formattedIcon = "{0,-2}" -f $IconoDestino
            $progressText = "$formattedIcon " + "[$ProgressBar$Espacios] " + "$([math]::Round(($Counter * 100) / $TotalFiles))% completado"

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
        # Salto de línea al finalizar este destino.
        Write-Host ""
    }
    catch {
        Write-Host "`n⚠ Error en respaldo de ${CloudName}: $($_)" -ForegroundColor Red
        $RespaldoFallido += $DestinationPath
    }

}

# ----------------------------------------------------
# EJECUCIÓN DEL RESPALDO EN TODAS LAS UBICACIONES
# ----------------------------------------------------
Write-Host "`n--------------------------------------------------" -ForegroundColor Yellow
Write-Host "🔄 Respaldando..." -ForegroundColor Yellow
Write-Host "--------------------------------------------------" -ForegroundColor Yellow
Write-Host ""  # Línea extra para separar el encabezado del progreso.

foreach ($Destino in $DestinosValidos) {
    Copy-WithProgress $Destino
}

Write-Host "`n--------------------------------------------------" -ForegroundColor Yellow
Write-Host "✅ Respaldo completado en:" -ForegroundColor Green
foreach ($Destino in $DestinoColores.Keys) {
    $CloudName = if ($Destino -match "OneDrive") { "OneDrive" }
    elseif ($Destino -match "iCloudDrive") { "iCloud" }
    else { Split-Path -Path $Destino -Leaf }
    $IconoDestino = if ($Destino -match "OneDrive" -or $Destino -match "iCloudDrive") { "☁" } else { "📂" }
    $formattedIcon = "{0,-2}" -f $IconoDestino
    Write-Host "- $formattedIcon $CloudName" -ForegroundColor $DestinoColores[$Destino]
}

if ($RespaldoFallido.Count -gt 0) {
    Write-Host "`n❌ No se pudo completar en:" -ForegroundColor Red
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
Write-Host "🔹 **Archivos modificados en cada destino:**" -ForegroundColor Yellow
Write-Host "--------------------------------------------------" -ForegroundColor Yellow

foreach ($CloudName in $ArchivosModificados.Keys) {
    if ($CloudName -eq "OneDrive") { 
        $modColor = "Blue"
        $icon = "☁"
    }
    elseif ($CloudName -eq "iCloud") {
        $modColor = "Cyan"
        $icon = "☁"
    }
    else {
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
    Write-Host "`n$formattedIcon  Archivos modificados en ${CloudName}:" -ForegroundColor $modColor
    Write-Host "--------------------------------------------------" -ForegroundColor $modColor

    foreach ($Carpeta in $ArchivosModificados[$CloudName].Keys) {
        $folderName = Split-Path -Leaf $Carpeta
        if ($CloudName -eq "OneDrive" -or $CloudName -eq "iCloud") {
            $folderIcon = "☁"
        }
        else {
            $folderIcon = "📂"
        }
        $formattedFolderIcon = "{0,-2}" -f $folderIcon
        Write-Host "`n$formattedFolderIcon  Carpeta: $folderName" -ForegroundColor $modColor
        Write-Host "--------------------------------------------------" -ForegroundColor $modColor
        "{0,-40} {1,-25} {2,-25}" -f "Archivo", "Fecha Original", "Fecha Reemplazo" | Write-Host -ForegroundColor "White"
        Write-Host "--------------------------------------------------" -ForegroundColor $modColor

        foreach ($entry in $ArchivosModificados[$CloudName][$Carpeta]) {
            "{0,-40} {1,-25} {2,-25}" -f $entry.Archivo, $entry.FechaAntes, $entry.FechaAhora | Write-Host -ForegroundColor $modColor
        }
    }
}

Write-Host "`n==================================================" -ForegroundColor Magenta
Write-Host "==================================================" -ForegroundColor Magenta
Write-Host "==================================================" -ForegroundColor Magenta
Write-Host "`n⚠ Archivos y destinos con errores: $($Errores.Count + $DestinosInvalidos.Count)" -ForegroundColor Red
if (($Errores.Count + $DestinosInvalidos.Count) -eq 0) {
    Write-Host "`n✅ Todos los archivos fueron respaldados correctamente." -ForegroundColor Green
}
else {
    Write-Host "`n⚠ Hubo errores durante el respaldo; revise el reporte." -ForegroundColor Red
}
Write-Host "`n==================================================" -ForegroundColor Magenta
Write-Host "🔹 Presione Enter para salir..." -ForegroundColor Magenta
Read-Host | Out-Null