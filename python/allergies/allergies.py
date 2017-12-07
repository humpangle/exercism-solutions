from math import floor, log

AILMENTS = 'eggs peanuts shellfish strawberries \
                tomatoes chocolate pollen cats'.split()
SCORES = [2 ** x for x in range(len(AILMENTS))]
ALLERGIES_SCORES = dict(zip(AILMENTS, SCORES))
SCORES_ALLERGIES = dict(zip(SCORES, AILMENTS))


class Allergies0(object):
    def __init__(self, score):
        self.score = score

    def is_allergic_to(self, item):
        return ALLERGIES_SCORES.get(item, 10**9) <= self.score

    @property
    def lst(self):
        allergies = []
        if self.score:
            possible_scores = list(
                2 ** x for x in range(floor(log(self.score) / log(2)) + 1)
            )
            max_score = self.score
            for score in possible_scores[::-1]:
                new_max_score = max_score - score

                if new_max_score >= 0:
                    max_score = new_max_score
                    if score in SCORES_ALLERGIES:
                        allergies.append(SCORES_ALLERGIES[score])

        return list(allergies)


class Allergies(object):
    def __init__(self, score):
        self.score = score

    def is_allergic_to(self, item):
        return bool(self.score & ALLERGIES_SCORES.get(item, 0))

    @property
    def lst(self):
        return [x for x in ALLERGIES_SCORES if self.is_allergic_to(x)]
