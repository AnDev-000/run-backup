# ==============================
#  Script de respaldo
# ==============================

# Rutas de origen y destino
$SourcePath = "D:\Emuladores\Sony - PlayStation Portable\ppsspp\memstick\PSP\SAVEDATA"
$iCloudDestinationPath = "C:\Users\xxxxx\iCloudDrive\Emuladores\Sony - PlayStation Portable\PPSSPP\memstick\PSP"
$OneDriveDestinationPath = "E:\Nube\OneDrive\Emuladores\Sony - PlayStation Portable\ppsspp\memstick\PSP"

# ==============================
# 🔧 Creación de carpetas si no existen
# ==============================
if (!(Test-Path -Path $iCloudDestinationPath)) { New-Item -Path $iCloudDestinationPath -ItemType Directory }
if (!(Test-Path -Path $OneDriveDestinationPath)) { New-Item -Path $OneDriveDestinationPath -ItemType Directory }

# Obtener número total de archivos
$Files = Get-ChildItem -Path $SourcePath -Recurse
$TotalFiles = $Files.Count
$ProgressStep = 100 / $TotalFiles
$Errores = @()
$ArchivosModificados = @{}

# ==============================
# 📌 Inicio del respaldo
# ==============================
Write-Host "`n==================================================" -ForegroundColor Cyan
Write-Host "🔹 **INICIANDO RESPALDO**" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan

Write-Host "`n📂 Origen:" -ForegroundColor Gray
Write-Host "   $SourcePath" -ForegroundColor White

Write-Host "`n💾 Destinos:" -ForegroundColor Gray
Write-Host "   ├── iCloudDrive  ➡  $iCloudDestinationPath" -ForegroundColor Blue
Write-Host "   └── OneDrive     ➡  $OneDriveDestinationPath" -ForegroundColor Green

# ==============================
# 📤 Función para respaldo con barra de progreso
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
        Write-Host "`n📂 Archivos modificados en $($CloudName):" -ForegroundColor $Color
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
        Write-Host "`n⚠ Error durante la copia en $($CloudName): $_" -ForegroundColor Red
        $Errores += $File.Name
    }
}

# ==============================
# 🚀 Ejecutar respaldo en ambas nubes
# ==============================
Copy-WithProgress $iCloudDestinationPath "iCloudDrive" "Blue"
Copy-WithProgress $OneDriveDestinationPath "OneDrive" "Green"

# ==============================
# 📌 Mostrar archivos con errores
# ==============================
if ($Errores.Count -gt 0) {
    Write-Host "`n--------------------------------------------------" -ForegroundColor Red
    Write-Host "⚠ Archivos que no se copiaron:" -ForegroundColor Red
    Write-Host "--------------------------------------------------" -ForegroundColor Red
    $Errores | ForEach-Object { Write-Host $_ }
    Write-Host "`n🚫 Total: $($Errores.Count) archivos no se pudieron copiar." -ForegroundColor Red
} else {
    Write-Host "`n✅ Archivos con conflicto: 0. Todo se respaldó correctamente." -ForegroundColor Green
}

# ==============================
# 🔚 Finalización del script
# ==============================
Write-Host "`n==================================================" -ForegroundColor Magenta
Write-Host "🔹 Presione Enter para salir..." -ForegroundColor Magenta
Write-Host "==================================================" -ForegroundColor Magenta
Read-Host | Out-Null