//
//  Day2.swift
//  AoC2021
//
//  Created by Ryan Vidal on 12/2/21.
//

import Foundation

public let day2 = DailyPuzzleBase(solver: Day2Solver(),
                                  testInput: testInputString,
                                  puzzleInput: puzzleInputString)

public class Day2Solver: DailySolver {
    public typealias CalculationInput = [Int]

    public func ParseInput(_ input: String) -> CalculationInput {
        let inputLines = input.components(separatedBy: "\n")
        return inputLines.compactMap(Int.init)
    }

    public func PerformPart1Calculation(_ input: CalculationInput) -> Int? {

        // Part 1 calculation here

        return nil
    }

    public func PerformPart2Calculation(_ input: CalculationInput) -> Int? {

        // Part 2 calculation here

        return nil
    }
}

fileprivate let testInputString = """
"""

fileprivate let puzzleInputString = """
"""
