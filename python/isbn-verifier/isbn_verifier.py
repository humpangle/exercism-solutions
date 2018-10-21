def verify(isbn):
    import re

    search = re.search(r'^[\d]{9}[\dX]$', isbn.replace('-', ''))
    return sum((10 if x == 'X' else int(x)) * (10 - i) for i, x in enumerate(search.group())) % 11 == 0 if search else False
