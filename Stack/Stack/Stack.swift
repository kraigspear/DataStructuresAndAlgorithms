//
//  Stack.swift
//  Stack
//
//  Created by Kraig Spear on 8/21/21.
//

import Foundation

struct Stack<Element: Equatable>: Equatable {

    init() {}

    init(_ elements: [Element]) {
        self.array.append(contentsOf: elements)
    }

    init(_ elements: Element...) {
        self.array.append(contentsOf: elements)
    }

    private var array: [Element] = []

    mutating func push(_ element: Element) {
        array.append(element)
    }

    @discardableResult
    mutating func pop() -> Element? {
        return array.popLast()
    }

    func peek() -> Element? {
        array.last
    }

    var isEmpty: Bool {
        array.isEmpty
    }
}

extension Stack: CustomStringConvertible {
    var description: String {
        return array.map { "\($0)" }
        .joined(separator: ",")
    }
}

extension Stack: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self.init(elements)
    }
}
