
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
     DOUBLE = 260,
     ERROR = 261,
     DATA = 262,
     DEF = 263,
     DIM = 264,
     END = 265,
     FOR = 266,
     TO = 267,
     STEP = 268,
     NEXT = 269,
     GOSUB = 270,
     GOTO = 271,
     IF = 272,
     THEN = 273,
     LET = 274,
     INPUT = 275,
     PRINT = 276,
     REM = 277,
     RETURN = 278,
     STOP = 279,
     NOTEQUAL = 280,
     SIZE = 281,
     BEQ = 282,
     BNE = 283,
     BGE = 284,
     BLE = 285,
     BGT = 286,
     BLT = 287,
     NOT = 288,
     AND = 289,
     OR = 290,
     XOR = 291,
     EQUAL = 292,
     ADD = 293,
     SUB = 294,
     PRO = 295,
     DIV = 296,
     POWER = 297,
     SEMCOM = 298,
     COMMA = 299,
     OPA = 300,
     CPA = 301,
     FUNC = 302,
     VARINT = 303,
     VARFLOAT = 304,
     VARSTRING = 305,
     VARDOUBLE = 306,
     STRING = 307,
     PRTEXP = 308,
     IGN = 309,
     EOL = 310
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


