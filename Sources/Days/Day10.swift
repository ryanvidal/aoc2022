//
//  Day10.swift
//  AoC2021
//
//  Created by Ryan Vidal on 12/10/21.
//

import Foundation

public let day10 = DailyPuzzleBase(solver: Day10Solver(),
                                       testInput: testInputString,
                                       puzzleInput: puzzleInputString)

public class Day10Solver: DailySolver {
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
