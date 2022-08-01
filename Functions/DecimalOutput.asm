DECOUT PROC 
    
    PUSH AX
    PUSH DX
    
    MOV AX,BX
    
    MOV CX,0 
    MOV BX,10
      
    DIVI:  
        
        XOR DX,DX
        DIV BX
        
        PUSH DX 
                               
        INC CX
        CMP AX,0
        JNE DIVI 
    
    MOV AH,2
    
    PRINT:
        POP DX 
        ADD DX,'0'
        INT 21H
        
        LOOP PRINT
                 
       
    POP DX
    POP AX
    
    RET 
        
DECOUT ENDP
