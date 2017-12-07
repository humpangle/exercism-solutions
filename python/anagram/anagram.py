from collections import Counter


def detect_anagrams0(word, candidates):
    word_lower, len_word, anagrams = word.lower(), len(word), []
    for candidate in candidates or word_lower == candidate.lower():
        if len_word != len(candidate):
            continue
        word_ = '%s%s' % (word_lower, word.upper())
        anagram = ''.join([w for w in candidate if w in word_])
        anagram_lower, anagram_len = anagram.lower(), len(anagram)

        if anagram_len == len_word and anagram_lower != word_lower:
            anagram_count = Counter(anagram_lower)
            word_count = Counter(word_lower)
            if all(anagram_count[a] == word_count[a] for a in anagram_lower):
                anagrams.append(anagram)

    return anagrams


def detect_anagrams(word, candidates):
    word_ = word.lower()
    return [x for x in candidates
            if x.lower() != word_ and sorted(x.lower()) == sorted(word_)]
