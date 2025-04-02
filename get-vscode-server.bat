@echo off

rem https://www.mathkuro.com/vs-code/remote-development-in-offline/

rem <Example>
rem get-vscode-server ddc367ed5c8936efe395cffeec279b04ffd7db78

set command_name=%~n0

goto main_processing

:usage_exit
echo Usage: %command_name% commit-id
exit /b 2

:main_processing

if "%~1"=="" (
    goto usage_exit
)

curl -L --ssl-no-revoke "https://update.code.visualstudio.com/commit:%~1/server-linux-x64/stable" -o vscode-server-linux-x64.tar.gz 

rem cp vscode-server-linux-x64.tar.gz ~/.vscode-server/bin
rem cd ~/.vscode-server/bin
rem tar zxvf vscode-server-linux-x64.tar.gz
rem mv vscode-server-linux-x64 <commit-id>
rem rm vscode-server-linux-x64.tar.gz
