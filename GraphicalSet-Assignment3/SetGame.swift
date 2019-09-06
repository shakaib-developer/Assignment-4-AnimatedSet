//
//  Set.swift
//  GraphicalSet-Assignment3
//
//  Created by Shakaib Akhtar on 21/08/2019.
//  Copyright © 2019 iParagons. All rights reserved.
//

import Foundation
import UIKit

class SetGame {
    
    var cards = [SetCard]()
    
    var shapesArray = ["squiggles", "diamonds", "ovals"]
    var colorsDict = ["red": #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1),"green": #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1), "purple": #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)]
    var fillingArray = ["filled","outline","striped"]
    var countArray = [1, 2, 3]
    
    
    init() {
        for shapeValue in shapesArray {

            for (_, colorValue) in colorsDict {

                for fillingValue in fillingArray {
                    
                     for count in countArray.indices {
                        
                        let tempCard = SetCard(count: countArray[count], shape: shapeValue, color: colorValue, filling: fillingValue)
                        
                        cards.append(tempCard)
                        
                    }
                }
            }
        }
    }
    
    func isMatch(selectedCards: Set<SetCard>) -> Bool {
        var x = Array(selectedCards)
        
        let numbersFeatures = Set([x[0].count, x[1].count, x[2].count])
        let colorsFeatures = Set([x[0].color, x[1].color, x[2].color])
        let symbolsFeatures = Set([x[0].shape, x[1].shape, x[2].shape])
        let shadingsFeatures = Set([x[0].filling, x[1].filling, x[2].filling])

        return (numbersFeatures.count == 1 || numbersFeatures.count == 3) &&
            (colorsFeatures.count == 1 || colorsFeatures.count == 3) &&
            (symbolsFeatures.count == 1 || symbolsFeatures.count == 3) &&
            (shadingsFeatures.count == 1 || shadingsFeatures.count == 3)
    }

    func getCardProperties() -> SetCard? {
        if cards.count > 0 {
            let cardIndex = cards.count.arc4random
            return cards.remove(at: cardIndex)
        }
        else {
            return nil
        }
    }
    
}
