from functools import reduce


def count(acc, val):
    acc[val] = acc.get(val, 0) + 1
    return acc

def is_isogram(string):
    string = string.replace(' ', '').replace('-', '').lower()
    if not string:
        return True
    counts_dict = reduce(count, string, {})
    return max(counts_dict.values()) == 1
