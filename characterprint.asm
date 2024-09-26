ORG 100h           ; Origin, to specify that the program starts at 100h (COM file format)

; Read a single character from user
MOV AH, 01h        ; Function 01h of INT 21h is used to read a character from input
INT 21h            ; Call DOS interrupt to get the character
MOV DL, AL         ; Store the input character from AL register to DL for printing

; Print the character on screen
MOV AH, 02h        ; Function 02h of INT 21h is used to print a character
INT 21h            ; Call DOS interrupt to print the character

; Terminate the program
MOV AH, 4Ch        ; Function 4Ch of INT 21h terminates the program
INT 21h            ; Call DOS interrupt to exit

END                ; End of program