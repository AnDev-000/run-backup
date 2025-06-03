# extras/notifications/templates/SuccessfulBackup.ps1
# Este script muestra una notificación simple indicando que el respaldo se completó exitosamente.
# Asegúrate de haber ejecutado Setup.ps1 para tener instalado el módulo BurntToast.

Import-Module BurntToast -ErrorAction Stop

# Opcional: Si tienes un icono personalizado, colócalo en extras/notifications/images (por ejemplo, backup_icon.png)
# y descomenta la siguiente línea:
# $iconPath = (Join-Path -Path $PSScriptRoot -ChildPath "..\images\backup_icon.png")
# New-BurntToastNotification -AppLogo $iconPath -Text "Respaldo completado", "El respaldo se ha completado exitosamente."

# Notificación simple sin imagen:
New-BurntToastNotification -Text "Respaldo completado", "El respaldo se ha completado exitosamente."
