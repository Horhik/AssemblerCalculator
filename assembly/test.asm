%include "./assembly/include/ios.inc"

section .data
    line: db "Filling Array with Natural Numbers!", 10

section .bss
    array: resd 12

section .text
    global _start

_start:
    mov eax , line
    call sprintLF

; Filling array with numbers
    xor eax, eax
    mov edi, array
    mov ecx, 12
    cld ; forward direction
FillArrayLoop:
    inc eax
    stosd ; eax -> [edi], then edi += 1
    loop FillArrayLoop

; Printing out array's contents
    mov esi, array
    mov ecx, 12
    cld ; forward direction
ReadArrayLoop:
    lodsd ; [edi] -> eax, then edi -= 1
    call iprintLF
    loop ReadArrayLoop

_end:
    call quit