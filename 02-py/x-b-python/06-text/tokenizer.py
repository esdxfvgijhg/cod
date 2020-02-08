#!/usr/bin/python
text = "Are you curious about tokenization? Let's see how it works! We need to analyze a couple of sentences with punctuations to see it in action."
from nltk.tokenize import sent_tokenize  # Sentence tokenization

sent_tokenize_list = sent_tokenize(text)
print "\nSentence tokenizer:"
print sent_tokenize_list
from nltk.tokenize import word_tokenize  # Create a new word tokenizer

print "\nWord tokenizer:"
print word_tokenize(text)
from nltk.tokenize import PunktWordTokenizer  # Create a new punkt word tokenizer

punkt_word_tokenizer = PunktWordTokenizer()
print "\nPunkt word tokenizer:"
print punkt_word_tokenizer.tokenize(text)
from nltk.tokenize import WordPunctTokenizer  # Create a new WordPunct tokenizer

word_punct_tokenizer = WordPunctTokenizer()
print "\nWord punct tokenizer:"
print word_punct_tokenizer.tokenize(text)
