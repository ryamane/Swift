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
        //emojiChoices = Array(themes[Int(arc4random_uniform(UInt32(themes.count)))]!)
        themeIndex = Int(arc4random_uniform(UInt32(emojiThemes.count)))
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
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : emojiThemes[themeIndex].cardBackColor
            }
        }
        view.backgroundColor = emojiThemes[themeIndex].bgColor
        flipCountLabel.text = "Flips: \(game.flipCount)"
        gameScore.text = "Score: \(game.score)"
    }
    
    // Game Themes
    
    struct Theme {
        var name: String
        var emojis: Array<String>
        var bgColor: UIColor
        var cardBackColor: UIColor
    }
    
    var emojiThemes: [Theme] = [
        Theme(name: "standard", emojis: ["😦","😏","🤔","😊","😉","😶","😱","😢"], bgColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), cardBackColor: #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)),
        Theme(name: "sports", emojis: ["⚽️","🏀","🏈","⚾️","🎾","🏐","🏉","🎱"], bgColor: #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1), cardBackColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)),
        Theme(name: "fruit", emojis: ["🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍓"], bgColor: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), cardBackColor: #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)),
        Theme(name: "food", emojis: ["🍞","🧀","🥚","🥞","🥓","🥩","🍖","🍔"], bgColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), cardBackColor: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)),
        Theme(name: "vehicles", emojis: ["🚗","🚕","🚙","🚌","🚎","🚓","🚑","🚒"], bgColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), cardBackColor: #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)),
        Theme(name: "hearts", emojis: ["❤️","🧡","💛","💚","💙","💜","🖤","💕"], bgColor: #colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1), cardBackColor: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))
    ]
    
    var backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    var cardColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
    var emoji = [0 : "😦",
                 1 : "😏",
                 2 : "🤔",
                 3 : "😊",
                 4 : "😉",
                 5 : "😶",
                 6 : "😱",
                 7 : "😢"]
    lazy var emojiChoices = Array(emoji.values)
    
    var themeIndex = 0 {
        didSet {
            backgroundColor = emojiThemes[themeIndex].bgColor
            cardColor = emojiThemes[themeIndex].cardBackColor
            emojiChoices = emojiThemes[themeIndex].emojis
        }
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0  {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?" // Return if not nil
        
    }
}

