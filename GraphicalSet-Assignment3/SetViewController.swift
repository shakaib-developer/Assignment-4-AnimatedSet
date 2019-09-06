//
//  ViewController.swift
//  GraphicalSet-Assignment3
//
//  Created by Shakaib Akhtar on 21/08/2019.
//  Copyright © 2019 iParagons. All rights reserved.
//

import UIKit

class SetViewController: UIViewController {
    var game = SetGame()
    
    var selectedCards = Set<SetCard>()
    var selectedCardButtons = Set<CardButtonView>()
    var deal3CardsSet = Set<CardButtonView>()
    
    var dealMoreCardsClicked = false
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
    
    @IBOutlet weak var dealMoreCardsButton: UIButton!
    @IBAction func SwipeDownGesture(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .down {
            dealMoreCards()
        }
    }
    
    override func viewDidLayoutSubviews() {
        grid = Grid(layout: Grid.Layout.aspectRatio(3/2), frame: cardContainerView.bounds)
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
        
        let touchedCard = SetCard(count: sender.count!, shape: sender.shape!, color: sender.color!, filling: sender.filling!)

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
            dealMoreCardsClicked = true
            if game.isMatch(selectedCards: selectedCards)
            {
                
                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 2, delay: 0.5, options: [], animations: { [unowned self] in
                    self.selectedCardButtons.forEach {
                            $0.superview?.bringSubview(toFront: $0)
                            $0.transform = CGAffineTransform.identity.rotated(by: CGFloat.pi)
                            $0.transform = CGAffineTransform.identity.scaledBy(x: 2, y: 2)
                         }
                }, completion: { _ in
                    UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 2, delay: 0.5, options: [], animations: { [unowned self] in
                        self.selectedCardButtons.forEach {
                            $0.transform = CGAffineTransform.identity.scaledBy(x: 0.5, y: 0.5)
                            $0.frame = self.scoreLabel.frame
                            $0.alpha = 0.1
                        }
                    }, completion: { _ in
                            self.cardButtons = self.cardButtons.subtracting(self.selectedCardButtons)
                            self.shownCards -= 3
                            self.score += 3
                            if self.game.cards.count > 0 {
                                self.dealMoreCards()
                            }
                            self.selectedCardButtons.removeAll()
                        
                            self.selectedCardButtons.forEach {
                                $0.layer.borderColor = UIColor.black.cgColor
                                $0.layer.borderWidth = 1.0
                            }
                        
                            self.selectedCards.removeAll()
                        
                        })
                })
            }
            
            else {
                score -= 1
                selectedCardButtons.forEach {
                    $0.layer.borderColor = UIColor.black.cgColor
                    $0.layer.borderWidth = 1.0
                }
                selectedCardButtons.removeAll()
                selectedCards.removeAll()
            }
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
            let tempCard = SetCard(count: $0.count!, shape: $0.shape!, color: $0.color!, filling: $0.filling!)
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
        dealMoreCardsClicked = true
        if shownCards >= 3 && game.cards.count > 0 {
            grid.cellCount = shownCards+3
            
            for _ in shownCards..<shownCards+3 {
                let cardView = fetchNewCard()
                
                self.cardContainerView.addSubview(cardView)
                
                deal3CardsSet.insert(cardView)
            }
            cardButtons = cardButtons.union(deal3CardsSet)
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
        
        var delayTime : Double = 0
        
        for (i, button) in cardButtons.enumerated() {
            cardContainerView.addSubview(button)
           
             if dealMoreCardsClicked && !deal3CardsSet.contains(button) {

                UIViewPropertyAnimator(duration: 1, curve: .easeInOut) { [unowned self] in
                    button.frame = self.grid[i]!
                }.startAnimation()

            }
            else {
                delayTime = delayTime + 0.3
                button.frame = dealMoreCardsButton.frame
                button.alpha = 0.1
                button.backgroundColor = UIColor.darkGray
                
                UIViewPropertyAnimator.runningPropertyAnimator(
                                       withDuration: 0.5,
                                       delay: TimeInterval(delayTime),
                                       options: [.curveEaseInOut],
                                       animations: {
                    button.frame = self.grid[i]!
                }, completion: { _ in
                    UIView.transition(with: button, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                        button.alpha = 1.0
                        button.backgroundColor = UIColor.clear
                    }, completion: nil)
                })
            }
        }
        
        deal3CardsSet.removeAll()
    }
    
    override func viewDidLoad() {
        reset()
        layoutAgain()
    }
    
    func reset() {
        dealMoreCardsClicked = false
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
