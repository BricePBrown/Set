//
//  SetGame.swift
//  Set
//
//  Created by Brice Brown on 12/30/22.
//
// Model for creating the set game

import Foundation

struct SetGame {
    private var deck: [Card]
    private(set) var cards: [Card]
    private var numOfCurrentlySelected: Int
    
    
    init() {
        numOfCurrentlySelected = 0
        deck = []
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
    }
    
    mutating func choose(_ card: Card){
        if (numOfCurrentlySelected < 3){
            if let chosenIndex = cards.firstIndex(where: {$0.id == card.id})
            {
                numOfCurrentlySelected += 1
                cards[chosenIndex].isSelected = true
            }
            if (numOfCurrentlySelected == 3){
                let matchedCards = cards.filter{$0.isSelected}
                let cardMatch = determineMatch(matchedCards[0], matchedCards[1], matchedCards[2])
                for card in matchedCards{
                    if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}){
                        cards[chosenIndex].isMatched = cardMatch ? .correct : .incorrect
                        cards[chosenIndex].isSelected = false
                        numOfCurrentlySelected = 0
                    }
                }
            }
        }
    }
    
    mutating func draw(_ numberOfNewCards: Int){
        cards.append(contentsOf: deck.extractElementsFromBack(numberOfNewCards))
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
        print(self)
        for _ in 1...numberOfElementsToRemove where numberOfElementsToRemove < self.count{
            subArray.append(self.popLast()!)
        }
        return subArray
    }
}
