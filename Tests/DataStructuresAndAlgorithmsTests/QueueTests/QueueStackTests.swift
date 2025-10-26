//
//  QueueStackTests.swift
//  DataStructuresAndAlgorithmsTests
//
//  Created by Claude Code
//

@testable import DataStructuresAndAlgorithms
import Testing

@Suite("QueueStack Tests")
struct QueueStackTests {
    @Test("QueueStack")
    func queueStack() {
        testQueue(queueType: QueueStack<String>.self)
    }

    @Test("QueueArray")
    func queueArray() {
        testQueue(queueType: QueueArray<String>.self)
    }

    func testQueue<Q: Queue<String>>(queueType: Q.Type) {
        var queue = queueType.init()
        #expect(queue.isEmpty, "Initial state, empty")
        queue.enqueue("Tippy")
        #expect(!queue.isEmpty, "Item added, not empty")
        queue.enqueue("Toonsis")
        queue.enqueue("Grumpy")

        let dequeue = queue.dequeue()!
        #expect(dequeue == "Tippy", "First item expected")
        #expect(queue.peek == "Toonsis", "We can see the next item, but it's not dequeued yet")

        #expect(queue.dequeue() == "Toonsis", "Dequeued Toonsis")

        // At this point we have 1 more item in dequeueStack
        // by enqueueing another we'll test that we rebuild dequeueStack, after all items have been removed

        queue.enqueue("Happy")

        #expect(queue.dequeue() == "Grumpy", "last item in dequeueStack")
        #expect(queue.dequeue() == "Happy", "dequeueStack was rebuilt")
    }
}
