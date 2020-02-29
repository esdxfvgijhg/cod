#!/usr/bin/python
from nltk.tokenize import RegexpTokenizer
from nltk.stem.snowball import SnowballStemmer
from gensim import models, corpora
from nltk.corpus import stopwords


def load_data(input_file):  # Load input data
    data = []
    with open(input_file, "r") as f:
        for line in f.readlines():
            data.append(line[:-1])
    return data


class Preprocessor(object):  # Class to preprocess text
    def __init__(self):  # Initialize various operators
        self.tokenizer = RegexpTokenizer(r"\w+")  # Create a regular expression tokenizer
        self.stop_words_english = stopwords.words("english")  # get the list of stop words
        self.stemmer = SnowballStemmer("english")  # Create a Snowball stemmer

    def process(self, input_text):  # Tokenizing, stop word removal, and stemming
        tokens = self.tokenizer.tokenize(input_text.lower())  # Tokenize the string
        tokens_stopwords = [x for x in tokens if not x in self.stop_words_english]  # Remove the stop words
        tokens_stemmed = [self.stemmer.stem(x) for x in tokens_stopwords]  # Perform stemming on the tokens
        return tokens_stemmed


if __name__ == "__main__":
    input_file = "data_topic_modeling.txt"  # File containing linewise input data
    data = load_data(input_file)  # Load data
    preprocessor = Preprocessor()  # Create a preprocessor object
    processed_tokens = [preprocessor.process(x) for x in data]  # Create a list for processed documents
    dict_tokens = corpora.Dictionary(processed_tokens)  # Create a dictionary based on the tokenized documents
    corpus = [dict_tokens.doc2bow(text) for text in processed_tokens]  # Create a document-term matrix
    num_topics = 2  # Generate the LDA model based on the corpus we just created
    num_words = 4
    ldamodel = models.ldamodel.LdaModel(corpus, num_topics=num_topics, id2word=dict_tokens, passes=25)
    print "\nMost contributing words to the topics:"
    for item in ldamodel.print_topics(num_topics=num_topics, num_words=num_words):
        print "\nTopic", item[0], "==>", item[1]
