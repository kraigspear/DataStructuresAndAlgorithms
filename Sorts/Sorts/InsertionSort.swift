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

        // Sort starting with comparing 2 items, adding one more item to compare
        // each time through the outer loop

        // Walking from left to right, we continue to swipe from highest to lowest
        // until the value to the left is not greater than the value we're comparing
        for numberOfElementsToCompare in 1..<sortingArray.count {

            // Each iteration through this loop we are incrementally comparing one more item
            // We are sorting 2 values, then 3 ext.. Left to Right
            // until we reach the beginning or we run into a value where the value to the left is <
            // then the value to the right.
            // What makes this not great is in a worse case scenario if the value at the end of an array
            // is less than all other values you are swiping 'n' times and depending on the array
            // this could happen often.
            let compareRange = (1...numberOfElementsToCompare).reversed()

            print("🍀 Outer numberOfElementsToCompare: \(numberOfElementsToCompare) comparing: indexes \(compareRange.first!) to \(compareRange.last!)")

            // Swipe all values where the left value is > than the value being compared
            // Example:
            //
            // ☀️ comparingValue: 5 valueLeftOfComparingValue: 1000 Array: [1000, 5, 1, 76, 10, 5, 7, 2, 5, 2]
            // Value: 5 is < 1000 need to swap
            // Before Swap [1000, 5, 1, 76, 10, 5, 7, 2, 5, 2]
            // After Swap [5, 1000, 1, 76, 10, 5, 7, 2, 5, 2]

            for comparingIndex in compareRange {
                let comparingValue = sortingArray[comparingIndex]
                let indexLeftOfComparingValue = comparingIndex - 1
                let valueLeftOfComparingValue = sortingArray[indexLeftOfComparingValue]

                print("☀️ comparingValue: \(comparingValue) valueLeftOfComparingValue: \(valueLeftOfComparingValue) Array: \(sortingArray) ")

                if valueLeftOfComparingValue > comparingValue {
                    print("Value: \(comparingValue) is < \(valueLeftOfComparingValue) need to swap")
                    print("Before Swap \(sortingArray)")
                    sortingArray.swapAt(comparingIndex, indexLeftOfComparingValue)
                    print("After Swap \(sortingArray)")
                } else {
                    print("⭐️Value: \(comparingValue) is NOT < \(valueLeftOfComparingValue) need to break out of loop")
                    break
                }
            }
        }

        return sortingArray
    }
}
