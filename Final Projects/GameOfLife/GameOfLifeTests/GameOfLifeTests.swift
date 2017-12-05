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
    
    func test_tick_emptyGrid_doesNothing() {
        XCTAssertTrue(tick([]) == [])
        XCTAssertTrue(tick([[]]) == [[]])
    }
    
    func test_tick_liveCellWithAllNeighboursDead_dies() {
        XCTAssertTrue(tick([[makeDeadCell(), makeDeadCell(), makeDeadCell()],
                            [makeDeadCell(), makeLiveCell(), makeDeadCell()],
                            [makeDeadCell(), makeDeadCell(), makeDeadCell()]])
                                ==
                           [[makeDeadCell(), makeDeadCell(), makeDeadCell()],
                            [makeDeadCell(), makeDeadCell(), makeDeadCell()],
                            [makeDeadCell(), makeDeadCell(), makeDeadCell()]])
    }
    
    func test_tick_liveCellWithOneLiveNeighbour_dies() {
        XCTAssertTrue(tick([[makeLiveCell(), makeDeadCell(), makeDeadCell()],
                            [makeDeadCell(), makeLiveCell(), makeDeadCell()],
                            [makeDeadCell(), makeDeadCell(), makeDeadCell()]])
                                ==
                           [[makeDeadCell(), makeDeadCell(), makeDeadCell()],
                            [makeDeadCell(), makeDeadCell(), makeDeadCell()],
                            [makeDeadCell(), makeDeadCell(), makeDeadCell()]])

        XCTAssertTrue(tick([[makeDeadCell(), makeDeadCell(), makeDeadCell()],
                            [makeDeadCell(), makeLiveCell(), makeDeadCell()],
                            [makeDeadCell(), makeDeadCell(), makeLiveCell()]])
                                ==
                           [[makeDeadCell(), makeDeadCell(), makeDeadCell()],
                            [makeDeadCell(), makeDeadCell(), makeDeadCell()],
                            [makeDeadCell(), makeDeadCell(), makeDeadCell()]])
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
    
    func test_tick_liveCellWithMoreThanThreeLiveNeighbours_dies() {
        XCTAssertTrue(tick([[makeLiveCell(), makeDeadCell(), makeLiveCell()],
                            [makeDeadCell(), makeLiveCell(), makeDeadCell()],
                            [makeLiveCell(), makeDeadCell(), makeLiveCell()]])
                                ==
                           [[makeDeadCell(), makeLiveCell(), makeDeadCell()],
                            [makeLiveCell(), makeDeadCell(), makeLiveCell()],
                            [makeDeadCell(), makeLiveCell(), makeDeadCell()]])
        
    }

    func test_tick_deadCellWithExactlyThreeLiveNeighbours_becomesAlive() {
        XCTAssertTrue(tick([[makeLiveCell(), makeDeadCell(), makeLiveCell()],
                            [makeDeadCell(), makeDeadCell(), makeDeadCell()],
                            [makeLiveCell(), makeDeadCell(), makeDeadCell()]])
                                ==
                          [[makeDeadCell(), makeDeadCell(), makeDeadCell()],
                           [makeDeadCell(), makeLiveCell(), makeDeadCell()],
                           [makeDeadCell(), makeDeadCell(), makeDeadCell()]])

        XCTAssertTrue(tick([[makeDeadCell(), makeLiveCell(), makeDeadCell()],
                            [makeLiveCell(), makeLiveCell(), makeLiveCell()],
                            [makeDeadCell(), makeLiveCell(), makeDeadCell()]])
                                ==
                           [[makeLiveCell(), makeLiveCell(), makeLiveCell()],
                            [makeLiveCell(), makeDeadCell(), makeLiveCell()],
                            [makeLiveCell(), makeLiveCell(), makeLiveCell()]])
    }
}

private func ==<T: Equatable>(lhs: [[T]], rhs: [[T]]) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (i, left) in lhs.enumerated() {
        if rhs[i] != left { return false }
    }
    return true
}