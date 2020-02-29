#!/usr/bin/python
import numpy as np
from sklearn.feature_extraction.text import CountVectorizer
from nltk.corpus import brown
from text_chunker import chunker

input_data = " ".join(brown.words()[:5400])  # Read the data from the Brown corpus
chunk_size = 800  # Number of words in each chunk
text_chunks = chunker(input_data, chunk_size)
chunks = []  # Convert to dict items
for count, chunk in enumerate(text_chunks):
    d = {"index": count, "text": chunk}
    chunks.append(d)
count_vectorizer = CountVectorizer(min_df=7, max_df=20)  # Extract the document term matrix
document_term_matrix = count_vectorizer.fit_transform([chunk["text"] for chunk in chunks])
vocabulary = np.array(count_vectorizer.get_feature_names())  # Extract the vocabulary and display it
print("\nVocabulary:\n", vocabulary)
chunk_names = []  # Generate names for chunks
for i in range(len(text_chunks)):
    chunk_names.append("Chunk-" + str(i + 1))
print("\nDocument term matrix:")  # Print the document term matrix
formatted_text = "{:>12}" * (len(chunk_names) + 1)
print("\n", formatted_text.format("Word", *chunk_names), "\n")
for word, item in zip(vocabulary, document_term_matrix.T):
    output = [word] + [str(freq) for freq in item.data]  # 'item' is a 'csr_matrix' data structure
    print(formatted_text.format(*output))
