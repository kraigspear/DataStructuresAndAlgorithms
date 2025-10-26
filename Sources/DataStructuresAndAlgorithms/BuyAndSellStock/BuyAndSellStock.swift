//
//  BuyAndSellStock.swift
//  DataStructuresAndAlgorithms
//
//  Created by Kraig Spear on 10/26/25.
//

/// Problem: Best Time to Buy and Sell Stock
///
/// You are given an array `prices` where `prices[i]` is the price of a given stock on the ith day.
///
/// You want to maximize your profit by choosing a single day to buy one stock and choosing a
/// different day in the future to sell that stock.
///
/// Return the maximum profit you can achieve from this transaction. If you cannot achieve any profit, return 0.
///
/// Constraints:
/// - You must buy before you sell (cannot sell before buying)
/// - You can only complete at most one transaction (one buy + one sell)
/// - If no profit is possible, return 0
///
/// Examples:
/// - Input: prices = [7,1,5,3,6,4]
///   Output: 5
///   Explanation: Buy on day 2 (price = 1) and sell on day 5 (price = 6), profit = 6-1 = 5
///
/// - Input: prices = [7,6,4,3,1]
///   Output: 0
///   Explanation: No transactions are done and the max profit = 0 (prices only decrease)
///
/// - Input: prices = [2,4,1]
///   Output: 2
///   Explanation: Buy on day 1 (price = 2) and sell on day 2 (price = 4), profit = 4-2 = 2
public func maxProfit(_ prices: [Int]) -> Int {
    // Step 1: Initialize the lowest price we've seen so far to Int.max
    // Why: We use Int.max so that any actual price we encounter will be lower, ensuring we capture
    // the first price as our initial lowest. This avoids needing special handling for the first element.
    //
    // Example: prices = [7, 1, 5, 3, 6, 4]
    // Starting with Int.max means when we see 7, it becomes our new lowest
    var lowestPrice = Int.max

    // Step 2: Initialize the maximum profit to 0
    // Why: We start at 0 because if no profitable transaction exists (prices only decrease),
    // we should return 0 rather than a negative number. This also handles the case where
    // we cannot complete any transaction (empty array or single price).
    var maxProfit = 0

    // Step 3: Iterate through each price in the array
    // Why: We need to examine each price as both a potential buy point (if it's the lowest so far)
    // and a potential sell point (if selling here would give us the best profit so far).
    // A single pass is sufficient because we track the minimum as we go.
    for price in prices {
        // Step 4: Update the lowest price we've seen so far
        // Why: We must buy before we sell, so we track the minimum price encountered up to this point.
        // This represents the best possible buy price available for any sell that happens at or after
        // the current position. By continuously updating this, we ensure we're always considering
        // the optimal buy point for each potential sell point.
        //
        // Example iteration 1: price=7, lowestPrice becomes 7
        // Example iteration 2: price=1, lowestPrice becomes 1 (better buy opportunity)
        // Example iteration 3: price=5, lowestPrice stays 1 (already have a better buy point)
        if price < lowestPrice {
            lowestPrice = price
        }

        // Step 5: Calculate what our profit would be if we sold at the current price
        // Why: At each price point, we ask "If I sold today, having bought at the best (lowest) price
        // I've seen so far, what would my profit be?" This allows us to identify the optimal buy/sell
        // combination without comparing every possible pair (which would be O(n²)).
        //
        // Example iteration 3: price=5, lowestPrice=1, potentialProfit=5-1=4
        // Example iteration 5: price=6, lowestPrice=1, potentialProfit=6-1=5
        let potentialProfit: Int = price - lowestPrice

        // Step 6: Update the maximum profit if selling at the current price would be better
        // Why: We track the best profit we've found so far. Each time we find a better profit,
        // we update our answer. By the end of the loop, maxProfit will contain the best possible
        // profit from any valid buy/sell combination.
        //
        // Example iteration 3: potentialProfit=4 > maxProfit=0, so maxProfit becomes 4
        // Example iteration 5: potentialProfit=5 > maxProfit=4, so maxProfit becomes 5
        // Example iteration 6: potentialProfit=3 < maxProfit=5, so maxProfit stays 5
        if potentialProfit > maxProfit {
            maxProfit = potentialProfit
        }
    }

    // Step 7: Return the maximum profit we found
    // Why: This represents the best possible profit from buying once and selling once.
    // If no profitable transaction was found, this will be 0 (our initial value).
    //
    // Final result for prices=[7,1,5,3,6,4]: maxProfit=5 (buy at 1, sell at 6)
    return maxProfit
}
