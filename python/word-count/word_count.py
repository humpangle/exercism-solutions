import re
from functools import reduce

p = re.compile(r"[a-z'\d]+")

def word_count(phrase):

    def count(acc, word):
        word = word.strip("'")
        acc[word] = acc.get(word, 0) + 1
        return acc

    return reduce(count, p.findall(phrase.lower()), {})
