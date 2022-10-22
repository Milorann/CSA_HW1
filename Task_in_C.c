#include <stdio.h>

static int A[100];
static int B[100];

int main()
{
    int n;
    printf("Input array size (from 1 to 100), then input the elements: ");
    scanf("%d", &n);

    if(n < 1 || n > 100){
        printf("Wrong size. Termination of the program.\n");
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
    
    for(int i = 0; i < n; i++){
        printf("%d ", B[i]);
    }
    
    printf("\n");
    return 0;
}
