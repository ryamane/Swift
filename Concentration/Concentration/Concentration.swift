//
//  Concentration.swift
//  Concentration
//
//  Created by Ryan Yamane on 3/13/18.
//  Copyright © 2018 Ryan Yamane. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = Array<Card>()
    
    var shuffledCards = Array<Card>()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    var flipCount = 0
    
    var score = 0
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func resetGame() {
        flipCount = 0
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        for _ in 0..<cards.count {
            let rand = Int(arc4random_uniform(UInt32(cards.count)))
            shuffledCards.append(cards[rand])
            cards.remove(at: rand)
        }
        cards = shuffledCards
    }
}
