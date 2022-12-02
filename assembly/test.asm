section .data
    line db "Whatever the fak",10
    lineLength equ $-line

section .text
global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, line
    mov edx, lineLength
    int 80h

    mov eax, 1
    mov ebx, 0
    int 80h