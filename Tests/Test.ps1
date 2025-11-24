Describe "Touch Basic Tests" {
    $TestFolder = "TestDrive:"

    It "Create simple file" {
        Touch -Path $TestFolder -Name "test.txt"
        "$TestFolder\test.txt" | Should Exist
    }

    It "Create 3 files" {
        Touch -Path $TestFolder -Name "file.txt" -Count 3
        
        "$TestFolder\(1)file.txt" | Should Exist
        "$TestFolder\(2)file.txt" | Should Exist
        "$TestFolder\(3)file.txt" | Should Exist
    }

    It "Create file with -Force" {
        $testFile = "force.txt"
        Touch -Path $TestFolder -Name $testFile

        Touch -Path $TestFolder -Name $testFile -Force
        "$TestFolder\$testFile" | Should Exist
    }
}