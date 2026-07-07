function Export-TouchPresetStore {
    param([hashtable]$Store)
    $path = Get-TouchPresetFilePath
    $Store | ConvertTo-Json -Depth 5 | Set-Content -Path $path -Encoding UTF8
}