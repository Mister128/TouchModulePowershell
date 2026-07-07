BeforeAll {
    . "$PSScriptRoot\Shared\Setup.ps1"
    Initialize-TestEnvironment
}

AfterAll {
    Remove-TestEnvironment
}

Describe 'Remove-TouchPreset' {
    It 'Removes existing preset' {
        Save-TouchPreset -Name 'to-delete' -Files 'x.txt' | Out-Null
        Remove-TouchPreset -Name 'to-delete' -Confirm:$false
        Get-TouchPreset -Name 'to-delete' -ErrorAction SilentlyContinue | Should -BeNullOrEmpty
    }

    It 'Accepts pipeline input from Get-TouchPreset' {
        Save-TouchPreset -Name 'pipe-del' -Files 'x.txt' | Out-Null
        Get-TouchPreset -Name 'pipe-del' | Remove-TouchPreset -Confirm:$false
        Get-TouchPreset -Name 'pipe-del' -ErrorAction SilentlyContinue | Should -BeNullOrEmpty
    }

    It 'Errors on unknown preset' {
        { Remove-TouchPreset -Name 'nope' -Confirm:$false -ErrorAction Stop } | Should -Throw '*not found*'
    }

    It 'Does not remove other presets' {
        Save-TouchPreset -Name 'keep' -Files 'keep.txt' | Out-Null
        Save-TouchPreset -Name 'remove' -Files 'remove.txt' | Out-Null
        Remove-TouchPreset -Name 'remove' -Confirm:$false
        Get-TouchPreset -Name 'keep' | Should -Not -BeNullOrEmpty
    }
}