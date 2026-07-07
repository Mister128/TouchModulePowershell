BeforeAll {
    . "$PSScriptRoot\Shared\Setup.ps1"
    Initialize-TestEnvironment
}

AfterAll {
    Remove-TestEnvironment
}

Describe 'Touch' {
    BeforeEach {
        $script:testFolder = Join-Path $TestDrive "Touch_$(Get-Random)"
        New-Item -Path $script:testFolder -ItemType Directory -Force | Out-Null
    }

    It 'Creates a single file' {
        Touch -Name 'hello.txt' -Path $script:testFolder
        Test-Path (Join-Path $script:testFolder 'hello.txt') | Should -BeTrue
    }

    It 'Creates multiple files from array' {
        Touch -Name 'a.txt', 'b.txt', 'c.txt' -Path $script:testFolder
        'a.txt', 'b.txt', 'c.txt' | ForEach-Object {
            Test-Path (Join-Path $script:testFolder $_) | Should -BeTrue
        }
    }

    It 'Creates numbered files with -Count' {
        Touch -Name 'log.txt' -Count 3 -Path $script:testFolder
        '(1)log.txt', '(2)log.txt', '(3)log.txt' | ForEach-Object {
            Test-Path (Join-Path $script:testFolder $_) | Should -BeTrue
        }
    }

    It 'Updates LastWriteTime of existing file with -Force' {
        $file = Join-Path $script:testFolder 'old.txt'
        New-Item -Path $file -ItemType File | Out-Null
        $oldTime = (Get-Item $file).LastWriteTime
        Start-Sleep -Milliseconds 50

        Touch -Name 'old.txt' -Path $script:testFolder -Force
        (Get-Item $file).LastWriteTime | Should -BeGreaterThan $oldTime
    }

    It 'Warns on existing file without -Force' {
        $file = Join-Path $script:testFolder 'exist.txt'
        New-Item -Path $file -ItemType File | Out-Null

        $warnings = Touch -Name 'exist.txt' -Path $script:testFolder 3>&1
        $warnings | Where-Object { $_ -match 'already exists' } | Should -Not -BeNullOrEmpty
    }

    It 'Accepts pipeline input' {
        'pipe1.txt', 'pipe2.txt' | Touch -Path $script:testFolder
        'pipe1.txt', 'pipe2.txt' | ForEach-Object {
            Test-Path (Join-Path $script:testFolder $_) | Should -BeTrue
        }
    }

    It 'Uses preset when -Preset specified' {
        Save-TouchPreset -Name 'test-preset' -Files 'x.txt', 'y.txt' -Path $script:testFolder | Out-Null
        Touch -Preset 'test-preset'
        'x.txt', 'y.txt' | ForEach-Object {
            Test-Path (Join-Path $script:testFolder $_) | Should -BeTrue
        }
    }

    It 'Throws when preset not found' {
        { Touch -Preset 'nonexistent' } | Should -Throw '*not found*'
    }
}