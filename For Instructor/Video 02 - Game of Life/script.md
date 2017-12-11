# Screencast Metadata

## Screencast Title

Swift Code Katas: Game of Life

## Screencast Description

Welcome back to the Swift Dojo! 

In this episode we're going to improve our Test Driven Development and functional programming skills together, while performing the Game of Life Kata. 

## Language, Editor and Platform versions used in this screencast

* **Language:** Swift 4
* **Platform:** iOS 11
* **Editor**: Xcode 9

# Talking Head

Hello everybody, this is Caio. In this screencast, we're going to perform a Swift Code Kata to implement the Game of Life.

If you don't know what Swift Code Katas are, be sure to check out our Introduction to Swift Code Katas screencast first.

Let's review the rules of Game of Life, and then dive in!

## Demo (game-of-life-slides.key)

[Slide 02]
The Game of life is played in a 2D grid where each cell can be in one of two possible states: either alive, or dead.  

[Slide 04]
You populate the grid with an initial state, and then at each "tick" you apply some rules to see what happens next.

The way it works, is in each "tick" every cell interacts with its eight neighbours, which are the cells that are horizontally, vertically, or diagonally adjacent, and then the next generation of cells is calculated by four rules.

[Slide 05]
Rule #1 is underpopulation. Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.

[Slide 06]
Rule #2 is overpopulation. Any live cell with more than three live neighbours dies, as if by overpopulation.

[Slide 07]
Rule #3 is status quo. Any live cell with two or three live neighbours lives on to the next generation.

[Slide 08]
Rule #4 is reproduction. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

[Slide 08]
In every "tick" in time, these 4 rules should be applied simultaneously to every cell and the process can be repeated indefinitely to create new generations.

## Talking Head

To make things interesting, we're also going to add two constraints:

Constraint #1 is Test Driven Development. The code kata must be test-driven

Constraint #2 is Functional programming. Which means:
	- No mutation
	- Only pure functions
	- The "var" keyword is not allowed!

The goal for this first code kata is to practice Test Driven Development and functional programming skills, so the final code can be as simple as possible, as long as it respect the constraints.

I've given you a starter project that has a stub for the tick function, which currently does nothing. Your challenge is to extend this and add the rest of the rules of the Game of Life, using TDD and Functional Programming. Now, I'd like you to pause the video and try and implement this code kata on your own.

So - pause the video and put your skills to the test - and good luck. 

## Challenge Slide (challenge-slide.key - Slide 01)

## Demo

Let's start by taking a tour of the starter project. We have two swift files: GameOfLife.swift where we have typealiases for the Cell and the GameState, two factory methods for creating the live and dead cells, and an initial stub for the tick function that does nothing.

In the GameOfLifeTests.swift we have our initial "do nothing" tests, which just give us extra guarantees that we are covering the empty array cases and that the tick function doesn't change grids will all cells dead.

For the next test, let's make sure we obey the first rule of Game of Life: Any live cell with fewer than two live neighbours dies, as if caused by underpopulation. Let's add two assertions with 3 by 3 grids this time, one for a live cell with no live neighbours and one for a live cell with one live neighbour. I'll leave it to you to add more assertions to make sure we cover all horizontal, vertical and diagonal neighbours!

```
func test_tick_liveCellWithFewerThanTwoLiveNeighbours_dies() {
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
```

Great, what's the minimum we can do to make this pass? Remember, no mutation and no var keyword allowed, so we can map both arrays and just replace all live cells with dead cells!

```
func tick(_ state: GameState) -> GameState {
    return state.map { rows in
        return rows.map { _ in
            return makeDeadCell()
        }
    }
}
```

Next, the second rule! Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction. So let's create a new test and add the assertions. Run the tests and it should fail.

```
func test_tick_deadCellWithExactlyThreeLiveNeighbours_becomesAlive() {
    XCTAssertTrue(tick([[makeLiveCell(), makeDeadCell(), makeLiveCell()],
                        [makeDeadCell(), makeDeadCell(), makeDeadCell()],
                        [makeLiveCell(), makeDeadCell(), makeDeadCell()]])
                            ==
                       [[makeDeadCell(), makeDeadCell(), makeDeadCell()],
                        [makeDeadCell(), makeLiveCell(), makeDeadCell()],
                        [makeDeadCell(), makeDeadCell(), makeDeadCell()]])
    
    XCTAssertTrue(tick([[makeDeadCell(), makeDeadCell(), makeLiveCell()],
                        [makeDeadCell(), makeDeadCell(), makeDeadCell()],
                        [makeLiveCell(), makeDeadCell(), makeLiveCell()]])
                            ==
                       [[makeDeadCell(), makeDeadCell(), makeDeadCell()],
                        [makeDeadCell(), makeLiveCell(), makeDeadCell()],
                        [makeDeadCell(), makeDeadCell(), makeDeadCell()]])
}
```

Now, back to the implementation! 

