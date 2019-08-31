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
    var selectedCardButtons = Set<CardButtonView>()
    
    var shownCards = 0
    var cardButtons = Set<CardButtonView>() {
        didSet {
            layoutAgain()
        }
    }
    
    var grid = Grid(layout: Grid.Layout.aspectRatio(3/2))
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score : \(score)"
        }
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var cardContainerView: PlayingCardContainerView!
    
    @IBAction func NewGame(_ sender: UIButton) {
        reset()
    }
    
    @IBAction func SwipeDownGesture(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .down {
            dealMoreCards()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            print("landscape")
            grid = Grid(layout: Grid.Layout.aspectRatio(3/2), frame: cardContainerView.bounds)
            print(grid.frame)
         } else {
            print("potrait")
            grid = Grid(layout: Grid.Layout.aspectRatio(3/2), frame: cardContainerView.bounds)
            print(grid.frame)
        }
        
        layoutAgain()
    }
    
    @objc func CardTapGesture(_ sender: CardButtonView) {
        if sender.layer.borderWidth != 3.0 {
            sender.layer.borderWidth = 3.0
            sender.layer.borderColor = UIColor.red.cgColor
        }
        else {
            sender.layer.borderColor = UIColor.black.cgColor
            sender.layer.borderWidth = 1.0
        }
        
        let touchedCard = Card(count: sender.count!, shape: sender.shape!, color: sender.color!, filling: sender.filling!)

        if selectedCards.count < 3 {
            if selectedCards.contains(touchedCard)
            {
                selectedCardButtons.remove(sender)
                selectedCards.remove(touchedCard)
            }
            else
            {
                selectedCardButtons.insert(sender)
                selectedCards.insert(touchedCard)
            }
        }
        if selectedCards.count >= 3 {
            if game.isMatch(selectedCards: selectedCards)
            {
                cardButtons.subtract(selectedCardButtons)
                shownCards -= 3
                score += 4
            }
            score -= 1
            selectedCardButtons.forEach { $0.layer.borderColor = UIColor.black.cgColor; $0.layer.borderWidth = 1.0 }
            selectedCardButtons.removeAll()
            selectedCards.removeAll()
        }
        
    }
    
    @IBAction func RotationGesture(_ sender: UIRotationGestureRecognizer) {
        if sender.state == .began {
            reShuffleCards()
        }
    }
    
    @IBAction func DealMoreCardsButtonClicked(_ sender: UIButton) {
        dealMoreCards()
    }
    
    func reShuffleCards() {
        cardButtons = cardButtons.union(selectedCardButtons)
        cardButtons.forEach {
            let tempCard = Card(count: $0.count!, shape: $0.shape!, color: $0.color!, filling: $0.filling!)
            game.cards.append(tempCard)
            $0.removeFromSuperview()
            cardButtons.remove($0)
        }
        
        for _ in 0..<shownCards {
            let cardView = fetchNewCard()
            cardContainerView.addSubview(cardView)
            cardButtons.insert(cardView)
        }
    }
    
    func dealMoreCards() {
        if shownCards >= 3 && game.cards.count > 0 {
            grid.cellCount = shownCards+3
            
            for _ in shownCards..<shownCards+3 {
                let cardView = fetchNewCard()
                cardContainerView.addSubview(cardView)
                
                cardButtons.insert(cardView)
            }
            
            shownCards += 3
        }
        else {
            showAlert(withTile: "Hey Listen!", andMessage: "Cannot deal more cards. ☹️")
        }
    }
    
    func fetchNewCard() -> CardButtonView {
        let card = game.getCardProperties()!
        let cardView: CardButtonView = CardButtonView()
        cardView.filling = card.filling
        cardView.count = card.count
        cardView.shape = card.shape
        cardView.color = card.color
        cardView.layer.cornerRadius = 10
        cardView.layer.borderColor = UIColor.black.cgColor
        cardView.layer.borderWidth = 1.0
        
        cardView.addTarget(self, action: #selector(CardTapGesture(_:)), for: .touchUpInside)
        
        return cardView
    }
    
    func layoutAgain() {
        grid.cellCount = cardButtons.count
        
        for subview in cardContainerView.subviews {
            subview.removeFromSuperview()
        }
        
        for (i, button) in cardButtons.enumerated() {
            cardContainerView.addSubview(button)
            button.frame = grid[i]!
        }
    }
    
    override func viewDidLoad() {
        reset()
        layoutAgain()
    }
    
    func reset() {
        shownCards = 12
        score = 0
        game = SetGame()
        cardButtons.removeAll()
        
        grid.frame = cardContainerView.bounds
        grid.cellCount = shownCards
        
        for _ in 0..<shownCards {
            let cardView = fetchNewCard()
            cardContainerView.addSubview(cardView)
            cardButtons.insert(cardView)
        }
    }
    
    func showAlert(withTile title:String,andMessage message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
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
