@echo off
title [Running] Extracting bnk...
cd input
move /y *.wem ../bin
move /y *.bnk ../bin
cd ../bin
:loop
for %%f in (*.bnk) do bnkextr %%f
 ) else (
del *.bnk
ren *.wav *.wem
title [Running] Converting wem...
for %%f in (*.wem) do ww2ogg %%f --pcb packed_codebooks_aoTuV_603.bin
for %%f in (*.ogg) do revorb %%f
title [Running] Deleting temp files...
del /q *.wem
title [Running] Decoding ogg...
for %%f in (*.ogg) do oggdec %%f
title [Running] Deleting temp files...
del /q *.ogg
title [Running] Moving wave...
move /y *.wav ../output
exit
 )
goto loop