#!/usr/bin/python
import numpy as np
from nltk.corpus import brown
from chunking import splitter

if __name__ == "__main__":
    data = " ".join(brown.words()[:10000])  # Read the data from the Brown corpus
    num_words = 2000  # Number of words in each chunk
    chunks = []
    counter = 0
    text_chunks = splitter(data, num_words)
    for text in text_chunks:
        chunk = {"index": counter, "text": text}
        chunks.append(chunk)
        counter += 1
    from sklearn.feature_extraction.text import CountVectorizer  # Extract document term matrix

    vectorizer = CountVectorizer(min_df=5, max_df=0.95)
    doc_term_matrix = vectorizer.fit_transform([chunk["text"] for chunk in chunks])
    vocab = np.array(vectorizer.get_feature_names())
    print "\nVocabulary:"
    print vocab
    print "\nDocument term matrix:"
    chunk_names = ["Chunk-0", "Chunk-1", "Chunk-2", "Chunk-3", "Chunk-4"]
    formatted_row = "{:>12}" * (len(chunk_names) + 1)
    print "\n", formatted_row.format("Word", *chunk_names), "\n"
    for word, item in zip(vocab, doc_term_matrix.T):
        output = [str(x) for x in item.data]  # 'item' is a 'csr_matrix' data structure
        print formatted_row.format(word, *output)
