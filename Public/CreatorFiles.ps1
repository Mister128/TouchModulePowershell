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
        Version: 1.0
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
    }

    process {
        if (-not $Path) {
            $Path = '.'
        }

        foreach ($File in $Name) {
            if ($Count) {
                # create many files
                for ($i = 1; $i -le $Count; $i++) {
                    $NumberedFile = "($i)$File"
                    # check exists
                    if (-not (Test-Path $NumberedFile) -or $Force) {
                        New-Item "$Path\$NumberedFile" -ItemType File -Force
                        Write-Verbose "Created: $NumberedFile"
                    } else {
                        # if not exist, only rewrite date
                        Write-Warning "File $NumberedFile already exists in this directory"
                        (Get-Item $NumberedFile).LastWriteTime = Get-Date
                    }
                }
            }
            else {
                # create 1 file
                if (-not (Test-Path $File) -or $Force) {
                    New-Item "$Path\$File" -ItemType File -Force
                    Write-Verbose "Created: $File"
                } else {
                    # if not exist, only rewrite date
                    Write-Warning "File $File already exists in this directory"
                    (Get-Item $File).LastWriteTime = Get-Date
                }
            }
        }
    }

    end {
        Write-Verbose "Operation completed successfully"
    }
}