# Data Structures and Algorithms

A Swift package for practicing LeetCode problems and sharpening interview skills. This repository contains implementations of common data structures and algorithms in Swift.

## Purpose

This project serves as:
- 📚 A learning resource for data structures and algorithms
- 💪 Practice for technical interviews
- 🎯 Solutions to common LeetCode-style problems
- 🔧 A reference implementation in modern Swift

## Structure

```
DataStructuresAndAlgorithms/
├── Package.swift                    # Swift Package manifest
├── Sources/
│   ├── DataStructuresAndAlgorithms/ # Library code
│   │   ├── Queue/                   # Queue implementations
│   │   ├── Stack/                   # Stack implementation
│   │   └── Sorts/                   # Sorting algorithms
│   └── Examples/                    # Executable demos
│       └── main.swift
├── Tests/
│   └── DataStructuresAndAlgorithmsTests/
│       ├── QueueTests/
│       ├── StackTests/
│       └── SortsTests/
├── scan.sh                          # Dead code scanner
└── formatcode.sh                    # Code formatter
```

## Implemented Data Structures

### Queue
- **QueueArray**: Simple array-based queue implementation
- **QueueStack**: Optimized queue using dual-stack approach (O(1) amortized operations)

### Stack
- Generic stack implementation with:
  - Array literal initialization
  - Equatable conformance
  - CustomStringConvertible
  - Example: Balanced parentheses checker

### Sorting Algorithms
- **Selection Sort**: O(n²) comparison-based sorting

## Getting Started

### Prerequisites
- Swift 5.10 or later
- macOS 12.0 or later

### Building the Package

```bash
# Build the library
swift build

# Run tests
swift test

# Run examples
swift run Examples
```

### Using in Xcode

Open `Package.swift` in Xcode:
```bash
open Package.swift
```

Or add to your Xcode project via File → Add Package Dependencies.

### Importing the Library

```swift
import DataStructuresAndAlgorithms

// Use Queue
var queue = QueueArray<Int>()
queue.enqueue(1)
queue.enqueue(2)
print(queue.dequeue()) // Optional(1)

// Use Stack
var stack = Stack<String>()
stack.push("Hello")
stack.push("World")
print(stack.pop()) // Optional("World")

// Use Sorting
let numbers = [5, 2, 8, 1, 9]
let sorted = numbers.selectionSort()
print(sorted) // [1, 2, 5, 8, 9]
```

## Development

### Running Tests

```bash
# Run all tests
swift test

# Run specific test
swift test --filter QueueTests
```

### Formatting Code

```bash
./formatcode.sh
```

This uses `swiftformat` to maintain consistent code style.

### Checking for Dead Code

```bash
./scan.sh
```

Note: Periphery has limited Swift Package support. Consider manual code review or build warnings.

## Adding New Topics

To add a new data structure or algorithm:

1. Create a new folder under `Sources/DataStructuresAndAlgorithms/`
2. Add your implementation files
3. Create corresponding test folder under `Tests/DataStructuresAndAlgorithmsTests/`
4. Add examples to `Sources/Examples/main.swift`
5. Update this README

Example topics to add:
- LinkedList
- Trees (Binary Tree, BST, AVL, Red-Black)
- Graphs (BFS, DFS, Dijkstra)
- Hash Tables
- Heaps
- Additional sorting algorithms (Merge Sort, Quick Sort, Heap Sort)

## Testing Philosophy

Tests use Swift Testing framework with:
- Clear test names using `@Test` macro
- `@Suite` for organizing related tests
- Comprehensive assertions with descriptive comments

## Code Quality Standards

This project follows principles from "A Philosophy of Software Design" by John Ousterhout:
- Deep modules with simple interfaces
- Comprehensive comments explaining "why" not just "what"
- Prefer Apple's frameworks over third-party solutions
- Use Swift concurrency instead of GCD

## License

This is a personal learning project. Feel free to use as reference.

## Contributing

This is a personal practice repository, but suggestions and corrections are welcome via issues.

## Resources

- [LeetCode](https://leetcode.com/)
- [Swift.org Documentation](https://swift.org/documentation/)
- [A Philosophy of Software Design](https://web.stanford.edu/~ouster/cgi-bin/book.php)
