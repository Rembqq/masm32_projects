.386
.model flat, stdcall
option casemap :none

include \masm32\include\masm32rt.inc

.data
    ; calculations 
    Volkovskyi_Mediate_Message      db "Mediate result: %d", 0
    Volkovskyi_Eventual_Message     db "Eventual result: %d", 0
    Volkovskyi_Example_Message      db "Example N%d", 0

    ; window title
    Volkovskyi_Caption              db "Arithmetic and logical operations with integers. Arrays", 0

    Volkovskyi_ABC_Values           db "Values: A = %d, B = %d, C = %d", 0
    Volkovskyi_Formula              db "Formula: (-25 / a + c - b * a) / (1 + c * b / 2)", 0
    Volkovskyi_Value_Formula        db "Formula with values: (-25 / %d + %d - %d * %d) / (1 + %d * %d / 2)", 0

    ; errors
    Volkovskyi_Default_Error_Message db "%s", 0
    Volkovskyi_ErrorZeroDivision    db "Division by zero is prohibited!", 0

    ; total messages
    Volkovskyi_Overall_Message db "%s", 10, "%s", 10, "%s", 10, "%s", 10, "%s", 10, "%s", 0
    Volkovskyi_Total_Error_Message db "%s", 10, "%s", 10, "%s", 10, "%s", 10, "%s", 0
    
        
.data?

    Volkovskyi_A               dd ?
    Volkovskyi_B               dd ?
    Volkovskyi_C               dd ?
    Volkovskyi_Numerator       dd ?
    Volkovskyi_Denominator     dd ?
    Volkovskyi_Mediate_Sum     dd ?
    Volkovskyi_Eventual_Sum    dd ?

    Volkovskyi_Example_Buff db 75 dup (?)
    Volkovskyi_Values_Buff db 75 dup (?)
    Volkovskyi_Value_Formula_Buff db 75 dup (?)
    Volkovskyi_Mediate_Sum_Buff db 75 dup (?)
    Volkovskyi_Eventual_Sum_Buff db 75 dup (?)
    Volkovskyi_Overall_Buff db 400 dup (?)

.code	
    Volkovskyi_A_Arr dd 25, -25, -5, 5, -5
    Volkovskyi_B_Arr dd 2, 2, 2, 2, 2
    Volkovskyi_C_Arr dd -2, 4, -1, 3, -2 
