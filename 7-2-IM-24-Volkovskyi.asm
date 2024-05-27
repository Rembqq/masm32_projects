.386
.model flat, stdcall
option casemap :none

include \masm32\include\masm32rt.inc

public Volkovskyi_A, Volkovskyi_Four, Volkovskyi_B
extern Volkovskyi_ExtPub_Proc:PROTO

.data
    ; calculations 
    Volkovskyi_Eventual_Message     db "Eventual result: %s", 0
    Volkovskyi_Example_Message      db "Example N%d", 0

    ; window title
    Volkovskyi_Caption              db "Calculation of arithmetic expressions and transcendental functions.", 0

    Volkovskyi_ABCD_Values          db "Values: A = %s, B = %s, C = %s, D = %s", 0
    Volkovskyi_Formula              db "Formula: (-2 * c - d * 82) / (tg(a / 4 - b))", 0
    Volkovskyi_Value_Formula        db "Formula with values: (-2 * %s - %s * 82) / (tg(%s / 4 - %s))", 0

    ; constants
    Volkovskyi_Four       dq 4.0
    Volkovskyi_EightyTwo  dq 82.0
    Volkovskyi_mTwo       dq -2.0
    Volkovskyi_halfPi     dq 1.5707
    Volkovskyi_Zero       dq 0.0
    ; these limits used to identify when TanArg = 1.5707
    Volkovskyi_UpperLimit dq 10000.0
    Volkovskyi_LowerLimit dq -10000.0

    ; errors
    Volkovskyi_Default_Error_Message    db "%s", 0
    Volkovskyi_ErrorZeroDivision        db "Division by zero is prohibited!", 0
    Volkovskyi_ErrorDefAreaViolation    db "Violation of the definition area of the existing function!", 0

    ; total messages
    Volkovskyi_Overall_Message     db "%s", 10, "%s", 10, "%s", 10, "%s", 10, "%s", 0
    Volkovskyi_Total_Error_Message db "%s", 10, "%s", 10, "%s", 10, "%s", 10, "%s", 0
    
    ;Volkovskyi_TMP_FORM        db "Value: %s", 0
        
.data?
    ; mediate values are DT
    Volkovskyi_Numerator       dt ?
    Volkovskyi_Denominator     dq ?
    Volkovskyi_TMP_VAR         dq ?
    Volkovskyi_TMP2_VAR         dq ?
    Volkovskyi_D_Converter       dq ?

    ; BufferA db 64 dup(?)
    ; BufferB db 64 dup(?)
    ; BufferFour db 64 dup(?)

    Volkovskyi_Str_A db 20 dup (?)
    Volkovskyi_Str_B db 20 dup (?)
    Volkovskyi_Str_C db 20 dup (?)
    Volkovskyi_Str_D db 20 dup (?)
    Volkovskyi_Str_Eventual_Sum db 20 dup(?)

    Volkovskyi_Eventual_Sum    dq ?
    Volkovskyi_Tan_Arg         dq ?
    Volkovskyi_A               dq ?
    Volkovskyi_B               dq ?

    Volkovskyi_Example_Buff         db 75 dup (?)
    Volkovskyi_Values_Buff          db 75 dup (?)
    Volkovskyi_Value_Formula_Buff   db 75 dup (?)
    Volkovskyi_Eventual_Sum_Buff    db 75 dup (?)
    Volkovskyi_Overall_Buff         db 400 dup (?)

    ;Volkovskyi_TMP_BUFF        db 30 dup (?)

.code	
    Volkovskyi_A_Arr dq 0.2, 24.8, 16.8, 8.4, 20.4, 5.6
    Volkovskyi_B_Arr dq 1.6, 4.7, 4.2, 0.7, 6.4, -0.1707
    Volkovskyi_C_Arr dq 72.1, 66.6, 19.6, -120.7, -29.2, -29.2 
    Volkovskyi_D_Arr dq 2.2, -2.1, 32.1, 3.3, 0.5, 0.5

Volkovskyi_Registers_Proc proc
    fld QWORD ptr [ecx]
    fld QWORD ptr [edx]
    fmul
    
    ret  ; condition of stack #4
Volkovskyi_Registers_Proc endp

Volkovskyi_Stack_Proc proc
    push ebp ; condition of stack #8
    mov ebp, esp

    mov ebx, [ebp + 8]
    fld QWORD ptr [ebx]
    mov eax, [ebp + 12]
    fld QWORD ptr [eax]
    fmul

    ; pop 4
    ; ret 4
    ; mov esp, ebp
    pop ebp ; condition of stack #9
    ret 8 ; condition of stack #10
Volkovskyi_Stack_Proc endp

