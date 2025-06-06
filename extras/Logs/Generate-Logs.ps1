# extras\Logs\Generate-Logs.ps1
# -------------------------------------------------------------------
# MODULE: Export-Logs
# Este módulo exporta los registros almacenados en $global:logEntries a varios formatos
# (CSV, JSON, XML, plain text y HTML) y limpia el historial si supera un máximo.
# -------------------------------------------------------------------

function Export-Logs {
    param(
        [Parameter(Mandatory=$true)]
        [array]$LogEntries,
        [int]$MaxLogHistory = 5   # Número máximo de archivos por formato (por defecto, 5)
    )

    # Crear un timestamp para distinguir las exportaciones
    $timestamp = (Get-Date).ToString("yyyyMMdd_HHmm")
    
    # Definir la carpeta raíz para los logs (dentro del directorio de este módulo)
    $logRoot = Join-Path $PSScriptRoot "logs_RunBackupV2"

    # Definir subcarpetas para cada formato
    $subFolders = @{
        csv   = Join-Path $logRoot "csv"
        json  = Join-Path $logRoot "json"
        xml   = Join-Path $logRoot "xml"
        plain = Join-Path $logRoot "log"
        html  = Join-Path $logRoot "html"
    }

    # Crear las subcarpetas si no existen
    foreach ($folder in $subFolders.Values) {
        if (-not (Test-Path $folder)) {
            New-Item -Path $folder -ItemType Directory | Out-Null
        }
    }

    # --- Exportación de Logs ---
    # CSV: Exportar los logs a un archivo CSV
    $csvFile = Join-Path $subFolders.csv ("runbackup_" + $timestamp + ".csv")
    $LogEntries | Export-Csv -Path $csvFile -NoTypeInformation

    # JSON: Exportar los logs a un archivo JSON
    $jsonFile = Join-Path $subFolders.json ("runbackup_" + $timestamp + ".json")
    $LogEntries | ConvertTo-Json -Depth 3 | Out-File $jsonFile -Encoding UTF8

    # XML: Exportar los logs a un archivo XML
    $xmlFile = Join-Path $subFolders.xml ("runbackup_" + $timestamp + ".xml")
    $LogEntries | ConvertTo-Xml -As String -Depth 3 | Out-File $xmlFile -Encoding UTF8

    # Formato Plano: Generar un archivo de log estilo SQL
    $plainFile = Join-Path $subFolders.plain ("runbackup_" + $timestamp + ".log")
    $plainContent = $LogEntries | ForEach-Object {
        "INSERT INTO backup_log (Destination, Subfolder, FileName, OriginalDate, ReplacementDate, State) VALUES ('$($_.Destination)', '$($_.Subfolder)', '$($_.FileName)', '$($_.OriginalDate)', '$($_.ReplacementDate)', '$($_.State)');"
    }
    $plainContent | Out-File $plainFile -Encoding UTF8

    # HTML: Generar un archivo HTML con una tabla que contenga los logs
    $htmlFile = Join-Path $subFolders.html ("runbackup_" + $timestamp + ".html")
    $htmlHeader = @"
<!DOCTYPE html>
<html lang='es'>
<head>
  <meta charset='UTF-8'>
  <title>RunBackup Log - $timestamp</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 20px; }
    table { border-collapse: collapse; width: 100%; }
    th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
    th { background-color: #f2f2f2; }
    tr:nth-child(even) { background-color: #fafafa; }
  </style>
</head>
<body>
  <h2>RunBackup Log - $timestamp</h2>
  <table>
    <thead>
      <tr>
        <th>Destination</th>
        <th>Subfolder</th>
        <th>FileName</th>
        <th>OriginalDate</th>
        <th>ReplacementDate</th>
        <th>State</th>
      </tr>
    </thead>
    <tbody>
"@
    $htmlFooter = @"
    </tbody>
  </table>
</body>
</html>
"@
    $htmlRows = ""
    foreach ($entry in $LogEntries) {
        $htmlRows += "<tr>"
        $htmlRows += "<td>$($entry.Destination)</td>"
        $htmlRows += "<td>$($entry.Subfolder)</td>"
        $htmlRows += "<td>$($entry.FileName)</td>"
        $htmlRows += "<td>$($entry.OriginalDate)</td>"
        $htmlRows += "<td>$($entry.ReplacementDate)</td>"
        $htmlRows += "<td>$($entry.State)</td>"
        $htmlRows += "</tr>`n"
    }
    $htmlContent = $htmlHeader + $htmlRows + $htmlFooter
    $htmlContent | Out-File $htmlFile -Encoding UTF8

    # --- Limpieza del historial de logs ---
    function Manage-LogHistory {
        param(
            [Parameter(Mandatory=$true)][string]$Folder,
            [Parameter(Mandatory=$true)][int]$MaxFiles
        )
        $files = Get-ChildItem -Path $Folder | Sort-Object LastWriteTime
        $fileCount = $files.Count
        if ($fileCount -gt $MaxFiles) {
            $filesToDelete = $files | Select-Object -First ($fileCount - $MaxFiles)
            foreach ($f in $filesToDelete) {
                Remove-Item $f.FullName -Force
            }
        }
    }

    foreach ($folder in $subFolders.Values) {
        Manage-LogHistory -Folder $folder -MaxFiles $MaxLogHistory
    }
    
    # Devolver, opcionalmente, la ruta del archivo HTML generado para referencia
    return $htmlFile
}

# Fin del módulo Export-Logs.
