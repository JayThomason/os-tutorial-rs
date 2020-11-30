;
; A simple bootloader that uses the stack.
;

mov ah, 0x0e ; tty mode

mov bp, 0x8000 ; this is an address far away from 0x7c00 so that we don't get overwritten
mov sp, bp ; if the stack is empty then sp points to bp

; push some characters onto the stack
push 'A'
push 'B'
push 'C'

; to show how the stack grows downwards
mov al, [0x7ffe] ; 0x8000 - 2
call printc

; however, don't try to access [0x8000] now, because it won't work
; you can only access the stack top so, at this point, only 0x7ffe (look above)
mov al, [0x8000]
call printc

; recover our characters using the standard procedure: 'pop'
; We can only pop full words so we need an auxiliary register to manipulate
; the lower byte
; Note that we can't use a subroutine for this because of the stack.
pop bx
mov al, bl
call printc

pop bx
mov al, bl
call printc

pop bx
mov al, bl
call printc

; data that has been pop'd from the stack is garbage now
mov al, [0x8000]
call printc

printc:
	int 0x10
	ret

jmp $
times 510-($-$$) db 0
dw 0xaa55
