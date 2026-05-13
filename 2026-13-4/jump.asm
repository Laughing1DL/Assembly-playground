.286
stack1 segment stack 
        db 32 DUP(0) 
stack1 ends

data segment
    FirstPointMessage db 10,13, "First point $"
    SecondPointMessage db 10,13, "Second point $"
    ThirdPointMessage db 10,13, "Third point $"
    FourthPointMessage db 10,13, "Fourth point $"
    FifthPointMessage db 10,13, "Fifth point $"
    EndMessage db 10,13, "End $"
    NewLine db 10,13, "$"
data ends

code segment 'code'
main proc FAR
    assume ss:stack1, ds:data, cs:code

    mov ax, data
    mov ds, ax

    ; --- Pedir primer número ---
    FirstPoint:
        mov ah, 09h
        mov dx, offset FirstPointMessage
        int 21h

        jmp FifthPoint

    SecondPoint:
        mov ah, 09h
        mov dx, offset SecondPointMessage
        int 21h

        jmp EndPoint

    ThirdPoint:
        mov ah, 09h
        mov dx, offset ThirdPointMessage
        int 21h

        jmp FourthPoint

    FourthPoint:
        mov ah, 09h
        mov dx, offset FourthPointMessage
        int 21h

        jmp SecondPoint

    FifthPoint:
        mov ah, 09h
        mov dx, offset FifthPointMessage
        int 21h

        jmp ThirdPoint

    EndPoint:
        mov ah, 09h
        mov dx, offset EndMessage1
        int 21h


    ; --- Salida al DOS ---
    mov ah, 4Ch
    int 21h
main endp
code ends
end main
