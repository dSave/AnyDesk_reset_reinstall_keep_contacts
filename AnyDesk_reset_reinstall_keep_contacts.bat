@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

echo ------------------------------------------
echo Технический блог dSave.ru
echo https://dSave.ru
echo ------------------------------------------

>nul 2>&1 net session
if %errorlevel% neq 0 (
    echo [Ошибка] Требуются права администратора. Перезапустите файл от имени администратора.
    pause
    exit /b
)

echo Инициализация переменных...
set "backupDir=%USERPROFILE%\Downloads\anydesk_backup"
set "userConf=%APPDATA%\AnyDesk\user.conf"
set "backupConf=%backupDir%\user.conf"

set "anydeskExe="
for /f "delims=" %%f in ('dir /b /a:-d /o:-d "%USERPROFILE%\Downloads\AnyDesk*.exe" 2^>nul') do (
    set "anydeskExe=%USERPROFILE%\Downloads\%%f"
    call :foundExe
    goto :eof
)
echo [Ошибка] Не найден файл AnyDesk.exe в Загрузках.
echo Пожалуйста, скачайте установочный файл AnyDesk с официального сайта:
echo https://anydesk.com/ru/download

echo Сохраните файл в папку "Загрузки" (Downloads). Это должен быть .exe-файл установки программы AnyDesk — он необходим для автоматической переустановки после удаления старой версии.
echo.
echo Без установочного файла невозможно автоматически переустановить AnyDesk и восстановить настройки.
echo Вы можете продолжить выполнение, если вы просто хотите полностью удалить AnyDesk с компьютера.
echo В этом случае установка и восстановление настроек выполняться не будут.
echo.
choice /M "Продолжить выполнение без установочного файла AnyDesk?"
if errorlevel 2 exit /b

:foundExe

echo Этот скрипт может сохранить файл user.conf, содержащий настройки AnyDesk и список сохранённых подключений.
echo Это позволит восстановить вашу конфигурацию после переустановки AnyDesk.
echo.
choice /M "Сохранить файл user.conf перед удалением программы?"
if errorlevel 2 goto skipBackup

echo [1/7] Сохранение user.conf в %backupDir%
mkdir "%backupDir%" >nul 2>&1
if exist "%userConf%" (
    copy /Y "%userConf%" "%backupConf%" >nul
    echo [OK] user.conf сохранён.
) else (
    echo [!] Файл user.conf не найден. Этот файл содержит настройки AnyDesk и список сохранённых подключений.
    echo При отсутствии этого файла восстановление настроек будет невозможно.
    choice /M "Продолжить выполнение без сохранения файла?"
    if errorlevel 2 exit /b
)

:skipBackup

echo [2/7] Завершение процессов AnyDesk (если они запущены)...
call :stopAnyDesk

echo [3/7] Удаление следов AnyDesk...
if exist "C:\ProgramData\AnyDesk" rmdir /S /Q "C:\ProgramData\AnyDesk" >nul 2>&1
if exist "%APPDATA%\AnyDesk" rmdir /S /Q "%APPDATA%\AnyDesk" >nul 2>&1
if exist "%LOCALAPPDATA%\AnyDesk" rmdir /S /Q "%LOCALAPPDATA%\AnyDesk" >nul 2>&1
if exist "%ProgramFiles(x86)%\AnyDesk" rmdir /S /Q "%ProgramFiles(x86)%\AnyDesk" >nul 2>&1
echo [OK] Следы AnyDesk удалены.

echo [4/7] Запуск установки AnyDesk: %anydeskExe%
start "" "%anydeskExe%"
echo Пожалуйста, установите AnyDesk. После завершения установки нажмите любую клавишу для продолжения...
pause >nul

echo [5/7] Завершение AnyDesk перед восстановлением user.conf...
call :stopAnyDesk

echo [6/7] Восстановление user.conf...
mkdir "%APPDATA%\AnyDesk" >nul 2>&1
if exist "%backupConf%" (
    copy /Y "%backupConf%" "%userConf%" >nul
    echo [OK] user.conf восстановлен.
) else (
    echo [!] Файл резервной копии не найден. Восстановление невозможно.
)

echo [7/7] Финальный запуск AnyDesk...
start "" "%anydeskExe%"

if exist "%backupDir%" rmdir /S /Q "%backupDir%" >nul 2>&1

echo.
echo [Готово] Все действия завершены. AnyDesk установлен и готов к работе.
powershell -c "[console]::beep()"
pause
exit /b

:stopAnyDesk
echo Завершение процессов и службы AnyDesk...
for /f "tokens=2 delims=," %%i in ('tasklist /fi "imagename eq AnyDesk.exe" /fo csv /nh') do taskkill /PID %%i /T /F >nul 2>&1
taskkill /f /im AnyDesk_Service.exe >nul 2>&1
taskkill /f /im AnyDesk*.exe >nul 2>&1
sc stop AnyDesk >nul 2>&1
powershell -Command "Try { Stop-Service -Name 'AnyDesk' -Force -ErrorAction Stop } Catch { }"
exit /b
