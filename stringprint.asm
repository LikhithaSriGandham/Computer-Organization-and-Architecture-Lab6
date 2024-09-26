.model small
.stack 100h
.data
    input_msg db 'Enter a string: $'       ; Message to prompt the user for input
    output_msg db 0Dh, 0Ah, 'You entered: $' ; Message to display the output
    input_buffer db 50 dup('$')            ; Buffer to hold user input (50 characters max)

.code
main:
    mov ax, @data         ; Initialize the data segment
    mov ds, ax

    ; Display prompt to the user
    mov ah, 09h           ; DOS function to display string
    lea dx, input_msg      ; Load address of the input prompt message
    int 21h               ; Call DOS interrupt to print the message

    ; Get user input
    mov ah, 0Ah           ; DOS function for buffered input
    lea dx, input_buffer   ; Load the address of the input buffer
    ;mov byte ptr [dx], 49  ; Set buffer size (maximum 49 characters)
    int 21h               ; Call DOS interrupt to get input

    ; Display output message
    mov ah, 09h           ; DOS function to display string
    lea dx, output_msg     ; Load address of the output message
    int 21h               ; Call DOS interrupt to print the message

    ; Print the user input string
    lea si, input_buffer+2 ; SI points to the first character of user input
                           ; input_buffer+2 skips the buffer size and input length
print_loop:
    mov al, [si]          ; Load the current character into AL
    cmp al, 0Dh           ; Check for carriage return (Enter key)
    je done               ; If carriage return, end the loop

    mov ah, 02h           ; DOS function to print a single character
    mov dl, al            ; Move the character into DL (required for int 21h)
    int 21h               ; Call DOS interrupt to print the character

    inc si                ; Move to the next character in the string
    jmp print_loop        ; Repeat the loop for the next character

done:
    ; Terminate the program
    mov ah, 4Ch           ; DOS terminate program function
    int 21h
end main