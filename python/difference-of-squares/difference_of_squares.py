def square_of_sum(num):
    return sum((x + 1 for x in range(num))) ** 2


def sum_of_squares(num):
    return sum(((x + 1) ** 2 for x in range(num)))


def difference(num):
    return square_of_sum(num) - sum_of_squares(num)
