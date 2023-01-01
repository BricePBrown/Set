//
//  Card.swift
//  Set
//
//  Created by Brice Brown on 12/30/22.
//
// MODEL for Cards

import Foundation

enum Opacity: CGFloat, CaseIterable{
    case light = 0.0
    case medium = 0.5
    case dark = 1.0
}

enum SetShapes: CaseIterable {
    case diamond
    case oval
    case rectangle
}

enum SetColors: CaseIterable {
    case a,b,c
}

enum SetMatches: CaseIterable{
    case correct, incorrect, unmatched
}

struct Card: Identifiable {
    // each card has 4 unique features:
    let shape: SetShapes
    var numOfShapes: Int
    let color: SetColors
    let colorFeature: Opacity
    
    let id: Int
    
    // states of the card
    var isSelected: Bool = false
    var isMatched: SetMatches = .unmatched
}
