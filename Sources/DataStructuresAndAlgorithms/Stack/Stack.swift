//
//  Stack.swift
//  DataStructuresAndAlgorithms
//
//  Created by Kraig Spear on 8/21/21.
//

import Foundation

public struct Stack<Element: Equatable>: Equatable {
    public init() {}

    public init(_ elements: [Element]) {
        array.append(contentsOf: elements)
    }

    public init(_ elements: Element...) {
        array.append(contentsOf: elements)
    }

    private var array: [Element] = []

    public mutating func push(_ element: Element) {
        array.append(element)
    }

    @discardableResult
    public mutating func pop() -> Element? {
        array.popLast()
    }

    public func peek() -> Element? {
        array.last
    }

    public var isEmpty: Bool {
        array.isEmpty
    }
}

extension Stack: CustomStringConvertible {
    public var description: String {
        array.map { "\($0)" }
            .joined(separator: ",")
    }
}

extension Stack: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        self.init(elements)
    }
}
