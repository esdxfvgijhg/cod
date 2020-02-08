#!/usr/bin/python
import json
import numpy as np


def pearson_score(dataset, user1, user2):  # Returns the Pearson correlation score between user1 and user2
    if user1 not in dataset:
        raise TypeError("User " + user1 + " not present in the dataset")
    if user2 not in dataset:
        raise TypeError("User " + user2 + " not present in the dataset")
    rated_by_both = {}  # Movies rated by both user1 and user2
    for item in dataset[user1]:
        if item in dataset[user2]:
            rated_by_both[item] = 1
    num_ratings = len(rated_by_both)
    if num_ratings == 0:  # If there are no common movies, the score is 0
        return 0
    user1_sum = np.sum([dataset[user1][item] for item in rated_by_both])  # Compute the sum of ratings of all the common preferences
    user2_sum = np.sum([dataset[user2][item] for item in rated_by_both])
    user1_squared_sum = np.sum([np.square(dataset[user1][item]) for item in rated_by_both])  # Compute the sum of squared ratings of all the common preferences
    user2_squared_sum = np.sum([np.square(dataset[user2][item]) for item in rated_by_both])
    product_sum = np.sum([dataset[user1][item] * dataset[user2][item] for item in rated_by_both])  # Compute the sum of products of the common ratings
    Sxy = product_sum - (user1_sum * user2_sum / num_ratings)  # Compute the Pearson correlation
    Sxx = user1_squared_sum - np.square(user1_sum) / num_ratings
    Syy = user2_squared_sum - np.square(user2_sum) / num_ratings
    if Sxx * Syy == 0:
        return 0
    return Sxy / np.sqrt(Sxx * Syy)


if __name__ == "__main__":
    data_file = "movie_ratings.json"
    with open(data_file, "r") as f:
        data = json.loads(f.read())
    user1 = "John Carson"
    user2 = "Michelle Peterson"
    print "\nPearson score:"
    print pearson_score(data, user1, user2)
