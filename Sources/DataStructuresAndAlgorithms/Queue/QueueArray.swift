//
//  QueueArray.swift
//  DataStructuresAndAlgorithms
//
//  Created by Kraig Spear on 8/22/21.
//

import Foundation

/// A naive array-based queue implementation that demonstrates a critical performance problem.
///
/// ## Overview
///
/// This implementation exists as a **pedagogical example** to demonstrate why a simple
/// array-based approach is inefficient for queue operations. While the code is correct
/// and follows FIFO (First-In-First-Out) semantics, it suffers from a significant
/// performance issue that makes it unsuitable for production use with large queues
/// or frequent dequeue operations.
///
/// ## The Performance Problem
///
/// The critical issue is that `array.removeFirst()` has **O(n)** time complexity because
/// it must shift all remaining elements forward in memory to fill the gap left by the
/// removed element.
///
/// ### Visual Example of Element Shifting
///
/// Consider a queue with 5 elements:
/// ```
/// Initial state:     [A, B, C, D, E]
///                     ↑
///                   front
///
/// After dequeue():   [B, C, D, E]
///                     ↑  ↑  ↑  ↑
///                     All elements shifted left!
///
/// After dequeue():   [C, D, E]
///                     ↑  ↑  ↑
///                     All elements shifted left again!
/// ```
///
/// Each dequeue operation requires copying all remaining elements, making the operation
/// O(n) where n is the number of elements still in the queue.
///
/// ## Performance Characteristics
///
/// | Operation | Time Complexity | Why |
/// |-----------|-----------------|-----|
/// | `enqueue(_:)` | O(1) amortized | Array append is efficient |
/// | `dequeue()` | **O(n)** ⚠️ | **removeFirst() shifts all elements** |
/// | `peek` | O(1) | Simple array access |
/// | `isEmpty` | O(1) | Simple property check |
///
/// ## When This Becomes Problematic
///
/// The O(n) dequeue operation becomes a serious bottleneck when:
/// - Processing large queues (thousands of elements)
/// - Performing frequent dequeue operations
/// - Real-time systems requiring consistent performance
/// - High-throughput scenarios (event processing, job queues, etc.)
///
/// ### Performance Impact Example
///
/// ```swift
/// var queue = QueueArray<Int>()
///
/// // Enqueue 10,000 elements - fast, O(1) per operation
/// for i in 0..<10_000 {
///     queue.enqueue(i)
/// }
///
/// // Dequeue all elements - SLOW!
/// // First dequeue: shifts 9,999 elements
/// // Second dequeue: shifts 9,998 elements
/// // ...
/// // Total operations: ~50 million element shifts!
/// while !queue.isEmpty {
///     queue.dequeue() // O(n) - gets slower as queue drains
/// }
/// ```
///
/// ## The Solution
///
/// For production code, use ``QueueStack`` or a ring buffer implementation, which
/// achieves O(1) dequeue operations by avoiding the element shifting problem entirely.
/// ``QueueStack`` uses two stacks to eliminate the need for shifting elements during
/// dequeue operations.
///
/// ## Usage (For Learning Only)
///
/// ```swift
/// var queue = QueueArray<String>()
///
/// // Enqueue is efficient - O(1)
/// queue.enqueue("First")
/// queue.enqueue("Second")
/// queue.enqueue("Third")
///
/// // Dequeue is inefficient - O(n)
/// // This shifts "Second" and "Third" forward in memory
/// let first = queue.dequeue() // "First"
///
/// // Check front without removing
/// let next = queue.peek // "Second"
/// ```
///
/// - Warning: Do not use this implementation in production code for large queues or
///   scenarios with frequent dequeue operations. Use ``QueueStack`` instead for O(1)
///   dequeue performance.
///
/// - Note: This implementation is provided purely for educational purposes to demonstrate
///   why naive array-based queues are problematic and why more sophisticated implementations
///   are necessary.
public struct QueueArray<T>: Queue {
    // MARK: - Properties

    /// The underlying array storage for queue elements.
    ///
    /// Elements are stored in FIFO order with the front of the queue at index 0.
    /// This layout necessitates the O(n) shifting behavior during dequeue operations.
    private var array: [T] = []

    // MARK: - Initialization

    /// Creates an empty queue.
    ///
    /// The queue is initialized with no elements and will grow dynamically as
    /// elements are enqueued.
    public init() {}

    // MARK: - Public Methods

