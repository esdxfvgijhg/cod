#!/usr/bin/python
from logpy import run, var, fact
import logpy.assoccomm as la

add = "addition"  # Define mathematical operations
mul = "multiplication"
fact(la.commutative, mul)  # using the facts system # Declare that these operations are commutative
fact(la.commutative, add)
fact(la.associative, mul)
fact(la.associative, add)
a, b, c = var("a"), var("b"), var("c")  # Define some variables
expression_orig = (add, (mul, 3, -2), (mul, (add, 1, (mul, 2, 3)), -1))  # Generate expressions
expression1 = (add, (mul, (add, 1, (mul, 2, a)), b), (mul, 3, c))
expression2 = (add, (mul, c, 3), (mul, b, (add, (mul, 2, a), 1)))
expression3 = (add, (add, (mul, (mul, 2, a), b), b), (mul, 3, c))
print(run(0, (a, b, c), la.eq_assoccomm(expression1, expression_orig)))  # Compare expressions
print(run(0, (a, b, c), la.eq_assoccomm(expression2, expression_orig)))
print(run(0, (a, b, c), la.eq_assoccomm(expression3, expression_orig)))
