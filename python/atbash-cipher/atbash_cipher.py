from itertools import zip_longest


def encode0(plain_text):
    table = dict(zip(
        'abcdefghijklmnopqrstuvwxyz0123456789',
        'zyxwvutsrqponmlkjihgfedcba0123456789'
    ))
    result = ''
    counter = 0
    for letter in plain_text.lower():
        if letter.isalnum():
            if counter == 5:
                result += ' '
                counter = 0
            result += (table[letter])
            counter += 1
    return result


def encode(plain_text):
    trans = plain_text.lower().translate(str.maketrans(dict(zip_longest(
        'abcdefghijklmnopqrstuvwxyz0123456789 .,',
        'zyxwvutsrqponmlkjihgfedcba0123456789'
    ))))
    return ' '.join(
        ''.join(trans[x * 5:(x + 1) * 5])
        for x in range(int(len(trans) / 5) + 1)
    ).strip()


def decode(ciphered_text):
    return ciphered_text.translate(str.maketrans(dict(zip_longest(
        'zyxwvutsrqponmlkjihgfedcba0123456789 ',
        'abcdefghijklmnopqrstuvwxyz0123456789'
    ))))
