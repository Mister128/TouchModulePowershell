# CreatorFiles module for Powershell


<div align=center>

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![PowerShell 5.1+](https://img.shields.io/badge/PowerShell-5.1%2B-blue)](https://github.com/PowerShell/PowerShell)
[![PowerShell Gallery](https://img.shields.io/powershellgallery/v/CreatorFiles.svg)](https://www.powershellgallery.com/packages/CreatorFiles)
[![PowerShell Gallery](https://img.shields.io/powershellgallery/dt/CreatorFiles.svg)](https://www.powershellgallery.com/packages/CreatorFiles)
[![CI](https://github.com/Mister128/TouchModulePowershell/actions/workflows/tests.yml/badge.svg)](https://github.com/Mister128/TouchModulePowershell/actions)

**PowerShell module that extends the Unix `touch` command with reusable file presets.**

[Installation](#installation) • [Quick Start](#quick-start) • [Documentation](#available-commands)

</div>

---

## About

**CreatorFiles** is a PowerShell module that brings the Unix `touch` command to Windows with modern enhancements. Create files, update timestamps, generate numbered copies, and - the killer feature - **save reusable file templates as presets**.

Perfect for developers, sysadmins, and anyone who regularly creates the same project scaffolding.

## Table of Contents

- [Installation](#installation)
- [Quick Start](#quick-start)
- [Available Commands](#available-commands)
- [Testing](#testing)
- [Requirements](#requirements)
- [License](#license)

## Installation

### From PowerShell Gallery (recommended)

```powershell
Install-Module CreatorFiles -Scope CurrentUser
```

### Manual installation

```powershell
# Clone the repository
git clone https://github.com/Mister128/TouchModulePowershell.git

# Copy to your modules folder
Copy-Item -Path .\TouchModulePowershell\CreatorFiles -Destination "$env:USERPROFILE\Documents\WindowsPowerShell\Modules\CreatorFiles" -Recurse

# Import the module
Import-Module CreatorFiles
```

## Quick Start

```powershell
# Create a single file
Touch "readme.md"

# Create multiple files at once
Touch "index.html", "style.css", "app.js"

# Create numbered copies
Touch "log.txt" -Count 7
# -> (1)log.txt, (2)log.txt, ..., (7)log.txt

# Save a project template
Save-TouchPreset -Name web-project -Files index.html, style.css, script.js

# Apply the template
Touch -Preset web-project -Path C:\Projects\my-site

# See all saved presets
Get-TouchPreset
```

## Available Commands

### `Touch`

Creates new files or updates timestamps of existing ones.

#### Parameters

| Parameter | Description |
|-----------|-------------|
| `-Name` | File name(s) to create or update. Accepts pipeline input. |
| `-Preset` | Name of a saved preset (mutually exclusive with `-Name`). |
| `-Path` | Target directory. Defaults to current directory. |
| `-Count` | Creates numbered copies: `(1)file.txt`, `(2)file.txt`, ... |
| `-Force` | Silently updates timestamps on existing files. |


### `Save-TouchPreset`

Saves a file template for later use.

```powershell
# Save a web project template
Save-TouchPreset -Name web-project -Files index.html, style.css, app.js

# Save with default path and count
Save-TouchPreset -Name week-logs -Files log.txt -Count 7 -Path C:\Logs
```

### `Get-TouchPreset`

Lists all saved presets or inspects a specific one.

```powershell
# List all presets
Get-TouchPreset

# Inspect a specific preset
Get-TouchPreset -Name web-project
```

### `Remove-TouchPreset`

Deletes a saved preset.

```powershell
# Remove a preset
Remove-TouchPreset -Name week-logs

# Pipeline support
Get-TouchPreset -Name old-preset | Remove-TouchPreset
```

### Note

Presets are stored in `%APPDATA%\CreatorFiles\presets.json`:

## Testing

The module is covered by **Pester 5** tests (24 tests).

```powershell
# Install Pester 5 (if needed)
Install-Module Pester -Force -SkipPublisherCheck -Scope CurrentUser

# Run all tests
Invoke-Pester -Path .\Tests\
```

Tests run automatically on every push via GitHub Actions.

## Requirements

- **PowerShell 5.1+** (Windows PowerShell or PowerShell Core 7+)
- **Windows 10/11** or **Windows Server 2016+**
- **Pester 5+** (for running tests)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
