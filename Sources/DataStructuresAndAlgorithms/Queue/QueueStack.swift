//
//  QueueStack.swift
//  DataStructuresAndAlgorithms
//
//  Created by Kraig Spear on 8/22/21.
//

import Foundation

/// A queue implementation using two stacks to achieve amortized O(1) operations.
///
/// This implementation solves a fundamental performance problem with array-based queues:
/// removing the first element from an array requires shifting all remaining elements
/// forward by one position, which is an O(n) operation. By using two stacks (arrays
/// accessed only from one end), this implementation achieves much better performance
/// characteristics.
///
/// ## Algorithm Overview
///
/// The queue maintains two internal stacks:
/// - **enqueueStack**: Receives all newly added elements via `append()` (O(1))
/// - **dequeueStack**: Provides elements for removal via `popLast()` (O(1))
///
/// When dequeuing and the dequeueStack is empty, all elements from enqueueStack
/// are reversed into dequeueStack. This reversal operation is O(n), but happens
/// infrequently, resulting in amortized O(1) performance across many operations.
///
/// ## Performance Characteristics
///
/// - **Enqueue**: O(1) - Always appends to the end of enqueueStack
/// - **Dequeue**: Amortized O(1) - Usually O(1), occasionally O(n) when reversing stacks
/// - **Peek**: O(1) - Checks the appropriate stack without modification
/// - **Space Complexity**: O(n) - Stores all elements across both stacks
///
/// ## Usage Example
///
/// ```swift
/// var queue = QueueStack<String>()
///
/// // Add elements to the queue
/// queue.enqueue("First")
/// queue.enqueue("Second")
/// queue.enqueue("Third")
///
/// // Check the front element without removing it
/// print(queue.peek) // Optional("First")
///
/// // Remove elements in FIFO order
/// print(queue.dequeue()) // Optional("First")
/// print(queue.dequeue()) // Optional("Second")
///
/// // Add more elements
/// queue.enqueue("Fourth")
///
/// // Queue maintains FIFO order across enqueue/dequeue operations
/// print(queue.dequeue()) // Optional("Third")
/// print(queue.dequeue()) // Optional("Fourth")
/// print(queue.dequeue()) // nil - queue is empty
/// ```
///
/// ## Why Two Stacks?
///
/// The two-stack approach provides several advantages:
///
/// 1. **Avoids Array Shifting**: Traditional array-based queues suffer from O(n)
///    dequeue operations because removing the first element requires shifting all
///    remaining elements forward. This implementation uses stack operations (append/popLast)
///    which are O(1).
///
/// 2. **Amortized Efficiency**: While reversing the enqueueStack into dequeueStack
///    is O(n), each element is moved at most once from enqueue to dequeue stack.
///    Spread across many operations, this averages out to constant time per operation.
///
/// 3. **Lazy Reversal**: The stack reversal only happens when needed (when dequeueStack
///    is empty and a dequeue is requested), minimizing unnecessary work.
///
/// 4. **Maintains FIFO Order**: The reversal operation ensures that elements are
///    dequeued in the same order they were enqueued, preserving queue semantics.
///
/// - Note: This implementation is a value type (struct) with mutating methods,
///   following Swift's standard library conventions for collection types.
public struct QueueStack<T>: Queue {
    typealias Element = T

    // MARK: - Properties

    /// Stack that receives newly enqueued elements.
    ///
    /// Elements are appended to this stack in the order they arrive, making
    /// enqueue operations O(1). When dequeueStack is empty, this stack is
    /// reversed to populate dequeueStack for efficient removal.
    private var enqueueStack: [Element] = []

    /// Stack that provides elements for dequeue operations.
    ///
    /// Elements are stored in reverse order, so calling popLast() removes
    /// elements in FIFO order. This stack is populated by reversing enqueueStack
    /// when this stack becomes empty and a dequeue is requested.
    private var dequeueStack: [Element] = []

    // MARK: - Initialization

    /// Creates an empty queue.
    ///
    /// Example:
    /// ```swift
    /// let queue = QueueStack<Int>()
    /// ```
    public init() {}

    // MARK: - Public Properties

