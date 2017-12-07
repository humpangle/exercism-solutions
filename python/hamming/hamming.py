def distance(strand_a, strand_b):
    if len(strand_a) != len(strand_b):
        raise ValueError()
    return len([a for i, a in enumerate(strand_a) if strand_b[i] != a])
