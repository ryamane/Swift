//
//  ViewController.swift
//  Concentration
//
//  Created by Ryan Yamane on 3/13/18.
//  Copyright © 2018 Ryan Yamane. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var gameScore: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }

    }
   
    @IBAction func newGame(_ sender: UIButton) {
        
        //emojiChoices = Array(emoji.values)
        emojiChoices = Array(themes[Int(arc4random_uniform(UInt32(themes.count)))]!)
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        updateViewFromModel()
        game.resetGame()
    }
    
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
            }
        }
        flipCountLabel.text = "Flips: \(game.flipCount)"
    }
    
    // Card Themes
    var standardTheme = ["😦","😏","🤔","😊","😉","😶","😱","😢"]
    var sportsTheme = ["⚽️","🏀","🏈","⚾️","🎾","🏐","🏉","🎱"]
    var fruitTheme = ["🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍓"]
    var foodTheme = ["🍞","🧀","🥚","🥞","🥓","🥩","🍖","🍔"]
    var vehicleTheme = ["🚗","🚕","🚙","🚌","🚎","🚓","🚑","🚒"]
    var heartTheme = ["❤️","🧡","💛","💚","💙","💜","🖤","💕"]
    
    // Standard theme is used as a default
    var emoji =      [0 : "😦",
                      1 : "😏",
                      2 : "🤔",
                      3 : "😊",
                      4 : "😉",
                      5 : "😶",
                      6 : "😱",
                      7 : "😢"]
    
    lazy var themes = [0 : standardTheme,
                       1 : sportsTheme,
                       2 : fruitTheme,
                       3 : foodTheme,
                       4 : vehicleTheme,
                       5 : heartTheme]
    
    lazy var emojiChoices = Array(emoji.values)
    
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0  {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?" // Return if not nil
        
    }
}

