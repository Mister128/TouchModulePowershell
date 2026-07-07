@{
    RootModule        = 'CreatorFiles.psm1'
    ModuleVersion     = '2.1'
    GUID              = '115bd93b-ae11-4d47-8fb9-24c45521011a'
    Author            = 'Mister Y'
    CompanyName       = 'Unknown'
    Copyright         = '(c) 2026 Mister Y. All rights reserved.'
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
}