.286
stack1 segment stack 
        db 32 DUP(0) 
stack1 ends

data segment
    numb1Sel db "Give me the first number: $"
    numb2Sel db 10,13,"Give me the second number: $"
    residMsg db 10, 13, "The residue is: $"
    resMsg   db 10, 13,"The result is: $"
    Number   db 0
    Number2  db 0
    Result   db 0
    Residue  db 0 
data ends

code segment 'code'
main proc FAR
    assume ss:stack1, ds:data, cs:code

    mov ax, data
    mov ds, ax

    ; --- Pedir primer número ---
    mov ah, 09h
    lea dx, numb1Sel
    int 21h

    mov ah, 01h      ; Captura carácter
    int 21h
    sub al, 30h      
    mov Number, al   ; Guardar en variable

    ; --- Pedir segundo número ---
    mov ah, 09h
    lea dx, numb2Sel
    int 21h

    mov ah, 01h      ; Captura carácter
    int 21h
    sub al, 30h      ; CONVERTIR DE ASCII A NÚMERO
    mov Number2, al  ; Guardar en variable

    ; --- División ---
    xor ax, ax
    mov al, Number
    mov cl, Number2
    div cl

    mov Result, al ;Movemos el resultado a el registro de la división
    mov Residue, ah ; Movemo el residuo al registro 

    ; --- Mostrar mensaje de resultado ---
    mov ah, 09h
    lea dx, resMsg
    int 21h

    mov dl, Result
    add dl, 30h     ; Convertir a ASCII
    mov ah, 02h      
    int 21h

    ; --- Mostrar residuo ---
    mov ah, 09h
    lea dx, residMsg
    int 21h

    mov dl, Residue
    add dl, 30h  ; Convierte de ASCII a numb
    mov ah, 02h
    int 21h

    ; --- Salida al DOS ---
    mov ah, 4Ch
    int 21h
main endp
code ends
end main
