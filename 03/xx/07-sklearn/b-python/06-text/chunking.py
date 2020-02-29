#!/usr/bin/python
import numpy as np
from nltk.corpus import brown


def splitter(data, num_words):  # Split a text into chunks
    words = data.split(" ")
    output = []
    cur_count = 0
    cur_words = []
    for word in words:
        cur_words.append(word)
        cur_count += 1
        if cur_count == num_words:
            output.append(" ".join(cur_words))
            cur_words = []
            cur_count = 0
    output.append(" ".join(cur_words))
    return output


if __name__ == "__main__":
    data = " ".join(brown.words()[:10000])  # Read the data from the Brown corpus
    num_words = 1700  # Number of words in each chunk
    chunks = []
    counter = 0
    text_chunks = splitter(data, num_words)
    print "Number of text chunks =", len(text_chunks)
