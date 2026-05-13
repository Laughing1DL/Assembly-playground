# Programa en Ensamblador x86 (.286)

Este programa está escrito en lenguaje ensamblador para procesadores Intel 80286 (`.286`) y utiliza interrupciones de DOS (`int 21h`) para mostrar mensajes en pantalla.

El objetivo principal del código es demostrar el uso de:

- Segmentos (`stack`, `data`, `code`)
- Etiquetas (`labels`)
- Saltos (`jmp`)
- Impresión de cadenas en DOS
- Flujo de ejecución entre diferentes puntos del programa

---

# Estructura General del Código

El programa está dividido en 3 partes principales:

## 1. Segmento Stack

```asm
stack1 segment stack 
    db 32 DUP(0) 
stack1 ends
