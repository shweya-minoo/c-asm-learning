bits 64

section .data
    extern g_long_array
    extern g_negative_sum

    extern g_char_array
    extern g_char_sum

    extern g_msg
    extern g_first_space
    extern g_last_space

    extern g_int_array
    extern g_int_len

section .text
    global sum_negative
    global sum_char_array
    global find_spaces
    global reverse_negatives

sum_negative:
    xor rax, rax        ; sum = 0
    xor rcx, rcx        ; i = 0

.loop1:
    cmp rcx, 10
    jge .done1

    mov rbx, [g_long_array + rcx*8]
    cmp rbx, 0
    jge .skip1

    add rax, rbx

.skip1:
    inc rcx
    jmp .loop1

.done1:
    mov [g_negative_sum], rax
    ret

sum_char_array:
    xor rax, rax
    xor rcx, rcx

.loop2:
    cmp rcx, 10
    jge .done2

    movsx rbx, byte [g_char_array + rcx]
    add rax, rbx

    inc rcx
    jmp .loop2

.done2:
    mov [g_char_sum], rax
    ret

find_spaces:

    ; ---- FIRST SPACE ----
    xor rcx, rcx

.first_loop:
    mov al, [g_msg + rcx]
    cmp al, 0
    je .first_done

    cmp al, ' '
    jne .first_continue

    mov [g_first_space], rcx
    jmp .first_done

.first_continue:
    inc rcx
    jmp .first_loop

.first_done:

    ; ---- FIND LENGTH ----
    xor rcx, rcx
.len_loop:
    mov al, [g_msg + rcx]
    cmp al, 0
    je .len_done
    inc rcx
    jmp .len_loop

.len_done:
    dec rcx        ; rcx = last valid index

.last_loop:
    cmp rcx, 0
    jl .end_spaces

    mov al, [g_msg + rcx]
    cmp al, ' '
    jne .last_continue

    mov [g_last_space], rcx
    jmp .end_spaces

.last_continue:
    dec rcx
    jmp .last_loop

.end_spaces:
    ret

reverse_negatives:
    xor rcx, rcx            ; i = 0
    xor rdx, rdx            ; new length

.loop4:
    cmp rcx, 10
    jge .done4

    movsx rax, byte [g_char_array + rcx]
    cmp rax, 0
    jge .skip4

    neg rax                 ; reverse sign

    mov [g_int_array + rdx*4], eax
    inc rdx

.skip4:
    inc rcx
    jmp .loop4

.done4:
    mov [g_int_len], edx
    ret