We need a way of knowing the live neighbours of a cell, so let's create a new function called `aliveNeighboursCount` where we can give it a column, row and a game state and it will return the live neighbours count by using a reduce on a range from -1 to 1, twice. That will give us offsets to apply to the column and row. If column and row are both 0, it means we are looking at the current cell, so we can ignore it. Next we can create a new function called `cell` in which we can give it a column, row and a game state and it will return a cell if within the bounds of the 2D array.
Back to the `aliveNeighboursCount` function we can now ask for a cell at column plus the column offset and a row plus the row offset, if we have a cell we can compare if it's alive. If it is, we increment one to the accumulated value. Else, we just return the current count. That's a very naive implementation but that will do. Since we have tests and we made the function private, we can get away with this for now – as an exercise you can reimplement this function in a more performant way and if the tests passes, you're covered!

```
private func aliveNeighboursCount(forColumn column: Int, row: Int, in game: GameState) -> Int {
    return (-1...1).reduce(0, { (acc, columnOffset) in
        return (-1...1).reduce(0, { (acc, rowOffset) in
            if columnOffset == 0 && rowOffset == 0 { return acc }
            
            if let c = cell(atColumn: column + columnOffset, row: row + rowOffset, in: game), c == makeLiveCell() {
                return acc + 1
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
```

Back to the `tick` function, let's change our code to enumerate the arrays before mapping so we can have an column and row indexes. Now we just need to check the alive neighbours count. If the count is three, it should return a live cell. Easy!

```
func tick(_ state: GameState) -> GameState {
    return state.enumerated().map { (column, rows) in
        return rows.enumerated().map { (row, cell) in
            let aliveNeighbours = aliveNeighboursCount(forColumn: column, row: row, in: state)

   	        if aliveNeighbours == 3 {
    	        return makeLiveCell()
			}
            
            return makeDeadCell()
        }
    }
}
```

Next rule: Any live cell with two or three live neighbours lives on to the next generation, so let's break it down into 2 tests. 

One with two live neighbours:

```
func test_tick_liveCellWithTwoLiveNeighbours_lives() {
    XCTAssertTrue(tick([[makeLiveCell(), makeDeadCell(), makeDeadCell()],
                        [makeDeadCell(), makeLiveCell(), makeDeadCell()],
                        [makeDeadCell(), makeDeadCell(), makeLiveCell()]])
                            ==
                       [[makeDeadCell(), makeDeadCell(), makeDeadCell()],
                        [makeDeadCell(), makeLiveCell(), makeDeadCell()],
                        [makeDeadCell(), makeDeadCell(), makeDeadCell()]])
}

And one with three:

func test_tick_liveCellWithThreeLiveNeighbours_lives() {
    XCTAssertTrue(tick([[makeLiveCell(), makeDeadCell(), makeLiveCell()],
                        [makeDeadCell(), makeLiveCell(), makeDeadCell()],
                        [makeLiveCell(), makeDeadCell(), makeDeadCell()]])
                            ==
                       [[makeDeadCell(), makeLiveCell(), makeDeadCell()],
                        [makeLiveCell(), makeLiveCell(), makeDeadCell()],
                        [makeDeadCell(), makeDeadCell(), makeDeadCell()]])
}
```

Back to the tick function! Since we already cover the case for three alive neighbours, we can just check if it's a live cell and if the count is equal to two. If the count is equal to two it still lives, so we just return the cell! Else, it dies. Run the tests and it passes!

```
func tick(_ state: GameState) -> GameState {
    return state.enumerated().map { (column, rows) in
        return rows.enumerated().map { (row, cell) in
            let aliveNeighbours = aliveNeighboursCount(forColumn: column, row: row, in: state)
            
            if aliveNeighbours == 3 {
                return makeLiveCell()
            }
            
            if cell == makeLiveCell() && aliveNeighbours == 2 {
                return cell
            }
            
            return makeDeadCell()
        }
    }
}
```

Last rule: Any live cell with more than three live neighbours dies, as if by overpopulation. Let's write the test and assertion:

```
func test_tick_liveCellWithMoreThanThreeLiveNeighbours_dies() {
    XCTAssertTrue(tick([[makeLiveCell(), makeDeadCell(), makeLiveCell()],
                        [makeDeadCell(), makeLiveCell(), makeDeadCell()],
                        [makeLiveCell(), makeDeadCell(), makeLiveCell()]])
                            ==
                       [[makeDeadCell(), makeLiveCell(), makeDeadCell()],
                        [makeLiveCell(), makeDeadCell(), makeLiveCell()],
                        [makeDeadCell(), makeLiveCell(), makeDeadCell()]])
}
```

Run the tests and... They pass! Looks like we're done with all the rules.

## Talking Head

Alright, that's all for this screencast.

I hope you had as much fun as I did implementing this kata.

Thanks for watching - and I look forward to seeing you back here in the Swift Dojo!