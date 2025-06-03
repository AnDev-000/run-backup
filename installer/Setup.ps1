# installer/Setup.ps1
Write-Host "Verificando dependencias..." -ForegroundColor Cyan

$moduleName = "BurntToast"
if (-not (Get-Module -ListAvailable -Name $moduleName)) {
    Write-Host "El módulo $($moduleName) no está instalado. Instalando..." -ForegroundColor Yellow
    try {
        Install-Module -Name $moduleName -Force -Scope CurrentUser -AllowClobber
        Write-Host "Módulo $($moduleName) instalado correctamente." -ForegroundColor Green
    }
    catch {
        Write-Host "Error al instalar $($moduleName): $($_.Exception.Message)" -ForegroundColor Red
    }
}
else {
    Write-Host "El módulo $($moduleName) ya está instalado." -ForegroundColor Green
}

Write-Host "Instalación y verificación de dependencias completadas." -ForegroundColor Cyan
