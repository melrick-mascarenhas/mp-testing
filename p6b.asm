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
	mov ah,9
	lea dx,l
	int 21h
	endm

exit macro
	mov ah,4ch
	int 21h
	endm
.data
	pb equ 1191h
	pc equ 1192h
	cr equ 1193h

	codes db 0c0h,0f9h,0a4h,0b0h,99h,92h,82h,0f8h,80h,90h

	msg1 db 30 dup(0ffh)
	num dw 0ffffh

.code
	mov ax,@data
	mov ds,ax

	mov al,80h
	mov dx,cr
	out dx,al

	call convert
	mov cx,11
	lea si,msg1
	add si,3

again: push cx
		push si
		mov cx,4
nextbit:
		call display
		dec si
		dec cx
		jnz nextbit
		call delay
		pop si
		pop cx
		inc si
		dec cx
		jnz again


		mov cx,11
		lea si,msg1
		add si,10
nextbit1:
		call display
		call delay
		dec si
		dec cx
		jnz nextbit1

		exit



convert proc
	lea si,msg1
	add si,8
	mov ax,num
fill:
	mov dx,0
	mov bx,10
	div bx
	mov bx,dx
	mov bl,codes[bx]
	mov [si],bl
	dec si
	cmp ax,0
	jnz fill
	ret
convert endp


display proc
	mov bl,8
	mov al,[si]
nxt:
	rol al,1
	outpb
	push ax
	mov al,00h
	outpc
	mov al,01h
	outpc
	pop ax
	dec bl
	jnz nxt
	ret
display endp


delay proc
	push cx
	push bx
	mov cx,055ffh
outer:
	mov bx,0ffffh
inner:
	dec bx
	jnz inner
	loop outer
	pop bx
	pop cx
	ret
delay endp
end				