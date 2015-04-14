@echo off
md input
md output
chcp 1251 > nul

REM Russian Translate
set program=WWISE Авто-Конвертер от ProDEAGLE
set message=WWISE Авто-Конвертер 1.4
set decode=Декодировать
set clear=Очистить папки
set exit=Выйти
set bnk=[Запущен] Распаковка bnk...
set wem=[Запущен] Конвертирование wem...
set temp=[Запущен] Удаление временных файлов...
set move=[Запущен] Перемещение...
set clean=[Запущен] Очистка...

REM English Translate
REM set program=WWISE Auto-Converter by ProDEAGLE
REM set message=WWISE Auto-Converter 1.4
REM set decode=Decode
REM set clear=Clear Folders
REM set exit=Exit
REM set title_pck=[Running] Unpacking pck...
REM set bnk=[Running] Unpacking bnk...
REM set wem=[Running] Converting wem...
REM set move=[Running] Moving...
REM set temp=[Running] Deleting Temporary Files...
REM set clean=[Running] Cleaning...

chcp 866 > nul
:main
title %program%
cls
echo    ========================
echo    %message%
echo    ========================
echo.
echo    1 - %decode%
echo    2 - %clear%
echo.
echo    3 - %exit%
echo.
set mymenu=x
set /p mymenu=" > "
cls
if /i %mymenu%==1 goto decode
if /i %mymenu%==2 goto clear
if /i %mymenu%==3 exit
goto main
:decode
cd input
move /y *.pck ../bin
move /y *.bnk ../bin
move /y *.wem ../bin
cd ../bin
for %%f in (*.pck) do quickbms pck.bms %%f
) else (
title %temp%
del /q *.pck
title %bnk%
)
for %%f in (*.bnk) do bnkextr %%f
) else (
title %temp%
del /q *.bnk
ren *.wav *.wem
title %wem%
for %%f in (*.wem) do ww2ogg %%f --pcb packed_codebooks_aoTuV_603.bin
for %%f in (*.ogg) do revorb %%f
title %temp%
del /q *.wem
title %move%
move /y *.ogg ../output
exit
)
:clear
title %clean%
cd bin
del /q *.pck
del /q *.bnk
del /q *.wem
del /q *.ogg
del /q *.wav
cd ../input
del /q *
cd ../output
del /q *
goto main