#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt
from deap import algorithms, base, benchmarks, cma, creator, tools


def create_toolbox(strategy):  # Function to create a toolbox
    creator.create("FitnessMin", base.Fitness, weights=(-1.0,))
    creator.create("Individual", list, fitness=creator.FitnessMin)
    toolbox = base.Toolbox()
    toolbox.register("evaluate", benchmarks.rastrigin)
    np.random.seed(7)  # Seeed the random number generator
    toolbox.register("generate", strategy.generate, creator.Individual)
    toolbox.register("update", strategy.update)
    return toolbox


if __name__ == "__main__":
    num_individuals = 10  # Problem size
    num_generations = 125
    strategy = cma.Strategy(centroid=[5.0] * num_individuals, sigma=5.0, lambda_=20 * num_individuals)  # Create a strategy using CMA-ES algorithm
    toolbox = create_toolbox(strategy)  # Create toolbox based on the above strategy
    hall_of_fame = tools.HallOfFame(1)  # Create hall of fame object
    stats = tools.Statistics(lambda x: x.fitness.values)  # Register the relevant stats
    stats.register("avg", np.mean)
    stats.register("std", np.std)
    stats.register("min", np.min)
    stats.register("max", np.max)
    logbook = tools.Logbook()
    logbook.header = "gen", "evals", "std", "min", "avg", "max"
    sigma = np.ndarray((num_generations, 1))  # Objects that will compile the data
    axis_ratio = np.ndarray((num_generations, 1))
    diagD = np.ndarray((num_generations, num_individuals))
    fbest = np.ndarray((num_generations, 1))
    best = np.ndarray((num_generations, num_individuals))
    std = np.ndarray((num_generations, num_individuals))
    for gen in range(num_generations):
        population = toolbox.generate()  # Generate a new population
        fitnesses = toolbox.map(toolbox.evaluate, population)  # Evaluate the individuals
        for ind, fit in zip(population, fitnesses):
            ind.fitness.values = fit
        toolbox.update(population)  # Update the strategy with the evaluated individuals
        hall_of_fame.update(population)  # Update the hall of fame and the statistics with the currently evaluated population
        record = stats.compile(population)
        logbook.record(evals=len(population), gen=gen, **record)
        print(logbook.stream)
        sigma[gen] = strategy.sigma  # Save more data along the evolution
        axis_ratio[gen] = max(strategy.diagD) ** 2 / min(strategy.diagD) ** 2
        diagD[gen, :num_individuals] = strategy.diagD ** 2
        fbest[gen] = hall_of_fame[0].fitness.values
        best[gen, :num_individuals] = hall_of_fame[0]
        std[gen, :num_individuals] = np.std(population, axis=0)
    x = list(range(0, strategy.lambda_ * num_generations, strategy.lambda_))  # The x-axis will be the number of evaluations
    avg, max_, min_ = logbook.select("avg", "max", "min")
    plt.figure()
    plt.semilogy(x, avg, "--b")
    plt.semilogy(x, max_, "--b")
    plt.semilogy(x, min_, "-b")
    plt.semilogy(x, fbest, "-c")
    plt.semilogy(x, sigma, "-g")
    plt.semilogy(x, axis_ratio, "-r")
    plt.grid(True)
    plt.title("blue: f-values, green: sigma, red: axis ratio")
    plt.figure()
    plt.plot(x, best)
    plt.grid(True)
    plt.title("Object Variables")
    plt.figure()
    plt.semilogy(x, diagD)
    plt.grid(True)
    plt.title("Scaling (All Main Axes)")
    plt.figure()
    plt.semilogy(x, std)
    plt.grid(True)
    plt.title("Standard Deviations in All Coordinates")
    plt.show()
