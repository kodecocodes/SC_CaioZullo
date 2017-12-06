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
In this screencast, we're going to start practicing right away with our first Swift Code Kata based on the Game of Life!

[Slide 02]
The Game of life is played in a 2D grid where each cell can be in one of two possible states: either alive, or dead.  

[Slide 04]
You populate the grid with an initial state, and then each "tick" you apply some rules to see what happens next.

The way it works, is in each "tick" every cell interacts with its eight neighbours, which are the cells that are horizontally, vertically, or diagonally adjacent, and then the next generation of cells is calculated by four rules.

[Slide 05]
Rule #1 is underpopulation. Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.

[Slide 06]
Rule #2 is status quo. Any live cell with two or three live neighbours lives on to the next generation.

[Slide 07]
Rule #3 is overpopulation. Any live cell with more than three live neighbours dies, as if by overpopulation.

[Slide 08]
Rule #4 is reproduction. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

[Slide 08]
In every "tick" in time, these 4 rules should be applied simultaneously to every cell and the process can be repeated indefinitely to create new generations.

## Talking Head

So basically, that's a Swift Code Kata. It's a challenge to implement the Game of Life, starting with this simple function. But there's more. 

Often, you can help improve your skills in your Swift Code Katas by setting up constraints to your practice. For example, have you ever tried to write code without `if` statements? Well, you definitely can! Have you ever tried to write code without using the `var` keyword? That can be great to improve your functional programming skills! Have you ever seen a karate master fighting with one hand tied? Cool, right?!

Well, I don't recommend trying the last one, but by setting up constraints, you limit yourself from relying on your default techniques, which is a great practice to learn new ways to solve problems.

So, for this example, we'll use some constraints to maximise our mastery experience on the following techniques:

1. TDD: The code kata must be test-driven
2. Functional programming, which means:
	- No mutation
	- Only pure functions
	- The "var" keyword is not allowed!

The goal is to practice Test Driven Development and functional programming skills, so the final code can be as simple as possible, as long as it respect the constraints.

## Demo (game-of-life-slides.key)

Since this is our first Swift code kata, we're going to start simple and break this problem into chunks.

For the first chunk, we'll simply write a function to take the game state for the Game of Life, and return it unaltered. Our main focus will be getting used to implemenet this in a TDD-manner.

Next time, we'll return and implement the full rules for the Game of Life. 

OK - so now you understand the challenge - to implement a function to take the game state and return it unaltered - and you understand the constraints - use TDD, and use functional programming. Now, I'd like you to pause the video and try and implement this code kata on your own.

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

## Talking Head

Alright, that's all for this screencast.

Although what we implemented here was quite simple, this has been some great practice - both on test-driven development, and using code katas in general. Remember, the entire reason for doing these code katas is practice makes perfect.

This is just the beginning - if you're eager to implement the rest of the Game of Life, come on back for the next screencast!

Thanks for watching - and I look forward to seeing back here in the Swift Dojo.