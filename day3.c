#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

// Driver Code
int main(int argc, char *argv[])
{
    if (argc < 2) {
        printf("Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    char buffer[64000];
    char filename[100];

    strcpy(filename, argv[1]);

    // Open the file for reading
    FILE* fp = fopen(filename, "r");
    if (!fp) {
        perror("Failed to open file");
        return 1;
    }

    // Read the contents of the file
    size_t bytesRead = fread(buffer, 1, sizeof(buffer) - 1, fp);
    buffer[bytesRead] = '\0'; // Null-terminate the buffer

    printf("File contents:\n%s\n", buffer);
    fclose(fp);
    
    int x, y;
    char *mul_pos;

    // Start searching for 'mul' in the string
    mul_pos = strstr(buffer, "mul");
    int total = 0;
    while (mul_pos != NULL) {
        // Check if the next characters are ( and ), and then extract the digits
        if (*(mul_pos + 3) == '(') {
            if (sscanf(mul_pos + 4, "%d,%d", &x, &y) == 2) {
                
                int len_x = snprintf(NULL, 0, "%d", x);  // Get length of x
                int len_y = snprintf(NULL, 0, "%d", y);  // Get length of y
                int expected_end_pos = 4 + len_x + 1 + len_y;  // 4 for 'mul(', len_x for x, 1 for ',', len_y for y
                if (*(mul_pos + expected_end_pos) == ')') {
                    // printf("e: %s %s \n",);
                    // Print the matching mul(x, y)
                    printf("Found mul(%d, %d)\n", x, y);
                    total+= x*y;
                }
            }
        }
        // Move the pointer to the next occurrence of 'mul'
        mul_pos = strstr(mul_pos + 1, "mul");
    }
    printf("Part 1: %d\n",total);


    char *last_mul_pos = NULL;
    total = 0;
    int mul_valid = 1;

    mul_pos = strstr(buffer, "mul");

    while (mul_pos != NULL) {
        char *sub_str = malloc(mul_pos - buffer + 1);
        strncpy(sub_str, buffer, mul_pos - buffer);
        sub_str[mul_pos - buffer] = '\0';

        char *donot_pos = strstr(sub_str, "don't()");
        char *do_pos = strstr(sub_str, "do()");

        if (donot_pos && (!do_pos || do_pos > donot_pos) && donot_pos < mul_pos) {
            mul_valid = 0;
        } else if (do_pos && (!donot_pos || do_pos < donot_pos) && do_pos < mul_pos) {
            mul_valid = 1;
        }

        free(sub_str);

        printf("Pos: %ld, do_pos: %ld, donot_pos: %d, Valid: %d\n", mul_pos - buffer, do_pos-sub_str, donot_pos-sub_str, mul_valid);

        if (*(mul_pos + 3) == '(') {
            if (sscanf(mul_pos + 4, "%d,%d", &x, &y) == 2) {
                int len_x = snprintf(NULL, 0, "%d", x);  // Get length of x
                int len_y = snprintf(NULL, 0, "%d", y);  // Get length of y
                int expected_end_pos = 4 + len_x + 1 + len_y;  // 4 for 'mul(', len_x for x, 1 for ',', len_y for y

                if (*(mul_pos + expected_end_pos) == ')') {
                    printf("Found mul(%d, %d)\n", x, y);
                    if (mul_valid == 1) {
                        total += x * y;
                    }
                }
            }
        }

        // Move the pointer to the next occurrence of 'mul'
        last_mul_pos = mul_pos;
        mul_pos = strstr(mul_pos + 1, "mul");
    }

    printf("Total: %d\n", total);

    return 0;
}