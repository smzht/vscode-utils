@echo off

REM https://www.mathkuro.com/vs-code/REMote-development-in-offline/

REM <Example>
REM get-vscode-server ddc367ed5c8936efe395cffeec279b04ffd7db78

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

REM vscode-server-linux-x64.tar.gz をサーバマシンに転送し、以下を実行する
REM cp vscode-server-linux-x64.tar.gz ~/.vscode-server/bin
REM cd ~/.vscode-server/bin
REM tar zxvf vscode-server-linux-x64.tar.gz
REM mv vscode-server-linux-x64 <commit-id>
REM rm vscode-server-linux-x64.tar.gz
