pub struct SimpleLinkedList<T> {
    head: Option<Box<Node<T>>>,
}
struct Node<T> {
    data: T,
    next: Option<Box<Node<T>>>,
}

impl<T> SimpleLinkedList<T> {
    pub fn new() -> Self {
        SimpleLinkedList { head: None }
    }

    pub fn len(&self) -> usize {
        let mut e = self.head.as_ref();
        let mut size = 0;
        while e.is_some() {
            size += 1;
            e = e.unwrap().next.as_ref();
        }
        size
    }

    pub fn push(&mut self, _element: T) {
        let new_node = Box::new(Node {
            data: _element,
            next: self.head.take(),
        });
        self.head = Some(new_node);
    }

    pub fn pop(&mut self) -> Option<T> {
        self.head.take().map(|node| {
            let node = *node;
            self.head = node.next;
            node.data
        })
    }

    pub fn peek(&self) -> Option<&T> {
        self.head.as_ref().map(|node| &node.data)
    }
}

impl<T: Clone> SimpleLinkedList<T> {
    pub fn rev(&self) -> SimpleLinkedList<T> {
        let mut current_node = &self.head;
        let mut result = Self::new();
        while let &Some(ref node) = current_node {
            result.push(node.data.clone());
            current_node = &node.next;
        }
        result
    }
}

// impl<'a, T: Clone> From<&'a [T]> for SimpleLinkedList<T> {
//     fn from(_item: &[T]) -> Self {
//         let mut list: SimpleLinkedList<T> = SimpleLinkedList::new();
//         for i in _item {
//             list.push(i.clone());
//         }
//         list
//     }
// }

impl<T> Into<Vec<T>> for SimpleLinkedList<T> {
    fn into(self) -> Vec<T> {
        let mut current_node = self.head;
        let mut result = Vec::new();
        while let Some(mut node) = current_node {
            current_node = std::mem::replace(&mut node.next, None);
            result.push(node.data);
        }
        result.reverse();
        result
    }
}
