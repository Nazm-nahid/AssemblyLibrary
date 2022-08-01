AVARAGE PROC 
    
    
    MOV AX,0
    MOV BX,0 
    MOV DX,0
    
    MOV CX,12
    
    SUMMATION:
        MOV DL,Array[BX]  
        ADD AX,DX
        ADD BX,1
        LOOP SUMMATION 
    XOR DX,DX 
        
    MOV BX,12
    DIV BX
    
    MOV Avg,AL 
    
    
    RET 
        
AVARAGE ENDP