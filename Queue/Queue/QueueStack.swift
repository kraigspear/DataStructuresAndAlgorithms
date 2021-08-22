//
//  QueueStack.swift
//  QueueStack
//
//  Created by Kraig Spear on 8/22/21.
//

import Foundation

/**
 The point of using a stack is not shifting up all of the array elements.
 When you remove first element of an array each element must be copied up
 One position. 

 This overhead can be significant.

 This implementation reverses the Queue so that elements are removed
 from the bottom, not the top.

 Removing from the bottom has little overhead.

 When an item is dequeued
 The elements are copied to another array in reverse order
 This only needs to happen when the queue is empty. 
 */
struct QueueStack<T>: Queue {

    typealias Element = T

    private var enqueueStack: [Element] = []
    private var dequeueStack: [Element] = []

    var isEmpty: Bool {
        enqueueStack.isEmpty && dequeueStack.isEmpty
    }

    var peek: T? {
        dequeueStack.isEmpty == false ? dequeueStack.last : enqueueStack.first
    }

    mutating func enqueue(_ element: T) {
        enqueueStack.append(element)
    }

    @discardableResult
    mutating func dequeue() -> T? {
        if dequeueStack.isEmpty {
            dequeueStack = enqueueStack.reversed()
            enqueueStack.removeAll()
        }
        return dequeueStack.popLast()
    }

}
