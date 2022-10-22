	.intel_syntax noprefix
	
	.text
	.local	A                   # массив A
	.comm	A,400,32    
	.local	B                   # массив B
	.comm	B,400,32
	
	.section	.rodata
	.align 8
.LC0:
	.string	"Input array size (from 1 to 100), then input the elements: "
.LC1:
	.string	"%d"
	.align 8
.LC2:
	.string	"Wrong size. Termination of the program."
.LC3:
	.string	"%d "
	
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	
	lea	rdi, .LC0[rip]
	mov	eax, 0
	call	printf@PLT
	
	lea	rsi, -12[rbp]           # 2-й аргумент для функции scanf, т.е. &n
	lea	rdi, .LC1[rip]          # 1-й аргумент для функции scanf, т.е. &.LC1
	mov	eax, 0
	call	__isoc99_scanf@PLT  # вызов scanf("%d", &n)
	
	cmp	DWORD PTR -12[rbp], 1   # сравнивает n с 100
	jl	.L2                     # если n < 1, то идет на завершение
	
	cmp	DWORD PTR -12[rbp], 100 # сравнивает n с 100
	jle	.L3                     # если n <= 100, то прыгает в цикл
	
.L2:
	lea	rdi, .LC2[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L12
	
.L3:
	mov	DWORD PTR -4[rbp], 0    # i = 0;
	jmp	.L5
	
.L9:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	
	lea	rsi, A[rip]
	add	rsi, rdx

	lea	rdi, .LC1[rip]
	mov	eax, 0
	call	__isoc99_scanf@PLT
	
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, A[rip]
	mov	eax, DWORD PTR [rdx+rax]
	
	test	eax, eax
	jle	.L6
	
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, B[rip]
	mov	DWORD PTR [rdx+rax], 1
	jmp	.L7
	
.L6:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, A[rip]
	mov	eax, DWORD PTR [rdx+rax]
	test	eax, eax
	jns	.L8
	
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, B[rip]
	mov	DWORD PTR [rdx+rax], -1
	jmp	.L7
	
.L8:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, B[rip]
	mov	DWORD PTR [rdx+rax], 0
	
.L7:
	add	DWORD PTR -4[rbp], 1
	
.L5:
	mov	eax, DWORD PTR -12[rbp]
	cmp	DWORD PTR -4[rbp], eax
	jl	.L9
	mov	DWORD PTR -8[rbp], 0
	jmp	.L10
	
.L11:
	mov	eax, DWORD PTR -8[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	
	lea	rax, B[rip]
	mov	esi, DWORD PTR [rdx+rax]

	lea	rdi, .LC3[rip]
	mov	eax, 0
	call	printf@PLT
	add	DWORD PTR -8[rbp], 1
	
.L10:
	mov	eax, DWORD PTR -12[rbp]
	cmp	DWORD PTR -8[rbp], eax
	jl	.L11
	mov	edi, 10
	call	putchar@PLT
	mov	eax, 0
	
.L12:
	leave
	ret
