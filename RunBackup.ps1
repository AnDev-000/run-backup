# ==============================
#  Script de respaldo
# ==============================

# ==============================
# 🔧 Configuración de rutas
# ==============================

# Configurar la consola para manejar caracteres Unicode correctamente
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

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
$Files = Get-ChildItem -Path $SourcePath -Recurse -File
$TotalFiles = $Files.Count
$ProgressStep = if ($TotalFiles -gt 0) { 100 / $TotalFiles } else { 0 }
$Errores = @()
$DestinoColores = @{}
$ArchivosModificados = @{}  # Se movió fuera de la función para evitar reinicio

# ==============================
# 🎨 Asignación de colores automáticamente
# ==============================
$Colores = @("Yellow", "Magenta", "DarkYellow", "Blue", "Green", "Cyan", "White")

# ==============================
# 📌 Asignación de colores a destinos (incluye detección de nubes)
# ==============================
foreach ($Destino in $DestinationPaths) {
    $NombreDestino = if ($Destino -match "OneDrive") { "OneDrive" }
                     elseif ($Destino -match "iCloudDrive") { "iCloudDrive" }
                     else { Split-Path -Path $Destino -Leaf }

    $ColorAsignado = if ($Destino -match "OneDrive") { "Blue" }
                     elseif ($Destino -match "iCloudDrive") { "Cyan" }
                     else { $Colores[$DestinationPaths.IndexOf($Destino) % $Colores.Count] }

    $DestinoColores[$Destino] = @{ Nombre = $NombreDestino; Color = $ColorAsignado }
}

# ==============================
# 📌 Inicio del respaldo
# ==============================
Write-Host "`n==================================================" -ForegroundColor Cyan
Write-Host "🔹 INICIANDO RESPALDO AUTOMÁTICO" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan

Write-Host "`n📂 Origen:" -ForegroundColor Gray
Write-Host "   $SourcePath" -ForegroundColor White

Write-Host "`n💾 Destinos:" -ForegroundColor Gray
foreach ($Destino in $DestinationPaths) {
    $DestinoInfo = $DestinoColores[$Destino]
    if ($DestinoInfo -ne $null) {
        $Icono = if ($Destino -eq $DestinationPaths[-1]) { "└──" } else { "├──" }
        Write-Host "   $Icono $($DestinoInfo.Nombre)  ➡  $Destino" -ForegroundColor $DestinoInfo.Color
    }
}

# ==============================
# 📤 Función para respaldo con barra de progreso y detalles de archivos
# ==============================
function Copy-WithProgress($DestinationPath, $CloudName) {
    $Color = $DestinoColores[$DestinationPath].Color
    
    Write-Host "`n--------------------------------------------------" -ForegroundColor $Color
    Write-Host "🔄 Iniciando respaldo en $CloudName..." -ForegroundColor $Color
    Write-Host "--------------------------------------------------" -ForegroundColor $Color

    $Counter = 0
    $BarLength = 40

    try {
        foreach ($File in $Files) {
            $DestinoCompleto = $File.FullName.Replace($SourcePath, $DestinationPath)
            
            # Crear estructura de carpetas en el destino si no existen
            $DestinoCarpeta = Split-Path -Path $DestinoCompleto -Parent
            if (!(Test-Path $DestinoCarpeta)) { 
                New-Item -Path $DestinoCarpeta -ItemType Directory -Force | Out-Null
            }

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
            $PercentComplete = [math]::Round($Counter * (100 / $Files.Count))
            $Bar = ("█" * ($PercentComplete * $BarLength / 100)) + (" " * ((40 - $PercentComplete * $BarLength / 100)))
            Write-Host "`r[$Bar] $PercentComplete% completado" -NoNewline
        }

        Write-Host "`r[$Bar] 100% completado" -ForegroundColor $Color
        Write-Host "`n✅ Respaldo en $CloudName completado!" -ForegroundColor $Color

        # ==============================
        # 📂 Mostrar archivos modificados agrupados por carpeta
        # ==============================
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
        Write-Host "`n⚠ Error durante la copia en $CloudName." -ForegroundColor Red
    }
}

# ==============================
# 🚀 Ejecutar respaldo en todas las ubicaciones
# ==============================
foreach ($Destino in $DestinationPaths) {
    Copy-WithProgress $Destino $DestinoColores[$Destino].Nombre
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