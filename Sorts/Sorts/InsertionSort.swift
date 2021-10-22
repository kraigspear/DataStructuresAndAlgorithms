//
//  InsertionSort.swift
//  InsertionSort
//
//  Created by Kraig Spear on 8/22/21.
//

import Foundation

extension Array where Element: Comparable {

    func insertionSort() -> [Element] {

        guard count >= 2 else { return self }

        var sortingArray = self

        for numberOfElementsToCompare in 1..<sortingArray.count {

            // Each iteration through this loop we are incrementally comparing one more item
            // We are sorting 2 values, then 3 ext.. Left to Right
            // until we reach the beginning or we run into a value where the value to the left is <
            // then the value to the right.
            // What makes this not great is in a worse case scenario if the value at the end of an array
            // is less than all other values you are swiping 'n' times and depending on the array
            // this could happen often.
            let range = (1...numberOfElementsToCompare).reversed()

            print("range: \(range)")

            print("🍀 Outer numberOfElementsToCompare: \(numberOfElementsToCompare) comparing: indexes \(range.first!) to \(range.last!)")

            // Swap all values where the left value is > than the value being compared
            // Example:
            //
            // ☀️ comparingValue: 5 valueLeftOfComparingValue: 1000 Array: [1000, 5, 1, 76, 10, 5, 7, 2, 5, 2]
            // Value: 5 is < 1000 need to swap
            // Before Swap [1000, 5, 1, 76, 10, 5, 7, 2, 5, 2]
            // After Swap [5, 1000, 1, 76, 10, 5, 7, 2, 5, 2]

            for index in range {
                if !sortingArray.swapLeftGreater(index) {
                    break
                }
            }
        }

        return sortingArray
    }
}

extension Array where Element: Comparable {
    /**
     Swap if the value to the left is greater than this value
     */
    mutating func swapLeftGreater(_ index: Int) -> Bool {
        let left = self.left(index)
        let value = self[index]
        if left.value > value {
            print("swipe index: \(index) with index: \(left.index) value: \(value) with: \(left.value) \(self)")
            swapAt(index, left.index)
            print("After: \(self)")
            return true
        }
        return false
    }

    func left(_ index: Int) -> (index: Int, value: Element) {
        let leftOfIndex = index - 1
        return (index: leftOfIndex,
                value: self[leftOfIndex])
    }
}
