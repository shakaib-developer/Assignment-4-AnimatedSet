//
//  PlayingCard.swift
//  GraphicalSet-Assignment3
//
//  Created by Shakaib Akhtar on 24/08/2019.
//  Copyright © 2019 iParagons. All rights reserved.
//

import UIKit

class PlayingCardContainerView: UIView {
    
    override func draw(_ rect: CGRect) {
        let cardView:CardButtonView = CardButtonView(frame:CGRect(x: 0, y: 0, width: 40, height: 40))
        self.addSubview(cardView)
    }
    

}
