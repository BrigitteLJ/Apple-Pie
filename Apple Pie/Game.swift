//
//  Game.swift
//  Apple Pie
//
//  Created by Student on 1/8/18.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

//creats a structure called Game with the variables: word, incorrectMovesRemaining, guessedLetters, and formattedWords
struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetters: [Character]
    //this computed variable represents the letters that the user has guessed  correctly
    var formattedWord: String  {
        //creates variable guessedWord to show the  users guessed word
        var guessedWord = ""
        //for every character in the guessing word, check to see if the user has guessed it, if they have add it to guessed word, else add a _
        for letter in word.characters {
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)"
            } else {
                guessedWord += "_"
            }
        }
        //return the guessedWord (letters and _ in the right spaces)
        return guessedWord
    }
    
    //creates a mutatig function for when the user guesses a letter incorrectly
    mutating func playerGuessed(letter: Character) {
        //adds the button pressed to the list that contains the guessedLetters and if the word doesn't contain the letter, remove one of the moves that the user has left
        guessedLetters.append(letter)
            if !word.characters.contains(letter) {
            incorrectMovesRemaining -= 1
        }
    }
}
