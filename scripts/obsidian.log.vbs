' obsidian.vbs
' 1. Remove ,"open":true from json file
' 2. Search for Obsidian.exe in common directories, launch the first found

On Error Resume Next
Set ws = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
Dim log: log = ""

' 1. Process obsidian.json
jsonFile = ws.ExpandEnvironmentStrings("%APPDATA%\obsidian\obsidian.json")
log = log & "Check obsidian.json: " & jsonFile & vbCrLf
If fso.FileExists(jsonFile) Then
    log = log & "[Found] Modifying obsidian.json..." & vbCrLf
    Set file = fso.OpenTextFile(jsonFile, 1, False)
    content = file.ReadAll
    file.Close
    newContent = Replace(content, ",""open"":true", "")
    Set file = fso.OpenTextFile(jsonFile, 2, False)
    file.Write newContent
    file.Close
    log = log & "[Success] Config file modified." & vbCrLf
Else
    log = log & "[Warning] obsidian.json not found." & vbCrLf
End If
log = log & vbCrLf

' 2. Search and launch Obsidian.exe
localAppData = ws.ExpandEnvironmentStrings("%LOCALAPPDATA%")
programFiles = ws.ExpandEnvironmentStrings("%ProgramFiles%")
programFilesX86 = ws.ExpandEnvironmentStrings("%ProgramFiles(x86)%")
programW6432 = ws.ExpandEnvironmentStrings("%ProgramW6432%")

Dim envPaths, envValue, i
envPaths = Array(localAppData, programFiles, programFilesX86, programW6432)
For i = 0 To UBound(envPaths)
    envValue = envPaths(i)
    log = log & "Checking Obsidian.exe " & (i+1) & ": " & envValue & "\Obsidian\Obsidian.exe" & vbCrLf
    If envValue <> "" Then
        obsidianExe = envValue & "\Obsidian\Obsidian.exe"
        If fso.FileExists(obsidianExe) Then
            log = log & "[Found] " & obsidianExe & vbCrLf & "Launching Obsidian..." & vbCrLf
            ws.Run """" & obsidianExe & """", 1, False
            found = True
            Exit For
        Else
            log = log & "[Not found] " & obsidianExe & vbCrLf
        End If
    End If
    log = log & vbCrLf
Next

If Not found Then
    log = log & "Obsidian not found in all paths, try launching by environment variable..." & vbCrLf
    ws.Run "obsidian.exe"
End If

log = log & vbCrLf & "Script finished."
MsgBox log, 0, "Obsidian Launcher Log"
