# ------------------ CARGA DE TEXTOS ------------------
# Símbolos globales
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
    "spanish"  = @{
        "titleAutoBackup"                               = "INICIANDO RESPALDO AUTOMÁTICO"
        "labelSource"                                   = "Origen"
        "destSingular"                                  = "Destino"
        "destPlural"                                    = "Destino(s)"

        # ------------------ Errores de validación ------------------
        "errorNoSource"                                 = "Falta definir la ruta de Origen."
        "errorMultipleSource"                           = "NO debe contener múltiples rutas. Especifique solo una ruta de origen."
        "errorNoDestination"                            = "No se ha definido ninguna ruta de destino válida."
        "errorInvalidDestination"                       = "La ruta de destino es incorrecta"
        "errorAdviceDestination"                        = " Especifique una ruta de destino (ej: C:\Users\destino)."
        "errorInvalidPaths"                             = "Error: Rutas de origen/destino inválidas."

        # ------------------ Mensajes del proceso ------------------
        "labelBackingUp"                                = "Respaldando"
        "labelBackupCompleted"                          = "Respaldo completado en"
        "backupSummary"                                 = "Resumen de Respaldo"
        "summaryLine1"                                  = "Ya existentes"
        "summaryLine2"                                  = "Copiados"
        "summaryLine3"                                  = "No se copiaron"

        # ------------------ Encabezados de tablas ------------------
        "date"                                          = "Fecha"
        "originalLabel"                                 = "original"
        "replacementLabel"                              = "reemplazo"
        "tableHeader1"                                  = "Carpeta"
        "tableHeader2"                                  = "Archivo"
        "tableHeader5"                                  = "Estado"

        # ------------------ Otros textos y mensajes ------------------
        "noFilesFound"                                  = "No se encontraron archivos para respaldar."
        "errorDuringBackup"                             = "Error en respaldo de"
        "progressCompleted"                             = "finalizado"
        "exitPrompt"                                    = "Presiona cualquier tecla para salir..."
        "warningText"                                   = "Advertencia"
        "errorNotification"                             = "No se pudo mostrar la notificación de respaldo completado: "
        "errorOccurred"                                 = "Se produjo un error: "
        "notApplicable"                                 = "N/A"
        "noExecuted"                                    = "No ejecutado"

        # ------------------ Estados para archivos ------------------
        "state_exists"                                  = "Ya existe"
        "state_copied"                                  = "Copiado"

        # ------------------ Variables para nubes ------------------
        "cloud_iCloudDrive"                             = "iCloudDrive"
        "cloud_OneDrive"                                = "OneDrive"

        # ------------------ Advertencias de módulos ------------------
        "logLabel"                                      = "Log"
        "notificationsLabel"                            = "Notificaciones"
        "errorMissingLogFile"                           = "No se pudo generar el log, ya que falta el archivo 'Generate-Logs.ps1'. Para habilitar la generación de logs, descargue y coloque dicho archivo en la carpeta del proyecto."

        # ------------------ Notificaciones del sistema ------------------
        "notificationSuccessTitle"                      = "Respaldo Exitoso"
        "notificationSuccessMessage"                    = "El respaldo se ha completado exitosamente."
        "notificationErrorTitle"                        = "Error en Respaldo"
        "notificationErrorMessage"                      = "Ocurrió un error durante el respaldo."
        "notificationWarningTitle"                      = "Advertencia"
        "notificationWarningMessage"                    = "Verifique la configuración del respaldo."
        "notificationSuggestionTitle"                   = "Característica Opcional"
        "notificationSuggestionMessage"                 = "Para notificaciones avanzadas, instale el módulo de notificaciones."
        "notificationNoSourceTitle"                     = "Falta definir la ruta de Origen"
        "notificationNoSourceMessage"                   = "No se ha definido la ruta de Origen. Por favor, revise la configuración."
        "notificationInvalidSourceTitle"                = "Ruta Origen Mal Definida"
        "notificationInvalidSourceMessage"              = "NO debe contener múltiples rutas. Especifique solo una ruta de origen."
        "notificationNoDestinationTitle"                = "Ruta Destino Indefinida"
        "notificationNoDestinationMessage"              = "No se ha definido ninguna ruta de destino válida. Configure al menos un destino e intente nuevamente."
        "notificationPartialSuccessTitle"               = "Respaldo Parcialmente Exitoso"
        "notificationPartialSuccessMessage"             = "El respaldo se completó en su mayoría, pero se presentaron advertencias en algunos destinos. Revise la configuración."
        "notificationNoFilesTitle"                      = "No Hay Archivos para Respaldar"
        "notificationNoFilesMessage"                    = "No se encontraron archivos para respaldar. Verifique la ruta de origen."
        "notificationLogErrorTitle"                     = "Error en la Generación del Log"
        "notificationLogErrorMessage"                   = "No se pudo generar el log correctamente. Asegúrese de que 'Generate-Logs.ps1' esté presente en la carpeta del proyecto."
        "notificationModuleMissing"                     = "Módulo de notificaciones no instalado. Continuando sin notificaciones."
        "notificationInstallerMissing"                  = "Falta la carpeta installer para instalar las dependencias del módulo de notificaciones."
        "logModuleMissing"                              = "Módulo de logs no instalado. Continuando sin generación de logs."
        "notificationInvalidDestinationTitle"           = "Advertencia de ruta(s) incorrecta(s)"
        "notificationInvalidDestinationMessageSingular" = " es incorrecta, vuelva a ingresarla correctamente."
        "notificationInvalidDestinationMessagePlural"   = " son incorrectas, vuelva a ingresarlas correctamente."
    }
    # ------------------ General Texts (English) ------------------
    "english"  = @{
        "titleAutoBackup"                               = "STARTING AUTOMATIC BACKUP"
        "labelSource"                                   = "Source"
        "destSingular"                                  = "Destination"
        "destPlural"                                    = "Destination(s)"

        # ------------------ Validation Errors ------------------
        "errorNoSource"                                 = "Source path is missing."
        "errorMultipleSource"                           = "Should not contain multiple paths. Specify only one source path."
        "errorNoDestination"                            = "No valid destination path defined."
        "errorInvalidDestination"                       = "Destination path is invalid"
        "errorAdviceDestination"                        = " Specify a destination path (e.g.: C:\Users\destination)."
        "errorInvalidPaths"                             = "Error: Invalid source/destination paths."

        # ------------------ Process Messages ------------------
        "labelBackingUp"                                = "Backing up"
        "labelBackupCompleted"                          = "Backup completed at"
        "backupSummary"                                 = "Backup Summary"
        "summaryLine1"                                  = "Already existing"
        "summaryLine2"                                  = "Copied"
        "summaryLine3"                                  = "Not copied"

        # ------------------ Table Headers ------------------
        "date"                                          = "Date"
        "originalLabel"                                 = "original"
        "replacementLabel"                              = "replacement"
        "tableHeader1"                                  = "Folder"
        "tableHeader2"                                  = "File"
        "tableHeader5"                                  = "Status"

        # ------------------ Other Messages ------------------
        "noFilesFound"                                  = "No files found to backup."
        "errorDuringBackup"                             = "Error during backup of"
        "progressCompleted"                             = "completed"
        "exitPrompt"                                    = "Press any key to exit..."
        "warningText"                                   = "Warning"
        "errorNotification"                             = "Failed to display backup completed notification: "
        "errorOccurred"                                 = "An error occurred: "
        "notApplicable"                                 = "N/A"
        "noExecuted"                                    = "Not executed"

        # ------------------ File States ------------------
        "state_exists"                                  = "Already exists"
        "state_copied"                                  = "Copied"

        # ------------------ Cloud Variables ------------------
        "cloud_iCloudDrive"                             = "iCloudDrive"
        "cloud_OneDrive"                                = "OneDrive"

        # ------------------ Module Warnings ------------------
        "logLabel"                                      = "Log"
        "notificationsLabel"                            = "Notifications"
        "errorMissingLogFile"                           = "Could not generate log because the 'Generate-Logs.ps1' file is missing. To enable log generation, download and place that file in the project folder."

        # ------------------ System Notifications ------------------
        "notificationSuccessTitle"                      = "Backup Successful"
        "notificationSuccessMessage"                    = "The backup has been completed successfully."
        "notificationErrorTitle"                        = "Backup Error"
        "notificationErrorMessage"                      = "An error occurred during the backup."
        "notificationWarningTitle"                      = "Warning"
        "notificationWarningMessage"                    = "Check backup configuration."
        "notificationSuggestionTitle"                   = "Optional Feature"
        "notificationSuggestionMessage"                 = "For advanced notifications, install the notifications module."
        "notificationNoSourceTitle"                     = "Source Path Missing"
        "notificationNoSourceMessage"                   = "No source path defined. Please check the configuration."
        "notificationInvalidSourceTitle"                = "Invalid Source Path"
        "notificationInvalidSourceMessage"              = "Should not contain multiple paths. Specify only one source path."
        "notificationNoDestinationTitle"                = "Destination Path Undefined"
        "notificationNoDestinationMessage"              = "No valid destination path defined. Configure at least one destination and try again."
        "notificationPartialSuccessTitle"               = "Backup Partially Successful"
        "notificationPartialSuccessMessage"             = "Backup completed mostly, but some destinations had warnings. Review configuration."
        "notificationNoFilesTitle"                      = "No Files to Backup"
        "notificationNoFilesMessage"                    = "No files found to backup. Check the source path."
        "notificationLogErrorTitle"                     = "Log Generation Error"
        "notificationLogErrorMessage"                   = "Could not generate the log correctly. Ensure 'Generate-Logs.ps1' is present in the project folder."
        "notificationModuleMissing"                     = "Notifications module not installed. Continuing without notifications."
        "notificationInstallerMissing"                  = "Installer folder missing to install notification module dependencies."
        "logModuleMissing"                              = "Log module not installed. Continuing without log generation."
        "notificationInvalidDestinationTitle"           = "Invalid Path Warning"
        "notificationInvalidDestinationMessageSingular" = " is invalid, please re-enter it correctly."
        "notificationInvalidDestinationMessagePlural"   = " are invalid, please re-enter them correctly."
    }

    # ------------------ 一般的なテキスト (General Texts) ------------------
    "japanese" = @{
        "titleAutoBackup"                               = "自動バックアップを開始しています"
        "labelSource"                                   = "ソース"
        "destSingular"                                  = "宛先"
        "destPlural"                                    = "宛先"

        # ------------------ 検証エラー (Validation Errors) ------------------
        "errorNoSource"                                 = "ソースパスが定義されていません。"
        "errorMultipleSource"                           = "複数のパスを含めることはできません。ソースパスは1つだけ指定してください。"
        "errorNoDestination"                            = "有効な宛先パスが定義されていません。"
        "errorInvalidDestination"                       = "宛先パスが無効です"
        "errorAdviceDestination"                        = " 宛先パスを指定してください（例: C:\Users\destination）。"
        "errorInvalidPaths"                             = "エラー: ソース/宛先パスが無効です。"

        # ------------------ 処理メッセージ (Process Messages) ------------------
        "labelBackingUp"                                = "バックアップ中"
        "labelBackupCompleted"                          = "バックアップ完了日時"
        "backupSummary"                                 = "バックアップ概要"
        "summaryLine1"                                  = "既存"
        "summaryLine2"                                  = "コピー済み"
        "summaryLine3"                                  = "コピーされず"

        # ------------------ テーブルヘッダー (Table Headers) ------------------
        "date"                                          = "日付"
        "originalLabel"                                 = "元"
        "replacementLabel"                              = "置換"
        "tableHeader1"                                  = "フォルダー"
        "tableHeader2"                                  = "ファイル"
        "tableHeader5"                                  = "ステータス"

        # ------------------ その他のメッセージ (Other Messages) ------------------
        "noFilesFound"                                  = "バックアップするファイルが見つかりません。"
        "errorDuringBackup"                             = "バックアップエラー: "
        "progressCompleted"                             = "完了"
        "exitPrompt"                                    = "終了するには任意のキーを押してください..."
        "warningText"                                   = "警告"
        "errorNotification"                             = "バックアップ完了通知を表示できませんでした: "
        "errorOccurred"                                 = "エラーが発生しました: "
        "notApplicable"                                 = "該当なし"
        "noExecuted"                                    = "未実行"

        # ------------------ ファイル状態 (File States) ------------------
        "state_exists"                                  = "既に存在"
        "state_copied"                                  = "コピー済み"

        # ------------------ クラウド変数 (Cloud Variables) ------------------
        "cloud_iCloudDrive"                             = "iCloudDrive"
        "cloud_OneDrive"                                = "OneDrive"

        # ------------------ モジュール警告 (Module Warnings) ------------------
        "logLabel"                                      = "ログ"
        "notificationsLabel"                            = "通知"
        "errorMissingLogFile"                           = "'Generate-Logs.ps1' ファイルが見つからないため、ログを生成できませんでした。ログ生成を有効にするには、そのファイルをプロジェクトフォルダーに配置してください。"

        # ------------------ システム通知 (System Notifications) ------------------
        "notificationSuccessTitle"                      = "バックアップ成功"
        "notificationSuccessMessage"                    = "バックアップが正常に完了しました。"
        "notificationErrorTitle"                        = "バックアップエラー"
        "notificationErrorMessage"                      = "バックアップ中にエラーが発生しました。"
        "notificationWarningTitle"                      = "警告"
        "notificationWarningMessage"                    = "バックアップの設定を確認してください。"
        "notificationSuggestionTitle"                   = "オプション機能"
        "notificationSuggestionMessage"                 = "高度な通知機能を利用するには、通知モジュールをインストールしてください。"
        "notificationNoSourceTitle"                     = "ソースパスが未定義"
        "notificationNoSourceMessage"                   = "ソースパスが定義されていません。設定を確認してください。"
        "notificationInvalidSourceTitle"                = "無効なソースパス"
        "notificationInvalidSourceMessage"              = "複数のパスを含めることはできません。ソースパスは1つだけ指定してください。"
        "notificationNoDestinationTitle"                = "宛先パスが未定義"
        "notificationNoDestinationMessage"              = "有効な宛先パスが定義されていません。少なくとも1つの宛先を設定して再試行してください。"
        "notificationPartialSuccessTitle"               = "バックアップ部分的に成功"
        "notificationPartialSuccessMessage"             = "ほとんどのバックアップは完了しましたが、一部の宛先で警告が発生しました。設定を確認してください。"
        "notificationNoFilesTitle"                      = "バックアップするファイルがありません"
        "notificationNoFilesMessage"                    = "バックアップするファイルが見つかりません。ソースパスを確認してください。"
        "notificationLogErrorTitle"                     = "ログ生成エラー"
        "notificationLogErrorMessage"                   = "ログを正しく生成できませんでした。プロジェクトフォルダーに 'Generate-Logs.ps1' が存在することを確認してください。"
        "notificationModuleMissing"                     = "通知モジュールがインストールされていません。通知なしで続行します。"
        "notificationInstallerMissing"                  = "通知モジュールの依存関係をインストールするための installer フォルダーがありません。"
        "logModuleMissing"                              = "ログモジュールがインストールされていません。ログ生成なしで続行します。"
        "notificationInvalidDestinationTitle"           = "無効なパスの警告"
        "notificationInvalidDestinationMessageSingular" = " は無効です。正しく再入力してください。"
        "notificationInvalidDestinationMessagePlural"   = " は無効です。正しく再入力してください。"
    }
    # ------------------ Allgemeine Texte (General Texts) ------------------
    "german"   = @{
        "titleAutoBackup"                               = "STARTE AUTOMATISCHE SICHERUNG"
        "labelSource"                                   = "Quelle"
        "destSingular"                                  = "Ziel"
        "destPlural"                                    = "Ziele"

        # ------------------ Validierungsfehler (Validation Errors) ------------------
        "errorNoSource"                                 = "Quellpfad fehlt."
        "errorMultipleSource"                           = "Darf nicht mehrere Pfade enthalten. Geben Sie nur einen Quellpfad an."
        "errorNoDestination"                            = "Kein gültiger Zielpfad definiert."
        "errorInvalidDestination"                       = "Zielpfad ist ungültig"
        "errorAdviceDestination"                        = " Geben Sie einen Zielpfad an (z.B.: C:\Users\ziel)."
        "errorInvalidPaths"                             = "Fehler: Ungültige Quell-/Zielpfade."

        # ------------------ Prozessnachrichten (Process Messages) ------------------
        "labelBackingUp"                                = "Sichere"
        "labelBackupCompleted"                          = "Sicherung abgeschlossen um"
        "backupSummary"                                 = "Sicherungsübersicht"
        "summaryLine1"                                  = "Bereits vorhanden"
        "summaryLine2"                                  = "Kopiert"
        "summaryLine3"                                  = "Nicht kopiert"

        # ------------------ Tabellenspaltenüberschriften (Table Headers) ------------------
        "date"                                          = "Datum"
        "originalLabel"                                 = "original"
        "replacementLabel"                              = "ersetzt"
        "tableHeader1"                                  = "Ordner"
        "tableHeader2"                                  = "Datei"
        "tableHeader5"                                  = "Status"

        # ------------------ Andere Meldungen (Other Messages) ------------------
        "noFilesFound"                                  = "Keine Dateien zum Sichern gefunden."
        "errorDuringBackup"                             = "Fehler bei Sicherung von"
        "progressCompleted"                             = "abgeschlossen"
        "exitPrompt"                                    = "Drücken Sie eine beliebige Taste zum Beenden..."
        "warningText"                                   = "Warnung"
        "errorNotification"                             = "Benachrichtigung zum Abschluss der Sicherung konnte nicht angezeigt werden: "
        "errorOccurred"                                 = "Ein Fehler ist aufgetreten: "
        "notApplicable"                                 = "N/A"
        "noExecuted"                                    = "Nicht ausgeführt"

        # ------------------ Dateizustände (File States) ------------------
        "state_exists"                                  = "Bereits vorhanden"
        "state_copied"                                  = "Kopiert"

        # ------------------ Cloud-Variablen (Cloud Variables) ------------------
        "cloud_iCloudDrive"                             = "iCloudDrive"
        "cloud_OneDrive"                                = "OneDrive"

        # ------------------ Modulwarnungen (Module Warnings) ------------------
        "logLabel"                                      = "Protokoll"
        "notificationsLabel"                            = "Benachrichtigungen"
        "errorMissingLogFile"                           = "Protokoll konnte nicht erstellt werden, da die Datei 'Generate-Logs.ps1' fehlt. Um die Protokollierung zu aktivieren, laden Sie diese Datei herunter und legen Sie sie im Projektordner ab."

        # ------------------ Systembenachrichtigungen (System Notifications) ------------------
        "notificationSuccessTitle"                      = "Sicherung erfolgreich"
        "notificationSuccessMessage"                    = "Die Sicherung wurde erfolgreich abgeschlossen."
        "notificationErrorTitle"                        = "Sicherungsfehler"
        "notificationErrorMessage"                      = "Beim Erstellen der Sicherung ist ein Fehler aufgetreten."
        "notificationWarningTitle"                      = "Warnung"
        "notificationWarningMessage"                    = "Überprüfen Sie die Sicherungskonfiguration."
        "notificationSuggestionTitle"                   = "Optionale Funktion"
        "notificationSuggestionMessage"                 = "Für erweiterte Benachrichtigungen installieren Sie das Benachrichtigungsmodul."
        "notificationNoSourceTitle"                     = "Quellpfad fehlt"
        "notificationNoSourceMessage"                   = "Kein Quellpfad definiert. Bitte überprüfen Sie die Konfiguration."
        "notificationInvalidSourceTitle"                = "Ungültiger Quellpfad"
        "notificationInvalidSourceMessage"              = "Darf nicht mehrere Pfade enthalten. Geben Sie nur einen Quellpfad an."
        "notificationNoDestinationTitle"                = "Zielpfad nicht definiert"
        "notificationNoDestinationMessage"              = "Kein gültiger Zielpfad definiert. Konfigurieren Sie mindestens ein Ziel und versuchen Sie es erneut."
        "notificationPartialSuccessTitle"               = "Sicherung teilweise erfolgreich"
        "notificationPartialSuccessMessage"             = "Sicherung größtenteils abgeschlossen, aber bei einigen Zielen gab es Warnungen. Überprüfen Sie die Konfiguration."
        "notificationNoFilesTitle"                      = "Keine Dateien zum Sichern"
        "notificationNoFilesMessage"                    = "Keine Dateien zum Sichern gefunden. Überprüfen Sie den Quellpfad."
        "notificationLogErrorTitle"                     = "Protokollierungsfehler"
        "notificationLogErrorMessage"                   = "Das Protokoll konnte nicht korrekt erstellt werden. Stellen Sie sicher, dass 'Generate-Logs.ps1' im Projektordner vorhanden ist."
        "notificationModuleMissing"                     = "Benachrichtigungsmodul nicht installiert. Führe ohne Benachrichtigungen fort."
        "notificationInstallerMissing"                  = "Installer-Ordner zum Installieren der Abhängigkeiten des Benachrichtigungsmoduls fehlt."
        "logModuleMissing"                              = "Protokollmodul nicht installiert. Führe ohne Protokollierung fort."
        "notificationInvalidDestinationTitle"           = "Warnung ungültige Pfade"
        "notificationInvalidDestinationMessageSingular" = " ist ungültig, bitte erneut korrekt eingeben."
        "notificationInvalidDestinationMessagePlural"   = " sind ungültig, bitte erneut korrekt eingeben."
    }

    # ------------------ 通用文本 (General Texts) ------------------
    "chinese"  = @{
        "titleAutoBackup"                               = "开始自动备份"
        "labelSource"                                   = "源"
        "destSingular"                                  = "目标"
        "destPlural"                                    = "目标"

        # ------------------ 验证错误 (Validation Errors) ------------------
        "errorNoSource"                                 = "缺少源路径。"
        "errorMultipleSource"                           = "不应包含多个路径。请仅指定一个源路径。"
        "errorNoDestination"                            = "未定义有效的目标路径。"
        "errorInvalidDestination"                       = "目标路径无效"
        "errorAdviceDestination"                        = " 请指定目标路径（例如: C:\Users\destination）。"
        "errorInvalidPaths"                             = "错误：源/目标路径无效。"

        # ------------------ 处理消息 (Process Messages) ------------------
        "labelBackingUp"                                = "正在备份"
        "labelBackupCompleted"                          = "备份完成于"
        "backupSummary"                                 = "备份摘要"
        "summaryLine1"                                  = "已存在"
        "summaryLine2"                                  = "已复制"
        "summaryLine3"                                  = "未复制"

        # ------------------ 表头 (Table Headers) ------------------
        "date"                                          = "日期"
        "originalLabel"                                 = "原"
        "replacementLabel"                              = "替换"
        "tableHeader1"                                  = "文件夹"
        "tableHeader2"                                  = "文件"
        "tableHeader5"                                  = "状态"

        # ------------------ 其他消息 (Other Messages) ------------------
        "noFilesFound"                                  = "未找到要备份的文件。"
        "errorDuringBackup"                             = "备份错误："
        "progressCompleted"                             = "完成"
        "exitPrompt"                                    = "按任意键退出..."
        "warningText"                                   = "警告"
        "errorNotification"                             = "无法显示备份完成通知："
        "errorOccurred"                                 = "发生错误："
        "notApplicable"                                 = "不适用"
        "noExecuted"                                    = "未执行"

        # ------------------ 文件状态 (File States) ------------------
        "state_exists"                                  = "已存在"
        "state_copied"                                  = "已复制"

        # ------------------ 云变量 (Cloud Variables) ------------------
        "cloud_iCloudDrive"                             = "iCloudDrive"
        "cloud_OneDrive"                                = "OneDrive"

        # ------------------ 模块警告 (Module Warnings) ------------------
        "logLabel"                                      = "日志"
        "notificationsLabel"                            = "通知"
        "errorMissingLogFile"                           = "无法生成日志，因为缺少 'Generate-Logs.ps1' 文件。要启用日志生成，请下载并将该文件放置在项目文件夹中。"

        # ------------------ 系统通知 (System Notifications) ------------------
        "notificationSuccessTitle"                      = "备份成功"
        "notificationSuccessMessage"                    = "备份已成功完成。"
        "notificationErrorTitle"                        = "备份错误"
        "notificationErrorMessage"                      = "备份过程中发生错误。"
        "notificationWarningTitle"                      = "警告"
        "notificationWarningMessage"                    = "请检查备份配置。"
        "notificationSuggestionTitle"                   = "可选功能"
        "notificationSuggestionMessage"                 = "如需高级通知，请安装通知模块。"
        "notificationNoSourceTitle"                     = "缺少源路径"
        "notificationNoSourceMessage"                   = "未定义源路径。请检查配置。"
        "notificationInvalidSourceTitle"                = "无效的源路径"
        "notificationInvalidSourceMessage"              = "不应包含多个路径。请仅指定一个源路径。"
        "notificationNoDestinationTitle"                = "未定义目标路径"
        "notificationNoDestinationMessage"              = "未定义有效的目标路径。请配置至少一个目标并重试。"
        "notificationPartialSuccessTitle"               = "部分成功"
        "notificationPartialSuccessMessage"             = "备份大部分已完成，但某些目标存在警告。请检查配置。"
        "notificationNoFilesTitle"                      = "无备份文件"
        "notificationNoFilesMessage"                    = "未找到要备份的文件。请检查源路径。"
        "notificationLogErrorTitle"                     = "日志生成错误"
        "notificationLogErrorMessage"                   = "无法正确生成日志。请确保 'Generate-Logs.ps1' 存在于项目文件夹中。"
        "notificationModuleMissing"                     = "未安装通知模块。继续时不发送通知。"
        "notificationInstallerMissing"                  = "缺少用于安装通知模块依赖项的 installer 文件夹。"
        "logModuleMissing"                              = "未安装日志模块。继续时不生成日志。"
        "notificationInvalidDestinationTitle"           = "无效路径警告"
        "notificationInvalidDestinationMessageSingular" = " 无效，请正确重新输入。"
        "notificationInvalidDestinationMessagePlural"   = " 无效，请正确重新输入。"
    }
}