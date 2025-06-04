# ---------------------------------------------------------------------------------
# Este archivo contiene todas las cadenas de texto utilizadas en RunBackup v2,
# organizadas por idioma, y una colección global de símbolos/emoticonos.
# ---------------------------------------------------------------------------------

$globalSymbols = @{
    "folder"   = "📂"
    "cloud"    = "☁"
    "warning"  = "⚠"
    "success"  = "✅"
    "error"    = "❌"
    "sidekick" = "🔹"
    "reload"   = "🔄"
    "storage"  = "💾"
    "bold"     = "**"
    "colon"    = ":"
    "ellipsis" = "..."
    "dash"     = "-"
}

$languages = @{
    "spanish" = @{
        # -----------------------------
        # Textos Generales
        # -----------------------------
        "titleAutoBackup"            = "INICIANDO RESPALDO AUTOMÁTICO"
        "labelSource"                = "Origen"
        "destSingular"               = "Destino"
        "destPlural"                 = "Destino(s)"
        
        # -----------------------------
        # Errores de Validación
        # -----------------------------
        "errorNoSource"              = "Falta definir la ruta de Origen."
        "errorMultipleSource"        = "NO debe contener múltiples rutas. Especifique solo una ruta de origen."
        "errorNoDestination"         = "No se ha definido ninguna ruta de destino válida."
        "errorInvalidDestination"    = "La ruta de destino es incorrecta"
        "errorAdviceDestination"     = " Especifique una ruta de destino (ej: C:\Users\destino)."
        "errorInvalidPaths"          = "Error: Rutas de origen/destino inválidas."
        
        # -----------------------------
        # Mensajes del Proceso
        # -----------------------------
        "labelBackingUp"             = "Respaldando"
        "labelBackupCompleted"       = "Respaldo completado en"
        "backupSummary"              = "Resumen de Respaldo"
        "summaryLine1"               = "Ya existentes"
        "summaryLine2"               = "Copiados"
        "summaryLine3"               = "No se copiaron"
        
        # -----------------------------
        # Encabezados de Tablas
        # -----------------------------
        "date"                     = "Fecha"
        "originalLabel"            = "original"
        "replacementLabel"         = "reemplazo"
        "tableHeader1"             = "Carpeta"
        "tableHeader2"             = "Archivo"
        "tableHeader5"             = "Estado"
        
        # -----------------------------
        # Otros Textos y Mensajes
        # -----------------------------
        "noFilesFound"             = "No se encontraron archivos para respaldar."
        "errorDuringBackup"        = "Error en respaldo de"
        "progressCompleted"        = "finalizado"
        "exitPrompt"               = "Presione Enter para salir"
        "warningText"              = "Advertencia"
        "errorNotification"        = "No se pudo mostrar la notificación de respaldo completado: "
        "errorOccurred"            = "Se produjo un error: "
        "notApplicable"            = "N/A"
        "noExecuted"               = "No ejecutado"
        
        # -----------------------------
        # Estados para Archivos
        # -----------------------------
        "state_exists"             = "Ya existe"
        "state_copied"             = "Copiado"
        
        # -----------------------------
        # Variables para Nubes
        # -----------------------------
        "cloud_iCloudDrive"        = "iCloudDrive"
        "cloud_OneDrive"           = "OneDrive"
        
        # -----------------------------
        # Errores y Advertencias Adicionales
        # -----------------------------
        "logLabel"                 = "log"
        "errorMissingLogFile"      = "No se pudo generar el log, ya que falta el archivo 'Generate-Logs.ps1'. Para habilitar la generación de logs, descargue y coloque dicho archivo en la carpeta del proyecto."
        
        # -----------------------------
        # Textos para Notificaciones
        # -----------------------------
        "notificationSuccessTitle"     = "Respaldo Exitoso"
        "notificationSuccessMessage"   = "El respaldo se ha completado exitosamente."
        "notificationErrorTitle"       = "Error en Respaldo"
        "notificationErrorMessage"     = "Ocurrió un error durante el respaldo."
        "notificationWarningTitle"     = "Advertencia"
        "notificationWarningMessage"   = "Verifique la configuración del respaldo."
        "notificationSuggestionTitle"  = "Característica Opcional"
        "notificationSuggestionMessage" = "Para notificaciones avanzadas, instale el módulo de notificaciones."
    }
    
    "english" = @{
        # -----------------------------
        # General Texts
        # -----------------------------
        "titleAutoBackup"            = "AUTO BACKUP INITIATED"
        "labelSource"                = "Source"
        "destSingular"               = "Destination"
        "destPlural"                 = "Destination(s)"
        
        # -----------------------------
        # Validation Errors
        # -----------------------------
        "errorNoSource"              = "Source path not defined."
        "errorMultipleSource"        = "Multiple source paths are not allowed. Specify only one source."
        "errorNoDestination"         = "No valid destination path defined."
        "errorInvalidDestination"    = "The destination path is invalid"
        "errorAdviceDestination"     = " Specify a destination path (e.g., C:\Users\destination)."
        "errorInvalidPaths"          = "Error: Invalid source/destination paths."
        
        # -----------------------------
        # Process Labels and Messages
        # -----------------------------
        "labelBackingUp"             = "Backing up"
        "labelBackupCompleted"       = "Backup completed in"
        "backupSummary"              = "Backup Summary"
        "summaryLine1"               = "Already exists"
        "summaryLine2"               = "Copied"
        "summaryLine3"               = "Not copied"
        
        # -----------------------------
        # Table Headers
        # -----------------------------
        "date"                     = "Date"
        "originalLabel"            = "original"
        "replacementLabel"         = "replacement"
        "tableHeader1"             = "Folder"
        "tableHeader2"             = "File"
        "tableHeader5"             = "Status"
        
        # -----------------------------
        # Other Texts
        # -----------------------------
        "noFilesFound"             = "No files found for backup."
        "errorDuringBackup"        = "Error during backup of"
        "progressCompleted"        = "completed"
        "exitPrompt"               = "Press Enter to exit"
        "warningText"              = "Warning"
        "errorNotification"        = "Could not display backup notification: "
        "errorOccurred"            = "An error occurred: "
        "notApplicable"            = "N/A"
        "noExecuted"               = "Not executed"
        
        # -----------------------------
        # File States
        # -----------------------------
        "state_exists"             = "Already exists"
        "state_copied"             = "Copied"
        
        # -----------------------------
        # Cloud Variables
        # -----------------------------
        "cloud_iCloudDrive"        = "iCloudDrive"
        "cloud_OneDrive"           = "OneDrive"
        
        # -----------------------------
        # Additional Errors & Warnings
        # -----------------------------
        "logLabel"                 = "log"
        "errorMissingLogFile"      = "Could not generate log, as 'Generate-Logs.ps1' file is missing. To enable log generation, download and place the file in the project folder."
        
        # -----------------------------
        # Notification Texts
        # -----------------------------
        "notificationSuccessTitle"     = "Backup Successful"
        "notificationSuccessMessage"   = "Your backup completed successfully."
        "notificationErrorTitle"       = "Backup Error"
        "notificationErrorMessage"     = "An error occurred during backup."
        "notificationWarningTitle"     = "Warning"
        "notificationWarningMessage"   = "Please check your backup configuration."
        "notificationSuggestionTitle"  = "Optional Feature"
        "notificationSuggestionMessage" = "For advanced notifications, please install the notifications module."
    }
    
    #FALTA CORREGIR LOS SIGUIENTES IDIOMAS RECORDAR HACERLO MAS TARDE
    "japanese" = @{
        # ==============================
        # 一般的なテキスト (General Texts)
        # ==============================
        "titleAutoBackup"    = "自動バックアップ開始"
        "labelSource"        = "ソース"
        "destSingular"       = "宛先"
        "destPlural"         = "宛先"
        
        # ==============================
        # 検証エラー (Validation Errors)
        # ==============================
        "errorNoSource"      = "ソースパスが定義されていません。"
        "errorMultipleSource"= "複数のソースパスは許可されていません。1つのソースパスのみ指定してください。"
        "errorNoDestination" = "有効な宛先パスが定義されていません。"
        "errorInvalidDestination" = "無効な宛先パスです"
        "errorAdviceDestination"  = " 有効な宛先パスを指定してください（例: C:\Users\destino）。"
        
        # ==============================
        # プロセスのラベル (Process Labels)
        # ==============================
        "labelBackingUp"     = "バックアップ中"
        "labelBackupCompleted" = "バックアップ完了"
        
        # ==============================
        # ファイル表のヘッダー (File Table Headers)
        # ==============================
        "date"               = "日付"
        "originalLabel"      = "変更前"
        "replacementLabel"   = "変更後"
        "tableHeader1"       = "フォルダ"
        "tableHeader2"       = "ファイル"
        "tableHeader5"       = "状態"
        
        # ==============================
        # その他のテキスト (Other Texts)
        # ==============================
        "noFilesFound"       = "バックアップするファイルが見つかりませんでした。"
        "errorDuringBackup"  = "バックアップ中のエラー"
        "progressCompleted"  = "完了"
        "exitPrompt"         = "終了するにはEnterキーを押してください"
        "warningText"        = "警告"
        "backupCompletedHeader" = "バックアップ完了"
        "backupSummary"      = "バックアップ概要"
        "summaryLine1"       = "既存ファイル"
        "summaryLine2"       = "コピーされたファイル"
        "summaryLine3"       = "コピーされなかった"
        "errorSingular"      = "エラー"
        "errorPlural"        = "エラー"
        
        # ==============================
        # クラウド用変数 (Cloud Variables)
        # ==============================
        "cloud_iCloudDrive"  = "iCloudDrive"
        "cloud_OneDrive"     = "OneDrive"

        # ———————————————
        # ファイルの状態
        # ———————————————
        "state_exists"       = "既に存在"
        "state_copied"       = "コピー済み"

        # ==============================
        # その他のエラー (Other Errors)
        # ==============================
        "logLabel" = "ログ"
        "errorMissingLogFile" = "ログを生成できませんでした。'Generate-Logs.ps1'ファイルが欠落しています。ログ生成を有効にするには、このファイルをプロジェクトフォルダにダウンロードして配置してください。"
    }
    
    "german" = @{
        # ==============================
        # Allgemeine Texte (General Texts)
        # ==============================
        "titleAutoBackup"    = "AUTO BACKUP INITIIERT"
        "labelSource"        = "Quelle"
        "destSingular"       = "Ziel"
        "destPlural"         = "Ziel(e)"
        
        # ==============================
        # Validierungsfehler (Validation Errors)
        # ==============================
        "errorNoSource"      = "Quellpfad nicht definiert."
        "errorMultipleSource"= "Mehrere Quellpfade sind nicht erlaubt. Bitte geben Sie nur einen Quellpfad an."
        "errorNoDestination" = "Kein gültiger Zielpfad definiert."
        "errorInvalidDestination" = "Der Zielpfad ist ungültig"
        "errorAdviceDestination"  = " Bitte geben Sie einen gültigen Zielpfad an (z.B. C:\Users\destino)."
        
        # ==============================
        # Prozessbeschriftungen (Process Labels)
        # ==============================
        "labelBackingUp"     = "Sicherung wird durchgeführt"
        "labelBackupCompleted" = "Sicherung abgeschlossen in"
        
        # ==============================
        # Tabellenüberschriften (Table Headers)
        # ==============================
        "date"               = "Datum"
        "originalLabel"      = "ursprünglich"
        "replacementLabel"   = "neu"
        "tableHeader1"       = "Ordner"
        "tableHeader2"       = "Datei"
        "tableHeader5"       = "Status"
        
        # ==============================
        # Weitere Texte (Other Texts)
        # ==============================
        "noFilesFound"       = "Keine Dateien zum Sichern gefunden."
        "errorDuringBackup"  = "Fehler beim Sichern von"
        "progressCompleted"  = "abgeschlossen"
        "exitPrompt"         = "Drücken Sie Enter zum Beenden"
        "warningText"        = "Warnung"
        "backupCompletedHeader" = "Sicherung abgeschlossen in"
        "backupSummary"      = "Sicherungsübersicht"
        "summaryLine1"       = "Existierende Dateien"
        "summaryLine2"       = "Kopierte Dateien"
        "summaryLine3"       = "Nicht kopiert"
        "errorSingular"      = "Fehler"
        "errorPlural"        = "Fehler"
        
        # ==============================
        # Cloud Variablen (Cloud Variables)
        # ==============================
        "cloud_iCloudDrive"  = "iCloudDrive"
        "cloud_OneDrive"     = "OneDrive"

        # ———————————————
        # Dateistatus
        # ———————————————
        "state_exists"       = "Bereits vorhanden"
        "state_copied"       = "Kopiert"

        # ==============================
        # Andere Fehler (Other Errors)
        # ==============================
        "logLabel" = "Log"
        "errorMissingLogFile" = "Das Log konnte nicht generiert werden, da die Datei 'Generate-Logs.ps1' fehlt. Um die Log-Generierung zu aktivieren, laden Sie diese Datei herunter und platzieren Sie sie im Projektordner."
    }
}
