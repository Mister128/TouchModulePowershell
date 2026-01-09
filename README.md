# CreatorFiles module for Powershell

This module used for creating file(s) and if you want, many similar files (`(1)text.txt, (2)text.txt, ...`)

## Available Commands

- `Touch` - Create files or update timestamps
    ### Features
    - `-Name` - Specifies the file name(s) to create or update.

        Supports multiple files in various formats:
        - Single file: text.txt
        - Multiple files: text.txt, document.md, script.py
        - Pipeline input: "file1.txt", "file2.txt" | Touch

    - `-Path` - if you want create file somewhere else.

        - Example:
            `Touch -Name testFile.txt -Path D:\TestDirectory`

    - `-Count` - Creates multiple numbered copies of each file.

        - Usage: Touch "file.txt" -Count 5

            Result: Creates (1)file.txt, (2)file.txt, (3)file.txt, (4)file.txt, (5)file.txt

    
    - `-Force` - Forces timestamp updates on existing files.

        - Without -Force: Shows warning if file exists, but updates timestamp

        - With -Force: Silently updates timestamp without warnings

        - Always creates new files if they don't exist

## Installation

To use the command, please unzip the folder in the path `C:\Users\Your_Profile\Documents\Powershell\Modules\`

After that, run powershell in `\Modules\` directory and write the command:

```powershell
Import-Module CreatorFiles
```

## License

This project is open source and available under the MIT License.
