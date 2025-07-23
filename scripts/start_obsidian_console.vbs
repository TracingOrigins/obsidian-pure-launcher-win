Set ws = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
Dim log: log = ""

' Get Program Files directories
On Error Resume Next
ProgramFilesPath = ws.RegRead("HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\ProgramFilesDir")
If ProgramFilesPath = "" Then ProgramFilesPath = "C:\\Program Files"
log = log & "Program Files: " & ProgramFilesPath & vbCrLf

ProgramFiles86Path = ws.RegRead("HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\ProgramFilesDir (x86)")
If ProgramFiles86Path = "" Then ProgramFiles86Path = "C:\\Program Files (x86)"
log = log & "Program Files (x86): " & ProgramFiles86Path & vbCrLf

ProgramW6432Dir = ws.RegRead("HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\ProgramW6432Dir")
If ProgramW6432Dir = "" Then ProgramW6432Dir = "C:\\Program Files"
log = log & "Program W6432: " & ProgramW6432Dir & vbCrLf & vbCrLf

' Modify Obsidian config file
obsidianJsonPath = ws.ExpandEnvironmentStrings("%APPDATA%\\obsidian\\obsidian.json")
log = log & "Check config file: " & obsidianJsonPath & vbCrLf
If fso.FileExists(obsidianJsonPath) Then
    log = log & "[Found] Modifying obsidian.json..." & vbCrLf
    Set file = fso.OpenTextFile(obsidianJsonPath, 1, False)
    content = file.ReadAll
    file.Close
    newContent = Replace(content, ",""open"":true", "")
    Set file = fso.OpenTextFile(obsidianJsonPath, 2, False)
    file.Write newContent
    file.Close
    log = log & "[Success] Config file modified." & vbCrLf
Else
    log = log & "[Warning] obsidian.json not found." & vbCrLf
End If
log = log & vbCrLf

' Find and launch Obsidian.exe
Dim paths(3)
paths(0) = ws.ExpandEnvironmentStrings("%LOCALAPPDATA%\Obsidian\Obsidian.exe")
paths(1) = ProgramFilesPath & "\\Obsidian\\Obsidian.exe"
paths(2) = ProgramFiles86Path & "\\Obsidian\\Obsidian.exe"
paths(3) = ProgramW6432Dir & "\\Obsidian\\Obsidian.exe"

found = False
For i = 0 To 3
    log = log & "Checking path " & (i+1) & ": " & paths(i) & vbCrLf
    If fso.FileExists(paths(i)) Then
        log = log & "[Found] " & paths(i) & vbCrLf & "Launching Obsidian..." & vbCrLf
        ws.Run Chr(34) & paths(i) & Chr(34)
        found = True
        Exit For
    Else
        log = log & "[Not found] " & paths(i) & vbCrLf
    End If
    log = log & vbCrLf
Next

If Not found Then
    log = log & "Obsidian not found in all paths, try launching by environment variable..." & vbCrLf
    ws.Run "obsidian.exe"
End If

log = log & vbCrLf & "Script finished."
MsgBox log, 0, "Obsidian Launcher Log"