main:   
    ; (-25 / a + c - b * a) / (1 + c * b / 2)
    ; array index
    mov esi, 0
    ; example number
    mov edi, 1
    
    ; mov esi, addr Volkovskyi_A_Arr         ; Указываем на начало массива A
    ; mov edi, addr Volkovskyi_B_Arr         ; Указываем на начало массива B
    ; mov ebx, addr Volkovskyi_C_Arr
    arrayLoop:
        ; compare index and array size, if equal, jump to closeProgram
        cmp esi, 5
        je closeProgram

        ; get values of arrays
        ; mov Volkovskyi_A, Volkovskyi_A_Arr[si * 2]
        ; mov Volkovskyi_B, Volkovskyi_B_Arr[si * 2]
        ; mov Volkovskyi_C, Volkovskyi_C_Arr[si * 2]

        mov eax, [Volkovskyi_A_Arr + esi * 4]
        mov ebx, [Volkovskyi_B_Arr + esi * 4]
        mov ecx, [Volkovskyi_C_Arr + esi * 4]

        ; mov ax, [esi]
        ; mov bx, [edi]
        ; mov cx, [ebx]


        ; mov bx, si
        ; shl bx, 1
        ; mov ax, Volkovskyi_A_Arr[bx]
        ; mov Volkovskyi_A, ax

        ; mov bx, si
        ; shl bx, 1
        ; mov cx, Volkovskyi_C_Arr[bx]
        ; mov Volkovskyi_C, cx

        ; mov ax, si
        ; shl ax, 1
        ; mov bx, [Volkovskyi_B_Arr + ax]
        ; mov Volkovskyi_B, bx

        ; 
        ;   Denominator
        ;

        ; mov ax, Volkovskyi_A
        ; mov bx, Volkovskyi_B
        ; mov cx, Volkovskyi_C

        mov Volkovskyi_A, eax
        mov Volkovskyi_C, ecx
        mov Volkovskyi_B, ebx

        ; c * b, result ==> ecx 
        imul ecx, Volkovskyi_B
        
        ; c * b, result ==> eax 
        mov eax, ecx

        ; c * b / 2, result ==> eax 
        mov ebx, 2
        cdq
        idiv ebx

        ; 1 + c * b / 2, result ==> eax
        inc eax 

        ; 1 + c * b / 2, result ==> Volkovskyi_Denominator
        mov Volkovskyi_Denominator, eax

        cmp Volkovskyi_Denominator, 0
        je denomZeroWindow

        ; 
        ;   Numerator
        ;

        mov eax, -25
        mov ebx, Volkovskyi_B
        mov ecx, Volkovskyi_C

        ; -25 / a, result ==> eax
        cdq
        idiv Volkovskyi_A

        ; -25 / a + c, result ==> eax
        add eax, Volkovskyi_C 

        ; b * a, result ==> ebx
        imul ebx, Volkovskyi_A

        ; (-25 / a + c) - (b * a) ==> Volkovskyi_Numerator
        sub eax, ebx
        mov Volkovskyi_Numerator, eax

        ; 
        ;   Mediate Result
        ;

        mov eax, Volkovskyi_Numerator
        cdq
        idiv Volkovskyi_Denominator
        mov Volkovskyi_Mediate_Sum, eax

        ; 
        ;   Eventual Result
        ;

        ; parity check
        mov eax, Volkovskyi_Mediate_Sum
        mov ebx, 2
        cdq 
        idiv ebx
        ; if (eax % 2 == 0) ==> jump to evenSum
        ; if (eax % 2 == 0) ==> jump to oddSum
        cmp edx, 0
        je evenSum
        jmp oddSum

        evenSum:
            ; sum / 2, result ==> Volkovskyi_Eventual_Sum
            mov eax, Volkovskyi_Mediate_Sum
            mov ebx, 2
            cdq
            idiv ebx
            mov Volkovskyi_Eventual_Sum, eax
            jmp exampleWindow
        oddSum:
            ; sum * 5, result ==> Volkovskyi_Eventual_Sum
            mov eax, Volkovskyi_Mediate_Sum
            imul eax, 5
            mov Volkovskyi_Eventual_Sum, eax
            jmp exampleWindow

    denomZeroWindow:
        ; example number + formula + values + substituted formula + error message
        invoke wsprintf, addr Volkovskyi_Example_Buff, addr Volkovskyi_Example_Message, edi
        invoke wsprintf, addr Volkovskyi_Values_Buff, addr Volkovskyi_ABC_Values, Volkovskyi_A, 
                Volkovskyi_B, Volkovskyi_C
        invoke wsprintf, addr Volkovskyi_Value_Formula_Buff, addr Volkovskyi_Value_Formula, 
                Volkovskyi_A, Volkovskyi_C, Volkovskyi_B, Volkovskyi_A, 
                Volkovskyi_C, Volkovskyi_B
        invoke wsprintf, addr Volkovskyi_Mediate_Sum_Buff, addr Volkovskyi_Default_Error_Message, 
                addr Volkovskyi_ErrorZeroDivision 
        invoke wsprintf, addr Volkovskyi_Overall_Buff, addr Volkovskyi_Total_Error_Message, 
                addr Volkovskyi_Example_Buff, addr Volkovskyi_Values_Buff, addr Volkovskyi_Formula,
                addr Volkovskyi_Value_Formula_Buff, addr Volkovskyi_Mediate_Sum_Buff


        jmp outputAndReturn
    exampleWindow:
        ; example number + formula + values + substituted formula + mediate sum + eventual sum 
        invoke wsprintf, addr Volkovskyi_Example_Buff, addr Volkovskyi_Example_Message, edi
        invoke wsprintf, addr Volkovskyi_Values_Buff, addr Volkovskyi_ABC_Values, Volkovskyi_A, 
                Volkovskyi_B, Volkovskyi_C
        invoke wsprintf, addr Volkovskyi_Value_Formula_Buff, addr Volkovskyi_Value_Formula, 
                Volkovskyi_A, Volkovskyi_C, Volkovskyi_B, Volkovskyi_A, 
                Volkovskyi_C, Volkovskyi_B
        invoke wsprintf, addr Volkovskyi_Mediate_Sum_Buff, addr Volkovskyi_Mediate_Message, 
                Volkovskyi_Mediate_Sum 
        invoke wsprintf, addr Volkovskyi_Eventual_Sum_Buff, addr Volkovskyi_Eventual_Message,
                Volkovskyi_Eventual_Sum
        invoke wsprintf, addr Volkovskyi_Overall_Buff, addr Volkovskyi_Overall_Message, 
                addr Volkovskyi_Example_Buff, addr Volkovskyi_Values_Buff, 
                addr Volkovskyi_Formula, addr Volkovskyi_Value_Formula_Buff, 
                addr Volkovskyi_Mediate_Sum_Buff, addr Volkovskyi_Eventual_Sum_Buff

        jmp outputAndReturn
    outputAndReturn:
        invoke MessageBox, 0, addr Volkovskyi_Overall_Buff, addr Volkovskyi_Caption, 0
        ; esi++ edi++
        ; add esi, 2
        ; add edi, 2       
        ; add ebx, 2
        inc esi
        inc edi
        jmp arrayLoop
    closeProgram:
        invoke ExitProcess, 0
end main