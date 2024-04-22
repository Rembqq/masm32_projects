
.386
.model flat,stdcall
option casemap:none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib

.data 
    body      db  "Volkovskyi Mykyta Ihorovych", 13, 10, "30.07.2005", 13, 10, "KV13945077", 0
    caption   db  "Student Info", 0

.code 

start:
    invoke  MessageBox, 0, addr body, addr caption, MB_OK
    invoke ExitProcess , 0

end start   



