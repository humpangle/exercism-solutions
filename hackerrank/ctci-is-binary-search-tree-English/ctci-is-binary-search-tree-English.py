from collections import Counter


class Node(object):
    def __init__(self, data, left=None, right=None):
        self.data, self.left, self.right = data, left, right

    def __str__(self):
        left = self.left and self.left.data or ''
        right = self.right and self.right.data or ''
        return '%s-%s-%s' % (str(left), self.data, str(right))

    def walk(self):
        left, right, data = self.left, self.right, [self.data]
        return (left and left.walk() or []) + data + \
            (right and right.walk() or [])

    def is_binary_search(self):
        left, right, data = self.left, self.right, self.data
        is_ok = True
        if left:
            is_ok = is_ok and all(data > x for x in left.walk())
        if right:
            is_ok = is_ok and all(data < x for x in right.walk())
        return is_ok

    @classmethod
    def make_node(cls, data):
        len_data = len(data)
        if len_data < 1:
            raise ValueError('A node must have a data value.')
        if len_data == 1:
            return Node(data[0])
        mid = len_data // 2
        return Node(
            data[mid],
            cls.make_node(data[: mid]),
            cls.make_node(data[mid + 1:])
        )


def transverse(node: Node=None):
    left, right, data = node.left, node.right, [node.data]
    return (left and transverse(left) or []) + data + \
        (right and transverse(right) or [])


def checkBST0(root):
    left, right, data = root.left, root.right, root.data
    is_ok = True
    if left:
        is_ok = is_ok and all(data > x for x in transverse(left))
    if right:
        is_ok = is_ok and all(data < x for x in transverse(right))
    return is_ok


def checkBST(root):
    # print('root', root)
    data, left, right = root.data, root.left, root.right
    if left and left.data > data:
        return False
    if right and right.data < data:
        return False
    root_all = transverse(root)
    # print('root_all', root_all)
    len_root = len(root_all)
    if sum(Counter(root_all).values()) != len_root:
        return False
    mid = len_root // 2
    if not (all(data > x for x in root_all[:mid]) and
            all(data < x for x in root_all[mid + 1:])):
        return False
    is_ok = True
    if right:
        is_ok = is_ok and checkBST(right)
    if left:
        is_ok = is_ok and checkBST(left)
    return is_ok


# root = Node.make_node([int(x.strip()) for x in '1 2 4 4 5 6 7'.split()])
root = Node.make_node([int(x.strip())
                       for x in '1 2 3 4 5 6 7 8 9 10 11 13 12 14 15'.split()])
# root = Node.make_node(
#     [int(x.strip()) for x in '1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31'.split()])
# print(root.walk())
# print(transverse(root))
print(checkBST(root))
