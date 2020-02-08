#!/usr/bin/python
from easyAI import TwoPlayersGame, AI_Player, Negamax  # This is a variant of the Tic Tac Toe recipe given in the easyAI library
from easyAI.Player import Human_Player


class GameController(TwoPlayersGame):
    def __init__(self, players):
        self.players = players  # Define the players
        self.nplayer = 1  # Define who starts the game
        self.board = [0] * 9  # Define the board

    def possible_moves(self):  # Define possible moves
        return [a + 1 for a, b in enumerate(self.board) if b == 0]

    def make_move(self, move):  # Make a move
        self.board[int(move) - 1] = self.nplayer

    def loss_condition(self):  # Does the opponent have three in a line?
        possible_combinations = [
            [1, 2, 3],
            [4, 5, 6],
            [7, 8, 9],
            [1, 4, 7],
            [2, 5, 8],
            [3, 6, 9],
            [1, 5, 9],
            [3, 5, 7],
        ]
        return any([all([(self.board[i - 1] == self.nopponent) for i in combination]) for combination in possible_combinations])

    def is_over(self):  # Check if the game is over
        return (self.possible_moves() == []) or self.loss_condition()

    def show(self):  # Show current position
        print("\n" + "\n".join([" ".join([[".", "O", "X"][self.board[3 * j + i]] for i in range(3)]) for j in range(3)]))

    def scoring(self):  # Compute the score
        return -100 if self.loss_condition() else 0


if __name__ == "__main__":
    algorithm = Negamax(7)  # Define the algorithm
    GameController([Human_Player(), AI_Player(algorithm)]).play()  # Start the game
