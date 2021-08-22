//
//  main.swift
//  Queue
//
//  Created by Kraig Spear on 8/22/21.
//

import Foundation


func testQueueArray() {

    var queueArray = QueueArray<String>()

    assert(queueArray.isEmpty)
    queueArray.enqueue("Tippy")
    assert(!queueArray.isEmpty)
    queueArray.enqueue("Toonsis")
    queueArray.enqueue("Grumpy")

    let dequeue = queueArray.dequeue()!
    assert(dequeue == "Tippy")
    assert(queueArray.peek == "Toonsis")

    queueArray.dequeue()
    assert(!queueArray.isEmpty)
    queueArray.dequeue()
    assert(queueArray.isEmpty)
}

testQueueArray()

func testQueueStack() {
    var queueArray = QueueStack<String>()

    assert(queueArray.isEmpty)
    queueArray.enqueue("Tippy")
    assert(!queueArray.isEmpty)
    queueArray.enqueue("Toonsis")
    queueArray.enqueue("Grumpy")

    let dequeue = queueArray.dequeue()!
    assert(dequeue == "Tippy")
    assert(queueArray.peek == "Toonsis")

    queueArray.dequeue()
    assert(!queueArray.isEmpty)
    queueArray.dequeue()
    assert(queueArray.isEmpty)
}

testQueueStack()

