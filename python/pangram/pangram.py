from string import ascii_lowercase

def is_pangram(string):
    chars = [x.lower() for x in string if x.isalpha()]
    return len(set(chars)) == len(ascii_lowercase)
