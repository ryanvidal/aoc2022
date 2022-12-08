//
//  Grid.swift
//  AoC2022
//
//  Created by Ryan Vidal on 12/5/22.
//

import Foundation

public struct Grid<Element> {
    var grid: [Pair: Element]

    mutating func setValue(x: Int, y: Int, to value: Element) {
        setValue(at: Pair(x, y), to: value)
    }

    mutating func setValue(at location: Pair, to value: Element) {
        grid[location] = value
    }

    func getPoints(where predicate: (Element) -> Bool) -> [Pair] {
        return grid
            .filter { predicate($0.value) }
            .map { $0.key }
    }

    var points: [Pair] {
        return grid.map { $0.key }
    }

    var elements: [Element] {
        return grid.map { $0.value }
    }

    var size: (Int, Int) {
        var (xMax, yMax) = (0, 0)
        for point in points {
            if point.x > xMax { xMax = point.x }
            if point.y > yMax { yMax = point.y }
        }
        return (xMax, yMax)
    }
}
