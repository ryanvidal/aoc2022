//
//  Day11.swift
//  AoC2021
//
//  Created by Ryan Vidal on 12/11/21.
//

import Algorithms
import Foundation
import AppKit

public let day11 = DailyPuzzleBase(solver: Day11Solver(),
                                       testInput: testInputString,
                                       puzzleInput: puzzleInputString)

public class Day11Solver: DailySolver {
    public typealias CalculationInput = [Int: Monkey]

    public func ParseInput(_ input: String) -> CalculationInput {
        if input == testInputString {
            return testMonkeys
        } else {
            return puzzleMonkeys
        }
    }

    public func PerformPart1Calculation(_ input: CalculationInput) -> Int? {
        for round in 1...20 {
//            print("Round \(round)")
            for n in 0..<input.count {
                input[n]?.performRound(with: input)
            }
//            for n in 0..<input.count {
//                print("Monkey \(n): \(input[n]!.items)")
//            }
        }

        for n in 0..<input.count {
            print("Monkey \(n): \(input[n]!.inspections)")
        }



        return input.map { $0.value.inspections }.sorted().dropFirst(input.count - 2).reduce(1, *)
    }

    public func PerformPart2Calculation(_ input: CalculationInput) -> Int? {

//        let divisor = input.map { $0.value.}

        return nil
    }
}

public class Monkey {

    let number: Int
    var items: [Int]
    let operation: (Int) -> Int
    let test: (Int) -> Bool
    let partnerTrue: Int
    let partnerFalse: Int
    var inspections: Int = 0

    init(number: Int, items: [Int], operation: @escaping (Int) -> Int, test: @escaping (Int) -> Bool, partnerTrue: Int, partnerFalse: Int) {
        self.number = number
        self.items = items
        self.operation = operation
        self.test = test
        self.partnerTrue = partnerTrue
        self.partnerFalse = partnerFalse
    }

//    init(_ description: String) {
//        let capturePattern =
//        #"Monkey (?<number>\d{1}):\n"# +
//        #"  Starting items: (?<itemList>.?)\n"# +
//        #"  Operation: new = (?<
//    }

    func performRound(with monkeys: [Int: Monkey]) {
        let itemsToInspect = items
        items = []
        for item in itemsToInspect {
            inspections += 1
            let newWorry = operation(item) / 3
            let partner = test(newWorry) ? partnerTrue : partnerFalse
            monkeys[partner]?.giveItem(withWorry: newWorry)
//            print("Monkey \(number) gave Monkey \(partner) \(newWorry)")
        }
    }

    func performExtremeRound(with monkeys: [Int: Monkey], worryDivisor: Int) {
        let itemsToInspect = items
        items = []
        for item in itemsToInspect {
            inspections += 1
            let newWorry = operation(item) / 3
            let partner = test(newWorry) ? partnerTrue : partnerFalse
            monkeys[partner]?.giveItem(withWorry: newWorry)
            //            print("Monkey \(number) gave Monkey \(partner) \(newWorry)")
        }
    }

    func giveItem(withWorry level: Int) {
        items.append(level)
    }
}

fileprivate let testInputString = """
Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1
"""

fileprivate let testMonkeys: [Int:Monkey] = [
    0: Monkey(
        number: 0,
        items: [79, 98],
        operation: { old in old * 19 },
        test: { $0 % 23 == 0 },
        partnerTrue: 2,
        partnerFalse: 3
    ),
    1: Monkey(
        number: 1,
        items: [54, 65, 75, 74],
        operation: { old in old + 6 },
        test: { $0 % 19 == 0 },
        partnerTrue: 2,
        partnerFalse: 0
    ),
    2: Monkey(
        number: 2,
        items: [79, 60, 97],
        operation: { old in old * old },
        test: { $0 % 13 == 0 },
        partnerTrue: 1,
        partnerFalse: 3
    ),
    3: Monkey(
        number: 3,
        items: [74],
        operation: { old in old + 3 },
        test: { $0 % 17 == 0 },
        partnerTrue: 0,
        partnerFalse: 1
    ),
]

fileprivate let puzzleInputString = """
Monkey 0:
  Starting items: 85, 79, 63, 72
  Operation: new = old * 17
  Test: divisible by 2
    If true: throw to monkey 2
    If false: throw to monkey 6

Monkey 1:
  Starting items: 53, 94, 65, 81, 93, 73, 57, 92
  Operation: new = old * old
  Test: divisible by 7
    If true: throw to monkey 0
    If false: throw to monkey 2

Monkey 2:
  Starting items: 62, 63
  Operation: new = old + 7
  Test: divisible by 13
    If true: throw to monkey 7
    If false: throw to monkey 6

Monkey 3:
  Starting items: 57, 92, 56
  Operation: new = old + 4
  Test: divisible by 5
    If true: throw to monkey 4
    If false: throw to monkey 5

Monkey 4:
  Starting items: 67
  Operation: new = old + 5
  Test: divisible by 3
    If true: throw to monkey 1
    If false: throw to monkey 5

Monkey 5:
  Starting items: 85, 56, 66, 72, 57, 99
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 1
    If false: throw to monkey 0

Monkey 6:
  Starting items: 86, 65, 98, 97, 69
  Operation: new = old * 13
  Test: divisible by 11
    If true: throw to monkey 3
    If false: throw to monkey 7

Monkey 7:
  Starting items: 87, 68, 92, 66, 91, 50, 68
  Operation: new = old + 2
  Test: divisible by 17
    If true: throw to monkey 4
    If false: throw to monkey 3
"""

fileprivate let puzzleMonkeys: [Int:Monkey] = [
    0: Monkey(
        number: 0,
        items: [85, 79, 63, 72],
        operation: { old in old * 17 },
        test: { $0 % 2 == 0 },
        partnerTrue: 2,
        partnerFalse: 6
    ),
    1: Monkey(
        number: 1,
        items: [53, 94, 65, 81, 93, 73, 57, 92],
        operation: { old in old * old },
        test: { $0 % 7 == 0 },
        partnerTrue: 0,
        partnerFalse: 2
    ),
    2: Monkey(
        number: 2,
        items: [62, 63],
        operation: { old in old + 7 },
        test: { $0 % 13 == 0 },
        partnerTrue: 7,
        partnerFalse: 6
    ),
    3: Monkey(
        number: 3,
        items: [57, 92, 56],
        operation: { old in old + 4 },
        test: { $0 % 5 == 0 },
        partnerTrue: 4,
        partnerFalse: 5
    ),
    4: Monkey(
        number: 4,
        items: [67],
        operation: { old in old + 5 },
        test: { $0 % 3 == 0 },
        partnerTrue: 1,
        partnerFalse: 5
    ),
    5: Monkey(
        number: 5,
        items: [85, 56, 66, 72, 57, 99],
        operation: { old in old + 6 },
        test: { $0 % 19 == 0 },
        partnerTrue: 1,
        partnerFalse: 0
    ),
    6: Monkey(
        number: 6,
        items: [86, 65, 98, 97, 69],
        operation: { old in old * 13 },
        test: { $0 % 11 == 0 },
        partnerTrue: 3,
        partnerFalse: 7
    ),
    7: Monkey(
        number: 7,
        items: [87, 68, 92, 66, 91, 50, 68],
        operation: { old in old + 2 },
        test: { $0 % 17 == 0 },
        partnerTrue: 4,
        partnerFalse: 3
    ),
]
