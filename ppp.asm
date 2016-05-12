.model small
	putchar macro l
		mov ah,2
		mov dl,l
		int 21h
		endm

.data
	n dw 5
	r dw 1	
	ncr dw 0

.code
	mov ax,@data
	mov ds,ax

	mov ax,n
	mov bx,r
	call ncrpro

	mov ax,ncr
	mov dx,ax
	call convdisp

	mov ah,4ch
	int 21h


ncrpro proc
	cmp bx,ax
	je r1
	cmp bx,0
	je r1
	cmp bx,1
	je rn
	dec ax
	cmp bx,ax
	je r2


	push ax
	push bx
	call ncrpro
	pop bx 
	pop ax

	dec ax
	push ax
	push bx
	call ncrpro
	pop bx 
	pop ax
	ret

r1:	inc ncr
	ret

r2:	inc ncr

rn:	add ncr,ax
	ret
ncrpro endp

convdisp proc
	;mov al,ncr
	aam
	add ax,3030h
	mov bx,ax
	putchar bh
	putchar bl
	mov ah,4ch
	int 21h
	ret
	convdisp endp	

end
