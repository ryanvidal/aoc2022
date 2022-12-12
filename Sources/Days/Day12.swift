//
//  Day12.swift
//  AoC2021
//
//  Created by Ryan Vidal on 12/12/21.
//

import Foundation
import SwiftyDijkstra

public let day12 = DailyPuzzleBase(solver: Day12Solver(),
                                       testInput: testInputString,
                                       puzzleInput: puzzleInputString)

public class Day12Solver: DailySolver {
    public typealias CalculationInput = Day12State

    public func ParseInput(_ input: String) -> CalculationInput {
        return Day12State(input)
    }

    public func PerformPart1Calculation(_ input: CalculationInput) -> Int? {
        return input.shortestPathLength
    }

    public func PerformPart2Calculation(_ input: CalculationInput) -> Int? {
        return input.shortestPathAnyLowestStart
    }
}

public class Day12State {
    var width: Int
    var height: Int
    var map: FullGrid<Character>
    var nodes: FullGrid<Node>
    var graph: Graph
    var start: Pair!
    var end: Pair!

    init(_ input: String) {
        let inputLines = input.components(separatedBy: "\n")
        width = inputLines.first!.count
        height = inputLines.count
        map = FullGrid<Character>.init(width: width, height: height)
        nodes = FullGrid<Node>.init(width: width, height: height)

        var edges = [Edge]()

        for (y, line) in inputLines.enumerated() {
            for (x, c) in line.enumerated() {
                map[(x,y)] = c
                if c == "S" {
                    start = Pair(x,y)
                    nodes[(x,y)] = Node("Start")
                } else if c == "E" {
                    end = Pair(x,y)
                    nodes[(x,y)] = Node("End")
                } else {
                    nodes[(x,y)] = Node(Pair(x,y).stringValue)
                }
            }
        }

        for x in 0..<width {
            for y in 0..<height {
                let point = Pair(x,y)
                let positiveNeighbors = point
                    .orthogonalNeighbors(bounds:( (0...width-1), 0...height-1))
                    .filter { $0.x >= point.x && $0.y >= point.y }
                for neighbor in positiveNeighbors {
                    let heightPoint = heightValue(of: map[point]!)
                    let heightNeighbor = heightValue(of: map[neighbor]!)
                    if abs(heightPoint - heightNeighbor) <= 1 {
                        edges.append(Edge(from: nodes[point]!, to: nodes[neighbor]!))
                    } else if heightPoint > heightNeighbor {
                        edges.append(Edge(from: nodes[point]!, to: nodes[neighbor]!, bidirectional: false))
                    } else {
                        edges.append(Edge(from: nodes[neighbor]!, to: nodes[point]!, bidirectional: false))
                    }
                }
            }
        }

        graph = Graph(edges: edges)
    }

    public var shortestPathLength: Int {
        return graph.shortestPath(from: nodes[start]!, to: nodes[end]!).count - 1
    }

    public var shortestPathAnyLowestStart: Int {
        return map
            .getPoints(where: { $0 == "a" })
            .map { graph.shortestPath(from: nodes[$0]!, to: nodes[end]!).count - 1 }
            .filter { $0 > 0 }
            .min()!
    }
}

fileprivate func heightValue(of c: Character) -> Int {
    switch c {
    case "S":
        return heightValue(of: "a")
    case "E":
        return heightValue(of: "z")
    case "a"..."z":
        return Int(c.asciiValue!)
    default:
        fatalError()
    }
}

fileprivate let testInputString = """
Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi
"""

