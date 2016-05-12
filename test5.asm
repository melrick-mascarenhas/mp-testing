.MODEL SMALL
.STACK
.DATA
        PA EQU 01190H
        PB EQU 01191H
        PC EQU 01192H
        CR EQU 01193H
        CLEAR DB 0FFH,0FFH,0FFH,0FFH
        FIRE DB 61H,11H,9FH,71H,01H,11H,9FH,71H,61H,11H,9FH,71H
        N DB 10H
.CODE
START:  MOV AX,@DATA
        MOV DS,AX
        MOV DX,CR
        MOV AL,80H
        OUT DX,AL
        MOV AL,00H
        MOV DX,PC
        OUT DX,AL
        LEA BX,CLEAR
        MOV SI,03H
        CALL DISW
        CALL DELAY
        LEA BX,FIRE
        MOV SI,0BH
        CALL DISW
        MOV AH,4CH
        INT 21H
DISW:   MOV AH,[BX][SI]
        CALL DISP
        CALL DELAY
        DEC SI
        JNS DISW
        RET
DISP:   MOV CL,08H
BACK:   MOV DX,PB
        MOV AL,AH
        OUT DX,AL
        MOV DX,PC
        MOV AL,01H
        OUT DX,AL
        MOV AL,00H
        OUT DX,AL
        ROR AH,01H
        DEC CL
        JNZ BACK
        RET
DELAY:  MOV SI,0FFFFH
BACK2:  MOV DI,0FFFFH
BACK3:  DEC DI
        JNZ BACK3
        DEC SI
        JNZ BACK2
        RET
        END START