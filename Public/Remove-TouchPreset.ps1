function Remove-TouchPreset {
    <#
    .SYNOPSIS
        Deletes a saved preset.

    .EXAMPLE
        Remove-TouchPreset -Name web-project
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]$Name
    )

    process {
        $store = Import-TouchPresetStore
        if (-not $store.ContainsKey($Name)) {
            Write-Error "Preset '$Name' not found."
            return
        }
        if ($PSCmdlet.ShouldProcess($Name, "Remove preset")) {
            $store.Remove($Name)
            Export-TouchPresetStore -Store $store
            Write-Verbose "Preset '$Name' removed."
        }
    }
}