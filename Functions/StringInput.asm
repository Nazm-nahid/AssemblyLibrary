READ_STR PROC 
    PUSH AX
    PUSH DI
    CLD
    XOR BX,BX
    
    MOV AH,1
    INT 21H
    
    WHILE1:
        CMP AL,0DH
        JE END_WHILE
         
        CMP AL,8H
        JNE ELSE
        
        DEC DI
        DEC BX 
        
        JMP READ 
    ELSE:  
        STOSB  
        INC BX
        
    READ:
        INT 21H
        JMP WHILE1
    END_WHILE:
        POP DI
        POP AX
        
        RET
    
READ_STR ENDP