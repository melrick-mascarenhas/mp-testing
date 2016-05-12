.model small
	outpb macro
	mov dx,pb
	out dx,al
	endm

outpc macro
	mov dx,pc
	out dx,al
	endm

	printf macro l
		lea dx,l
		mov ah,9
		int 21h
		endm

exit macro
	mov ah,4ch
	int 21h
	endm

.data
	pa equ 1190h
	pb equ 1191h
	cr equ 1193h
	pc equ 1192h

	m1 db 10,13,"enter key to exit$"
	txt db 80h,88h,90h,80h,0f8h,82h,92h,99h,0b0h,0a4h,0f9h,0c0h

.code
	mov ax,@data
	mov ds,ax

	mov al,80h
	mov dx,cr
	out dx,al

start:
	lea si,txt
	mov cx,12
next_char:
	mov al,[si]
	call dispchar
	call delay
	call kbhit
	inc si
	loop next_char
	jmp start

kbhit proc 	
	mov ah,1
	int 16h
	jnz done
done:
	exit
	kbhit endp

dispchar proc
	mov bl,8
nxtbit:
	rol al,1
	outpb
	push ax
	mov al,00h
	outpc
	mov al,01h
	outpc
	pop ax
	dec bl
	jnz nxtbit
	ret
	dispchar endp


delay proc
	mov bx,07ffh
b2:
	mov di,0ffffh
b1:
	dec di
	jnz b1
	dec bx
	jnz b2
	ret
	delay endp

	end
