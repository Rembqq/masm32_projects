.386
.model flat, stdcall
option casemap :none

extern Volkovskyi_A:QWORD, Volkovskyi_Four:QWORD, Volkovskyi_B:QWORD 
public Volkovskyi_ExtPub_Proc

.code
    Volkovskyi_ExtPub_Proc proc
        fld Volkovskyi_A
        fld Volkovskyi_Four ; st(1) / st(0) ==> st(0)
        fdiv                ; a / 4
        fld Volkovskyi_B    ; st(1) - st(0) ==> st(0)
        fsub                ; a / 4 - b
         
        fptan               ; st(1) = TanRes, st(0) = 1

        fmul                ; TanArg st(1) ==> st(0)
        ret
    Volkovskyi_ExtPub_Proc endp
end 