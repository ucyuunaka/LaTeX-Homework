@echo off
setlocal enabledelayedexpansion

set "filename=%~1"
if "%filename%"=="" set "filename=main"

set "filename=%filename:.tex=%"

if not exist build mkdir build

echo [Build] 开始构建 %filename%.tex ...
latexmk -pdf -xelatex -shell-escape -outdir=build -auxdir=build -interaction=nonstopmode -synctex=1 "%filename%.tex"

if errorlevel 1 (
    echo [Build] 构建失败，错误码：%errorlevel%
    exit /b %errorlevel%
)

if exist "build\%filename%.pdf" (
    copy "build\%filename%.pdf" "%filename%.pdf" >nul
    if errorlevel 1 (
        echo [Build] PDF 复制失败
        exit /b 1
    ) else (
        echo [Build] 构建成功，PDF 文件名为：%filename%.pdf
    )
) else (
    echo [Build] 构建失败，未找到 PDF 文件
    exit /b 1
)