    /// Indicates whether the queue contains no elements.
    ///
    /// The queue is empty only when both internal stacks are empty. This property
    /// checks both stacks because elements may reside in either the enqueue stack
    /// (newly added) or dequeue stack (ready for removal).
    ///
    /// - Complexity: O(1)
    ///
    /// Example:
    /// ```swift
    /// var queue = QueueStack<String>()
    /// print(queue.isEmpty) // true
    ///
    /// queue.enqueue("Hello")
    /// print(queue.isEmpty) // false
    /// ```
    public var isEmpty: Bool {
        enqueueStack.isEmpty && dequeueStack.isEmpty
    }

    /// Returns the element at the front of the queue without removing it.
    ///
    /// This property provides access to the next element that would be dequeued,
    /// without modifying the queue. The implementation checks the dequeueStack first
    /// (since those elements are next in line), falling back to the first element
    /// of enqueueStack if dequeueStack is empty.
    ///
    /// - Returns: The element at the front of the queue, or `nil` if the queue is empty.
    /// - Complexity: O(1)
    ///
    /// Example:
    /// ```swift
    /// var queue = QueueStack<Int>()
    /// queue.enqueue(1)
    /// queue.enqueue(2)
    ///
    /// print(queue.peek) // Optional(1)
    /// print(queue.peek) // Still Optional(1) - peek doesn't remove
    /// ```
    public var peek: T? {
        dequeueStack.isEmpty == false ? dequeueStack.last : enqueueStack.first
    }

    // MARK: - Public Methods

    /// Adds an element to the back of the queue.
    ///
    /// Elements are added to the internal enqueueStack by appending to its end,
    /// which is an O(1) operation. The element will eventually be dequeued after
    /// all previously enqueued elements have been removed, maintaining FIFO order.
    ///
    /// - Parameter element: The element to add to the queue.
    /// - Complexity: O(1)
    ///
    /// Example:
    /// ```swift
    /// var queue = QueueStack<String>()
    /// queue.enqueue("First")
    /// queue.enqueue("Second")
    /// // Queue now contains: First, Second (in that order)
    /// ```
    public mutating func enqueue(_ element: T) {
        enqueueStack.append(element)
    }

    /// Removes and returns the element at the front of the queue.
    ///
    /// This method implements the core queue dequeue operation with amortized O(1)
    /// performance. The implementation follows this logic:
    ///
    /// 1. If dequeueStack has elements, pop from it (O(1))
    /// 2. If dequeueStack is empty, reverse enqueueStack into it (O(n)), then pop (O(1))
    /// 3. If both stacks are empty, return nil
    ///
    /// The reversal operation (step 2) ensures that elements are removed in FIFO order.
    /// While reversal is O(n), each element is moved at most once between stacks,
    /// resulting in amortized O(1) performance across many operations.
    ///
    /// - Returns: The element at the front of the queue, or `nil` if the queue is empty.
    /// - Complexity: Amortized O(1). Individual calls may be O(n) when reversing stacks,
    ///   but averaged over many operations, the cost per operation is constant.
    ///
    /// Example:
    /// ```swift
    /// var queue = QueueStack<Int>()
    /// queue.enqueue(10)
    /// queue.enqueue(20)
    /// queue.enqueue(30)
    ///
    /// print(queue.dequeue()) // Optional(10)
    /// print(queue.dequeue()) // Optional(20)
    /// print(queue.dequeue()) // Optional(30)
    /// print(queue.dequeue()) // nil - queue is empty
    /// ```
    ///
    /// - Note: The `@discardableResult` attribute allows calling this method
    ///   without using the returned value, useful when you only need to remove
    ///   elements without processing them.
    @discardableResult
    public mutating func dequeue() -> T? {
        // If dequeueStack is empty, transfer all elements from enqueueStack
        // by reversing them. This reversal ensures FIFO order is maintained.
        // After this operation, dequeueStack will have elements in the correct
        // order for removal (last element = front of queue).
        if dequeueStack.isEmpty {
            dequeueStack = enqueueStack.reversed()
            enqueueStack.removeAll()
        }
        // Remove and return the last element from dequeueStack, which represents
        // the front of the queue. This is O(1) since we're removing from the end.
        return dequeueStack.popLast()
    }
}
