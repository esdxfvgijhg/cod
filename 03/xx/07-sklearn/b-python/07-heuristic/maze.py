#!/usr/bin/python
import math
from simpleai.search import SearchProblem, astar


class MazeSolver(SearchProblem):  # Class containing the methods to solve the maze
    def __init__(self, board):  # Initialize the class
        self.board = board
        self.goal = (0, 0)
        for y in range(len(self.board)):
            for x in range(len(self.board[y])):
                if self.board[y][x].lower() == "o":
                    self.initial = (x, y)
                elif self.board[y][x].lower() == "x":
                    self.goal = (x, y)
        super(MazeSolver, self).__init__(initial_state=self.initial)

    def actions(self, state):  # to arrive at the solution # Define the method that takes actions
        actions = []
        for action in COSTS.keys():
            newx, newy = self.result(state, action)
            if self.board[newy][newx] != "#":
                actions.append(action)
        return actions

    def result(self, state, action):  # Update the state based on the action
        x, y = state
        if action.count("up"):
            y -= 1
        if action.count("down"):
            y += 1
        if action.count("left"):
            x -= 1
        if action.count("right"):
            x += 1
        new_state = (x, y)
        return new_state

    def is_goal(self, state):  # Check if we have reached the goal
        return state == self.goal

    def cost(self, state, action, state2):  # Compute the cost of taking an action
        return COSTS[action]

    def heuristic(self, state):  # Heuristic that we use to arrive at the solution
        x, y = state
        gx, gy = self.goal
        return math.sqrt((x - gx) ** 2 + (y - gy) ** 2)


if __name__ == "__main__":
    MAP = """ # Define the map
    #     #####    #    #  # x   # #      #     #   #  #  #   ### #      #   ###   #           # #    ###     #####  ######   # #  o #    #              #   # # ####    ########       #   # #         #              #   # ##############################
    """  ############################## #              #       #     #
    print(MAP)  # Convert map to a list
    MAP = [list(x) for x in MAP.split("\n") if x]
    cost_regular = 1.0  # Define cost of moving around the map
    cost_diagonal = 1.7
    COSTS = {  # Create the cost dictionary
        "up": cost_regular,
        "down": cost_regular,
        "left": cost_regular,
        "right": cost_regular,
        "up left": cost_diagonal,
        "up right": cost_diagonal,
        "down left": cost_diagonal,
        "down right": cost_diagonal,
    }
    problem = MazeSolver(MAP)  # Create maze solver object
    result = astar(problem, graph_search=True)  # Run the solver
    path = [x[1] for x in result.path()]  # Extract the path
    print()  # Print the result
    for y in range(len(MAP)):
        for x in range(len(MAP[y])):
            if (x, y) == problem.initial:
                print("o", end="")
            elif (x, y) == problem.goal:
                print("x", end="")
            elif (x, y) in path:
                print("·", end="")
            else:
                print(MAP[y][x], end="")
        print()
