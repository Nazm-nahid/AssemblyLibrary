.MODEL SMALL
.STACK 100H
.DATA  
    INPUT DB "ENTER THE INPUT: $"
    OUTPUT DB "ASCII VALUE : $"
    OUTPUT2 DB "POP COUNT: $" 
    COUNT DW ?
.CODE
MAIN PROC  
    
    MOV AX,@DATA
    MOV DS,AX 
      
    MOV AH,9 
    LEA DX,INPUT
    INT 21H
      
    MOV AH,1
    INT 21H 
    
    MOV BL,AL
    
    MOV AH,2
    MOV DL,0DH
    INT 21H
    
    MOV DL,0AH
    INT 21H 
     
    
    
    MOV AH,9
    LEA DX,OUTPUT 
    INT 21H
             
    MOV AH,2 
    MOV COUNT,0
    MOV CX,8
    
    PRINT:
        SHL BL,1  
        JNC CASEZERO
             MOV DL,'1'
             INT 21H  
             ADD COUNT,1
             
             JMP ENDCASE
             
             CASEZERO:
             MOV DL,'0'
             INT 21H
         ENDCASE:  
            
    LOOP PRINT
    
    MOV AH,2
    MOV DL,0DH
    INT 21H
    
    MOV DL,0AH
    INT 21H
    
    MOV AH,9
    LEA DX,OUTPUT2 
    INT 21H
        
    MOV AH,2
    MOV DX,COUNT 
    OR DX,'0'
    INT 21H
    
    
    
    MOV AH,4CH
    INT 21H
    
MAIN ENDP
  END MAIN