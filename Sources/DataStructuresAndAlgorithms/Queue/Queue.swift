//
//  Queue.swift
//  DataStructuresAndAlgorithms
//
//  Created by Kraig Spear on 10/25/25.
//

/// A protocol defining the interface for queue data structures.
///
/// ## Overview
///
/// A queue is a fundamental data structure that follows **FIFO (First-In-First-Out)** semantics.
/// Elements are added to the back of the queue and removed from the front, similar to a line of
/// people waiting at a store checkout counter—the first person to arrive is the first person served.
///
/// This protocol defines the essential operations that all queue implementations must provide,
/// allowing different concrete implementations to be used interchangeably while guaranteeing
/// consistent queue behavior.
///
/// ### Visual Representation
///
/// ```
/// Enqueue (add)                Dequeue (remove)
///      ↓                              ↑
/// ┌─────────────────────────────────────┐
/// │  Back                         Front │
/// │   [D]  [C]  [B]  [A]            →   │
/// └─────────────────────────────────────┘
///
/// Flow: Elements enter at back, exit from front
/// Order preserved: A enters first, A exits first
/// ```
///
/// ## Why Queues Are Useful
///
/// Queues are essential when you need to:
///
/// - **Preserve order**: Process items in the exact sequence they arrived
/// - **Fair scheduling**: Ensure first-come-first-served semantics
/// - **Buffer data**: Handle bursts of incoming data at a controlled rate
/// - **Coordinate asynchronous operations**: Manage tasks that complete in order
///
/// ### Common Use Cases
///
/// 1. **Task Scheduling**
///    - Print job queues
///    - Background task processing
///    - Request handling in web servers
///
/// 2. **Algorithm Implementation**
///    - Breadth-first search (BFS) in graphs and trees
///    - Level-order tree traversal
///    - Shortest path algorithms
///
/// 3. **System Design**
///    - Message queues between components
///    - Event processing pipelines
///    - Rate limiting and throttling
///    - Buffering between producers and consumers
///
/// 4. **Real-World Modeling**
///    - Customer service queues
///    - Playlist management
///    - Undo/redo with limited history
///
/// ## Protocol Design
///
/// This protocol exists to decouple queue usage from specific implementations, enabling:
///
/// - **Abstraction**: Code written against the protocol works with any conforming implementation
/// - **Testing**: Easy substitution of implementations for unit tests
/// - **Flexibility**: Switch implementations based on performance characteristics
/// - **Extensibility**: Add new queue implementations without changing client code
///
/// The protocol uses an `associatedtype` to support queues of any element type while maintaining
/// type safety. This allows for generic, reusable code that works with `Queue<Int>`, `Queue<String>`,
/// or any other type.
///
/// ## Available Implementations
///
/// This package provides two concrete implementations with different performance characteristics:
///
/// ### ``QueueArray`` - Educational Implementation
///
/// A naive array-based implementation that demonstrates a critical performance problem.
///
/// **Performance:**
/// - Enqueue: O(1) amortized
/// - **Dequeue: O(n)** ⚠️ (shifts all remaining elements)
/// - Peek: O(1)
/// - Space: O(n)
///
/// **When to use:**
/// - Learning and understanding queue concepts
/// - Educational purposes and algorithm demonstrations
/// - Small queues (< 100 elements) with infrequent dequeues
///
/// **When NOT to use:**
/// - Production code with large queues
/// - High-throughput scenarios
/// - Real-time systems requiring consistent performance
///
/// ### ``QueueStack`` - Production Implementation
///
/// An optimized dual-stack implementation that achieves amortized O(1) operations.
///
/// **Performance:**
/// - Enqueue: O(1)
/// - **Dequeue: Amortized O(1)** ✓ (no element shifting)
/// - Peek: O(1)
/// - Space: O(n)
///
/// **When to use:**
/// - Production code
/// - Large queues or frequent dequeue operations
/// - Performance-critical applications
/// - Real-time systems
///
/// ## Usage Example
///
/// ```swift
/// // Using the protocol allows switching implementations easily
/// var queue: any Queue<String> = QueueStack<String>()
///
/// // Add elements to the back
/// queue.enqueue("First")
/// queue.enqueue("Second")
/// queue.enqueue("Third")
///
/// // Check what's at the front without removing
/// print(queue.peek) // Optional("First")
///
/// // Remove elements from the front (FIFO order)
/// print(queue.dequeue()) // Optional("First")
/// print(queue.dequeue()) // Optional("Second")
///
/// // Queue can be checked for emptiness
/// print(queue.isEmpty) // false
///
/// queue.dequeue() // "Third"
/// print(queue.isEmpty) // true
/// print(queue.dequeue()) // nil - empty queue
/// ```
///
/// ## Choosing an Implementation
///
/// ```swift
/// // For learning: understand the O(n) dequeue problem
/// let learningQueue = QueueArray<Task>()
///
/// // For production: get O(1) performance
/// let productionQueue = QueueStack<Task>()
///
/// // Both conform to Queue, so they're interchangeable:
/// func processTasks<Q: Queue>(_ queue: inout Q) where Q.T == Task {
///     while let task = queue.dequeue() {
///         task.execute()
///     }
/// }
/// ```
///
/// ## Implementation Notes
///
/// Queue implementations in this package are value types (structs) following Swift's standard
/// library conventions. This means:
///
/// - Queue operations are `mutating` methods
/// - Queues have value semantics (copies are independent)
/// - No reference counting or shared state concerns
/// - Thread safety requires explicit synchronization if shared across threads
///
/// - Note: The protocol uses an associated type `T` rather than generics, allowing each
///   conforming type to specify what kind of elements it stores while maintaining type safety.
protocol Queue<T> {
    // MARK: - Associated Types

