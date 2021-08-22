//
//  QueueArray.swift
//  QueueArray
//
//  Created by Kraig Spear on 8/22/21.
//

import Foundation


struct QueueArray<T>: Queue {
    typealias Element = T

    private var array: [T] = []

    mutating func enqueue(_ element: T) {
        array.append(element)
    }

    @discardableResult
    mutating func dequeue() -> T? {
        isEmpty ? nil : array.removeFirst()
    }

    var peek: T? {
        array.first
    }

    var isEmpty: Bool { array.isEmpty }
}
