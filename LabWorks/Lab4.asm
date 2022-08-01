.MODEL SMALL
.STACK 100H
.DATA  

.CODE
MAIN PROC   
        
    MOV CX,11
    MOV AX,1
    MOV BX,0
    
    SUM:
        ADD BX,AX   
        ADD AX,2
        
        LOOP SUM 
    
    
    MOV AH,4CH
    INT 21H
    
MAIN ENDP
  END MAIN