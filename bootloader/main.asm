bits 16

; 0x7c00 is the address where this bootloader is called.	
org 0x7c00

start:
	; cs = 0000:7c00
	push cs ; Assuming CS is 0
	pop ds
	mov bx,string

repeat:
	mov al,[bx]
	test al,al
	je end
	push bx
	mov ah,0x0e
	mov bx,0x000f
	int 0x10
	pop bx
	inc bx
	jmp repeat

end:
	jmp $


string:
	db "Hello World",0

	times 510-($-$$) db 0 ; fills the rest of bootloader with zeros.

	db 0x55, 0xaa ; Signature so BIOS detects it as bootable.
