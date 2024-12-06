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

# Function to prompt the user to select a file
function Select-TargetFile {
    $fileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $fileDialog.Title = "Select the source file to create a hard link:"
    $fileDialog.Filter = "All Files (*.*)|*.*"

    if ($fileDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        return $fileDialog.FileName
    } else {
        Write-Host "No file selected. Operation cancelled."
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

# Popup to ask the user if they want to create a link for a folder or a file
$dialogResult = [System.Windows.Forms.MessageBox]::Show(
    "Do you want to create a link for a folder? ( No for file )",
    "Choose Link Type",
    [System.Windows.Forms.MessageBoxButtons]::YesNo
)

if ($dialogResult -eq [System.Windows.Forms.DialogResult]::Yes) {
    # User chose "Yes" for folder, so prompt for a folder
    $targetFolder = Select-TargetFolder

    # Construct the path where the symbolic link will be created
    $linkName = Split-Path -Leaf $targetFolder
    $hardLinkPath = Join-Path -Path $currentPath -ChildPath $linkName

    # Create the symbolic link for the folder
    try {
        cmd /c mklink /D "$hardLinkPath" "$targetFolder"
        Write-Host "Symbolic link for folder created successfully at $hardLinkPath."
    } catch {
        Write-Host "Failed to create symbolic link. Error: $_"
    }
} elseif ($dialogResult -eq [System.Windows.Forms.DialogResult]::No) {
    # User chose "No" for file, so prompt for a file
    $targetFile = Select-TargetFile

    # Construct the path where the hard link will be created
    $linkName = Split-Path -Leaf $targetFile
    $hardLinkPath = Join-Path -Path $currentPath -ChildPath $linkName

    # Create the hard link for the file
    try {
        cmd /c mklink "$hardLinkPath" "$targetFile"
        Write-Host "Hard link for file created successfully at $hardLinkPath."
    } catch {
        Write-Host "Failed to create hard link. Error: $_"
    }
} else {
    Write-Host "Operation cancelled by the user."
}

Pause
