//
//  SetGame.swift
//  Set
//
//  Created by Brice Brown on 12/30/22.
//
// Model for creating the set game

import Foundation

struct SetGame {
    private(set) var deck: [Card]
    private(set) var cards: [Card]
    private(set) var discardPile: [Card]
    private var numOfCurrentlySelected: Int
    private(set) var playerScore: Int
    
    
    init() {
        numOfCurrentlySelected = 0
        playerScore = 0
        deck = []
        discardPile = []
        // each deck has 81 cards
        var index: Int = 0
        for shape in SetShapes.allCases {
            for numOfShapes in 1...3 {
                for color in SetColors.allCases{
                    for colorFeature in Opacity.allCases{
                        deck.append(Card(shape: shape, numOfShapes: numOfShapes, color: color, colorFeature: colorFeature, id: index))
                        index += 1
                    }
                }
            }
        }
        deck.shuffle()
        cards = deck.extractElementsFromBack(12)
        for card in cards {
            if let choosenIndex = cards.firstIndex(where: {$0.id == card.id}){
                cards[choosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func choose(_ card: Card){
        if (numOfCurrentlySelected == 3){
            numOfCurrentlySelected = 0
            removeMatchingCards()
        }
        
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id})
        {
            if (!cards[chosenIndex].isSelected){
                numOfCurrentlySelected += 1
                cards[chosenIndex].isSelected = true
            } else{
                numOfCurrentlySelected -= 1
                cards[chosenIndex].isSelected = false
            }
            
            if (numOfCurrentlySelected == 3){
                let matchedCards = cards.filter{$0.isSelected}
                let cardMatch = determineMatch(matchedCards[0], matchedCards[1], matchedCards[2])
                for card in matchedCards{
                    if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}){
                        cards[chosenIndex].isMatched = cardMatch ? .correct : .incorrect
                        playerScore += cardMatch ? 1 : -1
                        cards[chosenIndex].isSelected = false
                    }
                }
            }
        }
    }
    
    mutating func draw(_ numberOfNewCards: Int){
        cards.append(contentsOf: deck.extractElementsFromBack(numberOfNewCards))
        for card in cards {
            if let choosenIndex = cards.firstIndex(where: {$0.id == card.id}){
                cards[choosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func removeMatchingCards(){
        let matchedCards = cards.filter{$0.isMatched == .correct}
        for card in matchedCards{
            if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}){
                cards.remove(at: chosenIndex)
                discardPile.append(card)
            }
        }
    }
    
    func determineMatch(_ a: Card, _ b: Card, _ c: Card) -> Bool{
        let numberMatch = allSameOrAllDifferent(a.numOfShapes, b.numOfShapes, c.numOfShapes)
        let shapeMatch = allSameOrAllDifferent(a.shape, b.shape, c.shape)
        let colorFeatureMatch = allSameOrAllDifferent(a.colorFeature, b.colorFeature, c.colorFeature)
        let colorMatch = allSameOrAllDifferent(a.color, b.color, c.color)
        
        return numberMatch && shapeMatch && colorFeatureMatch && colorMatch
    }
    
    // either all the values are the same, or they are all different
    func allSameOrAllDifferent<T: Equatable>(_ a: T, _ b: T, _ c: T) -> Bool {
        ((a == b) && (b == c)) || ((a != b) && (b != c) && (a != c))
    }
    
    
}

extension Array {
    mutating func extractElementsFromBack(_ numberOfElementsToRemove: Int) -> [Element]{
        var subArray: [Element] = []
        print(self.count)
        for _ in 1...numberOfElementsToRemove where self.count > 0{
            subArray.append(self.popLast()!)
        }
        return subArray
    }
}
