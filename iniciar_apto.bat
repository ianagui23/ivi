@echo off
chcp 65001 > nul
title apto - ERP / POS Comercial de Artículos de Cuero
cls
echo ======================================================================
echo          apto - ERP & POS COMERCIAL (ARTÍCULOS DE CUERO)
echo         Seguridad Estricta y Facturación Electrónica SIAT
echo ======================================================================
echo.
echo Iniciando la aplicación web en su navegador predeterminado...
echo.

set APP_PATH=%~dp0index.html
start "" "%APP_PATH%"

echo [OK] La aplicación se ha abierto en su navegador.
echo.
echo ======================================================================
echo                     CREDENCIALES Y SEGURIDAD
echo ======================================================================
echo 1. Frase Clave Corporativa (requerida al cargar):
echo    APTO_BOLIVIA
echo.
echo 2. Cuenta de Administrador Principal (Inalterable):
echo    Correo:     ian@gmail.com
echo    Contraseña: ADM123
echo.
echo 3. Cuenta de Vendedor de Prueba (Secundaria):
echo    Correo:     carlos.mendoza@apto.bo
echo    Contraseña: VEN123
echo ======================================================================
echo.
echo Presione cualquier tecla para cerrar esta ventana...
pause > nul
