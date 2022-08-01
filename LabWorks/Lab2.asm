.MODEL SMALL
.STACK 100H  
.DATA
    ENTER DB 'ENTER THE VALUE : $' 
    ENTER2 DB 'CAPITAL VALUE : $'
.CODE 
MAIN PROC  
     
    MOV AX,@DATA 
    MOV DS,AX
    ;displaay prompt
    LEA DX,ENTER
    MOV AH,9
    INT 21H
    ;input
    MOV AH,1
    INT 21H
    MOV BL,AL 
    SUB BL,'a' 
    ADD BL,'A'
    ;goto newline
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H 
    ;displaay prompt
    LEA DX,ENTER2
    MOV AH,9
    INT 21H
    ;Display Charecter 
    MOV AH,2
    MOV DL,BL
    INT 21H
    
    ;Return in BIOS
    MOV AH,4CH
    INT 21H 
    
MAIN ENDP
    END MAIN
    