//
//  BuyAndSellStockTests.swift
//  DataStructuresAndAlgorithms
//
//  Created by Kraig Spear on 10/26/25.
//

@testable import DataStructuresAndAlgorithms
import Testing

struct BuyAndSellStockTests {
    @Test("Example 1: Buy at 1, sell at 6, profit = 5")
    func exampleOne() async throws {
        // Given: Prices with opportunity to buy low and sell high
        let prices = [7, 1, 5, 3, 6, 4]

        // When: Calculate maximum profit
        let profit = maxProfit(prices)

        // Then: Should buy on day 2 (price=1) and sell on day 5 (price=6) for profit of 5
        #expect(profit == 5)
    }

    @Test("Example 2: Prices only decrease, no profit possible")
    func exampleTwo() async throws {
        // Given: Prices that continuously decrease
        let prices = [7, 6, 4, 3, 1]

        // When: Calculate maximum profit
        let profit = maxProfit(prices)

        // Then: No profitable transaction exists, return 0
        #expect(profit == 0)
    }

    @Test("Example 3: Buy at 2, sell at 4, profit = 2")
    func exampleThree() async throws {
        // Given: Prices with small profit window
        let prices = [2, 4, 1]

        // When: Calculate maximum profit
        let profit = maxProfit(prices)

        // Then: Should buy on day 1 (price=2) and sell on day 2 (price=4) for profit of 2
        #expect(profit == 2)
    }

    @Test("Single price: No transaction possible")
    func singlePrice() async throws {
        // Given: Only one day of prices
        let prices = [5]

        // When: Calculate maximum profit
        let profit = maxProfit(prices)

        // Then: Cannot complete a transaction with only one price, return 0
        #expect(profit == 0)
    }

    @Test("Two prices: Buy low, sell high")
    func twoPricesBuyLowSellHigh() async throws {
        // Given: Two prices where second is higher
        let prices = [1, 5]

        // When: Calculate maximum profit
        let profit = maxProfit(prices)

        // Then: Buy at 1, sell at 5, profit = 4
        #expect(profit == 4)
    }

    @Test("Two prices: Sell lower than buy")
    func twoPricesSellLowerThanBuy() async throws {
        // Given: Two prices where second is lower
        let prices = [5, 1]

        // When: Calculate maximum profit
        let profit = maxProfit(prices)

        // Then: Cannot make profit, return 0
        #expect(profit == 0)
    }

    @Test("All same prices: No profit")
    func allSamePrices() async throws {
        // Given: All prices are identical
        let prices = [3, 3, 3, 3, 3]

        // When: Calculate maximum profit
        let profit = maxProfit(prices)

        // Then: No price difference means no profit
        #expect(profit == 0)
    }

    @Test("Maximum at the end")
    func maximumPriceAtEnd() async throws {
        // Given: Prices that increase and peak at the end
        let prices = [1, 2, 3, 4, 5]

        // When: Calculate maximum profit
        let profit = maxProfit(prices)

        // Then: Buy at 1 (first day), sell at 5 (last day), profit = 4
        #expect(profit == 4)
    }

    @Test("Minimum at the end")
    func minimumPriceAtEnd() async throws {
        // Given: Prices decrease continuously
        let prices = [5, 4, 3, 2, 1]

        // When: Calculate maximum profit
        let profit = maxProfit(prices)

        // Then: No profitable opportunity when prices only fall
        #expect(profit == 0)
    }

    @Test("Multiple peaks and valleys")
    func multiplePeaksAndValleys() async throws {
        // Given: Prices with multiple ups and downs
        let prices = [3, 2, 6, 5, 0, 3]

        // When: Calculate maximum profit
        let profit = maxProfit(prices)

        // Then: Buy at 2 (day 2), sell at 6 (day 3), profit = 4
        #expect(profit == 4)
    }
}
