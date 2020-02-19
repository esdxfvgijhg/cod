#!/usr/bin/python
import random
from deap import base, creator, tools


def eval_func(individual):  # Evaluation function
    target_sum = 45
    return (len(individual) - abs(sum(individual) - target_sum),)


def create_toolbox(num_bits):  # Create the toolbox with the right parameters
    creator.create("FitnessMax", base.Fitness, weights=(1.0,))
    creator.create("Individual", list, fitness=creator.FitnessMax)
    toolbox = base.Toolbox()  # Initialize the toolbox
    toolbox.register("attr_bool", random.randint, 0, 1)  # Generate attributes
    toolbox.register("individual", tools.initRepeat, creator.Individual, toolbox.attr_bool, num_bits)  # Initialize structures
    toolbox.register("population", tools.initRepeat, list, toolbox.individual)  # Define the population to be a list of individuals
    toolbox.register("evaluate", eval_func)  # Register the evaluation operator
    toolbox.register("mate", tools.cxTwoPoint)  # Register the crossover operator
    toolbox.register("mutate", tools.mutFlipBit, indpb=0.05)  # Register a mutation operator
    toolbox.register("select", tools.selTournament, tournsize=3)  # Operator for selecting individuals for breeding
    return toolbox


if __name__ == "__main__":
    num_bits = 75  # Define the number of bits
    toolbox = create_toolbox(num_bits)  # Create a toolbox using the above parameter
    random.seed(7)  # Seed the random number generator
    population = toolbox.population(n=500)  # Create an initial population of 500 individuals
    probab_crossing, probab_mutating = 0.5, 0.2  # Define probabilities of crossing and mutating
    num_generations = 60  # Define the number of generations
    print("\nStarting the evolution process")
    fitnesses = list(map(toolbox.evaluate, population))  # Evaluate the entire population
    for ind, fit in zip(population, fitnesses):
        ind.fitness.values = fit
    print("\nEvaluated", len(population), "individuals")
    for g in range(num_generations):  # Iterate through generations
        print("\n===== Generation", g)
        offspring = toolbox.select(population, len(population))  # Select the next generation individuals
        offspring = list(map(toolbox.clone, offspring))  # Clone the selected individuals
        for child1, child2 in zip(offspring[::2], offspring[1::2]):  # Apply crossover and mutation on the offspring
            if random.random() < probab_crossing:  # Cross two individuals
                toolbox.mate(child1, child2)
                del child1.fitness.values  # "Forget" the fitness values of the children
                del child2.fitness.values
        for mutant in offspring:  # Apply mutation
            if random.random() < probab_mutating:  # Mutate an individual
                toolbox.mutate(mutant)
                del mutant.fitness.values
        invalid_ind = [ind for ind in offspring if not ind.fitness.valid]  # Evaluate the individuals with an invalid fitness
        fitnesses = map(toolbox.evaluate, invalid_ind)
        for ind, fit in zip(invalid_ind, fitnesses):
            ind.fitness.values = fit
        print("Evaluated", len(invalid_ind), "individuals")
        population[:] = offspring  # The population is entirely replaced by the offspring
        fits = [ind.fitness.values[0] for ind in population]  # Gather all the fitnesses in one list and print the stats
        length = len(population)
        mean = sum(fits) / length
        sum2 = sum(x * x for x in fits)
        std = abs(sum2 / length - mean ** 2) ** 0.5
        print("Min =", min(fits), ", Max =", max(fits))
        print("Average =", round(mean, 2), ", Standard deviation =", round(std, 2))
    print("\n==== End of evolution")
    best_ind = tools.selBest(population, 1)[0]
    print("\nBest individual:\n", best_ind)
    print("\nNumber of ones:", sum(best_ind))
