def sieve(limit):
    if limit < 2:
        return []

    start = range(2, limit + 1)
    max_ = limit ** (1 / 2)
    index = 0
    val = start[index]
    while val < max_:
        start = [x for x in start if x == val or x % val != 0]
        index += 1
        val = start[index]

    return list(start)
