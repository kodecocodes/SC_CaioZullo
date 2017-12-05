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

[TODO: Caio write demo script here]

## Talking Head

[TODO: Caio put a nice conclusion here, including a joke]

