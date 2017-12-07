from functools import reduce
import re

def decode(string):

    def decode_(acc_prev_letter, next_letter):
        acc, prev_letter = acc_prev_letter

        if prev_letter.isdigit():
            return ('%s%s' % (acc, next_letter * int(prev_letter)), '')
        if next_letter.isdigit():
            return ('%s%s' % (acc, prev_letter), next_letter)

        return ('%s%s%s' % (acc, prev_letter, next_letter), '')

    if not string or len(string) == 1:
        return string

    p = re.compile(r'\d+|\w|\s')
    string_ = p.findall(string)
    return reduce(decode_, string_[1:], ('', string_[0]))[0]


def encode(string):

    def encode_(acc_prev_letter_count, next_letter):
        acc, prev_letter, count = acc_prev_letter_count

        if not acc:
            if prev_letter == next_letter:
                return ('2%s' % prev_letter, next_letter, 2)
            return ('%s%s' % (prev_letter, next_letter), next_letter, 1)

        if prev_letter == next_letter:
            acc_trim_len = -1 if count == 1 else (-len(str(count)) - 1)
            next_count = count + 1

            return (
                '%s%s%s' % (acc[: acc_trim_len], next_count, next_letter),
                next_letter,
                next_count
            )

        return ('%s%s' % (acc, next_letter), next_letter, 1)

    if not string or len(string) == 1:
        return string

    return reduce(encode_, string[1:], ('', string[0], 1))[0]
