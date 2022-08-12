.MODEL SMALL
.STACK 100H
.DATA

Array   DB 11,22,33,44
        DB 55,66,77,88
        DB 88,77,66,55 
        DB 44,33,22,11 
        
COUNT DB 0
    

MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    MOV SI,1
    XOR BX,BX
    MOV CX,4 
    
    FOR:
        MOV Array[BX][SI],0
        ADD BX,4      
        LOOP FOR 
        
    MOV SI,0
    
    WHILE: 
        MOV CX,4  
         
        MOV DX,0
        
        LOOPING:
            XOR BX,BX
            MOV BL, Array[BX][SI] 
            CALL DECOUT  
            
            MOV AH,2
            MOV DL,' '
            INT 21H
            
            INC SI     
            LOOP LOOPING 
            
        MOV AH,2 
        MOV DL,0AH
        INT 21H
        MOV DL,0DH
        INT 21H

        INC COUNT
        CMP COUNT,4  
        JNE WHILE
    
  
    MOV AH,4CH
    INT 21H
    
MAIN ENDP

DECOUT PROC 
    
    PUSH AX
    PUSH DX 
    PUSH CX
    
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
                 
    POP CX 
    POP DX
    POP AX
    
    RET 
        
DECOUT ENDP
END MAIN