# Cursor interactivo en Assembly x86 (DOS)

## Descripción

Este programa en Assembly x86 para DOS permite mover un bloque (`█`) por la pantalla usando las teclas:

- `W` → Arriba
- `S` → Abajo
- `A` → Izquierda
- `D` → Derecha
- `ESC` → Salir

El programa utiliza interrupciones del BIOS (`INT 10h`) y DOS (`INT 21h`) para controlar la pantalla y leer el teclado.

---

# Explicación

## `.286`

```asm
.286
```

Indica que el código es compatible con procesadores Intel 80286 o superiores.

---

# STACK

```asm
stack1 segment stack
    db 64 DUP(0)
stack1 ends
```

Reserva 64 bytes para la pila (stack).

La pila se usa para:

- llamadas a funciones
- interrupciones
- almacenamiento temporal

---

# DATA

```asm
data segment
```

Contiene las variables del programa.

## Coordenadas

```asm
PositionY db 12
PositionX db 40
```

Guardan la posición actual del cursor.

La pantalla en modo texto DOS tiene:

- 80 columnas (`0-79`)
- 25 filas (`0-24`)

Por eso `(40,12)` es aproximadamente el centro.

---

## Cursor

```asm
char db 219
```

El ASCII `219` representa:

```text
█
```

Se usa como sprite o cursor visual.

---

# Inicialización de DS

```asm
mov ax, data
mov ds, ax
```

Carga el segmento de datos en el registro `DS`.

Esto permite acceder correctamente a las variables.

---

# Limpiar pantalla

```asm
mov ah, 00h
mov al, 03h
int 10h
```

Usa `INT 10h` (servicios de video BIOS).

La función `00h` cambia el modo de video.

`03h` activa:

- modo texto 80x25
- limpieza de pantalla

---

# Game Loop

```asm
GameLoop:
```

Es el bucle principal del programa.

El flujo es:

1. Dibujar
2. Leer teclado
3. Actualizar posición
4. Repetir

---

# Posicionar cursor

```asm
mov ah, 02h
mov dh, PositionY
mov dl, PositionX
int 10h
```

Mueve el cursor físico en pantalla.

- `DH` = fila
- `DL` = columna

---

# Dibujar el carácter

```asm
mov ah, 09h
mov al, char
mov bl, 0Ch
int 10h
```

Imprime el bloque en color rojo claro.

`0Ch` significa:

- fondo negro
- texto rojo brillante

---

# Leer teclado

```asm
mov ah, 08h
int 21h
```

Usa `INT 21h` (servicios DOS).

Lee una tecla sin mostrarla en pantalla.

La tecla queda almacenada en:

```asm
AL
```

---

# Movimiento WASD

```asm
cmp al, 'w'
je Arriba
```

Compara la tecla presionada y salta a la rutina correspondiente.

---

# Límites de pantalla

Ejemplo:

```asm
cmp PositionY, 0
je GameLoop
```

Evita que el cursor salga de la pantalla.

---

# Movimiento

```asm
dec PositionY
inc PositionX
```

- `DEC` → resta 1
- `INC` → suma 1

---

# Refrescar pantalla

```asm
mov ah, 00h
mov al, 03h
int 10h
```

Limpia la pantalla antes de volver a dibujar.

Esto evita dejar un rastro del movimiento.

---

# Salida del programa

```asm
mov ax, 4C00h
int 21h
```

Finaliza el programa y devuelve el control a DOS.

---

# Conceptos que enseña este código

Este programa muestra conceptos básicos de:

- Assembly x86
- Segmentos de memoria
- Interrupciones BIOS y DOS
- Manejo de teclado
- Renderizado en texto
- Loops de videojuegos
- Movimiento por coordenadas

---

# Flujo general

```text
Inicializar memoria
↓
Limpiar pantalla
↓
Dibujar cursor
↓
Leer teclado
↓
Mover posición
↓
Refrescar pantalla
↓
Repetir
```

---

# Conclusión

Aunque el programa es pequeño, representa la base de muchos sistemas interactivos antiguos y motores simples de videojuegos en DOS.

Todo el control de pantalla y teclado se realiza directamente mediante interrupciones del sistema, sin librerías modernas ni motores gráficos avanzados.
