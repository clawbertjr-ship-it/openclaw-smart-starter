@echo off
setlocal

echo.
echo  ============================================
echo   OpenClaw Smart Agent Starter - Setup
echo  ============================================
echo.

:: Find the openclaw workspace
set "OC_DIR=%USERPROFILE%\.openclaw"
set "WS_DIR=%OC_DIR%\workspace"

if not exist "%OC_DIR%" (
    echo  [!] OpenClaw not found at %OC_DIR%
    echo      Install OpenClaw first: npm install -g openclaw ^&^& openclaw configure
    echo.
    pause
    exit /b 1
)

if not exist "%WS_DIR%" (
    echo  [+] Creating workspace directory...
    mkdir "%WS_DIR%"
)

:: Get the directory this script lives in
set "KIT_DIR=%~dp0"

echo  [1/4] Copying workspace files...
for %%f in (AGENTS.md SOUL.md USER.md IDENTITY.md TOOLS.md HEARTBEAT.md MEMORY.md start.md) do (
    if not exist "%WS_DIR%\%%f" (
        copy "%KIT_DIR%workspace\%%f" "%WS_DIR%\%%f" >nul 2>&1
        echo        + %%f
    ) else (
        echo        ~ %%f (already exists, skipping)
    )
)

:: Create memory directory
if not exist "%WS_DIR%\memory" (
    mkdir "%WS_DIR%\memory"
    echo        + memory\ (created)
) else (
    echo        ~ memory\ (already exists)
)

echo.
echo  [2/4] Installing bundled skills (17 skills)...
if not exist "%WS_DIR%\skills" mkdir "%WS_DIR%\skills"

set "SKILL_COUNT=0"
for /d %%s in ("%KIT_DIR%skills\*") do (
    set "SKILL_NAME=%%~ns"
    if not exist "%WS_DIR%\skills\%%~ns" (
        xcopy "%%s" "%WS_DIR%\skills\%%~ns\" /E /I /Q >nul 2>&1
        echo        + %%~ns
        set /a SKILL_COUNT+=1
    ) else (
        echo        ~ %%~ns (already exists, skipping)
    )
)
echo        Done.

echo.
echo  [3/4] Copying docs...
if not exist "%WS_DIR%\docs" mkdir "%WS_DIR%\docs"
if exist "%KIT_DIR%docs\smart-agent-guide.html" (
    copy "%KIT_DIR%docs\smart-agent-guide.html" "%WS_DIR%\docs\smart-agent-guide.html" >nul 2>&1
    echo        + docs\smart-agent-guide.html
)
if exist "%KIT_DIR%docs\example-config.json5" (
    copy "%KIT_DIR%docs\example-config.json5" "%WS_DIR%\docs\smart-starter-config.json5" >nul 2>&1
    echo        + docs\smart-starter-config.json5
)

echo.
echo  [4/4] Quick config check...
if exist "%OC_DIR%\openclaw.json" (
    echo        Config found at %OC_DIR%\openclaw.json
    findstr /C:"memoryFlush" "%OC_DIR%\openclaw.json" >nul 2>&1
    if errorlevel 1 (
        echo.
        echo  [!!] IMPORTANT: memoryFlush not found in your config!
        echo       Your agent WILL forget things without it.
        echo       See docs\smart-starter-config.json5 for what to add.
    ) else (
        echo        memoryFlush: found (good!)
    )
) else (
    echo        [!] No config found. Run: openclaw configure
)

echo.
echo  ============================================
echo   Setup complete!
echo  ============================================
echo.
echo  Next steps:
echo    1. Edit these files with YOUR info:
echo       %WS_DIR%\USER.md     (your name, timezone)
echo       %WS_DIR%\SOUL.md     (agent personality)
echo       %WS_DIR%\IDENTITY.md (agent name)
echo.
echo    2. Check your config (critical!):
echo       Open: %OC_DIR%\openclaw.json
echo       Add memoryFlush + postCompactionSections
echo       See: %WS_DIR%\docs\smart-starter-config.json5
echo.
echo    3. Restart gateway:
echo       openclaw gateway restart
echo.
echo    4. Open the full guide:
echo       %WS_DIR%\docs\smart-agent-guide.html
echo.
pause
