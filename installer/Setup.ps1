# Este script instala el módulo BurntToast de PowerShell para notificaciones en Windows 10 y 11.
# se ejecuta de modo silencioso y sin mostrar mensajes adicionales.
# Requiere permisos de administrador para instalar el módulo.

# ------------------ SETUP: INSTALAR BURNTTOAST ------------------
$moduleName = "BurntToast"
if (-not (Get-Module -ListAvailable -Name $moduleName)) {
    $spinner = "|/-\"
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = "powershell.exe"
    $psi.Arguments = "-NoProfile -ExecutionPolicy Bypass -Command `"Install-Module -Name $($moduleName) -Scope CurrentUser -Force -AllowClobber`""
    $psi.CreateNoWindow = $true
    $psi.UseShellExecute = $false

    # Ejecutar la instalación de BurntToast se mostrara un spinner durante la instalación.
    $process = [System.Diagnostics.Process]::Start($psi)
    while (-not $process.HasExited) {
        for ($i = 0; $i -lt $spinner.Length; $i++) {
            Write-Host -NoNewline ("`r" + $spinner[$i])
            Start-Sleep -Milliseconds 150
        }
    }
    Write-Host "`r" -NoNewline
    # Finaliza la instalación sin mostrar mensaje adicional.
}
