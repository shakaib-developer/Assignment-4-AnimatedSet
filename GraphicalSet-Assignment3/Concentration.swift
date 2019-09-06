//
//  Concentration.swift
//  GraphicalSet-Assignment3
//
//  Created by Shakaib Akhtar on 05/09/2019.
//  Copyright © 2019 iParagons. All rights reserved.
//

import Foundation

struct Concentration
{
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFacedUp }.oneAndOnly
            
            //return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
            
            //            var foundIndex: Int?
            //            for index in cards.indices {
            //                if cards[index].isFacedUp {
            //                    if foundIndex == nil {
            //                        foundIndex = index
            //                    }
            //                    else {
            //                        foundIndex = nil
            //                    }
            //                }
            //            }
            //            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFacedUp = (index == newValue )
            }
        }
    }
    
    mutating func chooseCard(at index:Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFacedUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have atleast one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        //TODO: Shuffle the cards
        
        // My Task starts here, Shuffling cards logic
        for _ in 0...cards.count {
            if cards.count >= 4 {
                var swapFromIndex = 0
                var swapToIndex = 0
                
                repeat {
                    swapFromIndex = Int(arc4random_uniform(UInt32(cards.count)))
                    swapToIndex = Int(arc4random_uniform(UInt32(cards.count)))
                } while(swapFromIndex == swapToIndex)
                cards.swapAt(swapFromIndex, swapToIndex)
            }
        }
        // My Task ended here and cards are shuffled
    }
}

extension Collection {
    
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
    
}
