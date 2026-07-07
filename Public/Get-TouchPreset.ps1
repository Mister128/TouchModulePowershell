function Get-TouchPreset {
    <#
    .SYNOPSIS
        Lists all saved presets or returns a specific one.

    .EXAMPLE
        Get-TouchPreset
    .EXAMPLE
        Get-TouchPreset -Name web-project
    #>
    [CmdletBinding()]
    param([string]$Name)

    $store = Import-TouchPresetStore

    if ($Name) {
        if (-not $store.ContainsKey($Name)) {
            Write-Error "Preset '$Name' not found."
            return
        }
        [pscustomobject]@{
            Name  = $Name
            Files = $store[$Name].Files
            Count = $store[$Name].Count
            Path  = $store[$Name].Path
        }
    }
    else {
        foreach ($key in $store.Keys | Sort-Object) {
            [pscustomobject]@{
                Name  = $key
                Files = $store[$key].Files
                Count = $store[$key].Count
                Path  = $store[$key].Path
            }
        }
    }
}