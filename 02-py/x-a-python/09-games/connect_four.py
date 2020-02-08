#!/usr/bin/python
import numpy as np  # This is a variant of the Connect Four recipe given in the easyAI library
from easyAI import TwoPlayersGame, Human_Player, AI_Player, Negamax, SSS


class GameController(TwoPlayersGame):
    def __init__(self, players, board=None):
        self.players = players  # Define the players
        self.board = board if (board != None) else (np.array([[0 for i in range(7)] for j in range(6)]))  # Define the configuration of the board
        self.nplayer = 1  # Define who starts the game
        self.pos_dir = np.array([[[i, 0], [0, 1]] for i in range(6)] + [[[0, i], [1, 0]] for i in range(7)] + [[[i, 0], [1, 1]] for i in range(1, 3)] + [[[0, i], [1, 1]] for i in range(4)] + [[[i, 6], [1, -1]] for i in range(1, 3)] + [[[0, i], [1, -1]] for i in range(3, 7)])  # Define the positions

    def possible_moves(self):  # Define possible moves
        return [i for i in range(7) if (self.board[:, i].min() == 0)]

    def make_move(self, column):  # Define how to make the move
        line = np.argmin(self.board[:, column] != 0)
        self.board[line, column] = self.nplayer

    def show(self):  # Show the current status
        print("\n" + "\n".join(["0 1 2 3 4 5 6", 13 * "-"] + [" ".join([[".", "O", "X"][self.board[5 - j][i]] for i in range(7)]) for j in range(6)]))

    def loss_condition(self):  # Define what a loss_condition looks like
        for pos, direction in self.pos_dir:
            streak = 0
            while (0 <= pos[0] <= 5) and (0 <= pos[1] <= 6):
                if self.board[pos[0], pos[1]] == self.nopponent:
                    streak += 1
                    if streak == 4:
                        return True
                else:
                    streak = 0
                pos = pos + direction
        return False

    def is_over(self):  # Check if the game is over
        return (self.board.min() > 0) or self.loss_condition()

    def scoring(self):  # Compute the score
        return -100 if self.loss_condition() else 0


if __name__ == "__main__":
    algo_neg = Negamax(5)  # Define the algorithms that will be used
    algo_sss = SSS(5)
    game = GameController([AI_Player(algo_neg), AI_Player(algo_sss)])  # Start the game
    game.play()
    if game.loss_condition():  # Print the result
        print("\nPlayer", game.nopponent, "wins.")
    else:
        print("\nIt's a draw.")
