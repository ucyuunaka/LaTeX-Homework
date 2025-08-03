@echo off
set current_dir=%cd%

set filename=%1
if "%filename%"=="" set filename=main

set filename=%filename:.tex=%

if not exist build mkdir build

echo [Build] 开始编译 %filename%.tex ...
latexmk -pdf -xelatex -shell-escape -outdir=build -auxdir=build -interaction=nonstopmode -synctex=1 %filename%.tex

if %errorlevel% neq 0 (
    echo [Build] 编译失败，错误代码: %errorlevel%
    exit /b %errorlevel%
)

if exist build\%filename%.pdf (
    copy build\%filename%.pdf %filename%.pdf >nul
    if %errorlevel% equ 0 (
        echo [Build] 编译成功，PDF 已生成: %filename%.pdf
    ) else (
        echo [Build] PDF 复制失败
        exit /b 1
    )
) else (
    echo [Build] 编译失败，未找到 PDF 文件
    exit /b 1
)

REM 不使用 pause，避免 TexStudio 中断编译流程