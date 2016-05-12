.MODEL SMALL
.STACK
.DATA
        PA EQU 01190H
        PB EQU 01191H
        PC EQU 01192H
        CR EQU 01193H
        FIRE DB 61H,11H,9FH,71H
        HELP DB 31H,0E3H,61H,91H
        N DB 05H
.CODE
START:  MOV AX,@DATA
        MOV DS,AX
        MOV DX,CR
        MOV AL,80H
        OUT DX,AL
        MOV AL,00H
        MOV DX,PC
        OUT DX,AL
AGAIN:  LEA BX,FIRE
        CALL DISW
        CALL DELAY
        LEA BX,HELP
        CALL DISW
        CALL DELAY
        DEC N
        JNZ AGAIN
        MOV AH,4CH
        INT 21H
DISW:   MOV SI,03H
AGN:    MOV AH,[BX][SI]
        CALL DISP
        DEC SI
        JNS AGN
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