.MODEL SMALL
.STACK
.DATA
        PA EQU 01190H
        PB EQU 01191H
        PC EQU 01192H
        CR EQU 01193H
        M1 DB 10,13,"SELECT I/P X FROM LC AND PRESS KEY FROM KB$"
        M2 DB 10,13,"SELECT I/P Y FROM LC AND PRESS KEY FROM KB$"
        M3 DB 10,13,"LOWER ORDER BYTE OF RESULT (PRESS KEY FROM KB)$"
        M4 DB 10,13,"HIGHER ORDER BYTE OF RESULT (PRESS KEY FROM KB)$"
.CODE
START:  MOV AX,@DATA
        MOV DS,AX
        MOV DX,CR
        MOV AL,83H
        OUT DX,AL
        LEA DX,M1
	CALL WAIT
        MOV DX,PB
        IN AL,DX
        MOV BL,AL
        LEA DX,M2
	CALL WAIT
        MOV DX,PB
        IN AL,DX
        MUL BL
        MOV BH,AH
        MOV DX,PA
        OUT DX,AL
        LEA DX,M3
        CALL WAIT
        MOV DX,PA
        MOV AL,BH
        OUT DX,AL
        LEA DX,M4
        CALL WAIT
        MOV AH,4CH
        INT 21H
WAIT:   MOV AH,09H
        INT 21H
        MOV AH,07H
        INT 21H
        RET
        END START