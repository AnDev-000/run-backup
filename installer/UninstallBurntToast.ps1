# Este script es para desinstalar BurntToast.
# Haz click derecho en el archivo y selecciona "Ejecutar con PowerShell" para desinstalar el módulo BurntToast de PowerShell.

# ------------------ UNINSTALL: DESINSTALAR BURNTTOAST ------------------
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
