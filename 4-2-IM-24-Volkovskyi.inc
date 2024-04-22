Volkovskyi_XOR macro 
    ;; you shouldn't have seen it -_-
	xor dl, byte ptr [Volkovskyi_Key + bx] ; XOR-ing the key
endm

Volkovskyi_ShowResult macro body, caption 
    ;; and this -_-
	invoke MessageBox, 0, addr body, addr caption, 0 ; outputs MessageBox with the enetered data
endm

Volkovskyi_ComparePasswords macro 
    ;; Ok, it's starting to get strange...
    ; uses local lables
	local count_length, exit_count_length, ComparePasswords
    ; Compares length
	count_length:
        cmp byte ptr [edi], 0
        je exit_count_length
        inc cx
        inc edi
        jmp count_length
    
        exit_count_length:
        cmp cx, Volkovskyi_Password_Length
        jne InvalidPass

    ComparePasswords: ; Compares passwords
        cmp bx, Volkovskyi_Password_Length
        je ValidPass

        mov dh, byte ptr [Volkovskyi_Suggested_Pass + bx]
        mov dl, byte ptr [Volkovskyi_Password + bx]
        Volkovskyi_XOR ; uses XOR-macro

        cmp dh, dl
        jne InvalidPass
        inc bx
        jmp ComparePasswords
endm