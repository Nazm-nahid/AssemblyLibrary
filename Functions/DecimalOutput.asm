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
                 
       
    POP DX
    POP AX
    
    RET 
        
DECOUT ENDP