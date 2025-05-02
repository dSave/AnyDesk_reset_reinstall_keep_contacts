:: -----------------------------------------------------
:: AnyDesk Reset & Reinstall Tool
:: Version: 1.1
:: Date: 2025-05-02
:: Author: dSave.ru
:: -----------------------------------------------------

@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

:: -------------------------------------------------
:: Language‑selection block
:: -------------------------------------------------

cls

:: --- Banner ---------------------------------------------------------------
echo  ----------------------------------------- 
echo   AnyDesk Reset ^& Reinstall Utility
echo  -----------------------------------------
echo.

:: --- Ask user for language -------------------------------------------------
choice /C 12 /N /M "Select language / Выберите язык (1-English 2-Русский):"

:: --- Map CHOICE result to LANG variable ------------------------------------
if errorlevel 1 set "LANG=EN"
if errorlevel 2 set "LANG=RU"
echo.

:: --- Text resources --------------------------------------------------------
:: Message variables in English (in display order)
set "MSG_WELCOME1=Welcome to the AnyDesk Repair ^& Reinstall Tool"
set "MSG_WELCOME2=This assistant will help you safely reset, reinstall, and restore AnyDesk settings."
set "MSG_ADMIN_ERR=[Error] Administrator privileges required. Please re-run this file as Administrator."
set "MSG_INIT=Initializing environment..."
set "MSG_NO_EXE=[Error] AnyDesk.exe not found in Downloads folder."
set "MSG_DL_PROMPT=Please download the AnyDesk installer from the official website:"
set "MSG_DL_LINK=https://anydesk.com/en/downloads"
set "MSG_DL_INSTR=Save the file to your Downloads folder. It must be the .exe installer required for automatic reinstallation."
set "MSG_DL_FAIL=Without the installer file, the script cannot automatically reinstall AnyDesk and restore your settings."
set "MSG_CONTINUE=You may proceed if your goal is to completely uninstall AnyDesk from this computer."
set "MSG_SKIP_REINSTALL=In this case, reinstallation and configuration recovery will be skipped."
set "MSG_CHOICE_CONTINUE=Proceed without the AnyDesk installer file?"
set "MSG_CONF_SAVE=This script can back up your user.conf file, which stores AnyDesk settings and saved connections."
set "MSG_CONF_RESTORE=This will allow you to restore your configuration after reinstalling AnyDesk."
set "MSG_CHOICE_SAVE_CONF=Back up user.conf before uninstalling AnyDesk?"
set "MSG_STEP1=[1/7] Saving user.conf to"
set "MSG_STEP1_OK=[OK] user.conf successfully saved."
set "MSG_NO_USERCONF=[!] user.conf not found. This file contains AnyDesk settings and saved connections."
set "MSG_NO_RESTORE=Without this file, settings restoration will not be possible."
set "MSG_CHOICE_NO_SAVE=Proceed without saving the configuration file?"
set "MSG_STEP2=[2/7] Terminating AnyDesk processes (if running)..."
set "MSG_STEP3=[3/7] Removing AnyDesk traces..."
set "MSG_STEP3_OK=[OK] AnyDesk traces removed."
set "MSG_STEP4=[4/7] Launching AnyDesk installer:"
set "MSG_STEP4_INSTR=Please install AnyDesk now. Press any key to continue once installation is complete..."
set "MSG_STEP5=[5/7] Closing AnyDesk before restoring user.conf..."
set "MSG_STEP6=[6/7] Restoring user.conf..."
set "MSG_STEP6_OK=[OK] user.conf restored successfully."
set "MSG_NO_BAK=[!] Backup file not found. Restoration is not possible."
set "MSG_STEP7=[7/7] Final launch of AnyDesk..."
set "MSG_FINISH=[Done] All actions completed. AnyDesk is ready to use."
set "MSG_CLEANUP=Stopping AnyDesk processes and services..."

:: Message variables in Russian (in display order)
if "%LANG%"=="RU" (
set "MSG_WELCOME1=Технический блог dSave.ru"
set "MSG_WELCOME2=https://dSave.ru"
set "MSG_ADMIN_ERR=[Ошибка] Требуются права администратора. Перезапустите файл от имени администратора."
set "MSG_INIT=Инициализация переменных..."
set "MSG_NO_EXE=[Ошибка] Не найден файл AnyDesk.exe в Загрузках."
set "MSG_DL_PROMPT=Пожалуйста, скачайте установочный файл AnyDesk с официального сайта:"
set "MSG_DL_LINK=https://anydesk.com/ru/downloads"
set "MSG_DL_INSTR=Сохраните файл в папку \"Загрузки\" (Downloads). Это должен быть .exe-файл установки программы AnyDesk — он необходим для автоматической переустановки после удаления старой версии."
set "MSG_DL_FAIL=Без установочного файла невозможно автоматически переустановить AnyDesk и восстановить настройки."
set "MSG_CONTINUE=Вы можете продолжить выполнение, если вы просто хотите полностью удалить AnyDesk с компьютера."
set "MSG_SKIP_REINSTALL=В этом случае установка и восстановление настроек выполняться не будут."
set "MSG_CHOICE_CONTINUE=Продолжить выполнение без установочного файла AnyDesk?"
set "MSG_CONF_SAVE=Этот скрипт может сохранить файл user.conf, содержащий настройки AnyDesk и список сохранённых подключений."
set "MSG_CONF_RESTORE=Это позволит восстановить вашу конфигурацию после переустановки AnyDesk."
set "MSG_CHOICE_SAVE_CONF=Сохранить файл user.conf перед удалением программы?"
set "MSG_STEP1=[1/7] Сохранение user.conf в "
set "MSG_STEP1_OK=[OK] user.conf сохранён."
set "MSG_NO_USERCONF=[!] Файл user.conf не найден. Этот файл содержит настройки AnyDesk и список сохранённых подключений."
set "MSG_NO_RESTORE=При отсутствии этого файла восстановление настроек будет невозможно."
set "MSG_CHOICE_NO_SAVE=Продолжить выполнение без сохранения файла?"
set "MSG_STEP2=[2/7] Завершение процессов AnyDesk (если они запущены)..."
set "MSG_STEP3=[3/7] Удаление следов AnyDesk..."
set "MSG_STEP3_OK=[OK] Следы AnyDesk удалены."
set "MSG_STEP4=[4/7] Запуск установки AnyDesk: "
set "MSG_STEP4_INSTR=Пожалуйста, установите AnyDesk. После завершения установки нажмите любую клавишу для продолжения..."
set "MSG_STEP5=[5/7] Завершение AnyDesk перед восстановлением user.conf..."
set "MSG_STEP6=[6/7] Восстановление user.conf..."
set "MSG_STEP6_OK=[OK] user.conf восстановлен."
set "MSG_NO_BAK=[!] Файл резервной копии не найден. Восстановление невозможно."
set "MSG_STEP7=[7/7] Финальный запуск AnyDesk..."
set "MSG_FINISH=[Готово] Все действия завершены. AnyDesk установлен и готов к работе."
set "MSG_CLEANUP=Завершение процессов и службы AnyDesk..."
)

