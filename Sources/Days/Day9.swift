//
//  Day9.swift
//  AoC2021
//
//  Created by Ryan Vidal on 12/9/21.
//

import Algorithms
import Foundation

public let day9 = DailyPuzzleBase(solver: Day9Solver(),
                                       testInput: testInputString,
                                       puzzleInput: puzzleInputString)

public class Day9Solver: DailySolver {
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
