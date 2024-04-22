.386
.model flat,stdcall
option casemap:none

include \masm32\include\masm32rt.inc

.data?
    ; ABuff
    ; BBuff
    ; CBuff
    DBuff db 32 dup (?)
    EBuff db 32 dup(?)
    FBuff db 32 dup(?)
    DnBuff db 32 dup (?)
    EnBuff db 32 dup(?)
    FnBuff db 32 dup(?)
    FinalBuff db 128 dup(?)
.data
MsgBoxCaption db "Lab Work 2",0
form db "A=%d",10,
        "-A=%d",10,
        "B=%d",10,
        "-B=%d",10,
        "C=%d",10,
        "-C=%d",10,
        "D=%s",10,
        "-D=%s",10,
        "E=%s",10,
        "-E=%s",10,
        "F=%s",10,
        "-F=%s",0

DateOfBirth db "30072005", 0
; A
A_1 db 30
An_1 db -30
A_2 dw 30
An_2 dw -30
A_4 dd 30
An_4 dd -30
A_8 dq 30
An_8 dq -30

; B
B_2 dw 3007
Bn_2 dw -3007
B_4 dd 3007
Bn_4 dd -3007
B_8 dq 3007
Bn_8 dq -3007

; C
C_4 dd 30072005
Cn_4 dd -30072005
C_8 dq 30072005
Cn_8 dq -30072005

; D
D_4 dd 0.006
Dn_4 dd -0.006
D_8 dq 0.006
Dn_8 dq -0.006

; E
E_8 dq 0.592
En_8 dq -0.592

; F
F_8 dq 5923.184
Fn_8 dq -5923.184
F_10 dt 5923.184
Fn_10 dt -5923.184

.code 
Main:
    invoke FloatToStr2, D_8, addr DBuff
    invoke FloatToStr, E_8, addr EBuff
    invoke FloatToStr2, Dn_8, addr DnBuff
    invoke FloatToStr, En_8, addr EnBuff
    invoke FloatToStr, F_8, addr FBuff
    invoke FloatToStr, Fn_8, addr FnBuff
    invoke  wsprintf, addr FinalBuff, addr form, A_4, An_4, B_4, Bn_4, C_4, 
                      Cn_4, addr DBuff, addr DnBuff, addr EBuff, addr EnBuff,
                      addr FBuff, addr FnBuff
    invoke MessageBox, 0, addr FinalBuff, addr MsgBoxCaption, 0
    invoke ExitProcess , 0

end Main 