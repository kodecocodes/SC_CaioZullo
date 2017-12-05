# Screencast Metadata

## Screencast Title

Swift Code Katas: Introduction

## Screencast Description

In many other industries, folks practice every day to master their crafts - take a look at great musicians or athletes for example. However, for some reason many of us as Swift developers feel that our practice is done on the job. But that often leads to a lot of mistakes, and a lot of bugs.

The idea behind Swift code katas is to split the practice from the profession, so we can dedicate time to become better and better at what we do.

## Language, Editor and Platform versions used in this screencast

* **Language:** Swift 4
* **Platform:** iOS 11
* **Editor**: Xcode 9

# Talking Head

Hello everybody, this is Caio. In this screencast, we're going to introduce you to a really cool practice that will help you improve your skills as a Swift developer: Swift Code Katas!

Kata is a Japanese word for the practice of choreographed patterns of movements, like those you use in martial arts. 

Have you ever watched a movie with a Karate master practicing alone, hitting perfectly timed and smooth punches and kicks to the air? That's a Kata!

One of the key aspects of katas is that you learn by practice and repetition, repeating these steps many times until they become second nature.

And just like there are katas for martial arts, we can make katas for Swift coding too! Swift Code katas are exercises that help Swift developers master their skills through practice and repetition. 

This is important, because in many other industries, folks practice every day to master their crafts - take a look at great musicians or athletes, for example. However, for some reason many of us as Swift developers feel that our practice is done on the job. But that often leads to a lot of mistakes, and a lot of bugs.

So the idea behind Swift code katas is to split the practice from the profession, so we can dedicate time to become better and better at what we do.

## Demo (game-of-life-slides.key)

[Slide 01]
In this screencast, we're going to start practicing right away with our first Swift Code Kata: The Game of Life!

[Slide 02]
The Game of life is played in a 2D grid where each cell can be in one of two possible states: either alive, or dead. 

[Slide 03]
You can populate the initial pattern by selecting which cells will be alive or dead. 

[Slide 04]
At each "tick" in time, every cell interacts with its eight neighbours, which are the cells that are horizontally, vertically, or diagonally adjacent, and then the next generation of cells is calculated by these four rules:

[Slide 05]
- Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.

[Slide 06]
- Any live cell with two or three live neighbours lives on to the next generation.

[Slide 07]
- Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

[Slide 08]
- Any live cell with more than three live neighbours dies, as if by overpopulation.

In every "tick" in time, the above rules should be applied simultaneously to every cell and the process can be repeated indefinitely to create new generations.

## Talking Head

So basically, that's a Swift Code Kata. It's a challenge to implement that algorithm. But there's more. 

Often, you can help improve your skills in your Swift Code Katas by setting up constraints to your practice. For example, have you ever tried to write code without `if` statements? Well, you definitely can! Have you ever tried to write code without using the `var` keyword? That can be great to improve your functional programming skills! Have you ever seen a karate master fighting with one hand tied? Cool, right?!

Well, I don't recommend trying the last one, but by setting up constraints, you limit yourself from relying on your default techniques, which is a great practice to learn new ways to solve problems.

So, for this example, we'll use some constraints to maximise our mastery experience on the following techniques:

1. TDD: The code kata must be test-driven
2. Functional programming, which means:
	- No mutation
	- Only pure functions
	- The "var" keyword is not allowed!

The goal is to practice Test Driven Development and functional programming skills, so the final code can be as simple as possible, as long as it respect the constraints.

OK - so now you understand the challenge - to implement the Game of Life - and you understand the constraints - use TDD, and use functional programming. Now, I'd like you to pause the video and try and implement this code kata on your own.

Remember, the only way you'll get anything out of a code kata like this is to put the work in, so I highly encourage you to pause the video and give it a shot. When you're done, you can unpause the video to see what I came up with, and you can share your work with everyone else on the forums.

So - pause the video and put your skills to the test - and good luck. 

## Challenge Slide (challenge-slide.key - Slide 01)

## Demo

Ok, let's do this!

In Xcode, you can create a new project. Select the macOS tab in the template finder and select Cocoa Framework and press Next. Type GameOfLife as the product name, Swift as the language and make sure to tick the "Include Unit Tests" checkbox!

Xcode should have created a test file for you in the test target: "GameOfLifeTests.swift", so let's select and use it.

Remove all the code inside the class, leaving the file as follows:

```
import XCTest
@testable import GameOfLife

class GameOfLifeTests: XCTestCase {

}
```

Perfect, we're ready for our first test!

Let's start with the most basic thing we can do and represent our 2D grid as an array of arrays. For our first test we can make sure that calling a `tick` function with empty arrays will return the same 2D array. In short, making sure it does nothing with the given empty arrays:

```
func test_tick_emptyGrid_doesNothing() {
	XCTAssertEqual(tick([]), [])
	XCTAssertEqual(tick([[]]), [[]])
}
```

If we try running the tests now (cmd + U) we'll get build errors. Good - that's expected from a TDD session, and to solve it let's create a file named GameOfLife.swift in the main target folder: GameOfLife.

Now let's define a `tick` function that receives an array of arrays and return another array of arrays. Let's keep it simple and use booleans to define if the cell is alive or dead.

