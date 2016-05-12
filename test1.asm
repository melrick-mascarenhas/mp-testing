.MODEL SMALL
.STACK
.DATA
        PA EQU 01190H
        PB EQU 01191H
        PC EQU 01192H
        CR EQU 01193H
        M1 DB "NO OF 1S =",13,10,"$"
        M2 DB "PRESS Q TO QUIT ANY OTHER TO CONTINUE",13,10,"$"
.CODE
START:  MOV AX,@DATA
        MOV DS,AX
        MOV DX,CR
        MOV AL,82H
        OUT DX,AL
BACK:   MOV DX,PB
        IN AL,DX
        MOV BL,00H
        MOV CL,08H
AGAIN:  ROR AL,01H
        JNC NEXT
        INC BL
NEXT:   DEC CL
        JNZ AGAIN
        MOV DX,PA
        TEST BL,01H
        JNZ ODD
        MOV AL,0FFH
        OUT DX,AL
        JMP EXIT
ODD:    MOV AL,00H
        OUT DX,AL
EXIT:   LEA DX,M1
        MOV AH,09H
        INT 21H
        ADD BL,30H
        MOV DL,BL
        MOV AH,02H
        INT 21H
	LEA DX,M2
        MOV AH,09H
        INT 21H
        MOV AH,07H
        INT 21H
        CMP AL,"Q"
        JNZ BACK
        MOV AH,4CH
        INT 21H
        END START