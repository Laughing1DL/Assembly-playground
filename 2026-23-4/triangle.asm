.286
stack1 segment stack
    db 32 DUP(0)
stack1 ends

data segment
    star db "*$"
    newline db 13,10,"$"
data ends

code segment
main proc FAR
    assume ss:stack1, ds:data, cs:code

    mov ax, data
    mov ds, ax

    mov cx, 6      ; número de filas
    mov si, 1      ; empieza con 1 estrella

outer_loop:
    push cx        ; guardar contador de filas

    mov bx, si     ; número de estrellas actuales

inner_loop:
    mov ah, 09h
    lea dx, star
    int 21h

    dec bx
    jnz inner_loop

    ; salto de línea
    mov ah, 09h
    lea dx, newline
    int 21h

    inc si         ; siguiente fila tiene +1 estrella

    pop cx
    loop outer_loop

; -------- EXIT --------
    mov ah, 4Ch
    int 21h

main endp
code ends
end main
