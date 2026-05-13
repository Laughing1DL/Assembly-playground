.286
stack1 segment stack
    db 32 DUP(0)
stack1 ends

data segment
    text db "Hola mundo!$"
    ; Define your positions here
    PositionY db 0
    PositionX db 0
data ends

code segment
    assume ss:stack1, ds:data, cs:code
main proc far

movementsec:

    lea PositionX
    mov ah, 09h
    int 21h

    lea PositionY
    mov ah, 09h
    int 21h

clearscreen:

    ; Initialize Data Segment
    mov ax, data
    mov ds, ax

    ; Poner la consola en modo texto
    mov ah, 00h
    mov al, 03h
    int 10h

    ; Window clearing
    mov ah, 06h
    mov al, 00h    ; 00 = Clear entire window
    mov bh, 0ch    ; Change color 
    mov cx, 0000h  ; Based on the ch and cl putting the 0000h means that we want (0,0) cods
    mov dx, 184Fh ; same as before but instead of using dl and dh we use both with dx
    int 10h

    ; Movement and coordinates section 
    mov ah, 02h
    mov bh, 00h
    mov dh, PositionY
    mov dl, PositionX
    int 10h

    mov ah, 09h
    lea dx, text
    int 21h

    ; 5. DOS Terminate Function (VERY IMPORTANT)
    mov ax, 4C00h
    int 21h
main endp
code ends
end main
