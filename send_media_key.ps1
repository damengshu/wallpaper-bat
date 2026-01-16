[CmdletBinding()]
param(
    # 支持：PlayPause / Next / Prev / Stop / VolUp / VolDown / Mute
    # 也支持直接传 VK：十六进制(0xB3) 或十进制(179)
    [Parameter(Position = 0)]
    [string]$Key = 'PlayPause'
)

$ErrorActionPreference = 'Stop'

function Resolve-VirtualKey {
    param([Parameter(Mandatory)][string]$Key)

    $normalized = $Key.Trim()

    # 允许直接传数字
    if ($normalized -match '^0x[0-9a-fA-F]+$') {
        return [Convert]::ToInt32($normalized, 16)
    }
    if ($normalized -match '^\d+$') {
        return [int]$normalized
    }

    switch -Regex ($normalized) {
        '^(PlayPause|Play|Pause)$' { return 0xB3 }
        '^(Next|NextTrack)$'       { return 0xB0 }
        '^(Prev|Previous|PrevTrack)$' { return 0xB1 }
        '^(Stop)$'                { return 0xB2 }
        '^(VolUp|VolumeUp)$'      { return 0xAF }
        '^(VolDown|VolumeDown)$'  { return 0xAE }
        '^(Mute|VolumeMute)$'     { return 0xAD }
        default {
            throw "不支持的 Key: '$Key'。可用：PlayPause/Next/Prev/Stop/VolUp/VolDown/Mute，或直接传 VK (例如 0xB3)"
        }
    }
}

try {
    Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices;

public static class MediaKeys {
    [DllImport("user32.dll", SetLastError=true)]
    public static extern void keybd_event(byte bVk, byte bScan, uint dwFlags, UIntPtr dwExtraInfo);
}
'@ -ErrorAction Stop

    $vk = Resolve-VirtualKey -Key $Key

    # keybd_event: dwFlags 0=down, 2=up
    [MediaKeys]::keybd_event([byte]$vk, 0, 0, [UIntPtr]::Zero)
    Start-Sleep -Milliseconds 50
    [MediaKeys]::keybd_event([byte]$vk, 0, 2, [UIntPtr]::Zero)
}
catch {
    Write-Error $_
    exit 1
}
