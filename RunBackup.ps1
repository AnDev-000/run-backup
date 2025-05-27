# ==============================
# 🚀 Script de respaldo PPSSPP
# ==============================

# Configurar la consola para manejar caracteres Unicode correctamente
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

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
$ArchivosModificados = @()

# ==============================
# 📌 Inicio del respaldo
# ==============================
Write-Host "`n=======================================" -ForegroundColor Cyan
Write-Host " 🔹 **Iniciando respaldo**" -ForegroundColor Cyan
Write-Host "=======================================" -ForegroundColor Cyan

Write-Host "📂 Origen: $SourcePath" -ForegroundColor Gray
Write-Host "💾 Destino: $iCloudDestinationPath y $OneDriveDestinationPath" -ForegroundColor Gray

# ==============================
# 📤 Función para respaldo con barra de progreso
# ==============================
function Copy-WithProgress($DestinationPath, $CloudName, $Color) {
    Write-Host "`n---------------------------------------" -ForegroundColor $Color
    Write-Host "🔄 Iniciando respaldo en $CloudName..." -ForegroundColor $Color
    Write-Host "---------------------------------------" -ForegroundColor $Color

    $Counter = 0
    $BarLength = 40
    $Bar = " " * $BarLength

    try {
        foreach ($File in $Files) {
            $DestinoCompleto = Join-Path $DestinationPath $File.Name
            $FechaAnterior = if (Test-Path $DestinoCompleto) { (Get-Item $DestinoCompleto).LastWriteTime } else { "No existía" }

            Copy-Item -Path $File.FullName -Destination $DestinoCompleto -Force
            $FechaNueva = (Get-Item $DestinoCompleto).LastWriteTime
            $ArchivosModificados += "`n📂 $File.Name | 📅 Antes: $FechaAnterior | 📅 Ahora: $FechaNueva"

            $Counter++
            $PercentComplete = [math]::Round($Counter * $ProgressStep)
            $Bar = ("█" * ($PercentComplete * $BarLength / 100)) + (" " * ((40 - $PercentComplete * $BarLength / 100)))
            Write-Host "`r[$Bar] $PercentComplete% completado" -NoNewline
        }

        Write-Host "`r[$Bar] 100% completado" -ForegroundColor $Color
        Write-Host "`n✅ Respaldo en $CloudName completado!" -ForegroundColor $Color

        # Mostrar archivos respaldados al final de cada respaldo
        Write-Host "`n📂 Archivos modificados en $($CloudName):" -ForegroundColor $Color
        $ArchivosModificados | ForEach-Object { Write-Host $_ -ForegroundColor $Color }
        $ArchivosModificados = @()  # Limpiar lista para el siguiente respaldo

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
    Write-Host "`n---------------------------------------" -ForegroundColor Red
    Write-Host "⚠ Archivos que no se copiaron:" -ForegroundColor Red
    Write-Host "---------------------------------------" -ForegroundColor Red
    $Errores | ForEach-Object { Write-Host $_ }
    Write-Host "`n🚫 Total: $($Errores.Count) archivos no se pudieron copiar." -ForegroundColor Red
} else {
    Write-Host "`n✅ Archivos con conflicto: 0. Todo se respaldó correctamente." -ForegroundColor Green
}

# ==============================
# 🔚 Finalización del script
# ==============================
Write-Host "`n=======================================" -ForegroundColor Magenta
Write-Host "🔹 Presione Enter para salir..." -ForegroundColor Magenta
Write-Host "=======================================" -ForegroundColor Magenta
Read-Host | Out-Null