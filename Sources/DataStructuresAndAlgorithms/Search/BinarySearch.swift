//
//  BinarySearch.swift
//  DataStructuresAndAlgorithms
//
//  Created by Kraig Spear on 10/26/25.
//

public extension Array where Element: Comparable {

    /// Performs a binary search to find the index of a target element in a sorted array.
    ///
    /// Binary search is an efficient algorithm that repeatedly divides the search interval in half.
    /// By comparing the target value to the middle element, it eliminates half of the remaining
    /// elements in each iteration, achieving logarithmic time complexity.
    ///
    /// - Important: This method assumes the array is already sorted in ascending order.
    ///   Results are undefined if the array is not sorted.
    ///
    /// - Parameter item: The element to search for in the array.
    /// - Returns: The index of the element if found; otherwise, `nil`.
    ///
    /// - Complexity:
    ///   - Time: O(log n), where n is the number of elements in the array
    ///   - Space: O(log n) due to recursive call stack
    ///
    /// - Note: This implementation uses recursion for clarity and readability.
    ///   While an iterative approach would use O(1) space, the recursive approach
    ///   provides a more intuitive understanding of the divide-and-conquer strategy.
    ///
    /// ## Example
    /// ```swift
    /// let numbers = [1, 3, 5, 7, 9, 11, 13]
    /// if let index = numbers.binarySearch(7) {
    ///     print("Found at index \(index)") // Found at index 3
    /// }
    ///
    /// let notFound = numbers.binarySearch(8)
    /// print(notFound) // nil
    /// ```
    func binarySearch(_ item: Element) -> Int? {

        return search(low: 0, high: count - 1)

        /// Recursively searches for the target element within the specified range.
        ///
        /// This nested function implements the core binary search logic using a divide-and-conquer approach.
        /// We use recursion here because it directly mirrors the mathematical definition of binary search
        /// and makes the algorithm's structure more apparent to readers familiar with the classic formulation.
        ///
        /// - Parameters:
        ///   - low: The lower bound index of the current search range (inclusive)
        ///   - high: The upper bound index of the current search range (inclusive)
        /// - Returns: The index of the target element if found within the range; otherwise, `nil`
        func search(low: Int, high: Int) -> Int? {
            // Base case: search range is invalid when low exceeds high
            // This indicates we've exhausted all possibilities without finding the target
            guard low <= high else { return nil }

            // Calculate midpoint using overflow-safe formula
            // We use low + (high - low) / 2 instead of (low + high) / 2 to prevent
            // potential integer overflow with very large array indices, even though
            // Swift's Int on 64-bit systems has a high max value. This is a defensive
            // programming practice that ensures portability and follows established best practices.
            let mid = low + (high - low) / 2
            let midValue = self[mid]

            // Found the target element at the midpoint
            if midValue == item {
                return mid
            }

            // Target is smaller than midpoint, so it must be in the left half
            // We search the range [low, mid-1] because we've already checked mid
            if item < midValue {
                return search(
                    low: low,
                    high: mid - 1
                )
            }
            // Target is larger than midpoint, so it must be in the right half
            // We search the range [mid+1, high] because we've already checked mid
            return search(
                low: mid + 1,
                high: high
            )
        }


    }

}
