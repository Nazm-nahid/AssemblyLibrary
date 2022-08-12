.MODEL SMALL
.STACK 100H
.DATA

msg1 db 'Type a character:$'
msg2 db ,0DH,0AH,'The Ascii code at Hexa-Decimal :  $'  

count dw 12

.CODE
MAIN PROC

    MOV AX,@DATA
    MOV DS,AX
    
    MOV AH,9
    LEA DX,msg1  
    INT 21H
    
    MOV AH,1
    INT 21H 
    XOR BX,BX
    MOV BL,AL
    
    MOV AH,9
    LEA DX,msg2  
    INT 21H 
    
    MOV CX,4
    
    FOR:
        MOV DX,BX
        
        PUSH CX
        MOV CX,count
        SHR DX,CL 
        AND DX,0FH 
        POP CX
        
        
        CMP DX,9
        JG CHAR 
        
        ADD DX,30H
        
        JMP DISPLAY
        
        CHAR:
        ADD DX,55H
        
        DISPLAY:
        MOV AH,2
        INT 21H 
        
        SUB count,4
        
        LOOP FOR  
        
        MOV DL,'H'
        INT 21H
    
    MOV AH,4CH
    INT 21H 
    
MAIN ENDP
END MAIN