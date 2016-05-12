.MODEL SMALL
.STACK
.DATA
        PA EQU 01190H
        PB EQU 01191H
        PC EQU 01192H
        CR EQU 01193H
.CODE
START:  MOV AX,@DATA
        MOV DS,AX
        MOV DX,CR
        MOV AL,82H
        OUT DX,AL
        MOV BL,00H
        MOV BH,01H
AGAIN:  MOV DX,PB
        IN AL,DX
        CMP AL,0FFH
        JZ UP
        CMP AL,0FEH
        JZ DOWN
        MOV AH,4CH
        INT 21H
UP:     MOV AL,BL
        CALL DISP
        ADD AL,01H
        DAA
        MOV BL,AL
        JMP AGAIN
DOWN:   MOV AL,BL
        CALL DISP
        SUB AL,01
        DAS
        MOV BL,AL
        JMP AGAIN
DISP:   MOV DX,PA
        OUT DX,AL
        CALL DELAY
        RET
DELAY:  MOV SI,055FFH  
LOOP1:  MOV DI,0FFFFH
LOOP2:  DEC DI
        JNZ LOOP2
        DEC SI
        JNZ LOOP1
        RET
        END START