//
//  SelectionSort.swift
//  SelectionSort
//
//  Created by Kraig Spear on 8/22/21.
//

import Foundation

/**
 Go thought each element
 Find the lowest element, swapping the lowest
 Now process the remaining
 */

extension Array where Element: Comparable {

    func selectionSort() -> [Element] {
        guard count >= 2 else { return self }

        var copy = self

        for index in 0..<(count - 1) {
            var lowestIndex = index
            var lowestVal = copy[index]

            for compareIndex in (index + 1)..<count {
                let compareValue = copy[compareIndex]
                if compareValue < lowestVal {
                   lowestIndex = compareIndex
                   lowestVal = compareValue
                }
            }

            if lowestIndex != index {
                copy.swapAt(lowestIndex, index)
            }
        }

        return copy
    }

}
