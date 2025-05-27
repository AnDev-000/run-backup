# Configurar la consola para manejar caracteres Unicode correctamente
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Rutas de origen y destino
$SourcePath = "D:\Emuladores\Sony - PlayStation Portable\ppsspp\memstick\PSP\SAVEDATA"
$iCloudDestinationPath = "C:\Users\andre\iCloudDrive\Emuladores\Sony - PlayStation Portable\PPSSPP\memstick\PSP"
$OneDriveDestinationPath = "E:\Nube\OneDrive\Emuladores\Sony - PlayStation Portable\ppsspp\memstick\PSP"

# Crear carpetas si no existen
if (!(Test-Path -Path $iCloudDestinationPath)) { New-Item -Path $iCloudDestinationPath -ItemType Directory }
if (!(Test-Path -Path $OneDriveDestinationPath)) { New-Item -Path $OneDriveDestinationPath -ItemType Directory }

# Obtener número total de archivos
$Files = Get-ChildItem -Path $SourcePath -Recurse
$TotalFiles = $Files.Count
$ProgressStep = 100 / $TotalFiles
$Errores = @()

# Mostrar inicio del respaldo
Write-Host "`n🔹 **Iniciando respaldo**" -ForegroundColor Cyan
Write-Host "De: $SourcePath" -ForegroundColor Gray
Write-Host "Hacia: $iCloudDestinationPath y $OneDriveDestinationPath" -ForegroundColor Gray

# Función para copiar archivos con barra de progreso única
function Copy-WithProgress($DestinationPath, $CloudName, $Color) {
    Write-Host "`n🔄 Iniciando respaldo en $CloudName..." -ForegroundColor $Color
    $Counter = 0
    $BarLength = 40

    foreach ($File in $Files) {
        $DestinoCompleto = Join-Path $DestinationPath $File.Name
        $FechaAnterior = if (Test-Path $DestinoCompleto) { (Get-Item $DestinoCompleto).LastWriteTime } else { "No existía" }

        try {
            Copy-Item -Path $File.FullName -Destination $DestinoCompleto -Force
            $FechaNueva = (Get-Item $DestinoCompleto).LastWriteTime
            $Counter++
            $PercentComplete = [math]::Round($Counter * $ProgressStep)
            $Bar = ("█" * ($PercentComplete * $BarLength / 100)) + (" " * ((40 - $PercentComplete * $BarLength / 100)))
            Write-Host "`r[$Bar] $PercentComplete% completado" -NoNewline
        } catch {
            $Errores += $File.Name
        }
    }

    Write-Host "`r[$Bar] 100% completado" -ForegroundColor $Color
    Write-Host "`n✅ Respaldo en $CloudName completado!" -ForegroundColor $Color

    # Mostrar lista de archivos respaldados
    Write-Host "`n📂 Archivos respaldados en $($CloudName):" -ForegroundColor $Color
    Get-ChildItem -Path $DestinationPath | ForEach-Object { Write-Host $_.Name }
}

# Ejecutar respaldo con colores personalizados
Copy-WithProgress $iCloudDestinationPath "iCloudDrive" "Blue"
Copy-WithProgress $OneDriveDestinationPath "OneDrive" "Green"

# Mostrar archivos con errores
if ($Errores.Count -gt 0) {
    Write-Host "`n⚠ Archivos que no se copiaron:" -ForegroundColor Red
    $Errores | ForEach-Object { Write-Host $_ }
    Write-Host "`n$($Errores.Count) archivos no se pudieron copiar." -ForegroundColor Red
} else {
    Write-Host "`n✅ Archivos con conflicto: 0. Todo se respaldó correctamente." -ForegroundColor Green
}

# Restaurar salida manual para evitar cierre inmediato
Write-Host "`n🔹 Presione Enter para salir..." -ForegroundColor Magenta
Read-Host | Out-Null