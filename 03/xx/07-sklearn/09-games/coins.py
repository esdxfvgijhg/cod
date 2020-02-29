#!/usr/bin/python
from easyAI import TwoPlayersGame, id_solve, Human_Player, AI_Player  # This is a variant of the Game of Bones recipe given in the easyAI library
from easyAI.AI import TT


class LastCoinStanding(TwoPlayersGame):
    def __init__(self, players):
        self.players = players  # Define the players. Necessary parameter.
        self.nplayer = 1  # Define who starts the game. Necessary parameter.
        self.num_coins = 25  # Overall number of coins in the pile
        self.max_coins = 4  # Define max number of coins per move

    def possible_moves(self):  # Define possible moves
        return [str(x) for x in range(1, self.max_coins + 1)]

    def make_move(self, move):  # Remove coins
        self.num_coins -= int(move)

    def win(self):  # Did the opponent take the last coin?
        return self.num_coins <= 0

    def is_over(self):  # Stop the game when somebody wins
        return self.win()

    def scoring(self):  # Compute score
        return 100 if self.win() else 0

    def show(self):  # Show number of coins remaining in the pile
        print(self.num_coins, "coins left in the pile")


if __name__ == "__main__":
    tt = TT()  # Define the transposition table
    LastCoinStanding.ttentry = lambda self: self.num_coins  # Define the method
    result, depth, move = id_solve(LastCoinStanding, range(2, 20), win_score=100, tt=tt)  # Solve the game
    print(result, depth, move)
    game = LastCoinStanding([AI_Player(tt), Human_Player()])  # Start the game
    game.play()
