#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static inline int min(int x, int y)
{
     return x < y ? x : y;
}

static int find_longest_substring(char *s, char output[])
{
    int i, j;
    char s2[3000] = { '\0' };

    s2[0] = '$';
    for (i = 0; s[i] != '\0'; i++) {
        s2[(i<<1)+1] = '#';
        s2[(i<<1)+2] = s[i];
    }
    s2[(i<<1)+1] = '#';
    int len = (i<<1)+2;
    s2[len] = '\0';
    
    int p[3000] = { 0 }; 
    int id = 0;  
    int limit = 0;  
    int max_len = 0;  
    int max_id = 0;  
    for (i = 1; i < len; i++) {
        if (i < limit) {
            p[i] = min(p[2*id-i], limit-i);
        } else {
            p[i] = 1;
        }
        
        while (s2[i+p[i]] == s2[i-p[i]]) {
            p[i]++;
        }
        
        if (i+p[i] > limit) {
            limit = i+p[i];
            id = i;
        }
        if (max_len < p[i]-1) {
            max_len = p[i]-1;
            max_id = i;
        }
    }
    
    for (j = 0, i = max_id - max_len; i <= max_id+max_len; i++) {
        if (s2[i] != '#') {
            output[j++] = s2[i];
        }
    }
    return max_len;
}

static char *longest_Palindrome(char *s)
{
    int i;
    if (s == NULL) {
        return NULL;
    }

    int len = strlen(s);
    if (len <= 1) {
        return s;
    }

    char *palindrome_str = malloc(strlen(s)+1);
    memset(palindrome_str, 0, sizeof(palindrome_str));

    int size = find_longest_substring(s, palindrome_str);
    palindrome_str[size] = '\0';
    return palindrome_str;
    free(s);
}

int main(int argc, char** argv)
 {
      if (argc == 2) {

         if (strcmp(argv[1], "help") == 0) {
         printf("\n%s\n\n", "Paramaters: palindrome [word] to find the longest palindromic substring.");
         return 0;
         }
     }

     if (argc == 1) {
         printf("%s%i%s\n", "Missing paramaters! Expects 1, got ", argc-1, ".");
         return -1;

     } else if (argc > 2) {
         printf("%s%i%s\n", "Too many paramaters! Expects 1, got ", argc-1, ".");
         return -1;

     }

    char *str1 = argv[1];
	printf("\n%s%s\n", "Original String: ", str1);
	printf("%s%s\n\n", "Longest palindromic substring of the said string: ", longest_Palindrome(str1));
	return 0;
 }
