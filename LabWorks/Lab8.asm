.MODEL SMALL
.STACK 100H
.DATA  
    STRING DB 80 DUP(0)  
    CRLF DB 0DH,0AH,'$' 
    MSG1 DB "Enter A string : $"  
    MSG2 DB "Reversed string : $"
.CODE
MAIN PROC   
        
    MOV AX,@DATA
    MOV DS,AX 
    MOV ES,AX  
    
    LEA DI,STRING 
    
    MOV AH,9
    LEA DX,MSG1
    INT 21H
    
    CALL READ_STR
    
    LEA DX,CRLF
    MOV AH,9
    INT 21H
    

    MOV AH,9
    LEA DX,MSG2
    INT 21H
     
    CALL DISPLAY_REVERSE_STR
         
    MOV AH,4CH
    INT 21H
    
MAIN ENDP  

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
END MAIN
