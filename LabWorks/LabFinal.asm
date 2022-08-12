.MODEL SMALL
.STACK 100H
.DATA  
    STRING DB 80 DUP(0)
    ARRAY DB 20 DUP(?)  
    CRLF DB 0DH,0AH,'$' 
    CRLF2 DB 0DH,0AH,'- $'
    MSG1 DB "Enter your name in small letter: $"  
    MSG2 DB "Name in Capital Letter : $"   
    MSG3 DB "Enter your CT marks of Course CSE 3109 in an array.  : $"  
    MSG4 DB "Enter last three digit of your roll: $"  
    
    CS1 DB "Case $"
    CS2 DB " Activated !!$"  
    
    CSM1 DB "YOUR NAME IS PALINDROM!! $"
    CSM2 DB "YOUR ROLL IS PALINDROM !! $ "
    
    CSM3 DB "BEST 3 CT AVARAGE : $ " 
    
    CSM4 DB "MAXIMUM MARKS : $ "
    CSM5 DB "MINIMUM MARKS : $ "
    
    
    N DB 0
    VAL DB ? 
    MAX DB 0 
    MIN DB 20
    SUM DB 0
    AVG DB 0 
    PALINDROM_FLAG DB 0 
    STRINGSIZE DB 0
    
.CODE
MAIN PROC   
        
    MOV AX,@DATA
    MOV DS,AX 
    MOV ES,AX  
    
    LEA DI,STRING 
    
    MOV AH,9
    LEA DX,MSG1
    INT 21H
    
    LEA DX,CRLF2
    MOV AH,9
    INT 21H
    
    CALL READ_NAME
    
    LEA DX,CRLF
    MOV AH,9
    INT 21H
    

    MOV AH,9
    LEA DX,MSG2
    INT 21H 
    
    LEA DX,CRLF2
    MOV AH,9
    INT 21H
     
    CALL DISPLAY_CAPITALIZE_NAME     
    
    
    LEA DX,CRLF
    MOV AH,9
    INT 21H
    

    MOV AH,9
    LEA DX,MSG3
    INT 21H 
    
    LEA DX,CRLF2
    MOV AH,9
    INT 21H   
    
    CALL INPUT_ARRAY 
    
    LEA DX,CRLF
    MOV AH,9
    INT 21H
    

    MOV AH,9
    LEA DX,MSG4
    INT 21H 
    
    LEA DX,CRLF2
    MOV AH,9
    INT 21H  
    
    CALL DEC_INPUT 
    
    XOR AX,AX 
    XOR DX,DX
    MOV AL,VAL
    
    MOV BX,3
    
    DIV BX
    
    CMP DX,0
    JE CASE1
    CMP DX,1
    JE CASE2
    JMP CASE3
    
    
    
    CASE1:  
        LEA DX,CRLF
        MOV AH,9
        INT 21H
        
    
        MOV AH,9
        LEA DX,CS1
        INT 21H
        MOV AH,2
        MOV DX,'1'
        INT 21H 
        MOV AH,9
        LEA DX,CS2
        INT 21H
        
        LEA DX,CRLF2
        MOV AH,9
        INT 21H  
        
        CALL CHECK_PALINDROM
        
        CMP PALINDROM_FLAG,0 
        JE NEX
        MOV AH,9
        LEA DX,CSM1
        INT 21H
        
        NEX:
        
        JMP RETURN_BIOS
    
    CASE2: 
        LEA DX,CRLF
        MOV AH,9
        INT 21H
        
    
        MOV AH,9
        LEA DX,CS1
        INT 21H
        MOV AH,2
        MOV DX,'2'
        INT 21H 
        MOV AH,9
        LEA DX,CS2
        INT 21H
        
        LEA DX,CRLF2
        MOV AH,9
        INT 21H 
        CALL CALCULATE_MIN
        CALL CALCULATE_SUM 
        
        CALL CALCULATE_BEST3_AVERAGE  
        
        LEA DX,CSM3 
        INT 21H
        
        XOR BX,BX 
        MOV BL,AVG
        CALL DECOUT
       
       JMP RETURN_BIOS
    CASE3: 
        LEA DX,CRLF
        MOV AH,9
        INT 21H
        
    
        MOV AH,9
        LEA DX,CS1
        INT 21H
        MOV AH,2
        MOV DX,'3'
        INT 21H 
        MOV AH,9
        LEA DX,CS2
        INT 21H
        
        LEA DX,CRLF2
        MOV AH,9
        INT 21H 
        
        
        LEA DX,CSM5 
        INT 21H 
        
        CALL CALCULATE_MIN
        
        XOR BX,BX 
        MOV BL,MIN
        CALL DECOUT 
        
        LEA DX,CRLF2 
        INT 21H
        
        LEA DX,CSM4 
        INT 21H 
        
        CALL CALCULATE_MAX
        
        XOR BX,BX 
        MOV BL,MAX
        CALL DECOUT
    
    
    
    ;CALL OUTPUT_ARRAY 
    
    ;CALL CALCULATE_MIN
    
    ;CALL CALCULATE_MAX 
    
    ;CALL CALCULATE_SUM 
    
    ;
    
    RETURN_BIOS:
       
    MOV AH,4CH
    INT 21H
    
MAIN ENDP  

