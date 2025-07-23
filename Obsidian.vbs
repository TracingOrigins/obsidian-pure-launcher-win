' obsidian.vbs
' 1. Remove ,"open":true from obsidian.json
' 2. Launch Obsidian.exe in the same directory

On Error Resume Next
Set ws = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

' 1. Process obsidian.json
jsonFile = ws.ExpandEnvironmentStrings("%APPDATA%\obsidian\obsidian.json")
If fso.FileExists(jsonFile) Then
    Set file = fso.OpenTextFile(jsonFile, 1, False)
    content = file.ReadAll
    file.Close
    newContent = Replace(content, ",""open"":true", "")
    Set file = fso.OpenTextFile(jsonFile, 2, False)
    file.Write newContent
    file.Close
End If

' 2. Launch Obsidian.exe
obsidianExe = fso.GetAbsolutePathName("Obsidian.exe")
If fso.FileExists(obsidianExe) Then
    ws.Run """" & obsidianExe & """", 1, False
Else
    ws.Run "obsidian.exe"
End If
