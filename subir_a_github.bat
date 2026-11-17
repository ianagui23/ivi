@echo off
chcp 65001 > nul
title Subir apto ERP a GitHub (vanis)
cls

echo ======================================================================
echo           APTO - ERP & POS COMERCIAL (ARTÍCULOS DE CUERO)
echo              SUBIR AUTOMÁTICO A GITHUB: ianagui23/vanis
echo ======================================================================
echo.

set REPO_URL=https://github.com/ianagui23/vanis.git

where git >nul 2>nul
if %errorlevel% neq 0 (
    echo [AVISO] No se detectó Git en el sistema.
    echo.
    echo Puedes subir los archivos directamente en tu navegador web:
    echo 1. Entra a: https://github.com/ianagui23/vanis/upload
    echo 2. Arrastra los archivos de esta carpeta.
    echo 3. Haz clic en "Commit changes".
    echo.
    pause
    exit /b
)

echo Preparando archivos locales...
cd /d "%~dp0"

if not exist ".git" (
    git init
)

git remote remove origin 2>nul
git remote add origin %REPO_URL%

echo Preparando commit...
git add .
git commit -m "feat: Sistema ERP y POS apto Articulos de Cuero v2.0 Cloud"
git branch -M main

echo.
echo Subiendo cambios a https://github.com/ianagui23/vanis (rama main)...
echo.
echo Si GitHub te solicita iniciar sesión, confirma en la ventana emergente.
echo.
git push -u origin main

echo.
if %errorlevel% equ 0 (
    echo ======================================================================
    echo  [EXITO] ¡Proyecto subido correctamente a https://github.com/ianagui23/vanis!
    echo ======================================================================
) else (
    echo ======================================================================
    echo  Si el comando no pudo autenticarse, puedes arrastrar los archivos
    echo  directamente desde tu navegador entrando a:
    echo  https://github.com/ianagui23/vanis/upload
    echo ======================================================================
)

echo.
pause
