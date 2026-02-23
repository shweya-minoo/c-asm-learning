bits 64

section .data
    extern g_int_a, g_int_b
    extern g_long_array
    extern g_long_sum
    extern g_string
    extern g_long_password
    extern g_password_str
    extern g_low_part
    extern g_high_part

section .text

; =====================================
; Swap g_int_a and g_int_b
; =====================================
global my_asm_function
my_asm_function:
    mov eax, [g_int_a]
    mov ecx, [g_int_b]
    mov [g_int_a], ecx
    mov [g_int_b], eax
    ret


; =====================================
; Sum long array (4 elements)
; =====================================
global my_sum
my_sum:
    xor rax, rax        ; sum = 0
    xor rcx, rcx        ; i = 0

.loop:
    cmp rcx, 4
    jge .done

    add rax, [g_long_array + rcx*8]
    inc rcx
    jmp .loop

.done:
    mov [g_long_sum], rax
    ret


; =====================================
; Replace '.' with '!'
; =====================================
global my_string
my_string:
    mov byte [g_string+5], '!'
    ret


; =====================================
; Split long into two 32-bit ints
; =====================================
global split_long
split_long:
    mov rax, [g_long_array+24]    ; element [3]

    mov [g_low_part], eax         ; lower 32 bits
    shr rax, 32
    mov [g_high_part], eax        ; higher 32 bits
    ret


; =====================================
; Move password long to string
; =====================================
global move_long_to_str
move_long_to_str:
    mov rax, [g_long_password]
    mov [g_password_str], rax
    mov byte [g_password_str+8], 0
    ret
