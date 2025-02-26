; combination_turns.asm
; x86_64 NASM assembly for Arch Linux
; This program calculates the minimum number of turns required to change
; a current combination to a target combination.
; For each digit pair:
;   diff = abs(current_digit - target_digit)
;   turn = min(diff, 10 - diff)
; The program sums these turns and prints the result.

section .data
    prompt_n         db "Enter N: ", 0
    prompt_current   db "Enter current combination: ", 0
    prompt_target    db "Enter target combination: ", 0
    newline          db 10

section .bss
    inputN           resb 16       ; buffer for N input
    current          resb 128      ; buffer for current combination
    target           resb 128      ; buffer for target combination
    outbuf           resb 32       ; buffer for converting result

section .text
global _start

_start:
    ; --- Prompt and read N ---
    mov     rax, 1                ; sys_write
    mov     rdi, 1                ; stdout
    mov     rsi, prompt_n
    mov     rdx, 10               ; length of "Enter N: "
    syscall

    mov     rax, 0                ; sys_read
    mov     rdi, 0                ; stdin
    mov     rsi, inputN
    mov     rdx, 16
    syscall

    ; Convert inputN (string) to integer in r8.
    mov     rdi, inputN           ; pointer to input string
    xor     rbx, rbx              ; rbx = accumulator = 0
.convert_loop:
    mov     al, byte [rdi]
    cmp     al, 10                ; newline?
    je      .convert_done
    cmp     al, 0                 ; also break at null terminator
    je      .convert_done
    sub     al, '0'
    imul    rbx, rbx, 10          ; rbx = rbx * 10
    add     rbx, rax              ; rbx = rbx + digit
    inc     rdi
    jmp     .convert_loop
.convert_done:
    mov     r8, rbx              ; r8 now holds N

    ; --- Prompt and read current combination ---
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, prompt_current
    mov     rdx, 28              ; length of "Enter current combination: "
    syscall

    mov     rax, 0
    mov     rdi, 0
    mov     rsi, current
    mov     rdx, 128
    syscall

    ; --- Prompt and read target combination ---
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, prompt_target
    mov     rdx, 27              ; length of "Enter target combination: "
    syscall

    mov     rax, 0
    mov     rdi, 0
    mov     rsi, target
    mov     rdx, 128
    syscall

    ; --- Initialize registers for loop ---
    xor     rcx, rcx            ; counter = 0
    xor     r9, r9              ; r9 will hold the sum (output)

    ; --- Loop over the digits ---
.loop_start:
    cmp     rcx, r8
    jge     .loop_end

    ; Get current digit from the "current" string
    mov     al, byte [current + rcx]
    sub     al, '0'
    movzx   r10, al             ; r10 = current digit

    ; Get target digit from the "target" string
    mov     al, byte [target + rcx]
    sub     al, '0'
    movzx   r11, al             ; r11 = target digit

    ; Compute absolute difference: diff = |current - target|
    cmp     r10, r11
    jge     .diff_a
    mov     r12, r11
    sub     r12, r10            ; r12 = diff when target > current
    jmp     .after_diff
.diff_a:
    mov     r12, r10
    sub     r12, r11            ; r12 = diff when current >= target
.after_diff:
    ; Compute D = 10 - diff
    mov     r13, 10
    sub     r13, r12            ; r13 = (10 - diff)

    ; Add the smaller of diff and (10 - diff) to the running total (r9)
    cmp     r12, r13
    jg      .add_d
    add     r9, r12
    jmp     .next_iter
.add_d:
    add     r9, r13

.next_iter:
    inc     rcx
    jmp     .loop_start

.loop_end:
    ; --- Convert the result (r9) to a string in outbuf ---
    mov     rax, r9             ; number to convert
    mov     rdi, outbuf         ; destination pointer for conversion
    ; Handle zero case separately.
    cmp     rax, 0
    jne     .convert_number
    mov     byte [outbuf], '0'
    mov     rbx, 1              ; length = 1
    jmp     .print_result

.convert_number:
    xor     rbx, rbx            ; rbx will count number of digits
.convert_loop_num:
    xor     rdx, rdx
    mov     r10, 10
    div     r10                 ; divide rax by 10: quotient in rax, remainder in rdx
    add     rdx, '0'
    mov     byte [rdi + rbx], dl
    inc     rbx
    cmp     rax, 0
    jne     .convert_loop_num

    ; At this point, outbuf contains the digits in reverse order.
    ; Now reverse the string in place.
    mov     rcx, rbx            ; rcx = length of string
    shr     rcx, 1              ; half length
    mov     rsi, outbuf         ; start pointer
    mov     rdi, outbuf
    add     rdi, rbx
    dec     rdi                 ; end pointer
.reverse_loop:
    cmp     rcx, 0
    je      .print_result
    mov     al, [rsi]
    mov     bl, [rdi]
    mov     [rsi], bl
    mov     [rdi], al
    inc     rsi
    dec     rdi
    dec     rcx
    jmp     .reverse_loop

.print_result:
    ; --- Print the result ---
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, outbuf
    mov     rdx, rbx            ; number of bytes to write
    syscall

    ; Print a newline.
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, newline
    mov     rdx, 1
    syscall

    ; --- Exit ---
    mov     rax, 60             ; sys_exit
    xor     rdi, rdi
    syscall