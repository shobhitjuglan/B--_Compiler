
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     NUM = 258,
     FLOAT = 259,
     DATA = 260,
     DEF = 261,
     DIM = 262,
     END = 263,
     FOR = 264,
     TO = 265,
     STEP = 266,
     NEXT = 267,
     GOSUB = 268,
     GOTO = 269,
     IF = 270,
     THEN = 271,
     LET = 272,
     INPUT = 273,
     PRINT = 274,
     REM = 275,
     RETURN = 276,
     STOP = 277,
     NOTEQUAL = 278,
     SIZE = 279,
     BEQ = 280,
     BNE = 281,
     BGE = 282,
     BLE = 283,
     BGT = 284,
     BLT = 285,
     NOT = 286,
     AND = 287,
     OR = 288,
     XOR = 289,
     EQUAL = 290,
     ADD = 291,
     SUB = 292,
     PRO = 293,
     DIV = 294,
     POWER = 295,
     SEMCOM = 296,
     COMMA = 297,
     OPA = 298,
     CPA = 299,
     FUNC = 300,
     VAR = 301,
     STRING = 302,
     PRTEXP = 303,
     IGN = 304,
     EOL = 305
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