fileprivate let puzzleInputString = """
abcccccccccccccccccccccccccccccccccccccccccccccccccccaaaaacccccccccccccaaaaaaaccccccccccccccccaaaaaaccccccccccccccccccccccccccaaaaacccaaaccccccccccccccccccccccccccccccaaaaa
abcccccccccaaaccccccccccccaaaccccccccccccccccccccccccaaaaaacccccccccccccaaaaaaaaaaaccaaaaccccaaaaaaacccccccccccccccccccccccccccaaaaaacaaaaccccccccccccccccccccccccccccccaaaa
abcccccccccaaaaaacccccccccaaaacccccccccccccccccccccccaaaaaaccccccccccccaaaaaaaaaaaccaaaaacccaaaaaacccccccccaaacccccccccccccccaaaaaaaacaaaaccccccccccccccccacccccccccccccaaaa
abcccccccccaaaaaacccccccccaaaaccccaacccccccccccccccccaaaaaaccccccccccaaaaaaaaaaaaaacaaaaaaccaacaaaccaacccaaaaaaccccccccccccccaaaaaaaacaaaccccccccccaccccaaaccccccccccccaaaaa
abcccccccaaaaaaaccccccccccaaaacccaaaaccccccccccccaaccccaaacccccccaaacaaaaaaaaaccccccaaaaaacccccaaaccaacccaaaaaacccccccccccccccccaaccccccccccccccccaaacccaaaccccccccccccaaaca
abcccccccaaaaaaacccccccaaacccccccaaaacccccccaaccaaaccccccccccccaaaaacaaaaaaaaaccccccaaaaaccccccccaaaaaaaacaaaaaccaacaaccccccccccaaccccccccccccccccaaaaaaaaaccccccccccccccccc
abcccccccccaaaaaaccaaccaaacccccccaaaacccccccaaaaaaaccccccccccccaaaaaaccccaaaaaacccccccaaaccccccccaaaaaaaaaaaaacccaaaaacccccccaaaccccccccccccccccccaaaaaaaackcccccccccccccccc
abcccccccccaaaaaaccaaaaaaaccccccccccccccccccaaaaaacccccccccccccaaaaaaccccaaaaaaccccccccccccccccccccaaaaccaaaaaccccaaaaaccccccaaaaaccccaaaaaccccccccaaaajjkkkkkccccccaacccccc
abcccccccccaaccccccaaaaaaccccccccccccccccccccaaaaaaaaccccccccccaaaaacccaaaacaaccccccccccccccccccccaaaaaccccccccccaaaaaacccccaaaaaaccccaaaaaccciijjjjjjjjjkkkkkkccaaaaaaccccc
abcaaaccccccccccccccaaaaaaaaccccccccccccccccaaaaaaaaacccccccccccaaaacccaaaccaaccccccccccccccccccccaacaaacccccccccaaaacccccccaaaaaacccaaaaaaciiiijjjjjjjjjoopkkkkcaaaaacccccc
abaaaacccccccccccccaaaaaaaaaccccccccccccccccaaaaaaaacccccccccccccccccccaaaaaaaccccaccaccccccccccccacccaacccccccccccaaccccccccaaaaacccaaaaaaiiiiiijjjjjjoooppppkkcaaaaaaacccc
abaaaaaccccccccccccaaaaaaaaccccccccccccccccaaaaaaaccccccccccccccccccccccaaaaaaccccaaaacccccccccccccccccccccccccccccccccccccccaaaaccccaaaaaiiiinnnoooooooooppppkkkaaaaaaacccc
abaaaaacccccccccccaaaaaaaccccccccccccccccccccccaaacccccccccccccccccccaaaaaaaacccccaaaaccccccccccccaaccaacccccaccccacccccccccccccccccccaaaciiinnnnoooooooouupppkkkaaaaaaacccc
abaaaaccccccccccccccccaaaccccccccccccccccccccccaaacccccccaaccccccccccaaaaaaaaacccaaaaaacccccccccccaaaaaaccccaaaaaaaacccccccccccccaaccccccciiinnnntttooouuuuupppiiacaaacccccc
abaaaacccccccccccccccccaaccccccccccccccccccccccccccccccaaaacacccccccccaaaaaaaacccaaaaaacccccccccccaaaaaccccccaaaaaacccccccccccaaaaaacccccciinnnttttuuuuuuuuuuppiiccaaacccccc
abcccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaacccccccccccaaaaaaaccccaacccccaaccccccaaaaaacccccaaaaaacccccccccccaaaaaccccccciinnntttttuuuuxyuuuppiiicccccccccc
abccccccccccccccccccccccccccccccccccccaaacccccccaaccccccaaaaccccccccccccaaccccccccccccccccaacaaacaaaaaaaacccaaaaaaaaccccccccccaaaaaaaccccchinnnttxxxxuuxyyyuuppiiiiccccccccc
abccccccccccccccccccccccccccccccccccccaaaaaaccccaaacccccaaaaccccccccccccaaccccccccccccccccaaaaaccaaaaaaaaccaaaaaaaaaaccccccccaaaaaaaaccccchhhnnttxxxxxxxyyuvppppiiiccccccccc
abccccccccccccccccccccccccccccccccccaaaaaaaaaaccaaaaaaacacaacccccccccccccccccaaaccccccccaaaaaaccccccaacccccaaaaaaaaaaccccccccaaaaaaaaccccchhhnntttxxxxxxyyvvvppqqiiicccccccc
abccccccccccccccccccccccccccccaacaccaaaaaaaaaaaaaaaaaaacccccccccccccccccccccaaaaaaccccccaaaaaaacccccaacccccaccaaaaacacccccccccacaaaccccccchhhnnnttxxxxxyyyvvvvqqqqiiiccccccc
SbccccccccccccccccccccccccccccaaaaccaaaaaaacaaaaaaaaaaccccccccccccccccccccccaaaaaaccccccccaaaaaaccccccccccccccaaaaccccccccccccccaaacccccchhhmmmtttxxxEzzyyyyvvvqqqqiiccccccc
abcccccccccccccccccccccccccccaaaaaccccaaaaaccaaaaaaaaacccccccccccccccaaaaaccaaaaaaccccccccaaccaacccccccccccccccaacccccccaaaaccccccccccccchhhmmmtttxxxyyyyyyyyvvvqqqjjjcccccc
abcccaaacccccccccccccccccccccaaaaaacccaacaaaaaaaaaaaaacccccccccccccccaaaaacccaaaaaccccccccaacccccccccccccccccccccccccccaaaaacccccccccccchhhmmmttsxxyyyyyyyyvvvvvqqqjjjcccccc
abcccaaaaaacccaacaaccccccccccacaaaacccaacccaaaaaaaaaaaacccccccccccccaaaaaacccaacaaccccccccccccccccccccccccccccccccaacccaaaaaaccccccccccchhhmmmssxxwwwwyyywvvvvvqqqjjjjcccccc
abccaaaaaaacccaaaaaccccccccccccaaccccccccccaaaaaaaccaaccccccccccccccaaaaaacccccccccccccccccccccccccccccccccccaaccaaacccaaaaaacccccccaaachhhmmssswwwwwwyyywvvqqqqqqjjjccccccc
abcaaaaaaacccccaaaaacccccccccccccccccccccccccccaaaccccccccccccccccccaaaaaacccccccccccaaccccaaccccccccccccccccaaacaaacccaaaaaacccccccaaacgggmmsssswwwswwyywwrrqqqjjjjcccccccc
abcaaaaaaaccccaaaaaacccccccccccccccccccccccaaccaaaccccccccccccccccccccaaccccccccccccaaccccaaaacccccccccccccccaaaaaaccccccaacccccccaacaaagggmmmssssssswwwwwwrrqjjjjjddccccccc
abcccaaaaaacccaaaacccccccccccccccccccccccccaaacaaccccccccccccccccccccccccccccccccaaaaacaacaaaaccccccccccccccccaaaaaaaaccccccccccccaaaaaagggmmmmssssssswwwwrrrkjjjjddddcccccc
abcccaaaaaacccccaaccccccccccccccccccccccccccaaaaaccccccccccccccccccccccccccccccccaaaaaaaacaaaacaaccccccaaccaaaaaaaaaaacccccccccccccaaaaaggggmmmmllllsrrwwwrrkkkjdddddaaacccc
abcccaaaccccccccccccaacccccccccccccccccccccaaaaaaccccccccccccccccccccccccccccccccccaaaaacccccccaaaaaaccaaaaaaaaaaaaaacccccccccccccccaaaaaggggmmllllllrrrrrrrkkkdddddaaaccccc
abccccaaaaaaccccccccaacaaaccccccccacccaaccaaaaaaaaccccccccccaaaccccccaacccccccccccaaaaaccccccccaaaaacccaaaaaaaaaaaaccccccccccccccccaaacaacggggggflllllrrrrrrkkddddaaaaaccccc
abccccaaaaacccccccccaaaaacccccccccaaaaaaccaaaaaaaaccccccccccaaacacccaaaaccccccccccaacaaacccccaaaaaaccccaaaaaaaccaaacccccccccccccccccaacccccggggffffllllrrrrkkkdddaaaaaaacccc
abccaaaaaaacccccccaaaaaaccccccccccaaaaaccccccaacccccaaccccaacaaaaaccaaaacccccccaaccccaaccccccaaaaaaaccaaaaaaaaccaaaccccccccccccccccccaaaccccccgffffflllkkkkkkeedaaaaaaaacccc
abccaaaaaaacccccccaaaaaaacccccccccaaaaaacccccaacccccaaacccaaaaaaaaccaaaacccaaaaacccccccccccccccaaaaaacaaaaaaaacccccccccccccccccccccccaaaacaacccccffffllkkkkkeeedccaaaaaacccc
abccccaaaaaaccccccccaaaaaacccccccaaaaaaaacccccaaccccaaaaaaaaaaaaccccccccccaaaaaaaacccccccccccccaaccaaccccaaaccccccaacccccccccccccccccaaaaaaaccccccfffffkkkkeeeecccaacccccccc
abccccaaccaaccccccccaaccaacccccccaaaaaaaacccccaaccaaaaaaaaccaaaaacccccccccaaaaaaaaccccccccccaacaaccccccccaaccccaacaaaccccaacccccccccccaaaaaaccccccaafffeeeeeeecccccccccccccc
abccccaaccccccccccccaaccccccccccccccaacccccaaaaaaaaaaaaaaacaaacaaaaaaacaccaaaaaaacccccccaaacaacccccccccccccccccaaaaaccccaaaacccccccaaaaaaaaccccccaaaaffeeeeeeeccccccccccccca
abacccccccccccccaaacccccccccccccccccaacccccaaaaaaaaaaaaaacccaaccaaaaaaaaaaaaaccaaacccccccaaaaaccccccccccccccccccaaaaaaccaaaacccccccaaaaaaaaaccccccaaacceeeeeccccccccccccccaa
abaaccccccccccaaaaaacccccccccccccccccccccccccaaaacccaaaaaaccccccaaaaaaaaaaaaaaaaaaaccccccaaaaaaacccaaaccccccccaaaaaaaaccaaaaccccccccaaaaaaaaccccccccccccaaacccccccccccaaacaa
abaaccccccccccaaaaaacccccccccccccccccccccccccaaaaacaaaaaaaccccccaaaaaaaaaaaaaaaaaaccccccaaaaaaaaccccaaaaccccccaaaaacaaccccccccccccccccaaaaaaacccccccccccacacccccccccccaaaaaa
abacccccccccccaaaaaaccccccccccccccccccccccccaaaaaacaaaccaaccccccaaaaaaccaaaaaaaaccccccccaaaaaaaaccaaaaaacccccccccaaaccccccccccccccccccaacccccccccccccccccccccccccccccccaaaaa
"""
