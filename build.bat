@echo off
set current_dir=%cd%

set filename=%1
if "%filename%"=="" set filename=main

set filename=%filename:.tex=%

if not exist build mkdir build

echo [Build] ��ʼ���� %filename%.tex ...
latexmk -pdf -xelatex -shell-escape -outdir=build -auxdir=build -interaction=nonstopmode -synctex=1 %filename%.tex

if %errorlevel% neq 0 (
    echo [Build] ����ʧ�ܣ��������: %errorlevel%
    exit /b %errorlevel%
)

if exist build\%filename%.pdf (
    copy build\%filename%.pdf %filename%.pdf >nul
    if %errorlevel% equ 0 (
        echo [Build] ����ɹ���PDF ������: %filename%.pdf
    ) else (
        echo [Build] PDF ����ʧ��
        exit /b 1
    )
) else (
    echo [Build] ����ʧ�ܣ�δ�ҵ� PDF �ļ�
    exit /b 1
)