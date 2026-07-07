@{
    RootModule        = 'CreatorFiles.psm1'
    ModuleVersion     = '2.1.1'
    GUID              = '6a5ca6c3-19bc-412d-83e3-1ca666591caf'
    Author            = 'MisterY'
    CompanyName       = 'Community'
    Copyright         = '(c) 2026 MisterY. All rights reserved.'
    Description       = 'Creates files and manages file templates with presets'
    PowerShellVersion = '5.1'
    FunctionsToExport = @(
        'Touch',
        'Save-TouchPreset',
        'Get-TouchPreset',
        'Remove-TouchPreset'
    )
    CmdletsToExport   = @()
    VariablesToExport = @()
    AliasesToExport   = @()

    PrivateData = @{
        PSDATA = @{
            Tags    = @('touch', 'file', 'preset', 'template', 'utility', 'PSEdition_Desktop', 'PSEdition_Core')
            LicenceUri = 'https://github.com/Mister128/TouchModulePowershell/blob/main/LICENSE'
            ProjectUri = 'https://github.com/Mister128/TouchModulePowershell'
        }
    }
}
