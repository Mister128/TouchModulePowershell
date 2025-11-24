@{
    RootModule = 'CreatorFiles.psm1'
    ModuleVersion = '1.0.0'
    GUID = '115bd93b-ae11-4d47-8fb9-24c45521011a'

    Author = 'Alexey Kudryakov (Mister Y)'
    Description = 'Helps create and manage files efficiently. Can create single files, update timestamps, or generate multiple identical files with numbering for testing and organization purposes.'

    PowerShellVersion = '5.1'
    CompatiblePSEditions = @('Desktop', 'Core')

    RequiredModules   = @()
    NestedModules     = @()
    FunctionsToExport = @('Touch')
    CmdletsToExport   = @()
    VariablesToExport = '*'
    AliasesToExport   = @()
}