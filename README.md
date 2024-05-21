ml /c /coff <.asm> **creates object file without listing**

ml /c /coff /Fl <.asm> **creates object file with listing**

Link32 /SUBSYSTEM:WINDOWS <.obj> **creates executable file**

Link M1.obj M2.obj [M.exe] **links modules**

**Debug functions:**

`fstp qword ptr Volkovskyi_TMP_VAR
invoke FloatToStr2, Volkovskyi_TMP_VAR, addr Volkovskyi_TMP_BUFF
invoke MessageBox, 0, addr Volkovskyi_TMP_BUFF, addr Volkovskyi_Caption, 0

fstp st(0)

fld qword ptr Volkovskyi_TMP_VAR`