@echo off
setlocal enabledelayedexpansion

set "filename=%~1"
if "%filename%"=="" set "filename=main"

set "filename=%filename:.tex=%"

if not exist build mkdir build

echo [Build] ��ʼ���� %filename%.tex ...
latexmk -pdf -xelatex -shell-escape -outdir=build -auxdir=build -interaction=nonstopmode -synctex=1 "%filename%.tex"

if errorlevel 1 (
    echo [Build] ����ʧ�ܣ������룺%errorlevel%
    pause
    exit /b %errorlevel%
)

if exist "build\%filename%.pdf" (
    copy "build\%filename%.pdf" "%filename%.pdf" >nul
    if errorlevel 1 (
        echo [Build] PDF ����ʧ��
        pause
        exit /b 1
    ) else (
        echo [Build] �����ɹ���PDF �ļ���Ϊ��%filename%.pdf
        pause
    )
) else (
    echo [Build] ����ʧ�ܣ�δ�ҵ� PDF �ļ�
    pause
    exit /b 1
)