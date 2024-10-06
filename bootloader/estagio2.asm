;---------------------------------------------------------------------------------------
; Implementação do segundo estágio
; Este código ainda está sendo desenvolvido
; Função: Carregamento da GDT com NULL Descriptor, transição de modo para modo protect
; --------------------------------------------------------------------------------------

bits 16
org 0x7c00

section .text

switch_to_pm:
    cli
    lgdt [gdt_descriptor]
    mov eax, cr0
    or eax, 0x1
    mov cr0, eax
    jmp CODE_SEG:init_pm

[bits 32]

init_pm:
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    
    mov ebx, 0xB8000
    mov cx, 2000
    mov al, ' '
    mov ah, 0x07
limpar:
    mov word [ebx], ax
    add ebx, 2
    loop limpar

    mov ebx, 0xB8000
    mov esi, kernel_string
print_kernel_msg:
    lodsb
    test al, al
    jz done
    mov ah, 0x07
    mov [ebx], ax
    add ebx, 2
    jmp print_kernel_msg

done:
    jmp $

boot_msg db 'Inicializando sistema', 0
kernel_string db 'Carregando Kernel', 0

gdt_start:
    dq 0x0

gdt_code:
    dw 0xFFFF
    dw 0x0
    db 0x0
    db 10011010b
    db 11001111b
    db 0x0

gdt_data:
    dw 0xFFFF
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

print_string:
    mov ah, 0x0e
print_loop:
    lodsb
    test al, al
    jz end_print
    int 0x10
    jmp print_loop

end_print:
    ret

times 510-($-$$) db 0
db 0x55, 0xAA
