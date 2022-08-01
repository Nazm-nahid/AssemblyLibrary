.MODEL SMALL
.STACK 100H
.DATA  
    Array DB 10,40,20,30,34,25,50,40,35,28,11,44
    Avg DB ? 
    count DB ?  
    MSG1 DW "Avarage : $"
    MSG2 DW "Index of upper avarage : $" 
    MSG3 DW "VALUE of upper avarage : $"
 
.CODE
MAIN PROC   
        
    MOV AX,@DATA
    MOV DS,AX  
    
    CALL AVARAGE
    
    
    PUSH AX
    MOV AH,9
    LEA DX,MSG1
    INT 21H 
    POP AX
    
    CALL DECOUT 
    
    PUSH AX  
    
    MOV AH,2
    MOV DL,0DH
    INT 21H
    
    MOV DL,0AH
    INT 21H
     
    MOV AH,9
    LEA DX,MSG2
    INT 21H 
    
    POP AX
    
    CALL COMPIRE 
    
    PUSH AX  
    
    MOV AH,2
    MOV DL,0DH
    INT 21H
    
    MOV DL,0AH
    INT 21H
     
    MOV AH,9
    LEA DX,MSG3
    INT 21H 
    
    POP AX 
    
    CALL COMPIREARRAY
         
    MOV AH,4CH
    INT 21H
    
MAIN ENDP  

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

COMPIRE PROC 
    
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    MOV CX,12
     
    MOV count,0  
    XOR BX,BX 
    LEA SI,Array
    
    MOV AH,2
    
    PRINTINDEX:
        
        MOV BL,[SI] 
        INC count 
        INC SI  
        
        CMP BL,Avg
        JLE END_PRINT 
        
         PUSH AX  
         XOR AX,AX
         MOV AL,count 
         CALL DECOUT
         POP AX 
         
         MOV DL,' '
         INT 21H
         
         
         
        
        END_PRINT:
        LOOP PRINTINDEX 
                 
       
    POP DX
    POP CX
    POP BX
    POP AX
    
    RET 
        
COMPIRE ENDP  

COMPIREARRAY PROC 
    
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    MOV CX,12
     
 
    XOR BX,BX 
    LEA SI,Array
    
    MOV AH,2
    
    PRINTVALUE:
        
        MOV BL,[SI]
        INC SI  
        
        CMP BL,Avg
        JLE END_PRINTVALUE 
        
         PUSH AX  
         XOR AX,AX
         MOV AL,BL 
         CALL DECOUT
         POP AX 
         
         MOV DL,' '
         INT 21H
         
         
         
        
        END_PRINTVALUE: 
        LOOP PRINTVALUE 
                 
       
    POP DX
    POP CX
    POP BX
    POP AX
    
    RET 
        
COMPIREARRAY ENDP  

DECOUT PROC 
    
    PUSH AX 
    PUSH BX
    PUSH CX
    PUSH DX
    
    
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
    POP CX
    POP BX
    POP AX 
    
    
    
    RET 
        
DECOUT ENDP  



  END MAIN