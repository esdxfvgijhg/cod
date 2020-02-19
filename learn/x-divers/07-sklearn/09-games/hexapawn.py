#!/usr/bin/python
from easyAI import TwoPlayersGame, AI_Player, Human_Player, Negamax  # This is a variant of the Hexapawn recipe given in the easyAI library


class GameController(TwoPlayersGame):
    def __init__(self, players, size=(4, 4)):
        self.size = size
        num_pawns, len_board = size
        p = [[(i, j) for j in range(len_board)] for i in [0, num_pawns - 1]]
        for i, d, goal, pawns in [(0, 1, num_pawns - 1, p[0]), (1, -1, 0, p[1])]:
            players[i].direction = d
            players[i].goal_line = goal
            players[i].pawns = pawns
        self.players = players  # Define the players
        self.nplayer = 1  # Define who starts first
        self.alphabets = "ABCDEFGHIJ"  # Define the alphabets
        self.to_tuple = lambda s: (self.alphabets.index(s[0]), int(s[1:]) - 1)  # Convert B4 to (1, 3)
        self.to_string = lambda move: " ".join([self.alphabets[move[i][0]] + str(move[i][1] + 1) for i in (0, 1)])  # Convert (1, 3) to B4

    def possible_moves(self):  # Define the possible moves
        moves = []
        opponent_pawns = self.opponent.pawns
        d = self.player.direction
        for i, j in self.player.pawns:
            if (i + d, j) not in opponent_pawns:
                moves.append(((i, j), (i + d, j)))
            if (i + d, j + 1) in opponent_pawns:
                moves.append(((i, j), (i + d, j + 1)))
            if (i + d, j - 1) in opponent_pawns:
                moves.append(((i, j), (i + d, j - 1)))
        return list(map(self.to_string, [(i, j) for i, j in moves]))

    def make_move(self, move):  # Define how to make a move
        move = list(map(self.to_tuple, move.split(" ")))
        ind = self.player.pawns.index(move[0])
        self.player.pawns[ind] = move[1]
        if move[1] in self.opponent.pawns:
            self.opponent.pawns.remove(move[1])

    def loss_condition(self):  # Define what a loss looks like
        return any([i == self.opponent.goal_line for i, j in self.opponent.pawns]) or (self.possible_moves() == [])

    def is_over(self):  # Check if the game is over
        return self.loss_condition()

    def show(self):  # Show the current status
        f = lambda x: "1" if x in self.players[0].pawns else ("2" if x in self.players[1].pawns else ".")
        print("\n".join([" ".join([f((i, j)) for j in range(self.size[1])]) for i in range(self.size[0])]))


if __name__ == "__main__":
    scoring = lambda game: -100 if game.loss_condition() else 0  # Compute the score
    algorithm = Negamax(12, scoring)  # Define the algorithm
    game = GameController([AI_Player(algorithm), AI_Player(algorithm)])  # Start the game
    game.play()
    print("\nPlayer", game.nopponent, "wins after", game.nmove, "turns")
