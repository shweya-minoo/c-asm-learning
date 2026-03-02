#include <stdio.h>

// Global Variables (Assembly က လှမ်းသုံးမယ့် ဒေတာများ)
int g_int_array[] = { -1, -2, -3, -4, -5, 0, 6, 7, 8, -9 };
int g_int_count = 0;

char g_str[] = "H e llo P r o g r a m m e r s!";
int g_space_count = 0;

long g_long_array[] = { 0x100, 0x111, 0x200, 0x212, 0x300, 0x313, 0x400, 0x414, 0x500, 0x515 };
long g_long_sum = 0;

// Assembly functions တွေကို ခေါ်ဖို့ ကြေညာခြင်း
extern void task1_asm();
extern void task2_asm();
extern void task3_asm();

int main() {
    // Task 1 ခေါ်ယူခြင်း
    task1_asm();
    printf("Task 1 - Result (Positive vs Negative): %d\n", g_int_count);

    // Task 2 ခေါ်ယူခြင်း
    task2_asm();
    printf("Task 2 - Space Count (if > half): %d\n", g_space_count);

    // Task 3 ခေါ်ယူခြင်း
    task3_asm();
    printf("Task 3 - Sum of Long (Lowest byte 0): 0x%lx\n", g_long_sum);

    return 0;
}