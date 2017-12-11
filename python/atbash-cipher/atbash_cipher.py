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


def encode1(plain_text):
    trans = plain_text.lower().translate(str.maketrans(dict(zip_longest(
        'abcdefghijklmnopqrstuvwxyz0123456789 .,',
        'zyxwvutsrqponmlkjihgfedcba0123456789'
    ))))
    return ' '.join(
        ''.join(trans[x * 5:(x + 1) * 5])
        for x in range((len(trans) // 5) + 1)
    ).strip()


def decode1(ciphered_text):
    return ciphered_text.translate(str.maketrans(dict(zip_longest(
        'zyxwvutsrqponmlkjihgfedcba0123456789 ',
        'abcdefghijklmnopqrstuvwxyz0123456789'
    ))))


def encode_(w, l='abcdefghijklmnopqrstuvwxyz'):
    return [l[-l.find(x) - 1]
            if x in l else x for x in w.lower() if x.isalnum()]


def encode(w):
    y = encode_(w)
    return ' '.join(
        ''.join(m) for m in [y[x:x + 5] for x in range(0, len(y), 5)])


def decode(w):
    return ''.join(encode_(w))
