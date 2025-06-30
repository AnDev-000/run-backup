# ------------------ CARGA DE LENGUAJES ------------------
# Este script define los textos utilizados en el script runbackup.
# si desea agregar un nuevo idioma, simplemente copie el bloque de un idioma existente y modifique los textos.

# ------------------ SÍMBOLOS GLOBALES ------------------
# Los símbolos globales se utilizan para representar diferentes elementos en la interfaz de usuario.
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

# ------------------ TEXTOS POR IDIOMA ------------------
$languages = @{

    # ------------------ Textos generales (Spanish) ------------------
    "spanish" = @{
        
        # Encabezados y títulos
        "titleAutoBackup"          = "INICIANDO RESPALDO AUTOMÁTICO"
        "labelSource"              = "Origen"
        
        # Términos con variación singular/plural (agrupados)
        "destination" = @{
            "label" = @{
                "singular" = "Destino"
                "plural"   = "Destinos"
            }
            "invalidMessage" = @{
                "singular" = " es incorrecto, vuelva a ingresarlo correctamente."
                "plural"   = " son incorrectos, vuelva a ingresarlos correctamente."
            }
        }
        
        # ------------------ Errores de validación ------------------
        "errorNoSource"            = "Falta definir la ruta de Origen."
        "errorMultipleSource"      = "NO debe contener múltiples rutas. Especifique solo una ruta de origen."
        "errorNoDestination"       = "No se ha definido ninguna ruta de destino válida."
        "errorInvalidDestination"  = "La ruta de destino es incorrecta"
        "errorAdviceDestination"   = " Especifique una ruta de destino (ej: C:\Users\destino)."
        "errorInvalidPaths"        = "Error: Rutas de origen/destino inválidas."
        
        # ------------------ Mensajes del proceso ------------------
        "labelBackingUp"           = "Respaldando"
        "labelBackupCompleted"     = "Respaldo completado en"
        "backupSummary"            = "Resumen de Respaldo"
        "summaryLine1"             = "Ya existentes"
        "summaryLine2"             = "Copiados"
        "summaryLine3"             = "No se copiaron"
        
        # ------------------ Encabezados de tablas ------------------
        "date"                   = "Fecha"
        "originalLabel"          = "original"
        "replacementLabel"       = "reemplazo"
        "tableHeader1"           = "Carpeta"
        "tableHeader2"           = "Archivo"
        "tableHeader5"           = "Estado"
        
        # ------------------ Otros textos y mensajes ------------------
        "noFilesFound"           = "No se encontraron archivos para respaldar."
        "errorDuringBackup"      = "Error en respaldo de"
        "progressCompleted"      = "finalizado"
        "exitPrompt"             = "Presiona cualquier tecla para salir..."
        "warningText"            = "Advertencia"
        "errorNotification"      = "No se pudo mostrar la notificación de respaldo completado: "
        "errorOccurred"          = "Se produjo un error: "
        "notApplicable"          = "N/A"
        "noExecuted"             = "No ejecutado"
        
        # ------------------ Estados para archivos ------------------
        "state_exists"           = "Ya existe"
        "state_copied"           = "Copiado"
        "state_not_copied"       = "No copiado"
        
        # ------------------ Variables para nubes ------------------
        "cloud_iCloudDrive"      = "iCloudDrive"
        "cloud_OneDrive"         = "OneDrive"
        
        # ------------------ Advertencias de módulos ------------------
        "logLabel"               = "Log"
        "notificationsLabel"     = "Notificaciones"
        "errorMissingLogFile"    = "No se pudo generar el log, ya que falta el archivo 'Generate-Logs.psm1'. Para habilitar la generación de logs, descargue y coloque dicho archivo en la carpeta del proyecto."
        "logModuleMissing"       = "Módulo de logs no instalado. Continuando sin generación de logs."
        
        # ------------------ Notificaciones del sistema ------------------
        "notificationSuccessTitle"      = "Respaldo Exitoso"
        "notificationSuccessMessage"    = "El respaldo se ha completado exitosamente."
        "notificationErrorTitle"        = "Error en Respaldo"
        "notificationErrorMessage"      = "Ocurrió un error durante el respaldo."
        "notificationWarningTitle"      = "Advertencia"
        "notificationWarningMessage"    = "Verifique la configuración del respaldo."
        "notificationSuggestionTitle"   = "Característica Opcional"
        "notificationSuggestionMessage" = "Para notificaciones avanzadas, instale el módulo de notificaciones."
        "notificationNoSourceTitle"     = "Falta definir la ruta de Origen"
        "notificationNoSourceMessage"   = "No se ha definido la ruta de Origen. Por favor, revise la configuración."
        "notificationInvalidSourceTitle"= "Ruta Origen Mal Definida"
        "notificationInvalidSourceMessage" = "NO debe contener múltiples rutas. Especifique solo una ruta de origen."
        "notificationNoDestinationTitle"= "Ruta Destino Indefinida"
        "notificationNoDestinationMessage" = "No se ha definido ninguna ruta de destino válida. Configure al menos un destino e intente nuevamente."
        "notificationPartialSuccessTitle" = "Respaldo Parcialmente Exitoso"
        "notificationPartialSuccessMessage" = "El respaldo se completó en su mayoría, pero se presentaron advertencias en algunos destinos. Revise la configuración."
        "notificationNoFilesTitle"      = "No Hay Archivos para Respaldar"
        "notificationNoFilesMessage"    = "No se encontraron archivos para respaldar. Verifique la ruta de origen."
        "notificationLogErrorTitle"     = "Error en la Generación del Log"
        "notificationLogErrorMessage"   = "No se pudo generar el log correctamente. Asegúrese de que 'Generate-Logs.psm1' esté presente en la carpeta del proyecto."
        "notificationModuleMissing"     = "Módulo de notificaciones no instalado. Continuando sin notificaciones."
        "notificationInstallerMissing"  = "Falta la carpeta installer para instalar las dependencias del módulo de notificaciones."
        "notificationDestinationNotWritableMessage" = "No se ha podido copiar a la ruta de destino."

        # ------------------ Notificación de destino inválido ------------------
        "notificationInvalidDestination" = @{
            "title"   = "Advertencia de ruta(s) incorrecta(s)"
            "message" = @{
                "singular" = " es incorrecta, vuelva a ingresarla correctamente."
                "plural"   = " son incorrectas, vuelva a ingresarlas correctamente."
            }
        }
        
        # ------------------ Otros términos con variación singular/plural ------------------
        "error" = @{
            "singular" = "error"
            "plural"   = "errores"
        }
        "file" = @{
            "singular" = "Archivo"
            "plural"   = "Archivos"
        }
        "path" = @{
            "singular" = "Ruta"
            "plural"   = "Rutas"
        }
    }
    "english" = @{

        # ------------------ General Texts (English) ------------------
        # Headers and Titles
        "titleAutoBackup"          = "STARTING AUTOMATIC BACKUP"
        "labelSource"              = "Source"

        # Terms with singular/plural variation (grouped)
        "destination" = @{
            "label" = @{
                "singular" = "Destination"
                "plural"   = "Destinations"
            }
            "invalidMessage" = @{
                "singular" = " is invalid, please enter it correctly."
                "plural"   = " are invalid, please enter them correctly."
            }
        }

        # ------------------ Validation Errors ------------------
        "errorNoSource"            = "Source path is missing."
        "errorMultipleSource"      = "Must not contain multiple paths. Specify only one source path."
        "errorNoDestination"       = "No valid destination path defined."
        "errorInvalidDestination"  = "The destination path is invalid."
        "errorAdviceDestination"   = " Please specify a destination path (e.g.: C:\Users\destination)."
        "errorInvalidPaths"        = "Error: Invalid source/destination paths."

        # ------------------ Process Messages ------------------
        "labelBackingUp"           = "Backing up"
        "labelBackupCompleted"     = "Backup completed at"
        "backupSummary"            = "Backup Summary"
        "summaryLine1"             = "Already existing"
        "summaryLine2"             = "Copied"
        "summaryLine3"             = "Not copied"

        # ------------------ Table Headers ------------------
        "date"                     = "Date"
        "originalLabel"            = "original"
        "replacementLabel"         = "replacement"
        "tableHeader1"             = "Folder"
        "tableHeader2"             = "File"
        "tableHeader5"             = "Status"

        # ------------------ Other Texts and Messages ------------------
        "noFilesFound"             = "No files found to back up."
        "errorDuringBackup"        = "Error backing up"
        "progressCompleted"        = "completed"
        "exitPrompt"               = "Press any key to exit..."
        "warningText"              = "Warning"
        "errorNotification"        = "Could not show backup completed notification: "
        "errorOccurred"            = "An error occurred: "
        "notApplicable"            = "N/A"
        "noExecuted"               = "Not executed"

        # ------------------ File States ------------------
        "state_exists"             = "Already exists"
        "state_copied"             = "Copied"
        "state_not_copied"         = "Not copied"

        # ------------------ Variables for Clouds ------------------
        "cloud_iCloudDrive"        = "iCloudDrive"
        "cloud_OneDrive"           = "OneDrive"

        # ------------------ Module Warnings ------------------
        "logLabel"                 = "Log"
        "notificationsLabel"       = "Notifications"
        "errorMissingLogFile"      = "Could not generate the log because the 'Generate-Logs.psm1' file is missing. To enable log generation, download and place that file in the project folder."
        "logModuleMissing"         = "Log module not installed. Continuing without log generation."

        # ------------------ System Notifications ------------------
        "notificationSuccessTitle"        = "Backup Successful"
        "notificationSuccessMessage"      = "The backup has completed successfully."
        "notificationErrorTitle"          = "Backup Error"
        "notificationErrorMessage"        = "An error occurred during the backup."
        "notificationWarningTitle"        = "Warning"
        "notificationWarningMessage"      = "Please check the backup settings."
        "notificationSuggestionTitle"     = "Optional Feature"
        "notificationSuggestionMessage"   = "To enable advanced notifications, install the notifications module."
        "notificationNoSourceTitle"       = "Missing Source Path"
        "notificationNoSourceMessage"     = "No source path defined. Please check the configuration."
        "notificationInvalidSourceTitle"  = "Invalid Source Path"
        "notificationInvalidSourceMessage"= "Must not contain multiple paths. Specify only one source path."
        "notificationNoDestinationTitle"  = "Undefined Destination Path"
        "notificationNoDestinationMessage"= "No valid destination path defined. Configure at least one destination and try again."
        "notificationPartialSuccessTitle" = "Partially Successful Backup"
        "notificationPartialSuccessMessage" = "The backup completed mostly successfully, but there were warnings for some destinations. Please review the configuration."
        "notificationNoFilesTitle"        = "No Files to Back Up"
        "notificationNoFilesMessage"      = "No files found to back up. Please check the source path."
        "notificationLogErrorTitle"       = "Log Generation Error"
        "notificationLogErrorMessage"     = "Could not generate the log correctly. Ensure 'Generate-Logs.psm1' is present in the project folder."
        "notificationModuleMissing"       = "Notifications module not installed. Continuing without notifications."
        "notificationInstallerMissing"    = "Installer folder is missing for installing notifications module dependencies."
        "notificationDestinationNotWritableMessage" = "Could not copy to the destination path."

        # ------------------ Invalid Destination Notification ------------------
        "notificationInvalidDestination" = @{
            "title"   = "Invalid Path Warning"
            "message" = @{
                "singular" = " is invalid, please enter it correctly."
                "plural"   = " are invalid, please enter them correctly."
            }
        }

        # ------------------ Other Terms with Singular/Plural Variation ------------------
        "error" = @{
            "singular" = "error"
            "plural"   = "errors"
        }
        "file" = @{
            "singular" = "File"
            "plural"   = "Files"
        }
        "path" = @{
            "singular" = "Path"
            "plural"   = "Paths"
        }
    }


    "japanese" = @{

        # ------------------ 一般的なテキスト (General Texts) ------------------
        # 見出しとタイトル (Headers and Titles)
        "titleAutoBackup"          = "自動バックアップを開始しています"
        "labelSource"              = "ソース"

        # 単数/複数の変動がある用語 (Terms with singular/plural variation)
        "destination" = @{
            "label" = @{
                "singular" = "宛先"
                "plural"   = "宛先"
            }
            "invalidMessage" = @{
                "singular" = "が無効です。正しく入力してください。"
                "plural"   = "が無効です。正しく入力してください。"
            }
        }

        # ------------------ 検証エラー (Validation Errors) ------------------
        "errorNoSource"            = "ソースパスが未定義です。"
        "errorMultipleSource"      = "複数のパスを含めることはできません。ソースパスは1つだけ指定してください。"
        "errorNoDestination"       = "有効な宛先パスが定義されていません。"
        "errorInvalidDestination"  = "宛先パスが無効です。"
        "errorAdviceDestination"   = " 宛先パスを指定してください (例: C:\Users\destination)。"
        "errorInvalidPaths"        = "エラー: ソース/宛先パスが無効です。"

        # ------------------ 処理メッセージ (Process Messages) ------------------
        "labelBackingUp"           = "バックアップ中"
        "labelBackupCompleted"     = "バックアップ完了:"
        "backupSummary"            = "バックアップサマリー"
        "summaryLine1"             = "既存"
        "summaryLine2"             = "コピー済み"
        "summaryLine3"             = "コピーされていない"

        # ------------------ テーブルヘッダー (Table Headers) ------------------
        "date"                     = "日付"
        "originalLabel"            = "元"
        "replacementLabel"         = "置換後"
        "tableHeader1"             = "フォルダー"
        "tableHeader2"             = "ファイル"
        "tableHeader5"             = "状態"

        # ------------------ その他のテキストとメッセージ (Other Texts and Messages) ------------------
        "noFilesFound"             = "バックアップするファイルが見つかりません。"
        "errorDuringBackup"        = "バックアップエラー: "
        "progressCompleted"        = "完了"
        "exitPrompt"               = "終了するには何かキーを押してください..."
        "warningText"              = "警告"
        "errorNotification"        = "バックアップ完了の通知を表示できませんでした: "
        "errorOccurred"            = "エラーが発生しました: "
        "notApplicable"            = "該当なし"
        "noExecuted"               = "未実行"

        # ------------------ ファイル状態 (File States) ------------------
        "state_exists"             = "既に存在"
        "state_copied"             = "コピー済み"
        "state_not_copied"         = "コピーされず"

        # ------------------ クラウド用変数 (Variables for Clouds) ------------------
        "cloud_iCloudDrive"        = "iCloudDrive"
        "cloud_OneDrive"           = "OneDrive"

        # ------------------ モジュール警告 (Module Warnings) ------------------
        "logLabel"                 = "ログ"
        "notificationsLabel"       = "通知"
        "errorMissingLogFile"      = "'Generate-Logs.psm1'ファイルが見つからないため、ログを生成できませんでした。ログ生成を有効にするには、当該ファイルをプロジェクトフォルダーに配置してください。"
        "logModuleMissing"         = "ログモジュールがインストールされていません。ログ生成なしで継続します。"

        # ------------------ システム通知 (System Notifications) ------------------
        "notificationSuccessTitle"        = "バックアップ成功"
        "notificationSuccessMessage"      = "バックアップが正常に完了しました。"
        "notificationErrorTitle"          = "バックアップエラー"
        "notificationErrorMessage"        = "バックアップ中にエラーが発生しました。"
        "notificationWarningTitle"        = "警告"
        "notificationWarningMessage"      = "バックアップ設定を確認してください。"
        "notificationSuggestionTitle"     = "オプション機能"
        "notificationSuggestionMessage"   = "高度な通知を有効にするには、通知モジュールをインストールしてください。"
        "notificationNoSourceTitle"       = "ソースパスが未定義"
        "notificationNoSourceMessage"     = "ソースパスが定義されていません。設定を確認してください。"
        "notificationInvalidSourceTitle"  = "無効なソースパス"
        "notificationInvalidSourceMessage"= "複数のパスを含めることはできません。ソースパスは1つだけ指定してください。"
        "notificationNoDestinationTitle"  = "宛先パスが未定義"
        "notificationNoDestinationMessage"= "有効な宛先パスが定義されていません。少なくとも1つの宛先を設定して再試行してください。"
        "notificationPartialSuccessTitle" = "バックアップ部分的成功"
        "notificationPartialSuccessMessage" = "ほとんど正常に完了しましたが、一部の宛先で警告が発生しました。設定を確認してください。"
        "notificationNoFilesTitle"        = "バックアップするファイルなし"
        "notificationNoFilesMessage"      = "バックアップするファイルが見つかりません。ソースパスを確認してください。"
        "notificationLogErrorTitle"       = "ログ生成エラー"
        "notificationLogErrorMessage"     = "ログを正しく生成できませんでした。'Generate-Logs.psm1'がプロジェクトフォルダーにあることを確認してください。"
        "notificationModuleMissing"       = "通知モジュールがインストールされていません。通知なしで継続します。"
        "notificationInstallerMissing"    = "通知モジュールの依存関係をインストールするためのinstallerフォルダーがありません。"
        "notificationDestinationNotWritableMessage" = "宛先パスにコピーできませんでした。"

        # ------------------ 無効な宛先通知 (Invalid Destination Notification) ------------------
        "notificationInvalidDestination" = @{
            "title"   = "無効なパスの警告"
            "message" = @{
                "singular" = "が無効です。正しく入力してください。"
                "plural"   = "が無効です。正しく入力してください。"
            }
        }

        # ------------------ 他の単数/複数変動用語 (Other Terms with Singular/Plural Variation) ------------------
        "error" = @{
            "singular" = "エラー"
            "plural"   = "エラー"
        }
        "file" = @{
            "singular" = "ファイル"
            "plural"   = "ファイル"
        }
        "path" = @{
            "singular" = "パス"
            "plural"   = "パス"
        }
    }

    "german" = @{

        # ------------------ Allgemeine Texte (General Texts) ------------------
        # Überschriften und Titel (Headers and Titles)
        "titleAutoBackup"          = "STARTE AUTOMATISCHE SICHERUNG"
        "labelSource"              = "Quelle"

        # Begriffe mit Singular/Plural Variation (Terms with singular/plural variation)
        "destination" = @{
            "label" = @{
                "singular" = "Ziel"
                "plural"   = "Ziele"
            }
            "invalidMessage" = @{
                "singular" = " ist ungültig, bitte geben Sie es korrekt ein."
                "plural"   = " sind ungültig, bitte geben Sie sie korrekt ein."
            }
        }

        # ------------------ Validierungsfehler (Validation Errors) ------------------
        "errorNoSource"            = "Quellpfad fehlt."
        "errorMultipleSource"      = "Darf keine mehrere Pfade enthalten. Bitte nur einen Quellpfad angeben."
        "errorNoDestination"       = "Kein gültiger Zielpfad definiert."
        "errorInvalidDestination"  = "Der Zielpfad ist ungültig."
        "errorAdviceDestination"   = " Bitte geben Sie einen Zielpfad an (z.B.: C:\Users\Ziel)."
        "errorInvalidPaths"        = "Fehler: Ungültige Quell-/Zielpfade."

        # ------------------ Prozessnachrichten (Process Messages) ------------------
        "labelBackingUp"           = "Sichere"
        "labelBackupCompleted"     = "Sicherung abgeschlossen um"
        "backupSummary"            = "Sicherungsübersicht"
        "summaryLine1"             = "Bereits vorhanden"
        "summaryLine2"             = "Kopiert"
        "summaryLine3"             = "Nicht kopiert"

        # ------------------ Tabellenüberschriften (Table Headers) ------------------
        "date"                     = "Datum"
        "originalLabel"            = "Original"
        "replacementLabel"         = "Ersatz"
        "tableHeader1"             = "Ordner"
        "tableHeader2"             = "Datei"
        "tableHeader5"             = "Status"

        # ------------------ Weitere Texte und Nachrichten (Other Texts and Messages) ------------------
        "noFilesFound"             = "Keine Dateien zum Sichern gefunden."
        "errorDuringBackup"        = "Fehler bei der Sicherung von"
        "progressCompleted"        = "abgeschlossen"
        "exitPrompt"               = "Drücken Sie eine beliebige Taste zum Beenden..."
        "warningText"              = "Warnung"
        "errorNotification"        = "Sicherungserfolg-Benachrichtigung konnte nicht angezeigt werden: "
        "errorOccurred"            = "Ein Fehler ist aufgetreten: "
        "notApplicable"            = "k. A."
        "noExecuted"               = "Nicht ausgeführt"

        # ------------------ Dateistatus (File States) ------------------
        "state_exists"             = "Bereits vorhanden"
        "state_copied"             = "Kopiert"
        "state_not_copied"         = "Nicht kopiert"

        # ------------------ Variablen für Clouds (Variables for Clouds) ------------------
        "cloud_iCloudDrive"        = "iCloudDrive"
        "cloud_OneDrive"           = "OneDrive"

        # ------------------ Modul-Warnungen (Module Warnings) ------------------
        "logLabel"                 = "Protokoll"
        "notificationsLabel"       = "Benachrichtigungen"
        "errorMissingLogFile"      = "Das Protokoll konnte nicht erstellt werden, da die Datei 'Generate-Logs.psm1' fehlt. Um die Protokollerstellung zu aktivieren, laden Sie diese Datei herunter und legen Sie sie im Projektordner ab."
        "logModuleMissing"         = "Protokollmodul nicht installiert. Führe ohne Protokollerstellung fort."

        # ------------------ Systembenachrichtigungen (System Notifications) ------------------
        "notificationSuccessTitle"        = "Sicherung erfolgreich"
        "notificationSuccessMessage"      = "Die Sicherung wurde erfolgreich abgeschlossen."
        "notificationErrorTitle"          = "Sicherungsfehler"
        "notificationErrorMessage"        = "Während der Sicherung ist ein Fehler aufgetreten."
        "notificationWarningTitle"        = "Warnung"
        "notificationWarningMessage"      = "Bitte überprüfen Sie die Sicherungseinstellungen."
        "notificationSuggestionTitle"     = "Optionale Funktion"
        "notificationSuggestionMessage"   = "Um erweiterte Benachrichtigungen zu aktivieren, installieren Sie das Benachrichtigungsmodul."
        "notificationNoSourceTitle"       = "Quellpfad fehlt"
        "notificationNoSourceMessage"     = "Es wurde kein Quellpfad definiert. Bitte überprüfen Sie die Konfiguration."
        "notificationInvalidSourceTitle"  = "Ungültiger Quellpfad"
        "notificationInvalidSourceMessage"= "Darf keine mehrere Pfade enthalten. Bitte nur einen Quellpfad angeben."
        "notificationNoDestinationTitle"  = "Zielpfad nicht definiert"
        "notificationNoDestinationMessage"= "Es wurde kein gültiger Zielpfad definiert. Konfigurieren Sie mindestens einen Zielpfad und versuchen Sie es erneut."
        "notificationPartialSuccessTitle" = "Teilweise erfolgreiche Sicherung"
        "notificationPartialSuccessMessage" = "Die Sicherung wurde größtenteils erfolgreich abgeschlossen, es gab jedoch Warnungen für einige Ziele. Bitte überprüfen Sie die Konfiguration."
        "notificationNoFilesTitle"        = "Keine Dateien zum Sichern"
        "notificationNoFilesMessage"      = "Es wurden keine Dateien zum Sichern gefunden. Bitte überprüfen Sie den Quellpfad."
        "notificationLogErrorTitle"       = "Protokollerstellungsfehler"
        "notificationLogErrorMessage"     = "Das Protokoll konnte nicht korrekt erstellt werden. Stellen Sie sicher, dass 'Generate-Logs.psm1' im Projektordner vorhanden ist."
        "notificationModuleMissing"       = "Benachrichtigungsmodul nicht installiert. Führe ohne Benachrichtigungen fort."
        "notificationInstallerMissing"    = "Installationsordner für die Abhängigkeiten des Benachrichtigungsmoduls fehlt."
        "notificationDestinationNotWritableMessage" = "Die Datei konnte nicht zum Zielpfad kopiert werden."

        # ------------------ Ungültige Zielbenachrichtigung (Invalid Destination Notification) ------------------
        "notificationInvalidDestination" = @{
            "title"   = "Ungültige Pfadwarnung"
            "message" = @{
                "singular" = " ist ungültig, bitte geben Sie es korrekt ein."
                "plural"   = " sind ungültig, bitte geben Sie sie korrekt ein."
            }
        }

        # ------------------ Weitere Begriffe mit Singular/Plural Variation (Other Terms with Singular/Plural Variation) ------------------
        "error" = @{
            "singular" = "Fehler"
            "plural"   = "Fehler"
        }
        "file" = @{
            "singular" = "Datei"
            "plural"   = "Dateien"
        }
        "path" = @{
            "singular" = "Pfad"
            "plural"   = "Pfade"
        }
    }


    "chinese" = @{

        # ------------------ 通用文本 (General Texts) ------------------
        # 标题和标题 (Headers and Titles)
        "titleAutoBackup"          = "开始自动备份"
        "labelSource"              = "源"

        # ------------------ 单复数可变词 (Terms with singular/plural variation) ------------------
        "destination" = @{
            "label" = @{
                "singular" = "目标"
                "plural"   = "目标"
            }
            "invalidMessage" = @{
                "singular" = "无效，请正确输入。"
                "plural"   = "无效，请正确输入。"
            }
        }

        # ------------------ 验证错误 (Validation Errors) ------------------
        "errorNoSource"            = "缺少源路径。"
        "errorMultipleSource"      = "不得包含多个路径。请只指定一个源路径。"
        "errorNoDestination"       = "未定义有效的目标路径。"
        "errorInvalidDestination"  = "目标路径无效。"
        "errorAdviceDestination"   = " 请指定目标路径（例如：C:\\Users\\destination）。"
        "errorInvalidPaths"        = "错误：源/目标路径无效。"

        # ------------------ 过程消息 (Process Messages) ------------------
        "labelBackingUp"           = "正在备份"
        "labelBackupCompleted"     = "备份完成于"
        "backupSummary"            = "备份摘要"
        "summaryLine1"             = "已存在"
        "summaryLine2"             = "已复制"
        "summaryLine3"             = "未复制"

        # ------------------ 表头 (Table Headers) ------------------
        "date"                     = "日期"
        "originalLabel"            = "原始"
        "replacementLabel"         = "替换后"
        "tableHeader1"             = "文件夹"
        "tableHeader2"             = "文件"
        "tableHeader5"             = "状态"

        # ------------------ 其他文本和消息 (Other Texts and Messages) ------------------
        "noFilesFound"             = "未找到要备份的文件。"
        "errorDuringBackup"        = "备份出错："
        "progressCompleted"        = "完成"
        "exitPrompt"               = "按任意键退出..."
        "warningText"              = "警告"
        "errorNotification"        = "无法显示备份完成通知："
        "errorOccurred"            = "发生错误："
        "notApplicable"            = "不适用"
        "noExecuted"               = "未执行"

        # ------------------ 文件状态 (File States) ------------------
        "state_exists"             = "已存在"
        "state_copied"             = "已复制"
        "state_not_copied"         = "未复制"

        # ------------------ 云变量 (Variables for Clouds) ------------------
        "cloud_iCloudDrive"        = "iCloudDrive"
        "cloud_OneDrive"           = "OneDrive"

        # ------------------ 模块警告 (Module Warnings) ------------------
        "logLabel"                 = "日志"
        "notificationsLabel"       = "通知"
        "errorMissingLogFile"      = "由于缺少 'Generate-Logs.psm1' 文件，无法生成日志。要启用日志生成，请将该文件放置在项目文件夹中。"
        "logModuleMissing"         = "日志模块未安装。继续而不生成日志。"

        # ------------------ 系统通知 (System Notifications) ------------------
        "notificationSuccessTitle"        = "备份成功"
        "notificationSuccessMessage"      = "备份已成功完成。"
        "notificationErrorTitle"          = "备份错误"
        "notificationErrorMessage"        = "备份过程中发生错误。"
        "notificationWarningTitle"        = "警告"
        "notificationWarningMessage"      = "请检查备份设置。"
        "notificationSuggestionTitle"     = "可选功能"
        "notificationSuggestionMessage"   = "要启用高级通知，请安装通知模块。"
        "notificationNoSourceTitle"       = "缺少源路径"
        "notificationNoSourceMessage"     = "未定义源路径。请检查配置。"
        "notificationInvalidSourceTitle"  = "源路径无效"
        "notificationInvalidSourceMessage"= "不得包含多个路径。请只指定一个源路径。"
        "notificationNoDestinationTitle"  = "未定义目标路径"
        "notificationNoDestinationMessage"= "未定义有效的目标路径。请配置至少一个目标并重试。"
        "notificationPartialSuccessTitle" = "部分成功的备份"
        "notificationPartialSuccessMessage" = "备份大部分完成，但某些目标存在警告。请检查配置。"
        "notificationNoFilesTitle"        = "无要备份的文件"
        "notificationNoFilesMessage"      = "未找到要备份的文件。请检查源路径。"
        "notificationLogErrorTitle"       = "日志生成错误"
        "notificationLogErrorMessage"     = "无法正确生成日志。请确保项目文件夹中存在 'Generate-Logs.psm1'。"
        "notificationModuleMissing"       = "未安装通知模块。继续而不显示通知。"
        "notificationInstallerMissing"    = "用于安装通知模块依赖项的 installer 文件夹丢失。"
        "notificationDestinationNotWritableMessage" = "无法复制到目标路径。"

        # ------------------ 无效目标通知 (Invalid Destination Notification) ------------------
        "notificationInvalidDestination" = @{
            "title"   = "无效路径警告"
            "message" = @{
                "singular" = "无效，请正确输入。"
                "plural"   = "无效，请正确输入。"
            }
        }

        # ------------------ 其他单复数可变词 (Other Terms with Singular/Plural Variation) ------------------
        "error" = @{
            "singular" = "错误"
            "plural"   = "错误"
        }
        "file" = @{
            "singular" = "文件"
            "plural"   = "文件"
        }
        "path" = @{
            "singular" = "路径"
            "plural"   = "路径"
        }
    }

}