    /// The type of elements stored in the queue.
    ///
    /// This associated type allows each conforming implementation to specify what kind
    /// of elements it manages, while ensuring type safety at compile time. For example,
    /// `QueueArray<String>` has `T == String`, ensuring you can only enqueue strings.
    ///
    /// - Note: The use of an associated type rather than a generic parameter on the protocol
    ///   allows for more flexible protocol conformance and better type inference in many scenarios.
    associatedtype T

    init()
    
    // MARK: - Properties

    /// A Boolean value indicating whether the queue contains no elements.
    ///
    /// Use this property to check if the queue is empty before attempting operations
    /// that require elements to be present, such as peeking or dequeuing.
    ///
    /// Example:
    /// ```swift
    /// var queue = QueueStack<Int>()
    /// print(queue.isEmpty) // true
    ///
    /// queue.enqueue(42)
    /// print(queue.isEmpty) // false
    ///
    /// queue.dequeue()
    /// print(queue.isEmpty) // true
    /// ```
    ///
    /// - Returns: `true` if the queue has no elements; otherwise, `false`.
    /// - Complexity: O(1) for all implementations.
    var isEmpty: Bool { get }

    /// The element at the front of the queue, without removing it.
    ///
    /// This property allows you to inspect what element would be returned by the next
    /// `dequeue()` operation, without actually modifying the queue. This is useful for
    /// conditional processing where you need to examine the next element before deciding
    /// whether to remove it.
    ///
    /// Example:
    /// ```swift
    /// var queue = QueueStack<String>()
    /// queue.enqueue("First")
    /// queue.enqueue("Second")
    ///
    /// // Check the front element
    /// if let next = queue.peek {
    ///     print("Next element: \(next)") // "First"
    /// }
    ///
    /// // Queue still contains both elements
    /// print(queue.isEmpty) // false
    /// ```
    ///
    /// - Returns: The element at the front of the queue, or `nil` if the queue is empty.
    /// - Complexity: O(1) for all implementations.
    var peek: T? { get }

    // MARK: - Methods

    /// Adds an element to the back of the queue.
    ///
    /// This operation adds the specified element to the end of the queue, where it will
    /// wait until all previously enqueued elements have been dequeued. This maintains
    /// the FIFO (First-In-First-Out) ordering that defines queue behavior.
    ///
    /// The method is marked `mutating` because it modifies the queue's internal state
    /// by adding a new element. This is consistent with Swift's value semantics for
    /// collection types.
    ///
    /// ### Performance Considerations
    ///
    /// - ``QueueArray``: O(1) amortized (occasional array resizing)
    /// - ``QueueStack``: O(1) (appends to internal stack)
    ///
    /// Example:
    /// ```swift
    /// var queue = QueueStack<String>()
    ///
    /// queue.enqueue("Task 1")  // ["Task 1"]
    /// queue.enqueue("Task 2")  // ["Task 1", "Task 2"]
    /// queue.enqueue("Task 3")  // ["Task 1", "Task 2", "Task 3"]
    ///
    /// // Elements will be dequeued in the same order they were enqueued
    /// queue.dequeue() // Returns "Task 1"
    /// queue.dequeue() // Returns "Task 2"
    /// queue.dequeue() // Returns "Task 3"
    /// ```
    ///
    /// - Parameter element: The element to add to the back of the queue.
    /// - Complexity: O(1) amortized for standard implementations.
    mutating func enqueue(_ element: T)

    /// Removes and returns the element at the front of the queue.
    ///
    /// This operation removes the element that has been in the queue the longest,
    /// implementing the FIFO (First-In-First-Out) behavior that defines queues.
    /// If the queue is empty, this method returns `nil` rather than trapping,
    /// allowing graceful handling of empty queue scenarios.
    ///
    /// The method is marked `mutating` because it modifies the queue's internal state
    /// by removing an element. The `@discardableResult` attribute allows calling this
    /// method without using the returned value when you only need to remove elements.
    ///
    /// ### Performance Considerations
    ///
    /// - ``QueueArray``: **O(n)** ⚠️ - Must shift all remaining elements forward
    /// - ``QueueStack``: **Amortized O(1)** ✓ - No element shifting required
    ///
    /// The performance difference becomes significant with large queues or frequent
    /// dequeue operations. For production code, prefer ``QueueStack``.
    ///
    /// Example:
    /// ```swift
    /// var queue = QueueStack<Int>()
    /// queue.enqueue(10)
    /// queue.enqueue(20)
    /// queue.enqueue(30)
    ///
    /// // Remove elements in FIFO order
    /// let first = queue.dequeue()  // Optional(10)
    /// let second = queue.dequeue() // Optional(20)
    /// let third = queue.dequeue()  // Optional(30)
    /// let fourth = queue.dequeue() // nil - queue is empty
    /// ```
    ///
    /// Example of discarding the result:
    /// ```swift
    /// var queue = QueueStack<String>()
    /// queue.enqueue("temporary")
    ///
    /// // Remove without using the value
    /// queue.dequeue() // No warning about unused result
    /// ```
    ///
    /// - Returns: The element at the front of the queue, or `nil` if the queue is empty.
    /// - Complexity: Depends on implementation. See ``QueueArray`` and ``QueueStack``
    ///   for specific complexity guarantees.
    mutating func dequeue() -> T?
}
