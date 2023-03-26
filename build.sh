#!/bin/sh

set -e
set -x
bison -d param_func_segment.y
flex param_func_segment.l

cc *.c -o paramfuncsegment
