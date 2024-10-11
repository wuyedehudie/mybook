@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

rem 获取脚本运行目录
set "base_dir=%~dp0"
set "summary_file=%base_dir%SUMMARY.md"

rem 创建或清空 SUMMARY.md
echo # Summary > "%summary_file%"

rem 遍历所有子目录和 Markdown 文件
call :addToSummary "%base_dir%"

echo SUMMARY.md 更新完成！
exit /b

:addToSummary
set "current_dir=%~1"

rem 遍历当前目录中的所有子目录
for /d %%d in ("%current_dir%\*") do (
    echo ## %%~nxd >> "%summary_file%"
    rem 遍历子目录中的所有 Markdown 文件
    for %%f in ("%%d\*.md") do (
        echo - [%%~nxf](%%~pnxf) >> "%summary_file%"
    )
    rem 递归调用处理子目录
    call :addToSummary "%%d"
)

rem 处理当前目录的 Markdown 文件
for %%f in ("%current_dir%\*.md") do (
    echo - [%%~nxf](%%~pnxf) >> "%summary_file%"
)

rem 确保每个链接末尾都有右括号
(for /f "usebackq delims=" %%l in ("%summary_file%") do (
    echo %%l)
) > "%summary_file%.tmp"

move /y "%summary_file%.tmp" "%summary_file%" > nul

exit /b
