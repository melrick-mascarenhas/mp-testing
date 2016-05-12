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

	m1 db 10,13,"any key to exit:$"
	fire db 8eh,0cfh,0afh,86h
	help db 89h,86h,0c7h,8ch

.code
	mov ax,@data
	mov ds,ax
	mov al,80h
	mov dx,cr
	out dx,al

	printf m1

start:
	lea si,fire
	call disp
	call delay
	lea si,help
	call disp
	call delay
	mov ah,1
	int 16h
	jz start
	exit


disp proc
	mov cx,4
next_char:
	mov bl,8
	mov al,[si]
nextbit:
	rol al,1
	outpb
	push ax
	mov al,00h
	outpc
	mov al,11h
	outpc
	pop ax
	dec bl
	jnz nextbit
	inc si
	loop next_char
	ret
	disp endp


delay proc
	mov bx,0fffh
b2:
	mov cx,0ffffh
b1:
	loop b1
	dec bx
	jnz b2
	ret
	delay endp

	end
