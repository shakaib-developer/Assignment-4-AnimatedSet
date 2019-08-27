//
//  ViewController.swift
//  GraphicalSet-Assignment3
//
//  Created by Shakaib Akhtar on 21/08/2019.
//  Copyright © 2019 iParagons. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var game = SetGame()
    
    var selectedCards = Set<Card>()
    var selectedCardButtons = Set<UIButton>()
    
    var shownCards = 0
    var score = 0 {
        didSet {
            scoreLabel.text = "Score : \(score)"
        }
    }
    
//    @IBOutlet var CardButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    
//    @IBAction func touchCard(_ sender: UIButton) {
//        selectCard(sender)
//
//        let title = sender.attributedTitle(for: .normal)
//        let color = title?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as! UIColor
//        let filling = title?.attribute(.strokeWidth, at: 0, effectiveRange: nil) as! Int
//
//        let touchedCard = Card(count: title!.length, shape: title!.string, color: color, filling: filling)
//
//        if selectedCards.count < 3 {
//            if selectedCards.contains(touchedCard)
//            {
//                selectedCardButtons.remove(sender)
//                selectedCards.remove(touchedCard)
//            }
//            else {
//                selectedCardButtons.insert(sender)
//                selectedCards.insert(touchedCard)
//            }
//        }
//        if selectedCards.count >= 3 {
//            if game.isMatch(selectedCards: selectedCards) {
//                selectedCardButtons.forEach { setButtonProperties($0, game.getCardProperties()) }
//                score += 4
//            }
//            score -= 1
//            selectedCardButtons.forEach { $0.layer.borderWidth = 0.0 }
//            selectedCardButtons.removeAll()
//            selectedCards.removeAll()
//
//           // scoreLabel.text = "Score : \(score)"
//        }
//
//        print("selectedCards.count = \(selectedCards.count)")
//        print("threeSelectedCards = \(selectedCardButtons.count)")
//    }
    
//    @IBAction func DealMoreCards(_ sender: UIButton) {
//        if shownCards < 23 && game.cards.count > 0 {
//            for index in  shownCards..<(shownCards + 3) {
//                setButtonProperties(CardButtons[index], game.getCardProperties())
//                CardButtons[index].alpha = 1.0
//            }
//            shownCards += 3
//        }
//        else {
//            showAlert(withTile: "Hey Listen!", andMessage: "Cannot deal more cards. ☹️")
//        }
//    }
    
//    @IBAction func NewGame(_ sender: UIButton) {
//        reset()
//    }
    
//    func setButtonProperties(_ sender: UIButton, _ OptCard: Card?) {
//        if let card = OptCard {
//            var attributes = [NSAttributedStringKey : Any]()
//            attributes[NSAttributedStringKey.strokeWidth] = card.filling
//            attributes[NSAttributedStringKey.foregroundColor] = card.color
//            
//            let title = NSMutableAttributedString(string: card.shape, attributes: attributes)
//            
//            sender.setAttributedTitle(title, for: .normal)
//            sender.titleColor(for: .normal)
//        }
//        else {
//            sender.alpha = 0.0
//        }
//    }
    
//    func showAlert(withTile title:String,andMessage message:String)
//    {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
//        self.present(alert, animated: true, completion: nil)
//    }
//
//    func setTheme() {
//        view.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        CardButtons.forEach { $0.backgroundColor = UIColor.white }
//        scoreLabel.textColor = UIColor.white
//    }
    
//    override func viewDidLoad() {
//        setTheme()
//        reset()
//    }
    
//    func reset() {
//        shownCards = 0
//        score = 0
//        game = SetGame()
//        for index in  0...23 {
//            CardButtons[index].layer.borderWidth = 0.0
//            if index < 12 {
//                setButtonProperties(CardButtons[index], game.getCardProperties())
//                shownCards += 1
//                CardButtons[index].alpha = 1.0
//            }
//            else {
//                CardButtons[index].alpha = 0
//            }
//        }
//    }
    
//    func selectCard(_ sender: UIButton) {
//        if sender.layer.borderWidth != 3.0 {
//            sender.layer.borderWidth = 3.0
//            sender.layer.borderColor = UIColor.red.cgColor
//        }
//        else {
//            sender.layer.borderWidth = 0.0
//        }
//    }
}

extension Int {
    func arc4random() -> Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0 {
            return Int(arc4random_uniform(UInt32(abs(self))))
        }
        else {
            return 0
        }
    }
}
