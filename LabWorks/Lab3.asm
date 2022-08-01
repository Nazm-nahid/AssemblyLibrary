.MODEL SMALL
.STACK 100H
.DATA   
    msg DB "Enter Input : $"
    msg1 DB "This is a Digit.$"
    msg2 DB "This is a capital letter.$"
    msg3 DB "This is a small letter.$"   
.CODE
    MAIN PROC 
        
        MOV AX,@DATA
        MOV DS,AX
        
        ;ENTER INPUT :
        LEA DX,msg
        MOV AH,9
        INT 21H 
        
        ;TAKE INPUT
        MOV AH,1
        INT 21H
        
        ;Move inputto bl
        MOV BL,AL
        
        ;Carige Return
        MOV AH,2
        MOV DL,0DH
        INT 21H
        
        ;New Line
        MOV DL,0AH
        INT 21H
        
        MOV AH,9
        
        CMP BL,'0' 
        JNGE END_IF
        CMP BL,'9'
        JNLE PRINTC
                 
        LEA DX,msg1
        INT 21H 
        JMP END_IF
        
        PRINTC:
               CMP BL,'A' 
               JNGE END_IF
               CMP BL,'Z'
               JNLE PRINTS
                         
               LEA DX,msg2
               INT 21H 
               JMP END_IF
        PRINTS:
               CMP BL,'a' 
               JNGE END_IF
               CMP BL,'z'
               JNLE END_IF
                         
               LEA DX,msg3
               INT 21H  
        END_IF:         
            MOV AH,4CH
            INT 21H 
    MAIN ENDP
        END MAIN