//
//  SetGame.swift
//  Set
//
//  Created by Brice Brown on 12/30/22.
//
// Model for creating the set game

import Foundation

struct SetGame {
    private(set) var cards: [Card]
    
    init() {
        cards = []
        // each deck has 81 cards
        var index: Int = 0
        for shape in SetShapes.allCases {
            for numOfShapes in 1...3 {
                for color in SetColors.allCases{
                    for colorFeature in Opacity.allCases{
                        cards.append(Card(shape: shape, numOfShapes: numOfShapes, color: color, colorFeature: colorFeature, id: index))
                        index += 1
                    }
                }
            }
        }
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card){
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id})
        {
            cards[chosenIndex].isSelected = false
        }
    } 
}
