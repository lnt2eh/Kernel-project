# Projeto Kernel Personalizado

## Visão Geral
Este projeto visa criar um kernel simples do zero, cobrindo conceitos como gerenciamento de memória, interrupções, drivers de dispositivos e sistema de arquivos. O foco é aprender sobre sistemas operacionais e como eles interagem diretamente com o hardware.

## Funcionalidades
- Bootloader personalizado
- Gerenciamento básico de memória
- Manipulação de interrupções
- Drivers para teclado e VGA
- Suporte inicial a sistema de arquivos

## Estrutura do Projeto
- `/boot`: Código do bootloader
- `/kernel`: Código-fonte principal do kernel
- `/drivers`: Drivers de dispositivos
- `/lib`: Funções utilitárias
- `/docs`: Documentação do projeto

## Instruções de Compilação
1. Instale ferramentas: `nasm`, `gcc`, `ld`, `qemu`.
2. Monte o bootloader: `nasm -f bin bootloader.asm -o bootloader.bin`.
3. Compile o kernel: `gcc -ffreestanding -m32 -c kernel.c -o kernel.o`.
4. Linke o kernel: `ld -o kernel.bin -Ttext 0x1000 --oformat binary kernel.o`.
5. Crie a imagem do disco: `cat bootloader.bin kernel.bin > os-image.bin`.
6. Execute no QEMU: `qemu-system-x86_64 -drive format=raw,file=os-image.bin`.
