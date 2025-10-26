//
//  TwoSum.swift
//  DataStructuresAndAlgorithms
//
//  Created by Kraig Spear on 10/26/25.
//


public func twoSums(_ numbers: [Int], _ target: Int) -> (firstIndex: Int, secondIndex: Int)? {
    // Step 1: Create a dictionary to map values to their indices for numbers we've already seen
    // Why: We're not comparing each value together, but instead generating a possible answer and looking it up in our table.
    // This allows O(1) lookup to check if a complement exists, avoiding nested loops (which would be O(n²))
    //
    // Example: numbers = [2, 7, 11, 15], target = 9
    // We'll build this table as we iterate: {2: 0, 7: 1, ...}
    var valueToIndexMap: [Int: Int] = [:]

    // Step 2: Iterate through the array with both index and value
    // Why: We need the index to return as part of the solution
    for (index, value) in numbers.enumerated() {

        // Step 3: Generate the complement - the value we would need to have already seen to reach our target
        // Why: Instead of comparing all pairs, we calculate what number would give us the answer and look it up
        //
        // Example iteration 1: value=2, complement=9-2=7 (need to find 7)
        // Example iteration 2: value=7, complement=9-7=2 (need to find 2)
        let complement = target - value

        // Step 4: Look up if this complement exists in our map of previously seen values
        // Why: If we find it, we've discovered a pair that sums to the target without comparing every combination
        //
        // Example iteration 1: Is 7 in valueToIndexMap? No (map is empty)
        // Example iteration 2: Is 2 in valueToIndexMap? Yes! (we stored it in iteration 1)
        if let otherIndex = valueToIndexMap[complement] {
            // Step 5: Return the indices of both numbers that sum to target
            // Why: otherIndex is where we saw the complement earlier, index is our current position
            //
            // Example iteration 2: Found! Return (firstIndex: 0, secondIndex: 1) because numbers[0]=2 and numbers[1]=7 sum to 9
            return (firstIndex: otherIndex, secondIndex: index)
        }

        // Step 6: The complement wasn't found in our map yet, so store the current value for future lookups
        // Why: The current value didn't find its match yet, but it might be the complement that a future number needs.
        // When we process that future number and it looks up its complement, it will find this value we're storing now.
        //
        // Example iteration 1: Complement 7 not found, so store {2: 0} in valueToIndexMap
        // This way when we later process the value 7, it will look for complement 2 and find it in the map
        valueToIndexMap[value] = index
    }

    // Step 7: Return nil if no pair found after checking all elements
    // Why: Optional return allows us to indicate no solution exists in a type-safe way
    return nil
}
