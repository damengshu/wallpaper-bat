# media_play_pause (Win11)

一个 Windows 11 小脚本：通过调用 `user32.dll` 的 `keybd_event` 发送媒体键。

## 用法

- 双击运行：发送播放/暂停（Play/Pause）
- 完全不弹出 CMD/控制台窗口：双击运行 [media_play_pause_hidden.vbs](media_play_pause_hidden.vbs)
- 或在命令行运行：

```bat
media_play_pause.bat
media_play_pause.bat Next
media_play_pause.bat Prev
media_play_pause.bat 0xB3
```

VBS 方式也支持传参：

```bat
media_play_pause_hidden.vbs
media_play_pause_hidden.vbs Next
```

支持的 Key：`PlayPause` / `Next` / `Prev` / `Stop` / `VolUp` / `VolDown` / `Mute`，也可直接传 VK（十六进制 `0x..` 或十进制）。

## 说明

- [media_play_pause.bat](media_play_pause.bat) 会以最小化方式启动并隐藏 PowerShell 窗口。
- [media_play_pause_hidden.vbs](media_play_pause_hidden.vbs) 通过 `wscript.exe` 启动 PowerShell，不会弹出 CMD/控制台窗口（更适合双击/快捷方式）。
- [send_media_key.ps1](send_media_key.ps1) 负责实际发送按键。

## PowerShell 执行策略

脚本通过 `-ExecutionPolicy Bypass` 调用，通常无需改系统策略。
如果你手动运行 `.ps1` 被拦截，可用：

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```
