//
//  SelectionSort.swift
//  DataStructuresAndAlgorithms
//
//  Created by Kraig Spear on 8/22/21.
//

import Foundation

/**
 Go thought each element
 Find the lowest element, swapping the lowest
 Now process the remaining
 */

public extension Array where Element: Comparable {
    func selectionSort() -> [Element] {
        guard count >= 2 else { return self }

        var copy = self

        /**
         Loop left to right
         Find the lowest value
         Swap this index with the lowest
         */

        for index in 0 ..< (count - 1) {
            print("index: \(index)")
            var lowestIndex = index
            var lowestVal = copy[index]

            for compareIndex in (index + 1) ..< count {
                let compareValue = copy[compareIndex]
                if compareValue < lowestVal {
                    lowestIndex = compareIndex
                    lowestVal = compareValue
                }
            }

            if lowestIndex != index {
                print("lowestIndex: \(lowestIndex)")
                print("before: \(copy)")
                copy.swapAt(lowestIndex, index)
                print("after: \(copy)")
            } else {
                print("index is already lowest")
            }
        }

        return copy
    }
}
