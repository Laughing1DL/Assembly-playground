.286
stack1 segment stack
    db 64 DUP(0)
stack1 ends

data segment
    ; Coordenadas actuales
    PositionY db 12    ; Empezar en medio (fila)
    PositionX db 40    ; Empezar en medio (columna)
    
    ; El caracter que será nuestro "cursor"
    ; Usamos el ASCII 219 (bloque sólido) o 'X'
    char db 219 
data ends

code segment
    assume ss:stack1, ds:data, cs:code
main proc far
    ; Inicializar segmento de datos
    mov ax, data
    mov ds, ax

ResetScreen:
    ; Poner la consola en modo texto y limpiar (Modo 03h)
    mov ah, 00h
    mov al, 03h
    int 10h

GameLoop:
    ; Limpiar el rastro anterior (Opcional)
    ; Para que no se "pinte" toda la pantalla, refrescamos la posición
    ; En este caso, simplemente re-imprimimos el fondo o movemos el cursor
    
    ; Posicionar el cursor físico en las coordenadas actuales
    mov ah, 02h
    mov bh, 00h
    mov dh, PositionY
    mov dl, PositionX
    int 10h

    ; Imprimir el "cursor" de color ROJO
    ; Usamos la función 09h de la INT 10h (Escribir caracter y atributo)
    mov ah, 09h
    mov al, char      ; Caracter a imprimir
    mov bh, 00h       ; Página 0
    mov bl, 0Ch       ; ATRIBUTO: 0 = Fondo Negro, C = Rojo Claro
    mov cx, 01h       ; Cuántas veces imprimirlo
    int 10h

    ; Leer teclado sin eco (esperar input)
    mov ah, 08h
    int 21h

    ; Lógica de movimiento (WASD)
    ; Comparamos AL (tecla presionada) y saltamos
    cmp al, 'w'
    je Arriba
    cmp al, 's'
    je Abajo
    cmp al, 'a'
    je Izquierda
    cmp al, 'd'
    je Derecha
    cmp al, 27        ; Tecla ESC para salir
    je Salir
    
    jmp GameLoop      ; Si es otra tecla, ignorar y repetir

Arriba:
    cmp PositionY, 0
    je GameLoop
    dec PositionY
    jmp BorrarYRefrescar

Abajo:
    cmp PositionY, 24
    je GameLoop
    inc PositionY
    jmp BorrarYRefrescar

Izquierda:
    cmp PositionX, 0
    je GameLoop
    dec PositionX
    jmp BorrarYRefrescar

Derecha:
    cmp PositionX, 79
    je GameLoop
    inc PositionX
    jmp BorrarYRefrescar

BorrarYRefrescar:
    ; esta es una recomendación que encontre para evitar el rastro que sea visible

    mov ah, 00h
    mov al, 03h
    int 10h
    jmp GameLoop

Salir:
    mov ax, 4C00h
    int 21h
main endp
code ends
end main
