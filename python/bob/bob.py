def hey(phrase):
    if not phrase.strip():
        return 'Fine. Be that way!'

    if phrase.isupper():
        return 'Whoa, chill out!'

    if phrase.strip().endswith('?'):
        return 'Sure.'

    return 'Whatever.'
