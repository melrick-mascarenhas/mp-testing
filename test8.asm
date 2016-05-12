.MODEL SMALL
.STACK
.DATA
        PA EQU 01190H
        PB EQU 01191H
        PC EQU 01192H
        CR EQU 01193H
        N1 DB 48
        MSG DB "MOTOR IS ROTATING IN CLOCKWISE DIRECTION",10,13,"$"
.CODE
START:  MOV AX,@DATA
        MOV DS,AX
        LEA DX,MSG
        MOV AH,09H
        INT 21H
        MOV DX,CR
        MOV AL,80H
        OUT DX,AL
        MOV BL,N1
        MOV AL,88H
        MOV DX,PA
BACK:   OUT DX,AL
        CALL DELAY
        ROR AL,01H
        DEC BL
        JNZ BACK
        MOV AH,4CH
        INT 21H
DELAY PROC
        MOV SI,055FFH
LOOP1:  MOV DI,0FFFFH
LOOP2:  DEC DI
	JNZ LOOP2
        DEC SI
        JNZ LOOP1
        RET
        DELAY ENDP
        END START