@echo off
::::: Language: :::::
:: en_US - English ::
:: ru_RU - Russian ::
:::::::::::::::::::::
set lang=ru_RU
:::::::::::::::::::::
call bin/languages/%lang%.cmd
chcp 866 > nul
if exist "bin/languages/*%lang%.cmd*" (
goto main
) else (
cls
color 4c
echo.
echo    {!} Language File Not Found!
ping -n 10 127.0.0.1 > nul
exit
)
md input
md output
cls
:main
title %program%
color 1f
echo    ========================
echo    %start_message%
echo    ========================
echo.
echo    1 - %decode%
echo    2 - %clear_folders%
echo.
echo    3 - %exit%
echo.
set mm=x
set /p mm=" > "
cls
if /i %mm%==1 goto decode
if /i %mm%==2 goto clear
if /i %mm%==3 exit
goto main
:decode
title %program%
color 1f
echo    ========================
echo    %start_message%
echo    ========================
echo.
echo    %choice_format%
echo.
echo    1 - OGG
echo    2 - WAV
echo    3 - MP3
echo.
echo    4 - %back%
echo    5 - %exit%
echo.
set fm=x
set /p fm=" > "
cls
if /i %fm%==1 goto ogg
if /i %fm%==2 goto wav
if /i %fm%==3 goto mp3
if /i %fm%==4 goto main
if /i %fm%==5 exit
goto decode
:ogg
cd input
move /y *.pck ../bin
move /y *.bnk ../bin
move /y *.wem ../bin
cd ../bin
for %%f in (*.pck) do quickbms pck.bms %%f
) else (
title %title_temp%
del /q *.pck
title %title_bnkdec%
)
for %%f in (*.bnk) do bnkextr %%f
) else (
title %title_temp%
del /q *.bnk
ren *.wav *.wem
title %title_wemdec%
for %%f in (*.wem) do ww2ogg %%f --pcb packed_codebooks_aoTuV_603.bin
for %%f in (*.ogg) do revorb %%f
title %title_temp%
del /q *.wem
title %title_move%
(
move /y *.ogg ../output
if errorlevel 1 goto fail
)
cls
color 2a
echo    %dec_success%
echo.
ping -n 2 127.0.0.1 > nul
goto main
)
:wav
cd input
move /y *.pck ../bin
move /y *.bnk ../bin
move /y *.wem ../bin
cd ../bin
for %%f in (*.pck) do quickbms pck.bms %%f
) else (
title %title_temp%
del /q *.pck
title %bnk%
)
for %%f in (*.bnk) do bnkextr %%f
) else (
title %title_temp%
del /q *.bnk
ren *.wav *.wem
title %title_wemdec%
for %%f in (*.wem) do ww2ogg %%f --pcb packed_codebooks_aoTuV_603.bin
for %%f in (*.ogg) do revorb %%f
title %title_temp%
del /q *.wem
for %%f in (*.ogg) do oggdec %%f -w
title %title_temp%
del /q *.ogg
title %title_move%
(
move /y *.wav ../output
if errorlevel 1 goto fail
)
cls
color 2a
echo    %dec_success%
echo.
ping -n 2 127.0.0.1 > nul
goto main
)
:mp3
cd input
move /y *.pck ../bin
move /y *.bnk ../bin
move /y *.wem ../bin
cd ../bin
for %%f in (*.pck) do quickbms pck.bms %%f
) else (
title %title_temp%
del /q *.pck
title %title_bnkdec%
)
for %%f in (*.bnk) do bnkextr %%f
) else (
title %title_temp%
del /q *.bnk
ren *.wav *.wem
title %title_wem%
for %%f in (*.wem) do ww2ogg %%f --pcb packed_codebooks_aoTuV_603.bin
for %%f in (*.ogg) do revorb %%f
title %title_temp%
del /q *.wem
for %%f in (*.ogg) do ogg2mp3 %%f
title %title_temp%
del /q *.ogg
title %title_move%
(
move /y *.mp3 ../output
if errorlevel 1 goto fail
)
cls
color 2a
echo    %dec_success%
echo.
ping -n 2 127.0.0.1 > nul
goto main
)
:fail
title %title_error%
cls
color 4c
echo    %error%
echo.
ping -n 2 127.0.0.1 > nul
goto main
:clear
title %title_clean%
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
cls
color 2a
echo    %clear_done%
echo.
ping -n 2 127.0.0.1 > nul
goto main