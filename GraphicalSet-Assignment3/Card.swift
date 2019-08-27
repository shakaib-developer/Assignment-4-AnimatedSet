//
//  Card.swift
//  GraphicalSet-Assignment3
//
//  Created by Shakaib Akhtar on 21/08/2019.
//  Copyright © 2019 iParagons. All rights reserved.
//

import Foundation
import UIKit

class Card: Hashable {
    var hashValue: Int = 0
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.count == rhs.count && lhs.shape == rhs.shape && lhs.color == rhs.color && lhs.filling == rhs.filling
    }
    
//    enum Shapes: String {
//        case squiggle = "■"
//        case diamond = "▲"
//        case oval = "●"
//    }
//
//    enum Counts: Int {
//        case one = 1
//        case two = 2
//        case three = 3
//    }
//
//    enum Colors: Int {
//        case red = 1
//        case green = 2
//        case purple = 3
//    }
//
//    enum Fillings: Int {
//        case solid = 0
//        case striped = 05
//        case outlined = 020
//    }
    
    var count: Int
    var shape: String
    var color: UIColor
    var filling: Int
    
    init(count: Int, shape: String, color: UIColor, filling: Int) {
        self.count = count
        self.shape = shape
        self.color = color
        self.filling = filling
        
//        print("count = \(self.count.rawValue)")
//        print("fillings = \(self.filling)")
//        print("color = \(self.color)")
//        print("shape = \(self.shape.rawValue)")
//        print("identifier = \(self.identifier)")
    }
    
}