main:   


    ; (-25 / a + c - b * a) / (1 + c * b / 2)
    ; array index
    mov esi, 0
    ; example number
    mov edi, 1
    
    arrayLoop:
        ; compare index and array size, if equal, jump to closeProgram
        cmp esi, 6
        je closeProgram

        invoke FloatToStr, [Volkovskyi_A_Arr + esi * 8], addr Volkovskyi_Str_A
        invoke FloatToStr, [Volkovskyi_B_Arr + esi * 8], addr Volkovskyi_Str_B
        invoke FloatToStr, [Volkovskyi_D_Arr + esi * 8], addr Volkovskyi_Str_D
        invoke FloatToStr, [Volkovskyi_C_Arr + esi * 8], addr Volkovskyi_Str_C

        ; formula: (-2 * c - d * 82) / (tg(a / 4 - b))

        ; 
        ;   Denominator
        ;

        finit

        ; get values of arrays
        fld qword ptr [Volkovskyi_A_Arr + esi * 8]
        fstp qword ptr Volkovskyi_A
        fstp st(0)
        fld qword ptr [Volkovskyi_B_Arr + esi * 8]
        fstp qword ptr Volkovskyi_B
        fstp st(0)

        call Volkovskyi_ExtPub_Proc ; condition of stack #1

        ; TMP start                  ; Выделить место для хранения значения
        ; fstp qword ptr [esp]
        ; invoke FloatToStr, qword ptr [esp], addr Volkovskyi_TMP_STR
        ; invoke wsprintf, addr Volkovskyi_TMP_BUFF, addr Volkovskyi_TMP_STR
        ; invoke MessageBox, 0, addr Volkovskyi_TMP_BUFF, addr Volkovskyi_Caption, 0


        ; fstp qword ptr [BufferB]  ; извлечение Volkovskyi_B_Arr
        ; fstp qword ptr [BufferFour]  ; извлечение Volkovskyi_Four
        ; fstp qword ptr [BufferA]  ; извлечение Volkovskyi_A_Arr

        ; ; Преобразование чисел в строки
        ; invoke FloatToStr, ADDR BufferA, BufferA
        ; invoke FloatToStr, ADDR BufferFour, BufferFour
        ; invoke FloatToStr, ADDR BufferB, BufferB

        ; ; Подготовка сообщения для MessageBox
        ; invoke wsprintf, ADDR BufferA, OFFSET BufferA, OFFSET BufferB, OFFSET BufferFour

        ; ; Вывод в MessageBox
        ; invoke MessageBox, 0, ADDR BufferA, ADDR Volkovskyi_Caption, MB_OK

        ; TMP end

        fstp qword ptr Volkovskyi_Denominator 

        fstp st(0)

        ; ; st(1) = TanArg, st(0) = 1 
        ; fptan

        ; ; TanArg st(1) ==> st(0)
        ; fmul

        ; upper limit check
        
        fld qword ptr Volkovskyi_Denominator
        fld Volkovskyi_UpperLimit
        fcom 
        fstsw ax
        sahf
        jb defAreaViolation
        fstp st(0)

        fld qword ptr Volkovskyi_Denominator
        fcom Volkovskyi_Zero
        fstsw ax
        sahf
        jz denomZeroWindow
        fstp st(0)

        ; lower limit check
        fcom Volkovskyi_LowerLimit
        fstsw ax
        sahf
        jl defAreaViolation
        
        ; zero compare
        

        ;fstp Volkovskyi_Denominator
        ;fld Volkovskyi_Denominator

        ; 
        ;   Numerator
        ;

        
        lea eax, Volkovskyi_EightyTwo
        lea ebx, [Volkovskyi_D_Arr + esi * 8]
        lea ecx, [Volkovskyi_C_Arr + esi * 8]
        lea edx, Volkovskyi_mTwo

        call Volkovskyi_Registers_Proc ; condition of stack #3

        fstp qword ptr Volkovskyi_TMP_VAR

        fstp st(0)

        fld qword ptr Volkovskyi_D_Arr[esi * 8]
        fstp qword ptr Volkovskyi_D_Converter 
        fstp st(0)

        push offset Volkovskyi_EightyTwo ; condition of stack #5
        push offset Volkovskyi_D_Converter ; condition of stack #6

        call Volkovskyi_Stack_Proc ; condition of stack #7

        fstp qword ptr Volkovskyi_TMP2_VAR

        fstp st(0)

        fld qword ptr Volkovskyi_TMP_VAR
        fld qword ptr Volkovskyi_TMP2_VAR
        
        fsub

        ; fld Volkovskyi_EightyTwo
        ; fld [Volkovskyi_D_Arr + esi * 8]
        ; fmul

        ; fld [Volkovskyi_C_Arr + esi * 8]
        ; fld Volkovskyi_mTwo
        ; fmul

        ; fsubr
        fstp Volkovskyi_Numerator

        ; 
        ;   Eventual Result
        ;

        fld Volkovskyi_Denominator
        fld Volkovskyi_Numerator  
        fdivr 

        fstp Volkovskyi_Eventual_Sum
        jmp exampleWindow

    denomZeroWindow:
        ; example number + formula + values + substituted formula + error message
        invoke wsprintf, addr Volkovskyi_Example_Buff, addr Volkovskyi_Example_Message, edi
        invoke wsprintf, addr Volkovskyi_Values_Buff, addr Volkovskyi_ABCD_Values, addr Volkovskyi_Str_A, 
                addr Volkovskyi_Str_B, addr Volkovskyi_Str_C, addr Volkovskyi_Str_D
        invoke wsprintf, addr Volkovskyi_Value_Formula_Buff, addr Volkovskyi_Value_Formula, 
                addr Volkovskyi_Str_C, addr Volkovskyi_Str_D, addr Volkovskyi_Str_A, addr Volkovskyi_Str_B
        invoke wsprintf, addr Volkovskyi_Eventual_Sum_Buff, addr Volkovskyi_Default_Error_Message, 
                addr Volkovskyi_ErrorZeroDivision 
        invoke wsprintf, addr Volkovskyi_Overall_Buff, addr Volkovskyi_Total_Error_Message, 
                addr Volkovskyi_Example_Buff, addr Volkovskyi_Values_Buff, addr Volkovskyi_Formula,
                addr Volkovskyi_Value_Formula_Buff, addr Volkovskyi_Eventual_Sum_Buff

        jmp outputAndReturn

    defAreaViolation:
        invoke wsprintf, addr Volkovskyi_Example_Buff, addr Volkovskyi_Example_Message, edi
        invoke wsprintf, addr Volkovskyi_Values_Buff, addr Volkovskyi_ABCD_Values, addr Volkovskyi_Str_A, 
                addr Volkovskyi_Str_B, addr Volkovskyi_Str_C, addr Volkovskyi_Str_D
        invoke wsprintf, addr Volkovskyi_Value_Formula_Buff, addr Volkovskyi_Value_Formula, 
                addr Volkovskyi_Str_C, addr Volkovskyi_Str_D, addr Volkovskyi_Str_A, addr Volkovskyi_Str_B
        invoke wsprintf, addr Volkovskyi_Eventual_Sum_Buff, addr Volkovskyi_Default_Error_Message, 
                addr Volkovskyi_ErrorDefAreaViolation 
        invoke wsprintf, addr Volkovskyi_Overall_Buff, addr Volkovskyi_Total_Error_Message, 
                addr Volkovskyi_Example_Buff, addr Volkovskyi_Values_Buff, addr Volkovskyi_Formula,
                addr Volkovskyi_Value_Formula_Buff, addr Volkovskyi_Eventual_Sum_Buff

        jmp outputAndReturn
    exampleWindow:
        ; converting
        invoke FloatToStr, Volkovskyi_Eventual_Sum, addr Volkovskyi_Str_Eventual_Sum
        
        ; invoke FloatToStr, Volkovskyi_Denominator, addr Volkovskyi_TMP_STR
        ; example number + formula + values + substituted formula + eventual sum 
        invoke wsprintf, addr Volkovskyi_Example_Buff, addr Volkovskyi_Example_Message, edi
        invoke wsprintf, addr Volkovskyi_Values_Buff, addr Volkovskyi_ABCD_Values, addr Volkovskyi_Str_A, 
                addr Volkovskyi_Str_B, addr Volkovskyi_Str_C, addr Volkovskyi_Str_D
        invoke wsprintf, addr Volkovskyi_Value_Formula_Buff, addr Volkovskyi_Value_Formula, 
                addr Volkovskyi_Str_C, addr Volkovskyi_Str_D, addr Volkovskyi_Str_A, addr Volkovskyi_Str_B
        invoke wsprintf, addr Volkovskyi_Eventual_Sum_Buff, addr Volkovskyi_Eventual_Message,
                addr Volkovskyi_Str_Eventual_Sum

        ; invoke wsprintf, addr Volkovskyi_TMP_BUFF, addr Volkovskyi_TMP_FORM, addr Volkovskyi_TMP_STR

        invoke wsprintf, addr Volkovskyi_Overall_Buff, addr Volkovskyi_Overall_Message, 
                addr Volkovskyi_Example_Buff, addr Volkovskyi_Values_Buff, 
                addr Volkovskyi_Formula, addr Volkovskyi_Value_Formula_Buff, 
                addr Volkovskyi_Eventual_Sum_Buff

        jmp outputAndReturn
    outputAndReturn:
        invoke MessageBox, 0, addr Volkovskyi_Overall_Buff, addr Volkovskyi_Caption, 0
        ; esi++ edi++
        inc esi
        inc edi
        jmp arrayLoop
    closeProgram:
        invoke ExitProcess, 0
end main