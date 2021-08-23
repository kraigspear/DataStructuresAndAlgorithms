//
//  main.swift
//  Sorts
//
//  Created by Kraig Spear on 8/22/21.
//

import Foundation

func testSorts() {
    let myArray = [1000,5,1,76,10,5,7,2,5,2]

    let bubble = myArray.bubbleSort()

    print("bubble: \(bubble)")

    let selection = myArray.selectionSort()

    print("selection: \(bubble)")

    assert(bubble == selection)

    let insertion = myArray.insertionSort()

    print("insertion: \(insertion)")
    assert(insertion == selection)
}

testSorts()

