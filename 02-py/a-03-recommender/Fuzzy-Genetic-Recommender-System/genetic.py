#!/usr/bin/python
import numpy as np

INITIAL_POPULATION = 50  # Constants
MUTATION_RATE = 0.05
NUM_OF_GENERATIONS = 50
FEATURE_LENGTH = 21
WINNER_PER_GEN = 5


def cost_function(actual_ratings, predicted_ratings):
    """Cost function to optimize using genetic method."""
    ms = sum(abs(np.array(predicted_ratings) - np.array(actual_ratings)))
    return ms / len(actual_ratings)


def genetic_optimize(actual_ratings, predicted_ratings):
    """Get genetic feature weights using crossover and mutation."""
    cur_gen_pop = np.random.randint(2, size=(INITIAL_POPULATION, FEATURE_LENGTH))  # Generate initial binary population
    next_gen_pop = np.zeros((cur_gen_pop.shape[0], cur_gen_pop.shape[1]))
    fitness_vector = np.zeros((INITIAL_POPULATION, 2))
    for i in range(NUM_OF_GENERATIONS):
        fitness_vector = np.array([np.array([x, cost_function(actual_ratings, predicted_ratings)]) for x in range(INITIAL_POPULATION)])
        # create a winners array of size winner*solution # e.g. [0, 0.11] means that the 0th element in cur_gen_pop (first solution) has an error of 0.11
        winners = np.zeros((WINNER_PER_GEN, FEATURE_LENGTH))
        for n in range(len(winners)):
            selected = np.random.choice(range(len(fitness_vector)), int(WINNER_PER_GEN / 2), replace=False)  # select random indexes from pop
            wnr = np.argmin(fitness_vector[selected, 1])  # select one index with min fitness error (tournament)
            winners[n] = cur_gen_pop[int(fitness_vector[selected[wnr]][0])]  # add to winner population
        next_gen_pop[: len(winners)] = winners  # populate new gen with winners
        next_gen_pop[len(winners) :] = np.array([np.array(np.random.permutation(np.repeat(winners[:, x], ((INITIAL_POPULATION - len(winners)) / len(winners)), axis=0))) for x in range(winners.shape[1])]).T  # Populate the rest of the generation with offspring of mating pairs # mating using crossover via permutation
        next_gen_pop = np.multiply(next_gen_pop, np.matrix([np.float(np.random.normal(0, 2, 1)) if np.random.random() < MUTATION_RATE else 1 for x in range(next_gen_pop.size)]).reshape(next_gen_pop.shape))  # random mutation
        cur_gen_pop = next_gen_pop
    best_soln = np.array(cur_gen_pop[np.argmin(fitness_vector[:, 1])])
    return best_soln
