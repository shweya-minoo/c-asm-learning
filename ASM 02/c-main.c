#include <stdio.h>

long g_long_array[10] = { 5, -2, 8, -4, -10, 7, 3, -1, 6, -9 };
long g_negative_sum = 0;

char g_char_array[10] = { -1, 20, -3, 40, -5, 60, -7, 80, -9, 100 };
long g_char_sum = 0;

char g_msg[] = "The summer semester has begun.";
long g_first_space = -1;
long g_last_space = -1;

int g_int_array[10];
int g_int_len = 0;

void sum_negative();
void sum_char_array();
void find_spaces();
void reverse_negatives();

int main()
{
    sum_negative();
    sum_char_array();
    find_spaces();
    reverse_negatives();

    printf("Sum of negative longs: %ld\n", g_negative_sum);
    printf("Sum of char array: %ld\n", g_char_sum);
    printf("First space: %ld\n", g_first_space);
    printf("Last space: %ld\n", g_last_space);
    printf("Reversed negatives count: %d\n", g_int_len);
}