    /// Adds an element to the back of the queue.
    ///
    /// This operation is efficient (O(1) amortized) because it uses the array's
    /// `append` method, which only occasionally needs to resize the underlying storage.
    ///
    /// Example:
    /// ```swift
    /// var queue = QueueArray<Int>()
    /// queue.enqueue(1)  // [1]
    /// queue.enqueue(2)  // [1, 2]
    /// queue.enqueue(3)  // [1, 2, 3]
    /// ```
    ///
    /// - Parameter element: The element to add to the back of the queue.
    /// - Complexity: O(1) amortized. While array resizing occasionally requires O(n)
    ///   copying, this happens infrequently enough that the amortized cost is O(1).
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }

    /// Removes and returns the element at the front of the queue.
    ///
    /// ## Performance Warning
    ///
    /// This operation has **O(n)** time complexity, which is the primary performance
    /// problem this implementation demonstrates. The inefficiency stems from
    /// `array.removeFirst()`, which must shift all remaining elements forward by one
    /// position to fill the gap.
    ///
    /// ### Why removeFirst() is O(n)
    ///
    /// When we remove the first element, Swift's Array must:
    /// 1. Remove the element at index 0
    /// 2. Shift element at index 1 → index 0
    /// 3. Shift element at index 2 → index 1
    /// 4. Continue shifting all remaining elements...
    /// 5. Update the array's count
    ///
    /// This means if the queue has 1,000 elements, removing the front element requires
    /// moving 999 elements in memory. If we dequeue all elements, we perform approximately
    /// 500,000 total element moves!
    ///
    /// ### Visual Example
    ///
    /// ```
    /// Before: array = [10, 20, 30, 40, 50]
    ///                  ↑
    ///                Remove this
    ///
    /// After removeFirst():
    /// Step 1: [__, 20, 30, 40, 50]  // Element removed
    /// Step 2: [20, __, 30, 40, 50]  // Shift 20 left
    /// Step 3: [20, 30, __, 40, 50]  // Shift 30 left
    /// Step 4: [20, 30, 40, __, 50]  // Shift 40 left
    /// Step 5: [20, 30, 40, 50]      // Shift 50 left and update count
    ///         ↑   ↑   ↑   ↑
    ///         All elements had to move!
    /// ```
    ///
    /// Example:
    /// ```swift
    /// var queue = QueueArray<String>()
    /// queue.enqueue("Alice")
    /// queue.enqueue("Bob")
    /// queue.enqueue("Charlie")
    ///
    /// // This shifts "Bob" and "Charlie" forward - O(n)!
    /// let first = queue.dequeue() // "Alice"
    ///
    /// // This shifts "Charlie" forward - O(n) again!
    /// let second = queue.dequeue() // "Bob"
    /// ```
    ///
    /// - Returns: The element at the front of the queue, or `nil` if the queue is empty.
    /// - Complexity: **O(n)** where n is the number of elements in the queue. This is
    ///   the critical performance problem that makes this implementation unsuitable for
    ///   production use.
    ///
    /// - Note: For O(1) dequeue operations, use ``QueueStack`` which eliminates the
    ///   shifting problem through a dual-stack design.
    @discardableResult
    public mutating func dequeue() -> T? {
        // Using removeFirst() is the source of the O(n) problem.
        // It must shift all remaining elements forward in the array.
        // For a queue with n elements, this requires n-1 element moves.
        isEmpty ? nil : array.removeFirst()
    }

    /// Returns the element at the front of the queue without removing it.
    ///
    /// This operation is efficient because it simply accesses the first element
    /// of the array without modifying the queue's structure.
    ///
    /// Example:
    /// ```swift
    /// var queue = QueueArray<Int>()
    /// queue.enqueue(100)
    /// queue.enqueue(200)
    ///
    /// let front = queue.peek  // 100
    /// // Queue still contains [100, 200]
    /// ```
    ///
    /// - Returns: The element at the front of the queue, or `nil` if the queue is empty.
    /// - Complexity: O(1) - simple array access with no modifications.
    public var peek: T? {
        array.first
    }

    /// A Boolean value indicating whether the queue is empty.
    ///
    /// Example:
    /// ```swift
    /// var queue = QueueArray<Int>()
    /// print(queue.isEmpty)  // true
    ///
    /// queue.enqueue(1)
    /// print(queue.isEmpty)  // false
    /// ```
    ///
    /// - Returns: `true` if the queue contains no elements; otherwise, `false`.
    /// - Complexity: O(1) - simple property check.
    public var isEmpty: Bool { array.isEmpty }
}
