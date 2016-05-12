.model small
.stack
.data
        PA EQU 01190H
        PB EQU 01191H
        PC EQU 01192H
        CR EQU 01193H
	table db 80h,96h,0abh,0c0h,0d2h,0e2h,0eeh,0f8h,0feh,0ffh,
		  0feh,0f8h,0eeh,0e2h,0d2h,0c0h,0abh,96h,80h,
		  69h,54h,3fh,2dh,1dh,1dh,11h,07h,01h,00h,
		  01h,07h,011h,1dh,2dh,3fh,54h,69h
	count equ 36d
.code
	mov ax,@data
	mov ds,ax
	mov dx,CR
	mov al,80h
	out dx,al
lp1:    lea si,table
        mov cx,count
lp2:    mov dx,PA
        mov al,[si]
        out dx,al
        inc si
        call delay
        loop lp2
        mov ah,01h
        int 16h
        jz lp1
        mov ah,4ch
        int 21h
        delay proc
        mov ax,0ffffh
lp3:    dec ax
        jnz lp3
	ret
  	delay endp
  	end