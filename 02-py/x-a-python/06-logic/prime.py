#!/usr/bin/python
import itertools as it
import logpy.core as lc
from sympy.ntheory.generate import prime, isprime


def check_prime(x):  # Check if the elements of x are prime
    if lc.isvar(x):
        return lc.condeseq([(lc.eq, x, p)] for p in map(prime, it.count(1)))
    else:
        return lc.success if isprime(x) else lc.fail


x = lc.var()  # Declate the variable
list_nums = (23, 4, 27, 17, 13, 10, 21, 29, 3, 32, 11, 19)  # Check if an element in the list is a prime number
print("\nList of primes in the list:")
print(set(lc.run(0, x, (lc.membero, x, list_nums), (check_prime, x))))
print("\nList of first 7 prime numbers:")  # Print first 7 prime numbers
print(lc.run(7, x, check_prime(x)))
