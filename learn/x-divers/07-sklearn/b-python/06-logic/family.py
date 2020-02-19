#!/usr/bin/python
import json
from logpy import Relation, facts, run, conde, var, eq


def parent(x, y):  # Check if 'x' is the parent of 'y'
    return conde([father(x, y)], [mother(x, y)])


def grandparent(x, y):  # Check if 'x' is the grandparent of 'y'
    temp = var()
    return conde((parent(x, temp), parent(temp, y)))


def sibling(x, y):  # Check for sibling relationship between 'a' and 'b'
    temp = var()
    return conde((parent(temp, x), parent(temp, y)))


def uncle(x, y):  # Check if x is y's uncle
    temp = var()
    return conde((father(temp, x), grandparent(temp, y)))


if __name__ == "__main__":
    father = Relation()
    mother = Relation()
    with open("relationships.json") as f:
        d = json.loads(f.read())
    for item in d["father"]:
        facts(father, (list(item.keys())[0], list(item.values())[0]))
    for item in d["mother"]:
        facts(mother, (list(item.keys())[0], list(item.values())[0]))
    x = var()
    name = "John"  # John's children
    output = run(0, x, father(name, x))
    print("\nList of " + name + "'s children:")
    for item in output:
        print(item)
    name = "William"  # William's mother
    output = run(0, x, mother(x, name))[0]
    print("\n" + name + "'s mother:\n" + output)
    name = "Adam"  # Adam's parents
    output = run(0, x, parent(x, name))
    print("\nList of " + name + "'s parents:")
    for item in output:
        print(item)
    name = "Wayne"  # Wayne's grandparents
    output = run(0, x, grandparent(x, name))
    print("\nList of " + name + "'s grandparents:")
    for item in output:
        print(item)
    name = "Megan"  # Megan's grandchildren
    output = run(0, x, grandparent(name, x))
    print("\nList of " + name + "'s grandchildren:")
    for item in output:
        print(item)
    name = "David"  # David's siblings
    output = run(0, x, sibling(x, name))
    siblings = [x for x in output if x != name]
    print("\nList of " + name + "'s siblings:")
    for item in siblings:
        print(item)
    name = "Tiffany"  # Tiffany's uncles
    name_father = run(0, x, father(x, name))[0]
    output = run(0, x, uncle(x, name))
    output = [x for x in output if x != name_father]
    print("\nList of " + name + "'s uncles:")
    for item in output:
        print(item)
    a, b, c = var(), var(), var()  # All spouses
    output = run(0, (a, b), (father, a, c), (mother, b, c))
    print("\nList of all spouses:")
    for item in output:
        print("Husband:", item[0], "<==> Wife:", item[1])
