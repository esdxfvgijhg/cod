#!/usr/bin/python
from nltk.tokenize import RegexpTokenizer
from nltk.corpus import stopwords
from nltk.stem.snowball import SnowballStemmer
from gensim import models, corpora


def load_data(input_file):  # Load input data
    data = []
    with open(input_file, "r") as f:
        for line in f.readlines():
            data.append(line[:-1])
    return data


def process(input_text):  # words, and stemming # Processor function for tokenizing, removing stop
    tokenizer = RegexpTokenizer(r"\w+")  # Create a regular expression tokenizer
    stemmer = SnowballStemmer("english")  # Create a Snowball stemmer
    stop_words = stopwords.words("english")  # Get the list of stop words
    tokens = tokenizer.tokenize(input_text.lower())  # Tokenize the input string
    tokens = [x for x in tokens if not x in stop_words]  # Remove the stop words
    tokens_stemmed = [stemmer.stem(x) for x in tokens]  # Perform stemming on the tokenized words
    return tokens_stemmed


if __name__ == "__main__":
    data = load_data("data.txt")  # Load input data
    tokens = [process(x) for x in data]  # Create a list for sentence tokens
    dict_tokens = corpora.Dictionary(tokens)  # Create a dictionary based on the sentence tokens
    doc_term_mat = [dict_tokens.doc2bow(token) for token in tokens]  # Create a document-term matrix
    num_topics = 2  # Define the number of topics for the LDA model
    ldamodel = models.ldamodel.LdaModel(doc_term_mat, num_topics=num_topics, id2word=dict_tokens, passes=25)  # Generate the LDA model
    num_words = 5
    print("\nTop " + str(num_words) + " contributing words to each topic:")
    for item in ldamodel.print_topics(num_topics=num_topics, num_words=num_words):
        print("\nTopic", item[0])
        list_of_strings = item[1].split(" + ")  # Print the contributing words along with their relative contributions
        for text in list_of_strings:
            weight = text.split("*")[0]
            word = text.split("*")[1]
            print(word, "==>", str(round(float(weight) * 100, 2)) + "%")
