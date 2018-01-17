//
//  ViewController.swift
//  Apple Pie
//
//  Created by Student on 1/3/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //array that holds the words that will be guessed
    var listOfWords = ["cheese", "potato", "toaster", "dog", "cat", "horse", "vacuum", "television", "artichoke", "meow", "toad"]
    //constant for how many wrong gueses they get
    let incorrectMovesAllowed = 7
    // creates a var for which player is currently playing
    var playerNum = 1
    //creates two var that hold the points for each player, one and two indicated
    var oneScore = 0
    var twoScore = 0
    //variable for the amount of wins and var for the amount of losses
    //when either var changes, it calls a new round
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    //creates a var that holds a boolean to used to change the player number
    var player = true
    //fuction that enables or disables (when there are no more words) all buttons (in letterButtons) when a new round starts
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    //creats outlets for ImageViews and labels for scores, player information, and the word
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var playerInfoLabel: UILabel!
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    //makes an outlet for all of the letter buttons
    @IBOutlet var letterButtons: [UIButton]!
    //makes an action for all the letter buttons for when thy are pressed
    @IBAction func buttonPressed(_ sender: UIButton) {
        //disabled the button, sets the constant letterString to the name of the button, and then sets the constant letter into a lowercased character, and sets the 'letter' init to letter in the playerGuessed func
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        //an if statement that if the word contains the letter guessed chack which player is playing and add one to the appropriate score
        if currentGame.word.contains(letter){
            if player {
                oneScore += 1
            } else if !player {
                twoScore += 1
            }
        // if not, switch player
        } else {
            player = !player
        }
        //calls updateGameState
        updateGameState()
    }
    
    
    //makes function updateGameState
    func updateGameState() {
        //if there are no more moves left, add 1 to the var totalLosses, switch player, then updateUI
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
            player = !player
            updateUI()
        //if not, check if the guessed word is the same as the hidden word, if yes, add one to the var totalWins, and add one to the current players score (this plus the correct letter guess makes the score go up two), then update the UI
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
            if player {
                oneScore += 1
                player = !player
            } else {
                twoScore += 1
                player = !player
            }
            updateUI()
        //else, just update the UI
        } else {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
        // Do any additional setup after loading the view, typically from a nib.
    }
    //Creats an instant of Game called currentGame
    var currentGame: Game!
    //creats a function called newRound, if there are more words to guess, get the first word out of the list and set currentGame's word to the newWord, and reset incorrectMovesRemaining and guessedLetters
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            //enable the buttons, update the UI
            enableLetterButtons(true)
            updateUI()
        //if there are no more words in the listOfWords, disable all the buttons
        } else {
            enableLetterButtons(false)
        }

    }

   //creates the function updateUI
    func updateUI() {
        //interprets the player bool into the player number
        if player {
            playerNum = 1
        } else {
            playerNum = 2
        }
        //creates a variable called letters (string)
        var letters = [String]()
        //for every character in formattedWord of the currentGame, add each charcter to variable letters
        for letter in currentGame.formattedWord.characters {
            letters.append(String(letter))
        }
        //create constant called word with spacing and set it to letters with a space between each character
        let wordWithSpacing = letters.joined(separator: " ")
        //set the guessing word's label to wordWithSpacing
        correctWordLabel.text = wordWithSpacing
        //set the score label's text to display the number of win and losses
        scoreLabel.text = "  Total Wins: \(totalWins), Total Losses: \(totalLosses)"
        //displays which player is playing
        playerLabel.text = "Player \(playerNum)"
        //displays the players' scores
        playerInfoLabel.text = "Player One Score: \(oneScore) || Player Two Score: \(twoScore)"
        //sets the image view to the tree that has the number of apples the same as the number of guesses remaining
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


