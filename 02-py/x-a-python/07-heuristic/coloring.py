#!/usr/bin/python
from simpleai.search import CspProblem, backtrack


def constraint_func(names, values):  # that neighbors should be different # Define the function that imposes the constraint
    return values[0] != values[1]


if __name__ == "__main__":
    names = ("Mark", "Julia", "Steve", "Amanda", "Brian", "Joanne", "Derek", "Allan", "Michelle", "Kelly")  # Specify the variables
    colors = dict((name, ["red", "green", "blue", "gray"]) for name in names)  # Define the possible colors
    constraints = [  # Define the constraints
        (("Mark", "Julia"), constraint_func),
        (("Mark", "Steve"), constraint_func),
        (("Julia", "Steve"), constraint_func),
        (("Julia", "Amanda"), constraint_func),
        (("Julia", "Derek"), constraint_func),
        (("Julia", "Brian"), constraint_func),
        (("Steve", "Amanda"), constraint_func),
        (("Steve", "Allan"), constraint_func),
        (("Steve", "Michelle"), constraint_func),
        (("Amanda", "Michelle"), constraint_func),
        (("Amanda", "Joanne"), constraint_func),
        (("Amanda", "Derek"), constraint_func),
        (("Brian", "Derek"), constraint_func),
        (("Brian", "Kelly"), constraint_func),
        (("Joanne", "Michelle"), constraint_func),
        (("Joanne", "Amanda"), constraint_func),
        (("Joanne", "Derek"), constraint_func),
        (("Joanne", "Kelly"), constraint_func),
        (("Derek", "Kelly"), constraint_func),
    ]
    problem = CspProblem(names, colors, constraints)  # Solve the problem
    output = backtrack(problem)  # Print the solution
    print("\nColor mapping:\n")
    for k, v in output.items():
        print(k, "==>", v)
