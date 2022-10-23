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
	
	lea	rdi, .LC0[rip]          # 1-й аргумент для функции printf, т.е. &.LC0
	mov	eax, 0
	call	printf@PLT          # вызов printf(.LC0);
	
	lea	rsi, -12[rbp]           # 2-й аргумент для функции scanf, т.е. &n
	lea	rdi, .LC1[rip]          # 1-й аргумент для функции scanf, т.е. &.LC1
	mov	eax, 0
	call	__isoc99_scanf@PLT  # вызов scanf("%d", &n)
	
	cmp	DWORD PTR -12[rbp], 1   # сравнивает n с 100
	jl	.L2                     # если n < 1, то идет на завершение
	
	cmp	DWORD PTR -12[rbp], 100 # сравнивает n с 100
	jle	.L3                     # если n <= 100, то прыгает в цикл
	
.L2:
	lea	rdi, .LC2[rip]          # 1-й аргумент для функции printf, т.е. &.LC2
	call	puts@PLT            # вызов puts(.LC2) (printf(.LC2) с \n)
	mov	eax, 0
	jmp	.L12
	
.L3:
	mov	DWORD PTR -4[rbp], 0    # i = 0 (первый цикл)
	jmp	.L5
	
.L9:
	mov	eax, DWORD PTR -4[rbp]  # eax = i (первый цикл)
	lea	rdx, 0[0+rax*4]         # rdx = rax * 4
	lea	rsi, A[rip]
	add	rsi, rdx
	lea	rdi, .LC1[rip]          # 1-й аргумент для функции scanf, т.е. &.LC1
	mov	eax, 0
	call	__isoc99_scanf@PLT  # вызов scanf("%d", &A[i])
	
	mov	eax, DWORD PTR -4[rbp]  # eax = i (первый цикл)
	lea	rdx, 0[0+rax*4]         # rdx = rax * 4
	lea	rax, A[rip]
	mov	eax, DWORD PTR [rdx+rax]
	
	test	eax, eax
	jle	.L6
	
	mov	eax, DWORD PTR -4[rbp]  # eax = i (первый цикл)
	lea	rdx, 0[0+rax*4]         # rdx = rax * 4
	lea	rax, B[rip]
	mov	DWORD PTR [rdx+rax], 1
	jmp	.L7
	
.L6:
	mov	eax, DWORD PTR -4[rbp]  # eax = i (первый цикл)
	lea	rdx, 0[0+rax*4]         # rdx = rax * 4
	lea	rax, A[rip]
	mov	eax, DWORD PTR [rdx+rax]
	test	eax, eax
	jns	.L8
	
	mov	eax, DWORD PTR -4[rbp]  # eax = i (первый цикл)
	lea	rdx, 0[0+rax*4]         # rdx = rax * 4
	lea	rax, B[rip]
	mov	DWORD PTR [rdx+rax], -1
	jmp	.L7
	
.L8:
	mov	eax, DWORD PTR -4[rbp]  # eax = i (первый цикл)
	lea	rdx, 0[0+rax*4]         # rdx = rax * 4
	lea	rax, B[rip]
	mov	DWORD PTR [rdx+rax], 0
	
.L7:
	add	DWORD PTR -4[rbp], 1    # i++ (первый цикл)
	
.L5:
	mov	eax, DWORD PTR -12[rbp] # eax = n
	cmp	DWORD PTR -4[rbp], eax
	jl	.L9
	mov	DWORD PTR -8[rbp], 0
	jmp	.L10
	
.L11:
	mov	eax, DWORD PTR -8[rbp]  # eax = i (второй цикл)
	lea	rdx, 0[0+rax*4]         # rdx = rax * 4
	lea	rax, B[rip]
	mov	esi, DWORD PTR [rdx+rax]# 2-й аргумент для функции printf, т.е. &B[i]
	lea	rdi, .LC3[rip]          # 1-й аргумент для функции printf, т.е. &.LC3
	mov	eax, 0
	call	printf@PLT          # вызов printf(.LC3, B[i])
	add	DWORD PTR -8[rbp], 1    # i++ (второй цикл)
	
.L10:
	mov	eax, DWORD PTR -12[rbp] # eax = n
	cmp	DWORD PTR -8[rbp], eax
	jl	.L11
	mov	edi, 10                 # 1-й аргумент для функции printf, т.е. '\n'
	call	putchar@PLT         # вызов putchar('\n') (printf('\n'))
	mov	eax, 0
	
.L12:
	leave                       # выход из функции
	ret                         # выход из функции
