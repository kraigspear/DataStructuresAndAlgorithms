//
//  Test.swift
//  DataStructuresAndAlgorithms
//
//  Created by Kraig Spear on 10/26/25.
//

import Testing

struct BinaryTest {
    
    @Test("Binary Search")
    func binarySearch() async throws {
        let numbers = [1, 3, 5, 7, 9, 11, 13]
        // Test element present in the array
        let index = numbers.binarySearch(7)
        #expect(index == 3, "7 should be found at index 3")

        // Test element not present in the array
        let notFound = numbers.binarySearch(8)
        #expect(notFound == nil, "8 is not in the array, should return nil")

    }
    
    @Test("Empty Array")
    func emptyArray() {
        let empty: [Int] = []
        let emptyResult = empty.binarySearch(42)
        #expect(emptyResult == nil, "Searching an empty array should return nil")
    }
    
    @Test("Single Element Array")
    func singleElementArray() {
        let singlePresent = [42]
        let found = singlePresent.binarySearch(42)
        #expect(found == 0, "Should find 42 at index 0 in single-element array")

        let singleAbsent = [99]
        let notFound = singleAbsent.binarySearch(42)
        #expect(notFound == nil, "Should not find 42 in [99]")
    }
    
    @Test("Array With Duplicates")
    func arrayWithDuplicates() {
        let array = [1, 2, 2, 2, 3, 4, 5]
        let found = array.binarySearch(2)
        #expect(found == 1 || found == 2 || found == 3, "Should find 2 at any index in [1, 2, 2, 2, 3, 4, 5]")

        let notFound = array.binarySearch(6)
        #expect(notFound == nil, "Should not find 6 in array with duplicates")
    }

    @Test("Boundary Values")
    func boundaryValues() {
        let array = [10, 20, 30, 40, 50]

        let firstIndex = array.binarySearch(10)
        #expect(firstIndex == 0, "Should find 10 at index 0 (first element)")

        let lastIndex = array.binarySearch(50)
        #expect(lastIndex == 4, "Should find 50 at index 4 (last element)")
    }

}
