# Queue

A queue is a FIFO (First-In-First-Out) data structure where elements are added to the back and removed from the front.

## Implementations

### QueueArray
Simple array-based queue implementation for educational purposes.

**Performance:**
- Enqueue: O(1)
- Dequeue: O(n) ⚠️ **Inefficient!**

This implementation demonstrates the problem with naive array-based queues. See the [QueueArray source code](../Sources/DataStructuresAndAlgorithms/Queue/QueueArray.swift) for detailed DocC documentation.

### QueueStack
Optimized queue using dual-stack approach.

**Performance:**
- Enqueue: O(1)
- Dequeue: O(1) amortized

This is the production-ready implementation. See the [QueueStack source code](../Sources/DataStructuresAndAlgorithms/Queue/QueueStack.swift) for detailed DocC documentation.

## What to Remember

In order to have an efficient queue we can't shift items in an array due to the overhead of moving items.

In a large array we would have the impact of O(n) for each dequeue operation.

By using two arrays (that function as stacks), we can start by first storing the enqueueStack in the dequeueStack reversed.

**enqueueStack always receives any new items, while dequeueStack always provides items to the caller.**

Since it's reversed we have last in first out, so we keep removing from the end where we don't have the performance penalty of shifting.

We can then still enqueue, adding to the enqueueStack that has been emptied.
When we run out of items in the dequeueStack we then repeat the process of assigning the dequeueStack and clearing it out.

## Usage Examples

```swift
import DataStructuresAndAlgorithms

// Using QueueArray (educational - shows the problem)
var arrayQueue = QueueArray<Int>()
arrayQueue.enqueue(1)
arrayQueue.enqueue(2)
arrayQueue.enqueue(3)
print(arrayQueue.dequeue()) // Optional(1)
print(arrayQueue.peek)      // Optional(2)

// Using QueueStack (production - optimized)
var stackQueue = QueueStack<String>()
stackQueue.enqueue("First")
stackQueue.enqueue("Second")
stackQueue.enqueue("Third")
print(stackQueue.dequeue()) // Optional("First")
print(stackQueue.peek)      // Optional("Second")
```

## Common Use Cases

- Task scheduling (print jobs, background tasks)
- Breadth-first search in graphs and trees
- Message queues and event processing
- Buffering data streams
- Managing requests in web servers

## See Also

- [Queue Protocol](../Sources/DataStructuresAndAlgorithms/Queue/Queue.swift) - Defines the queue interface
- [QueueArray](../Sources/DataStructuresAndAlgorithms/Queue/QueueArray.swift) - Educational implementation
- [QueueStack](../Sources/DataStructuresAndAlgorithms/Queue/QueueStack.swift) - Optimized implementation
- [Tests](../Tests/DataStructuresAndAlgorithmsTests/QueueTests/)
