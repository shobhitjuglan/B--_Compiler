1. This is a basic B-- language lexer and parser program. 

2. So, we will have to start by copying either CorrectSample.bmm or IncorrectSample.bmm to the input.txt file.

3. After that, after opening the terminal to this directory, write the commands in order.

4. flex BMM_Scanner.l
   This will make a lex.yy.c file as well.

5. bison -d BMM_Parser.y
   This will make BMM_Parser.tab.c and BMM_Parser.tab.h files.

6. gcc lex.yy.c BMM_Parser.tab.c
   This will create the executable file a.exe

7. ./a.exe
   This will run the file and printed values will be returned on the terminal.

8. Note that some basic syntax errors will be detected but not all kinds of errors.