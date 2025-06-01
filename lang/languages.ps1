# languages.ps1
# ---------------------------------------------------------------------------------
# Este archivo contiene todas las cadenas de texto utilizadas en RunBackup v2,
# organizadas por idioma, y una colección global de símbolos/emoticonos.
# ---------------------------------------------------------------------------------

# ==============================
# Global Symbols (Simbolos Globales)
# ==============================
$globalSymbols = @{
    # Emoticonos usados en RunBackup (sin espacios adjuntos)
    "folder"   = "📂"
    "cloud"    = "☁"
    "warning"  = "⚠"
    "success"  = "✅"
    "error"    = "❌"
    "sidekick" = "🔹"
    "reload"   = "🔄"
    "storage"  = "💾"
    # Símbolos comunes
    "bold"     = "**"
    "colon"    = ":"
    "ellipsis" = "..."
}

# ==============================
# Language Strings
# ==============================
$languages = @{
    "spanish" = @{
        # ==============================
        # Textos Generales
        # ==============================
        "titleAutoBackup"    = "INICIANDO RESPALDO AUTOMÁTICO"
        "labelSource"        = "Origen"
        "destSingular"       = "Destino"
        "destPlural"         = "Destino(s)"
        
        # ==============================
        # Errores de Validación
        # ==============================
        "errorNoSource"      = "Falta definir la ruta de Origen."
        "errorMultipleSource"= "NO debe contener múltiples rutas. Especifique solo una ruta de origen."
        "errorNoDestination" = "No se ha definido ninguna ruta de destino válida."
        "errorInvalidDestination" = "La ruta de destino es incorrecta"
        "errorAdviceDestination"  = " Especifique una ruta de destino (ej: C:\Users\destino)."
        
        # ==============================
        # Etiquetas y Mensajes del Proceso
        # ==============================
        "labelBackingUp"     = "Respaldando"
        "labelBackupCompleted" = "Respaldo completado en"
        
        # ==============================
        # Encabezados de la Tabla de Archivos
        # ==============================
        "date"               = "Fecha"
        "originalLabel"      = "original"
        "replacementLabel"   = "reemplazo"
        "tableHeader1"       = "Carpeta"
        "tableHeader2"       = "Archivo"
        "tableHeader5"       = "Estado"
        
        # ==============================
        # Otros Textos
        # ==============================
        "noFilesFound"       = "No se encontraron archivos para respaldar."
        "errorDuringBackup"  = "Error en respaldo de"
        "progressCompleted"  = "finalizado"
        "exitPrompt"         = "Presione Enter para salir"
        "warningText"        = "Advertencia"
        "backupCompletedHeader" = "Respaldo completado en"
        "backupSummary"      = "Resumen de Respaldo"
        "summaryLine1"       = "Ya existentes"
        "summaryLine2"       = "Copiados"
        "summaryLine3"       = "No se copiaron"
        "errorSingular"      = "error"
        "errorPlural"        = "error(es)"
        
        # ==============================
        # Variables para Nubes
        # ==============================
        "cloud_iCloudDrive"  = "iCloudDrive"
        "cloud_OneDrive"     = "OneDrive"
        # ———————————————
        # Estados para archivos
        # ———————————————
        "state_exists"       = "Ya existe"
        "state_copied"       = "Copiado"
    }
    
    "english" = @{
        # ==============================
        # General Texts
        # ==============================
        "titleAutoBackup"    = "AUTO BACKUP INITIATED"
        "labelSource"        = "Source"
        "destSingular"       = "Destination"
        "destPlural"         = "Destination(s)"
        
        # ==============================
        # Validation Errors
        # ==============================
        "errorNoSource"      = "Source path not defined."
        "errorMultipleSource"= "Multiple source paths are not allowed. Please specify only one source path."
        "errorNoDestination" = "No valid destination path defined."
        "errorInvalidDestination" = "The destination path is invalid"
        "errorAdviceDestination"  = " Specify a destination path (eg: C:\Users\destino)."
        
        # ==============================
        # Process Labels and Messages
        # ==============================
        "labelBackingUp"     = "Backing up"
        "labelBackupCompleted" = "Backup completed in"
        
        # ==============================
        # File Table Headers
        # ==============================
        "date"               = "Date"
        "originalLabel"      = "Original"
        "replacementLabel"   = "New"
        "tableHeader1"       = "Folder"
        "tableHeader2"       = "File"
        "tableHeader5"       = "Status"
        
        # ==============================
        # Other Texts
        # ==============================
        "noFilesFound"       = "No files found for backup."
        "errorDuringBackup"  = "Error during backup of"
        "progressCompleted"  = "completed"
        "exitPrompt"         = "Press Enter to exit"
        "warningText"        = "Warning"
        "backupCompletedHeader" = "Backup completed in"
        "backupSummary"      = "Backup Summary"
        "summaryLine1"       = "Already existing"
        "summaryLine2"       = "Copied"
        "summaryLine3"       = "Not copied"
        "errorSingular"      = "error"
        "errorPlural"        = "error(s)"
        
        # ==============================
        # Cloud Variables
        # ==============================
        "cloud_iCloudDrive"  = "iCloudDrive"
        "cloud_OneDrive"     = "OneDrive"

        # ———————————————
        # File States
        # ———————————————
        "state_exists"       = "Already exists"  # O bien "Exists" según prefieras
        "state_copied"       = "Copied"
    }
    
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
    }
}
