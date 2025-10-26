//
//  main.swift
//  Examples
//
//  DataStructures and Algorithms Examples
//  Demonstrates Queue, Stack, and Sorts implementations
//

import DataStructuresAndAlgorithms
import Foundation

print("=== Data Structures and Algorithms Examples ===\n")

// MARK: - Queue Examples

print("--- Queue Examples ---")

func demonstrateQueueArray() {
    print("\n🔸 QueueArray Demo:")
    var queueArray = QueueArray<String>()

    assert(queueArray.isEmpty)
    queueArray.enqueue("Tippy")
    assert(!queueArray.isEmpty)
    queueArray.enqueue("Toonsis")
    queueArray.enqueue("Grumpy")

    print("  Enqueued: Tippy, Toonsis, Grumpy")

    let dequeue = queueArray.dequeue()!
    print("  Dequeued: \(dequeue)")
    assert(dequeue == "Tippy")
    assert(queueArray.peek == "Toonsis")
    print("  Peek: \(queueArray.peek ?? "nil")")

    queueArray.dequeue()
    assert(!queueArray.isEmpty)
    queueArray.dequeue()
    assert(queueArray.isEmpty)
    print("  ✅ QueueArray works correctly!")
}

func demonstrateQueueStack() {
    print("\n🔸 QueueStack Demo (optimized with dual stacks):")
    var queueStack = QueueStack<String>()

    assert(queueStack.isEmpty)
    queueStack.enqueue("Tippy")
    assert(!queueStack.isEmpty)
    queueStack.enqueue("Toonsis")
    queueStack.enqueue("Grumpy")

    print("  Enqueued: Tippy, Toonsis, Grumpy")

    let dequeue = queueStack.dequeue()!
    print("  Dequeued: \(dequeue)")
    assert(dequeue == "Tippy")
    assert(queueStack.peek == "Toonsis")
    print("  Peek: \(queueStack.peek ?? "nil")")

    queueStack.dequeue()
    assert(!queueStack.isEmpty)
    queueStack.dequeue()
    assert(queueStack.isEmpty)
    print("  ✅ QueueStack works correctly!")
}

demonstrateQueueArray()
demonstrateQueueStack()

// MARK: - Stack Examples

print("\n--- Stack Examples ---")

func demonstrateBasicStack() {
    print("\n🔸 Basic Stack Operations:")
    var myStack = Stack<String>()

    assert(myStack.isEmpty)

    myStack.push("Kraig")
    assert(!myStack.isEmpty)

    myStack.push("Christine")
    myStack.push("Tippy")

    print("  Stack: \(myStack)")
    print("  Peek: \(String(describing: myStack.peek()))")
    print("  Pop: \(String(describing: myStack.pop()))")
    print("  Stack after pop: \(myStack)")
    print("  ✅ Basic stack operations work!")
}

func demonstrateStackInitializers() {
    print("\n🔸 Stack Initializers:")
    let stack1 = Stack<String>(["One", "Two", "Three"])

    let lastPeek = stack1.peek()
    print("  Stack from array: \(stack1)")
    print("  Peek: \(String(describing: lastPeek))")

    assert(lastPeek == "Three")
    print("  ✅ Array initializer works!")
}

func demonstrateStackEquality() {
    print("\n🔸 Stack Equality:")
    let stack1 = Stack<Int>(1, 2, 3)
    let stack2: Stack = [1, 2, 3]
    let stack3: Stack = [3, 2, 1]

    print("  Stack1: \(stack1)")
    print("  Stack2: \(stack2)")
    print("  Stack3: \(stack3)")
    print("  Stack1 == Stack2: \(stack1 == stack2)")
    print("  Stack1 == Stack3: \(stack1 == stack3)")

    assert(stack1 == stack2)
    assert(stack1 != stack3)
    print("  ✅ Stack equality works!")
}

func demonstrateBalancedParentheses() {
    print("\n🔸 Balanced Parentheses Problem:")

    func areParensBalanced(_ value: String) -> Bool {
        var stack = Stack<Character>()

        for c in value {
            if c == "(" {
                stack.push(c)
            } else if c == ")" {
                if stack.isEmpty {
                    return false
                }
                stack.pop()
            }
        }

        return stack.isEmpty
    }

    func areParensBalancedNoStack(_ value: String) -> Bool {
        var count = 0

        for c in value {
            if c == "(" {
                count += 1
            } else if c == ")" {
                count -= 1
                if count < 0 { return false }
            }
        }

        return count == 0
    }

    let test1 = "(test) (what) up"
    let test2 = "(test) (what) up)"

    print("  Testing: '\(test1)'")
    print("    With stack: \(areParensBalanced(test1))")
    print("    Without stack: \(areParensBalancedNoStack(test1))")

    print("  Testing: '\(test2)'")
    print("    With stack: \(areParensBalanced(test2))")
    print("    Without stack: \(areParensBalancedNoStack(test2))")

    assert(areParensBalanced(test1))
    assert(!areParensBalanced(test2))
    assert(areParensBalancedNoStack(test1))
    assert(!areParensBalancedNoStack(test2))

    print("  💡 Interesting: Counter approach is more efficient than stack!")
    print("  ✅ Parentheses validation works!")
}

demonstrateBasicStack()
demonstrateStackInitializers()
demonstrateStackEquality()
demonstrateBalancedParentheses()

// MARK: - Sorting Examples

print("\n--- Sorting Examples ---")

func demonstrateSorts() {
    print("\n🔸 Sorting Algorithms:")
    let myArray = [5, 1, 76, 10, 5, 7, 2, 5, 2, 1000]
    let expected = [1, 2, 2, 5, 5, 5, 7, 10, 76, 1000]

    func runTest(named: String, test: () -> [Int]) {
        let result = test()
        let prefix = expected == result ? "✅" : "❌"
        print("  \(prefix) \(named)")
        if expected != result {
            print("    Expected: \(expected)")
            print("    Got: \(result)")
        }
    }

    print("  Input: \(myArray)")
    print("  Expected: \(expected)")
    print("")

    runTest(named: "selectionSort") {
        myArray.selectionSort()
    }
}

demonstrateSorts()

print("\n=== All Examples Completed Successfully! ===")
