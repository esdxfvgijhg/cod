#!/usr/bin/python
import numpy as np
from nltk.corpus import brown


def chunker(input_data, N):  # each chunk contains N words # Split the input text into chunks, where
    input_words = input_data.split(" ")
    output = []
    cur_chunk = []
    count = 0
    for word in input_words:
        cur_chunk.append(word)
        count += 1
        if count == N:
            output.append(" ".join(cur_chunk))
            count, cur_chunk = 0, []
    output.append(" ".join(cur_chunk))
    return output


if __name__ == "__main__":
    input_data = " ".join(brown.words()[:12000])  # Read the first 12000 words from the Brown corpus
    chunk_size = 700  # Define the number of words in each chunk
    chunks = chunker(input_data, chunk_size)
    print("\nNumber of text chunks =", len(chunks), "\n")
    for i, chunk in enumerate(chunks):
        print("Chunk", i + 1, "==>", chunk[:50])
