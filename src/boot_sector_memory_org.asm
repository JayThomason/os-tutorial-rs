;
; A simple  boot  sector  program  that  demonstrates  addressing.
;
BITS 16

[org 0x7c00]

mov ah, 0x0e

; attempt 1
; Will fail again regardless of 'org' because we are still addressing the pointer
; and not the data it points to
mov al, "1"
call printc
mov al, the_secret
call printc_with_newline

; attempt 2
; Having solved the memory offset problem with 'org', this is now the correct answer
mov al, "2"
call printc
mov al, [the_secret]
call printc_with_newline

; attempt 3
; As you expected, we are adding 0x7c00 twice, so this is not going to work
mov al, "3"
call printc
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
call printc_with_newline

; attempt 4
; This still works because there are no memory references to pointers, so
; the 'org' mode never applies. Directly addressing memory by counting bytes
; is always going to work, but it's inconvenient
mov al, "4"
call printc
mov al, [0x7c2d]
call printc_with_newline

jmp $ ; infinite loop

the_secret:
    ; ASCII code 0x58 ('X') is stored just before the zero-padding.
    ; On this code that is at byte 0x2d (check it out using 'xxd file.bin')
    db "X"

printc:
	int 0x10
	ret

printc_with_newline:
	call printc
	mov al, 0xd
	call printc
	mov al, 0xa
	call printc
	ret

; zero padding and magic bios number
times 510-($-$$) db 0
dw 0xaa55
