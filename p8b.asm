; stepper motor

.model small
	outpa macro
		mov dx,pa
		out dx,al
	endm
exit macro
		mov ah,4ch
		int 21h
		endm

.data
	pa equ 1190h
	pb equ 1191h
	cr equ 1193h

.code
	mov ax,@data
	mov ds,ax

	mov al,82h
	mov dx,cr
	out dx,al

	mov al,88h
	mov cx,200

rotate:
	outpa
	call delay
	ror al,01
	dec cx
	jnz rotate

	exit

delay proc
	push ax
	push cx
	mov ax,0cffh
outer:
	mov cx,0ffffh
inner:
	dec cx
	jnz inner
	dec ax
	jnz outer
	pop cx
	pop ax
	ret
delay endp
end