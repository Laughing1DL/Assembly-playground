.286
stack1 segment stack
    db 32 DUP(0)
stack1 ends

data segment
    loopinp db 13,10,"Give me the ammount of loops: $"
    loopnum db 0
    loopmsg db 13,10, "This is a loop, somebody kill me!!$"

data ends

code segment
main proc FAR
    assume ss:stack1, ds:data, cs:code

    mov ax, data
    mov ds, ax

; -------- FIRST NUMBER --------
    mov ah, 09h
    lea dx, loopinp
    int 21h

   mov ah, 01h
   int 21h
   sub al, 30h
   mov loopnum, al
   
   xor cx, cx
   mov cl, al

; -------- DECISION --------

Movmentloop:
    mov ah, 09h
    lea dx, loopmsg
    int 21h

    loop Movmentloop

; -------- EXIT --------
Exit:
    mov ah, 4Ch
    int 21h

main endp
code ends
end main
