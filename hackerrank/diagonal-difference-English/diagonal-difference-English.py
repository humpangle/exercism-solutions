from itertools import chain


def diagonal_difference(size: int, matrix: str):
    vals = list(chain(*[map(int, x.strip().split(' '))
                        for x in matrix.strip().split('\n')]))
    second, pry = size - 1, size + 1
    return abs(sum(vals[y * pry] - vals[(y + 1) * second] for y in range(size)))
