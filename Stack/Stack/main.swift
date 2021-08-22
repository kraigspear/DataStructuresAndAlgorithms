//
//  main.swift
//  Stack
//
//  Created by Kraig Spear on 3/20/21.
//

import Foundation


var myStack = Stack<String>()

assert(myStack.isEmpty)

myStack.push("Kraig")
assert(!myStack.isEmpty)

myStack.push("Christine")
myStack.push("Tippy")

print("Stack: \(myStack)")
print("Peek: \(String(describing: myStack.peek()))")
print("Pop: \(String(describing: myStack.pop()))")
print("Stack: \(myStack)")

func testPassInArray() {
    myStack = Stack<String>(["One", "Two", "Three"])

    let lastPeek = myStack.peek()
    print("lastPeek: \(String(describing: lastPeek))")

    assert(lastPeek == "Three")
}

testPassInArray()

func testEquatable() {
    let stack1 = Stack<Int>(1,2,3)
    let stack2: Stack = [1,2,3]
    let stack3: Stack = [3,2,1]

    assert(stack1 == stack2)
    assert(stack1 != stack3)
}

testEquatable()

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

assert(areParensBalanced("(test) (what) up"))
assert(!areParensBalanced("(test) (what) up)"))

assert(areParensBalancedNoStack("(test) (what) up"))
assert(!areParensBalancedNoStack("(test) (what) up)"))

/*
 Interesting that this is one of the go to problems to solve with a stack and it's not
 the most efficient.

 By using the stack, we take up more memory and have the overhead of adding and removing
 to a backing store.

 Locally the same thing can be done with a counter, which doesn't use extra memory or
 the overhead of using some underlying data structure.

 */



