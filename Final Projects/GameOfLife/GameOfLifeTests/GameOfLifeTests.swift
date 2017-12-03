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

import XCTest
@testable import GameOfLife

class GameOfLifeTests: XCTestCase {
    
    // MARK: Factory tests
    
    func test_updateCell() {
        let game = [[makeDeadCell(), makeDeadCell()], [makeDeadCell(), makeDeadCell()]]
        
        XCTAssertTrue(replace(makeLiveCell(), at: makePosition(column: 0, row: 0), in: game) ==  [[makeLiveCell(), makeDeadCell()], [makeDeadCell(), makeDeadCell()]])
        XCTAssertTrue(replace(makeLiveCell(), at: makePosition(column: 1, row: 0), in: game) ==  [[makeDeadCell(), makeDeadCell()], [makeLiveCell(), makeDeadCell()]])
        XCTAssertTrue(replace(makeLiveCell(), at: makePosition(column: 0, row: 1), in: game) ==  [[makeDeadCell(), makeLiveCell()], [makeDeadCell(), makeDeadCell()]])
        XCTAssertTrue(replace(makeLiveCell(), at: makePosition(column: 1, row: 1), in: game) ==  [[makeDeadCell(), makeDeadCell()], [makeDeadCell(), makeLiveCell()]])
    }
    
    // MARK: Game tests
    
    func test_tick_liveCellWithAllNeighboursDead_dies() {
        let state = [[makeDeadCell(), makeDeadCell(), makeDeadCell()],
                     [makeDeadCell(), makeLiveCell(), makeDeadCell()],
                     [makeDeadCell(), makeDeadCell(), makeDeadCell()]]

        let expected = [[makeDeadCell(), makeDeadCell(), makeDeadCell()],
                        [makeDeadCell(), makeDeadCell(), makeDeadCell()],
                        [makeDeadCell(), makeDeadCell(), makeDeadCell()]]
        
        XCTAssertTrue(tick(state) == expected)
    }
    
    func test_tick_liveCellWithOneLiveNeighbour_dies() {
        let state = [[makeDeadCell(), makeDeadCell(), makeDeadCell()],
                     [makeDeadCell(), makeLiveCell(), makeDeadCell()],
                     [makeDeadCell(), makeDeadCell(), makeDeadCell()]]
        
        let expected = [[makeDeadCell(), makeDeadCell(), makeDeadCell()],
                        [makeDeadCell(), makeDeadCell(), makeDeadCell()],
                        [makeDeadCell(), makeDeadCell(), makeDeadCell()]]

        (0...2).forEach { column in
            (0...2).forEach { row in
                let game = replace(makeLiveCell(), at: makePosition(column: column, row: row), in: state)
                XCTAssertTrue(tick(game) == expected)
            }
        }
    }
    
    func test_tick_liveCellWithTwoOrThreeLiveNeighbours_lives() {
        XCTAssertTrue(tick([[makeLiveCell(), makeDeadCell(), makeDeadCell()],
                            [makeDeadCell(), makeLiveCell(), makeDeadCell()],
                            [makeDeadCell(), makeDeadCell(), makeLiveCell()]])
                                ==
                           [[makeDeadCell(), makeDeadCell(), makeDeadCell()],
                            [makeDeadCell(), makeLiveCell(), makeDeadCell()],
                            [makeDeadCell(), makeDeadCell(), makeDeadCell()]])

        XCTAssertTrue(tick([[makeDeadCell(), makeDeadCell(), makeLiveCell()],
                            [makeDeadCell(), makeLiveCell(), makeDeadCell()],
                            [makeLiveCell(), makeDeadCell(), makeDeadCell()]])
                                ==
                           [[makeDeadCell(), makeDeadCell(), makeDeadCell()],
                            [makeDeadCell(), makeLiveCell(), makeDeadCell()],
                            [makeDeadCell(), makeDeadCell(), makeDeadCell()]])
    }
    
    func test_tick_deadCellWithExactlyThreeLiveNeighbours_becomesAlive() {
        XCTAssertTrue(tick([[makeDeadCell(), makeLiveCell(), makeDeadCell()],
                            [makeLiveCell(), makeLiveCell(), makeLiveCell()],
                            [makeDeadCell(), makeLiveCell(), makeDeadCell()]])
                                ==
                           [[makeLiveCell(), makeLiveCell(), makeLiveCell()],
                            [makeLiveCell(), makeDeadCell(), makeLiveCell()],
                            [makeLiveCell(), makeLiveCell(), makeLiveCell()]])
    }
    
    
    // MARK: Interesting Game of Life Patterns
    // https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life#Examples_of_patterns
    
    // MARK: Still lives (never change)

    func test_blockStillLive() {
        let block = [[makeLiveCell(), makeLiveCell()],
                     [makeLiveCell(), makeLiveCell()]]
        
        XCTAssertTrue(tick(block) == block)
        XCTAssertTrue(tick(tick(block)) == block)
    }

    func test_tubStillLive() {
        let tub = [[makeDeadCell(), makeLiveCell(), makeDeadCell()],
                   [makeLiveCell(), makeDeadCell(), makeLiveCell()],
                   [makeDeadCell(), makeLiveCell(), makeDeadCell()]]

        XCTAssertTrue(tick(tub) == tub)
        XCTAssertTrue(tick(tick(tub)) == tub)
    }

    // MARK: Period 2 Oscilators (loop patterns)
    
    func test_blinkerOscilator() {
        let period1 = [[makeDeadCell(), makeLiveCell(), makeDeadCell()],
                       [makeDeadCell(), makeLiveCell(), makeDeadCell()],
                       [makeDeadCell(), makeLiveCell(), makeDeadCell()]]
        
        let period2 = [[makeDeadCell(), makeDeadCell(), makeDeadCell()],
                       [makeLiveCell(), makeLiveCell(), makeLiveCell()],
                       [makeDeadCell(), makeDeadCell(), makeDeadCell()]]
        
        XCTAssertTrue(tick(period1) == period2)
        XCTAssertTrue(tick(tick(period1)) == period1)
    }
    
    func test_toadOscilator() {
        let period1 = [[makeDeadCell(), makeDeadCell(), makeDeadCell(), makeDeadCell()],
                       [makeDeadCell(), makeLiveCell(), makeLiveCell(), makeLiveCell()],
                       [makeLiveCell(), makeLiveCell(), makeLiveCell(), makeDeadCell()],
                       [makeDeadCell(), makeDeadCell(), makeDeadCell(), makeDeadCell()]]
        
        let period2 = [[makeDeadCell(), makeDeadCell(), makeLiveCell(), makeDeadCell()],
                       [makeLiveCell(), makeDeadCell(), makeDeadCell(), makeLiveCell()],
                       [makeLiveCell(), makeDeadCell(), makeDeadCell(), makeLiveCell()],
                       [makeDeadCell(), makeLiveCell(), makeDeadCell(), makeDeadCell()]]

        XCTAssertTrue(tick(period1) == period2)
        XCTAssertTrue(tick(tick(period1)) == period1)
    }
}

private func ==<T: Equatable>(lhs: [[T]], rhs: [[T]]) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (i, left) in lhs.enumerated() {
        if rhs[i] != left { return false }
    }
    return true
}
