Option Explicit

Dim fso, scriptDir, ps1, key, cmd
Set fso = CreateObject("Scripting.FileSystemObject")
scriptDir = fso.GetParentFolderName(WScript.ScriptFullName)
ps1 = scriptDir & "\\send_media_key.ps1"

key = "PlayPause"
If WScript.Arguments.Count >= 1 Then
  key = WScript.Arguments(0)
End If

cmd = "powershell -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File """ & ps1 & """ -Key """ & key & """"

CreateObject("WScript.Shell").Run cmd, 0, False
