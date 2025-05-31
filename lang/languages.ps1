# languages.ps1
# ---------------------------------------------------------------------------------
# Este archivo contiene todas las cadenas de texto utilizadas en RunBackup v2,
# organizadas por idioma.
# ---------------------------------------------------------------------------------

$languages = @{
    "spanish"  = @{
        "titleAutoBackup"           = "**INICIANDO RESPALDO AUTOMÁTICO**"
        "labelSource"               = "Origen:"
        "labelDestination"          = "Destinos:"
        
        "errorNoSource"             = "Falta definir la ruta de Origen."
        "errorMultipleSource"       = "NO debe contener múltiples rutas. Especifique solo una ruta de origen."
        "errorNoDestination"        = "No se ha definido ninguna ruta de destino válida."
        "errorInvalidDestination"   = "La ruta de destino es incorrecta: '{0}'"
        
        "labelBackingUp"            = "Respaldando..."
        "labelBackupCompleted"      = "Respaldo completado en:"
        
        "modifiedFilesSection"      = "Archivos modificados en cada destino:"
        "modifiedFilesLabel"        = "Archivos modificados en"
        "folderLabel"               = "Carpeta:"
        "tableHeader"               = "Archivo                                  Fecha Original            Fecha Reemplazo"
        "noData"                    = "No disponible"
        
        "errorSummary"              = "Archivos y destinos con errores: {0}"
        "successMessage"            = "Todos los archivos fueron respaldados correctamente."
        "generalError"              = "Hubo errores durante el respaldo; revise el reporte."
        "exitPrompt"                = "Presione Enter para salir..."
        
        "warningLabel"              = "Advertencia(s):"
        "backupFailed"              = "Backup fallido en:"
        "warningInvalidDestination" = "no es una ruta válida. Especifique una ruta de destino (ej: C:\Users\restino)."
        "noFilesFound"              = "No se encontraron archivos para respaldar."
        "errorDuringBackup"         = "Error en respaldo de"
        "progressCompleted"         = "completed"
        "destination"               = "Destino"
        "folder"                    = "Folder"
        "errorDetected"             = "Error(es) detectado(s):"
        "source"                    = "Origen:"
    }
    "english"  = @{
        "titleAutoBackup"           = "**AUTO BACKUP INITIATED**"
        "labelSource"               = "Source:"
        "labelDestination"          = "Destinations:"
        
        "errorNoSource"             = "Source path not defined."
        "errorMultipleSource"       = "Multiple source paths are not allowed. Please specify only one source path."
        "errorNoDestination"        = "No valid destination path defined."
        "errorInvalidDestination"   = "The destination path is invalid: '{0}'"
        
        "labelBackingUp"            = "Backing up..."
        "labelBackupCompleted"      = "Backup completed in:"
        
        "modifiedFilesSection"      = "Modified files in each destination:"
        "modifiedFilesLabel"        = "Modified files in"
        "folderLabel"               = "Folder:"
        "tableHeader"               = "File                                   Original Date              New Date"
        "noData"                    = "Not available"
        
        "errorSummary"              = "Files and destinations with errors: {0}"
        "successMessage"            = "All files were backed up successfully."
        "generalError"              = "There were errors during backup; please review the report."
        "exitPrompt"                = "Press Enter to exit..."
        
        "warningLabel"              = "Warning(s):"
        "backupFailed"              = "Backup failed in:"
        "warningInvalidDestination" = "is not a valid path. Please specify a destination path (eg: C:\Users\restino)."
        "noFilesFound"              = "No files found for backup."
        "errorDuringBackup"         = "Error during backup of"
        "progressCompleted"         = "completed"
        "destination"               = "Destination"
        "folder"                    = "Folder"
        "errorDetected"             = "Error(s) detected:"
        "source"                    = "Source:"
    }
    "japanese" = @{
        "titleAutoBackup"           = "**自動バックアップ開始**"
        "labelSource"               = "ソース:"
        "labelDestination"          = "宛先:"
        
        "errorNoSource"             = "ソースパスが定義されていません。"
        "errorMultipleSource"       = "複数のソースパスは許可されていません。1つのソースパスのみを指定してください。"
        "errorNoDestination"        = "有効な宛先パスが定義されていません。"
        "errorInvalidDestination"   = "無効な宛先パスです: '{0}'"
        
        "labelBackingUp"            = "バックアップ中..."
        "labelBackupCompleted"      = "バックアップ完了:"
        
        "modifiedFilesSection"      = "各宛先で変更されたファイル:"
        "modifiedFilesLabel"        = "変更されたファイル:"
        "folderLabel"               = "フォルダ:"
        "tableHeader"               = "ファイル名                             変更前の日付              変更後の日付"
        "noData"                    = "利用不可"
        
        "errorSummary"              = "エラーが発生したファイルおよび宛先: {0}"
        "successMessage"            = "すべてのファイルが正常にバックアップされました。"
        "generalError"              = "バックアップ中にエラーが発生しました。レポートを確認してください。"
        "exitPrompt"                = "終了するにはEnterキーを押してください..."
        
        "warningLabel"              = "警告:"
        "backupFailed"              = "バックアップに失敗した宛先:"
        "warningInvalidDestination" = "は有効なパスではありません。有効な宛先パスを指定してください（例: C:\Users\restino）。"
        "noFilesFound"              = "バックアップするファイルが見つかりませんでした。"
        "errorDuringBackup"         = "バックアップ中のエラー:"
        "progressCompleted"         = "完了"
        "destination"               = "宛先"
        "folder"                    = "フォルダ"
        "errorDetected"             = "エラーが検出されました:"
        "source"                    = "ソース:"
    }
    "german"   = @{
        "titleAutoBackup"           = "**AUTO BACKUP INITIIERT**"
        "labelSource"               = "Quelle:"
        "labelDestination"          = "Ziele:"
        
        "errorNoSource"             = "Quellpfad nicht definiert."
        "errorMultipleSource"       = "Mehrere Quellpfade sind nicht erlaubt. Bitte geben Sie nur einen Quellpfad an."
        "errorNoDestination"        = "Kein gültiger Zielpfad definiert."
        "errorInvalidDestination"   = "Der Zielpfad ist ungültig: '{0}'"
        
        "labelBackingUp"            = "Sicherung wird durchgeführt..."
        "labelBackupCompleted"      = "Sicherung abgeschlossen in:"
        
        "modifiedFilesSection"      = "Geänderte Dateien in jedem Ziel:"
        "modifiedFilesLabel"        = "Geänderte Dateien in"
        "folderLabel"               = "Ordner:"
        "tableHeader"               = "Datei                                  Ursprüngliches Datum          Neues Datum"
        "noData"                    = "Nicht verfügbar"
        
        "errorSummary"              = "Fehler bei Dateien und Zielen: {0}"
        "successMessage"            = "Alle Dateien wurden erfolgreich gesichert."
        "generalError"              = "Beim Backup traten Fehler auf; überprüfen Sie den Bericht."
        "exitPrompt"                = "Drücken Sie Enter zum Beenden..."
        
        "warningLabel"              = "Warnung:"
        "backupFailed"              = "Backup fehlgeschlagen in:"
        "warningInvalidDestination" = "ist kein gültiger Pfad. Bitte geben Sie einen gültigen Zielpfad an (z.B. C:\Users\restino)."
        "noFilesFound"              = "Keine Dateien zum Sichern gefunden."
        "errorDuringBackup"         = "Fehler beim Sichern von"
        "progressCompleted"         = "abgeschlossen"
        "destination"               = "Ziel"
        "folder"                    = "Ordner"
        "errorDetected"             = "Fehler wurden erkannt:"
        "source"                    = "Quelle:"
    }
}
