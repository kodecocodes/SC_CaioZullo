/// Copyright (c) 2017 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation

typealias Cell = Bool
typealias GameState = [[Cell]]
typealias Position = (column: Int, row: Int)

func makeLiveCell() -> Cell {
    return true
}

func makeDeadCell() -> Cell {
    return false
}

func makeGame(columns: Int, rows: Int, repeating: Cell = makeDeadCell()) -> GameState {
    return Array(repeating: Array(repeating: repeating, count: rows), count: columns)
}

func makePosition(column: Int, row: Int) -> Position {
    return (column, row)
}

func replace(_ newCell: Cell, at position: Position, in state: GameState) -> GameState {
    // Silly / not performant implementation!
    // One of the goals set for this series is to avoid mutation, so the keyword "var" is forbidden
    // this limitation makes us search for different patterns to solve this problem in a functional way
    // and part of the tutorial idea is to show how to create perfomant immutable code too, for example ArraySlices and Lazy collections!
    
    // It can also be a challenge for the audience: improve the performance of this function without using "var"
    
    return state.enumerated().map{ (column, rows) in
        return rows.enumerated().map { (row, cell) in
            if column == position.column && row == position.row {
                return newCell
            }
            return cell
        }
    }
}

func step(_ state: GameState) -> GameState {
    return state.enumerated().map{ (column, rows) in
        return rows.enumerated().map { (row, cell) in
            let neighbours = aliveNeighbours(from: makePosition(column: column, row: row), in: state)
            
            if cell == makeDeadCell() {
                if neighbours.count == 3 {
                    return makeLiveCell()
                }
                return cell
            }
            
            if neighbours.count >= 2 && neighbours.count <= 3 {
                return makeLiveCell()
            }
            return makeDeadCell()
        }
    }
}

private func aliveNeighbours(from position: Position, in game: GameState) -> [Cell] {
    return (-1...1).reduce([Cell](), { (acc, columnOffset) in
        return (-1...1).reduce([Cell](), { (acc, rowOffset) in
            if columnOffset == 0 && rowOffset == 0 { return acc }
            let offset = makePosition(column: position.column + columnOffset, row: position.row + rowOffset)
            if let c = cell(at: offset, in: game), c == makeLiveCell() {
                return acc + [c]
            }
            return acc
        }) + acc
    })
}

private func cell(at position: Position, in game: GameState) -> Cell? {
    guard position.column >= 0 && position.row >= 0 else { return nil }
    guard let rows = game.first?.count, rows > 0 else { return nil }
    guard position.column < game.count && position.row < rows else { return nil }
    return game[position.column][position.row]
}
