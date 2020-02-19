#!/usr/bin/python
from simpleai.search import astar, SearchProblem


class PuzzleSolver(SearchProblem):  # Class containing methods to solve the puzzle
    def actions(self, cur_state):  # numbers that can be moved in to the empty space # Action method to get the list of the possible
        rows = string_to_list(cur_state)
        row_empty, col_empty = get_location(rows, "e")
        actions = []
        if row_empty > 0:
            actions.append(rows[row_empty - 1][col_empty])
        if row_empty < 2:
            actions.append(rows[row_empty + 1][col_empty])
        if col_empty > 0:
            actions.append(rows[row_empty][col_empty - 1])
        if col_empty < 2:
            actions.append(rows[row_empty][col_empty + 1])
        return actions

    def result(self, state, action):  # Return the resulting state after moving a piece to the empty space
        rows = string_to_list(state)
        row_empty, col_empty = get_location(rows, "e")
        row_new, col_new = get_location(rows, action)
        rows[row_empty][col_empty], rows[row_new][col_new] = rows[row_new][col_new], rows[row_empty][col_empty]
        return list_to_string(rows)

    def is_goal(self, state):  # Returns true if a state is the goal state
        return state == GOAL

    def heuristic(self, state):  # the goal using the manhattan distance # Returns an estimate of the distance from a state to
        rows = string_to_list(state)
        distance = 0
        for number in "12345678e":
            row_new, col_new = get_location(rows, number)
            row_new_goal, col_new_goal = goal_positions[number]
            distance += abs(row_new - row_new_goal) + abs(col_new - col_new_goal)
        return distance


def list_to_string(input_list):  # Convert list to string
    return "\n".join(["-".join(x) for x in input_list])


def string_to_list(input_string):  # Convert string to list
    return [x.split("-") for x in input_string.split("\n")]


def get_location(rows, input_element):  # Find the 2D location of the input element
    for i, row in enumerate(rows):
        for j, item in enumerate(row):
            if item == input_element:
                return i, j


GOAL = """1-2-3 # Final result that we want to achieve
4-5-6
7-8-e"""
INITIAL = """1-e-2 # Starting point
6-3-4
7-5-8"""
goal_positions = {}  # Create a cache for the goal position of each piece
rows_goal = string_to_list(GOAL)
for number in "12345678e":
    goal_positions[number] = get_location(rows_goal, number)
result = astar(PuzzleSolver(INITIAL))  # Create the solver object
for i, (action, state) in enumerate(result.path()):  # Print the results
    print()
    if action == None:
        print("Initial configuration")
    elif i == len(result.path()) - 1:
        print("After moving", action, "into the empty space. Goal achieved!")
    else:
        print("After moving", action, "into the empty space")
    print(state)
