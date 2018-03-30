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
    var seenCards = Array<Int>()
    var startTime = Date()
    var previousMatchTime = Date()
    var hasMatchedAPair = false
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            flipCount += 1

            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2 // 2 points for a match
                    if hasMatchedAPair == false {
                        let firstMatchTime = Date()
                        let firstMatchTimeInterval = firstMatchTime.timeIntervalSince(startTime)
                        if firstMatchTimeInterval < 3 {
                            score += 2
                        } else if firstMatchTimeInterval >= 3, firstMatchTimeInterval < 6 {
                            score += 1
                        }
                    } else {
                        let nextMatchTime = Date()
                        let nextMatchTimeInterval = nextMatchTime.timeIntervalSince(previousMatchTime)
                        if nextMatchTimeInterval < 3 {
                            score += 2
                        } else if nextMatchTimeInterval >= 3, nextMatchTimeInterval < 6 {
                            score += 1
                        }
                    }
                    hasMatchedAPair = true
                    previousMatchTime = Date()
                    
                    
                } else { // if no match, subtract 1 point for each card already seen
                    if seenCards.contains(index) {
                        score -= 1
                    }
                    if seenCards.contains(matchIndex) {
                        score -= 1
                    }
                }
                if !seenCards.contains(matchIndex) {
                    seenCards.append(matchIndex)
                }
                if !seenCards.contains(index) {
                    seenCards.append(index)
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
        score = 0
        seenCards = []
        startTime = Date.init()
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
