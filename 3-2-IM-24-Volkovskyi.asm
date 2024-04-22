.386
.model flat, stdcall
option casemap :none

include \masm32\include\masm32rt.inc

.data
	caption             db "Student Info", 0
	body                db "Volkovskyi Mykyta Ihorovych", 13, 10, "30.07.2005", 13, 10, "KV13945077", 0
    wrong_pass_body		db "Wrong password. Try again.", 0
	wrong_pass_caption	db "Wrong password", 0
	password			db "Epsilon0", 0

.data?
	suggested_pass	    db 20 dup (?)
	password_length 	dw ?

DialogH	PROTO :DWORD, :DWORD, :DWORD, :DWORD

.code	
main:    
	
	Dialog "Lab3, Studying the structure of EXE format programs.",\
		"Candara", 14,											  \            							    
        WS_OVERLAPPED or										  \ 
		WS_SYSMENU or DS_CENTER,								  \   							
        4,														  \
		15, 15,													  \
		170, 90,											      \
		512
		DlgStatic "Enter the password:", SS_LEFT, 50,  12, 120,  10, 228	
		DlgEdit   WS_BORDER, 15,  25, 130, 10, 0		
		DlgButton "Check", WS_VISIBLE, 20,  55, 45,  15, IDOK 				
		DlgButton "Cancel", WS_VISIBLE, 95, 55, 45,  15, IDCANCEL 	

	    CallModalDialog 0, 0, DialogH, NULL


	DialogH proc hWnd:DWORD, message:DWORD, wParam:DWORD, lParam:DWORD
		cmp message, WM_INITDIALOG
		je dialogInit
		
		cmp message, WM_COMMAND
		je commandH

		cmp message, WM_CLOSE
		je closeProgram

		dialogInit:
			invoke GetWindowLong, hWnd, GWL_USERDATA
			return 0

		handleOK:
			invoke GetDlgItemText, hWnd, 0, offset suggested_pass, 256
			invoke StrLen, offset password
            mov password_length, ax
            mov edi, offset suggested_pass

            xor bx, bx
            xor cx, cx
            cld

            count_length:
                cmp byte ptr [edi], 0
                je exit_count_length
                inc cx
                inc edi
                jmp count_length
            
                exit_count_length:
                cmp cx, password_length
                jne InvalidPass

            ComparePasswords:
                cmp bx, password_length
                je ValidPass
                mov dh, byte ptr [suggested_pass + bx]
                mov dl, byte ptr [password + bx]
                cmp dh, dl
                jne InvalidPass
                inc bx
                jmp ComparePasswords
            
            InvalidPass:                          
                invoke MessageBox, 0, offset wrong_pass_body, offset wrong_pass_caption, 0
                invoke ExitProcess, 0
            return 0
            
            ValidPass:                            
                invoke MessageBox, 0, offset body, offset caption, 0
                invoke ExitProcess, 0
            return 0

            xor eax, eax
			return 0


		commandH:
			cmp wParam, IDOK
			je handleOK
			cmp wParam, IDCANCEL
			je closeProgram
			return 0

		closeProgram:
			invoke ExitProcess, 0

	DialogH endp

end main