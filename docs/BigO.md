# Big O Notation

Big O notation describes the **time complexity** or **space complexity** of an algorithm - how the runtime or memory usage grows as the input size increases.

## Why Big O Matters

Big O helps you:
- **Compare algorithms**: Which one performs better at scale?
- **Predict performance**: How will this behave with 1 million items?
- **Make informed decisions**: When to use which data structure or algorithm

## Common Time Complexities

Listed from fastest to slowest:

### O(1) - Constant Time
**Performance**: Same time regardless of input size

**Examples:**
- Accessing an array element by index: `array[5]`
- Pushing to a stack: `stack.push(item)`
- Popping from a stack: `stack.pop()`
- Hash table lookup (average case)

```swift
// O(1) - Single operation, doesn't depend on n
func getFirst<T>(_ array: [T]) -> T? {
    return array.first
}
```

**Real world**: Instant, always fast

---

### O(log n) - Logarithmic Time
**Performance**: Grows slowly as input doubles

**Examples:**
- Binary search in sorted array
- Balanced tree operations (BST, AVL, Red-Black)

```swift
// O(log n) - Each iteration cuts the problem in half
func binarySearch<T: Comparable>(_ array: [T], _ target: T) -> Int? {
    var left = 0
    var right = array.count - 1

    while left <= right {
        let mid = (left + right) / 2
        if array[mid] == target {
            return mid
        } else if array[mid] < target {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    return nil
}
```

**Real world**: Very fast even for large datasets
- 1,000 items → ~10 operations
- 1,000,000 items → ~20 operations

---

### O(n) - Linear Time
**Performance**: Grows proportionally with input size

**Examples:**
- Iterating through an array once
- Linear search
- Finding max/min in unsorted array

```swift
// O(n) - Must check every element
func findMax(_ array: [Int]) -> Int? {
    var max = array.first
    for num in array {
        if let currentMax = max, num > currentMax {
            max = num
        }
    }
    return max
}
```

**Real world**: Reasonable for most use cases
- 1,000 items → 1,000 operations
- 1,000,000 items → 1,000,000 operations

---

### O(n log n) - Linearithmic Time
**Performance**: Better than O(n²), worse than O(n)

**Examples:**
- Efficient sorting algorithms (Merge Sort, Quick Sort, Heap Sort)

```swift
// O(n log n) - Divide and conquer sorting
func mergeSort<T: Comparable>(_ array: [T]) -> [T] {
    guard array.count > 1 else { return array }

    let mid = array.count / 2
    let left = mergeSort(Array(array[..<mid]))
    let right = mergeSort(Array(array[mid...]))

    return merge(left, right)
}
```

**Real world**: Standard for sorting large datasets
- 1,000 items → ~10,000 operations
- 1,000,000 items → ~20,000,000 operations

---

### O(n²) - Quadratic Time
**Performance**: Grows rapidly, nested loops

**Examples:**
- Bubble Sort, Selection Sort, Insertion Sort
- Comparing every item with every other item

```swift
// O(n²) - Nested loops
func selectionSort<T: Comparable>(_ array: [T]) -> [T] {
    var result = array
    for i in 0..<result.count {
        var minIndex = i
        for j in (i+1)..<result.count {  // Nested loop!
            if result[j] < result[minIndex] {
                minIndex = j
            }
        }
        result.swapAt(i, minIndex)
    }
    return result
}
```

**Real world**: Only practical for small datasets
- 1,000 items → 1,000,000 operations ⚠️
- 1,000,000 items → 1,000,000,000,000 operations 🔥

---

### O(2ⁿ) - Exponential Time
**Performance**: Doubles with each additional input

**Examples:**
- Recursive Fibonacci (naive implementation)
- Generating all subsets of a set
- Brute force solutions

```swift
// O(2ⁿ) - Each call spawns two more calls
func fibonacci(_ n: Int) -> Int {
    if n <= 1 { return n }
    return fibonacci(n - 1) + fibonacci(n - 2)
}
```

**Real world**: Impractical for n > 30
- 10 items → 1,024 operations
- 20 items → 1,048,576 operations
- 30 items → 1,073,741,824 operations 💀

---

## Performance Comparison

For 1,000,000 items:

| Big O | Operations | Relative Speed |
|-------|-----------|----------------|
| O(1) | 1 | ⚡️ Instant |
| O(log n) | 20 | ⚡️ Extremely fast |
| O(n) | 1,000,000 | ✅ Fast |
| O(n log n) | 20,000,000 | ✅ Acceptable |
| O(n²) | 1,000,000,000,000 | 🐌 Very slow |
| O(2ⁿ) | ∞ | 💀 Unusable |

## What to Remember

### Focus on Growth Rate
Big O describes how time grows **as input grows**, not the exact time.
- O(100n) → O(n) - constants are dropped
- O(n + 1000) → O(n) - smaller terms are dropped
- O(2n + n²) → O(n²) - keep only the dominant term

### Worst Case Analysis
Big O typically describes the **worst-case** scenario:
- Array search: O(n) even though you might find it immediately
- QuickSort: O(n²) worst case, O(n log n) average case

### Space vs Time
Big O applies to both time AND space:
- **Time complexity**: How long does it take?
- **Space complexity**: How much memory does it use?

Example: Merge Sort is O(n log n) time but O(n) space (needs extra arrays)

## Examples from This Project

### Queue Implementations

**QueueArray** (Naive):
- Enqueue: O(1) ✅
- Dequeue: **O(n)** ⚠️ - Must shift all elements
- Space: O(n)

**QueueStack** (Optimized):
- Enqueue: O(1) ✅
- Dequeue: **O(1) amortized** ✅ - No shifting needed
- Space: O(n)

### Stack
- Push: O(1) ✅
- Pop: O(1) ✅
- Peek: O(1) ✅
- Space: O(n)

### Selection Sort
- Time: O(n²) ⚠️ - Nested loops
- Space: O(1) ✅ - Sorts in place
- Not suitable for large datasets

## How to Determine Big O

1. **Single loop through n items**: O(n)
2. **Nested loops**: O(n²), O(n³), etc.
3. **Dividing problem in half repeatedly**: O(log n)
4. **Divide and conquer with merge**: O(n log n)
5. **Fixed number of operations**: O(1)

### Tips
- **Count the loops**: Nested loops multiply
- **Ignore constants**: 5n → n
- **Drop smaller terms**: n² + n → n²
- **Different inputs use different variables**: O(a + b) or O(a × b)

## Resources

- [Big-O Cheat Sheet](https://www.bigocheatsheet.com/)
- [Visualizing Algorithms](https://visualgo.net/)
- Introduction to Algorithms (CLRS)

## See Also

- [Queue Documentation](Queue.md) - O(1) amortized vs O(n)
- [Stack Documentation](Stack.md) - O(1) operations
- [Sorts Documentation](Sorts.md) - O(n²) Selection Sort
