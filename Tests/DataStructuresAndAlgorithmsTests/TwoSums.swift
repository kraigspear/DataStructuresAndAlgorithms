//
//  Test.swift
//  DataStructuresAndAlgorithms
//
//  Created by Kraig Spear on 10/26/25.
//

import Testing
@testable import DataStructuresAndAlgorithms

struct Test {

    @Test("TwoSum")
    func twoSum() async throws {

        let nums = [1,6,7,9,10,20]

        let answer = twoSums(nums, 29)

        #expect(answer?.firstIndex == 3)
        #expect(answer?.secondIndex == 5)

    }

}
