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

func makeLiveCell() -> Cell {
    return true
}

func makeDeadCell() -> Cell {
    return false
}

func tick(_ state: GameState) -> GameState {
    return state.enumerated().map{ (column, rows) in
        return rows.enumerated().map { (row, cell) in
            let neighbours = aliveNeighbours(fromColumn: column, row: row, in: state)
            
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

private func aliveNeighbours(fromColumn column: Int, row: Int, in game: GameState) -> [Cell] {
    return (-1...1).reduce([Cell](), { (acc, columnOffset) in
        return (-1...1).reduce([Cell](), { (acc, rowOffset) in
            if columnOffset == 0 && rowOffset == 0 { return acc }
            
            if let c = cell(atColumn: column + columnOffset, row: row + rowOffset, in: game), c == makeLiveCell() {
                return acc + [c]
            }
            return acc
        }) + acc
    })
}

private func cell(atColumn column: Int, row: Int, in game: GameState) -> Cell? {
    guard column >= 0 && row >= 0 else { return nil }
    guard let rows = game.first?.count, rows > 0 else { return nil }
    guard column < game.count && row < rows else { return nil }
    return game[column][row]
}
