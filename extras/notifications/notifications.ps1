# extras\notifications\notifications.ps1
<#
.SYNOPSIS
Module for sending customized notifications during the backup process.
.DESCRIPTION
Provides functions for displaying success, error, warning, and suggestion notifications
using the BurntToast module.
Customize each function with an optional icon parameter.
NOTES:
- Ensure that the BurntToast module is installed andaccessible.
- You can customize images and, if desired, sounds by extending the functions.
.EXAMPLE
Show-SuccessNotification -Title "Backup Successful" -Message "Your backup completed successfully." -IconPath "C:\path\to\icon.png"
#>

function Show-SuccessNotification {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Title,
        [Parameter(Mandatory=$true)]
        [string]$Message,
        [Parameter(Mandatory=$false)]
        [string]$IconPath
    )
    Import-Module BurntToast -ErrorAction Stop
    if ($IconPath -and (Test-Path $IconPath)) {
        New-BurntToastNotification -AppLogo $IconPath -Text $Title, $Message
    }
    else {
        New-BurntToastNotification -Text $Title, $Message
    }
}

function Show-ErrorNotification {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Title,
        [Parameter(Mandatory=$true)]
        [string]$Message,
        [Parameter(Mandatory=$false)]
        [string]$IconPath
    )
    Import-Module BurntToast -ErrorAction Stop
    if ($IconPath -and (Test-Path $IconPath)) {
        New-BurntToastNotification -AppLogo $IconPath -Text $Title, $Message
    }
    else {
        New-BurntToastNotification -Text $Title, $Message
    }
}

function Show-WarningNotification {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Title,
        [Parameter(Mandatory=$true)]
        [string]$Message,
        [Parameter(Mandatory=$false)]
        [string]$IconPath
    )
    Import-Module BurntToast -ErrorAction Stop
    if ($IconPath -and (Test-Path $IconPath)) {
        New-BurntToastNotification -AppLogo $IconPath -Text $Title, $Message
    }
    else {
        New-BurntToastNotification -Text $Title, $Message
    }
}

function Show-SuggestionNotification {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Title,
        [Parameter(Mandatory=$true)]
        [string]$Message,
        [Parameter(Mandatory=$false)]
        [string]$IconPath
    )
    # A suggestion notification can be handled as a warning notification.
    Show-WarningNotification -Title $Title -Message $Message -IconPath $IconPath
}

# Generic function if you prefer one unified call:
function Show-Notification {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Title,
        [Parameter(Mandatory=$true)]
        [string]$Message,
        [ValidateSet("Success", "Error", "Warning", "Info")]
        [string]$Type = "Info",
        [Parameter(Mandatory=$false)]
        [string]$IconPath
        # In a future version, you might add an optional SoundPath parameter.
    )
    switch ($Type) {
        "Success" { Show-SuccessNotification -Title $Title -Message $Message -IconPath $IconPath }
        "Error"   { Show-ErrorNotification -Title $Title -Message $Message -IconPath $IconPath }
        "Warning" { Show-WarningNotification -Title $Title -Message $Message -IconPath $IconPath }
        default   { New-BurntToastNotification -Text $Title, $Message }
    }
}

<#
.EXAMPLE
# Display a success notification with a custom icon:
Show-SuccessNotification -Title "Backup Successful" -Message "The backup completed successfully." -IconPath "$PSScriptRoot\extras\notifications\images\backup_success.png"

# Display an error notification:
Show-ErrorNotification -Title "Backup Failed" -Message "The backup encountered an error." 

# Display a suggestion to install the notifications module (if missing):
Show-SuggestionNotification -Title "Optional Module" -Message "For enhanced notifications, please install the notifications module."
#>
