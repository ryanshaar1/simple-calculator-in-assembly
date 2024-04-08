.MODEL small
.STACK 100h

.DATA
    msg_prompt db "Enter operation (+ for addition, - for subtraction): $" 
    msg_operand1 db "Enter first operand: $"
    msg_operand2 db "Enter second operand: $" 
    msg_result db "Result: $"
    result db ?

.CODE

_start:
    mov ax, @data
    mov ds, ax
    ; Print prompt for operation
    mov ah, 09h ;09h is the function number for printing a string, which indicates that we want to print a string to the console.
    mov dx, offset msg_prompt
    int 21h ;The DX register contains the offset address of the string to be printed.

    ; Read operation from user
    mov ah, 01h ;01h is the function number for reading a character from the standard input (keyboard). It indicates that we want to read a character from the keyboard.
    int 21h ;After this interrupt, the character read from the keyboard will be stored in the AL register.
    mov bl, al ;This is done to preserve the character for later use or processing.

    ; Print prompt for first operand
    mov ah, 09h
    mov dx, offset msg_operand1
    int 21h

    ; Read first operand from user
    mov ah, 01h
    int 21h
    sub al, '0'  ; Convert ASCII to integer ;subtracting the ASCII value of '0' from a digit character will convert it to its corresponding integer value
    mov cl, al

    ; Print prompt for second operand
    mov ah, 09h
    mov dx, offset msg_operand2
    int 21h

    ; Read second operand from user
    mov ah, 01h
    int 21h
    sub al, '0'  ; Convert ASCII to integer

    ; Perform operation
    cmp bl, '+' ; This line compares the value in the BL register (which holds the character inputted by the user) with the ASCII value of '+'
    je addition ;If the comparison made by the previous CMP instruction results in equality, the program jumps to the addition label, which represents the code for addition
    cmp bl, '-'
    je subtraction

addition:
    add cl, al
    jmp calculate

subtraction:
    sub cl, al;להשתמש בנג וכנראה להוסיף תנאי כי רוצים להשתמש בנג רק אם תוצאת החיסור היא שלילית

calculate:
    ; Convert result to ASCII
    add cl, '0' ; Convert integer to ASCII

    ; Store result in buffer
    mov result, cl

    ; Print result
    mov ah, 09h
    lea dx, msg_result
    int 21h

    mov dl, result
    mov ah, 02h
    int 21h

    ; Exit program
    mov ah, 4Ch
    int 21h
END _start
