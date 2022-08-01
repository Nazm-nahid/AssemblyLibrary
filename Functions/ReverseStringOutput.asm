DISPLAY_REVERSE_STR PROC 
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    
    LEA SI,STRING  
    ADD SI,BX 
    DEC SI 
    
    MOV CX,BX
    
    JCXZ P_EXIT
    
    
    MOV AH,2 
    STD
    TOP:
       
    LODSB
    MOV DL,AL
    INT 21H 
    LOOP TOP
    
    P_EXIT:
    
    
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    
    RET

DISPLAY_REVERSE_STR ENDP
