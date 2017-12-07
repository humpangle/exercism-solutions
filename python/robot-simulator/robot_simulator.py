# Globals for the bearings
# Change the values as you see fit
EAST = '+x'
NORTH = '+y'
WEST = '-x'
SOUTH = '-y'


class Robot(object):
    turn_right_mappings = dict(zip(
        (EAST, NORTH, WEST, SOUTH),
        (SOUTH, EAST, NORTH, WEST)
    ))

    turn_left_mappings = dict(zip(
        (EAST, NORTH, WEST, SOUTH),
        (NORTH, WEST, SOUTH, EAST)
    ))

    def __init__(self, bearing=NORTH, x=0, y=0):
        self.coordinates = (x, y)
        self.bearing = bearing
        self.motion_mappings = dict(zip(
            'LAR', (self.turn_left, self.advance, self.turn_right)
        ))

    def turn_right(self):
        self.bearing = self.turn_right_mappings[self.bearing]

    def turn_left(self):
        self.bearing = self.turn_left_mappings[self.bearing]

    @staticmethod
    def addition(sign, a, b):
        return (a + b) if sign == '+' else (a - b)

    def advance(self):
        sign, pos = self.bearing
        x_coord, y_coord = self.coordinates
        if pos == 'x':
            x_coord = self.addition(sign, x_coord, 1)
        else:
            y_coord = self.addition(sign, y_coord, 1)
        self.coordinates = (x_coord, y_coord)

    def simulate(self, motions: str):
        [self.motion_mappings[m]() for m in motions]