READ_NAME PROC 
    PUSH AX
    PUSH DI
    CLD
    XOR BX,BX
    
    MOV AH,1
    INT 21H
    
    WHILE1:
        CMP AL,0DH 
        JE END_WHILE1
         
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
        
        ADD STRINGSIZE,1
        JMP WHILE1
    END_WHILE1:
        POP DI
        POP AX
        
        RET
    
READ_NAME ENDP

DISPLAY_CAPITALIZE_NAME PROC 
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    
    LEA SI,STRING  
    
    MOV CX,BX
    
    JCXZ P_EXIT
    
    
    MOV AH,2 
    CLD
    TOP:
       
    LODSB
    MOV DL,AL 
    SUB DL,20H
    INT 21H 
    LOOP TOP
    
    P_EXIT:
    
    
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    
    RET

DISPLAY_CAPITALIZE_NAME ENDP

CHECK_PALINDROM PROC 
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI  
    
    MOV PALINDROM_FLAG,1
    
    LEA SI,STRING  
    XOR BX,BX
    MOV BL,STRINGSIZE
    ADD SI,BX
    DEC SI
    
    LEA DI,STRING
    
    XOR AX,AX
    MOV AL,STRINGSIZE
    MOV BX,2 
    XOR DX,DX
    DIV BX
    MOV CX,AX
    
    JCXZ P1_EXIT
    
    TOP1:
    MOV AL,[SI]
    MOV BL,[DI] 
    
    CMP AL,BL
    JE ENDTOP
    MOV PALINDROM_FLAG,0
    ENDTOP: 
    INC DI
    DEC SI 
    
    LOOP TOP1
    
    P1_EXIT:
    
    
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    
    RET

CHECK_PALINDROM ENDP

CALCULATE_MIN PROC
    PUSH AX
    PUSH CX
    PUSH DX
    PUSH SI
    
    LEA SI,ARRAY  
    
    MOV CX,4

    WHILE:
       MOV BL,[SI] 
       CMP BL,MIN
       JG END_WHILE
       MOV MIN,BL 
       END_WHILE: 
       INC SI
       LOOP WHILE
    POP SI
    POP DX
    POP CX
    
    POP AX
    
    RET
CALCULATE_MIN ENDP 

CALCULATE_MAX PROC
    PUSH AX
    PUSH CX
    PUSH DX
    PUSH SI
    
    LEA SI,ARRAY  
    
    MOV CX,4

    WHILE2:
       MOV BL,[SI] 
       CMP BL,MIN
       JL END_WHILE2
       MOV MAX,BL 
       END_WHILE2: 
       INC SI
       LOOP WHILE2
    POP SI
    POP DX
    POP CX
    
    POP AX
    
    RET
CALCULATE_MAX ENDP 

CALCULATE_SUM PROC
    PUSH AX
    PUSH CX
    PUSH DX
    PUSH SI
    
    LEA SI,ARRAY  
    
    MOV CX,4

    WHILE3:
       MOV BL,[SI]
       ADD SUM,BL 
       INC SI
       LOOP WHILE3
    POP SI
    POP DX
    POP CX
    
    POP AX
    
    RET
CALCULATE_SUM ENDP

CALCULATE_BEST3_AVERAGE PROC
    PUSH AX
    PUSH CX
    PUSH DX
    PUSH SI
    
    XOR AX,AX
    MOV AL,SUM 
    SUB AL,MIN 
    XOR DX,DX
    MOV BX,3
    DIV BX  
    MOV AVG,AL
    
    POP SI
    POP DX
    POP CX
    
    POP AX
    
    RET
CALCULATE_BEST3_AVERAGE ENDP  





INPUT_ARRAY PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    
    LEA SI,ARRAY  
    
    MOV CX,4

    LOOPING:
       CALL DEC_INPUT 
       XOR AX,AX
       MOV AL,VAL
       MOV [SI],AX
       INC SI 
       LOOP LOOPING
    
    
    
    
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    
    RET
INPUT_ARRAY ENDP  

DEC_INPUT PROC 
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI 
    
    XOR DL,DL ;DL=0
    
    FOR:
        MOV AH,1
        INT 21H 
        CMP AL,0DH
        JE END_FOR 
        CMP AL,','
        JE END_FOR
        
        SUB AL,'0'
        MOV N,AL   ;N=AL
        MOV AL,10  ;AL=10
        MUL DL     ;AL=AL*DL
        ADD AL,N   ;AL+=N
        MOV DL,AL  ;DL=AL
        JMP FOR 
        
        END_FOR:
        
        MOV VAL,DL ;VAL=DL
    
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    
    RET
DEC_INPUT ENDP 

OUTPUT_ARRAY PROC
    PUSH AX
    PUSH CX
    PUSH DX
    PUSH SI
    
    LEA SI,ARRAY  
    
    MOV CX,4

    LOOPING1: 
       XOR BX,BX
       MOV BL,[SI] 
       CALL DECOUT 
       INC SI
         
       MOV AH,2
       MOV DL,' '
       INT 21H
       
       LOOP LOOPING1
    
    
    
    
    POP SI
    POP DX
    POP CX
    
    POP AX
    
    RET
OUTPUT_ARRAY ENDP 

DECOUT PROC 
    
    PUSH AX 
    PUSH BX
    PUSH CX
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