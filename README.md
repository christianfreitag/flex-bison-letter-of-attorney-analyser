# flex-bison-letter-of-attorney-analyser

It's a script to analyse a Brazilian specific format of a  letter of attorney. It's analysed first on Flex, where is done a lexic analyse. And then in Bison, where is done a syntactic analyse. The program it is done on C language and it uses tools like Flex and Bison. 

Execution on Linux (Ubuntu 18):

Install flex and Bison:
-----------------------
$ sudo apt-get install flex
$ sudo apt-get install bison

Generate C files using using flex and bison:
--------------------------------------------

$ flex flex_analyse.l
$ bison -d bison_analyse.y

"-d" allow to besides of .c file, also creates a header file (.h).

Compiling c files (gcc compilator):
------------------

$ gcc lex.yy.c bison_analyser.tab.c -o outAnalyser -lfl

Executing:
---------

$ ./outAnalyser ExampleFile

On "ExampleFile", its where is a example of the letter of attorney format. So it is passed as paramter at the command.

Result:
------

If there are any lexic or syntactical error, a txt file will be created with the same error that appear on terminal.
If there aren't any, a successfull mesagem shows.
