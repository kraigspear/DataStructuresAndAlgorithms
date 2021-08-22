//
//  Queue.swift
//  Queue
//
//  Created by Kraig Spear on 8/22/21.
//

import Foundation

protocol Queue {
    associatedtype Element
    mutating func enqueue(_ element: Element)
    mutating func dequeue() -> Element?
    var isEmpty: Bool { get }
    var peek: Element? { get }
}
