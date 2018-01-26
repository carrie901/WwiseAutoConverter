@echo off
SetLocal EnableDelayedExpansion
call bin/settings.cmd
if exist "bin/languages/%lang%.cmd*" (
call bin/languages/%lang%.cmd
chcp 866 > nul
goto main
) else (
cls
color c
echo.
echo    Language File Not Found
ping -n 6 127.0.0.1 > nul
exit
)
md input
md output
:main
title WWISE Batch Converter
cls
color 7
echo.
echo    =====================
echo    WWISE Batch-Converter
echo    =====================
echo.
echo    1 - %decode%
echo    2 - %clear%
echo.
echo    3 - %exit%
echo.
set menu=x
set /p menu=" > "
cls
if /i %menu%==1 goto decode
if /i %menu%==2 goto clear
if /i %menu%==3 exit
goto main
:decode
title %program%
echo.
echo    =====================
echo    WWISE Batch-Converter
echo    =====================
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
set menu=x
set /p menu=" > "
cls
if /i %menu%==1 goto ogg
if /i %menu%==2 goto wav
if /i %menu%==3 goto mp3
if /i %menu%==4 goto main
if /i %menu%==5 exit
goto decode
:ogg
cd input
move /y *.pck ../bin
move /y *.bnk ../bin
move /y *.wem ../bin
cd ../bin
for %%f in (*.pck) do quickbms pck.bms %%f
) else (
title %title_del%
del /q *.pck
title %title_bnk%
)
for %%f in (*.bnk) do bnkextr %%f
) else (
title %title_del%
del /q *.bnk
ren *.wav *.wem
title %title_wem%
for %%f in (*.wem) do ww2ogg %%f --pcb packed_codebooks_aoTuV_603.bin
for %%f in (*.ogg) do revorb %%f
title %title_del%
del /q *.wem
title %title_move%
(
move /y *.ogg ../output
if errorlevel 1 goto fail
)
goto success
)
:wav
cd input
move /y *.pck ../bin
move /y *.bnk ../bin
move /y *.wem ../bin
cd ../bin
for %%f in (*.pck) do quickbms pck.bms %%f
) else (
title %title_del%
del /q *.pck
title %bnk%
)
for %%f in (*.bnk) do bnkextr %%f
) else (
title %title_del%
del /q *.bnk
ren *.wav *.wem
title %title_wem%
for %%f in (*.wem) do ww2ogg %%f --pcb packed_codebooks_aoTuV_603.bin
for %%f in (*.ogg) do revorb %%f
title %title_del%
del /q *.wem
for %%f in (*.ogg) do oggdec %%f -w
title %title_del%
del /q *.ogg
title %title_move%
(
move /y *.wav ../output
if errorlevel 1 goto fail
)
goto success
)
:mp3
cd input
move /y *.pck ../bin
move /y *.bnk ../bin
move /y *.wem ../bin
cd ../bin
for %%f in (*.pck) do quickbms pck.bms %%f
) else (
title %title_del%
del /q *.pck
title %title_bnk%
)
for %%f in (*.bnk) do bnkextr %%f
) else (
title %title_del%
del /q *.bnk
ren *.wav *.wem
title %title_wem%
for %%f in (*.wem) do ww2ogg %%f --pcb packed_codebooks_aoTuV_603.bin
for %%f in (*.ogg) do revorb %%f
title %title_del%
del /q *.wem
for %%f in (*.ogg) do ogg2mp3 %%f
title %title_del%
del /q *.ogg
title %title_move%
(
move /y *.mp3 ../output
if errorlevel 1 goto fail
)
goto success
)
:fail
title %title_fail%
cls
color c
echo.
echo    %decode_fail%
ping -n 2 127.0.0.1 > nul
goto main
:success
cls
color a
echo.
echo    %decode_success%
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
color a
echo.
echo    %clear_done%
ping -n 2 127.0.0.1 > nul
goto main
