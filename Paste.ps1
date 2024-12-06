param (
    [string]$currentDirectory
)

# Check clipboard contents
$clipboardContent = Get-Clipboard -Format FileDropList

if ($clipboardContent.Count -eq 0) {
    # Show message box if clipboard is empty or invalid
    Add-Type -AssemblyName "System.Windows.Forms"
    [System.Windows.Forms.MessageBox]::Show("Clipboard is empty or does not contain a valid folder path.", "Error")
    exit
}

# Ensure clipboard content is a folder
$sourceFolder = $clipboardContent[0]
if (-not (Test-Path -Path $sourceFolder -PathType Container)) {
    # Show message box if clipboard doesn't contain a valid folder
    Add-Type -AssemblyName "System.Windows.Forms"
    [System.Windows.Forms.MessageBox]::Show("The clipboard does not contain a valid folder path.", "Error")
    exit
}

# Ensure the current directory parameter is valid
if (-not (Test-Path -Path $currentDirectory -PathType Container)) {
    # Show message box if the current directory is invalid
    Add-Type -AssemblyName "System.Windows.Forms"
    [System.Windows.Forms.MessageBox]::Show("The current directory path is invalid.", "Error")
    exit
}

# Corrected: The desired link name should be the current directory + leaf of the source folder
$linkName = Join-Path -Path $currentDirectory -ChildPath (Split-Path -Leaf $sourceFolder)

# Debug: Show the full path of the link being created
Write-Host "Current Directory: $currentDirectory"
Write-Host "Link Name (Final Path): $linkName"

# Check if a file/folder already exists with that name
if (Test-Path -Path $linkName) {
    Add-Type -AssemblyName "System.Windows.Forms"
    [System.Windows.Forms.MessageBox]::Show("A file or folder already exists with that name. Please choose another location.", "Error")
    exit
}

# Debug: Show the command being run for creating the link
Write-Host "Running Command: mklink /d `"$linkName`" `"$sourceFolder`""

try {
    # Create the hardlink in the current directory (current folder -> link points to source folder)
    cmd /c mklink /d "$linkName" "$sourceFolder"
    # Show success message box
    Add-Type -AssemblyName "System.Windows.Forms"
    [System.Windows.Forms.MessageBox]::Show("Hardlink created successfully at: $linkName", "Success")
} catch {
    # Show error message box if there's an issue with creating the hardlink
    Add-Type -AssemblyName "System.Windows.Forms"
    [System.Windows.Forms.MessageBox]::Show("Error creating hardlink: $_", "Error")
}
