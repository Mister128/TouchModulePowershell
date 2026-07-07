function Initialize-TestEnvironment {
    $modulePath = Join-Path $PSScriptRoot '..\..\CreatorFiles.psd1'
    Import-Module $modulePath -Force

    $script:tempPresetsFolder = Join-Path $TestDrive 'Presets'
    New-Item -Path $script:tempPresetsFolder -ItemType Directory -Force | Out-Null
    $env:CREATORFILES_PRESETS_PATH = $script:tempPresetsFolder
}

function Clear-TestEnvironment {
    Remove-Module CreatorFiles -Force -ErrorAction SilentlyContinue
    Remove-Item env:CREATORFILES_PRESETS_PATH -ErrorAction SilentlyContinue
}