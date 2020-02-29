#!/usr/bin/python
from logpy import *
from logpy.core import lall

people = var()  # Declare the variable
rules = lall((eq, (var(), var(), var(), var()), people), (membero, ("Steve", var(), "blue", var()), people), (membero, (var(), "cat", var(), "Canada"), people), (membero, ("Matthew", var(), var(), "USA"), people), (membero, (var(), var(), "black", "Australia"), people), (membero, ("Jack", "cat", var(), var()), people), (membero, ("Alfred", var(), var(), "Australia"), people), (membero, (var(), "dog", var(), "France"), people), (membero, (var(), "rabbit", var(), var()), people),)  # Define the rules  # There are 4 people  # Steve's car is blue  # Person who owns the cat lives in Canada  # Matthew lives in USA  # The person who has a black car lives in Australia  # Jack has a cat  # Alfred lives in Australia  # Person who owns the dog lives in France  # Who is the owner of the rabbit?
solutions = run(0, people, rules)  # Run the solver
output = [house for house in solutions[0] if "rabbit" in house][0][0]  # Extract the output
print("\n" + output + " is the owner of the rabbit")  # Print the output
print("\nHere are all the details:")
attribs = ["Name", "Pet", "Color", "Country"]
print("\n" + "\t\t".join(attribs))
print("=" * 57)
for item in solutions[0]:
    print("")
    print("\t\t".join([str(x) for x in item]))
