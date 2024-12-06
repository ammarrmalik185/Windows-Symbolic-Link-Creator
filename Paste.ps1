param (
    [string]$currentDirectory
)

# Check clipboard contents
$clipboardContent = Get-Clipboard -Format FileDropList

if ($clipboardContent.Count -eq 0) {
    # Show message box if clipboard is empty or invalid
    Add-Type -AssemblyName "System.Windows.Forms"
    [System.Windows.Forms.MessageBox]::Show("Clipboard is empty or does not contain a valid file or folder path.", "Error")
    exit
}

# Get the first item from the clipboard content
$sourceItem = $clipboardContent[0]

# Ensure the current directory parameter is valid
if (-not (Test-Path -Path $currentDirectory -PathType Container)) {
    # Show message box if the current directory is invalid
    Add-Type -AssemblyName "System.Windows.Forms"
    [System.Windows.Forms.MessageBox]::Show("The current directory path is invalid.", "Error")
    exit
}

# Check if the item in the clipboard is a folder or a file
if (Test-Path -Path $sourceItem -PathType Container) {
    # It's a folder, create a symbolic link for a folder
    $linkName = Join-Path -Path $currentDirectory -ChildPath (Split-Path -Leaf $sourceItem)

    # Check if a file/folder already exists with that name
    if (Test-Path -Path $linkName) {
        Add-Type -AssemblyName "System.Windows.Forms"
        [System.Windows.Forms.MessageBox]::Show("A folder already exists with that name. Please choose another location.", "Error")
        exit
    }

    # Debug: Show the command being run for creating the link
    Write-Host "Running Command: mklink /d `"$linkName`" `"$sourceItem`""

    try {
        # Create the symbolic link for the folder
        cmd /c mklink /d "$linkName" "$sourceItem"
        # Show success message box
        Add-Type -AssemblyName "System.Windows.Forms"
    } catch {
        # Show error message box if there's an issue with creating the symbolic link
        Add-Type -AssemblyName "System.Windows.Forms"
        [System.Windows.Forms.MessageBox]::Show("Error creating symbolic link: $_", "Error")
    }
} elseif (Test-Path -Path $sourceItem -PathType Leaf) {
    # It's a file, create a hard link for a file
    $linkName = Join-Path -Path $currentDirectory -ChildPath (Split-Path -Leaf $sourceItem)

    # Check if a file already exists with that name
    if (Test-Path -Path $linkName) {
        Add-Type -AssemblyName "System.Windows.Forms"
        [System.Windows.Forms.MessageBox]::Show("A file already exists with that name. Please choose another location.", "Error")
        exit
    }

    # Debug: Show the command being run for creating the hard link
    Write-Host "Running Command: mklink /h `"$linkName`" `"$sourceItem`""

    try {
        # Create the hard link for the file
        cmd /c mklink "$linkName" "$sourceItem"
        # Show success message box
        Add-Type -AssemblyName "System.Windows.Forms"
    } catch {
        # Show error message box if there's an issue with creating the hard link
        Add-Type -AssemblyName "System.Windows.Forms"
        [System.Windows.Forms.MessageBox]::Show("Error creating hard link: $_", "Error")
    }
} else {
    # Show message box if clipboard content is neither a file nor a folder
    Add-Type -AssemblyName "System.Windows.Forms"
    [System.Windows.Forms.MessageBox]::Show("The clipboard does not contain a valid file or folder path.", "Error")
    exit
}
