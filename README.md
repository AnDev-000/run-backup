# RunBackup - Script de Respaldo Automático para Emuladores y Archivos

Este proyecto nació de una necesidad personal de crear respaldos automáticos de mis partidas en el emulador PPSSPP. Como el emulador no ofrece respaldo en la nube, debía copiar manualmente mis partidas para mantenerlas respaldadas. Por eso decidí automatizar este proceso con un script en PowerShell que facilita la creación de copias de archivos.

## ¿Qué hace este script?

El script copia recursivamente los archivos desde una carpeta de origen hacia una o más carpetas de destino. En este caso, se utilizo para copiar los archivos de la carpeta SAVEDATA de PPSSPP hacia dos ubicaciones en la nube: iCloud Drive y OneDrive. Así, puedes garantizar que tu progreso en juegos o cualquier otro archivo importante esté protegido y disponible en varios dispositivos.

## ¿Por qué usar este script?

- Automatiza la copia de tus archivos a las rutas que definas.
- Evita perder datos importantes por fallos o pérdidas en el equipo original.
- Es fácilmente adaptable para respaldar cualquier carpeta, no solo partidas de un emulador.

## Requisitos

- Windows con PowerShell instalado.
- Acceso a las carpetas de origen y destino configuradas en el script.

## Uso

1. Modifica las rutas de origen y destino en el archivo `RunBackup.ps1` según tus necesidades, por ejemplo:

```powershell
# Rutas de origen y destino
$SourcePath = "D:\Emuladores\Sony - PlayStation Portable\ppsspp\memstick\PSP\SAVEDATA"
$iCloudDestinationPath = "C:\Users\xxxxx\iCloudDrive\Emuladores\Sony - PlayStation Portable\PPSSPP\memstick\PSP\SAVEDATA"
$OneDriveDestinationPath = "E:\Nube\OneDrive\Emuladores\Sony - PlayStation Portable\ppsspp\memstick\PSP\SAVEDATA"
```

2. Ejecuta el script haciendo clic derecho sobre `RunBackup.ps1` y seleccionando **Ejecutar con PowerShell**.

3. El script mostrará un mensaje confirmando que el respaldo se realizó correctamente.
