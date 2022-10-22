#include <stdio.h>

static int A[100];
static int B[100];

int main()
{
    int n;
    printf("Введите разер массива (от 1 до 100 включительно), затем введите элементы массива: ");
    scanf("%d", &n);

    if(n < 1 || n > 100){
        printf("Неправильный размер массива. Завершение программы.\n");
        return 0;
    }

    for(int i = 0; i < n; i++){
        scanf("%d", &A[i]);
        if(A[i] > 0){
            B[i] = 1;
        }
        else if(A[i] < 0){
            B[i] = -1;
        }
        else{
            B[i] = 0;
        }
    }
    
    for(int i = 0; i<n; i++){
        printf("%d ", B[i]);
    }
    
    printf("\n");
    return 0;
}
