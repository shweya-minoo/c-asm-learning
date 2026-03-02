section .data
    ; C ဘက်က global variable တွေကို လှမ်းယူဖို့ ကြေညာခြင်း
    extern g_int_array, g_int_count
    extern g_str, g_space_count
    extern g_long_array, g_long_sum

section .text
    global task1_asm, task2_asm, task3_asm

; --- TASK 1: Positive vs Negative Algorithm ---
task1_asm:
    mov rsi, g_int_array    ; RSI = Array Address
    mov rcx, 10             ; RCX = Counter (10 elements)
    xor r8d, r8d            ; R8D ကို 0 လုပ် (ယာယီ count သိမ်းဖို့)

t1_loop:
    cmp dword [rsi], 0      ; 0 နဲ့ နှိုင်းယှဉ်
    jg  t1_pos              ; 0 ထက်ကြီးရင် (Greater)
    jl  t1_neg              ; 0 ထက်ငယ်ရင် (Less)
    jmp t1_next             ; 0 ဖြစ်နေရင် ကျော်

t1_pos:
    inc r8d                 ; +1
    jmp t1_next
t1_neg:
    dec r8d                 ; -1

t1_next:
    add rsi, 4              ; Integer က 4 bytes ဖြစ်လို့
    loop t1_loop            ; RCX-- ဖြစ်ပြီး 0 မဟုတ်မချင်း ပတ်မယ်

    mov [g_int_count], r8d  ; ရလဒ်ကို Global variable ထဲထည့်
    ret

; --- TASK 2: Space Count Algorithm ---
task2_asm:
    mov rdi, g_str          ; RDI = String Address
    xor rcx, rcx            ; RCX = Total Length
    xor rdx, rdx            ; RDX = Space Count

t2_count:
    mov al, [rdi + rcx]     ; Character တစ်လုံးချင်းယူ
    cmp al, 0               ; End of string (\0) လားစစ်
    je  t2_check            ; ကုန်သွားရင် စစ်ဆေးတဲ့ဆီသွား
    
    cmp al, ' '             ; Space ဟုတ်လားစစ်
    jne t2_not_space
    inc rdx                 ; Space ဖြစ်ရင် RDX ကို တိုး

t2_not_space:
    inc rcx                 ; Total Length တိုး
    jmp t2_count

t2_check:
    mov r8, rcx             ; R8 = Length
    shr r8, 1               ; R8 = Length / 2 (Algorithm အရ ၂ နဲ့စားခြင်း)
    cmp rdx, r8             ; Spaces > Half length ?
    ja  t2_store            ; ပိုများရင် သိမ်းမယ်
    mov rdx, 0              ; နည်းနေရင် 0 ထားမယ်

t2_store:
    mov [g_space_count], edx ; အဖြေသိမ်း
    ret

; --- TASK 3: Lowest Byte Sum Algorithm ---
task3_asm:
    mov rsi, g_long_array   ; RSI = Long Array Address
    mov rcx, 10             ; RCX = 10 elements
    xor r8, r8              ; R8 = Sum total (0 ထားမယ်)

t3_loop:
    mov rdx, [rsi]          ; ဂဏန်းကို RDX ထဲယူ
    mov r9, rdx             ; R9 ထဲ ကူးထား
    and r9, 0xFF            ; Lowest byte ကိုပဲ ချန် (AND operation)
    jnz t3_next             ; 0 မဟုတ်ရင် (Lowest byte has value) မပေါင်းဘူး
    
    add r8, rdx             ; 0 ဖြစ်ရင် ရလဒ်ထဲ ပေါင်းထည့်

t3_next:
    add rsi, 8              ; Long က 8 bytes ရှိလို့
    loop t3_loop

    mov [g_long_sum], r8    ; ရလဒ်သိမ်း
    ret