//
//  BubbleSort.swift
//  BubbleSort
//
//  Created by Kraig Spear on 8/22/21.
//

import Foundation

/**
 The worst performant of all sorting algorithms


 */
extension Array where Element: Comparable {
    func bubbleSort() -> [Element] {

        guard count >= 2 else { return self }

        var copy = self

        // At the end of each iteration, we know the largest value is
        // bubbled up to the end.
        // The number of elements is now one less because it's already sorted.
        for end in (1..<copy.count).reversed() {
            print("end: \(end)")

            var swapped = false

            for currentIndex in 0..<end {
                let nextIndex = currentIndex + 1
                print("currentIndex: \(currentIndex) nextIndex: \(nextIndex)")
                let currentVal = copy[currentIndex]
                let nextVal = copy[nextIndex]

                if currentVal > nextVal {
                    print("Need to swipe \(currentVal) \(nextVal)")
                    print("Before Swipe: \(copy)")
                    copy.swapAt(currentIndex, nextIndex)
                    print("After Swipe: \(copy)")
                    swapped = true
                } else {
                    print("No need to swipe \(currentVal) \(nextVal)")
                }
            }

            if !swapped {
                print("Not swapped, we done.")
                return copy
            }
        }

        return copy
    }
}
