/*
 
 # Test-driven functional Game of Life kata
 
 The universe of the Game of Life is an infinite two-dimensional orthogonal grid of square cells, each of which is in one of two possible states, alive or dead, or "populated" or "unpopulated". Every cell interacts with its eight neighbours, which are the cells that are horizontally, vertically, or diagonally adjacent. At each step in time, the following transitions occur:

 Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.
 Any live cell with two or three live neighbours lives on to the next generation.
 Any live cell with more than three live neighbours dies, as if by overpopulation.
 Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
 The initial pattern constitutes the seed of the system. The first generation is created by applying the above rules simultaneously to every cell in the seed—births and deaths occur simultaneously, and the discrete moment at which this happens is sometimes called a tick (in other words, each generation is a pure function of the preceding one). The rules continue to be applied repeatedly to create further generations.
 
    > https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life
 
 
 # Initial goals/constraints for the code kata:
 
     - Test driven
     - As simple as possible
        - Basic Foundation types (no classes, structs or enums)
     - No mutation
        - only pure functions
        - immutable data
        - no "var" keywords allowed!

*/

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
    // and part of the tutorial idea is to show how to create perfomant no-mutable code too, for example ArraySlices and Lazy collections!
    
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
