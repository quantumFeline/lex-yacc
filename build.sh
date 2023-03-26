#!/bin/sh

yacc -d *.y
lex *.l

cc *.c -o paramfuncsegment
