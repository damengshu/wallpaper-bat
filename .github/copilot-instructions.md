# Copilot instructions (wallpaper_bat)

## Current repo reality
- This workspace currently contains **no files** (no `README.md`, no scripts, no CI), so there are **no established conventions** to follow yet.
- Treat the project as **greenfield**: avoid inventing architecture or workflows that aren’t explicitly requested.

## How to proceed when asked to add code
1. First confirm the intended scope (e.g., set wallpaper once vs. scheduled rotation, single monitor vs. multi-monitor, source folder rules, logging needs).
2. Prefer **Windows-native** solutions unless the user asks otherwise:
   - Batch scripts (`.bat`) and/or PowerShell (`.ps1`).
   - Avoid requiring third-party runtimes (Python/Node) unless requested.
3. Keep changes minimal and self-contained:
   - Don’t add complex folder structures unless the user asks.
   - If adding multiple scripts, propose a simple layout and get confirmation before creating it.

## Script expectations (when you create them)
- Handle paths with spaces (always quote paths).
- Fail clearly: validate inputs (folder exists, image exists) and print actionable error messages.
- Prefer idempotent operations (re-running should not break state).
- Include `-h/--help` style usage output (or a `:help` label for `.bat`) when practical.

## Documentation
- If you add the first runnable script, also add a minimal `README.md` describing:
  - What the script does
  - Example commands
  - Any required Windows permissions / policy notes for PowerShell
