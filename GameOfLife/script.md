## Intro 

Hello everybody, this is Caio. In this video we're going to practice our first Swift Code Kata: Game of Life!

Game of life is played in a 2D grid where each cell can be in one of two possible states, alive or dead. 

You can populate the initial pattern by selecting which cells will be alive or dead. At each "step" in time, every cell interacts with its eight neighbours, which are the cells that are horizontally, vertically, or diagonally adjacent, and the next generation of cells is calculated by those rules:

- Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.

- Any live cell with two or three live neighbours lives on to the next generation.

- Any live cell with more than three live neighbours dies, as if by overpopulation.

- Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

In every "step" in time, the above rules should be applied simultaneously to every cell and the process can be repeated indefinitely to create new generations.

## Constraints 

For this code kata, we'll use some constraints to maximise our mastery experience on the following techniques:

1. TDD: The code kata must be test-driven
2. Functional programming, which means:
	- No mutation
	- Only pure functions
	- Immutable data
	- The "var" keyword is not allowed!

The goal is to practice TDD and functional programming skills, so the final code can be as simple as possible, as long as it respect the constraints.

We'll show you the solution next, but I'd like you to try and implement this code kata on your own. You can pause this video now and put your skills to the test! Ah, and don't forget to share your project with us! We'd love to see other creative solutions.

## Solution


