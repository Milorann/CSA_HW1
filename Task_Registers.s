	.intel_syntax noprefix
	.text
	.local	A
	.comm	A,400,32            # массив A
	.local	B
	.comm	B,400,32            # массив B
	
	.section	.rodata
.LC0:
	.string	"%d"
	
	.text                       # подпрограмма ввода и формирования
	.globl	input_and_forming
	.type	input_and_forming, @function
input_and_forming:              # получает на вход n
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32                 # подготовка стэка
	
	mov	DWORD PTR -20[rbp], edi # загрузка n на стэк
	mov	r12d, 0                 # i = 0
	
	jmp	.L2                     # прыжок на условие цикла
.L6:
	mov	eax, r12d               # eax = i
	lea	rdx, 0[0+rax*4]         # rdx = i * 4 (для получения позиции)
	
	lea	rsi, A[rip]             # /
	add	rsi, rdx                # \ 2-й аргумент для функции scanf, т.е. &A[i]

	lea	rdi, .LC0[rip]          # 1-й аргумент для функции scanf, т.е. &.LC0
	mov	eax, 0
	call	__isoc99_scanf@PLT  # scanf("%d", &A[i])
	
	mov	eax, r12d               # eax = i
	lea	rdx, 0[0+rax*4]         # rdx = i * 4 (для получения позиции)
	lea	rax, A[rip]                 # 
	mov	eax, DWORD PTR [rdx+rax]    #
	test	eax, eax                # if(A[i] > 0)
	jle	.L3
	
	mov	eax, r12d               # eax = i
	lea	rdx, 0[0+rax*4]         # rdx = i * 4 (для получения позиции)
	lea	rax, B[rip]             #
	mov	DWORD PTR [rdx+rax], 1  # B[i] = 1
	jmp	.L4
	
.L3:
	mov	eax, r12d               # eax = i
	lea	rdx, 0[0+rax*4]         # rdx = i * 4 (для получения позиции)
	lea	rax, A[rip]                 #
	mov	eax, DWORD PTR [rdx+rax]    #
	test	eax, eax                # else if(A[i] < 0)
	jns	.L5
	
	mov	eax, r12d               # eax = i
	lea	rdx, 0[0+rax*4]         # rdx = i * 4 (для получения позиции)
	lea	rax, B[rip]             #
	mov	DWORD PTR [rdx+rax], -1 # B[i] = -1
	jmp	.L4
	
.L5:
	mov	eax, r12d               # eax = i
	lea	rdx, 0[0+rax*4]         # rdx = i * 4 (для получения позиции)
	lea	rax, B[rip]             #
	mov	DWORD PTR [rdx+rax], 0  # B[i] = 0
	
.L4:
	add	r12d, 1                 # i++
	
.L2:
	cmp	r12d, DWORD PTR -20[rbp]     # сравнение i и n
	jl	.L6                         # если i < n, прыжок в тело цикла
	
	leave                       # подпрограмма не возвращает значений
	ret                         # конец подпрограммы ввода и формирования
	.size	input_and_forming, .-input_and_forming
	
	.section	.rodata
.LC1:
	.string	"%d "
	
	.text                       # подпрограмма печати массива
	.globl	print_arr
	.type	print_arr, @function
print_arr:                      # получает на вход n
	push	rbp                 #
	mov	rbp, rsp                #
	sub	rsp, 32                 # подготовка стэка
	mov	DWORD PTR -20[rbp], edi # загрузка n на стэк
	mov	DWORD PTR -4[rbp], 0    # i = 0
	jmp	.L8
	
.L9:
	mov	eax, DWORD PTR -4[rbp]  # eax = i
	lea	rdx, 0[0+rax*4]         # rdx = i * 4 (для получения позиции)
	lea	rax, B[rip]             #
	mov	esi, DWORD PTR [rdx+rax] # 2-й аргумент для функции printf, т.е. &B[i]
	lea	rdi, .LC1[rip]          # 1-й аргумент для функции printf, т.е. &.LC1    
	mov	eax, 0
	call	printf@PLT          # вызов printf(.LC1, B[i])
	add	DWORD PTR -4[rbp], 1    # i++
	
.L8:
	mov	eax, DWORD PTR -4[rbp]  # eax = i
	cmp	eax, DWORD PTR -20[rbp] # сравнение i и n
	jl	.L9                     # если i < n, прыжок в тело цикла
	
	mov	edi, 10                 # 1-й аргумент для функции printf, т.е. '\n'        
	call	putchar@PLT         # putchar('\n') (printf('\n'))
	
	leave                       # подпрограмма не возвращает значений
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
	push	rbp                 #
	mov	rbp, rsp                #
	sub	rsp, 16                 # подготовка стэка
	
	lea	rdi, .LC2[rip]          # 1-й аргумент для функции printf, т.е. &.LC2
	mov	eax, 0
	call	printf@PLT          # printf(.LC2);
	
	lea	rsi, -4[rbp]            # 2-й аргумент для функции scanf, т.е. &n
	lea	rdi, .LC0[rip]          # 1-й аргумент для функции scanf, т.е. &.LC1
	mov	eax, 0
	call	__isoc99_scanf@PLT  # scanf("%d", &n)
	
	mov	eax, DWORD PTR -4[rbp]  #
	test	eax, eax            # if(n < 1
	jle	.L11
	
	cmp	DWORD PTR -4[rbp], 100  # || n > 100)
	jle	.L12
	
.L11:
	lea	rdi, .LC3[rip]          # 1-й аргумент для функции printf, т.е. &.LC3
	call	puts@PLT            # puts(.LC2) (printf(.LC2) с \n)
	mov	eax, 0
	jmp	.L14
	
.L12:
	mov	edi, DWORD PTR -4[rbp]  # аргумент для подпрограммы
	call	input_and_forming   # вызов подпрограммы ввода A и формирования B
	
	mov	edi, DWORD PTR -4[rbp]  # аргумент для подпрограммы
	call	print_arr           # вызов подпрограммы печати B
	mov	eax, 0
	
.L14:
	leave                       #
	ret                         # конец основной программы
