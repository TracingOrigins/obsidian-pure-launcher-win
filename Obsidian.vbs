' obsidian.vbs
' 1. Remove ,"open":true from obsidian.json
' 2. Launch Obsidian.exe in the same directory

On Error Resume Next
Set ws = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

' 1. Process obsidian.json using PowerShell approach
jsonFile = ws.ExpandEnvironmentStrings("%APPDATA%\obsidian\obsidian.json")
If fso.FileExists(jsonFile) Then
    ' 使用PowerShell方式处理文件，确保UTF-8 without BOM
    psCommand = "powershell -Command ""$c = [System.IO.File]::ReadAllText('" & jsonFile & "'); $c = $c -replace ',\""open\"":true', ''; [System.IO.File]::WriteAllText('" & jsonFile & "', $c, (New-Object System.Text.UTF8Encoding($false)))"""
    ws.Run "cmd /c " & psCommand & " >nul", 0, True
End If

' 2. Launch Obsidian.exe
obsidianExe = fso.GetAbsolutePathName("Obsidian.exe")
If fso.FileExists(obsidianExe) Then
    ws.Run """" & obsidianExe & """", 1, False
Else
    ws.Run "obsidian.exe"
End If
