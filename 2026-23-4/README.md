# Programa de Patrón de Estrellas en Ensamblador x86 (.286)

Este programa está escrito en lenguaje ensamblador para procesadores Intel 80286 (`.286`) y utiliza interrupciones de DOS (`int 21h`) para mostrar caracteres en pantalla.

El objetivo principal del programa es imprimir un patrón de estrellas (`*`) en forma de triángulo utilizando ciclos anidados (`loops`).

El resultado esperado es algo similar a esto:

```text
*
**
***
****
*****
******
```

---

# Estructura General del Programa

El código está dividido en tres segmentos principales:

- Stack
- Data
- Code

---

# 1. Segmento Stack

```asm
stack1 segment stack
    db 32 DUP(0)
stack1 ends
```

## ¿Qué hace?

Reserva espacio para la pila (`stack`) del programa.

### Explicación

- `db`
  - Define bytes en memoria.
- `32 DUP(0)`
  - Reserva 32 bytes inicializados en `0`.

La pila se utiliza para guardar datos temporales durante la ejecución, por ejemplo registros.

---

# 2. Segmento de Datos

```asm
data segment
    star db "*$"
    newline db 13,10,"$"
data ends
```

Aquí se almacenan las cadenas que se imprimirán en pantalla.

---

## Variable `star`

```asm
star db "*$"
```

Contiene el carácter `*`.

### Explicación

- `*`
  - Carácter que se imprimirá.
- `$`
  - Marca el final de la cadena para DOS.

---

## Variable `newline`

```asm
newline db 13,10,"$"
```

Representa un salto de línea.

### Explicación

- `13`
  - Retorno de carro (Carriage Return).
- `10`
  - Nueva línea (Line Feed).
- `$`
  - Fin de cadena.

---

# 3. Segmento de Código

```asm
code segment
```

Contiene toda la lógica principal del programa.

---

# Inicio del Programa

```asm
main proc FAR
```

Define el procedimiento principal.

---

# Configuración de Segmentos

```asm
assume ss:stack1, ds:data, cs:code
```

Indica qué segmentos usar:

- `ss` → stack
- `ds` → datos
- `cs` → código

---

# Inicialización del Segmento de Datos

```asm
mov ax, data
mov ds, ax
```

Carga el segmento de datos en el registro `DS`.

Esto permite acceder a las variables declaradas en `data`.

---

# Configuración Inicial

```asm
mov cx, 6
mov si, 1
```

## Explicación

### `mov cx, 6`

Define la cantidad de filas que tendrá el patrón.

En este caso:

```text
6 filas
```

---

### `mov si, 1`

Inicializa el contador de estrellas.

La primera fila comienza con:

```text
1 estrella
```

---

# Loop Externo (`outer_loop`)

```asm
outer_loop:
```

Este ciclo controla las filas del triángulo.

Cada vuelta del loop representa una nueva línea.

---

# Guardar el Contador

```asm
push cx
```

Guarda el valor actual de `CX` en la pila.

Esto es necesario porque el loop interno modificará registros y se necesita recuperar el contador original después.

---

# Preparar Cantidad de Estrellas

```asm
mov bx, si
```

Copia la cantidad actual de estrellas a `BX`.

`BX` será utilizado por el loop interno.

---

# Loop Interno (`inner_loop`)

```asm
inner_loop:
```

Este ciclo imprime las estrellas de cada fila.

---

# Mostrar una Estrella

```asm
mov ah, 09h
lea dx, star
int 21h
```

## Explicación

- `AH = 09h`
  - Función DOS para imprimir cadenas.
- `DX`
  - Dirección de la cadena.
- `int 21h`
  - Llamada al sistema DOS.

Esto imprime:

```text
*
```

---

# Control del Loop Interno

```asm
dec bx
jnz inner_loop
```

## ¿Qué hace?

### `dec bx`

Reduce el contador de estrellas.

### `jnz inner_loop`

- Si `BX` no es cero:
  - vuelve al loop interno.
- Si llega a cero:
  - termina la fila actual.

---

# Salto de Línea

```asm
mov ah, 09h
lea dx, newline
int 21h
```

Imprime un salto de línea para comenzar una nueva fila.

---

# Incrementar Número de Estrellas

```asm
inc si
```

Aumenta la cantidad de estrellas para la siguiente fila.

Ejemplo:

| Fila | Estrellas |
|---|---|
| 1 | 1 |
| 2 | 2 |
| 3 | 3 |
| 4 | 4 |
| 5 | 5 |
| 6 | 6 |

---

# Recuperar el Contador

```asm
pop cx
```

Restaura el valor original de `CX` desde la pila.

---

# Repetir el Loop Externo

```asm
loop outer_loop
```

## ¿Cómo funciona?

La instrucción `loop`:

1. Decrementa `CX`
2. Verifica si `CX` es diferente de `0`
3. Si no es `0`, vuelve a `outer_loop`

---

# Finalización del Programa

```asm
mov ah, 4Ch
int 21h
```

## ¿Qué hace?

Finaliza el programa y devuelve el control al sistema operativo DOS.

---

# Flujo General del Programa

```text
Inicializar filas y estrellas
        ↓
Iniciar loop externo
        ↓
Preparar cantidad de estrellas
        ↓
Imprimir estrellas
        ↓
Salto de línea
        ↓
Incrementar estrellas
        ↓
Repetir hasta terminar filas
        ↓
Finalizar programa
```

---

# Conceptos de Ensamblador Utilizados

- Segmentos
- Registros (`AX`, `BX`, `CX`, `DX`, `SI`)
- Loops anidados
- Pila (`push` y `pop`)
- Interrupciones DOS (`int 21h`)
- Manejo de cadenas
- Saltos condicionales (`jnz`)
- Instrucción `loop`

---

# Resultado Esperado

```text
*
**
***
****
*****
******
```

---

# Requisitos

Para ejecutar este programa se necesita:

- MASM o TASM
- DOSBox o entorno DOS compatible

---
