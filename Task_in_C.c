#include <stdio.h>

int main()
{
    int n;
    scanf("%d", &n);
    
    int A[n];
    int B[n];
    
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
    return 0;
}
