@echo off

:: Get the current directory where this batch file is located
set "BASE_DIRECTORY=%~dp0"
set "BASE_DIRECTORY=%BASE_DIRECTORY:~0,-1%"  :: Remove the trailing backslash
set "BASE_DIRECTORY=%BASE_DIRECTORY:\=\\%"  :: Replace single backslashes with double backslashes

:: Create the registry entries
echo Windows Registry Editor Version 5.00 > temp.reg
echo. >> temp.reg
echo [HKEY_CLASSES_ROOT\Directory\shell\HardLink Paste] >> temp.reg
echo @="Paste Hardlink" >> temp.reg
echo "Icon"="%BASE_DIRECTORY%\\link.ico" >> temp.reg
echo. >> temp.reg
echo [HKEY_CLASSES_ROOT\Directory\shell\HardLink Paste\command] >> temp.reg
echo @="wscript.exe \"%BASE_DIRECTORY%\\RunHardLink - Paste.vbs\" \"%%V\"" >> temp.reg
echo. >> temp.reg
echo [HKEY_CLASSES_ROOT\Directory\Background\shell\HardLink Paste] >> temp.reg
echo @="Paste Hardlink" >> temp.reg
echo "Icon"="%BASE_DIRECTORY%\\link.ico" >> temp.reg
echo. >> temp.reg
echo [HKEY_CLASSES_ROOT\Directory\Background\shell\HardLink Paste\command] >> temp.reg
echo @="wscript.exe \"%BASE_DIRECTORY%\\RunHardLink - Paste.vbs\" \"%%V\"" >> temp.reg
echo. >> temp.reg
echo [HKEY_CLASSES_ROOT\Directory\Background\shell\HardLink Creator] >> temp.reg
echo @="Create a HardLink here" >> temp.reg
echo "Icon"="%BASE_DIRECTORY%\\link.ico" >> temp.reg
echo. >> temp.reg
echo [HKEY_CLASSES_ROOT\Directory\Background\shell\HardLink Creator\command] >> temp.reg
echo @="wscript.exe \"%BASE_DIRECTORY%\\RunHardLink - Directory.vbs\" \"%%V\"" >> temp.reg

:: Add the registry entries
regedit /s "%CD%\temp.reg"

:: Clean up the temporary .reg file
del temp.reg

echo Registry entries added successfully!
pause
