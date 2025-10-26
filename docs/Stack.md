# Stack

A stack is a LIFO (Last-In-First-Out) data structure where elements are added and removed from the same end (the top).

## Implementation

Generic stack implementation with:
- Array literal initialization
- Equatable conformance
- CustomStringConvertible
- Push/pop operations

**Performance:**
- Push: O(1)
- Pop: O(1)
- Peek: O(1)

## Usage Examples

```swift
import DataStructuresAndAlgorithms

// Create and use a stack
var stack = Stack<String>()
stack.push("Hello")
stack.push("World")
print(stack.pop())  // Optional("World")
print(stack.peek)   // Optional("Hello")
print(stack.isEmpty) // false

// Initialize with array literal
let stack2: Stack = [1, 2, 3, 4, 5]
print(stack2) // Stack: [1, 2, 3, 4, 5]
```

## Common Use Cases

- **Balanced parentheses checker**: Verify that opening and closing brackets match
- **Function call stack**: Track nested function calls
- **Undo/redo functionality**: Maintain history of operations
- **Expression evaluation**: Parse and evaluate mathematical expressions
- **Depth-first search**: Traverse graphs and trees

## Example: Balanced Parentheses

The implementation includes a practical example of checking for balanced parentheses:

```swift
func isBalanced(_ string: String) -> Bool {
    var stack = Stack<Character>()
    for char in string {
        if char == "(" {
            stack.push(char)
        } else if char == ")" {
            if stack.pop() == nil {
                return false
            }
        }
    }
    return stack.isEmpty
}

print(isBalanced("(())"))    // true
print(isBalanced("(()"))     // false
print(isBalanced("())"))     // false
```

## See Also

- [Stack Implementation](../Sources/DataStructuresAndAlgorithms/Stack/Stack.swift)
- [Tests](../Tests/DataStructuresAndAlgorithmsTests/StackTests/)
