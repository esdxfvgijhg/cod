#!/usr/bin/python
from logpy import run, fact, eq, Relation, var

adjacent = Relation()
coastal = Relation()
file_coastal = "coastal_states.txt"
file_adjacent = "adjacent_states.txt"
with open(file_coastal, "r") as f:  # Read the file containing the coastal states
    line = f.read()
    coastal_states = line.split(",")
for state in coastal_states:  # Add the info to the fact base
    fact(coastal, state)
with open(file_adjacent, "r") as f:  # Read the file containing the coastal states
    adjlist = [line.strip().split(",") for line in f if line and line[0].isalpha()]
for L in adjlist:  # Add the info to the fact base
    head, tail = L[0], L[1:]
    for state in tail:
        fact(adjacent, head, state)
x = var()  # Initialize the variables
y = var()
output = run(0, x, adjacent("Nevada", "Louisiana"))  # Is Nevada adjacent to Louisiana?
print("\nIs Nevada adjacent to Louisiana?:")
print("Yes" if len(output) else "No")
output = run(0, x, adjacent("Oregon", x))  # States adjacent to Oregon
print("\nList of states adjacent to Oregon:")
for item in output:
    print(item)
output = run(0, x, adjacent("Mississippi", x), coastal(x))  # States adjacent to Mississippi that are coastal
print("\nList of coastal states adjacent to Mississippi:")
for item in output:
    print(item)
n = 7  # List of 'n' states that border a coastal state
output = run(n, x, coastal(y), adjacent(x, y))
print("\nList of " + str(n) + " states that border a coastal state:")
for item in output:
    print(item)
output = run(0, x, adjacent("Arkansas", x), adjacent("Kentucky", x))  # List of states that adjacent to the two given states
print("\nList of states that are adjacent to Arkansas and Kentucky:")
for item in output:
    print(item)
