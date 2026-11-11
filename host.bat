@echo off
setlocal
pushd "%~dp0" || goto directory_error

set "HOST_NODE=node.exe"
where /q node.exe || set "HOST_NODE=%USERPROFILE%\.cache\codex-runtimes\codex-primary-runtime\dependencies\node\bin\node.exe"
if not "%HOST_NODE%"=="node.exe" if not exist "%HOST_NODE%" goto node_missing

if not exist "node_modules\vinext\dist\cli.js" (
  echo Dependencies are missing. Run pnpm install in this folder, then run host.bat again.
  goto setup_error
)

echo Starting Snow Cheats. Open http://127.0.0.1:5173/ when the server is ready.
"%HOST_NODE%" scripts\host.mjs %*
set "HOST_EXIT=%ERRORLEVEL%"
popd
if not "%HOST_EXIT%"=="0" (
  echo The server exited with code %HOST_EXIT%. See the error above.
  pause
)
exit /b %HOST_EXIT%

:node_missing
echo Node.js was not found. Install Node.js 22.13 or newer and run host.bat again.
:setup_error
popd
pause
exit /b 1

:directory_error
echo Could not open the website folder.
pause
exit /b 1
