	.intel_syntax noprefix
	.text
	.local	A
	.comm	A,400,32            # массив
	.local	B
	.comm	B,400,32            # массив
	
	.section	.rodata
.LC0:
	.string	"%d"
	
	.text
	.globl	input_and_forming
	.type	input_and_forming, @function
input_and_forming:              # подпрограмма ввода и формирования
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32                 # подготовка стэка
	
	mov	DWORD PTR -20[rbp], edi # загрузка n на стэк
	mov	DWORD PTR -4[rbp], 0    # i = 0
	
	jmp	.L2                     # прыжок на условие цикла
.L6:
	mov	eax, DWORD PTR -4[rbp]  # eax = i
	lea	rdx, 0[0+rax*4]         # rdx = i * 4 (для получения позиции)
	
	lea	rsi, A[rip]             # /
	add	rsi, rdx                # \ 2-й аргумент для функции scanf, т.е. &A[i]

	lea	rdi, .LC0[rip]          # 1-й аргумент для функции scanf, т.е. &.LC0
	mov	eax, 0
	call	__isoc99_scanf@PLT  # scanf("%d", &A[i])
	
	mov	eax, DWORD PTR -4[rbp]  # eax = i
	lea	rdx, 0[0+rax*4]         # rdx = i * 4 (для получения позиции)
	lea	rax, A[rip]                 # 
	mov	eax, DWORD PTR [rdx+rax]    #
	test	eax, eax                # if(A[i] > 0)
	jle	.L3
	
	mov	eax, DWORD PTR -4[rbp]  # eax = i
	lea	rdx, 0[0+rax*4]         # rdx = i * 4 (для получения позиции)
	lea	rax, B[rip]             #
	mov	DWORD PTR [rdx+rax], 1  # B[i] = 1
	jmp	.L4
	
.L3:
	mov	eax, DWORD PTR -4[rbp]  # eax = i
	lea	rdx, 0[0+rax*4]         # rdx = i * 4 (для получения позиции)
	lea	rax, A[rip]
	mov	eax, DWORD PTR [rdx+rax]
	test	eax, eax
	jns	.L5
	mov	eax, DWORD PTR -4[rbp]  # eax = i
	lea	rdx, 0[0+rax*4]         # rdx = i * 4 (для получения позиции)
	lea	rax, B[rip]
	mov	DWORD PTR [rdx+rax], -1
	jmp	.L4
.L5:
	mov	eax, DWORD PTR -4[rbp]  # eax = i
	lea	rdx, 0[0+rax*4]         # rdx = i * 4 (для получения позиции)
	lea	rax, B[rip]
	mov	DWORD PTR [rdx+rax], 0
.L4:
	add	DWORD PTR -4[rbp], 1    # i++
.L2:
	mov	eax, DWORD PTR -4[rbp]      # eax = i
	cmp	eax, DWORD PTR -20[rbp]     # сравнение i и n
	jl	.L6                         # если i < n, прыжок в тело цикла
	leave
	ret                         # конец подпрограммы ввода и формирования
	.size	input_and_forming, .-input_and_forming
	
	.section	.rodata
.LC1:
	.string	"%d "
	
	.text
	.globl	print_arr
	.type	print_arr, @function
print_arr:                      # подпрограмма печати массива
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	DWORD PTR -20[rbp], edi
	mov	DWORD PTR -4[rbp], 0
	jmp	.L8
.L9:
	mov	eax, DWORD PTR -4[rbp]  # eax = i
	lea	rdx, 0[0+rax*4]         # rdx = i * 4 (для получения позиции)
	lea	rax, B[rip]
	mov	eax, DWORD PTR [rdx+rax]
	mov	esi, eax
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	add	DWORD PTR -4[rbp], 1
.L8:
	mov	eax, DWORD PTR -4[rbp]  # eax = i
	cmp	eax, DWORD PTR -20[rbp]
	jl	.L9
	mov	edi, 10
	call	putchar@PLT
	
	leave
	ret                         # конец подпрограммы печати массива B
	
	.size	print_arr, .-print_arr
	
	.section	.rodata
	.align 8
.LC2:
	.string	"Input array size (from 1 to 100), then input the elements: "
	.align 8
.LC3:
	.string	"Wrong size. Termination of the program."
	.text
	.globl	main
	.type	main, @function
main:                           # основная программа
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	lea	rax, .LC2[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	lea	rax, -4[rbp]
	mov	rsi, rax
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT
	mov	eax, DWORD PTR -4[rbp]
	test	eax, eax
	jle	.L11
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, 100
	jle	.L12
.L11:
	lea	rax, .LC3[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 0
	jmp	.L14
.L12:
	mov	eax, DWORD PTR -4[rbp]
	mov	edi, eax
	call	input_and_forming
	mov	eax, DWORD PTR -4[rbp]
	mov	edi, eax
	call	print_arr
	mov	eax, 0
.L14:
	leave
	ret                         # конец основной программы
