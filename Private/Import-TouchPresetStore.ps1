function Import-TouchPresetStore {
    $path = Get-TouchPresetFilePath
    if (-not (Test-Path $path)) { return @{} }
    try {
        $raw = Get-Content -Path $path -Raw -ErrorAction Stop | ConvertFrom-Json
        $store = @{}
        foreach ($prop in $raw.PSObject.Properties) {
            $store[$prop.Name] = @{
                Files = @($prop.Value.Files)
                Count = [int]$prop.Value.Count
                Path  = $prop.Value.Path
            }
        }
        return $store
    }
    catch {
        Write-Warning "Failed to load presets file: $_"
        return @{}
    }
}