<# 
    Uninstall-BurntToast.ps1
    Script para desinstalar el módulo BurntToast.
    Se recomienda ejecutar este script en una sesión de PowerShell donde el módulo no esté en uso.
#>

try {
    # Si el módulo está cargado en la sesión, se intenta quitarlo.
    if (Get-Module -Name BurntToast) {
        Remove-Module -Name BurntToast -ErrorAction SilentlyContinue
    }
    
    # Verificar si el módulo está instalado en el sistema.
    $moduleInstalled = Get-Module -ListAvailable -Name BurntToast
    if ($moduleInstalled) {
        Write-Host "Desinstalando BurntToast..." -ForegroundColor Yellow
        Uninstall-Module -Name BurntToast -AllVersions -Force
        Write-Host "BurntToast se ha desinstalado correctamente." -ForegroundColor Green
    }
    else {
        Write-Host "BurntToast no está instalado." -ForegroundColor Cyan
    }
}
catch {
    Write-Host "Error al desinstalar BurntToast: $($_.Exception.Message)" -ForegroundColor Red
}
