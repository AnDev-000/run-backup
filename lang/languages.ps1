# languages.ps1
# ---------------------------------------------------------------------------------
# Este archivo contiene todas las cadenas de texto utilizadas en RunBackup v2,
# organizadas por idioma. Solo se incluyen aquellos mensajes o etiquetas que 
# varían según el idioma.
#
# Los elementos visuales universales (como iconos, separadores o barras de progreso)
# deben definirse en el script principal (RunBackup.ps1) para mantener la modularidad.
# ---------------------------------------------------------------------------------

$languages = @{
    "spanish" = @{
        # Títulos y etiquetas generales
        "titleAutoBackup"         = "**INICIANDO RESPALDO AUTOMÁTICO**"
        "labelSource"             = "Origen:"
        "labelDestination"        = "Destinos:"

        # Mensajes de error para rutas
        "errorNoSource"           = "Falta definir la ruta de Origen."
        "errorNoDestination"      = "No se ha definido ninguna ruta de destino válida."
        "errorInvalidDestination" = "La ruta de destino es incorrecta: '{0}'"  # {0} se reemplaza por la ruta errónea

        # Proceso de respaldo
        "labelBackingUp"          = "Respaldando..."
        "labelBackupCompleted"    = "Respaldo completado en:"

        # Sección de archivos modificados
        "modifiedFilesSection"    = "Archivos modificados en cada destino:"
        "labelModifiedFiles"      = "Archivos modificados en {0}:"  # {0} = nombre de la carpeta destino
        "folderLabel"             = "Carpeta:"  # Etiqueta para indicar el nombre de la carpeta

        # Reporte en formato tabla
        "tableHeader"             = "Archivo                                  Fecha Original            Fecha Reemplazo"
        "noData"                  = "No disponible"

        # Resumen y mensajes finales
        "errorSummary"            = "Archivos y destinos con errores: {0}"  # {0} se reemplaza por el número de errores
        "successMessage"          = "Todos los archivos fueron respaldados correctamente."
        "generalError"            = "Hubo errores durante el respaldo; revise el reporte."
        "exitPrompt"              = "Presione Enter para salir..."
    }
    "english" = @{
        # Titles and general labels
        "titleAutoBackup"         = "**AUTO BACKUP INITIATED**"
        "labelSource"             = "Source:"
        "labelDestination"        = "Destinations:"

        # Error messages for paths
        "errorNoSource"           = "Source path not defined."
        "errorNoDestination"      = "No valid destination path defined."
        "errorInvalidDestination" = "The destination path is invalid: '{0}'"  # {0} replaced by the invalid path

        # Backup process messages
        "labelBackingUp"          = "Backing up..."
        "labelBackupCompleted"    = "Backup completed in:"

        # Modified files section
        "modifiedFilesSection"    = "Modified files in each destination:"
        "labelModifiedFiles"      = "Modified files in {0}:"  # {0} will be replaced by the destination folder name
        "folderLabel"             = "Folder:"  # Label for folder name

        # Table header for the report
        "tableHeader"             = "File                                   Original Date              New Date"
        "noData"                  = "Not available"

        # Summary and final messages
        "errorSummary"            = "Files and destinations with errors: {0}"  # {0} will be replaced by the number of errors
        "successMessage"          = "All files were backed up successfully."
        "generalError"            = "There were errors during backup; please review the report."
        "exitPrompt"              = "Press Enter to exit..."
    }
}