```
import Foundation

func tick(_ state: [[Bool]]) -> [[Bool]] {

}
```

We can use typealiases to make this a bit nicer:

```
import Foundation

typealias Cell = Bool
typealias GameState = [[Cell]]

func tick(_ state: GameState) -> GameState {

}
```

Great! Now a TDD rule says we need to see a failing test first, to guarantee that we're testing something so let's return something that will make it fail:

```
func tick(_ state: GameState) -> GameState {
	return [[false]]
}
```

Let's try to run the test again (cmd+U). Oh-oh. Arrays of arrays are not Equatable so they don't have a == function. Let's implement our own in the test file (GameOfLifeTests.swift).

Let's leave it outside of the class scope, and we can use generics to make sure this can be used for any 2D array. First we check the count than we iterate through the collection and compare each index.

```
private func ==<T: Equatable>(lhs: [[T]], rhs: [[T]]) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (i, left) in lhs.enumerated() {
        if rhs[i] != left { return false }
    }
    return true
}
```

Great! Now let's use the equality function in our test:

```
func test_tick_emptyGrid_doesNothing() {
	XCTAssertTrue(tick([]) == [])
	XCTAssertTrue(tick([[]]) == [[]])
}
```

Let's run the test again and this time it should build without errors. But we'll see a failing test! Awesome, that's it. Let's make it pass now by simply... Doing nothing! Change the tick function to return the unmodified state. Run the tests again (cmd + U) aaaaand... it passes! Fantastic!

```
func tick(_ state: GameState) -> GameState {
    return state
}
```

We can add another "does nothing test" - if all cells are dead, nothing should change. Let's use a 2 by 2 grid to test this:

```
func test_tick_allCellsDead_doesNothing() {
	let state = [[false, false],
                       [false, false]]

	XCTAssertTrue(tick(state) == state)
}
```

Run the tests. And it passes! That's just an extra guarantee test, so let's leave it in and refactor the code a bit. Let's create a factory methods to avoid using explicit booleans in the code. 

```
func test_tick_allCellsDead_doesNothing() {
	let state = [[makeDeadCell(), makeDeadCell()],
                       [makeDeadCell(), makeDeadCell()]]

	XCTAssertTrue(tick(state) == state)
}
```

In the GameOfLife.swift file we can now implement the factory methods, run the tests and they should pass!

```
func makeLiveCell() -> Cell {
    return true
}

func makeDeadCell() -> Cell {
    return false
}
```

For the next test, let's make sure we obey the first rule of Game of Life: Any live cell with fewer than two live neighbours dies, as if caused by underpopulation. Let's add two assertions with 3 by 3 grids this time, one for a live cell with no live neighbours and one for a live cell with one live neighbour. I'll leave it to you to add more assertions to make sure we cover all horizontal, vertical and diagonal adjacent cells!

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

Next, the second rule! Any live cell with two or three live neighbours lives on to the next generation, so let's add 2 assertion examples, with diagonal live neighbours. Don't forget to add more as an exercise!

```
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
```

Now, back to the implementation! In the `tick` function we need to somehow get the neighbours for all the cells during the mapping phase, so let's change our code to enumerate the arrays before mapping so we can have an column and row indexes.

```
func tick(_ state: GameState) -> GameState {
    return state.enumerated().map { (column, rows) in
        return rows.enumerated().map { (row, cell) in
            return makeDeadCell()
        }
    }
}
```

Great, now we need a way of knowing the live neighbours of a cell, so let's create a new function called `aliveNeighboursCount` where we can give it a column, row and a game state and it will return the live neighbours count by using a reduce on a range from -1 to 1, twice. Which can give us offsets to apply to the column and row. If column and row are both 0, it means we are looking at the current cell, so we can ignore it. Next we can create a new function called `cell` in which we can give it a column, row and a game state and it will return a cell if within the bounds of the 2D array.
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

Back to the tick function! We can now check if it's a dead cell, we just return it. Otherwise we request the live neighbours and is equal to two or three, it still lives, so we just return the cell! Else, it dies. Run the tests and it passes!

```
func tick(_ state: GameState) -> GameState {
    return state.enumerated().map { (column, rows) in
        return rows.enumerated().map { (row, cell) in
            if cell == makeDeadCell() {
                return cell
            }
            
            let aliveNeighbours = aliveNeighboursCount(forColumn: column, row: row, in: state)

            if aliveNeighbours == 2 || aliveNeighbours == 3 {
                return cell
            }
            return makeDeadCell()
        }
    }
}
```

Next rule: Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction. So let's create a new test case with assertions. Run the tests and it should fail.

```
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
```

Back to the `tick` function, we just need to move the alive neighbours before the first check for dead cells and add a new condition, if the alive neighbours is three, it should return a live cell. Easy!

```
func tick(_ state: GameState) -> GameState {
    return state.enumerated().map { (column, rows) in
        return rows.enumerated().map { (row, cell) in
            let aliveNeighbours = aliveNeighboursCount(forColumn: column, row: row, in: state)

            if cell == makeDeadCell() {
                if aliveNeighbours == 3 {
                    return makeLiveCell()
                }
                return cell
            }
            

            if aliveNeighbours == 2 || aliveNeighbours == 3 {
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

[TODO: Caio put a nice conclusion here, including a joke]

