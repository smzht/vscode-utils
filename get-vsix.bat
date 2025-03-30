@echo off

REM �{�o�b�`�t�@�C���́Ashell�X�N���v�g get-vsix �� Microsoft Copilot �ɕϊ����Ă���������̂�
REM �x�[�X�ɍ쐬���܂���
REM �Ō�Ɏ��s���Ă��� wget �́AWindows �ɕW���C���X�g�[������Ă��� curl �ɒu�������Ă��܂�

REM https://www.reddit.com/r/vscode/comments/1i6k7gf/cant_download_vsix_extensions_from_the_web/

REM <Examples>
REM  get-vsix MS-CEINTL.vscode-language-pack-ja
REM  get-vsix MS-CEINTL.vscode-language-pack-ja latest
REM  get-vsix MS-CEINTL.vscode-language-pack-ja 1.99.2025032609
REM  get-vsix MS-CEINTL.vscode-language-pack-ja 1.98.2025031209

REM �R�}���h���̎擾
set "command_name=%~n0"

goto main_processing

REM �g�p���@��\������֐�
:usage_exit
echo Usage: %command_name% unique-identifier [version]
exit /b 2

:main_processing

REM �����̐����`�F�b�N
if "%~2"=="" (
    if "%~1"=="" (
        goto :usage_exit
    ) else (
        set "version=latest"
    )
) else (
    set "version=%~2"
)

REM unique-identifier�𕪊�
for /f "tokens=1,2 delims=." %%a in ("%~1") do (
    set "part1=%%a"
    set "part2=%%b"
)

REM �����Ɏ��s�����ꍇ�͏I��
if "%part2%"=="" (
    goto :usage_exit
)

REM wget�R�}���h�̎��s
set "url=https://%part1%.gallery.vsassets.io/_apis/public/gallery/publisher/%part1%/extension/%part2%/%version%/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage"
REM wget -O "%part1%.%part2%-%version%.vsix" "%url%"
curl -L --ssl-no-revoke "%url%" -o "%part1%.%part2%-%version%.vsix"
