pairs = dict((('{', '}'), ('(', ')'), ('[', ']')))


def is_matched0(exp):
    seen = ''
    len_exp = len(exp)
    while len_exp > 0:
        if len_exp == 1:
            if not seen:
                return False
            return len(seen) == 1 and pairs.get(seen[0]) == exp
        exp0 = exp[0]
        if seen and pairs.get(seen[-1]) == exp0:
            seen = seen[:-1]
        else:
            seen += exp0
        exp = exp[1:]
        len_exp = len(exp)
    return not seen


def is_matched(exp):
    stack = []
    for item in exp:
        if item in pairs:
            stack.append(pairs[item])
        elif not stack or stack.pop() != item:
            return False
    return not stack
