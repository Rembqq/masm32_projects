.386
.model flat, stdcall
option casemap :none

extern Volkovskyi_A:qword, Volkovskyi_Four:qword, Volkovskyi_B:qword 
public Volkovskyi_ExtPub_Proc

.code
    Volkovskyi_ExtPub_Proc proc
        fld qword ptr Volkovskyi_A
        fld qword ptr Volkovskyi_Four ; st(1) / st(0) ==> st(0)
        fdiv                ; a / 4
        fld qword ptr Volkovskyi_B    ; st(1) - st(0) ==> st(0)
        fsub                ; a / 4 - b

        fptan               ; st(1) = TanRes, st(0) = 1

        fstp st(0)          ; TanArg st(1) ==> st(0)
        ret                 ; condition of stack #2
    Volkovskyi_ExtPub_Proc endp
end 