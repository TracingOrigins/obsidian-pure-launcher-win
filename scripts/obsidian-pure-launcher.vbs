' obsidian.vbs
' 1. Remove ,"open":true from json file
' 2. Search for Obsidian.exe in common directories, launch the first found

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

' 2. Search and launch Obsidian.exe
localAppData = ws.ExpandEnvironmentStrings("%LOCALAPPDATA%")
programFiles = ws.ExpandEnvironmentStrings("%ProgramFiles%")
programFilesX86 = ws.ExpandEnvironmentStrings("%ProgramFiles(x86)%")
programW6432 = ws.ExpandEnvironmentStrings("%ProgramW6432%")

Dim envPaths, envValue, i, found, obsidianExe
envPaths = Array(localAppData, programFiles, programFilesX86, programW6432)
found = False
For i = 0 To UBound(envPaths)
    envValue = envPaths(i)
    If envValue <> "" Then
        obsidianExe = envValue & "\Obsidian\Obsidian.exe"
        If fso.FileExists(obsidianExe) Then
            ws.Run """" & obsidianExe & """", 1, False
            found = True
            Exit For
        End If
    End If
Next
If Not found Then
    ws.Run "obsidian.exe"
End If
