; Stage 1 bootloader
; This bootloader will load the next stage of the bootloader from the first sector of the
; first disk and jump to it.

; The bootloader will be loaded at physical address 0x00007c00, so we need to use
; relative addressing to access data and code.

; Set up the segment registers to point to the correct memory location
mov ax, 0x07c0      ; Set the segment registers to the correct location
mov ds, ax
mov es, ax

; Read the first sector of the first disk into memory
mov ah, 0x02        ; Set up the parameters for the INT 0x13 function to read from the disk
mov al, 0x01        ; Read one sector
mov ch, 0x00        ; Read from cylinder 0
mov cl, 0x02        ; Read from sector 2
mov dh, 0x00        ; Read from head 0
mov dl, 0x00        ; Read from the first disk
int 0x13            ; Call the INT 0x13 function to read from the disk

; Check if the read was successful
jc boot_error       ; If the carry flag is set, there was an error

; Jump to the second stage bootloader
jmp 0x0000:0x7c00   ; Jump to the second stage bootloader at physical address 0x7c00

boot_error:
; Print an error message
mov ah, 0x0e        ; Set up the parameters for the INT 0x10 function to print a string
mov al, 'E'         ; Print the letter 'E'
int 0x10            ; Call the INT 0x10 function to print a character
mov al, 'R'         ; Print the letter 'R'
int 0x10            ; Call the INT 0x10 function to print a character
mov al, 'R'         ; Print the letter 'R'
int 0x10            ; Call the INT 0x10 function to print a character
mov al, 'O'         ; Print the letter 'O'
int 0x10            ; Call the INT 0x10 function to print a character
mov al, 'R'         ; Print the letter 'R'
int 0x10            ; Call the INT 0x10 function to print a character
jmp $               ; Loop forever
