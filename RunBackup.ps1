# Configurar la consola para manejar caracteres Unicode correctamente
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Rutas de origen y destino
$SourcePath = "D:\Emuladores\Sony - PlayStation Portable\ppsspp\memstick\PSP\SAVEDATA"
$iCloudDestinationPath = "C:\Users\xxxxx\iCloudDrive\Emuladores\Sony - PlayStation Portable\PPSSPP\memstick\PSP"
$OneDriveDestinationPath = "E:\Nube\OneDrive\Emuladores\Sony - PlayStation Portable\ppsspp\memstick\PSP"

# Crear carpetas si no existen
if (!(Test-Path -Path $iCloudDestinationPath)) { New-Item -Path $iCloudDestinationPath -ItemType Directory }
if (!(Test-Path -Path $OneDriveDestinationPath)) { New-Item -Path $OneDriveDestinationPath -ItemType Directory }

# Obtener número total de archivos
$Files = Get-ChildItem -Path $SourcePath -Recurse
$TotalFiles = $Files.Count
$ProgressStep = 100 / $TotalFiles

# Función para copiar archivos con barra de progreso
function Copy-WithProgress($DestinationPath, $CloudName) {
    Write-Host "`n🔄 Iniciando respaldo en $CloudName..." -ForegroundColor Cyan
    $Counter = 0

    foreach ($File in $Files) {
        Copy-Item -Path $File.FullName -Destination $DestinationPath -Force
        $Counter++
        $PercentComplete = [math]::Round($Counter * $ProgressStep)
        $Bar = ("█" * ($Counter * 40 / $TotalFiles)) + (" " * ((40 - $Counter * 40 / $TotalFiles)))
        Write-Host "`r[$Bar] $PercentComplete% completado" -NoNewline
    }

    Write-Host "`n✅ Respaldo en $($CloudName) completado!" -ForegroundColor Green

    # Mostrar lista de archivos respaldados
    Write-Host "`n📂 Archivos respaldados en $($CloudName):" -ForegroundColor Yellow
    Get-ChildItem -Path $DestinationPath | ForEach-Object { Write-Host $_.Name }
}

# Ejecutar respaldo con barra de progreso
Copy-WithProgress $iCloudDestinationPath "iCloudDrive"
Copy-WithProgress $OneDriveDestinationPath "OneDrive"

# Mensaje final para evitar cierre automático
Write-Host "`n🔹 Presione Enter para salir..." -ForegroundColor Magenta
Read-Host | Out-Null