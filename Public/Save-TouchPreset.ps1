function Save-TouchPreset {
    <#
    .SYNOPSIS
        Saves a file template as a reusable preset.

    .EXAMPLE
        Save-TouchPreset -Name web-project -Files index.html, style.css, script.js

    .EXAMPLE
        Save-TouchPreset -Name logs -Files log.txt -Count 7 -Path C:\Logs
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)][ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter(Mandatory)][string[]]$Files,
        [int]$Count = 1,
        [string]$Path
    )

    $store = Import-TouchPresetStore

    if ($store.ContainsKey($Name) -and
        -not $PSCmdlet.ShouldProcess($Name, "Overwrite existing preset")) {
        return
    }

    $store[$Name] = @{
        Files = $Files
        Count = $Count
        Path  = if ($Path) { $Path } else { $null }
    }

    Export-TouchPresetStore -Store $store
    Write-Verbose "Preset '$Name' saved with $($Files.Count) file(s)."
    [pscustomobject]@{ 
        Name = $Name; 
        Files = $Files; 
        Count = $Count; 
        Path = $Path 
    }
}