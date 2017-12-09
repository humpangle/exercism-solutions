def has_cycle0(head):
    if head is None:
        return False

    def cycle(node, seen=[]):
        d, n = node.data, node.next
        if n is None:
            return False
        s = (d, n.data)
        if s in seen:
            return True
        seen.append(s)
        return cycle(n, seen)

    return cycle(head, [])


def has_cycle(head):
    if head is None:
        return False

    slow, fast = head, head.next
    while slow != fast:
        if fast is None or fast.next is None:
            return False
        slow = slow.next
        fast = fast.next.next
    return True
