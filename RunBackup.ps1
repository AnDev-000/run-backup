# ==============================
#  Script de respaldo
# ==============================

# ==============================
# 🔧 Configuración de rutas
# ==============================

# 📂 Ruta de origen - Carpeta con archivos que deseas respaldar
$SourcePath = "D:\Emuladores\Sony - PlayStation Portable\ppsspp\memstick\PSP\SAVEDATA"

# 📌 Rutas de destino - Lugares donde se hará el respaldo
$DestinationPaths = @(
    "C:\Users\xxxxx\iCloudDrive\Emuladores\Sony - PlayStation Portable\PPSSPP\memstick\PSP",
    "E:\Nube\OneDrive\Emuladores\Sony - PlayStation Portable\ppsspp\memstick\PSP",
    "C:\Users\xxxxx\Desktop\Carpeta1"
)

# ==============================
# 🔧 Creación de carpetas de destino si no existen
# ==============================
foreach ($Destination in $DestinationPaths) {
    if (!(Test-Path -Path $Destination)) { 
        New-Item -Path $Destination -ItemType Directory -Force
    }
}

# ==============================
# 📤 Procesamiento de archivos
# ==============================

# Obtener número total de archivos
$Files = Get-ChildItem -Path $SourcePath -Recurse
$TotalFiles = $Files.Count
$ProgressStep = if ($TotalFiles -gt 0) { 100 / $TotalFiles } else { 0 }
$Errores = @()
$ArchivosModificados = @{}

# ==============================
# 🎨 Asignación de colores automáticamente
# ==============================
$Colores = @("Yellow", "Magenta", "DarkYellow", "Blue", "Green", "Cyan", "White")

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
    $NombreDestino = if ($DestinationPaths[$i] -match "OneDrive") { "OneDrive" }
                     elseif ($DestinationPaths[$i] -match "iCloudDrive") { "iCloudDrive" }
                     else { Split-Path -Path $DestinationPaths[$i] -Leaf }

    $Icono = if ($i -eq $DestinationPaths.Count - 1) { "└──" } else { "├──" }
    Write-Host "   $Icono $NombreDestino  ➡  $($DestinationPaths[$i])" -ForegroundColor Green
}

# ==============================
# 📤 Función para respaldo con barra de progreso y detalles de archivos
# ==============================
function Copy-WithProgress($DestinationPath, $CloudName, $Color) {
    Write-Host "`n--------------------------------------------------" -ForegroundColor $Color
    Write-Host "🔄 Iniciando respaldo en $CloudName..." -ForegroundColor $Color
    Write-Host "--------------------------------------------------" -ForegroundColor $Color

    $Counter = 0
    $BarLength = 40

    try {
        foreach ($File in $Files) {
            $DestinoCompleto = Join-Path $DestinationPath $File.Name
            $FechaAnterior = if (Test-Path $DestinoCompleto) { (Get-Item $DestinoCompleto).LastWriteTime } else { "No existía" }

            Copy-Item -Path $File.FullName -Destination $DestinoCompleto -Force
            $FechaNueva = (Get-Item $DestinoCompleto).LastWriteTime

            # Agrupar archivos por carpeta
            $Carpeta = Split-Path -Path $File.FullName -Parent
            if (!$ArchivosModificados.ContainsKey($Carpeta)) {
                $ArchivosModificados[$Carpeta] = @()
            }
            $ArchivosModificados[$Carpeta] += @{ Archivo = $File.Name; FechaAntes = $FechaAnterior; FechaAhora = $FechaNueva }

            # Barra de progreso
            $Counter++
            $PercentComplete = [math]::Round($Counter * $ProgressStep)
            $Bar = ("█" * ($PercentComplete * $BarLength / 100)) + (" " * ((40 - $PercentComplete * $BarLength / 100)))
            Write-Host "`r[$Bar] $PercentComplete% completado" -NoNewline
        }

        Write-Host "`r[$Bar] 100% completado" -ForegroundColor $Color
        Write-Host "`n✅ Respaldo en $CloudName completado!" -ForegroundColor $Color

        # Mostrar archivos modificados agrupados por carpeta
        Write-Host "`n📂 Archivos modificados en ${CloudName}:" -ForegroundColor $Color
        Write-Host "--------------------------------------------------" -ForegroundColor $Color
        foreach ($Carpeta in $ArchivosModificados.Keys) {
            Write-Host "`n📂 Carpeta: $Carpeta" -ForegroundColor Yellow
            Write-Host "--------------------------------------------------" -ForegroundColor Yellow
            "{0,-40} {1,-25} {2,-25}" -f "Archivo", "Fecha Original", "Fecha Reemplazo" | Write-Host -ForegroundColor White
            Write-Host "--------------------------------------------------" -ForegroundColor Yellow
            foreach ($entry in $ArchivosModificados[$Carpeta]) {
                "{0,-40} {1,-25} {2,-25}" -f $entry.Archivo, $entry.FechaAntes, $entry.FechaAhora | Write-Host -ForegroundColor $Color
            }
            Write-Host "--------------------------------------------------" -ForegroundColor Yellow
        }

    } catch {
        $ErrorMessage = $_.Exception.Message
        Write-Host "`n⚠ Error durante la copia en $CloudName." -ForegroundColor Red
        Write-Host "`n🔴 Detalles del error:" -ForegroundColor Red
        Write-Host "$ErrorMessage" -ForegroundColor Red
        $Errores += $File.Name
    }
}

# ==============================
# 🚀 Ejecutar respaldo en todas las ubicaciones con asignación de color automática
# ==============================
for ($i = 0; $i -lt $DestinationPaths.Count; $i++) {
    $CloudName = if ($DestinationPaths[$i] -match "OneDrive") { "OneDrive" }
                 elseif ($DestinationPaths[$i] -match "iCloudDrive") { "iCloudDrive" }
                 else { Split-Path -Path $DestinationPaths[$i] -Leaf }

    $ColorAsignado = $Colores[$i % $Colores.Count]
    Copy-WithProgress $DestinationPaths[$i] $CloudName $ColorAsignado
}


# ==============================
# 📌 Mostrar archivos con errores
# ==============================

Write-Host "`n--------------------------------------------------" -ForegroundColor Red
Write-Host "⚠ Archivos con errores: $($Errores.Count)" -ForegroundColor Red

if ($Errores.Count -eq 0) {
    Write-Host "`n✅ Todos los archivos fueron respaldados correctamente." -ForegroundColor Green
} else {
    $Errores | ForEach-Object { Write-Host $_ }
}

# ==============================
# 🔚 Finalización del script
# ==============================
Write-Host "`n==================================================" -ForegroundColor Magenta
Write-Host "🔹 Presione Enter para salir..." -ForegroundColor Magenta
Write-Host "==================================================" -ForegroundColor Magenta
Read-Host | Out-Null