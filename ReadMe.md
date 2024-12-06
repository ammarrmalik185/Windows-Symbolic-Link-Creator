Create Hardlink and Paste Hardlink Utilities
============================================

This repository contains two utility scripts for managing hardlinks in Windows. These scripts integrate with the Windows context menu to allow easy creation and pasting of hardlinks using a graphical user interface (GUI) and command-line operations.

Features
--------

1.  **Create Hardlink** Allows users to select a target folder via a GUI and creates a hardlink at the current directory.

    *   Appears in the right-click context menu.

    *   Enables folder selection for the target.

2.  **Paste Hardlink** Uses the clipboard to create a hardlink in the current directory pointing to the file or folder copied to the clipboard.

    *   If an error occurs (e.g., clipboard is empty or invalid), an error popup is shown.

    *   No GUI is displayed for folder selection.


Context Menu Integration
------------------------

The scripts are designed to appear in the **Windows 11 context menu**:
*   **"Create Hardlink"**: Available when right-clicking inside a folder.
*   **"Paste Hardlink"**: Available when right-clicking inside a folder with a valid clipboard entry.

![image](https://github.com/user-attachments/assets/64693382-7b69-49dc-991f-0d186325e250)


Setup Instructions
------------------

1.  **Prerequisites**
    *   Ensure PowerShell is installed on your system.
    *   The scripts require Windows PowerShell 5.0 or higher.

2.  **Script Files**
    *   Place the following files in the same folder:
        *   Directory.ps1
        *   Paste.ps1
        *   RunHardlink - Directory.vbs
        *   RunHardlink - Paste.vbs
        *   link.ico (optional, you can also change the icon)
        *   Install.bat

3.  **Run the Install.bat, there should be a "Registry entries added successfully!" print**

**You can uninstall by using the Uninstall.bat file (you will need to start as administrator)**

Script Descriptions
-------------------

### 1. **Directory.ps1**

#### Description:

This script allows the user to create a hardlink at the current directory, pointing to a folder selected using a GUI.

#### Workflow:
*   The user selects a target folder via a dialog.
*   The script creates a hardlink in the current directory using the selected folder's name.

#### Usage:
*   Right-click inside a folder and select **"Create Hardlink"**.
*   A folder selection dialog will appear.
*   Select the target folder.
*   The hardlink will be created in the current directory.


### 2. **Paste.ps1**

#### Description:

This script creates a hardlink in the current directory, pointing to the file or folder currently copied to the clipboard.

#### Workflow:
*   The script retrieves the clipboard content.
*   If valid, it creates a hardlink in the current directory using the source's name.

#### Error Handling:
*   If the clipboard is empty or contains invalid data, an error popup is shown.


#### Usage:

*   Copy a file or folder to the clipboard.
*   Right-click inside a folder and select **"Paste Hardlink"**.
*   The hardlink will be created in the current directory.
