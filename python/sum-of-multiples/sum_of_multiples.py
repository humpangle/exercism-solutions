from itertools import chain


def sum_of_multiples(limit, multiples):
    return sum(set(chain(*[range(x, limit, x) for x in multiples])))
