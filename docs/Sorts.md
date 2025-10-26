# Sorting Algorithms

Collection of sorting algorithm implementations in Swift.

## Implemented Algorithms

### Selection Sort

A comparison-based sorting algorithm that divides the array into sorted and unsorted regions, repeatedly selecting the minimum element from the unsorted region.

**Performance:**
- Time Complexity: O(n²)
- Space Complexity: O(1)
- Stable: No
- In-place: Yes

**How it works:**
1. Find the minimum element in the unsorted portion
2. Swap it with the first unsorted element
3. Move the boundary between sorted and unsorted regions
4. Repeat until the entire array is sorted

**When to use:**
- Small datasets
- When memory is limited (in-place sorting)
- When simplicity is more important than performance

**Not recommended for:**
- Large datasets (O(n²) makes it impractical)
- When stability is required

## Usage Examples

```swift
import DataStructuresAndAlgorithms

let numbers = [5, 2, 8, 1, 9, 3]
let sorted = numbers.selectionSort()
print(sorted) // [1, 2, 3, 5, 8, 9]

// Works with any Comparable type
let names = ["Zoe", "Alice", "Bob", "Charlie"]
let sortedNames = names.selectionSort()
print(sortedNames) // ["Alice", "Bob", "Charlie", "Zoe"]
```

## Planned Algorithms

Future sorting algorithms to implement:

- **Bubble Sort**: O(n²) - Simple but inefficient
- **Insertion Sort**: O(n²) - Efficient for small/nearly sorted data
- **Merge Sort**: O(n log n) - Stable, divide and conquer
- **Quick Sort**: O(n log n) average - Fast, widely used
- **Heap Sort**: O(n log n) - In-place, uses heap data structure

## See Also

- [Selection Sort Implementation](../Sources/DataStructuresAndAlgorithms/Sorts/SelectionSort.swift)
- [Tests](../Tests/DataStructuresAndAlgorithmsTests/SortsTests/)
