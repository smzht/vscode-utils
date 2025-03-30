@echo off

REM 本バッチファイルは、shellスクリプト get-vsix を Microsoft Copilot に変換してもらったものを
REM ベースに作成しました
REM 最後に実行していた wget は、Windows に標準インストールされている curl に置き換えています

REM https://www.reddit.com/r/vscode/comments/1i6k7gf/cant_download_vsix_extensions_from_the_web/

REM <Examples>
REM  get-vsix MS-CEINTL.vscode-language-pack-ja
REM  get-vsix MS-CEINTL.vscode-language-pack-ja latest
REM  get-vsix MS-CEINTL.vscode-language-pack-ja 1.99.2025032609
REM  get-vsix MS-CEINTL.vscode-language-pack-ja 1.98.2025031209

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
        goto :usage_exit
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
    goto :usage_exit
)

REM wgetコマンドの実行
set "url=https://%part1%.gallery.vsassets.io/_apis/public/gallery/publisher/%part1%/extension/%part2%/%version%/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage"
REM wget -O "%part1%.%part2%-%version%.vsix" "%url%"
curl -L --ssl-no-revoke "%url%" -o "%part1%.%part2%-%version%.vsix"
