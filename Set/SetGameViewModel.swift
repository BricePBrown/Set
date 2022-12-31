//
//  SetGameViewModel.swift
//  Set
//
//  Created by Brice Brown on 12/30/22.
//
// View Model for SetGame

import SwiftUI

class SetGameViewModel: ObservableObject {
    
    private static func createSetGame() -> SetGame{
        SetGame()
    }
    
    @Published private var model = createSetGame()
    
    var cards: [Card]{
        return model.cards
    }
    
    // MARK: - Intents(s)
    
    func choose(_ card: Card){
        model.choose(card)
    }
}

