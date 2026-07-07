BeforeAll {
    . "$PSScriptRoot\Shared\Setup.ps1"
    Initialize-TestEnvironment
    
    Save-TouchPreset -Name 'alpha' -Files 'a.txt' | Out-Null
    Save-TouchPreset -Name 'beta'  -Files 'b.txt' -Count 5 | Out-Null
}

AfterAll {
    Remove-TestEnvironment
}

Describe 'Get-TouchPreset' {
    It 'Returns all presets when -Name omitted' {
        $all = Get-TouchPreset
        $all.Count | Should -BeGreaterOrEqual 2
        $all.Name | Should -Contain 'alpha'
        $all.Name | Should -Contain 'beta'
    }

    It 'Returns specific preset by name' {
        $p = Get-TouchPreset -Name 'beta'
        $p.Name  | Should -Be 'beta'
        $p.Count | Should -Be 5
    }

    It 'Writes error for unknown preset' {
        $err = Get-TouchPreset -Name 'ghost' 2>&1
        $err | Should -Not -BeNullOrEmpty
    }

    It 'Returns preset with correct Files array' {
        $p = Get-TouchPreset -Name 'alpha'
        $p.Files | Should -Be @('a.txt')
    }
}