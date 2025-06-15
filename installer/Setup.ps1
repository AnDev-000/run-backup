# ------------------ SETUP: INSTALAR BURNTTOAST ------------------
$moduleName = "BurntToast"
if (-not (Get-Module -ListAvailable -Name $moduleName)) {
    $spinner = "|/-\"
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = "powershell.exe"
    $psi.Arguments = "-NoProfile -ExecutionPolicy Bypass -Command `"Install-Module -Name $($moduleName) -Scope CurrentUser -Force -AllowClobber`""
    $psi.CreateNoWindow = $true
    $psi.UseShellExecute = $false
    # Mostrar spinner sin mensajes adicionales:
    $process = [System.Diagnostics.Process]::Start($psi)
    while (-not $process.HasExited) {
        for ($i = 0; $i -lt $spinner.Length; $i++) {
            Write-Host -NoNewline ("`r" + $spinner[$i])
            Start-Sleep -Milliseconds 150
        }
    }
    Write-Host "`r" -NoNewline
    # Al finalizar, no se muestra ningún mensaje sobre la instalación.
}
