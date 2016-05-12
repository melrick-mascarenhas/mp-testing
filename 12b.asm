.model small
inpb macro
	mov dx,pb 
	in al,dx
	endm
outpc macro
	mov dx,pc
	out dx,al
	endm

outpa macro
	mov dx,pa
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
	floor db 00h,03h,06h,09h,0e0h,0d3h,0b6h,79h

.code
mov ax,@data
	mov ds,ax
	mov al,82h
	mov dx,cr
	out dx,al
start:
	printf m1
	mov bl,0
initial:
	mov al,bl
	or al,0f0h
	outpa
	lea si,floor
floorinput:
	call kbhit
	inpb
	or al,0f0h
	jz floorinput
	mov al,cl
	sub al,0feh
	jz reset


floorcheck:
	mov al,cl
	ror al,1
	mov cl,al
	jnc decide
	inc si
	jmp floorcheck
decide:
	call delay
	mov al,[si]
	sub al,bl
	jz reset
up:
	inc bl
	mov al,bl
	or al,0f0h
	outpa
	jmp decide

reset:
	add si,4
	mov al,[si]
	outpa
down1:
	call delay
	mov al,bl
	or al,0f0h
	outpa
	dec bl
	cmp bl,-1
	jz start
	jnz down1
	jmp initial


kbhit proc
	mov ah,1
	int 16h
	jnz done
	ret
done:
	exit
	kbhit endp


delay proc
	push cx
	push bx
	mov bx,0fffh
b2:
	mov cx,0ffffh
b1:
	loop b1
	dec bx
	jnz b2
	pop bx
	pop cx
	ret
	delay endp

	end	


