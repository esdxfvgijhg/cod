#!/usr/bin/python
from nltk.stem import WordNetLemmatizer

input_words = ["writing", "calves", "be", "branded", "horse", "randomize", "possibly", "provision", "hospital", "kept", "scratchy", "code"]
lemmatizer = WordNetLemmatizer()  # Create lemmatizer object
lemmatizer_names = ["NOUN LEMMATIZER", "VERB LEMMATIZER"]  # Create a list of lemmatizer names for display
formatted_text = "{:>24}" * (len(lemmatizer_names) + 1)
print("\n", formatted_text.format("INPUT WORD", *lemmatizer_names), "\n", "=" * 75)
for word in input_words:  # Lemmatize each word and display the output
    output = [word, lemmatizer.lemmatize(word, pos="n"), lemmatizer.lemmatize(word, pos="v")]
    print(formatted_text.format(*output))