:: -------------------------------------------------
:: End of Language‑selection block
:: -------------------------------------------------

echo ------------------------------------------
echo %MSG_WELCOME1%
echo %MSG_WELCOME2%
echo ------------------------------------------

>nul 2>&1 net session
if %errorlevel% neq 0 (
    echo %MSG_ADMIN_ERR%
    pause
    exit /b
)

echo %MSG_INIT%
set "backupDir=%USERPROFILE%\Downloads\anydesk_backup"
set "userConf=%APPDATA%\AnyDesk\user.conf"
set "backupConf=%backupDir%\user.conf"

set "anydeskExe="
for /f "delims=" %%f in ('dir /b /a:-d /o:-d "%USERPROFILE%\Downloads\AnyDesk*.exe" 2^>nul') do (
    set "anydeskExe=%USERPROFILE%\Downloads\%%f"
    call :foundExe
    goto :eof
)
echo %MSG_NO_EXE%
echo %MSG_DL_PROMPT%
echo %MSG_DL_LINK% 
echo %MSG_DL_INSTR% 
echo.
echo %MSG_DL_FAIL%
echo %MSG_CONTINUE%
echo %MSG_SKIP_REINSTALL%
echo.
choice /M "%MSG_CHOICE_CONTINUE%"
if errorlevel 2 exit /b

:foundExe

echo %MSG_CONF_SAVE%
echo %MSG_CONF_RESTORE%
echo.
choice /M "%MSG_CHOICE_SAVE_CONF%"
if errorlevel 2 goto skipBackup

echo %MSG_STEP1% %backupDir%
mkdir "%backupDir%" >nul 2>&1
if exist "%userConf%" (
    copy /Y "%userConf%" "%backupConf%" >nul
    echo %MSG_STEP1_OK%
) else (
    echo %MSG_NO_USERCONF%
    echo %MSG_NO_RESTORE%
    choice /M "%MSG_CHOICE_NO_SAVE%"
    if errorlevel 2 exit /b
)

:skipBackup

echo %MSG_STEP2%
call :stopAnyDesk

echo %MSG_STEP3%
if exist "C:\ProgramData\AnyDesk" rmdir /S /Q "C:\ProgramData\AnyDesk" >nul 2>&1
if exist "%APPDATA%\AnyDesk" rmdir /S /Q "%APPDATA%\AnyDesk" >nul 2>&1
if exist "%LOCALAPPDATA%\AnyDesk" rmdir /S /Q "%LOCALAPPDATA%\AnyDesk" >nul 2>&1
if exist "%ProgramFiles(x86)%\AnyDesk" rmdir /S /Q "%ProgramFiles(x86)%\AnyDesk" >nul 2>&1
echo %MSG_STEP3_OK%

echo %MSG_STEP4% "%anydeskExe%"
start "" "%anydeskExe%"
echo %MSG_STEP4_INSTR%
pause >nul

echo %MSG_STEP5%
call :stopAnyDesk

echo %MSG_STEP6%
mkdir "%APPDATA%\AnyDesk" >nul 2>&1
if exist "%backupConf%" (
    copy /Y "%backupConf%" "%userConf%" >nul
    echo %MSG_STEP6_OK%
) else (
    echo %MSG_NO_BAK%
)

echo %MSG_STEP7%
start "" "%anydeskExe%"

if exist "%backupDir%" rmdir /S /Q "%backupDir%" >nul 2>&1

echo.
echo %MSG_FINISH%
powershell -c "[console]::beep()"
pause
exit /b

:stopAnyDesk
echo %MSG_CLEANUP%
for /f "tokens=2 delims=," %%i in ('tasklist /fi "imagename eq AnyDesk.exe" /fo csv /nh') do taskkill /PID %%i /T /F >nul 2>&1
taskkill /f /im AnyDesk_Service.exe >nul 2>&1
taskkill /f /im AnyDesk*.exe >nul 2>&1
sc stop AnyDesk >nul 2>&1
powershell -Command "Try { Stop-Service -Name 'AnyDesk' -Force -ErrorAction Stop } Catch { }"
exit /b
