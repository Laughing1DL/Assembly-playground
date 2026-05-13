.286

stack1 segment stack
    db 64 DUP(0)
stack1 ends

data segment
    input1    db 50 dup(' ')
    len1      dw 0
    input2    db 50 dup(' ')
    len2      dw 0
    msgEqual  db 10,13, "Son iguales$"
    msgDiff   db 10,13, "Son diferentes$"
    EndLine db 10,13, "$"
data ends

code segment 'code'
main proc FAR
    assume ss:stack1, ds:data, cs:code

    ; Inicio del codigo
    mov ax, data
    mov ds, ax
    mov es, ax

    ; Input1 texto
    mov ah, 3fh
    mov bx, 00h
    mov cx, 50
    lea dx, input1
    int 21h
    sub ax, 2
    mov len1, ax ; Guardado de la logitud total


    ; Input2 texto 
    mov ah, 3fh
    mov bx, 00h
    mov cx, 50
    lea dx, input2
    int 21h
    sub ax, 2
    mov len2, ax ; Guardado de la longitud final 

   ; Tabla comparativa  de longitudes
    mov ax, len1
    cmp ax, len2 ; Comparación entre longitudes definidas
    jne No_es_igual ; Salto si no es equivalente 

    ; Tabla comparativa de resultados
    ; analisis por caracter disponible de assembly 
    lea si, input1
    lea di, input2
    mov cx, len1 ; Cuenta la cantidad de caracteres a comparar 
    cld ; Limpieza de flags 

    repe cmpsb ; Realiza la comparación si es que son iguales (Repeat Equal: repe)
    jne No_es_igual; SI en dado caso un caracter no es igual entonces salta a la linea de no igualdad

    ; Llegados a este punto todo caracter debe ser igual
    mov ah, 09h
    lea dx, msgEqual ;Simplemente imprime el texto remarcando la igualdad
    int 21h
    jmp End_code

No_es_igual:
    ; Impresión del texto de resultado en no equivalencia
    mov ah, 09h
    lea dx, msgDiff
    int 21h
    
    jmp End_code

End_code:
    ; Final del codigo
    mov ax, 4C00h
    int 21h
main endp
code ends
end main
