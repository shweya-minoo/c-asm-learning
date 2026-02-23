#include <stdio.h>

// ASM functions
void my_asm_function();
void my_sum();
void my_string();
void move_long_to_str();
void split_long();

// Global variables
int g_int_a = 33;
int g_int_b = 44;

long g_long_array[4] = { 33, 44, 55, 0x66554433221100 };
long g_long_sum = 0;

char g_string[10] = "Hello.";   // 7 bytes including '\0'

long g_long_password = 0x70617373776f7264;   // "password"
char g_password_str[9];                     // 8 chars + '\0'

unsigned int g_low_part;
unsigned int g_high_part;

int main()
{
    printf("Before swap: a=%d b=%d\n", g_int_a, g_int_b);
    my_asm_function();
    printf("After swap:  a=%d b=%d\n\n", g_int_a, g_int_b);

    my_sum();
    printf("Sum of array = %ld\n\n", g_long_sum);

    my_string();
    printf("Modified string = %s\n\n", g_string);

    split_long();
    printf("Split long:\n");
    printf("Low  part  = 0x%x\n", g_low_part);
    printf("High part  = 0x%x\n\n", g_high_part);

    move_long_to_str();
    printf("Password (raw) = %s\n", g_password_str);

    return 0;
}
