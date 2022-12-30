//
//  Card.swift
//  Set
//
//  Created by Brice Brown on 12/30/22.
//
// MODEL for Cards

import Foundation

enum Opacity: CGFloat, CaseIterable{
    case light = 0.4
    case medium = 0.6
    case dark = 0.8
}

enum SetShapes: CaseIterable {
    case diamond
    case oval
    case rectangle
}

enum SetColors: CaseIterable {
    case a,b,c
}

struct Card: Identifiable {
    // each card has 4 unique features:
    let shape: SetShapes
    let numOfShapes: Int
    let color: SetColors
    let colorFeature: Opacity
    
    let id: Int
    
    // states of the card
    var isSelected: Bool = true
    var isMatched: Bool = false 
}
