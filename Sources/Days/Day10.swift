//
//  Day10.swift
//  AoC2021
//
//  Created by Ryan Vidal on 12/10/21.
//

import Algorithms
import Foundation

public let day10 = DailyPuzzleBase(solver: Day10Solver(),
                                       testInput: testInputString,
                                       puzzleInput: puzzleInputString)

public class Day10Solver: DailySolver {
    public typealias CalculationInput = [VideoSystem.Instruction]

    public func ParseInput(_ input: String) -> CalculationInput {
        let inputLines = input.components(separatedBy: "\n")
        return inputLines.compactMap(VideoSystem.Instruction.init)
    }

    public func PerformPart1Calculation(_ input: CalculationInput) -> Int? {
        let system = VideoSystem(input)
        let firstStrength = system.performCycles(count: 20)

        return (60...220)
            .striding(by: 40)
            .map { _ in system.performCycles(count: 40) }
            .reduce(firstStrength, +)
    }

    public func PerformPart2Calculation(_ input: CalculationInput) -> Int? {
        let system = VideoSystem(input)
        system.drawProgram()
        return nil
    }
}

public class VideoSystem {
    public enum Instruction {
        case adx(Int)
        case noop

        init(_ string: String) {
            let components = string.components(separatedBy: " ")
            switch components[0] {
            case "noop":
                self = .noop
            case "addx":
                self = .adx(Int(components[1])!)
            case nil:
                self = .noop
            default:
                fatalError()
            }
        }
    }

    enum CPUState {
        case idle
        case doAdx(Int)
    }

    var state: CPUState
    var x: Int
    var instructionStack: Stack<Instruction>
    var cycle: Int
    var pixels: FullGrid<Bool>
    var pixelBeingDrawn: Pair

    init(_ program: [Instruction]) {
        state = .idle
        x = 1
        instructionStack = Stack<Instruction>.init(program)
        cycle = 0
        pixels = .init(width: 40, height: 6)
        pixelBeingDrawn = Pair(0,0)
    }

    @discardableResult
    func performCycles(count: Int) -> Int {
        var strengthDuring = 0
        for _ in 1...count {
            // Draw screen
            let spriteLocations = [x-1, x, x+1].map { Pair($0, pixelBeingDrawn.y) }
            pixels[pixelBeingDrawn] = spriteLocations.contains(pixelBeingDrawn)
            advanceDrawnPixel()

            // Perform Instructions
            cycle += 1
            strengthDuring = x * cycle
            switch state {
            case .idle:
                // If there are no more instructions, just return
                if instructionStack.isEmpty { return strengthDuring }

                execute(instructionStack.pop())
            case .doAdx(let int):
                x += int
                state = .idle
            }
        }

        return strengthDuring
    }

    func execute(_ instruction: Instruction?) {
        switch instruction {
        case .adx(let int):
            state = .doAdx(int)
        case .noop, nil:
            state = .idle
        }
    }

    func advanceDrawnPixel() {
        let newX = (pixelBeingDrawn.x + 1) % 40
        let newY = (newX == 0 ? (pixelBeingDrawn.y + 1) : pixelBeingDrawn.y) % 6

        pixelBeingDrawn = Pair(newX, newY)
    }

    func printScreen() {
        print("Screen:")
        let (width, height) = pixels.size
        for y in 1...height {
            var line = ""
            for x in 1...width {
                if pixels[Pair(x-1,y-1)] == true {
                    line.append("#")
                } else {
                    line.append(".")
                }
            }
            print(line)
        }
        print("")
    }

    func drawProgram() {
        performCycles(count: Int(INT_MAX)) // Do as many cycles as necessary to run the full program
        printScreen()
    }

}

fileprivate let testInputString = """
addx 15
addx -11
addx 6
addx -3
addx 5
addx -1
addx -8
addx 13
addx 4
noop
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx -35
addx 1
addx 24
addx -19
addx 1
addx 16
addx -11
noop
noop
addx 21
addx -15
noop
noop
addx -3
addx 9
addx 1
addx -3
addx 8
addx 1
addx 5
noop
noop
noop
noop
noop
addx -36
noop
addx 1
addx 7
noop
noop
noop
addx 2
addx 6
noop
noop
noop
noop
noop
addx 1
noop
noop
addx 7
addx 1
noop
addx -13
addx 13
addx 7
noop
addx 1
addx -33
noop
noop
noop
addx 2
noop
noop
noop
addx 8
noop
addx -1
addx 2
addx 1
noop
addx 17
addx -9
addx 1
addx 1
addx -3
addx 11
noop
noop
addx 1
noop
addx 1
noop
noop
addx -13
addx -19
addx 1
addx 3
addx 26
addx -30
addx 12
addx -1
addx 3
addx 1
noop
noop
noop
addx -9
addx 18
addx 1
addx 2
noop
noop
addx 9
noop
noop
noop
addx -1
addx 2
addx -37
addx 1
addx 3
noop
addx 15
addx -21
addx 22
addx -6
addx 1
noop
addx 2
addx 1
noop
addx -10
noop
noop
addx 20
addx 1
addx 2
addx 2
addx -6
addx -11
noop
noop
noop
"""

fileprivate let puzzleInputString = """
noop
addx 25
addx -5
addx -14
addx 4
noop
addx 2
addx 3
noop
noop
noop
noop
addx 3
addx 5
addx 2
noop
noop
addx 5
noop
noop
noop
addx 1
addx 2
addx 5
addx -40
addx 5
noop
addx 26
addx -20
addx -3
addx 2
noop
addx -4
addx 9
addx 5
addx 2
addx 11
addx -10
addx 2
addx 5
addx 2
addx 5
noop
noop
noop
addx -31
addx 32
addx -37
addx 1
addx 8
addx 13
addx -15
addx 4
noop
addx 5
noop
addx 3
addx -2
addx 4
addx 1
addx 4
addx -14
addx 15
addx 4
noop
noop
noop
addx 3
addx 5
addx -40
noop
addx 5
addx 8
addx -3
noop
addx 2
addx 9
addx -4
noop
noop
noop
noop
addx 5
addx -9
addx 10
addx 4
noop
noop
addx 5
addx -19
addx 24
addx -2
addx 5
addx -40
addx 22
addx -19
addx 2
addx 5
addx 2
addx 5
noop
noop
addx -2
addx 2
addx 5
addx 3
noop
addx 2
addx 2
addx 3
addx -2
addx 10
addx -3
addx 3
noop
addx -40
addx 2
addx 11
addx -5
addx -1
noop
addx 3
addx 7
noop
addx -2
addx 5
addx 2
addx 3
noop
addx 2
addx 6
addx -5
addx 2
addx -18
addx 26
addx -1
noop
noop
noop
noop
"""
