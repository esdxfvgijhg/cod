#!/usr/bin/python
import pandas as pd

u_cols = ["user_id", "age", "sex", "occupation", "zip_code"]  # Load users
users = pd.read_csv("ml-100k/u.user", sep="|", names=u_cols, encoding="latin-1")
r_cols = ["user_id", "movie_id", "rating", "unix_timestamp"]  # Load ratings
ratings = pd.read_csv("ml-100k/u.data", sep="\t", names=r_cols, encoding="latin-1")
i_cols = ["movie_id", "movie_title", "release date", "video release date", "IMDb URL", "unknown", "Action", "Adventure", "Animation", "Children's", "Comedy", "Crime", "Documentary", "Drama", "Fantasy", "Film-Noir", "Horror", "Musical", "Mystery", "Romance", "Sci-Fi", "Thriller", "War", "Western"]  # Load genres
items = pd.read_csv("ml-100k/u.item", sep="|", names=i_cols, encoding="latin-1")
movies_users_ratings = pd.merge(users, ratings, on="user_id")  # Merge users and ratings on user_id
items_merged = pd.merge(movies_users_ratings, items, on="movie_id")  # Merge movies_users_ratings and items on movie_id
