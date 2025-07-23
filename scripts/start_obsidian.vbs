' 1. 获取 Program Files 等目录
On Error Resume Next
Set ws = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

ProgramFilesPath = ws.RegRead("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ProgramFilesDir")
ProgramFiles86Path = ws.RegRead("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ProgramFilesDir (x86)")
ProgramW6432Dir = ws.RegRead("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ProgramW6432Dir")

' 2. 修改 Obsidian 配置文件
obsidianJsonPath = ws.ExpandEnvironmentStrings("%APPDATA%\obsidian\obsidian.json")
If fso.FileExists(obsidianJsonPath) Then
    Set file = fso.OpenTextFile(obsidianJsonPath, 1, False)
    content = file.ReadAll
    file.Close
    newContent = Replace(content, ",""open"":true", "")
    Set file = fso.OpenTextFile(obsidianJsonPath, 2, False)
    file.Write newContent
    file.Close
End If

' 3. 查找 Obsidian.exe 并启动
Dim paths(3)
paths(0) = ws.ExpandEnvironmentStrings("%LOCALAPPDATA%\Obsidian\Obsidian.exe")
paths(1) = ProgramFilesPath & "\Obsidian\Obsidian.exe"
paths(2) = ProgramFiles86Path & "\Obsidian\Obsidian.exe"
paths(3) = ProgramW6432Dir & "\Obsidian\Obsidian.exe"

found = False
For i = 0 To 3
    If fso.FileExists(paths(i)) Then
        ws.Run Chr(34) & paths(i) & Chr(34)
        found = True
        Exit For
    End If
Next

If Not found Then
    ws.Run "obsidian.exe"
End If