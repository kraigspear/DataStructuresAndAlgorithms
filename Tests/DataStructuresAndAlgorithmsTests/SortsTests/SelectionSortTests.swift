//
//  SelectionSortTests.swift
//  DataStructuresAndAlgorithmsTests
//
//  Created by Claude Code on 10/26/25.
//

import Testing
@testable import DataStructuresAndAlgorithms

/// Comprehensive test suite for the SelectionSort algorithm implementation
///
/// SelectionSort works by repeatedly finding the minimum element from the unsorted portion
/// and placing it at the beginning. These tests verify correctness across various edge cases,
/// data types, and array configurations.
@Suite("SelectionSort Algorithm Tests")
struct SelectionSortTests {
    
    @Test("sort test")
    func sortTest() {
        let names = ["Charlie", "Bravo", "Alpha", "Delta", "Echo"]
        let sorted = names.selectionSort()
        #expect(sorted == ["Alpha", "Bravo", "Charlie", "Delta", "Echo"])
    }
    
    @Test("one item")
    func oneItem() {
        let names = ["Charlie"]
        let sorted = names.selectionSort()
        #expect(sorted == ["Charlie"])
    }
    
    @Test("duplicates")
    func duplicates() {
        let names = ["Charlie", "Bravo", "Alpha", "Delta", "Echo", "Charlie"]
        let sorted = names.selectionSort()
        #expect(sorted == ["Alpha", "Bravo", "Charlie", "Charlie", "Delta", "Echo"])
    }
    
    @Test("already sorted")
    func alreadySorted() {
        let names = ["Alpha", "Bravo", "Charlie", "Delta", "Echo"]
        let sorted = names.selectionSort()
        #expect(sorted == ["Alpha", "Bravo", "Charlie", "Delta", "Echo"])
    }

}
