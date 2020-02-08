#!/usr/bin/python
from nltk.tokenize import sent_tokenize, word_tokenize, WordPunctTokenizer

input_text = "Do you know how tokenization works? It's actually quite interesting! Let's analyze a couple of sentences and figure it out."  # Define input text
print("\nSentence tokenizer:")  # Sentence tokenizer
print(sent_tokenize(input_text))
print("\nWord tokenizer:")  # Word tokenizer
print(word_tokenize(input_text))
print("\nWord punct tokenizer:")  # WordPunct tokenizer
print(WordPunctTokenizer().tokenize(input_text))
