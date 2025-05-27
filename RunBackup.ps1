# ==============================
# 🚀 Script de respaldo automático - RunBackupV2
# ==============================

# Configurar la consola para manejar caracteres Unicode correctamente
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# ==============================
# 🔧 Configuración de rutas
# ==============================

# 📂 Ruta de origen - Carpeta con archivos que deseas respaldar
$SourcePath = "D:\Emuladores\Sony - PlayStation Portable\ppsspp\memstick\PSP\Cheats"

# 📌 Rutas de destino - Lugares donde se hará el respaldo
$DestinationPaths = @(
    "E:\Nube\OneDrive\Carpeta3",
    "C:\Users\xxxxx\Desktop\carpeta2",
    "C:\Users\xxxxx\iCloudDrive\carpetaTest",
    "C:\Users\xxxxx\Desktop\Carpeta1"
)

# Validar rutas antes de ejecutar el respaldo
if ($SourcePath -eq "" -or $DestinationPaths.Count -eq 0) {
    Write-Host "`n⚠ ERROR: Debes definir la ruta de origen y al menos un destino antes de ejecutar el script." -ForegroundColor Red
    exit
}

# ==============================
# 🎨 Asignación de colores a destinos (con deteccion de nubes)
# ==============================

# Función para determinar el color según el destino
function Get-DestinationColor ($Destino) {
    $Colores = @("Yellow", "Magenta", "DarkYellow", "Blue", "Green", "Cyan", "White")
    if ($Destino -match "OneDrive") { return "Blue" }
    elseif ($Destino -match "iCloudDrive") { return "Cyan" }
    else { return $Colores[(Get-Random -Maximum $Colores.Count)] }
}

# ✅ Asignar colores a cada destino
$DestinoColores = @{}
foreach ($Destino in $DestinationPaths) {
    $DestinoColores[$Destino] = Get-DestinationColor $Destino
}

# ==============================
# 📌 Inicio del respaldo
# ==============================

Write-Host "`n==================================================" -ForegroundColor Cyan
Write-Host "🔹 **INICIANDO RESPALDO AUTOMÁTICO**" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan

Write-Host "`n📂 Origen:" -ForegroundColor Gray
Write-Host "   $SourcePath" -ForegroundColor White

Write-Host "`n💾 Destinos:" -ForegroundColor Gray
for ($i = 0; $i -lt $DestinationPaths.Count; $i++) {
    $Destino = $DestinationPaths[$i]
    $DestinoInfo = $DestinoColores[$Destino]
    if ($DestinoInfo -ne $null) {
        $Icono = if ($i -eq $DestinationPaths.Count - 1) { "└──" } else { "├──" }
        $IconoDestino = if ($Destino -match "OneDrive" -or $Destino -match "iCloudDrive") { "☁" } else { "📁" }
        Write-Host "   $Icono $IconoDestino $Destino" -ForegroundColor $DestinoInfo
    }
}

# ==============================
# 📤 Función para respaldo con barra de progreso y detalles de archivos
# ==============================

# Variables globales para almacenar archivos respaldados y errores
$ArchivosModificados = @{}
$Errores = @()

function Copy-WithProgress($DestinationPath) {
    $Color = $DestinoColores[$DestinationPath]
    $CloudName = if ($DestinationPath -match "OneDrive") { "OneDrive" }
                elseif ($DestinationPath -match "iCloudDrive") { "iCloud" }
                else { Split-Path -Path $DestinationPath -Leaf }

    Write-Host "`n--------------------------------------------------" -ForegroundColor $Color
    Write-Host "🔄 Iniciando respaldo en ${CloudName}..." -ForegroundColor $Color
    Write-Host "--------------------------------------------------" -ForegroundColor $Color

    $Files = Get-ChildItem -Path $SourcePath -Recurse
    $Counter = 0
    $BarLength = 40

    try {
        foreach ($File in $Files) {
            $DestinoCompleto = $File.FullName.Replace($SourcePath, $DestinationPath)
            $DestinoCarpeta = Split-Path -Path $DestinoCompleto -Parent

            if (!(Test-Path $DestinoCarpeta)) {
                try {
                    New-Item -Path $DestinoCarpeta -ItemType Directory -Force | Out-Null
                } catch {
                    Write-Host "`n⚠ No se pudo crear la carpeta: $DestinoCarpeta (Permiso denegado) - Archivo afectado: $DestinoCompleto" -ForegroundColor Red
                    $Errores += $DestinoCompleto
                    continue
                }
            }

            $FechaAnterior = if (Test-Path $DestinoCompleto) { (Get-Item $DestinoCompleto).LastWriteTime } else { "No existía" }
            Copy-Item -Path $File.FullName -Destination $DestinoCompleto -Force
            $FechaNueva = (Get-Item $DestinoCompleto).LastWriteTime

            $Carpeta = Split-Path -Path $File.FullName -Parent
            if (!$ArchivosModificados.ContainsKey($Carpeta)) { $ArchivosModificados[$Carpeta] = @() }
            $ArchivosModificados[$Carpeta] += @{ Archivo = $File.Name; FechaAntes = $FechaAnterior; FechaAhora = $FechaNueva }

            $Counter++
            $ProgressBar = "█" * [math]::Round(($Counter * $BarLength) / $Files.Count)
            $Espacios = " " * ($BarLength - $ProgressBar.Length)
            Write-Host "`r[$ProgressBar$Espacios] $([math]::Round($Counter * (100 / $Files.Count)))% completado" -NoNewline
        }

        Write-Host "`r[$('█' * 40)] 100% completado" -ForegroundColor $Color
        Write-Host "`n✅ Respaldo en ${CloudName} completado!" -ForegroundColor $Color

        # 📂 Mostrar archivos respaldados agrupados por carpeta
        Write-Host "`n📂 Archivos modificados en ${CloudName}:" -ForegroundColor $Color
        Write-Host "--------------------------------------------------" -ForegroundColor $Color
        foreach ($Carpeta in $ArchivosModificados.Keys) {
            Write-Host "`n📂 Carpeta: $(Split-Path -Path $Carpeta -Leaf)" -ForegroundColor Yellow
            Write-Host "--------------------------------------------------" -ForegroundColor Yellow
            "{0,-40} {1,-25} {2,-25}" -f "Archivo", "Fecha Original", "Fecha Reemplazo" | Write-Host -ForegroundColor White
            Write-Host "--------------------------------------------------" -ForegroundColor Yellow
            foreach ($entry in $ArchivosModificados[$Carpeta]) {
                "{0,-40} {1,-25} {2,-25}" -f $entry.Archivo, $entry.FechaAntes, $entry.FechaAhora | Write-Host -ForegroundColor $Color
            }
            Write-Host "--------------------------------------------------" -ForegroundColor Yellow
        }

    } catch {
        Write-Host "`n⚠ Error en respaldo: $_" -ForegroundColor Red
        $Errores += $_.Exception.Message
    }
}

# 🚀 Ejecutar respaldo en todas las ubicaciones
foreach ($Destino in $DestinoColores.Keys) { Copy-WithProgress $Destino }

Write-Host "`n⚠ Archivos con errores: $($Errores.Count)" -ForegroundColor Red

if ($Errores.Count -eq 0) { Write-Host "`n✅ Todos los archivos fueron respaldados correctamente." -ForegroundColor Green }

Write-Host "`n==================================================" -ForegroundColor Magenta
Write-Host "🔹 Presione Enter para salir..." -ForegroundColor Magenta
Read-Host | Out-Null