function Touch {
    <#
    .SYNOPSIS
        Creates new files or updates timestamps of existing files.

    .DESCRIPTION
        The Touch function creates new files or updates the last write time of existing files.
        Similar to the Unix 'touch' command, but with additional PowerShell features.
        It can also create files from a saved preset.
        For preset management, see the related cmdlets in the NOTES section.

    .PARAMETER Name
        Specifies the path(s) of the file(s) to create or update.

    .PARAMETER Preset
        Name of a previously saved preset.

    .PARAMETER Count
        Creates multiple numbered copies of the file. For example, -Count 3 creates (1)file.txt, (2)file.txt, (3)file.txt.
    
    .PARAMETER Force
        Forces the command to update timestamps even if the file already exists. Without -Force, shows warning for existing files.

    .PARAMETER Path
        Specifies the directory path where the file(s) will be created.

    .EXAMPLE
        Touch "newfile.txt"
        Creates a new file or updates its timestamp if it exists.
    
    .EXAMPLE
        Touch "file1.txt", "file2.txt", "file3.txt"
        Creates or updates multiple files.
    
    .EXAMPLE
        Touch "template.txt" -Count 5
        Creates 5 numbered files: (1)template.txt, (2)template.txt, ..., (5)template.txt.
    
    .EXAMPLE
        Touch "log.txt" -Force
        Always updates the file timestamp, even if it exists.
    
    .EXAMPLE
        "file1.txt", "file2.txt" | Touch -Force
        Processes files from pipeline with forced update.

    .INPUTS
        System.String[]
        You can pipe file paths to the Touch function via the -Name parameter.

    .OUTPUTS
        None
        This function does not produce output by default. Use -Verbose to see created files.

    .EXAMPLE
        Touch -Preset web-project
        Creates all files defined in the "web-project" preset.

    .EXAMPLE
        Touch -Preset logs -Path D:\Logs
        Applies the "logs" preset but overrides the target directory.

    .NOTES
        Author:  Alexey Kudryakov (Mister Y)
        Version: 2.0

        Related cmdlets for preset management:
        - Save-TouchPreset   : save a new preset
        - Get-TouchPreset    : list or inspect presets
        - Remove-TouchPreset : delete a preset
    #>
    
    [CmdletBinding(DefaultParameterSetName = 'ByName')]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'ByName')]
        [string[]]$Name,

        [Parameter(Mandatory = $true, ParameterSetName = 'ByPreset')]
        [string]$Preset,

        [string]$Path,
        [int]$Count,
        [switch]$Force
    )
    
    begin {
        Write-Verbose "Creating file(s)"

        if (-not $Path) { $Path = '.' }

        if ($PSCmdlet.ParameterSetName -eq 'ByPreset') {
            $store = Import-TouchPresetStore
            if (-not $store.ContainsKey($Preset)) {
                throw "Preset '$Preset' not found. Use Get-TouchPreset to list available presets."
            }
            $presetData = $store[$Preset]
            $Name = $presetData.Files
            if (-not $PSBoundParameters.ContainsKey('Count')) { $Count = $presetData.Count }
            if (-not $PSBoundParameters.ContainsKey('Path') -and $presetData.Path) {
                $Path = $presetData.Path
            }
        }
    }

    process {
        function CreateFile($File) {
            $fullPath = Join-Path $Path $File
            if (-not (Test-Path $fullPath) -or $Force) {
                New-Item -Path $fullPath -ItemType File -Force | Out-Null
                Write-Verbose "Created: $fullPath"
            }
            else {
                Write-Warning "File $File already exists in this directory"
                (Get-Item $fullPath).LastWriteTime = Get-Date
            }
        }

        foreach ($File in $Name) {
            if ($Count -and $Count -gt 1) {
                for ($i = 1; $i -le $Count; $i++) {
                    CreateFile "($i)$File"
                }
            }
            else {
                CreateFile $File
            }
        }
    }
    
    end { Write-Verbose "Creating finished successfully" }
}