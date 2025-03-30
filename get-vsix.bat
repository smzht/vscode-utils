@echo off

REM コマンド名の取得
set "command_name=%~n0"

goto main_processing

REM 使用方法を表示する関数
:usage_exit
echo Usage: %command_name% unique-identifier [version]
exit /b 2

:main_processing

REM 引数の数をチェック
if "%~2"=="" (
    if "%~1"=="" (
        goto usage_exit
    ) else (
        set "version=latest"
    )
) else (
    set "version=%~2"
)

REM unique-identifierを分割
for /f "tokens=1,2 delims=." %%a in ("%~1") do (
    set "part1=%%a"
    set "part2=%%b"
)

REM 分割に失敗した場合は終了
if "%part2%"=="" (
    goto usage_exit
)

REM curlコマンドの実行
set "url=https://%part1%.gallery.vsassets.io/_apis/public/gallery/publisher/%part1%/extension/%part2%/%version%/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage"
curl -L --ssl-no-revoke "%url%" -o "%part1%.%part2%-%version%.vsix"
