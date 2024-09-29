bits 16

; 0x7c00 is the address where this bootloader is called.	
org 0x7c00

start:
	jmp short entry 

;******************************************************
;	OEM Parameter block
;******************************************************


%define bsOemName 		bp+0x03
%define bsBytesPerSec		bp+0x0b
%define bsSecPerCluster		bp+0x0d
%define bsResSectors		bp+0x0e
%define bsFATs			bp+0x10
%define bsRootDirEnts		bp+0x11
%define bsSectors		bp+0x13
%define bsMedia			bp+0x15
%define sectPerFat		bp+0x16
%define sectPerTrack		bp+0x18
%define nHeads			bp+0x1a
%define nHidden			bp+0x1c
%define nSectorHuge		bp+0x20
%define drive			bp+0x24
%define extBoot			bp+0x26
%define volid			bp+0x27
%define vollabel		bp+0x2b
%define filesys			bp+0x36

msg db "Welcome to FenixOS",0

print:
	lodsb
	test al,al
	je printDone
	mov ah, 0xe
	int 0x10
	jmp print

printDone:
	ret
entry:
	xor ax,ax
	mov es,ax
	mov ds,ax
	
	mov si, msg
	call print
	cli   ; disable all interupts
	hlt

times 510-($-$$) db 0 ; fills the rest of bootloader with zeros.

db 0x55, 0xaa ; Signature so BIOS detects it as bootable.
