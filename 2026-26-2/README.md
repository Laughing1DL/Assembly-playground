# Programa de División en Ensamblador x86 (.286)

Este programa en ensamblador pide dos números al usuario, realiza una división y muestra:

- El resultado de la división
- El residuo

Utiliza interrupciones de DOS (`int 21h`) para entrada y salida de datos.

---

# ¿Qué hace el programa?

1. Pide el primer número.
2. Pide el segundo número.
3. Divide el primer número entre el segundo.
4. Guarda:
   - Cociente (`Result`)
   - Residuo (`Residue`)
5. Muestra ambos resultados en pantalla.

---

# Segmento Stack

```asm
stack1 segment stack 
    db 32 DUP(0) 
stack1 ends
```

Reserva memoria para la pila del programa.

---

# Segmento Data

Aquí se guardan los mensajes y variables.

## Mensajes

```asm
numb1Sel db "Give me the first number: $"
numb2Sel db 10,13,"Give me the second number: $"
residMsg db 10, 13, "The residue is: $"
resMsg   db 10, 13,"The result is: $"
```

Son los textos que se mostrarán en pantalla.

El símbolo `$` marca el final de la cadena para DOS.

---

## Variables

```asm
Number   db 0
Number2  db 0
Result   db 0
Residue  db 0 
```

Guardan:

- Primer número
- Segundo número
- Resultado de la división
- Residuo

---

# Inicialización

```asm
mov ax, data
mov ds, ax
```

Carga el segmento de datos para poder acceder a las variables.

---

# Captura del Primer Número

```asm
mov ah, 09h
lea dx, numb1Sel
int 21h
```

Muestra el mensaje:

```text
Give me the first number:
```

Luego:

```asm
mov ah, 01h
int 21h
```

Lee un carácter desde teclado.

---

# Conversión ASCII a Número

```asm
sub al, 30h
```

Convierte el carácter ASCII a valor numérico.

Ejemplo:

| Carácter | ASCII | Número |
|---|---|---|
| '1' | 31h | 1 |
| '5' | 35h | 5 |

---

# Guardar el Número

```asm
mov Number, al
```

Guarda el primer número.

---

# Captura del Segundo Número

El proceso es exactamente igual:

```asm
mov Number2, al
```

Guarda el segundo número.

---

# División

```asm
xor ax, ax
mov al, Number
mov cl, Number2
div cl
```

## ¿Qué hace?

Divide:

```text
AL / CL
```

El resultado queda así:

| Registro | Contenido |
|---|---|
| AL | Cociente |
| AH | Residuo |

---

# Guardar Resultado y Residuo

```asm
mov Result, al
mov Residue, ah
```

Guarda ambos valores en memoria.

---

# Mostrar Resultado

```asm
mov ah, 09h
lea dx, resMsg
int 21h
```

Muestra:

```text
The result is:
```

Luego imprime el número:

```asm
mov dl, Result
add dl, 30h
mov ah, 02h
int 21h
```

`add dl, 30h` convierte el número nuevamente a ASCII para poder mostrarlo.

---

# Mostrar Residuo

El mismo proceso se usa para el residuo:

```asm
mov dl, Residue
add dl, 30h
mov ah, 02h
int 21h
```

---

# Finalizar Programa

```asm
mov ah, 4Ch
int 21h
```

Termina el programa y devuelve el control a DOS.

---

# Resultado Esperado

Ejemplo:

```text
Give me the first number: 8
Give me the second number: 3

The result is: 2
The residue is: 2
```

Porque:

```text
8 / 3 = 2
Residuo = 2
```

---

# Conceptos Utilizados

- Variables
- Registros (`AL`, `AH`, `CL`, `DL`)
- División (`div`)
- Interrupciones DOS (`int 21h`)
- Entrada por teclado
- Conversión ASCII
- Salida en pantalla

---

# Requisitos

- MASM o TASM
- DOSBox o entorno DOS compatible

---
