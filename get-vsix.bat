@echo off

REM https://www.reddit.com/r/vscode/comments/1i6k7gf/cant_download_vsix_extensions_from_the_web/

REM <Examples>
REM  get-vsix MS-CEINTL.vscode-language-pack-ja
REM  get-vsix MS-CEINTL.vscode-language-pack-ja latest
REM  get-vsix MS-CEINTL.vscode-language-pack-ja 1.99.2025032609
REM  get-vsix MS-CEINTL.vscode-language-pack-ja 1.98.2025031209

REM コマンド名の取得
set command_name=%~n0

goto main_processing

REM エラー処理
:usage_exit
echo Usage: %command_name% unique-identifier [version]
exit /b 2

:main_processing

REM 引数チェック
if "%~1"=="" (
    goto usage_exit
)
if not "%~3"=="" (
    goto usage_exit
)
if "%~2"=="" (
    set version=latest
) else (
    set version=%~2
)

REM unique-identifierを分割
for /f "tokens=1,2 delims=." %%a in ("%~1") do (
    set part1=%%a
    set part2=%%b
)

REM 分割に失敗した場合は終了
if "%part2%"=="" (
    goto usage_exit
)

REM curlコマンドの実行
curl -L --ssl-no-revoke "https://%part1%.gallery.vsassets.io/_apis/public/gallery/publisher/%part1%/extension/%part2%/%version%/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage" -o "%part1%.%part2%-%version%.vsix"
