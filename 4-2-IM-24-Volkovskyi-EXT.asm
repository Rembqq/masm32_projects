.386
.model flat, stdcall
option casemap :none

include \masm32\include\masm32rt.inc

include 4-2-IM-24-Volkovskyi.inc

.data
	Volkovskyi_Caption              db "Student Info", 0
	Volkovskyi_FullName             db "Volkovskyi Mykyta Ihorovych", 0
    Volkovskyi_DateOfBirth          db "Date of birth: 30.07.2005", 0
    Volkovskyi_ScorebookNumber      db "Scorebook number: KV13945077", 0
    Volkovskyi_Wrong_Pass_Body		db "Wrong password. Try again.", 0
	Volkovskyi_Wrong_Pass_Caption	db "Wrong password", 0
	Volkovskyi_Password			    db "*5@[O9/S", 0
    Volkovskyi_Key				    db "oE32#VAc", 0

.data?
	Volkovskyi_Suggested_Pass	    db 20 dup (?)
	Volkovskyi_Password_Length 	    dw ?

DialogH	PROTO :DWORD, :DWORD, :DWORD, :DWORD

.code	
main:    
	
	Dialog "Lab4, Macro definitions and macros in MASM.",\
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
			invoke GetDlgItemText, hWnd, 0, offset Volkovskyi_Suggested_Pass, 256
			invoke StrLen, offset Volkovskyi_Password
            mov Volkovskyi_Password_Length, ax
            mov edi, offset Volkovskyi_Suggested_Pass

            xor bx, bx
            xor cx, cx
            cld

            Volkovskyi_ComparePasswords
            
            InvalidPass:                          
                invoke MessageBox, 0, offset Volkovskyi_Wrong_Pass_Body, offset Volkovskyi_Wrong_Pass_Caption, 0
                invoke ExitProcess, 0
            return 0
            
            ValidPass:                            
                Volkovskyi_ShowResult Volkovskyi_FullName, Volkovskyi_Caption
                Volkovskyi_ShowResult Volkovskyi_DateOfBirth, Volkovskyi_Caption
                Volkovskyi_ShowResult Volkovskyi_ScorebookNumber, Volkovskyi_Caption
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