<#
.SYNOPSIS
  Valida si la ruta de origen contiene archivos para respaldar.
.DESCRIPTION
  Verifica si en la ruta de origen existen archivos. Si no se encuentran,
  muestra una notificación de error usando Show-ErrorNotification y retorna $false.
  En caso contrario, retorna $true.
.NOTAS
  Se asume que se pasa la variable $msg con los textos localizados.
  Este script se encuentra en extras\notifications.
.PARAMETER sourcePath
  Ruta de origen a evaluar.
.PARAMETER msg
  Objeto con los textos localizados.
.EXAMPLE
  $valid = .\Validate-Source.ps1 -sourcePath "C:\MiRutaOrigen" -msg $msg
#>
param (
    [Parameter(Mandatory=$true)]
    [string]$sourcePath,
    [Parameter(Mandatory=$true)]
    [psobject]$msg
)

# --- Asegurarse de que las funciones de notificación están cargadas ---
if (-not (Get-Command Show-ErrorNotification -ErrorAction SilentlyContinue)) {
    # Asumimos que notifications.ps1 está en la misma carpeta que este script.
    $notifModule = Join-Path $PSScriptRoot "notifications.ps1"
    if (Test-Path $notifModule) {
        . $notifModule
    }
    else {
        Write-Host "El módulo de notificaciones no se encontró en $PSScriptRoot." -ForegroundColor Yellow
    }
}

# --- Validar la existencia de archivos en la ruta de origen ---
$files = Get-ChildItem -Path $sourcePath -Recurse -File -ErrorAction SilentlyContinue
if (-not $files) {
    # Si no se encuentran archivos, se muestra la notificación de error.
    Show-ErrorNotification -TitleKey "notificationNoFilesTitle" -MessageKey "notificationNoFilesMessage"
    return $false
}
return $true
