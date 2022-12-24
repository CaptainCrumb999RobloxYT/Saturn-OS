; Stage 1 bootloader
; This bootloader will load the next stage of the bootloader from the first sector of the
; first disk and jump to it.

; The bootloader will be loaded at physical address 0xfffffc0000200000, so we need to use
; relative addressing to access data and code.

; Set up the segment registers to point to the correct memory location
mov s0, 0xfffffc0000200000      ; Set the s0 register to the correct location

; Read the first sector of the first disk into memory
ldq t0, 0xfffffc0000210000      ; Load the parameters for the disk read function into t0
jsr t1, (t0)                    ; Call the disk read function

; Check if the read was successful
beq t1, boot_error              ; If t1 is equal to 0, there was an error

; Jump to the second stage bootloader
jmp 0xfffffc0000200000          ; Jump to the second stage bootloader at physical address 0xfffffc0000200000

boot_error:
; Print an error message
ldq t0, 0xfffffc0000220000      ; Load the parameters for the print function into t0
jsr t1, (t0)                    ; Call the print function
jmp $                           ; Loop forever
