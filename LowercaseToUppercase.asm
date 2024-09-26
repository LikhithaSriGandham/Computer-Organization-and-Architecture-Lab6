.model small
.stack 100h
.data
    msg1 db 'Enter the text: $'
    msg2 db 0Dh,0Ah,'Converted text: $'
    input db 50 dup('$')      ; Reserve space for 50 characters (user input)

.code
main:
    mov ax, @data            ; Initialize data segment
    mov ds, ax

    ; Display message to ask user for input
    mov ah, 09h              ; DOS print string function
    lea dx, msg1
    int 21h

    ; Get user input
    mov ah, 0Ah              ; DOS buffered input
    lea dx, input            ; Load address of input buffer
   ; mov byte ptr [dx], 49    ; Buffer size (maximum 49 characters)
    int 21h

    ; Convert to uppercase
    lea si, input+2          ; Start at the first character (input+2 skips size and actual entered length)
next_char:
    mov al, [si]              ; Load the current character into AL
    cmp al, 0Dh               ; Check for carriage return (Enter key)
    je done                   ; If carriage return, we're done

    cmp al, 'a'               ; Check if the character is lowercase
    jl skip                   ; If less than 'a', skip
    cmp al, 'z'               ; Check if the character is greater than 'z'
    jg skip                   ; If greater than 'z', skip
    sub al, 20h               ; Convert to uppercase by subtracting 32 (20h)

skip:
    mov [si], al              ; Store the converted character back
    inc si                    ; Move to the next character
    jmp next_char             ; Repeat for the next character

done:
    ; Print converted text message
    mov ah, 09h               ; DOS print string function
    lea dx, msg2
    int 21h

    ; Print the converted string
    lea dx, input+2           ; Load address of the converted string (skip size and length bytes)
    mov ah, 09h               ; DOS print string function
    int 21h

    ; Terminate program
    mov ah, 4Ch               ; DOS terminate program function
    int 21h
end main