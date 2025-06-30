# ------------------ MÓDULO DE NOTIFICACIONES ------------------
# Este módulo proporciona funciones para enviar notificaciones personalizadas en PowerShell utilizando BurntToast.

# ------------------ RUTAS A ASSETS ------------------
$ModuleRoot = Split-Path -Parent $MyInvocation.MyCommand.Path

$ImgSuccess = Join-Path $ModuleRoot 'Assets\Images\Success.png'
$ImgError   = Join-Path $ModuleRoot 'Assets\Images\Error.png'
$ImgWarning = Join-Path $ModuleRoot 'Assets\Images\Warning.png'

$SndSuccess = Join-Path $ModuleRoot 'Assets\Sounds\Success.wav'
$SndError   = Join-Path $ModuleRoot 'Assets\Sounds\Error.wav'
$SndWarning = Join-Path $ModuleRoot 'Assets\Sounds\Warning.wav'

# ------------------ FUNCIONES AUXILIARES ------------------
function Get-LocalizedText {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$Key
    )
    # Devuelve el texto localizado si existe; de lo contrario, la propia clave.
    if ($global:msg -and $global:msg.ContainsKey($Key)) {
        return $global:msg[$Key]
    }
    return $Key
}

function Play-CustomSound {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$Path
    )
    if (Test-Path $Path) {
        try {
            $player = New-Object System.Media.SoundPlayer $Path
            $player.Play()
        }
        catch {
            # Se omite el mensaje para evitar duplicaciones.
        }
    }
}

# ------------------ FUNCION WAIT WITH SPINNER ------------------
function Wait-WithSpinner {
    param([int]$Seconds)
    $spinChars = "|/-\"
    $endTime = (Get-Date).AddSeconds($Seconds)
    while ((Get-Date) -lt $endTime) {
        foreach ($char in $spinChars.ToCharArray()) {
            Write-Host -NoNewline "`r$char"
            Start-Sleep -Milliseconds 100
        }
    }
    Write-Host "`r" -NoNewline
}

# ------------------ VERIFICACIÓN DE DEPENDENCIAS ------------------
$installerSetup = Join-Path $ModuleRoot "..\..\Installer\Setup.ps1"
if (-not (Get-Module -ListAvailable -Name "BurntToast")) {
    if (Test-Path $installerSetup) {
        & $installerSetup
    }
}
$global:BurntToastInstalled = (Get-Module -ListAvailable -Name "BurntToast") -ne $null
# No se muestra mensaje directo; RunBackup.ps1 se encargará de avisar.

# ------------------ CMDLETS DE NOTIFICACIÓN ------------------
function Send-SuccessNotification {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$TitleKey,
        [Parameter(Mandatory)][string]$MessageKey,
        [string]$IconPath
    )
    if (-not $global:BurntToastInstalled) { return }
    Import-Module BurntToast -ErrorAction Stop
    $title   = Get-LocalizedText -Key $TitleKey
    $message = Get-LocalizedText -Key $MessageKey
    Play-CustomSound -Path $SndSuccess
    $logo = if ($IconPath -and (Test-Path $IconPath)) { $IconPath } else { $ImgSuccess }
    New-BurntToastNotification -AppLogo $logo -Text $title, $message
    # Notificación de éxito sin espera.
}

function Send-ErrorNotification {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$TitleKey,
        [Parameter(Mandatory)][string]$MessageKey,
        [string]$IconPath
    )
    if (-not $global:BurntToastInstalled) { return }
    Import-Module BurntToast -ErrorAction Stop
    $title   = Get-LocalizedText -Key $TitleKey
    $message = Get-LocalizedText -Key $MessageKey
    Play-CustomSound -Path $SndError
    $logo = if ($IconPath -and (Test-Path $IconPath)) { $IconPath } else { $ImgError }
    New-BurntToastNotification -AppLogo $logo -Text $title, $message
    # Notificación de error sin espera.
}

function Send-WarningNotification {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$TitleKey,
        [Parameter(Mandatory)][string]$MessageKey,
        [string]$IconPath
    )
    if (-not $global:BurntToastInstalled) { return }
    Import-Module BurntToast -ErrorAction Stop
    $title   = Get-LocalizedText -Key $TitleKey
    $message = Get-LocalizedText -Key $MessageKey
    Play-CustomSound -Path $SndWarning
    $logo = if ($IconPath -and (Test-Path $IconPath)) { $IconPath } else { $ImgWarning }
    New-BurntToastNotification -AppLogo $logo -Text $title, $message
    # Las notificaciones de advertencia esperan 7 segundos para ser visibles.
    Wait-WithSpinner 7
}

function Send-SuggestionNotification {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$TitleKey,
        [Parameter(Mandatory)][string]$MessageKey,
        [string]$IconPath
    )
    # Reutiliza la notificación de advertencia para sugerencias.
    Send-WarningNotification -TitleKey $TitleKey -MessageKey $MessageKey -IconPath $IconPath
}

function Send-Notification {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$TitleKey,
        [Parameter(Mandatory)][string]$MessageKey,
        [ValidateSet("Success","Error","Warning","Suggestion","Info")][string]$Type = "Info",
        [string]$IconPath
    )
    switch ($Type) {
        "Success"    { Send-SuccessNotification -TitleKey $TitleKey -MessageKey $MessageKey -IconPath $IconPath }
        "Error"      { Send-ErrorNotification -TitleKey $TitleKey -MessageKey $MessageKey -IconPath $IconPath }
        "Warning"    { Send-WarningNotification -TitleKey $TitleKey -MessageKey $MessageKey -IconPath $IconPath }
        "Suggestion" { Send-SuggestionNotification -TitleKey $TitleKey -MessageKey $MessageKey -IconPath $IconPath }
        default {
            Import-Module BurntToast -ErrorAction Stop
            New-BurntToastNotification -Text (Get-LocalizedText -Key $TitleKey), (Get-LocalizedText -Key $MessageKey)
            # Asume notificación de advertencia; espera 7 segundos.
            Wait-WithSpinner 7
        }
    }
}

# ------------------ EXPORTACIÓN DEL MODULO ------------------
Export-ModuleMember -Function `
    Get-LocalizedText, `
    Play-CustomSound, `
    Send-SuccessNotification, `
    Send-ErrorNotification, `
    Send-WarningNotification, `
    Send-SuggestionNotification, `
    Send-Notification, `
    Wait-WithSpinner
