Set objShell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
scriptPath = fso.GetParentFolderName(WScript.ScriptFullName)
ps1Path = scriptPath & "\Directory.ps1"

objShell.Run "powershell -NoProfile -ExecutionPolicy Bypass -File """ & ps1Path & """ """ & WScript.Arguments(0) & """", 0, False
