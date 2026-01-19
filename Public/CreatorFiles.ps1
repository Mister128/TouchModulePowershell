function Touch {
    <#
    .SYNOPSIS
        Creates new files or updates timestamps of existing files.
    
    .DESCRIPTION
        The Touch function creates new files or updates the last write time of existing files.
        Similar to the Unix 'touch' command, but with additional PowerShell features.
    
    .PARAMETER Name
        Specifies the path(s) of the file(s) to create or update. Accepts multiple files via pipeline or array.
    
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
        You can pipe file paths to the Touch function.
    
    .NOTES
        Created by: Alexey Kudryakov (Mister Y)
        Version: 1.1
    #>
    
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string[]]$Name,

        [string]$Path,
        [int]$Count,
        [switch]$Force
        
    )
    
    begin {
        Write-Verbose "Creating file(s)"
        if (-not $Path) {
            $Path = '.'
        }
    }

    process {
        function CreateFile($File) {
            if (-not (Test-Path $File) -or $Force) {
                New-Item "$Path\$File" -ItemType File -Force
                Write-Verbose "Created: $File"
            }
            else {
                Write-Warning "File $File already exists in this directory"
                (Get-Item $File).LastWriteTime = Get-Date # if exist, only rewrite date
            }
        }

        foreach ($File in $Name) {
            if ($Count) {
                for ($i = 1; $i -le $Count; $i++) {
                    $NumberedFile = "($i)$File"
                    CreateFile($NumberedFile) # create many files
                }
            }
            else {
                CreateFile($File) # create 1 file
            }
        }
    }

    end {
        Write-Verbose "Creating finish successfully"
    }
}