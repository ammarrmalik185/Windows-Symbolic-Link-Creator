@echo off

:: Notify the user about the uninstallation process
echo This will remove the registry entries for HardLink Paste and HardLink Creator.
echo You need administrator privileges to proceed.
pause

:: Remove the registry entries using reg commands
echo Removing registry entries...

:: Remove HardLink Paste from Directory
reg delete "HKEY_CLASSES_ROOT\Directory\shell\HardLink Paste" /f

:: Remove HardLink Paste from Background
reg delete "HKEY_CLASSES_ROOT\Directory\Background\shell\HardLink Paste" /f

:: Remove HardLink Creator from Background
reg delete "HKEY_CLASSES_ROOT\Directory\Background\shell\HardLink Creator" /f

:: Check if the commands succeeded
if errorlevel 1 (
    echo Failed to delete some registry entries. Ensure you are running as Administrator.
    pause
    exit /b
)

echo Registry entries successfully removed!
pause
