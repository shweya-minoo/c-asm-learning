section .data
    ; C ဘက်က global variable တွေကို လှမ်းယူဖို့ ကြေညာခြင်း
    extern g_int_array, g_int_count
    extern g_str, g_space_count
    extern g_long_array, g_long_sum

section .text
    global task1_asm, task2_asm, task3_asm

; ---Array ထဲက ဂဏန်းတွေဟာ သတ်မှတ်ထားတဲ့ low နဲ့ high ကြားမှာ ရှိမရှိ စစ်ရမှာပါ။
int_in_range:
    xor eax, eax            ; Counter (EAX = 0)
    test rsi, rsi           ; N က 0 ဖြစ်နေလားစစ်
    jz .done
.loop:
    mov r8d, [rdi]          ; Array ထဲက data တစ်ခုကို R8D ထဲယူ
    cmp r8d, edx            ; r8d < low ?
    jl .next                ; ငယ်ရင် ကျော်
    cmp r8d, ecx            ; r8d > high ?
    jg .next                ; ကြီးရင် ကျော်
    inc eax                 ; range ထဲမှာရှိရင် counter တိုး
.next:
    add rdi, 4              ; နောက်တစ်လုံးကို ရွှေ့ (int = 4 bytes)
    dec rsi                 ; N--
    jnz .loop               ; N က 0 မဟုတ်သေးရင် ပတ်မယ်
.done:
    ret
;Task 2: Count Bits set to 1ဒါက Bitwise Algorithm ပါ။ ဂဏန်းတစ်ခုရဲ့ binary form မှာ 1 ဘယ်နှစ်လုံး ပါလဲဆိုတာ ရေတွက်တာပါ။
    num_bits_one:
    xor eax, eax            ; Bit counter = 0
.loop:
    test rdi, rdi           ; ဂဏန်းက 0 ဖြစ်သွားပြီလား (ကုန်ပြီလား)
    jz .done
    mov r8, rdi             ; r8 ထဲ ကူးထား
    and r8, 1               ; နောက်ဆုံး bit က 1 ဟုတ်လားစစ်
    add eax, r8d            ; 1 ဆိုရင် ပေါင်းထည့် (0 ဆိုရင် ဘာမှမတိုးဘူး)
    shr rdi, 1              ; Right shift 1 (Bit တစ်ခုချင်းစီကို ညာဘက်တွန်းထုတ်)
    jmp .loop
.done:
    ret
;Task 3: Binary String to Int"1010" ဆိုတဲ့ စာသားကို $10$ ဆိုတဲ့ ဂဏန်းဖြစ်အောင် ပြောင်းတာပါ။
binstr_to_int:
    xor eax, eax            ; Result = 0
.loop:
    movzx r8d, byte [rdi]   ; စာလုံးတစ်လုံးယူ
    test r8b, r8b           ; Null terminator ဟုတ်လားစစ်
    jz .done
    shl eax, 1              ; Result ကို ဘယ်ဘက် ၁ ချက်တိုး (x2 လုပ်တာနဲ့တူတယ်)
    sub r8b, '0'            ; '1' (ASCII 49) ကို 1 (Number) ဖြစ်အောင်ပြောင်း
    or al, r8b              ; Result ထဲကို bit ထည့်ပေါင်း
    inc rdi                 ; နောက်စာလုံးကို ရွှေ့
    jmp .loop
.done:
    ret
;Count Digits in Stringစာသားထဲမှာ '0' ကနေ '9' အထိ ဂဏန်း ဘယ်နှစ်လုံး ပါသလဲ ရေတွက်ရမှာပါ။
num_digits:
    xor eax, eax            ; Digit counter = 0
.loop:
    movzx r8d, byte [rdi]
    test r8b, r8b           ; End of string?
    jz .done
    cmp r8b, '0'            ; '0' ထက် ငယ်လား
    jb .next
    cmp r8b, '9'            ; '9' ထက် ကြီးလား
    ja .next
    inc eax                 ; '0'-'9' ကြားဆိုရင် counter တိုး
.next:
    inc rdi
    jmp .loop
.done:
    ret
;binstr_to_int ရဲ့ Algorithm အဆင့်ဆင့်
    binstr_to_int:
    xor eax, eax            ; အဖြေ (EAX) ကို 0 အရင်လုပ်မယ်
.loop:
    movzx r8d, byte [rdi]   ; စာလုံးတစ်လုံးယူ (ဥပမာ '1')
    test r8b, r8b           ; String ကုန်ပြီလား စစ်
    jz .done
    shl eax, 1              ; EAX ထဲက bit တွေကို ဘယ်ဘက် ၁ ချက်တိုး
    sub r8b, '0'            ; ASCII '1' (49) ကို နံပါတ် 1 ဖြစ်အောင်ပြောင်း
    or  al, r8b             ; EAX ရဲ့ အနောက်ဆုံးအကန့်ထဲကို 1 ထည့်လိုက်တာ

    