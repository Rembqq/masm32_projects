echo Assembling 7-2-IM-24-Volkovskyi.asm
ml /c /coff /Cp /nologo 7-2-IM-24-Volkovskyi.asm
echo Assembling 7-2-IM-24-Volkovskyi-module.asm
ml /c /coff /Cp /nologo 7-2-IM-24-Volkovskyi-module.asm
echo Linking
link /SUBSYSTEM:WINDOWS /OUT:7-2-IM-24-Volkovskyi.exe 7-2-IM-24-Volkovskyi.obj 7-2-IM-24-Volkovskyi-module.obj
echo Gotovo