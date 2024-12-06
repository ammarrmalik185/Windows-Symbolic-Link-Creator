# Enable use of Windows Forms
Add-Type -AssemblyName System.Windows.Forms

# Function to prompt the user to select a folder
function Select-TargetFolder {
    $folderDialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $folderDialog.Description = "Select the source folder to create a hard link:"
    $folderDialog.ShowNewFolderButton = $false

    if ($folderDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        return $folderDialog.SelectedPath
    } else {
        Write-Host "No folder selected. Operation cancelled."
        Exit
    }
}

# Get the current directory from the passed argument
$currentPath = $args[0]

# Ensure a current path is provided
if (-not $currentPath) {
    Write-Host "No current directory provided. Operation cancelled."
    Exit
}

# Prompt the user to select the target folder
$targetFolder = Select-TargetFolder

# Construct the path where the hard link will be created
$linkName = Split-Path -Leaf $targetFolder
$hardLinkPath = Join-Path -Path $currentPath -ChildPath $linkName

# Create the hard link
try {
    cmd /c mklink /D "$hardLinkPath" "$targetFolder"
    Write-Host "Hard link created successfully at $hardLinkPath."
} catch {
    Write-Host "Failed to create hard link. Error: $_"
}

Pause
