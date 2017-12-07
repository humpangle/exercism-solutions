from string import ascii_uppercase, ascii_lowercase

def rotate(text, key):
    map_lowercase = dict([(x, i) for i, x in enumerate(ascii_lowercase)])
    map_uppercase = dict([(x, i) for i, x in enumerate(ascii_uppercase)])
    acc = ''
    for letter in text:
        rotation = letter
        if letter in map_lowercase:
            rotation = ascii_lowercase[(map_lowercase.get(letter) + key) % 26]
        elif letter in map_uppercase:
            rotation = ascii_uppercase[(map_uppercase.get(letter) + key) % 26]
        acc += rotation
    return acc
