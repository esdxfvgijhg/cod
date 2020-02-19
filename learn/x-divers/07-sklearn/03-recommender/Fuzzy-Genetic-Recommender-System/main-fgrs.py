#!/usr/bin/python
""""""
import pandas as pd  # Import pandas and numpy
import numpy as np
import operator
from settings import NO_OF_GENRES, NO_OF_FEATURES
import load_data
import fuzzy_sets
import gim
from genetic import genetic_optimize, cost_function

WEIGHTS = np.random.rand(NO_OF_FEATURES)  # Constants
NO_OF_ITERATIONS = 10
NO_OF_NEIGHBOURS = 20
items_merged = load_data.items_merged  # namespace items_merged from load_data file
age = fuzzy_sets.Age()  # Create objects for Age and GIM to use for fuzzy sets
gim_obj = fuzzy_sets.GIM()
m_cols = ["unknown", "Action", "Adventure", "Animation", "Children's", "Comedy", "Crime", "Documentary", "Drama", "Fantasy", "Film-Noir", "Horror", "Musical", "Mystery", "Romance", "Sci-Fi", "Thriller", "War", "Western", "age", "user_id"]
model_data_active_users = pd.DataFrame(columns=m_cols)  # Initialize empty dataFrames for active and passive users
model_data_passive_users = pd.DataFrame(columns=m_cols)


def euclidean_dist(list_a, list_b):
    """Return the Euclidean distance between two array elements."""
    return np.linalg.norm(np.array(list_a) - np.array(list_b))


def fuzzy_dist(first_point, second_point, fuzzy_set_first_point, fuzzy_set_second_point):
    """Returns fuzzy distance between two values and their fuzzy sets."""
    return abs(first_point - second_point) * euclidean_dist(fuzzy_set_first_point, fuzzy_set_second_point)


def fuzzy_distance(ui, uj):
    """Returns fuzzy distance between given points."""
    fuzzy_dis = [0] * NO_OF_FEATURES
    for i in range(0, NO_OF_GENRES):  # Get fuzzy set values for movie genres
        ui_gim = gim_obj.get_fuzzy_set(ui[i])
        uj_gim = gim_obj.get_fuzzy_set(uj[i])
        fuzzy_dis[i] = fuzzy_dist(ui[i], uj[i], ui_gim, uj_gim)
    ui_gim = age.get_fuzzy_set(ui[i])  # Get fuzzy set values for age
    uj_gim = age.get_fuzzy_set(uj[i])
    fuzzy_dis[i] = fuzzy_dist(ui[i], uj[i], ui_gim, uj_gim)
    fuzzy_dis[NO_OF_FEATURES - 1] = uj["user_id"]  # adding user_id of second user
    return fuzzy_dis


def get_neighbours(model_active_users, model_passive_users):
    user_neighbours = pd.DataFrame(columns=model_active_users["user_id"])  # Save active users and its neighbours in a data-frame with active users' id as column name
    for _, value in model_active_users.iterrows():  # Iterate over active users model and save neighbours of each active users in user_neighbours
        j = 0
        fuzzy_vec = []
        for _, value_p in model_passive_users.iterrows():
            fuzzy_vec.append(fuzzy_distance(value, value_p))
            fuzzy_gen_dist = np.sum(np.multiply(WEIGHTS[:-1], np.array(fuzzy_vec[j][:-1]))) ** 0.5
            fuzzy_vec[j] = [fuzzy_gen_dist, fuzzy_vec[j][-1]]
            j = j + 1
        user_neighbours[value[-1]] = [n[1] for n in sorted(fuzzy_vec, key=operator.itemgetter(0), reverse=True)][:NO_OF_NEIGHBOURS]
    return user_neighbours


def model_for_users(users_data):
    """Create model for given users data i.e. merged movies, items, and users
    Args:
        users_data: DataFrame of merged movies, items, and users based on movie_id
    """
    i = 0
    model_data_for_users = pd.DataFrame(columns=m_cols)
    for _, curr_value in users_data.iterrows():
        user_movies = items_merged.loc[items_merged["user_id"] == curr_value["user_id"]]  # Get user movies based on user
        feature_array = gim.gim_final(user_movies, curr_value["user_id"])  # Get feature list for all movies of one user
        feature_array[NO_OF_GENRES] = curr_value["age"]
        feature_array[NO_OF_GENRES + 1] = curr_value["user_id"]
        model_data_for_users.loc[i] = feature_array  # Save current feature values in model data
        i = i + 1
    return model_data_for_users


def recommend(nearest_neighbours, test_users_data):
    """Recommend rating for given movies i.e. test_examples based on nearest neighbours.
    Also return actual and predicated ratings for testing users
    """
    predicated_rat = []
    actual_rat = []
    for key, item in test_users_data.iterrows():
        m_id = item["movie_id"]
        n_ratings = []
        for i in nearest_neighbours:
            temp = items_merged.loc[items_merged["user_id"] == i].loc[items_merged["movie_id"] == m_id]  # Get items or movie details reviewed by neighbour i with given m_id
            for k, it in temp.iterrows():
                n_ratings.append(it["rating"])
        predicated_rat.append(float(sum(n_ratings)) / len(n_ratings) if len(n_ratings) else 0)
        actual_rat.append(item["rating"])
    return actual_rat, predicated_rat


top_users = load_data.items_merged.groupby("user_id").size().sort_values(ascending=False)[:497]  # Users who has rated movies at least 60 movies
model_error = []
for i in range(0, NO_OF_ITERATIONS):  # Train model for given iterations
    active_users = top_users.sample(frac=0.10)  # Get random 10% of the top_users as active users and remaining are passive users
    training_active_users = active_users.sample(frac=0.34)  # Random 34% of active users will be used for training and 66% users for testing purpose.
    # passive_users will be used as training examples # testing_active_users = active_users.drop(training_active_users.index)
    passive_users = top_users.drop(active_users.index)
    training_active_users_data = items_merged.loc[items_merged["user_id"].isin(training_active_users)][:10]  # Get active and passive users' data from merged movies, items, and users
    test_active_users_data = items_merged.loc[items_merged["user_id"].isin(training_active_users)][10:]
    passive_users_data = items_merged.loc[items_merged["user_id"].isin(passive_users)][:10]
    model_data_active_users = model_for_users(training_active_users_data)  # Get model for active users
    model_data_passive_users = model_for_users(passive_users_data)  # Get model for passive users
    active_users_neighbours = get_neighbours(model_data_active_users, model_data_passive_users)  # Get neighbour users of active users
    actual_ratings, predicated_ratings = recommend(active_users_neighbours, test_active_users_data)  # Recommend users based on neighbours
    cur_error = cost_function(actual_ratings, predicated_ratings)  # Get error for predictions of test users
    WEIGHTS = genetic_optimize(actual_ratings, predicated_ratings).flatten()  # Optimize weights using genetic algorithm approach and update weighs
    model_error.append(cost_function(actual_ratings, predicated_ratings))  # Add current iteration error to model error for MAE of the model
    print("Iteration : ", i)  # Log details for current iteration
    print("Error: ", cur_error)
    print("Weights after iteration is: ", WEIGHTS)
print("Mean absolute error for all iterations: ", sum(model_error) / len(model_error))
