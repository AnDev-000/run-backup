# Rutas de origen y destino
$SourcePath = "D:\Emuladores\Sony - PlayStation Portable\ppsspp\memstick\PSP\SAVEDATA"
$iCloudDestinationPath = "C:\Users\xxxxx\iCloudDrive\Emuladores\Sony - PlayStation Portable\PPSSPP\memstick\PSP\SAVEDATA"
$OneDriveDestinationPath = "E:\Nube\OneDrive\Emuladores\Sony - PlayStation Portable\ppsspp\memstick\PSP\SAVEDATA"

# Verifica si la carpeta de destino en iCloudDrive existe, si no, la crea
if (!(Test-Path -Path $iCloudDestinationPath)) {
    New-Item -Path $iCloudDestinationPath -ItemType Directory -Force
}

# Verifica si la carpeta de destino en OneDrive existe, si no, la crea
if (!(Test-Path -Path $OneDriveDestinationPath)) {
    New-Item -Path $OneDriveDestinationPath -ItemType Directory -Force
}

# Copia los archivos al destino iCloudDrive
Copy-Item -Path $SourcePath\* -Destination $iCloudDestinationPath -Recurse -Force

# Copia los archivos al destino OneDrive
Copy-Item -Path $SourcePath\* -Destination $OneDriveDestinationPath -Recurse -Force

# Mensaje de confirmación
Write-Host "✅ Se ha realizado el respaldo en iCloudDrive y OneDrive correctamente."
