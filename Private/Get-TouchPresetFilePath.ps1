function Get-TouchPresetFilePath {
    $folder = Join-Path $env:APPDATA 'CreatorFiles'
    if (-not (Test-Path $folder)) {
        New-Item -Path $folder -ItemType Directory -Force | Out-Null
    }
    Join-Path $folder 'presets.json'
}