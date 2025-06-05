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
    
    "japanese" = @{
        # ==============================
        # 一般的なテキスト (General Texts)
        # ==============================
        "titleAutoBackup"            = "自動バックアップを開始中"
        "labelSource"                = "ソース"
        "destSingular"               = "バックアップ先"
        "destPlural"                 = "バックアップ先"
        
        # ==============================
        # バリデーションエラー (Validation Errors)
        # ==============================
        "errorNoSource"              = "ソースパスが定義されていません。"
        "errorMultipleSource"        = "複数のソースパスは許可されていません。一つのソースのみを指定してください。"
        "errorNoDestination"         = "有効なバックアップ先パスが定義されていません。"
        "errorInvalidDestination"    = "バックアップ先のパスが無効です。"
        "errorAdviceDestination"     = " バックアップ先のパスを指定してください（例：C:\Users\destination）。"
        "errorInvalidPaths"          = "エラー：無効なソース/バックアップ先パスです。"
        
        # ==============================
        # プロセスメッセージ (Process Messages)
        # ==============================
        "labelBackingUp"             = "バックアップ中"
        "labelBackupCompleted"       = "バックアップ完了:"
        "backupSummary"              = "バックアップ概要"
        "summaryLine1"               = "既存"
        "summaryLine2"               = "コピー済み"
        "summaryLine3"               = "コピーされなかった"
        
        # ==============================
        # テーブルのヘッダー (Table Headers)
        # ==============================
        "date"                     = "日付"
        "originalLabel"            = "元"
        "replacementLabel"         = "置換"
        "tableHeader1"             = "フォルダ"
        "tableHeader2"             = "ファイル"
        "tableHeader5"             = "状態"
        
        # ==============================
        # その他のテキスト (Other Texts)
        # ==============================
        "noFilesFound"             = "バックアップ対象のファイルが見つかりません。"
        "errorDuringBackup"        = "バックアップ中にエラーが発生しました："
        "progressCompleted"        = "完了"
        "exitPrompt"               = "終了するにはEnterキーを押してください。"
        "warningText"              = "警告"
        "errorNotification"        = "バックアップ完了の通知を表示できませんでした： "
        "errorOccurred"            = "エラーが発生しました："
        "notApplicable"            = "該当なし"
        "noExecuted"               = "未実行"
        
        # ==============================
        # ファイルの状態 (File States)
        # ==============================
        "state_exists"             = "既に存在"
        "state_copied"             = "コピー"
        
        # ==============================
        # クラウド変数 (Cloud Variables)
        # ==============================
        "cloud_iCloudDrive"        = "iCloudDrive"
        "cloud_OneDrive"           = "OneDrive"
        
        # ==============================
        # 追加のエラーと警告 (Additional Errors & Warnings)
        # ==============================
        "logLabel"                 = "log"
        "errorMissingLogFile"      = "'Generate-Logs.ps1' ファイルが見つからないため、ログを生成できませんでした。ログ生成を有効にするには、プロジェクトフォルダにこのファイルをダウンロードして配置してください。"
        
        # ==============================
        # 通知テキスト (Notification Texts)
        # ==============================
        "notificationSuccessTitle"     = "バックアップ成功"
        "notificationSuccessMessage"   = "バックアップが正常に完了しました。"
        "notificationErrorTitle"       = "バックアップエラー"
        "notificationErrorMessage"     = "バックアップ中にエラーが発生しました。"
        "notificationWarningTitle"     = "警告"
        "notificationWarningMessage"   = "バックアップ設定を確認してください。"
        "notificationSuggestionTitle"  = "オプショナル機能"
        "notificationSuggestionMessage" = "高度な通知機能のためには、通知モジュールをインストールしてください。"
    }
    
    "german" = @{
        # ==============================
        # Allgemeine Texte (General Texts)
        # ==============================
        "titleAutoBackup"            = "AUTO BACKUP INITIIERT"
        "labelSource"                = "Quelle"
        "destSingular"               = "Ziel"
        "destPlural"                 = "Ziele"
        
        # ==============================
        # Validierungsfehler (Validation Errors)
        # ==============================
        "errorNoSource"              = "Quellpfad nicht definiert."
        "errorMultipleSource"        = "Mehrere Quellpfade sind nicht erlaubt. Bitte geben Sie nur einen Quellpfad an."
        "errorNoDestination"         = "Kein gültiger Zielpfad definiert."
        "errorInvalidDestination"    = "Der Zielpfad ist ungültig."
        "errorAdviceDestination"     = " Bitte geben Sie einen Zielpfad an (z.B. C:\Users\Ziel)."
        "errorInvalidPaths"          = "Fehler: Ungültige Quell-/Zielpfade."
        
        # ==============================
        # Prozessmeldungen (Process Messages)
        # ==============================
        "labelBackingUp"             = "Sicherung läuft"
        "labelBackupCompleted"       = "Sicherung abgeschlossen in"
        "backupSummary"              = "Sicherungsübersicht"
        "summaryLine1"               = "Bereits vorhanden"
        "summaryLine2"               = "Kopiert"
        "summaryLine3"               = "Nicht kopiert"
        
        # ==============================
        # Tabellenüberschriften (Table Headers)
        # ==============================
        "date"                     = "Datum"
        "originalLabel"            = "Original"
        "replacementLabel"         = "Ersetzung"
        "tableHeader1"             = "Ordner"
        "tableHeader2"             = "Datei"
        "tableHeader5"             = "Status"
        
        # ==============================
        # Weitere Texte und Meldungen (Other Texts)
        # ==============================
        "noFilesFound"             = "Keine Dateien zum Sichern gefunden."
        "errorDuringBackup"        = "Fehler bei Sicherung von"
        "progressCompleted"        = "abgeschlossen"
        "exitPrompt"               = "Drücken Sie die Eingabetaste zum Beenden."
        "warningText"              = "Warnung"
        "errorNotification"        = "Die Benachrichtigung über abgeschlossene Sicherung konnte nicht angezeigt werden: "
        "errorOccurred"            = "Ein Fehler ist aufgetreten: "
        "notApplicable"            = "N/V"
        "noExecuted"               = "Nicht ausgeführt"
        
        # ==============================
        # Datei Status (File States)
        # ==============================
        "state_exists"             = "Bereits vorhanden"
        "state_copied"             = "Kopiert"
        
        # ==============================
        # Cloud Variablen (Cloud Variables)
        # ==============================
        "cloud_iCloudDrive"        = "iCloudDrive"
        "cloud_OneDrive"           = "OneDrive"
        
        # ==============================
        # Zusätzliche Fehler & Warnungen (Additional Errors & Warnings)
        # ==============================
        "logLabel"                 = "log"
        "errorMissingLogFile"      = "Log konnte nicht erstellt werden, da die Datei 'Generate-Logs.ps1' fehlt. Um die Log-Erstellung zu aktivieren, laden Sie bitte die Datei herunter und platzieren Sie sie im Projektordner."
        
        # ==============================
        # Benachrichtigungstexte (Notification Texts)
        # ==============================
        "notificationSuccessTitle"     = "Sicherung erfolgreich"
        "notificationSuccessMessage"   = "Die Sicherung wurde erfolgreich abgeschlossen."
        "notificationErrorTitle"       = "Sicherungsfehler"
        "notificationErrorMessage"     = "Während der Sicherung ist ein Fehler aufgetreten."
        "notificationWarningTitle"     = "Warnung"
        "notificationWarningMessage"   = "Bitte überprüfen Sie Ihre Sicherungskonfiguration."
        "notificationSuggestionTitle"  = "Optionale Funktion"
        "notificationSuggestionMessage" = "Für erweiterte Benachrichtigungen installieren Sie bitte das Benachrichtigungsmodul."
    }
    
    "chinese" = @{
        # -----------------------------
        # 通用文本 (General Texts)
        # -----------------------------
        "titleAutoBackup"            = "自动备份启动"
        "labelSource"                = "源"
        "destSingular"               = "目标"
        "destPlural"                 = "目标(多个)"
        
        # -----------------------------
        # 验证错误 (Validation Errors)
        # -----------------------------
        "errorNoSource"              = "未定义源路径."
        "errorMultipleSource"        = "不允许包含多个路径。请仅指定一个源路径."
        "errorNoDestination"         = "未定义有效的目标路径."
        "errorInvalidDestination"    = "目标路径不正确"
        "errorAdviceDestination"     = " 请指定一个目标路径（例如：C:\Users\destination）."
        "errorInvalidPaths"          = "错误: 无效的源/目标路径."
        
        # -----------------------------
        # 处理信息 (Process Messages)
        # -----------------------------
        "labelBackingUp"             = "正在备份"
        "labelBackupCompleted"       = "备份完成于"
        "backupSummary"              = "备份摘要"
        "summaryLine1"               = "已存在"
        "summaryLine2"               = "已复制"
        "summaryLine3"               = "未复制"
        
        # -----------------------------
        # 表头 (Table Headers)
        # -----------------------------
        "date"                     = "日期"
        "originalLabel"            = "原始"
        "replacementLabel"         = "替换"
        "tableHeader1"             = "文件夹"
        "tableHeader2"             = "文件"
        "tableHeader5"             = "状态"
        
        # -----------------------------
        # 其他文本 (Other Texts)
        # -----------------------------
        "noFilesFound"             = "未找到可备份的文件."
        "errorDuringBackup"        = "备份时出错:"
        "progressCompleted"        = "完成"
        "exitPrompt"               = "按Enter键退出"
        "warningText"              = "警告"
        "errorNotification"        = "无法显示备份完成通知: "
        "errorOccurred"            = "发生错误: "
        "notApplicable"            = "不适用"
        "noExecuted"               = "未执行"
        
        # -----------------------------
        # 文件状态 (File States)
        # -----------------------------
        "state_exists"             = "已存在"
        "state_copied"             = "已复制"
        
        # -----------------------------
        # 云变量 (Cloud Variables)
        # -----------------------------
        "cloud_iCloudDrive"        = "iCloudDrive"
        "cloud_OneDrive"           = "OneDrive"
        
        # -----------------------------
        # 附加错误和警告 (Additional Errors & Warnings)
        # -----------------------------
        "logLabel"                 = "日志"
        "errorMissingLogFile"      = "无法生成日志，因为缺少 'Generate-Logs.ps1' 文件。要启用日志生成，请下载该文件并将其放置在项目文件夹中."
        
        # -----------------------------
        # 通知文本 (Notification Texts)
        # -----------------------------
        "notificationSuccessTitle"     = "备份成功"
        "notificationSuccessMessage"   = "备份成功完成."
        "notificationErrorTitle"       = "备份错误"
        "notificationErrorMessage"     = "备份过程中发生错误."
        "notificationWarningTitle"     = "警告"
        "notificationWarningMessage"   = "请检查备份配置."
        "notificationSuggestionTitle"  = "可选功能"
        "notificationSuggestionMessage" = "要使用高级通知，请安装通知模块."
    }
}
