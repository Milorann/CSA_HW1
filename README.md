### Листеренко Ольга Руслановна ###
### БПИ 217 ###

### Вариант 4 ###
#### Задача ####
Разработать программу, которая получает одномерный массив A, после
чего формирует из элементов массива A новый массив B по правилам,
указанным в варианте, и выводит его. Память под массивы может
выделяться статически, на стеке, автоматичеси по выбору разработчика.
При решении задачи необходимо использовать подпрограммы для
реализации ввода, вывода и формирования нового массива.

Массив B формируется по следующим правилам:  
• Bi = 1, если Ai > 0,  
• Bi = -1, если Ai < 0,  
• Bi = 0, если Ai = 0.  

#### Тесты ####
##### 1 тест #####
5  
12 0 -23 2 -39
###### Результат (одинаковый во всех программах) ######
1 0 -1 1 -1

##### 2 тест #####
0
###### Результат (одинаковый во всех программах) ######
Wrong size. Termination of the program.

##### 3 тест #####
101
###### Результат (одинаковый во всех программах) ######
Wrong size. Termination of the program.

#### Программа на C ####
Код находится в файле Task_in_C.c  

#### Оптимизированная программа на ассембелере с комментариями #### 
Код находится в файле Task.s

#### Программа на ассембелере от компилятора #### 
Код находится в файле Task_from_C.s
Код получен путем компиляции Task_in_C.c следующим образом:  
gcc -masm=intel -fno-asynchronous-unwind-tables -fno-jump-tables -fno-stack-protector -fno-exceptions ./Task_in_C.c -S -o ./Task_from_C.s

#### Информация, подтверждающую выполнение задания на 6 ####
Добавлены комментарии.  
Убраны лишние макросы.  
Удалены из конца кода строки ниже ret, а из начала информация о файле, из которой получили код на ассемблере.  
Удалены cdqe и nop, добавленные компилятором для дополнения.  
Удалены промежуточные присваивания на подобии:  
![image](https://user-images.githubusercontent.com/57359954/197390680-2a9bc23f-8160-4e97-86c3-f18e7f4f696c.png)  
![image](https://user-images.githubusercontent.com/57359954/197390738-4731a6fe-cf13-4fa4-bdaa-0e60581064c0.png)  
или  
![image](https://user-images.githubusercontent.com/57359954/197390878-68401c1b-b171-4f44-bb72-2c6065dc2879.png)  
![image](https://user-images.githubusercontent.com/57359954/197390890-c4979356-e38a-4be1-9d65-31a02da558ea.png)  
или  
![image](https://user-images.githubusercontent.com/57359954/197392341-8a98ae7e-cf5a-4d11-996e-3a14232fc9b9.png)  
![image](https://user-images.githubusercontent.com/57359954/197392379-d0c5f914-ddda-4884-be65-1c6c9516daa5.png)  
или  
![image](https://user-images.githubusercontent.com/57359954/197392993-d0762a1d-d08f-4a22-a949-636163c5fa28.png)  
![image](https://user-images.githubusercontent.com/57359954/197393026-de5f10d2-8420-4564-b23a-ac005826fd20.png)  
В программе использованы функции ввода и формирования, вывода, получающие на вход n (число элементов в массивах).  
Использованы локальные переменные n и i.  
Добавлены комментарии о передаче параметров (фактических и формальных).  
